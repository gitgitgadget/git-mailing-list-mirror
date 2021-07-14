Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A36AC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B166101B
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhGNWMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhGNWMc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:12:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C51C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:09:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso4172795wmc.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kkq1OTrVwUX553SYnFqENeq+YZm+9D18wlYw2yr0ih8=;
        b=ZvkIvsjpFkpgISTZR8CzXLyA8cxwQX6A5hj6WwW15GE2Swnru7GA7hlTAvNRQIPsrD
         a5hjFxSFfzw/6y16XMNTO48l6cAMLlfdyHK5SwETmBAxxDktWM8nSoDaxNeKpFIc4qrd
         xqUQjP59STldXVQTCyyMw1Gguys7raMcOsQb7YqL0xHF/6o7LdSCrpCiHlTG+pdntT47
         CJDg/nH2ynTbmNsU5icpYqvMrkDUkigesdzcgyIzg3zY61h/ll4wXju4r1yRIK1+djAH
         rLDSwkWc/gVYB5BPtS8ff5kMQgAWLJjARDocNDBKyTT+OHRyE2NcPR4fL2oyqJ7xBAMl
         f5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kkq1OTrVwUX553SYnFqENeq+YZm+9D18wlYw2yr0ih8=;
        b=Z/23FCD1JdPQVbEZVVbCEOaa9XnpbsP542WnEN//kBFeIiQ9RtksAqTAPChnGzHUu8
         igEWjl71zhBRD4U45ZdmVw9I1d8Kzr4SjRW+yPyPXLvEWhn8C6YNN3ieEXgbQ9m7S07Q
         ldxmNVUnfM+8KsrS3ZbsAE0RKL4rAkcjDvDIhWDONrTBUnzdMxbD+Ct8PnNFC1elVjAk
         TMcQ9gzENeJBwVqiAvJF7VWeo7EXm33+m+C6WVvpI7aaBlR08hSCTfI+Xfg2NELP97zR
         8DIE7B7Mzwv3gPr7nK7KkcTKPYlSGHHudIgIaId+7rMx+HYm9qTP0pvZBZLHJCOq3CG2
         AXCg==
X-Gm-Message-State: AOAM532LaVtcIh+42JlCRU/3JyEw7hTSyZjn5Rp+p5+C2kyA6gJxFPbP
        AimygDc93Qs9BsbAhy8JAKRlwQOH7Aw=
X-Google-Smtp-Source: ABdhPJzOhDvbBUGPy8WetkmTmxIRmdffiCRo1uwuNiB6cSPCIIk/l7QVAE9wuX73hvh1OoSkTyjIfw==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr6288877wmm.95.1626300578817;
        Wed, 14 Jul 2021 15:09:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm3938411wrq.92.2021.07.14.15.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:09:38 -0700 (PDT)
Message-Id: <pull.995.git.1626300577.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 22:09:35 +0000
Subject: [PATCH 0/2] check-whitespace: two fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Chris. Webster" <chris@webstech.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently ran into a situation where a merge commit (which admittedly are
undesirable in git/git and gitgitgadget/git Pull Requests, but are sometimes
totally appropriate in the context of other forks such as
git-for-windows/git) misled the logic in the check-whitespace workflow to
look at upstream commits (and missing some patches that it should have
looked at).

At the same time, I also realized that the feature where this workflow adds
a PR comment in an attempt to be more helpful requires a read/write token
(which weakens the overall security, I'd much rather stay with the read-only
token configured e.g. in gitgitgadget/git and in git-for-windows/git).

This patch series addresses both issues.

Johannes Schindelin (2):
  ci(check-whitespace): stop requiring a read/write token
  ci(check-whitespace): restrict to the intended commits

 .github/workflows/check-whitespace.yml | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-995%2Fdscho%2Ffix-check-whitespace-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-995/dscho/fix-check-whitespace-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/995
-- 
gitgitgadget
