Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05387C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiI1Im1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiI1IkS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09835A6AD2
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id iv17so8047324wmb.4
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1D9asluIC2fxF8SEKZoTgE+FxMRRgL2SUCzcDFFW5IM=;
        b=jbU5GY44tTcLN7+ZUpdAcOVty0DD19IOFcAU9EeE7XbixVibNpFNtOGrbDc/t5B3cK
         AsCMOLEkq+A3gBmbLiUMFXXEN1o9z76PrDu2J5csLUTjlZicbiJr8qiuwa2OolwfQrwr
         HF8ILcd/Wl6/hF8a6jIebXHclSxQuWhqqM3I3xs/y99MLYEWu6bn+HM4ix12AVnKIj0f
         YZ8iTMdztRaTNHQrSLZT75ZzOZXzV6CtKebbWjktUCm+Pu0O7CtZaHv02PHDS0p6KBat
         oA160mCr0AzR1kkW2SJYpqXNfWvk+EtidTaN2KkmE9HgmbGRtw8ZpEH8OKAV2yVq0ArK
         s1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1D9asluIC2fxF8SEKZoTgE+FxMRRgL2SUCzcDFFW5IM=;
        b=zhhU8I1s7vPz2A4C/JsuI1yKF8LTUNWBpy2PHnudaXLWsu7I9fmcgddpB/cHJ0pmJQ
         mkTKZmmQSI8Hcf8zpI/Q8isGanwK0gHgUXqF9GeG7OxkXqL9LOAX8umahoqTP8BsM35M
         n9HSuCPeF49RUqnb6AUkVuQOCwncPGymu4oYqooPIgtSK16Qa5ST2OI/bBgoIbbRXrqd
         H1maDd449Yk09x/+4ocvFjjODN/op0l3dR8LS9FnViXydlBREWqOLCPir1bVt0q8fNct
         9RDa9193spQdZrci/oxYPje/ygJSbTkDFT+po5IzkfbDHCoNMAK7IUxkWTu2pUlKwe1g
         /KSg==
X-Gm-Message-State: ACrzQf1z3ZwoYUNd3FUZz9UX4uaSrdlai1waIvr701xhIQ9gPJDN/bOm
        m7hOgFbO5i5/gh+DOz9Dxipfhz7aUDBNIw==
X-Google-Smtp-Source: AMsMyM5jq/+4k9AOfTRTikkq5lwLOb75ipNuZUHdDi0Q4Z9f/mntIjsfiT0ppYEXD+8vmEEM2+1D1w==
X-Received: by 2002:a7b:c4c7:0:b0:3b4:62b6:b54c with SMTP id g7-20020a7bc4c7000000b003b462b6b54cmr6036758wmk.89.1664354411439;
        Wed, 28 Sep 2022 01:40:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:40:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 33/35] doc txt & -h consistency: make "worktree" consistent
Date:   Wed, 28 Sep 2022 10:39:28 +0200
Message-Id: <patch-v2-33.35-a63d8017381-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "worktree" -h output consistent with the *.txt version.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/worktree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index ba6846c3788..4a24d53be15 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -16,17 +16,18 @@
 #include "quote.h"
 
 #define BUILTIN_WORKTREE_ADD_USAGE \
-	N_("git worktree add [<options>] <path> [<commit-ish>]")
+	N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]\n" \
+	   "                 [-b <new-branch>] <path> [<commit-ish>]")
 #define BUILTIN_WORKTREE_LIST_USAGE \
-	N_("git worktree list [<options>]")
+	N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
-	N_("git worktree lock [<options>] <path>")
+	N_("git worktree lock [--reason <string>] <worktree>")
 #define BUILTIN_WORKTREE_MOVE_USAGE \
 	N_("git worktree move <worktree> <new-path>")
 #define BUILTIN_WORKTREE_PRUNE_USAGE \
-	N_("git worktree prune [<options>]")
+	N_("git worktree prune [-n] [-v] [--expire <expire>]")
 #define BUILTIN_WORKTREE_REMOVE_USAGE \
-	N_("git worktree remove [<options>] <worktree>")
+	N_("git worktree remove [-f] <worktree>")
 #define BUILTIN_WORKTREE_REPAIR_USAGE \
 	N_("git worktree repair [<path>...]")
 #define BUILTIN_WORKTREE_UNLOCK_USAGE \
-- 
2.38.0.rc1.925.gb61c5ccd7da

