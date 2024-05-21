Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B9835894
	for <git@vger.kernel.org>; Tue, 21 May 2024 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716329600; cv=none; b=AOtoPWdPt3kCWEocL3His4jLjICaghHSHEfqRCJNFzBCd68aH1FOFwYha5rpkG0W1rEXbjqpKwtI3/H5d4I8RCwXm1sw4aaUOs7Rw3Q1banPJOV6CNraRf0DfOWYjbFRLaSAJipYVXWxGhap/oss38c8NnDNN2ZlHRM/hXxuwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716329600; c=relaxed/simple;
	bh=WQIz5XjXAcsN82P2Lny9T2M2QIUcBu5pSeTf5mUXZa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k9piW9QnG/uXf5sHQcZhIvR0iR8uHbB/s/iPO+6Xga1xbmwbs9D1fx09/X/sz+RyoQZsHP/hhQEFge2PEza+FEuQu7l3E+EAJakI7yiu53HXRLrEtpSYYPPkyvkiNp/uoNKtuBAhC4K+zysIU9xiHkIcoMN2VN5nX6ohDiNM8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UsT8ryt/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UsT8ryt/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD59631EFB;
	Tue, 21 May 2024 18:13:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WQIz5XjXAcsN82P2Lny9T2M2QIUcBu5pSeTf5m
	UXZa4=; b=UsT8ryt/rbGa08MnKjoHOvHB2+cBbmxxzLYJxh91zf87eNtbJj4DlL
	pMEdP6KLpEQIE5knjlAgn3V9RzqDyoTPKkKDUYqyZvZ1vy/z+GtyVur8FuHmXv9R
	4Asqoc8VSrjAogrqGoJqKDr+hEiOkH+acOSbfjq4uiy88AHdnaL8E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4C3831EF9;
	Tue, 21 May 2024 18:13:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1910431EF8;
	Tue, 21 May 2024 18:13:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/12] Fix various overly aggressive protections in
 2.45.1 and friends
In-Reply-To: <xmqqmsoi96tf.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	21 May 2024 14:46:36 -0700")
References: <20240521195659.870714-1-gitster@pobox.com>
	<937e89c6-6161-42ba-670d-8f20ff90a7d0@gmx.de>
	<xmqqmsoi96tf.fsf@gitster.g>
Date: Tue, 21 May 2024 15:13:15 -0700
Message-ID: <xmqqed9u95l0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 530B2528-17BF-11EF-993C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Tue, 21 May 2024, Junio C Hamano wrote:
>>
>>> I'll figure out a way to convey conflict resolutions as this topic
>>> gets merged up to newer maintenance tracks on the list so that
>>> people can assist with ensuring correctness of the result by
>>> reviewing, and follow up. ("git show --remerge-diff" might turn out
>>> to be such a way, but I do not know yet).
>>
>> I pushed 12/12 to https://github.com/dscho/git's
>> `various-fixes-for-v2.45.1-and-friends` branch, and updated the
>> `tentative/maint-*` branches accordingly:
>
> Thanks, but I suspect it is not productive use of your time to merge
> these up until we know we are happy with what we are merging up.
>
> Even though I did the 12/12 that reverts the "iffy ownership check
> during repository discovery", it is far from clear without
> discussion if that is a reasonable thing to do or use of
> safe.directory by narrow non-target audience (like k.org that may
> use gitolite and/or bare git for hosting) that lets nobody access
> trusted user repositories.  Every time we find new issues or
> different solutions, somebody has to merge it up, eventually to
> maint-2.45, but I am afraid it may be a bit too early to commit.

Another thing is that, now this is not an embargoed set of secret
releases, I'd want to have them go through 'next' down to 'master'
in the usual way, with the usual "develop in the open" fashion,
before we convince ourselves that the whole cascade is ready.  We
may find necessary updates while these fixes are in 'next' due to
$WORK folks feeding 'next' based updates to $CORP users and helping
us find issues, in which case we would need to add more patches on
top of the topic based on maint-2.39 (and merge it up all the way).
After that is all done, we would finally become ready to write
release notes for the tracks, which will be merged up the same way
as the "oops, we found we need another patch while the series was in
'next'" case.  Preparing tentative/maint-* set of branches your way,
with release notes and GIT-VERSION-GEN updates together ready to be
tagged, would not help prepare something that I can feed other
developers in 'seen' and then 'next'.

Thanks.
