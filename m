Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FA0C433E0
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 18:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6512076A
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 18:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="zMhS3hHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGRS15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 14:27:57 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:37382 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgGRS15 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 14:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1595096876; bh=+QnEt/q28YPem7kRnP0h0yVdsNuTA2ZcPndyttJa1EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To;
        b=zMhS3hHiTJCjh+IoacsRME4+ld5TFl/FQqGBPxw1fEtIhb/OUFtCZ2mLXFKg9r/O3
         cktGh6vsA2knW2Fuqyj0d8v8w2oVdxVFsCJ67+58RX16RC9WBRyYG/iK7jd3nG6sBo
         uCY7MCrcP+nvW2DivLOST6WYJZFghI21qu4EIjPY=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] git-send-email: die if sendmail.* config is set
Date:   Sat, 18 Jul 2020 14:25:41 -0400
Message-Id: <C49YLQZUZ4RG.129ZY8FQEYDYU@homura>
In-Reply-To: <xmqqpn8sbt0w.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat Jul 18, 2020 at 7:02 AM EDT, Junio C Hamano wrote:
> It is not very friendly thing to do, though.
>
> It just closes the door for anybody to add something that works
> independent from "git send-email", to which "sendmail.*" variables
> may be appropriate knob to use.
>
> Demoting the "die" to "warn" is OK, and limiting the check to
> variables that actually has corresponding and likely-misspelt
> "sendemail.*" counterparts would be even better, but "you are not
> allowed to have any 'sendmail.*' variables, ever" is way too much,
> I am afraid.

I originally had this just a warning, but it can be difficult to see.
There's a lot of text printed from git send-email, a lot of it looks
like diagnostics, and it can be easy to lose a message in there. And if
you pass --annotate, which I encourage people to do, your editor
immediately covers up the warning.

I wonder if a happy medium would be adding a config option which
squelches the message? If sendemail.squelchConfigError is set, for
example. If not, I'll experiment with a noisy warning.
