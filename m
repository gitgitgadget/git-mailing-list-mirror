Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35071C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F9B22B51
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbhAXCfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAXCfR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 21:35:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B62FC0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:34:37 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c13so1297734ybg.8
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fstTqJayJawAliZkXzrcNnQbmdMSyQMs1hc6MU8eGyE=;
        b=mNQrOcSjaf1UnePWRqsOtSv6uCOW2CMIDkL2dBA5usPRDGyB1l/KdrJNa7rMi7yHAi
         CKdeLblD17LzBUQfFQtzdRBgBGln/dhQOwz7nOtRx6lekMXsBrmchb3fKv0I3/x658+c
         u3H91/yWHfUcwvQg94NlUk2KNPIgY8BxRID7PxEb9+iowrsZP5NL+sLcD2iy5HbaOMrL
         o+ISJQ1tDSsSVpIPjYrIyk/QIb04TKR37wsSikXUeKII/IjwdVUC1oxoexDrS67VjKcq
         cVnyNJh3P4VZYPgXSLexMUvVOtGtQn26s0CXrG2sv0e0pIhw0X9tPbMPh/4kS03RycCb
         kLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fstTqJayJawAliZkXzrcNnQbmdMSyQMs1hc6MU8eGyE=;
        b=V9RUwVAT+BO+lxF3j1CzkKYvH/jyk6I6Jxb3vYMakFOymARAflv11pKrmdgtPLtRpG
         gueC+KkXvKmB3C/RXfI6lRwU8kwvRgy3EwNXkCG8w6s1IGP9K/53L5M/ScXSbPWWa4kh
         cdpRvW/kRgaq6Yrb7UonXPGUUV4VFTyZWPWE36bDmV491/pt265UETxeRA3zrzcXec9p
         aR+29qPz3rTSDVtyC9ibk65Twt//y8HjCvfMF2Ye7Vro+YaEuHDQGoOvRfoKKTZu159U
         I8y+lX5MwDobuQiaEO8uXoC9WFAQiOMSQSL0KTgG8oN744vyZ0X136VLsU5FHKG++jCE
         39aQ==
X-Gm-Message-State: AOAM532pv/uFPX3/6UC/EWFI2lVMzya1tGzXfLpmKG+tEneNWNOgypwI
        JK/QZO0UYTwaun7BdH/IT2cUul6cS0fNbuU7YifjbmaR0+FWc1ynPTJTuqW9lO/jvo2CxjNZs4Z
        7iUh18HX5F2pjwwPxvIb6CbS6wQc3wlSPtZ3hRCWD9MFyPhrX6V56xjbUJ73sbTFwmJNXNtbDMW
        YF
X-Google-Smtp-Source: ABdhPJyo9bCE5w6F0Bfip3fqR2prrwsx+EyGaKkAreWWP2PhGdj/+VQkb1AOKkXAgbp9DrGTbQ5/7dZOdOdOuv754UBd
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:9242:: with SMTP id
 e2mr16099146ybo.405.1611455675145; Sat, 23 Jan 2021 18:34:35 -0800 (PST)
Date:   Sat, 23 Jan 2021 18:34:26 -0800
In-Reply-To: <20210115234300.350442-1-jonathantanmy@google.com>
Message-Id: <cover.1611455251.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210115234300.350442-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 0/4] Check .gitmodules when using packfile URIs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set resolves the .gitmodules-and-tree-in-separate-packfiles
issue I mentioned in [1] by having index-pack print out all dangling
.gitmodules (instead of returning with an error code) and then teaching
fetch-pack to read those and run its own fsck checks after all
index-pack invocations are complete.

As part of this, index-pack has to output (1) the hash that goes into
the name of the .pack/.idx file and (2) the hashes of all dangling
.gitmodules. I just had (2) come after (1). If anyone has a better idea,
I'm interested.

I also discovered a bug in that different index-pack arguments were used
when processing the inline packfile and when processing the ones
referenced by URIs. Patch 1-3 fixes that bug by passing the arguments to
use as a space-separated URL-encoded list. (URL-encoded so that we can
have spaces in the arguments.) Again, if anyone has a better idea, I'm
interested. It is only in patch 4 that we have the dangling .gitmodules
fix.

[1] https://lore.kernel.org/git/20210115234300.350442-1-jonathantanmy@google.com/

Jonathan Tan (4):
  http: allow custom index-pack args
  http-fetch: allow custom index-pack args
  fetch-pack: with packfile URIs, use index-pack arg
  fetch-pack: print and use dangling .gitmodules

 Documentation/git-http-fetch.txt |   9 ++-
 Documentation/git-index-pack.txt |   7 +-
 builtin/index-pack.c             |   9 ++-
 builtin/receive-pack.c           |   2 +-
 fetch-pack.c                     | 106 ++++++++++++++++++++++++++-----
 fsck.c                           |  16 +++--
 fsck.h                           |   8 +++
 http-fetch.c                     |  35 +++++++++-
 http.c                           |  15 +++--
 http.h                           |  10 +--
 pack-write.c                     |   8 ++-
 pack.h                           |   2 +-
 t/t5550-http-fetch-dumb.sh       |   3 +-
 t/t5702-protocol-v2.sh           |  47 ++++++++++++++
 14 files changed, 232 insertions(+), 45 deletions(-)

-- 
2.30.0.280.ga3ce27912f-goog

