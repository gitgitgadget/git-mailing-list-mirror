Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA46C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 429FE603E9
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhJ3W1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhJ3W1G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E961FC061767
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p14so22269436wrd.10
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BX73bFuClGimNX6Xmrzu0++aLbQxYTZ08XQ7pyHOvO4=;
        b=QHfi7Pc5ZOAKTdhViEIPfd2eAR4+oGZUO0ktiOuEYnd9Sjbo0RpCb9XvUsyrfedbFu
         uSC/vJSE2F7kYs9u4nI3H7ocXWL8ALwGbuQ9MaxLgck22SKypbfhWuno9epeoq/1fCYX
         B8JehlGEDrMwVi8hYrBxYQDqczExG0kITsTCyWHVy0mfu7dIFFHt+QgSwCImAntrArm9
         iPerafoVcCYZ0y6tFJq1wuijaVdf3zCxMDIa2j5d6lMpv90RCzvlSjyAH9hiAT01enic
         w81HNsThRLN29nfdW6fh1kg0GUT8IOfs1h6079x7VGNycPc02rLxA1LdwCFjlaCNNQTb
         T49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BX73bFuClGimNX6Xmrzu0++aLbQxYTZ08XQ7pyHOvO4=;
        b=Ar98s6lX3v0pZlZkyYeReLWIEkbPkOVYIbJggu7Jqgn50eb6IcaKpd35LYFh9qugrI
         37COIS/X8/IAfJUp1h6u5wUOoqINppLPyYsCJ0hWheAGyBYk9jfOKyqO1T6oa00m0vCu
         2q2FcqyXL6IvBF0ll4WA4OaVsQSsHPU7XFYB65VQXNyI2gQpNYkbFu2/tF773NR93i0S
         n/i54dezoTe+CB0ugzwLihTldFNBGR0s0U3Lw0HHzKrmXcgF4szt2MANv/FxH0KlBeip
         VxC6iGbdIEAqFf7oPVCfHTWkJZszqquYPr28PoZr1G2SfWoSjyvytMrXtxGpXohg86Ak
         6m2w==
X-Gm-Message-State: AOAM533vJJ74Z4CjOtalibeVto2QtaIOJUEbDXkk0AJPYcQvW1KCLkRl
        9V7hmxrXXkMmgPnER7hncsXGjQNmSRMz6g==
X-Google-Smtp-Source: ABdhPJzfJ1b8WwLGGm1Po0IZkulJ39IH3dxote34YlhkoMy2x+TygfkwYcUpsVlEnTlt6nFc4brSUQ==
X-Received: by 2002:adf:a152:: with SMTP id r18mr25980697wrr.317.1635632673344;
        Sat, 30 Oct 2021 15:24:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/15] leak tests: mark some notes tests as passing with SANITIZE=leak
Date:   Sun, 31 Oct 2021 00:24:17 +0200
Message-Id: <patch-08.15-72d7bb5cccf-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*notes*" as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3302-notes-index-expensive.sh | 1 +
 t/t3303-notes-subtrees.sh        | 1 +
 t/t3320-notes-merge-worktrees.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index ef8b63952e3..bc9d8ee1e6a 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -8,6 +8,7 @@ test_description='Test commit notes index (expensive!)'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_repo () {
diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index d47ce00f694..f5fd80d4d3f 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -5,6 +5,7 @@ test_description='Test commit notes organized in subtrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 number_of_commits=100
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 6b2d507f3e7..bff0aea550f 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -8,6 +8,7 @@ test_description='Test merging of notes trees in multiple worktrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commit' '
-- 
2.33.1.1570.g069344fdd45

