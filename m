Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41E9C12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789A86120F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 12:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhGULpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbhGULpN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 07:45:13 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB3EC061574
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 05:25:49 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r80so2604125oie.13
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SqlAERPCy14te1XmD689X602PG4zqwodqL9XWECjeIU=;
        b=Yg4R7zFLXVkchyaZp8hyvlYMdBZFKK8s2IF86ceu/+98nfVIsuSe9zWfWWvFaKOCPI
         uqNBO4t+u6kXRfK6sm5vzc5sWaj9yA8B8OrwG1XwE3TQBxJSLZLJHqaurekR7ezJ0cip
         w4rSLvz4sLEv4sFj+Ss3bEbchdeV7LGozhvdF1yC86Rwoq9x1i/57NQdBQXMRuY7ivTB
         mSVf8lNwDWE3GyR+lr4ZIzgknseK1Q2RTaX9dvBmarXdWzq1esSQc7onzGnrAUqOoW36
         nF3ihluFO727X/e4tQc42YMOPJIe1obBK1qReZBHaEzcJ4yG1Rl1+4frX67oZS51aFRq
         IoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SqlAERPCy14te1XmD689X602PG4zqwodqL9XWECjeIU=;
        b=O9ayRhUZ4fsWIuus12j16ww6Ex5/ugPZiqQ1vMX8PykENPDHHhopShNx0+IvQ0oXcF
         jaGD0Cl39pb4JhWgga3H4C+Tx7lik+ajHdAidkZAWcdnK5Gw1FBPWcnBag89nmHEjsdY
         aWB7x15N+lj9kz5xiZTMVIhnx9JEPwqa72eQyqBUkHx4Uy48iWOYDH2fqM/oBx7uYslY
         jwzbgAHHI1R4rDkrXYtSdJ96Cdg7Ys+TqiUF8Xz5f9MUZKWSAInZJBJy01nE1dJbHbX+
         UMiFzmZfec7Y9UCUB7QJkm+AJ8B1dcxIPD+YXtCLhrdyj1Cf6CgYNzLvWT/npCNAO4Iz
         U/7g==
X-Gm-Message-State: AOAM533m+68SoQiC/QCoXRdxVHwqz2tQi6IHD6HC6aYuVvwBUeHrjE1Q
        dbpaJB2RLyXvaWZfvmpgDo4=
X-Google-Smtp-Source: ABdhPJytkh7t9PDWCoIavpDA85JWRORbr2qA7s5BG4nhLrWztBDb/ph6UB4+iTP9N1aI1V+3IaH8nw==
X-Received: by 2002:aca:1215:: with SMTP id 21mr2392743ois.37.1626870349098;
        Wed, 21 Jul 2021 05:25:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id j5sm4407631ooo.22.2021.07.21.05.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 05:25:48 -0700 (PDT)
Date:   Wed, 21 Jul 2021 07:25:47 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Message-ID: <60f8124b341c2_1305dc2081@natae.notmuch>
In-Reply-To: <c45cd2396664e915a1d962e6d131505df51b118e.1626831744.git.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
 <c45cd2396664e915a1d962e6d131505df51b118e.1626831744.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH v2 3/8] pull: abort if --ff-only is given and
 fast-forwarding is impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie via GitGitGadget wrote:
> From: Alex Henrie <alexhenrie24@gmail.com>
> 
> The warning about pulling without specifying how to reconcile divergent
> branches says that after setting pull.rebase to true, --ff-only can
> still be passed on the command line to require a fast-forward. Make that
> actually work.

This is a backwards-incompatible change.

-- 
Felipe Contreras
