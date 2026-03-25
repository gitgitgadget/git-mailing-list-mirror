Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9073D6483
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442983; cv=none; b=s2P9mdVZJJR6fxh0xk/S7gnRRzvk0vudxVrVbf3UTV59HahxuUXT2Ov/aJm8BNwq2UsqPRty4MPihcNzZJIsQIAmOHn//NLeu9naJtu7W6fe1+4nybM/68n4mgTPSqZR6H+W+m2XJDxyEMOvbJxGJ8EaqQTj/GhlEuAHkRmtnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442983; c=relaxed/simple;
	bh=6Z+vSdgIr2m3IkPkLPyCcWeVjHDz0GP2Tb1YsUK6XJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vl5rD55Rz8KikiC71HYGvaKr9u69tjP9EZaH00knQPSiUkaETY7qnLBpf53N2dP7vgDoMrSrPu9NPVsiHP5CiJS1IYc29zokvEBhe9A883eqSmg3XvH+GcQAUNDTe8kk6vy6XdPzrhRRt0V9eCIPo7nEcgNJqt+gSJ8Uo4GW1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=BO3D4oad; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="BO3D4oad"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774442979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hNm+3KJxl8vtfuiINDZN5P5+NpyyXlG8zxfWnb/s2nE=;
	b=BO3D4oadgZUlvEWSWj+IS/x2NjAzq85gpSo11L78RWD0eu5Ef0CCO/fzTlDuHCuIlehAN/
	lacZ0jomISYlO2B6zTeW3uSBEtHhcaTfL+8P36px9pYoki3u2rLa3ozJVp/3JACv7+rkN2
	0r72OhQ9NPiDi1kTIfk5lw/y3Il5Two=
From: Toon Claes <toon@iotcl.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Siddharth Asthana
 <siddharthasthana31@gmail.com>, Yee Cheng Chin <yeecheng.chin@gmail.com>
Subject: Re: [PATCH 3/3] replay: allow to specify a ref with option --ref
In-Reply-To: <63a66d11-d138-4d4e-ab5c-f7669c218293@app.fastmail.com>
References: <20260323-toon-replay-arbitrary-ref-v1-0-5c7172f675ec@iotcl.com>
 <20260323-toon-replay-arbitrary-ref-v1-3-5c7172f675ec@iotcl.com>
 <63a66d11-d138-4d4e-ab5c-f7669c218293@app.fastmail.com>
Date: Wed, 25 Mar 2026 13:49:31 +0100
Message-ID: <87ikak13c4.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Mar 23, 2026, at 17:09, Toon Claes wrote:
>> To enable users to replay commits without having refs in
>> <revision-range> or as the value for --advance and --revert, start
>> accepting option --ref. When the user specifies a --ref, the refs from
>> the other option are ignored, and only the ref is acted on.
>
> s/option are/options are/

Thanks!

>> Signed-off-by: Toon Claes <toon@iotcl.com>
>> ---
>>[snip]
>> +To replay onto a specific commit while updating a different reference:
>> +
>> +------------
>> +$ git replay --onto 112233 --ref refs/heads/mybranch aabbcc..ddeeff
>> +------------
>
> This example could use the stuck form like in the two previous commits.
>
>     git replay --onto=112233 --ref=refs/heads/mybranch ...

Good point.

>> +
>> +This replays the range `aabbcc..ddeeff` onto commit `112233` and updates
>> +`refs/heads/mybranch` to point at the result. This is useful when you want
>> +to use bare commit IDs instead of branch names.
>> +
>>  NOTE: For reverting an entire merge request as a single commit (rather
>> than
>>[snip]

-- 
Cheers,
Toon
