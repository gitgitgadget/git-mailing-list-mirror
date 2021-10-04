Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81042C4167D
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760666103B
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 00:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhJDAsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhJDAsM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 20:48:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E933C061780
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 17:46:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s198-20020a1ca9cf000000b0030d6986ea9fso2162897wme.1
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 17:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mReH4798/aXY2sjYDQgIWxChOSmQ7Mc1m37pt0wf3KY=;
        b=e3HVO+UQO0iGpKiDtU+WVp8E1C87ooGWde1QqaLcGbPyjqzdoBlyS7zAB/5Fuhi/w2
         AN+KM1NWRaQ/HnkxXoAwlCoe3RjGS0LL42y3d9jRlLnTzmC/IVUMBqgw4akvAeVi6CrG
         HsSV3L2UiG1mt4IXwQ2nSwvUt0XASJ+fe/htKRQ5Pl0hfqqPtk6sl6fBRsKSiAaYD3UP
         ojmtsZnhzm+wn6+WOjuXQBCYxfRUCLvl6krqGHL5i3f2b066iyAVBuBmAQxQ/L+uneVc
         RWIAeS2e2Co7BSaiVhpUZ0LqKd+Xhu5k/v/fldnp5LImPzwmzlClu90kNsKFiPYGiFOO
         lvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mReH4798/aXY2sjYDQgIWxChOSmQ7Mc1m37pt0wf3KY=;
        b=i1NOdEAAR3LERAGcNE++nC55q2DOfFchC3pwXFMcjvvj7f6cPotTXsb9d5E61O2KQW
         9ZRN8+DSsBnYRxBSVlW1sJxZSc4bTZ909Htg5puCssWgz5sDLQfmb+nUDqS8NBWCFwLw
         vn5sUdAdGTXSFLs8YoBYaHVnZISzawaGmuncHZGM2K6KLBrjF3sJoT4ZY9ZnJTPYnxCi
         8w8a2Dgj5Y/9J9mv7lO80ozlaG3E0IjjJAryhGRNVM7U99bS7WF0ahjnEFf3jDLeVdZJ
         w4O97y6QkR8h18x5PLHCF22Sa3QOSN6BPccNU5HzpHgC389gXyTKyKI6m4EC4BqVR/vj
         rdbg==
X-Gm-Message-State: AOAM533g/yCeWtAOkFRni0IPZXX9f8sn6wksly0M/3CCrDQ3JFFF4Exp
        BKeur2PcxwwumAil59rU++NhLv1m7tpGYA==
X-Google-Smtp-Source: ABdhPJwaZylArgXxvduuSKwSkaCJiV9kepVUuy1yRTq7uFEuvBbhwWfYfPrWPYy0txXxE1MQrJBLAA==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr10620164wmh.163.1633308379558;
        Sun, 03 Oct 2021 17:46:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7sm13526773wrc.55.2021.10.03.17.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 17:46:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] dir.[ch]: make DIR_INIT mandatory
Date:   Mon,  4 Oct 2021 02:46:06 +0200
Message-Id: <patch-05.10-042080b8d6d-20211004T002226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dir_init() initializer has been documented as being mandatory
since eceba532141 (dir: fix problematic API to avoid memory leaks,
2020-08-18), but both it and my ce93a4c6127 (dir.[ch]: replace
dir_init() with DIR_INIT, 2021-07-01) managed to miss this callsite in
"add-interactive.c" added before those two commits in
ab1e1cccaf6 (built-in add -i: re-implement `add-untracked` in C,
2019-11-29).

In addition my change to remove dir_init() neglected to update this
documentation. Let's use "must be initialized with" in reference to
"DIR_INIT". We have one lazy initialization which pre-dates
eceba532141 in dir.c. Adjusting this callsite is a prerequisite for
removing it in favor of trusting the macro to initialize the "struct
dir_struct" correctly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c | 2 +-
 dir.h             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 6498ae196f1..27daea8d1b3 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -826,7 +826,7 @@ static int get_untracked_files(struct repository *r,
 			       struct prefix_item_list *files,
 			       const struct pathspec *ps)
 {
-	struct dir_struct dir = { 0 };
+	struct dir_struct dir = DIR_INIT;
 	size_t i;
 	struct strbuf buf = STRBUF_INIT;
 
diff --git a/dir.h b/dir.h
index 83f46c0fb4c..ff3b4a7f602 100644
--- a/dir.h
+++ b/dir.h
@@ -19,7 +19,7 @@
  * CE_SKIP_WORKTREE marked. If you want to exclude files, make sure you have
  * loaded the index first.
  *
- * - Prepare `struct dir_struct dir` using `dir_init()` function.
+ * - The `struct dir_struct dir` must be initialized with `DIR_INIT`.
  *
  * - To add single exclude pattern, call `add_pattern_list()` and then
  *   `add_pattern()`.
-- 
2.33.0.1404.g83021034c5d

