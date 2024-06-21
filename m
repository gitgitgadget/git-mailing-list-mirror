Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC1156227
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987670; cv=none; b=J/EzJ1FkpGkSSjYtygXwCTTjI1nV25OhmwThxtEhExR724NxzhLWR0Tc/u6uWv2fben2JOdXlgbqvYj0kP7olNj7ZNzhGmLmdFy265HC4rUHT/fg2/om6MH+iDKXGBufN1+/kZxERpyxaKJUATiy8v5v6zt+09viqgcGgYeLcnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987670; c=relaxed/simple;
	bh=Wt2nEkaLdFDu/Pxpdy+L+lT3+2E+OdqsnS2zhv3zGbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JlLyvMFVRn2+R2URKx+d6o09Xqm3Q1ZapY1FtyH/F15zQTS23Iv5PxbudJWuVIoDxLBM1vVcvLJA2oLzci60R0ZKMoziQcDElFe9s6OvJTr6GfrPcGwzuGOySqQQ4Di0ZBu1nAfSKxHGL2hzDO9YMeGqUy/zh7T1auj3BKhRUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CWm8rMPu; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CWm8rMPu"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A0C736FBA;
	Fri, 21 Jun 2024 12:34:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Wt2nEkaLdFDu/Pxpdy+L+lT3+2E+OdqsnS2zhv
	3zGbg=; b=CWm8rMPuAg8tvHAy1cLIAxVuAhiehmu88zMbfFMyVxxu/QAPa+WYVF
	iKvB9J0pEBab5B3tPIzWH2seEwYZhSybdSFAdYzT66IV+9+uA/qqcoibQjWTWv2Z
	Mtlgc3pwdLqL5wTHKVnjn4RspBZv+oL0uzp808VxHCgCBL7ohyCaU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 32AA236FB9;
	Fri, 21 Jun 2024 12:34:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 55D9A36FB8;
	Fri, 21 Jun 2024 12:34:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Stefan Haller <lists@haller-berlin.de>,  Git <git@vger.kernel.org>
Subject: Re: Thoughts about the -m option of cherry-pick and revert
In-Reply-To: <6e71b1f3-599f-49c3-be37-e499f28983cf@gmail.com> (Phillip Wood's
	message of "Fri, 21 Jun 2024 11:19:31 +0100")
References: <e60a8b1a-98c8-4ac7-b966-ff9635bb781d@haller-berlin.de>
	<xmqqa5jfoxvh.fsf@gitster.g>
	<dd58a60d-a551-4726-85a7-f47b851914be@haller-berlin.de>
	<6e71b1f3-599f-49c3-be37-e499f28983cf@gmail.com>
Date: Fri, 21 Jun 2024 09:34:22 -0700
Message-ID: <xmqqv822ntkh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E957132-2FEC-11EF-87F5-C38742FD603B-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I can see why people want to revert merges but cherry-picking them
> always feels strange to me - what is the advantage over actually
> merging the branch and seeing the full history of that commit?

One case that comes to my mind is when you failed to plan ahead and
used a wrong base when building a series to "fix" an old bug.  You
built a 7-patch series to fix a bug that you introduced in release
1.0, but instead of basing the fix on maint-1.0 maintenance track,
you forked from the tip of master that is preparing for your next
feature release that is release 1.4.

Even if you realized that the fix is important enough to warrant
applying to the maint-1.0 maintenance track, you cannot merge the
topic that houses 7-patch series down to the old maintenance track
without bringing all the new features that happened since 1.0 on the
master track.

A kosher way may be to rebase the 7-patch series to maint-1.0 and
merge the result into the maint-1.0 track (and upwards if needed).
But cherry-picking the commit that merged the original "fix" topic
into master _may_ be simpler, as you need to resolve a larger
conflict but (hopefully) only once, instead of up to 7 times, once
per each commit on the "fix" topic while rebasing.

But of course if something goes wrong, it makes the result
impossible to bisect---exactly the same reason why you should think
twice before doing a "merge --squash".  In addition, if you somehow
figured out why the cherry-picked fix was inadequate, you'd now need
to forward-port the fix for the fix to the master track or whereever
the cherry-picked-merge was taken from.

On the other hand, if the original "fix" branch was rebased on
maint-1.0 and then further fixed, the result can be merged to
maint-1.0 as well as all the way to the master track.

So, I can understand why people may want to cherry-pick a merge,
I suspect it is a false economy.  Optimizing for picking, paying
higher price when the result of (incorrect) picking has to be
corrected later.
