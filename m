Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6C6C433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 18:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351212AbiD1TBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 15:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiD1TBU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 15:01:20 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E51B9F35
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:58:05 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id ba32so2114006uab.6
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/snCfLg3kiBMsHAqR8mjM2Dq1w2dLE8IWvdvR2nirOI=;
        b=ldEdPW2I6RoVQjCWVPbbtimsmDa41CwKqEzoCMYMOoL7TrmLHFQjae5vuAePLBQvSh
         FHZqLbwzNBPb5nzJX1lnmlnVhEhYB9JQnwTq4rQ1Y37zKS6/TXjXHahKJLlUdsad+Czd
         LnPrnVnVex46b6KZTro35BnJC1/SqfUv4LBb60LiOObV8ZComtWZiez2ycxImSbgkiNp
         X6PgjsnnqsJFWNrXB5/NcHfyVrlQZ/8LAke+buOjEKAX8i9hZdCgsAllOZymm8Afe793
         4pBQ2EVoCq8fM1u0UD3igRHIQC7RJm9e3gTZvAM6m5DroMx49W1PJLR4P6+sJ1JxuvxP
         1Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/snCfLg3kiBMsHAqR8mjM2Dq1w2dLE8IWvdvR2nirOI=;
        b=TL+CXj+YSyVEyMlZ8w6HcieRdQEtdUPTneXVfdL3cAuPDreQudPVy1sKYeGzLLb4R8
         EIscRQNklew/3AFy/IRDipopffCaEGKzsfj0dJ9t3/TQrN5lSIVEpG2sCIxlLHBHKBa/
         KWe56LlM23XWCMCGV+dvWPO3XBRRMxflxSGG6REjP3fYDBV5qLP/UErkTSvFiXJQ/0Ie
         vLF5H8sTKJD8IDMShqMCzfRES3l2dNhqkbefYtO6vIikY1yUkSBcKVJ3/zNrxI25+luq
         fPwOWjM7w/tTiCT773GnxDWeXPjfX1PNbJCpwTheop9fDMY4NotP6P/ooc3aCJET7IeA
         3CYA==
X-Gm-Message-State: AOAM533f/rSFmlXnLFMXFX7ekRfBSDtMMFCLHdfSIyGzbRdrl32+WqKS
        oluw4up8/V+6LNm7uigXXYu5z5LIXpqY0q3VefI=
X-Google-Smtp-Source: ABdhPJxYRWcVCB/aSKedv3xyBOTfwmTPSi7oy09BZOeIn4Z2XxsLJzYlLy7kNelEk2T9lsGmC16YxmJWQsgDgcjAMgw=
X-Received: by 2002:a9f:2048:0:b0:352:9b4f:ac98 with SMTP id
 66-20020a9f2048000000b003529b4fac98mr11043863uam.12.1651172284503; Thu, 28
 Apr 2022 11:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220428033544.68188-1-carenas@gmail.com> <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-2-carenas@gmail.com> <225d0f01-89d5-f2b4-36f2-097b915d66c5@gmail.com>
In-Reply-To: <225d0f01-89d5-f2b4-36f2-097b915d66c5@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 28 Apr 2022 11:57:53 -0700
Message-ID: <CAPUEsphFb-=BcV-mxS5RZpJQ8UVq23ni0Lo8tQ4J3TP04B4KQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2022 at 11:02 AM Phillip Wood <phillip.wood123@gmail.com> w=
rote:
>
> On 28/04/2022 11:58, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> I still don't understand why you're worried about preserving errno - am
> I missing something?

I don't think so, you are correct that doing so is useless now and
could be dropped, I even said so in my message.

> It's not wrong to save it but I'm not sure why we
> need to. is_path_owned_by_current_uid() does not save it around the stat
> call so why do we need to do this here?

because the errno from is_path_owned_by_current_uid() is useful and
unlike this one is not being handled, so a caller of that function
might later use it to distinguish between a "dunno" and "no" answer to
the "is path owned by current uid" question and more importantly
understand better why "dunno" was the answer (ex: path has a loop, or
not accessible or whatever).

it also documents (in the code) that this function won't report any
issues it might have getting that information from the environment
(which extra checks on top to make sure anything suspicious is
ignored), so you can trust that if you get an answer it was a valid
one.

> > +             errno =3D 0;
> > +             env_id =3D strtoul(real_uid, &endptr, 10);
> > +             if (!errno && !*endptr && env_id <=3D (uid_t)-1)
>
> Thinking out loud:
> "!errno && !*endptr" ensures we have read a valid integer from SUDO_UID.
> If uid_t is unsigned then "env_id <=3D (uid_t)-1" ensures the value we
> read fits into a uid_t. If uid_t is signed then this test is always true

and you hopefully got a warning at build time.

> and we could truncate the value we read. However if we don't trust
> SUDO_UID then we shouldn't be doing any of this so we are trusting that
> the truncation never happens which means we probably don't need this
> test in the first place.

it is there to protect us against a system where uid_t is unsigned but
still narrower than long, and so we don't accidentally assume uid =3D 0
if we somehow get (the obviously tampered with) SUDO_UID =3D UINT_MAX +
1

Carlo
