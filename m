Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D368C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 21:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjBAVeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 16:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAVeG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 16:34:06 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98FE39BA4
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 13:34:04 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hx15so396469ejc.11
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 13:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lr/hQKyutTuhtqCRDpKsFx5xCSFgx9in53Lk3q8mI5k=;
        b=AsZXcjbjXbocH/yr/Ss8dEJ2baXfywOiVe9RlzF9xykg0kEV896pniunTTAq1USdrS
         pyeo4As01wfmmw1PYJsmbNEjAbCWsf7b3uETjlzC+Fkmvo1Uo9rbadrmRXIfIdshV7I8
         Y6YP7V3fLY49qnOmA9p5A/lzFNhE2Alata7rWMA0rreaRdSHqHYAbCSvjKavLBgJFrqw
         pa2yioH7LpPyEDPW3V82Qk6TzXnBD4juTeRrCfsTVkzI+4VpdzoO8iBOXfoZ5LyplerJ
         5pVDiDj/75a6GRgHZDPLmZ3Ao2gN2Nx50k0US/EQrXlnlsA+Nhr0gkt/x4QhOSSL7OMO
         ynvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lr/hQKyutTuhtqCRDpKsFx5xCSFgx9in53Lk3q8mI5k=;
        b=wziUBFW2nhgPMLe8p19f5/vvDz1D2aFnNx+GuDnAfDe8Itvd+swaPiQ437PsOUGhiP
         nbv9/c5L3cdsZDgWWv42nE9jmJSNPj+Kwgan8y03aSuUoKRVeGivFN8gajryuXE4LY9l
         YDKsBkt9l36XWOk357fI2Z+Fr9tjGDJ6pSFuGX1Zvm5v249CoCCVc082Y9qRMa4JVgOn
         L3GO9j2Zhw9O7J4TXqTimSao5MJsa3pbr8zN66xfNPEzmkfOVa7LeReOZAia7xLDGSf8
         uBXDsjmsDtwT8vJXyq7loWoyBRBAxCFrducA6/rxnr9VoKKqy4nQD7JyGYP8p27WASSe
         imBA==
X-Gm-Message-State: AO0yUKUK2Yqu/uTpYlhvwdkrGiPym+g8G0PyFmmxXXlhMIjkXAJRrmdx
        EvTZJl8LDbTrMfB9tfnHACOX2Dm5vsO43Lm5m2TCKNTjTD0=
X-Google-Smtp-Source: AK7set9Rh1ojEwNARhPPYCmQDej4usEt2YegC9x1oGXq88jt1EHj3Jg+aqIhTA9+I3NwaAc/M1NGTcQN8R/Ev3H0eIQ=
X-Received: by 2002:a17:906:ecef:b0:884:3f4f:fa8 with SMTP id
 qt15-20020a170906ecef00b008843f4f0fa8mr1046592ejb.29.1675287243338; Wed, 01
 Feb 2023 13:34:03 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <CALnO6CDCkuN2XU_AyO66hQSm2ztfpe8Rs_baw_J4uTQZmekREw@mail.gmail.com>
 <CANgJU+WZR56xG+KL3P053aD_qTh+rBhZ01mqNajg2qRt_+RNMA@mail.gmail.com> <xmqqsffpz05o.fsf@gitster.g>
In-Reply-To: <xmqqsffpz05o.fsf@gitster.g>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Wed, 1 Feb 2023 16:33:52 -0500
Message-ID: <CALnO6CAZ_RMirOwQqJyqJrq2dY1w09eV1h=0JFosYSb7XhyQVQ@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        dds@aueb.gr
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 1, 2023 at 1:54 PM Junio C Hamano <gitster@pobox.com> wrote:
> There was a discussion on BRE having and not having GNU-like
> extension on macOS, in this thread
>
>   https://lore.kernel.org/git/26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de/
>
> The patch we ended up using avoids touching the behaviour with ERE,
> as REG_ENHANCED on macOS affects REG_EXTENDED, but the issue we were
> looking at in the thread was about BRE.
>

Are you suggesting that I try with `-P` and/or `-E`?

CC'ing the original author of
https://github.com/git/git/commit/1819ad327b7a1f19540a819813b70a0e8a7f798f,
which I suspect is the most relevant.

-- 
D. Ben Knoble
