Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C471C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 05:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3357C60F58
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 05:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhHQFCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 01:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhHQFCM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 01:02:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6C1C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 22:01:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so2985968pjn.4
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 22:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=5XQbYVzdGayfT2Uitnb1kzX8d1P2Lr+aMHqXNIWX3mk=;
        b=XeBjS9XWbef1tbJDgravNMR9XsoUQ7okIJMfJwtqI6Q0OyNgBwWHvYd6V3NuF4P7U5
         ic2gQuaMMrpvqBuFyXd6BXzPUO3710JYZwPk9IyHU5fKx11Zt3xaPMS31HhJqq9+PULi
         QLb122T7TCX/JV16s5Rgycu+rA5p+mMkIhJWTW2FKN9klOWvbhCnwk/r4PVp9TGrUSFp
         kmAiGOuv07BZu8pJqgXuQNywF8h0toTBCdlDH02rLOw9uYeFbso8Uhe59ouk3WevJ2J0
         s/REVOm/YkKuHPkqIKI9MxSVdeSOMCmBkUyrc6ImQrm79DL1ug/JGuACq0+O3gifjoKI
         Ryrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=5XQbYVzdGayfT2Uitnb1kzX8d1P2Lr+aMHqXNIWX3mk=;
        b=YMnR11Gets+uvejxBPt2znycft6SFFh/UuJKArB249Z6Zt2gY2sdE7p0pbiN1YzvQo
         6sTAViPjq1GNyk0Xi8kth/fuJB3VTJtnL2auNYF1icchKWcn4/ZTYFZp8yQ8BHZeew+p
         UjNIeW8amg4ccjGnZPV9L2WsqKTbZ6vQagYL1rqC13RvSRGeoEVWyVfNypD/GoYPzVTe
         XbPgD/I/iXyQAQjaXq59Ur1HM/OJ6bLLU8WtXmEbOzY/8nhhzLejDdJtIJyILaE+cLTa
         5Rnn/vw8TTETLaKQDqlwGB7LgMFS6jPHVliY7WLD3eftoZTCIk5Yq8f0VCoxF+BpJXvq
         tGkQ==
X-Gm-Message-State: AOAM533Yh2tMImNxOkSPc/J5Bbi2xbNREgD+3Xec+6BowxnPaAZi9u4c
        tfYxtVhb0kALAltKAcUv3+o=
X-Google-Smtp-Source: ABdhPJz3at4XOXBK7p6p1TAczJvJ5tMHKBxPWmrZ02UDmw85FDhXVyqFNH3ND3/DOPD92tMO0bLlQg==
X-Received: by 2002:a17:90a:7283:: with SMTP id e3mr1654765pjg.65.1629176499311;
        Mon, 16 Aug 2021 22:01:39 -0700 (PDT)
Received: from atharva-on-air ([2402:e280:3e09:4a4:9477:bacc:6c6e:9e7d])
        by smtp.gmail.com with ESMTPSA id z3sm879022pff.47.2021.08.16.22.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 22:01:39 -0700 (PDT)
References: <m2lf5lxog6.fsf@gmail.com> <m2k0l5xo1q.fsf@gmail.com>
 <CAP8UFD0V3hoDUkeMyAaeo_=cZ46P-Yka1v67FFNbQ5Me5Hh_+g@mail.gmail.com>
 <m2pmuwrp7x.fsf@gmail.com>
 <nycvar.QRO.7.76.6.2108161500200.55@tvgsbejvaqbjf.bet>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Shourya Shukla <periperidip@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [GSoC] My Git Dev Blog =?utf-8?Q?=E2=80=93?= Week 11
In-reply-to: <nycvar.QRO.7.76.6.2108161500200.55@tvgsbejvaqbjf.bet>
Message-ID: <m2h7foaclt.fsf@gmail.com>
Date:   Tue, 17 Aug 2021 10:31:34 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 2 Aug 2021, Atharva Raykar wrote:
>
>> [...]
>
> You can use the `linux-gcc` job for that, imitating how b2627cc3d4b (ci:
> include the built-in `git add -i` in the `linux-gcc` job, 2020-01-14) did
> it for the built-in `git add --interactive`:
>
>     ci: include the built-in `git add -i` in the `linux-gcc` job
>
>     This job runs the test suite twice, once in regular mode, and once
>     with a whole slew of `GIT_TEST_*` variables set.
>
>     Now that the built-in version of `git add --interactive` is
>     feature-complete, let's also throw `GIT_TEST_ADD_I_USE_BUILTIN` into
>     that fray.
>
>     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index ff0ef7f08e7..4df54c4efea 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -20,6 +20,7 @@ linux-gcc)
>         export GIT_TEST_OE_DELTA_SIZE=5
>         export GIT_TEST_COMMIT_GRAPH=1
>         export GIT_TEST_MULTI_PACK_INDEX=1
> +       export GIT_TEST_ADD_I_USE_BUILTIN=1
>         make test
>         ;;
>  linux-gcc-4.8)

Thanks, this is helpful!
