Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACDA214A8B
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409629; cv=none; b=KzeM0E4bWsLZJi6iTGIEo7xtAVvuIv34UCpRyLQ24N6135wBw0EUvn4lS2wMRC7XSBDLTY7ieTYezyWBlnk9zcnrPzFHvxVvip2qSeppxoQBhe+gOc/jkG/YfRbxgQ3TccJQbtEa8LxXFEe14eKmsiA7KONTyOJVcxwaMkiKVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409629; c=relaxed/simple;
	bh=otgDluj7+fWdOPHNM0xvH0GsGIN+GzKWDKpiZuTPqUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JzFsOHZbKfoKy8RFpSdE0P8/0LqSuGQIsD/7GDRAB/K5VsUCegzKe5tvMwSKzLOKAOaQsPKt+2bbcL/zjCE//gzbS0+rPNCx+3SADFlI3jgK9nhBLdy3UbZmeqwvhzU9yEll6hkIzlHO797ea6GgAYwlID2KnIHdkfq6NonTdZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=yTsBWNph; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="yTsBWNph"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1736409618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U3RiUIRzcMPn2kEMAbOK9a4h880cW+XhOic7dAjTmYQ=;
	b=yTsBWNphapjx8GHd9N3tcPe1DQcLLba5to9fS3tk3v+pJRUCkiY5yare0SjGo4knaaPpqU
	NS31yCZP3NWVxCadlb7KWH7maqiUX+5kZYhNwTDGpTIvw2OEX7lLQYy7EsomXSG1dVzie0
	bqjxtbs4tcjkFXWxRrt6LYhxHGmEWCg=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] fsck: reject misconfigured fsck.skipList
In-Reply-To: <xmqqttaatu8h.fsf@gitster.g>
References: <20250107162914.3756968-2-jltobler@gmail.com>
 <xmqqttaatu8h.fsf@gitster.g>
Date: Thu, 09 Jan 2025 09:00:04 +0100
Message-ID: <87jzb4ju2j.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

>
> If the value is missing, i.e.,
>
> 	[fsck]
> 		skipList
>
> it is a very clear misconfiguration.  "We expect a path, but you
> gave me a valueless true".  Once a specified value gets to
> oidset_parse_file(), we would die when a specified path cannot be
> opened, so it is not like we want to deliberately tolerate
> misconfiguration (we also die if the value is given as "~t/sl" and
> user "t" does not exist on the system).
>
> Makes sense.

Yeah, I did some testing as well and reviewed the code. Also makes sense
to me.

--
Toon
