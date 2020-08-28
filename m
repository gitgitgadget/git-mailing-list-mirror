Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBADC433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EADC2080C
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 21:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="upZHOR0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgH1Vn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:43:29 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:50388 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgH1Vn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 17:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598651005; bh=EXWN597K6iWkHxaMUK2b2bB7uA2otazoKC2nj07wjIo=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=upZHOR0J1Oe6D9Eu921KP1+f6yEd87Vogl0WbGmIRAAKJY7CMMKKb3lbvA02OCoEu
         2nUA4L3iUCwGdBiqaq4pNl47FS/kVWwaJTgzw+fUVxTjOqFmd/awOdfFTe8riAWHnx
         ie740XJFACuNcdACDOw3TgNUdKoRdm/pN65wlhbQ=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Fri, 28 Aug 2020 17:35:09 -0400
Message-Id: <C58YB5DAHSZF.F67NZSQYAPF7@homura>
In-Reply-To: <xmqq7dtio3pa.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Aug 28, 2020 at 5:33 PM EDT, Junio C Hamano wrote:
> I suspect that the legacy reason exists only because it was (thought
> to be) (a) common enough to make a series in response to an existing
> message than a thread starter and (b) "to:" and "in-reply-to:" are
> quite close to make sense to be asked together [*1*], back when the
> current behaviour was established, ? In other words, the "legacy
> reson" may have inherent justification for it.

I understand what you mean, but like you said, without a time machine to
peer into the mind of the original author, this is an assumption without
evidence. If we cannot come up with a renewed justification it... does
it really still hold on the basis that it may or may not have been
adequately justified at some point in the distant past?

> Your primary and only argument to flip the default not to ask about
> in-reply-to is, because, in your opinion, more users would want to
> send thread-starters than responses. I haven't seen the numbers,
> and more importantly I do not think anybody can expected to produce
> numbers that convince everybody (there are biases based on who's
> counting and what is counted), so I cannot buy such an argument
> blindly.

I would agree that this is part of my argument, but it's only a
supporting argument, not my primary argument. The primary argument is
that understanding and answering the prompt requires domain-specific
knowledge about email internals which are not normally presented to the
user. I am unaware of any mail client which makes the meaning or even
the existence of the Message-ID or In-Reply-To headers known to the user
without going out of their way to find it. Explaining the meaning of
these fields, how to find them for their mail client, and when to use
them, would be well outside the scope for the prompt itself.

No one has yet come forward to vouch for this branch as something they
actually depend on, by the way. It's just been people who are unaffected
making arguments that such a user may exist in theory. Maybe we could
figure it for sure out by putting a prompt in this branch, like you
initially suggested?

> That makes it the safest thing to give users a new choice without
> changing the default. That would allow us at least move forward.

Well, it'd be a start, and I may very well write that patch for the sake
of moving forward, as you say. But it doesn't solve the problem I came
here to solve, unless viewed as the first of several steps towards its
eventual removal.
