Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36DBC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31F42075B
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="bQCo/3bT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgH1Sty (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:49:54 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:50004 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgH1Stx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 14:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598640587; bh=uUT3amoJc84cMAKH0S5nH/eUMD0Fd6/fWUlMw+LivU0=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=bQCo/3bT5fWWsENidiwN03jUZBSZfOfwWN1/BYvwLYPyRpE/mPBoUU0SRS87z4wMm
         wdU5nlz/M47OI19P4k58ZZaXUTOkavL+vHjXUvrmMeW/irM9lT3lu/I2QZXbTdV7Zd
         uArHpjOOgub0uyW1Ru0t3+hsjvIp4paonFuxPYs0=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>,
        =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Date:   Fri, 28 Aug 2020 14:39:02 -0400
Message-Id: <C58UKAYKF1ZY.V5LLW3DY1KAY@homura>
In-Reply-To: <xmqqd03bpuh7.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 27, 2020 at 6:57 PM EDT, Junio C Hamano wrote:
> To help those who do not want to add this header, it would probably
> be more helpful to tell what to do when prompted (like "you can give
> an empty answer to tell the command that you are not responding to
> any message").

I'm trying to come up with a message like this for a reduced-scope
initial patch, but I'm drawing up a blank when the goal is to avoid
confusing users who don't understand this. The goal is to remove
domain-specific knowledge about email, namely how the In-Reply-To and
Message-Id headers work, which is uncommon knowledge among new users.

"You can give an empty answer if you are not responding to any message"
could confuse users, because they might think -v2 is a "response", or
maybe they've written the patch in response to a discussion on the
-users mailing list, or any other number of reasons. Now they have to
figure out how to answer this prompt, even if the mailing list they're
sending it to isn't expecting it to be a reply. I came up with a number
of alternative wordings but they all ultimately failed to this same
problem.

In-Reply-To is such an arcane and tangental piece of knowledge so far
removed from git, and so little information is given to the user to help
them understand (1) what it is, and (2) whether they need it or not, and
(3) where to find it, that this prompt just seems totally awful to me.
It'd be like if we prompted someone to enter their display EDID when
filing a bug for a video game. Could it be useful? It's unlikely. Is the
user likely to know what the hell an EDID is? Almost certainly not!

"Legitimate" use-cases like qemu-devel or not, this is only ever going
to confuse new users, and I think that qemu is wrong for encouraging
users to deal with it.

Or they would be wrong, but I looked into it and, the qemu wiki advises
that the user does *not* use in-reply-to:

https://wiki.qemu.org/Contribute/SubmitAPatch

Nor does patchew make it easy to extract the message ID from their
interface for this use-case. I'm not sure where this qemu idea is coming
from.

Is compatibility-breaking migrations a nightmare? Well, maybe.

Is that nightmare worth such a trivial problem? Well, it seems trivial
to those of us who have been using it for years, but I can assure you
there are plenty of new users who shut down at this step.

I hate to be a nuisance over such a seemingly simple problem, but there
are a lot of new users who are struggling here and I care about their
struggle. What path should we take to fixing this issue for them?
