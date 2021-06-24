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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA083C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0476610A2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhFXSca (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhFXScY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 14:32:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67C6C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:30:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i94so7760497wri.4
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=x3cVfDFX+W/Go4VEmkNtbURAY9smrqJ7fhsa9L42NEU=;
        b=OG4Dv0C/UVlVcIJ1CEeyf8L5H9yvnsEr2/v2FtIwqIn+gSDN8QyqO5ODbvQhYFAExh
         pcQ55oRYyM7IGlf73r1+g7snh4llV+owbNvABM4/ePHQ9VDAA3qaONmZKd6m79saeq8Z
         icsPf3wnEHIxxmituPDlOBsDNA3KSY+hL7EofjkrYii5k0ySbIm8TTkbmfoh/mLn80y5
         zLXskS2Wr9BV2eUDKkbzi/05ItPeYrCzgP5ND6y5/zHE+8mnij1y0Z50lFQsqghO56d3
         +KJBp0iNApUy/cKN1Pk/jjbh7lYW5Y9YRxRXcqDIb+TV1JcyNjrl0WsN0d+cdYaA2qig
         z/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x3cVfDFX+W/Go4VEmkNtbURAY9smrqJ7fhsa9L42NEU=;
        b=QkrRKdUM6zT0hg4IQomIqvZlOI0zA6M1wLGWlpxgF4FfGcWWPAdIPxD/lINV74GyDB
         EaUjbqH1vjuyF3oHErLAyv9wkTK8yBVIwLs8ziLTITTdDYdUyqw9rgYXKZleGEY6H0mW
         mqtZdWKOJA5CJoYJqkAJltrQjqnpcQVzjsJfT9Y0SOUyFxSbWu2QSAwyLE1trDnS/IGK
         ag2ktdcwGRjEzNI9GIPLRTVqaDBVR9qSs9sM71WcqAt+8r0/382wqOTzVShoApE62t3Y
         g6Sr+JY9XWujqDJjNcJl2RroFcvPD1QvnT0vxiv+1NHAWgFhYwHHQsOiryPEyiqH/QOx
         SMuA==
X-Gm-Message-State: AOAM533p5ZeR6zM2orJXFzmiDXXO4rgQXp3Ou8ltkN2fHfeyBg4zA2yp
        gO5KmkKCFT7XvXvt106Kb36UbbIiIak=
X-Google-Smtp-Source: ABdhPJz8kvqUJRS3191dW6lWVMvkxcHl2S2QGuFI/UlgliKf/Yb1KNnyVKS2mhLvHpll17eIl5DQTw==
X-Received: by 2002:adf:f40c:: with SMTP id g12mr6191414wro.20.1624559403477;
        Thu, 24 Jun 2021 11:30:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm3348546wmj.15.2021.06.24.11.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:30:03 -0700 (PDT)
Message-Id: <pull.986.git.1624559401.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Jun 2021 18:29:58 +0000
Subject: [PATCH 0/3] Empty untracked cache performance issue
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset addresses a performance issue with untracked cache. When a new
untracked cache structure is added to the index but remains empty,
subsequent "git status" calls populate it but do not write the index - so
they perform as though the index were disabled.

This situation can be caused in several different ways:

 * Running "git update-index --untracked-cache" on a repo that did not have
   the untracked cache
 * Modifying the git configuration to enable untracked cache, but then
   immediately running "git status -uall", causing the untracked cache to be
   created, but not used/populated (and the index written).
 * (likely others)

The patchset includes fixes to t7519, which otherwise starts failing because
it wasn't testing what it intended to.

Tao Klerks (3):
  Add a second's delay to t7519 for untracked cache
  In t7519, populate untracked cache before test
  Write index when populating empty untracked cache

 dir.c                       | 14 +++++++++++---
 t/t7519-status-fsmonitor.sh |  6 ++++++
 2 files changed, 17 insertions(+), 3 deletions(-)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-986%2FTaoK%2Ftaok-empty-untracked-cache-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-986/TaoK/taok-empty-untracked-cache-bug-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/986
-- 
gitgitgadget
