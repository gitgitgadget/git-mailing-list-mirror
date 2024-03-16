Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3818D11737
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587993; cv=none; b=B1HH9Lv7LKVJ76aFOCHSpcm57AuNhUG5ERYZYRitFdvQsmJ2Tno0guMq+67N2ECjC+aBCCqIbxuAoS+SzXLbXRSGlN4nP3oC3Lemw1PQhbniYVsBF7+erM4y+XtVYr3fE8StRCcxZtdRDcs5bslM3kdRZ1M7u3bbisN5/SNGPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587993; c=relaxed/simple;
	bh=yzrdYS2OBYgSXD1H9/qhIVnLXyHVEVbM9gaRz+a1ceg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVLfMKRdZN8xMu5+rrTpk6+5UF/tKy7S11Nypj1sN2G+U/Kdy32iAV7fEZqJ3REhFZsxbT2Gk9VslVKjGYs4TyS689fiimur6XsvXVKAyC35fLZE0N1NTgGaNtDW+F98XTTqsp6rVFBZtGNK0g8zJUsjqM+CGm9lb50fRfz+JWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=qL0vNTfN; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="qL0vNTfN"
Message-ID: <857e512c-d6d8-4bad-9eb5-5ca233a1c884@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1710587988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdvntSMpupGvk1hxK45w0pdjoIidGtZ+LTpt0cmwiaM=;
	b=qL0vNTfNDaMrf5D7n3DRkaYMcw7aWb9jfeSLZYc0DYbBvLhvJokeOs4ne9owdcHJvR/C/X
	4Q24npxUTYr+RDU/zWOEtJvbnzIsSjQ5no81UWV6t2qC1b8fv5lN6kgtAt6D/rP/E1OMJe
	0Gk9rOns4Sw03qn8gmIYyAqZ2EV77dIAjJbb6i+8OQ5v3zOoYU1/Ua98orqFOrOmE/1PjV
	qI0V5VrPcuigEg/KtmW3RC7V3SmAlqKZko6t8f6Cw7eQ2VS4Ry3e2Gzi8tSIYWJgOu611C
	VTR4ME65SKKZug2uuTPize2M+VEs7yt4u7o5VuWpKqBh27f+W69jswck5+NPDg==
Date: Sat, 16 Mar 2024 12:19:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240309181828.45496-1-ignacio@iencinas.com>
 <20240309181828.45496-2-ignacio@iencinas.com>
 <20240316065737.GA544929@coredump.intra.peff.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <20240316065737.GA544929@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 16/3/24 7:57, Jeff King wrote:
> On Sat, Mar 09, 2024 at 07:18:28PM +0100, Ignacio Encinas wrote:
> 
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index e3a74dd1c19d..9a22fd260935 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -186,6 +186,11 @@ As for the naming of this keyword, it is for forwards compatibility with
>>  a naming scheme that supports more variable-based include conditions,
>>  but currently Git only supports the exact keyword described above.
>>  
>> +`hostname`::
>> +	The data that follows the keyword `hostname:` is taken to be a
>> +	pattern with standard globbing wildcards. If the current
>> +	hostname matches the pattern, the include condition is met.
> 
> Do we need to define "hostname" in more detail here? Specifically, I'm
> wondering whether the result will be a FQDN or not (i.e., the output of
> "hostname" vs "hostname -f"). Looking at the code I think it will just
> be the short name returned. That's probably OK, but it may be worth
> documenting.

Thanks for pointing it out. I agree that it should be further clarified. 

Indeed, I was referring to the short name reported by gethostname(2), 
which should agree with "hostname". What do you think about

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9a22fd260935..268a9fab7be0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -189,7 +189,8 @@ but currently Git only supports the exact keyword described above.
 `hostname`::
        The data that follows the keyword `hostname:` is taken to be a
        pattern with standard globbing wildcards. If the current
-       hostname matches the pattern, the include condition is met.
+       hostname (output of gethostname(2)) matches the
+       pattern, the include condition is met.
