Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5792C47257
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD06620735
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq/NF6c+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgEEQ0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730282AbgEEQ0x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:26:53 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1360EC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:26:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x2so1110548pfx.7
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmPfAOtHAu2lxxvqqfx0KXwy/cGvKABDDTfwq0z9JLA=;
        b=iq/NF6c+fU6uA0oL6ozwqfgVT756YDlvHSMBSZliaLB6Ft9bv4mAKs3hEMlE6PytKG
         wu/iB5PZuzAhA0N1PabBlsjJ3mplqCAWWqVRMOSDOdmtuZoa6OKdllaUuaGyRFRI5yo0
         K+OxQqAaCii1u2PaMEWUPwVIR1qrMplFa51ApwIT0oapfysHc0Y4XV2KmVYbgFjKda8i
         Bh+CgE+pOPwRfexJvhXIgxs9JB0cpeyNNK9l6RliFsjzmXIKJYS87VT5qK6wXBO/ZKCo
         hJ0n0aUF39wNKLSJb0RLm7opMy2IvkpyA6FI9lSBK4iqueiNCAmiJ8daOEwImbjEr5aA
         jbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmPfAOtHAu2lxxvqqfx0KXwy/cGvKABDDTfwq0z9JLA=;
        b=Txeb0z5sJMr/wNh6A6ukh+SpRy6A8ExrbCxzyFjJPEVTkv9B7qjNCwlXVAkjFcTKEU
         wS+rqvdvR+yyxcanj8+kbx8nNwochUPhyW5V+olZ7g6aaB4pP3pjhLYK7ZiCRbVgDqC/
         9Aj8U3kd6Bj8HSZnE6vYY0AccSDZzMcsDo86RyKv9Vj8gGPomgVJnI77sO5DFTJSmfkU
         jx/D5bhybxhNHpXjIsjk9PfRTV9ZDekRE/ozXbQKL2QeZ3/XQHN/MhEri/3pErPCkyIk
         m90z8oY6qBPZjyDXzfQwGt/c3qtrswqPcS5U2ab50doL5+ivL5Xl7gNVdKszvMyRCKTV
         KetA==
X-Gm-Message-State: AGi0Pubxc1GQZFJmJav1O6N62o7VL7DqRDQHueZ0KddRO1OXjWGQ9ztC
        agcdMy/RR/+HkKjGlsi7szMehbqi
X-Google-Smtp-Source: APiQypIJ3bXw1zi09WwVon3Z3UZ2P6gwfhLnjqqe5A909+3r3zWoyZ7aWgqV29UM7CHRg/MZpQwyfg==
X-Received: by 2002:a63:241:: with SMTP id 62mr3359368pgc.38.1588696012277;
        Tue, 05 May 2020 09:26:52 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id l37sm2508996pje.12.2020.05.05.09.26.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 09:26:51 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/3] CI: limit GitHub Actions to designated branches
Date:   Tue,  5 May 2020 23:26:40 +0700
Message-Id: <a4c6f687c0a8ce55863a19a1c4048438f02803b5.1588695295.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
In-Reply-To: <cover.1588695295.git.congdanhqx@gmail.com>
References: <cover.1588607262.git.congdanhqx@gmail.com> <cover.1588695295.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's maintainer usually don't have enough time to debug the failure of
invidual feature branch, they usually want to look at intergration
branches only.

Contributors now can have GitHub Actions as an opt-in option,
should they want to check their code, they will push into designated
branch.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .github/workflows/main.yml      | 14 +++++++++++++-
 Documentation/SubmittingPatches |  3 ++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fd4df939b5..9bba0ce068 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -1,6 +1,18 @@
 name: CI/PR
 
-on: [push, pull_request]
+on:
+  pull_request:
+  push:
+    branches:
+      - maint
+      - master
+      - next
+      - jch
+      - pu
+      - 'for-ci**'
+    tags:
+      - '**'
+      - '!**wip**'
 
 env:
   DEVELOPER: 1
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 8686318550..e516b080df 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -79,7 +79,8 @@ test your changes on Linux, Mac (and hopefully soon Windows).  See
 GitHub-Travis CI hints section for details.
 
 Alternately, you can use GitHub Actions (which supports testing your changes
-on Linux, macOS, and Windows) by pushing into a branch in your fork
+on Linux, macOS, and Windows) by pushing into a branch whose name starts
+with "for-ci", or a tag whose name doesn't have `wip`,
 or opening a GitHub's Pull Request against
 https://github.com/git/git.git or a fork of that repository.
 
-- 
2.26.2.672.g232c24e857

