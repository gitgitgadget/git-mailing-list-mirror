Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DB2C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A77611F0
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbhHXNHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbhHXNHK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 09:07:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7C1C0613C1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 06:06:26 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g135so3476928wme.5
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 06:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=gInvUFIFamXN4Q0setfnYbgFIcobo5Nl6j/T+dl31fg=;
        b=VOmKG15m8ro8XzdrJxUCDy0NClLbCA+as0m/FI1ap8RsyrXKPlZVdFsNKJhYKU4feO
         MfhCJw5VHGtP5Ope4K/AtjJM3SqNA4rK/DVZ/rhLU1dojgilS/7N5uxa2N4blZZXtULC
         3ajiItFdxRJ0ZmZBJm88k8GLG+C2XFp1SQzYH6nXCicIRpayIRIRX/B7jpwb7xAP44RU
         4CfXLqjJlyN8AkgQvE9SwWk2VlBW4OFnb5VZ8DtAugjri2wE56qDQN6nDuvNGVD1u2ej
         PDvXnkVeL6p2RbbZKmdjL7BIAiK6oTTPSLwMptpQdEqr/PKsBo+pPQVlPR0FztIkt94l
         Hz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gInvUFIFamXN4Q0setfnYbgFIcobo5Nl6j/T+dl31fg=;
        b=OWtIODJp6rty1PriV4HUkb1Lb3locaGg9LZshpHSwD7aZMGPvi0C+mWE60Bwh9YcgM
         Gh301Tc7anB9HrZfvQfNsmtwDHWNP0wrDLy+v6QWwb30vhO3nYrdQRifDoMmbzFi5KVy
         R5f6ycUYcjgKfHfxhtTtutIJxSKZ0y5XQKU0Q9ES0q+cH9PL3W0ch/xhCkxSy+Gwh9Z+
         /KykgJ/UG7NdPRPbJ/qts/qipx5kJ3LDqDQBGFy8nHzAew1CxdKFadhmbn4e5y1BzJ/A
         S9z18JKWMu/jP4chM6faTFnJ7CARpWawO46vhsJbySEIoZlGt7N1oo2WWCCxI0io4ike
         MVeg==
X-Gm-Message-State: AOAM530zRU6a2+yCyy7GGOmGixVebS32Bksv2asgehLmRzy3xtf0dYIy
        h6ESN6Owa2qoC1ufMb7RpORNCgX084w=
X-Google-Smtp-Source: ABdhPJzSShKiIWRfTB3HMps7Ll0xVlKi/Nla4mjHGprip3VV/51MSFOxJkq1sRaiC/juiQujSUcAEA==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr4046992wma.33.1629810384938;
        Tue, 24 Aug 2021 06:06:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm10642796wro.83.2021.08.24.06.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 06:06:24 -0700 (PDT)
Message-Id: <pull.1075.git.git.1629810383934.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 13:06:23 +0000
Subject: [PATCH] whats-cooking: fix a couple of typos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    whats-cooking: fix a couple of typos
    
    I noticed a couple of typos while reading the most recent "What's
    cooking" mail.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1075%2Fdscho%2Ftodo-tyops-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1075/dscho/todo-tyops-v1
Pull-Request: https://github.com/git/git/pull/1075

 whats-cooking.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/whats-cooking.txt b/whats-cooking.txt
index 09a9916d4c..5c34d18a57 100644
--- a/whats-cooking.txt
+++ b/whats-cooking.txt
@@ -321,7 +321,7 @@ Release tarballs are available at:
  Originally merged to 'next' on 2021-08-09
 
  Bugfix for common ancestor negotiation recently introduced in "git
- push" codepath.
+ push" code path.
 
  Will merge to 'master'.
 
@@ -570,7 +570,7 @@ Release tarballs are available at:
  - Merge branch 'ds/add-with-sparse-index' into ds/sparse-index-ignored-files
  (this branch uses ds/add-with-sparse-index.)
 
- In cone mode, the sparse-index codepath learned to remove ignored
+ In cone mode, the sparse-index code path learned to remove ignored
  files (like build artifacts) outside the sparse cone, allowing the
  entire directory outside the sparse cone to be removed, which is
  especially useful when the sparse patterns change.
@@ -659,7 +659,7 @@ Release tarballs are available at:
  - Merge branch 'ar/submodule-add-config' into ar/submodule-add
  (this branch uses ar/submodule-add-config.)
 
- More parts of "git submoudle add" has been rewritten in C.
+ More parts of "git submodule add" has been rewritten in C.
 
 
 * cb/makefile-apple-clang (2021-08-06) 3 commits
@@ -763,7 +763,7 @@ Release tarballs are available at:
  - midx: don't provide a total for QSORT() progress
  - commit-graph: fix bogus counter in "Scanning merged commits" progress line
 
- The code to show progress indicator in a few codepaths did not
+ The code to show progress indicator in a few code paths did not
  cover between 0-100%, which has been corrected.
 
  The middle one wants to be discarded.

base-commit: ded2f065b417326184f3c71d5d3e8c701ebe3252
-- 
gitgitgadget
