Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06ADC63777
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C276206F4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 10:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hslqJgBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgK0KXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 05:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgK0KXp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 05:23:45 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3C0C0613D1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:23:43 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id hb22so6639222ejb.12
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 02:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=XhdlVceSgNf3oqtrQ9mzQLLiinSsYPirQ63DVdilpUA=;
        b=hslqJgBQfRfu6VQ+zVatlYw3odHt+9vTPK38NZLNEgH93MoIl9Qei8i6L3gWM4Vx5X
         UsLmmRYffxK+EmUWBtEjvs3gQc76JEEwjRcMiRBOZFe9WZ7sZIX8Vmn7mIrIFFOBx9qM
         DkneE5SqPJauG1rRLqPtg4mf4E0WM3LMuVIt2/ohn2oIKfpLrGaOCwPOd2stq044pqwm
         I876rOjvPPU/G+JX0c/sVSesNKDbv7hNuw75tFDFjPfqNaqmpYn78osB/BykQ/3de5vt
         SZ2uY3im9O3qG0cVaeLiCHBGDWxx0c7yf/hE7HTcsBL4GRbnYTUCfwDctAcmpQS3l7xf
         VIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=XhdlVceSgNf3oqtrQ9mzQLLiinSsYPirQ63DVdilpUA=;
        b=Du5wSRbkJc6ldPcUYPu721M8nXyfj1xkaN494SSECRa1kCyFHbI57VS4dN6K+y++sP
         IXOwg7JuP4hnVNBuCPf6BJJi94z/Qw7W9xwdC8WaFwF51vtBt6dRzwfjvAZwQmmyZE3a
         gBYakFAUnCavkckFwuaPMFowqtvHAPWS6aqlKfHqhh5ZQCbnVY+wWDWEgrLFt1scb1Rr
         aE0cuRANUVHNPcaFnz6k3fkmm3KFw0n+XPX5/Ov8laAFJXjCvrxvJHjEKiT0yRcYyyLf
         0bQ+JvV1lSkmlFaGNF5i5xLgjyk6S3bgJHPtHwTQCIjomYmPGfEy0tQ0OW8DA08KDuEw
         DMaQ==
X-Gm-Message-State: AOAM531oGfX2dTUQgEl6N8lgFmb1Jzae2Wimgs11Ujc8wWzRapcjcnIH
        v2XjbPVbLjAMLGAGr/4II5UGct8pZjERLg==
X-Google-Smtp-Source: ABdhPJwMRqhu5McpY8HIcJdOdX790JzkX+HLScdSPMdGJyYtxXohVogaRcLCaFhphsSlLTkGLvo56w==
X-Received: by 2002:a17:906:81da:: with SMTP id e26mr6625397ejx.491.1606472622052;
        Fri, 27 Nov 2020 02:23:42 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id rk12sm4378415ejb.75.2020.11.27.02.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:23:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 03/16] reftable: add LICENSE
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
Date:   Fri, 27 Nov 2020 11:23:39 +0100
Message-ID: <87lfennln8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 26 2020, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> TODO: relicense?

On the topics of TODOs, it would be nice to have an answer/some idea the
"I am concerned..." question in about
https://lore.kernel.org/git/873625i9tc.fsf@evledraar.gmail.com/ relevant
to the license etc.
