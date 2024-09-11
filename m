Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799AE1A2C05
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069950; cv=none; b=Z6PvZBWh2PdIeFIX0I9oTi7szOEAt57mJ4PQW1jQq9smElkIs12Ui4AWwOz3/Eou96LpQaxk6pugPeTDob4CgEyxkJDFTQfKwpB7NjGIIuqraMKYnHnKY5wGydvLOka4kNHxStX36OwSfPThwhbLysKet5zWU1r6nG3U7GCFl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069950; c=relaxed/simple;
	bh=sDXC5eSTnFObc8FsmgD+PJFMPF5dzmP1z3rzxN0VIK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L4N8P9lBMaxO8yo3E1dzDYwKeyFQJ3uLH/pwe8Z9l7dHaE+fds03RATD8J6rOahZfsVuJMuPq5wOee8Ke+rc5r5ckuWIqlFHT4faTFPhRGTfte/p7u1pTtTvaDFCiVdxIn7kFsCeMDw4bKWL2KqBJiW09tu1h7KwGuJm7MyZ8gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wCxNEUla; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wCxNEUla"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2617E19FD7;
	Wed, 11 Sep 2024 11:52:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sDXC5eSTnFObc8FsmgD+PJFMPF5dzmP1z3rzxN
	0VIK8=; b=wCxNEUlaN7717rjQrh4H4sfs8MZabYsuJT7V9bdSnjugH7hX5U+L2A
	neWPftAtaOmIp/UmXSoe0yiJWQv+BxvtXDTTKm88wJ3i/lFmsEmWUyvCMVUAQZSQ
	EpXcZG7JvWLOUfJlKAvpS5xoxQRLPJlMSvEr2X5h5l3YHmdXy1Ht0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C15719FD6;
	Wed, 11 Sep 2024 11:52:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7F8A219FD5;
	Wed, 11 Sep 2024 11:52:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>,  "Taylor Blau" <me@ttaylorr.com>,  "Patrick
 Steinhardt" <ps@pks.im>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  "Johannes
 Schindelin" <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 1/2] fetch: set-head with --set-head option
In-Reply-To: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com> (Bence Ferdinandy's
	message of "Wed, 11 Sep 2024 14:13:05 +0200")
References: <20240910203835.2288291-1-bence@ferdinandy.com>
	<20240910203835.2288291-2-bence@ferdinandy.com>
	<xmqqseu7cfsl.fsf@gitster.g>
	<D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
Date: Wed, 11 Sep 2024 08:52:19 -0700
Message-ID: <xmqq1q1qb32k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D4237EE6-7055-11EF-A35F-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

>> Ideally, because every "git fetch" you do will automatically learn
>> what their HEAD of the day points at, even without "--set-head", it
>> may be nice to let the user know when their HEAD changed, so that
>> the user can inspect the situation and decide.
>
> That would actually make sense, we could print a message saying HEAD has
> changed and I guess helpfully print the exact set-head command they would need
> to manually update should they wish to do so.

We need to be careful if we were to do this, though.  A user may see
that their HEAD points at their 'main' branch, and they know the
remote-tracking HEAD points at 'next' branch.  But the only thing
the latter tells us is that 'next' is, as far as this user is
concerned, the primary branch they are interested in from this
remote.  It may have been set earlier with "git remtoe set-head"
explicitly, or it may have been set back when "git clone" created
this repository and back then the remote had 'next' marked as its
primary branch.  In other words, the HEAD we learned from remote
while we are fetching from it may or may not be the same from the
remote-tracking HEAD we have, but it does not mean that the remote
recently flipped its HEAD if these two are different, but what we
want to report is "their HEAD used to point at 'master' but now it
is pointing at 'main'".

> So there will be no
> extra flag for fetch, rather:
>
> - if the remote HEAD does not exist, we create it
>
> - if it does exist, but has changed we print a message saying it was changed from X to Y and print the required command to update to this
>
> - no configuration needed

Very good, with two reservations.

 - if the remote HEAD does not exist, we may still not want to
   create it.  Imagine

	[remote "his"]
		url = https://git.kernel.org/pub/scm/git/git
		push = refs/heads/maint
		push = refs/heads/master
		push = refs/heads/next
		push = +refs/heads/seen

   without any refspec for the fetching side.  "git fetch his master"
   may learn where the remote HEAD is, and it may even be pointing
   at their 'master' branch, but because we do not maintain any
   remote tracking information for their 'master' (in other words,
   refs/remotes/his/master is not updated by this 'fetch' and there
   is no configuration to make future 'fetch' to do so).

 - it would be very nice to report when we notice that they changed
   their HEAD, but I do not think we have enough information to do
   so.  Our existing refs/remotes/origin/HEAD may not have been set
   to match their HEAD in the first place.

Thanks.
