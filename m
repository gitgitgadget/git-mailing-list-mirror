Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215EF16FF2A
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797130; cv=none; b=qdI5hsNXrMWtGmSQFtDLiMcVklrxoC16pPvXHXftcKM2Uq8VBXhDJBOHadVFrIJA6irXqcKf7zL+8m5Q5FD0PDi8xIwXLFMP+X65hr2Fla/G6mflMz+fWlogg4BKT9i9maigkzJySeOCsFM1AAMd+m1zK4TQjwX2oFl45bPMHNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797130; c=relaxed/simple;
	bh=Tv+mY/sAUzyGWquaCNEaXNHFSeQddeNp0V7ZKWEbfpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m5P5a9JLLTGZRzj0NZv5i09nWKBtcFmAraD5TWHAonNqOg6Xt9GwpHVRvNojjCtwXWkihsG9id/Oo7exmfYTeWHbmN/CdpZtzLS/icqt7x9558zGrF8VD0Q1Gk/zixXKTWPYdNBKeSQwiWWGuK2pqTBXQAhewhL12s8pew5g/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WosP6drq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WosP6drq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 493A41F924;
	Fri, 12 Jul 2024 11:12:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Tv+mY/sAUzyGWquaCNEaXNHFSeQddeNp0V7ZKW
	EbfpE=; b=WosP6drqxmQimVMKIWDoxek6CescQycmc6ddJ7wr78BnRGK95RyoAR
	3nAiQxfJKdozV9jt22zgldwrcJXNnZL/+jyfIICvo18s5/jD8imXjREeJV5B5e5D
	LM1EoM9nI3Dj0EWCv70wwm8EgM5uTM4yvJBxVXOPdAPdydBRRNV/8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 40DE71F923;
	Fri, 12 Jul 2024 11:12:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 596EB1F920;
	Fri, 12 Jul 2024 11:12:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>,  chriscool@tuxfamily.org,
  git@vger.kernel.org
Subject: Re: [PATCH v2 8/8] check-whitespace: detect if no base_commit is
 provided
In-Reply-To: <CAOLa=ZSR=mMMnYNrpKc9ivOx4vbzJF7c5e3632NpX4XYFdLMmg@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 12 Jul 2024 04:51:22 -0400")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240711083043.1732288-1-karthik.188@gmail.com>
	<20240711083043.1732288-9-karthik.188@gmail.com>
	<zq2x3k5gshs5jgx6zglfdzu4kx6vrrzugfvd4w4pjfh6uyjc4r@4x2zt2ftfmsq>
	<xmqqikxbsy4d.fsf@gitster.g>
	<CAOLa=ZSR=mMMnYNrpKc9ivOx4vbzJF7c5e3632NpX4XYFdLMmg@mail.gmail.com>
Date: Fri, 12 Jul 2024 08:12:05 -0700
Message-ID: <xmqq34oeprui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1A975D54-4061-11EF-AE3C-965B910A682E-77302942!pb-smtp2.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> Another thing that I find somewhat disturbing is that the
>> conditional seems the other way around.  It shouldn't be saying "If
>> B is not available, use A, otherwise use B", as if A is known to be
>> usable always.  It should be more like ...
>> shouldn't it?
>>
>
> Agreed, that a comment would be nice here. Will add if I reroll!
>
> In this case A ("$CI_MERGE_REQUEST_DIFF_BASE_SHA") is known to be usable
> always [1].
>
> [1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html

Ok, if so check the one you want to use, if exists, first, and then
fall back to what is supposed to exist always but is your second
choice, e.g.,

 	if test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
 	then
 		ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
 	elif 
 	then test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
 		ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
 	else
 		BUG CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!
 	fi

Thanks.
