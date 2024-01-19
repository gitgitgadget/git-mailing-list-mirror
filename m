Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7666FB1
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645668; cv=none; b=q9scfTV4depCQVKK460ws5P4fMhjPSgQRAHrLH+EojeGOrxlE7vLlHeomBGQvaHWfrOZ0uW5ugWLbEeNPE2XRNP336kPWFy87u/Iylv4ACYk/F7LbYbVwdnuPlK4fA5KCS0ixqiozpZpDtRteNeXouQOYfX6QLoClVOI7Zvb/mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645668; c=relaxed/simple;
	bh=3ORjt89kNkfvLCd0Ou5uKLwCl4Jxo+5cMV6pAy03gEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5SwnC1AthBQ0NW+5RlzwJnQMhjOCHp8Lxxlx1zUD1mOmPAJxsHF5kL2mU884i5Flc938tOuvkaTICROeMoHSuHkRGPInhimilDgQbYUlGcP82HbFUHyIvMv9UbYpIBDVE3iCbihYvxJzYVxkl/GLA6etCDHNZb1y/AcZ9iuacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DbtAU3Fl; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DbtAU3Fl"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EDF01D0834;
	Fri, 19 Jan 2024 01:27:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3ORjt89kNkfvLCd0Ou5uKLwCl4Jxo+5cMV6pAy
	03gEc=; b=DbtAU3FlKM31uLjO0G8kJ2UZZnPW2bDmD1mzDl0frnvCC+SLCFpM3q
	+UPdC8386UJx4pBoy69ViQyuDJJdNQOk4149XzvE2BgWHmqThHG2iUjBeO3g4pAu
	OY9k1Db8BnFmU/ikVfdryyMm+j3b12T+/RVvw3MlsDUf3yA1tRDEY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4780F1D0833;
	Fri, 19 Jan 2024 01:27:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A99B61D0832;
	Fri, 19 Jan 2024 01:27:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] diffcore-delta: avoid ignoring final 'line' of file
In-Reply-To: <CABPp-BHybPEg_+649fL6QrKjRQcJXxbYMFiQn0KxAgbr2Nz0Gg@mail.gmail.com>
	(Elijah Newren's message of "Thu, 18 Jan 2024 21:05:47 -0800")
References: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>
	<xmqqedenearc.fsf@gitster.g>
	<CABPp-BGp0NMQKLYg=OxJgnVxARffNF57B_N2bLmwT2R2EZqhdA@mail.gmail.com>
	<xmqqil3x69dk.fsf@gitster.g>
	<CABPp-BEaYkAPphh06R1HrfD03WTv5uy-2q-T0ZMZaxo9hfXv-g@mail.gmail.com>
	<xmqqjzo6m37n.fsf@gitster.g>
	<CABPp-BHybPEg_+649fL6QrKjRQcJXxbYMFiQn0KxAgbr2Nz0Gg@mail.gmail.com>
Date: Thu, 18 Jan 2024 22:27:43 -0800
Message-ID: <xmqqbk9hn8gw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DB15096C-B693-11EE-8716-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Elijah Newren <newren@gmail.com> writes:

> But perhaps I can put it another way:  You can't just look at the
> output of `diff --name-only` and say a rename was involved -- unless
> you know the test setup and the previous operations.

That is true.  But that is exactly what a test is about.  You have
this and that file, and you do this operation, now what should
happen?  Does the observation match the expectation?  That is what
our tests are done.

And your argument should not have to rely on a bug in "git mv".
After all, you should be able to do the same with "mv A B && git add
B && git add -u" (or "git rm -f A") and you won't be affected by
such a bug.

> If you still like `diff --name-only` better anyway, that's fine and
> I'll switch it.  I'm just stating why it seems suboptimal to me.

I'd prefer to omit "sed" involved, but I'd even more prefer not
waste more time on the test.  As long as we can make a robust test
(which an extra process running sed would certainly give us), I'd be
fine.

Thanks.
