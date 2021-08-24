Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D84C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5D5611C8
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbhHXPos (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbhHXPor (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 11:44:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C17C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:44:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o39-20020a05600c512700b002e74638b567so2618116wms.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FCfvMt3mK/OhvZi20GIPtm8JUpAIiMlrM6Z3YIuWNm8=;
        b=ejin7IODomPJlWQkgef9mNGciIUbQMr0/SD2S8bjlcogFUEmFlwTCy/wTCWpC5WgIz
         UTnD7MX/RP9QVrsVlBaxUHM1OEgayjEkRpvmpDIEGfDfn0ugFcZyCPzP3nV/c5BRjITV
         3UsUy6qJ14I0m4bbyz7Vi/rzJ77/wCqWP3aeUlQFy+6x/r/jAXitUMRNOo5/tGNeWQ5G
         mJsfwWB+cmJbQk/i33Epb1F2b3DwLlqZ1g1O6y6Gdy6b/rjNYJyWcF95SdNUD5+Pdm4Z
         YoxN99dL7I2HSTxmqUxzzb1xVKIgbWPPPA4gZra8AgNTQaOy/Mq3ujuOkNj/ZYp14Mch
         KbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FCfvMt3mK/OhvZi20GIPtm8JUpAIiMlrM6Z3YIuWNm8=;
        b=gFNPpv10LKl8zjKZLkVsZYPpVR/qkcBqRV96cLbrsAnNKDfnFbWSTYvQXj83ueQCLb
         4oja+PMuTnjKE7jRT9hH1mOtSg8MUhAPLnsRVMVEWqzXIk32/p20gqycpMlzYGxkDlMM
         H8VwEvFFu/JUC51J6MzL2uX5BRbPUXcDc0AMx6AwRxPwHVu4hiBL2hltc5AocCJpUYuE
         DdJbunLMGG/w3egILhCeI/xWhpMUo14irgKEvQkWptMOqqXBwc4KrqHzAj1BJhMyJr3e
         z2HdgiQQ7LqFnYGhyJuzxlrv5EzavXVdMlzcxlZEFNcbPpfrE+cH4vdJP+5Ii2tqc5OQ
         bDZg==
X-Gm-Message-State: AOAM532R3Y53OmdxxdcvUAEE77pzkZjs+mpRIhYfaHR/KvwwVWvyddQ4
        AwNbtMA6uU1zfpp+Sx7be+WrSZiEzh8=
X-Google-Smtp-Source: ABdhPJxtMNFP2KO0nDlUd1v4hSmvvKAKqQXmwMOPaFZu5yJs+2XECHV0eQ2ubvXvWA9D0Mvs5owOmA==
X-Received: by 2002:a05:600c:3b91:: with SMTP id n17mr4712941wms.72.1629819841269;
        Tue, 24 Aug 2021 08:44:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm2374766wmq.18.2021.08.24.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:44:00 -0700 (PDT)
Message-Id: <pull.1024.git.1629819840.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 15:43:58 +0000
Subject: [PATCH 0/2] macos: safeguard git maintenance against highly concurrent operations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we started porting Scalar to C, one of the first things we did was to
run Scalar's quite extensive set of functional tests. And there, we ran into
immediate problems in the macOS job because git maintenance was registering
a large number of repositories concurrently, and our code could be more
robust in such scenarios.

The culprit lies not with Scalar, of course, but with the way git
maintenance wants to write the plist for use by launchctl and register it,
every time, and if two concurrent processes try to do that, they stumble
over each other.

This pair of patches makes git maintenance much less fragile in those
situations.

Please note that this patch series conflicts with lh/systemd-timers,
although in a trivial way: the latter changes the signature of
launchctl_schedule_plist() to lose its cmd parameter. The resolution is to
adjust the conflicting code to lose the cmd parameter, and also drop it from
launchctl_list_contains_plist() (and define it in the same way as
launchctl_boot_plist() does). I assume that lh/systemd-timers will advance
to next pretty soon; I plan on rebasing this patch series on top of it at
that stage.

Derrick Stolee (1):
  maintenance: skip bootout/bootstrap when plist is registered

Johannes Schindelin (1):
  maintenance: create `launchctl` configuration using a lock file

 builtin/gc.c           | 91 ++++++++++++++++++++++++++++++++----------
 t/t7900-maintenance.sh | 17 ++++++++
 2 files changed, 87 insertions(+), 21 deletions(-)


base-commit: 48bf2fa8bad054d66bd79c6ba903c89c704201f7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1024%2Fdscho%2Fmaintenance%2Flaunchctl-concurrent-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1024/dscho/maintenance/launchctl-concurrent-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1024
-- 
gitgitgadget
