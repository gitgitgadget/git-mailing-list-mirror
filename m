Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F7C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 01:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9971561074
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 01:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbhICBzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 21:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhICBzg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 21:55:36 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E1CC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 18:54:37 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id s25so3188041vsa.9
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DZrFEQpvlKWkfBckGGTB/O9xRqrQuEQ65OEC0WEijKk=;
        b=f4BGKe8kQx8bi/rUseHU75pAoluRqCqR738rGeXz0oUQ1dWXXncaOfLyyHa1u22Nar
         zlplEfT1tr1SAFuX+iYHvo/IpkubeXj7uczrU722Z//NuVTVCVOj1uz6nlGM/dk+7uP7
         lchpAkbtjhTDaLbHJM2MFr4dBUCZ75kpC6hqLhGjJvJtCyDK8tRXHaLY3I+f3oZVA0BJ
         msfNXMtWttEoptmYonAiSrQZY0zwPUVBPnt309qB0H/SZKh7kFQ8F4P0SHoG/RvYxvFo
         3IiSSsZsEfx5rfCRZ3LzH8AvnuQfkCJ4Xs4hkpGVwlh6uZkRZFDRLh0CACyxCVyb9nwo
         0CLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DZrFEQpvlKWkfBckGGTB/O9xRqrQuEQ65OEC0WEijKk=;
        b=TY45ozDKlyGivCivOBIB6UrjgnsRtpDPK6NiK0NyhIzjoD5nmfTttkxxQDmMSw3O8f
         IkFet4K3F1NrYuXbT+ZiG+4GOeiDxEvmwjfNoTDWOCe92IL4dtqrVcMz8YWdAc46DQX+
         WaAoFPRgOxVNq+Fh+qDqlmdAhWogwQufypjCH7n3Ftd2dcWZWxp3mP+GWZQpkMDfBC+P
         5UJKGjh0bLH5u8nkL8JTyQEMp7nWV/0z1/VcRvaig22mDifvNmH2SyHh85kdff52vObZ
         EQCH3ZIv6y9i29jMUM8lhP+8anIr1iKA6mLCxRtNk8gxaGBqSeRACHxi5cQOL9ireszD
         5w5w==
X-Gm-Message-State: AOAM533VOdTYpyEjC2PTYVtZbVVQO5K+wFIlrUq86eMBzRpQuRmuLMEe
        KvjApTBMhu/lOFqpiL+pk8IVnDhc4LLjuZkf4uLHzBmY
X-Google-Smtp-Source: ABdhPJykyqBQUNoWSvcrj1PgqeAbxx1ex36VvNSJmEThKllwo8KqinvbAGWE4h+zGCA1mSLnC/LLFdCgRLw760M8gQM=
X-Received: by 2002:a05:6102:10c7:: with SMTP id t7mr949548vsr.44.1630634076244;
 Thu, 02 Sep 2021 18:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210902085438.54121-1-carenas@gmail.com> <nycvar.QRO.7.76.6.2109021730040.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2109021730040.55@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 2 Sep 2021 18:54:25 -0700
Message-ID: <CAPUEspj8gwpBNZRqJWgoUG8ouxnMd=SMtoH=z+8AR12+f+j5_g@mail.gmail.com>
Subject: Re: [PATCH] makefile: teach git about NO_MSGFMT (as supported in GUI
 and gitk)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 2, 2021 at 8:32 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 2 Sep 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> > NO_MSGFMT can be used to indicate there is no msgfmt available, so
> > make git recognize that and avoid failing to build while trying to
> > generate i18n files.
> >
> > while at it, refactor the change introduced in 4348824059
> > (artifacts-tar: respect NO_GETTEXT, 2021-07-04) with something as
> > functional but shorter.
>
> To me, this commit message is not really related to the diff, which
> essentially only adds a code comment and then has the only functional
> change that _prevents_ `POFILES` and `MOFILES` from being set to empty
> values when `NO_MSGFMT` is set.

correct, except that they should be empty already since nothing has
set them and therefore the end result is the same.
I should have mentioned I tracked back the conversation for this and
even the github issue about it (that I can't find anymore) to make
sure it wouldn't introduce a regression.

< I am therefore quite puzzled how that diff is supposed to achieve anythin=
g
> that is described in the commit message (how does this "make git recogniz=
e
> that"?).

It does not, which is on the (on an unrelated but touching the same
lines issue), which I am starting to suspect I shouldn't use anymore;
apologies for the noise.

Carlo
