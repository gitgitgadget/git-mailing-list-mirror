Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896DC4F88A
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883984; cv=none; b=F3vU2CPoFxha42rwhIwxM8JZXn0LWrfNDUrQZA3UOA7rzSPPzX46wMutdiBf7Sljc2FSKA7/Wf1pq9ZN+dkQ1oJ6ZlaUO11ISiJRW5mtsY1+1rK6dOrrdKHXuxkU8YAjw8Uvy19TlFde28EinpftFGkRMrFkvj8wWa+9KzDe0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883984; c=relaxed/simple;
	bh=PgyFqWUYiFT8FvFuR4TwGClu/fScLZv58+76tenS/3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP+EOdhWMZMPFS+avQaIvjZBpkQ1YEiynNajdt+oUq+YaPMGrC18FGT/wRDOyyKX4MhyipvWEZn6ITE90OS8tSfnIbeWGvXGT3JDf1BWC5wPoZ9DeTPc0hlB9Z4gWbx/TcKlrStjfFnIAbOyhGUjAYNGENqfBWumamurTT5Cuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=O2YDLQ/p; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="O2YDLQ/p"
Message-ID: <cf3f27f9-c3c5-465e-bd49-767a1acabf0d@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710883979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHkmpVdnxwii0GDUg5pumxB9cDYM8iOPdMIeMB/cqS8=;
	b=O2YDLQ/pr1cUjednSVglpAzQ1u+OngjyvcQ8KGbBphDpId7QbpXQulQEmqUVPowgM3p5tI
	XyxIykhai2PDBgAC0raicce+M/G6UZ/CBr3z8W+aAxARwBCGUFLBGt5RvFCkMc7FDgqQ7c
	+pbqh3MZMBW0Hrg05rh73tS8iHuyS7VwiN014LRWoFjAr3a/dhuFxj1lXU429K2YrICmxB
	ZVmXZkXP84vJXM1FZciQUDJZyLpG+89OLD5mdPufh6vTr8yn+tC9lZUlE2KI0oHxq0UAxf
	4uPTMLlkX4CHQNnwY1NuQb6/UWjvauiZ/Kd3brrzoOJux7gs48kNA3ksZjxmLw==
Date: Tue, 19 Mar 2024 22:32:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] config: learn the "hostname:" includeIf condition
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20240309181828.45496-1-ignacio@iencinas.com>
 <20240319183722.211300-1-ignacio@iencinas.com>
 <20240319183722.211300-3-ignacio@iencinas.com>
 <20240319210428.GC1159535@coredump.intra.peff.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <20240319210428.GC1159535@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 19/3/24 22:04, Jeff King wrote:
> On Tue, Mar 19, 2024 at 07:37:22PM +0100, Ignacio Encinas wrote:
> 
>> +`hostname`::
>> +	The data that follows the keyword `hostname:` is taken to be a
>> +	pattern with standard globbing wildcards. If the current
>> +	hostname (output of gethostname(2)) matches the
>> +	pattern, the include condition is met.
> 
> I was going to comment further here, but I see Eric already replied with
> everything I was going to say. ;)

Please see my reply there. Thanks for the suggestion and sorry again if 
I sounded rude!

> One small comment on the patch...
> 
>> +static int include_by_hostname(const char *cond, size_t cond_len)
>> +{
>> +	int ret;
>> +	char my_host[HOST_NAME_MAX + 1];
>> +	struct strbuf pattern = STRBUF_INIT;
>> +
>> +	if (xgethostname(my_host, sizeof(my_host)))
>> +		return 0;
>> +
>> +	strbuf_add(&pattern, cond, cond_len);
>> +	ret = !wildmatch(pattern.buf, my_host, 0);
>> +	strbuf_release(&pattern);
>> +	return ret;
>> +}
> 
> This is absolutely a nit, but I think using xmemdupz() like:
> 
>   char *pattern;
>   ...
> 
>   pattern = xmemdupz(cond, cond_len);
>   ...
>   free(pattern);
> 
> expresses the intent more directly (it's also a little more efficient,
> but that's probably not measurable).

Noted, thanks!
 
> -Peff
