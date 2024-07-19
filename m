Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2178828F1
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402000; cv=none; b=grlgJtlFAPRKYrOR3ApjpRELRcLf9ih4lUkfjmNsXkhmpMDKBIFQDlDhLBc5NnDn2cCJ2blCBwrHGCP4BQQc+crtIzxa9c1w7vByD5Y7aRFHbRu+t1bXNAgti53/tNSmO7DrUad2AqjBDjqkC/L8o95smN69uFEs66e/A/iK7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402000; c=relaxed/simple;
	bh=pOruliguOwuO62GefssPpuz4zi7w7VI0z+ndICsTFns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BFACumPU61iNXZ/IC1Hck2KtLryoJSgsIjUz9xMSvhr74/X9+EJX3mCjc8EpLwCNC5KCQ/rVRwcUDmYwlrJIUfpPAmt6AihIgtdVr2WJeYhW//iqjQjgoNb/RpAFq10bMYHoPk0eZmPX8ku1A1j90oKV8ni3NpxX+QqYUPxYe50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hal4vu5c; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hal4vu5c"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA5BD3711E;
	Fri, 19 Jul 2024 11:13:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pOruliguOwuO62GefssPpuz4zi7w7VI0z+ndIC
	sTFns=; b=Hal4vu5cEU+4iJdbv3JAs5EyaL6CbC+cmWryzi7THGHgJqqyD2efEz
	CdC6hWG/F9+rRjpm8In3XM9OFWJx9BVx/0NhBloDRXyJ0fGr4EAWzQ/Pz/9HZKf9
	w3zAd2HJ+u7TmxFEpJvQciw+6J8YrwQms62vlFA7Q0HmjC2dLSsiw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E28623711D;
	Fri, 19 Jul 2024 11:13:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B0E23711A;
	Fri, 19 Jul 2024 11:13:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/2] Fix background maintenance regression in Git 2.45.0
In-Reply-To: <81c7bd02-0c2d-452f-800e-ca0d3853a941@gmail.com> (Derrick
	Stolee's message of "Fri, 19 Jul 2024 09:24:55 -0400")
References: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
	<xmqqle1ynz18.fsf@gitster.g>
	<81c7bd02-0c2d-452f-800e-ca0d3853a941@gmail.com>
Date: Fri, 19 Jul 2024 08:13:16 -0700
Message-ID: <xmqq34o5l8j7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6D343F52-45E1-11EF-9742-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> On 7/18/24 5:57 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> Here is an issue I noticed while exploring issues with my local copy of a
>>> large monorepo. I was intending to show some engineers how nice the objects
>>> were maintained by background maintenance, but saw hundreds of small
>>> pack-files that were up to two months old. This time matched when I upgraded
>>> to the microsoft/git fork that included the 2.45.0 release of Git.
>> I almost said "wow, perfect timing on the -rc1 day", but then
>> realized that this is not a regression during _this_ cycle, but a
>> cycle ago.
>
> I almost waited until after the release, but I wanted to put the
> information out there just in case you were interested in taking it
> into 2.46.0 or were planning on a 2.45.3.

Yup, thanks but this is not exactly a repository breaking data
corruption bug, and did not look ultra urgent.  Especially if we
want to pursue a solution that helps both expiring stale packs
better (which is what you are restoring) and making better delta
chain selection (which may be what you are losing) at the same time,
such a change could become a source of data corruption bug, so I'd
prefer to see it started early in a cycle, rather as a last-minute
"let's fix this too".

Thanks.
