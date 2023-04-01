Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3028DC761A6
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 00:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjDAAZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 20:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjDAAZS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 20:25:18 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83CCCDC9
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:25:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p204so29246234ybc.12
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 17:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680308717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yJogZ5Q8yJRdY9gLbtwmDTI9pbyn3Bn9iHAhvoWIdI=;
        b=Ks8EGKsHoBplVYfost1JKQpulv3ERYS6a7Jw9rcNVR5E2eSbMEWMbm1MaA7Cf+onqM
         MrnSd8wDuxYv0UPrDKeLjmbVAuopD03XkbRLc25TMJAvLaB7sb8nkgTJI1ecLAW+aXIU
         7n+DHFqBd1Vv4WcYNSY2+wJMfz2MvrXyMGxBI9zgwiyUpZYsfpbTpHD6Y+VMypQ8IQvK
         b9I09ae3p3pi/nKduCcrAzj8BTW0q3BFq438ZuNi0zABcu5NujdlOlaPL3uIWqWSk+g+
         uEI00jNpT39xxWwhRAOLq0EwNb0vpairDJPSWpBOVuIRwN5p7hlG57lgLlkx7bt3Dtfs
         pZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680308717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yJogZ5Q8yJRdY9gLbtwmDTI9pbyn3Bn9iHAhvoWIdI=;
        b=p3F+7IbjYlzZoMEzVJjLhpErEwGFvmklj11kwQyCsHxLPJCF4Z0rDWTACpiYM/7KFG
         CWaa2zc6uSO+ngYdRpKb7/vdFaFvOAhrgcst5205l01bT/civmMy7nhaobgSTYeqWLJG
         IevkxgxEV07ygEMEGJc3XW56zsgcd+0nDe+Y/txqn93VSP2Q0fEj+yySTdb35Tqme1Jn
         Elmw+FpGAWAFjf/w/xZuC4+mY3A2hCU/CiKWJwSKHaErvSX4DjIzFPcgm+ah9S3e/9aj
         o52v5Vx2eosMuY1Sx8LyM1nsbsukhF7L2jPQgfVPdfH5yY2uIwxxUxEjbx5mWCjdaAI3
         FZig==
X-Gm-Message-State: AAQBX9fFAcuas0N/d+cjB5Q6T2NIG3iQYw0DaonnREb12ybB074yyeMv
        VwRuhxxNyv7UUJVA4Z08mUcw7fdq1HC3GDih7ipRuJ3z
X-Google-Smtp-Source: AKy350a2WnyyGq5NoCOueXRLgNg5YpeiM1t8+QNIxtqsvn1HWMP9haRUu/+wZmVcYcj00QF010bMQaX1vVhNu4z1lYg=
X-Received: by 2002:a05:6902:18c6:b0:b78:4788:525b with SMTP id
 ck6-20020a05690218c600b00b784788525bmr18500499ybb.0.1680308716924; Fri, 31
 Mar 2023 17:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
 <20230328173932.3614601-3-felipe.contreras@gmail.com> <ZCd1Vyr+l9w/NmZ+@nand.local>
In-Reply-To: <ZCd1Vyr+l9w/NmZ+@nand.local>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 31 Mar 2023 18:25:05 -0600
Message-ID: <CAMP44s0XQnDkRcR7bzztsiuPBXTBdECHLQ=7pZYzt4d3oBB8Sw@mail.gmail.com>
Subject: Re: [PATCH 2/6] test: avoid `stat` variable
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2023 at 6:05=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Tue, Mar 28, 2023 at 11:39:28AM -0600, Felipe Contreras wrote:
> > ---
> >  t/t0001-init.sh                | 4 ++--
> >  t/t3432-rebase-fast-forward.sh | 4 ++--
> >  t/t4013-diff-various.sh        | 6 +++---
> >  t/t5512-ls-remote.sh           | 4 ++--
> >  t/t5516-fetch-push.sh          | 8 ++++----
> >  t/test-lib.sh                  | 4 ++--
> >  6 files changed, 15 insertions(+), 15 deletions(-)
>
> Maybe I'm misreading your patch or its subject line, but all of these
> hunks convert from something (usually "status") _to_ "stat".

No, the title is wrong; the purpose is to avoid `status`, which in zsh
it's linked to $?

--=20
Felipe Contreras
