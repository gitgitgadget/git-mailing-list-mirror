Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4A13AF8
	for <git@vger.kernel.org>; Sat, 27 Jan 2024 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706349611; cv=none; b=IEO+1H7oTFYsgZXq3dbsDg+Cd17m66b/+ODV14lgKKeJ6XiyqPooP2nHbQxDZSUeHD5pfqdd5mIyFs7E7SlBJbEbsACs9u7fnQMPCFqrNrdMEdvHt2H+0hmxnsfgHqrbwWcUvje6DRKXmao0URXlxE6CNM5HIoWODxaV8m95mVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706349611; c=relaxed/simple;
	bh=NiuJ/igQlDrf4uFsVRWQpaLr1nRIvWA8B+PhAoAV9Dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oRCrx64F6kCCT+a7KUK5GnH8GPE2+JJMnWKiSxk2SDuW/bGfgL3SEASAW6eyaGIJY8Um2E0TC6I8/eiom935PiqvjFCc2/2KiGvqQTSUmRNemn/aMa1/a7ihAQy63WnfpdEi68yEGUIL6jB5LFJw39gO+RLMDabLkFp1RxyZUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oKCHaYn2; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oKCHaYn2"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91A8B1CFA68;
	Sat, 27 Jan 2024 05:00:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NiuJ/igQlDrf4uFsVRWQpaLr1nRIvWA8B+PhAo
	AV9Dg=; b=oKCHaYn2Z3sIbwyZznD8AuWUcGRESrzZCca+X92+e0en8Ri3IweQb4
	Mks1H9oby+1hp0z5GJsdVwPIhdwwpD4scdsCqrN9FVIr2/9KgNhPgX6xzS9ykeb6
	K3jDx9tu9FCklqWFdtCLfF78hYlCeL1/LlSDT3020l3QcSsK4LATs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B4A41CFA63;
	Sat, 27 Jan 2024 05:00:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 024711CFA55;
	Sat, 27 Jan 2024 05:00:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sergey Organov <sorganov@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
In-Reply-To: <87ede4fg8s.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
	26 Jan 2024 15:09:39 +0300")
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
	<87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
	<87il3h72ym.fsf@osv.gnss.ru> <xmqq1qa5xq4n.fsf@gitster.g>
	<87ede56tva.fsf@osv.gnss.ru> <87a5ot6tos.fsf@osv.gnss.ru>
	<xmqqzfwspmh0.fsf@gitster.g> <87ede4fg8s.fsf@osv.gnss.ru>
Date: Sat, 27 Jan 2024 02:00:02 -0800
Message-ID: <xmqqzfwrjdul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D79D2B76-BCFA-11EE-873F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Sergey Organov <sorganov@gmail.com> writes:

> I'm still arguing in favor of fixing "-n", and I believe a fix is needed
> independently from decision about "-f -f".

Even though I do not personally like it, I do not think "which
between do-it (f) and do-not-do-it (n) do you want to use?" is
broken.  It sometimes irritates me to find "git clean" (without "-f"
or "-n", and with clean.requireForce not disabled) complain, and I
personally think "git clean" when clean.requireForce is in effect
and no "-n" or "-f" were given should pretend as if "-n" were given.
I wish if it were "without -n or -f, we pretend as if -n were given,
possibly with a warning that says 'you need -f if you actually want
to carry out these operations'".

But that is a separate usability issue.

What I find broken is that giving one 'f' and one 'n' in different
order, i.e. "-f -n" and "-n -f", does not do what I expect.  If you
are choosing between do-it (f) and do-not-do-it (n), you ought to be
able to rely on the usual last-one-wins rule.  That I find broken.

The mistake[*] of "-f -f" is rather obvious, given that the other
"normal" ways to tweak what is affected by the command are done as
"what else do we clean? directories (d)? ignored (x)?..." options.
When we add the upcoming "precious" bit support, we should make sure
that the way to trigger "oh, by the way, please clobber those paths
that are marked precious, too" is not by giving three '-f'.  It
would make it impossible to ask for that without also removing
nested repositories, which takes two '-f'.


[Footnote]

 * To a lessor extent, the -v (verbose) option shares the same
   problem as "-f -f" here, in that its worldview is to assume that
   a single "verbosity level" is sufficient.  Unlike the severity
   level thing, however, the user who wanted to see only messages
   about X but have to also see messages about Y and Z that are at
   the same or lessor verbosity level as X can filter out unwanted
   messages without causing a real harm.
