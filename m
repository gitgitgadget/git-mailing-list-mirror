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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EDBC432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4916460FA0
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhHCPfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbhHCPfi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:35:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE752C0613D5
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 08:35:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k4so14964827wrc.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=orxdWDoDW6Mkyzypekhi5kd1qSdh25358N+ckFh/UCA=;
        b=q3iyGyMsntgkkVtWWLLsGSMUCBpMa37lTf6uj2z6Di+sG4KFncA++nD4fI3WNqusrB
         ebORqD9BYj3DUypp7ntYVV2YmWsrum2pJ1j07b0yRQTHli1EE4zbYeR0TkfSgTjLI87v
         vMzTi34GfrzIXacShIvpq3jTuver7gR9jNvdm0abbSSUfy7ffeRN65KD3ZaR2R2y6beR
         tKvConZCYuX6wSC+k6/4VwEWshQ7SC1lI5yIvPAeyNz6mUdsUzGhLfHjRwk/gWwrWWmg
         Pg6z7NjuPhJuj6Vh8plCpQvcFDuu6w7OMKvODdPs65uxorjk0SSSe8XNjFLTccS+Lk22
         ncLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=orxdWDoDW6Mkyzypekhi5kd1qSdh25358N+ckFh/UCA=;
        b=Hrewglm0/CIgPks913hqdmcoq5Kn8uE2pjeR7KtZ9Pda9SIjy/UmCtCVoROqoBeWC6
         N+qrz2ofsdZkw4xfkNA+7KYk3JTiUHMopOukiFlI40vfUJRgfwedDWp3f6SooLiVDpz2
         wTFY79Mi40s2QHDhKVP0JTat3WQSg9hnlKLc0b4DJl9dnpmQwVG/X4Qn3pXS9bHbfBUi
         CFMvDRPftDnU/xGp4VG4oaL/3mum1ybSdCza2WH/Lr1q7XVehgs/Q5+NiXwhXp1gPeLK
         LWNJnGXbU8m81l1SeDXhG964T0KmXt3QOX3jE3B5X5GPv/oROW5dxk1FMhSeejXHJBdN
         CCGg==
X-Gm-Message-State: AOAM530lw630bZntiW317Rj+4C6FcPofSbO3oentUCSncGFSXZaOTEm1
        nKRhbDQ9zkd3UZVU28uwGCQrOLxHsDU=
X-Google-Smtp-Source: ABdhPJwp4QZ+RCaaX7835kIsutmIPKjHjfCLgCK++G1nvr0MGIFnkb6wUH3+qu92gz4yYrZD3C7rKg==
X-Received: by 2002:adf:ee08:: with SMTP id y8mr23426971wrn.299.1628004924531;
        Tue, 03 Aug 2021 08:35:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15sm14424574wmj.11.2021.08.03.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:35:24 -0700 (PDT)
Message-Id: <6b89ab8d9b1c03ce97fab73f7a2b4261fd90c0c4.1628004920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:35:12 +0000
Subject: [PATCH 02/10] directory-rename-detection.txt: small updates due to
 merge-ort optimizations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 0c4fd732f0 ("Move computation of dir_rename_count from
merge-ort to diffcore-rename", 2021-02-27), much of the logic for
computing directory renames moved into diffcore-rename.
directory-rename-detection.txt had claims that all of that logic was
found in merge-recursive.  Update the documentation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 .../technical/directory-rename-detection.txt       | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.txt
index 49b83ef3cc4..029ee2cedc5 100644
--- a/Documentation/technical/directory-rename-detection.txt
+++ b/Documentation/technical/directory-rename-detection.txt
@@ -2,9 +2,9 @@ Directory rename detection
 ==========================
 
 Rename detection logic in diffcore-rename that checks for renames of
-individual files is aggregated and analyzed in merge-recursive for cases
-where combinations of renames indicate that a full directory has been
-renamed.
+individual files is also aggregated there and then analyzed in either
+merge-ort or merge-recursive for cases where combinations of renames
+indicate that a full directory has been renamed.
 
 Scope of abilities
 ------------------
@@ -88,9 +88,11 @@ directory rename detection support in:
     Folks have requested in the past that `git diff` detect directory
     renames and somehow simplify its output.  It is not clear whether this
     would be desirable or how the output should be simplified, so this was
-    simply not implemented.  Further, to implement this, directory rename
-    detection logic would need to move from merge-recursive to
-    diffcore-rename.
+    simply not implemented.  Also, while diffcore-rename has most of the
+    logic for detecting directory renames, some of the logic is still found
+    within merge-ort and merge-recursive.  Fully supporting directory
+    rename detection in diffs would require copying or moving the remaining
+    bits of logic to the diff machinery.
 
   * am
 
-- 
gitgitgadget

