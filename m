Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D1C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 21:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E34D2088E
	for <git@archiver.kernel.org>; Thu, 28 May 2020 21:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4uqWlpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436515AbgE1VX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 17:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436505AbgE1VXT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 17:23:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE540C08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 14:23:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l26so679751wme.3
        for <git@vger.kernel.org>; Thu, 28 May 2020 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=W7fIRq65sQiLkyjxcL6rdITG8jr033f6ASzjpQNDIl8=;
        b=e4uqWlpzdC1mtdjuAYn3wUCx7P8RU6EKKLV+i9abZB0OHdSnPaEhK/DYzaOezs6tZu
         Fc1tymdlu8Z1gypDL91v07TZcbdhJawrpJWHTw6SkprDlcM2xIEnhYsdMCG4XmfKKFIP
         HsJcNHmIkl8PK5EPAd6Uyn7wAux7ltpZCH14ZzW7ooSi0jzxGWUHUxl6whhY9lJsFkR7
         nv4QAPj1weqZot7JiXL8hEFg70vvPe381V6ouV1911Khv9E8tq4xREQOwfuxOu36VfJd
         Va9UgjCSuhOQknWgIaW/MytHTr5cdgbrtrqP3Yqe2A7MYoUcTmjXGaJ10I7AX71Nujiw
         t92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W7fIRq65sQiLkyjxcL6rdITG8jr033f6ASzjpQNDIl8=;
        b=P+SgEddZmPaByWFKIZUzK5KCwmWdEPoCBe79jIJ31m2dOinElSXNRzJwhdihjJlJUt
         Ah6PcVsHBif0dp/L+Hhb0BTUyLVxtz/KAq6TvWz86WMos2QdbGtNwSATDC6O837PZWOB
         dQYeJXhCQTI5RfgvGUk08dWuJmtsCBHZ9Sm6bW/L3jF3uXpILxbU9k0t7A6Go3jCAI+e
         r0gBKHOxvW/h6T+iXOnwLsUnuoHA2CgV2/d2oCK+vdB0OerfEeAg62GsW+xLTpzi4c0m
         RBd+KlyxFgAvkJQlkTquCvWBTFQ8n0jHq7aycNLQdDXSSdQP/dVBJTKqx7XoPgGHORWD
         VZ+w==
X-Gm-Message-State: AOAM5331Nb5tgVTHWUcTaT+S1HShIbs5iqHB/bSUxxSnlF93iBCcj6Gq
        PMLswzVVLH/e5x56HHON8cD+Lh8r
X-Google-Smtp-Source: ABdhPJy5zyDUToNxDRFU/jCNIfUXKadZXVKb6RpHxs/1+34tNXUsKvUZHTxecYo3vVKpmGG4ZJQ5vA==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr5147231wmk.35.1590700997346;
        Thu, 28 May 2020 14:23:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20sm8059168wma.6.2020.05.28.14.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:23:16 -0700 (PDT)
Message-Id: <pull.796.git.git.1590700996483.gitgitgadget@gmail.com>
From:   "Steven Willis via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 21:23:16 +0000
Subject: [PATCH] doc: ls-tree paths do not support wildcards
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Steven Willis <onlynone@gmail.com>,
        Steven Willis <onlynone@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Steven Willis <onlynone@gmail.com>

Signed-off-by: Steven Willis <onlynone@gmail.com>
---
    doc: ls-tree paths do not support wildcards
    
    The documentation for ls-tree says that paths can be wildcards, but this
    appears to be incorrect, only raw paths seem to work.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-796%2Fonlynone%2Fls-tree-paths-do-not-support-wildcards-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-796/onlynone/ls-tree-paths-do-not-support-wildcards-v1
Pull-Request: https://github.com/git/git/pull/796

 Documentation/git-ls-tree.txt | 6 +++---
 t/t3102-ls-tree-wildcards.sh  | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index a7515714da1..8a8ce20cf51 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -19,7 +19,7 @@ Lists the contents of a given tree object, like what "/bin/ls -a" does
 in the current working directory.  Note that:
 
  - the behaviour is slightly different from that of "/bin/ls" in that the
-   '<path>' denotes just a list of patterns to match, e.g. so specifying
+   '<path>' denotes just a list of files to match, e.g. so specifying
    directory name (without `-r`) will behave differently, and order of the
    arguments does not matter.
 
@@ -74,8 +74,8 @@ OPTIONS
 	Implies --full-name.
 
 [<path>...]::
-	When paths are given, show them (note that this isn't really raw
-	pathnames, but rather a list of patterns to match).  Otherwise
+	When paths are given, show them (note that this is really raw
+	pathnames, not a list of patterns to match).  Otherwise
 	implicitly uses the root level of the tree as the sole path argument.
 
 
diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.sh
index 1e16c6b8ea6..6c0f2af1d04 100755
--- a/t/t3102-ls-tree-wildcards.sh
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -33,4 +33,10 @@ test_expect_failure 'ls-tree does not yet support negated pathspec' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'ls-tree does not yet support wildcard pathspec' '
+	git ls-files "a*" >expect &&
+	git ls-tree --name-only -r HEAD "a*" >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 2d5e9f31ac46017895ce6a183467037d29ceb9d3
-- 
gitgitgadget
