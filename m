Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844318D63D
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959679; cv=none; b=Z42JN3RM1j4EdO05RJjWcPy7JTK4MvasgjtVkxN1O5E2GLlAvlTTjv6NIJ9CoN6XiMOkUr2NL+Con8NFnzK25u2rHb38XFzcGH0D5PcDKiVvHQsdiE63vX5cw9cUA2fVSl/JY4QWEbI8Vs8iMO5bP1yoXSAHrHs13YGD7tRG8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959679; c=relaxed/simple;
	bh=Eava742OYgO1GfJch6OOq8jmPmq0oBINWvM8vSBZ/e0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XsO0P3TK1QIyHRlnNf2N3fKDjOp43627c/GZ1vGKLKHJ0L4YSv8+mH+EJ3EYU2kuhOnuEYwvClnl81IBqtpFO+XwAuI4z7urDLx6f++krkDqRuixNB2BEcvbEDXieFM57e10t1sqJgkDYWTLc3vZwkTQsAo6Mu54QyTbNd9Z8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xU4aaXRV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xU4aaXRV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AB2B92E8BC;
	Tue,  6 Aug 2024 11:54:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Eava742OYgO1GfJch6OOq8jmPmq0oBINWvM8vS
	BZ/e0=; b=xU4aaXRVpmyQ28tr9yZfb51WmD1z4QVHE14hZHmJpr2jdsnF8Iz2LI
	FDC/SKOMrj4H8ffgMDr2VWeuxozBt5ns+shBqmuQ3/IV/XIt8xMeesgemJrdcqNH
	U133iXOi8fsGuCe6daai7n4fdvyCx0PDQyUofjBF6L7GGtN5G2lyE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A35E12E8BB;
	Tue,  6 Aug 2024 11:54:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1335F2E8BA;
	Tue,  6 Aug 2024 11:54:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 09/11] builtin/fsck: add `git-refs verify`
 child process
In-Reply-To: <ZrG89e6IVMEuq0IK@tanuki> (Patrick Steinhardt's message of "Tue,
	6 Aug 2024 08:04:37 +0200")
References: <ZqulmWVBaeyP4blf@ArchLinux> <ZqumdJz3-0mqh6Rc@ArchLinux>
	<ZrDMdEJR6DV5HyLD@tanuki> <ZrDtVJYoJJZDesB4@ArchLinux>
	<xmqq4j7y3kmt.fsf@gitster.g> <ZrEbllB6WjLfWqNZ@ArchLinux>
	<xmqqsevi220s.fsf@gitster.g> <ZrFxb1FNRCzu-NuW@ArchLinux>
	<ZrG89e6IVMEuq0IK@tanuki>
Date: Tue, 06 Aug 2024 08:54:34 -0700
Message-ID: <xmqq7cctzlxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E11031C-540C-11EF-B639-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> > But if "git refs verify" does exercise all the new code paths (and
>> > the refactored code that existed before this series, sitting now in
>> > different places), then I do not have to worry about it.  My question
>> > was primarily to extract "even though we do not wire this up to fsck,
>> > we already have another code paths that uses all these changes" out
>> > of you.
>> ...
> So, to summarize: the refactored functionality is both used and tested
> and I think it's sensible to defer the integration of git-fsck(1) and
> git-refs(1).

After refactoring, existing functionality about objects are used, of
course, (there is no other code that does so), the refactoring lets
the code to learn to perform checks on references, and these new
checks are exercised by "git refs verify".

I took what shejialuo said that way, and that is fine by me when I
said the above ;-).  So I think we all are on the same page?

Thanks.




