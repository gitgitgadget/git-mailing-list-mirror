Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B019C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 23:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA18613AE
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 23:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhFPXYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbhFPXYq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 19:24:46 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEEEC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 16:22:39 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso4219887otl.13
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 16:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=BVS28wLIYj2k7XQDoj1OMeaAKqW4Bmg+uy3xoJk0Wx0=;
        b=BpA7uJ1sv7JiCZx+3ILv6v9+DGSWG/fExovwhpco0RtDmxQOs5rwC5sLtDQGdpV/ZK
         TW1o1nOPHgPqX1AHof+pYY8AC7g3SJZo1PmYhinnyWQ5TtuQ0WXUl9wi3GUBppj6bt5B
         VTUxmNmstxpNqLKYcAhGPBD6y1JduDplVqUF2t/wUliR0lTx7qEzaMGsdR4wGo1I6wIe
         rulToEnkjOC5Dr8gc0L3w0Z0BhOWxZ96MHtp1SfZ5Jl09SuoMJYHVZ0FRKNMTpEYZnWf
         Zv+LTWLXGgcwRD1ORoTssz4bkJIdroBwDFS+lpZ/H3TbjyhRNlHHLN7JMfJuIym8dSzi
         ktqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=BVS28wLIYj2k7XQDoj1OMeaAKqW4Bmg+uy3xoJk0Wx0=;
        b=ON5VbFtrbpvOQ3AiGG6b/QqsHoc9KQ0IpRv3Ml91kd3dwlwye/CgTBt+4mv0nrJF8k
         6jmaOj1P6OXcTSDx5CvBzS6zFq5nCAFcTmRyCtBmrqNIQ7oFc98cCLtk3kNqFGj6yLks
         scEW6RlCOHSJJQLXasoOF8g0N/43gaJJOirTG2iEyeKbNKC7+ECLn0DgzAgYZgIDPcpx
         N5XQy7BxJwooaeycIYrshl1nnNcaImbDfp+hfKqyNAKDZsT+EGU4qfbgWM1/lNQ++gbk
         9dcxcFR1q1D0kxOVmekeMs4gCnd2S+AGxlZO/hS+gRAnxvh3DBN86XeBZISx2OG5dNRc
         Jljw==
X-Gm-Message-State: AOAM532ERGN4raDULm64kxowgtoIJJDCEu5bk+wjSjLnwqOaP5s5vhf1
        xtj6wlwe85B7xjRbLgQaRgs=
X-Google-Smtp-Source: ABdhPJyGDu1oQxZ/2kwdfzgvkoHBu2eO76N5dExxGVTULF7/Gbwxj36tky3sCQYyi0JS0FFzUQ0pMQ==
X-Received: by 2002:a05:6830:2476:: with SMTP id x54mr1951308otr.293.1623885758620;
        Wed, 16 Jun 2021 16:22:38 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q11sm805141ooc.27.2021.06.16.16.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:22:38 -0700 (PDT)
Date:   Wed, 16 Jun 2021 18:22:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60ca87bca71c1_72512085c@natae.notmuch>
In-Reply-To: <87bl85y15s.fsf@evledraar.gmail.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
 <87a6nryt51.fsf@evledraar.gmail.com>
 <xmqqsg1iseza.fsf@gitster.g>
 <xmqqbl86qtyf.fsf@gitster.g>
 <87bl85y15s.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> It just seems superfluous to me to insist on enumerating increasingly
> obscure and disfavored alternatives to what we suggest as preferred
> prose in our documentation. For example, we have around the same order
> of magnitude of "one might" in Documentation/, I think we should
> probably just fix that and move on, not forever have a guideline agains=
t
> overly formal or "Shakespearean language" in the guidelines.

I also don't see much point in writing guidelines for something that
doesn't come up often, and hasn't come up in more than 15 years of life
of the project.

Does not smell like an issue.

-- =

Felipe Contreras=
