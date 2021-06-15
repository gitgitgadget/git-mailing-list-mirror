Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A0FC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF44C6191A
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFORLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFORLC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 13:11:02 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A11C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:08:56 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so12668309ott.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=5MCHcKOOLldTfy+LAhMtZsHK9tqQD2FtNbqEfouq1Oo=;
        b=gxYVTxUENaa4wGBsRknLI85WY6j1HWdgXGk6n6weSKIIj/2jgORKD9H6YyRZ62YL+7
         H/fwrgzDdUIOj5ROcXdsG8LpZXXlqacuOVM7acJfA7IYXyMITerqyrjoOUVju6l98p7p
         kVUOZfatU9ScCmyWPV2V8N3H3b0HP34ZZlTn/fYGMPqNrc8OK70GPt3GiZ2qc7gzafJK
         Bvv+iOael8G+XQjvFxEy18c+RLPDXgTD0BmmL4uuq7SCUIl0W8YlJO+Zjv5Wt3eX5ZVc
         wHT4YEmoiCh9oTLCtqGanr/D5ifZQh+cmr1GmXt6bUfFeaKlj0RHXDsVDryiDgPq2sNo
         D7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=5MCHcKOOLldTfy+LAhMtZsHK9tqQD2FtNbqEfouq1Oo=;
        b=QLdF9nOlw4zDW6Oe6IK9qEYbC2/hCEUQqzPUPI7BXrIL+99QCdSxcv5B+XxrJ4STUe
         Xx5l80jIFtsS8x2RCu7V2QHM8gO22nbUW0pKye7p2gr/uw2es1xrX89q4MjciJ0yh1JZ
         xQz8O5ozy9Dr7M+yNcKobBFNqfTUIXbUJH3W5X87fJYDK6bd6DEaOATaSLH3H326oCrt
         Nv1nAaN8pihqMdzpzen1xjM+3tGAek8HeyXwY93Py9+RUr+I2UgRPL4pC61r+iSKbs9d
         tRnig2iSteAoSRjAUswWsTlcetAi2pSxjwrL2mp/OI/Y5FdcGSWxh5iFTazeAp01ZJFy
         BRJA==
X-Gm-Message-State: AOAM53302gbv2ym+fG+2TPxJBSeU1xwAPeFrHjqzF61lutm/hscbb9gw
        ffFIpFEtKtFkNdmpdJk7+lI=
X-Google-Smtp-Source: ABdhPJyB/iIjfY/UICc2yPmP9Wh2+zBGqccnykxdc54Qi0hXE6c+hP80Fqnb3hJlgzNwuwVq7rW++A==
X-Received: by 2002:a05:6830:22cc:: with SMTP id q12mr255800otc.202.1623776935764;
        Tue, 15 Jun 2021 10:08:55 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l19sm3937600oou.2.2021.06.15.10.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:08:55 -0700 (PDT)
Date:   Tue, 15 Jun 2021 12:08:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
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
Message-ID: <60c8dea5ef999_12c2820871@natae.notmuch>
In-Reply-To: <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
 <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH v3 4/4] CodingGuidelines: recommend singular they
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Technical writing seeks to convey information with minimal friction. One
> way that a reader can experience friction is if they encounter a
> description of "a user" that is later simplified using a gendered
> pronoun. If the reader does not consider that pronoun to apply to them,
> then they can experience cognitive dissonance that removes focus from
> the information.

The gender of the reader is never specified.

The documentation doesn't mention users in that way, only third-person
developers, reviewers, etc.

The code mentions third-person users.

Never the reader.

So it's not true the reader can experience cognitive dissonance when the
gender ofthe reader is specified, because we never do that.

Do you have an actual example?

-- 
Felipe Contreras
