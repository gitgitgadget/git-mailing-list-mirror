Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062A7C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 01:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1157603E7
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 01:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhHGBgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 21:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhHGBgh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 21:36:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E77C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 18:36:21 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 188so13485831ioa.8
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 18:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0rEeNmEQ0XnNOG+7mauFiVs2Ero4CRtshaWN/HbVWCw=;
        b=k+QcKGAFCSSUsPyn5I0xyqgEVIwYzYHqeCV00HTG8CEVLLI04/V7B4NglIQKDEZOYR
         8TSx0Ff8liJEiv0sKjf+DvQp155M0QBI3QIts+527ujGBC5eHKzznGuelS8UbaNrzRv1
         fsFaRexhzoWj/lJbltTbKHkeAdfB2og958kpNeUXGMCI9D3BdA5qSf9MzstVFZKb1a2n
         f2iRLso5Q58YJFh3ceSCTw9+vrvjDFBejw4askhIqPwTmr5ejBV+nnZwhob18zH+b2SC
         qWYm+OkjXQCDEiG/v5ESJkMWbISfvbQxyG1il0irBJ8BzAZUJ24c6FmZUbFNvLbIo0nx
         vuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0rEeNmEQ0XnNOG+7mauFiVs2Ero4CRtshaWN/HbVWCw=;
        b=dLqwmcBAwi3Trsa93WkSGFrfpnSuQYklZdFQaJKNAFhVSLAfulSvJWa5YzeHKXaCTq
         Onv3b8JVm+etVlOGFhbCu/rovzgvwJ9+fy3nqxmj+EVxaUaC77IzIgQiCBlLNlurPDDS
         X2B6gHo8EH6Rgsy9ECrpTcD+ilYtzQMy5zi8mAN4MosX93qN1QGpPY1sWRloNSu5gF0B
         D6y2IJkWQ3i2hnJ8kqbaS/eRnZ7CsD1/J4VFtFY6GUK1eVMMBamig8LAHgxIzahCzgRP
         wd+pdzjnf2KmXYQ9DdBcgcjc3wjEtRv+CiujgrvA0rb6XUTwOS/OObiVxcXKsg136LTL
         FMhA==
X-Gm-Message-State: AOAM531LPth9YChrtxjGjmgvCFZv/vejL4s7V3vvRQbZ/0quml7PkSqf
        vCwUmEhMtfS3WOVchSeMPy4CEEKqhomViSEGPEE=
X-Google-Smtp-Source: ABdhPJxiZrloQ0hqnnNjl0Y/70kmUJA7R3MgjtUQ1gQ9JAoM/SySaRL95sjl07+qzqgNQR0rLuf9/t770ombTkMFflI=
X-Received: by 2002:a02:b047:: with SMTP id q7mr12505442jah.130.1628300180692;
 Fri, 06 Aug 2021 18:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210805194825.1796765-1-felipe.contreras@gmail.com> <20210806164433.8665-1-felipe.contreras@gmail.com>
In-Reply-To: <20210806164433.8665-1-felipe.contreras@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 7 Aug 2021 09:37:08 +0800
Message-ID: <CAOLTT8S2_CucmhW8f6Ko8m5xUkfwSRjoqr_R_VyZdimGanMhoQ@mail.gmail.com>
Subject: Re: [PATCH v2] test: fix for COLUMNS and bash 5
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=
=887=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:44=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Since c49a177bec (test-lib.sh: set COLUMNS=3D80 for --verbose
> repeatability, 2021-06-29) multiple tests have been failing when using
> bash 5 because checkwinsize is enabled by default, therefore COLUMNS is
> reset using TIOCGWINSZ even for non-interactive shells.
>
> It's debatable whether or not bash should even be doing that, but for
> now we can avoid this undesirable behavior by disabling this option.
>
> Reported-by: Fabian Stelzer <fabian.stelzer@campoint.net>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> Since v1 moved the code before setting COLUMNS as SZEDER G=C3=A1bor sugge=
sted
> and mention checkwinsize could be set before bash 5 as =C3=86var Arnfj=C3=
=B6r=C3=B0
> Bjarmason mentioned.
>
> Range-diff against v1:
> 1:  40273074de < -:  ---------- test: fix for COLUMNS and bash 5
> -:  ---------- > 1:  9f8c3ffa6a test: fix for COLUMNS and bash 5
>
>  t/test-lib.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index db61081d6b..6b1015a5af 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -409,6 +409,12 @@ then
>         verbose=3Dt
>  fi
>
> +# In bash if checkwinsize is enabled the COLUMNS variable is updated eve=
ry time
> +# an external command completes, even for non-interactive shells. Since =
bash 5.0
> +# this is enabled by default.
> +# Disable that since we are aiming for reproducibility.
> +test -n "$BASH_VERSION" && shopt -u checkwinsize 2>/dev/null
> +
>  # For repeatability, reset the environment to known value.
>  # TERM is sanitized below, after saving color control sequences.
>  LANG=3DC
> --
> 2.32.0.40.gb9b36f9b52
>

This can work on Arch-Linux. LGTM.

Thanks.
--
ZheNing Hu
