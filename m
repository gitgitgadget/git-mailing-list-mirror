Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9071BC49
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772082; cv=none; b=gP0Sr3vh0rkiA1uTk2JKsFNxdUqNfjR/P6Fu5X0cytPn4H/UvK6et0Un0biRSCmhoRIHM1AJ+u5jqiPYx4tPigD2mNid7A2pqw4wfB4kgC4eAvYcQ4ICrBRfaX00kYncRBoLBqYHQTmc2emaWgP7op+nNwqtCAAUeIg3sFDNuME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772082; c=relaxed/simple;
	bh=xVR2WH80YvoB3UXeJzoQRUA68keBgR4Czsz1cm1MBiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q6PFai1OnQtcrpS/zWUFzvQ4b5FG1Xe/PMJb2XqV33LzIc99Mc9/WtG3jOgI3RNZ1A2CXrlllQ4MbraraiV3OKi7+V4qnOlSlmEZyBFsR/RbnfAPHXUVGgWJQxSDvz4eqyEsT9A+Myrsd0w5QaoLB7bWjenvk6d1tyIwIUpS/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nKJ7VIIP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nKJ7VIIP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C2C92A500;
	Thu, 19 Sep 2024 14:54:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xVR2WH80YvoB3UXeJzoQRUA68keBgR4Czsz1cm
	1MBiw=; b=nKJ7VIIPg/rckGvRUETpCyezfU6wEzGnRDlyH9YyE6s7d1opmcks1b
	39KcCctf0ZbxGQ9LdivHGbr3nAUFuHbU0FKr7XRAaVjh+3j7zdzwJri6vcCz7MwO
	t2BUaNNVzYbAPIE1n4t8307+Gt6uPmPbfc5MpFVGZjiCjCVa1wy80=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 14B242A4FF;
	Thu, 19 Sep 2024 14:54:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BDED2A4FD;
	Thu, 19 Sep 2024 14:54:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/23] Memory leak fixes (pt.7)
In-Reply-To: <cover.1726484308.git.ps@pks.im> (Patrick Steinhardt's message of
	"Mon, 16 Sep 2024 13:45:21 +0200")
References: <cover.1726484308.git.ps@pks.im>
Date: Thu, 19 Sep 2024 11:54:38 -0700
Message-ID: <xmqqwmj779u9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9F9592B8-76B8-11EF-B551-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The patch series is built on top of ed155187b4 (Sync with Git 2.46.1,
> 2024-09-13) with ps/leakfixes-part-6 at 46f6ca2a68 (builtin/repack: fix
> leaking keep-pack list, 2024-09-05) merged into it.

I haven't said this, but I really appreciate contributors (like you)
pacing their series submission perfectly with the rate of related
topics in flight solidifying.  If people hold off sending new and
dependent topics for too long, that would waste available review and
testing bandwidth, but if people send them while the other topics
that they depend on are not yet in a good shape, it would require
conflict resolutions that may get wasted when the depended topics
have to be updated.

I've been trying to be more explicit in the "What's cooking" report
what my evaluation of each topic's "doneness" is, to help contributors
who need to send new topics that may conflict with the topics that
are already cooking, and I hope it helped in your (and other
contributors') pacing their submissions to help the process run more
smoothly.

THanks.
