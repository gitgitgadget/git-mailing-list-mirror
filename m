Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B9DC4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F6760F6B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhH3Vft (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhH3Vfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:35:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0759C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m2so9751024wmm.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j2bGVjqPT7Pn8kjChLvmqQS0Jlg6df0AQr+Wz7oQLNA=;
        b=ISse+AkGtDafCRlUmmFMQt2uM0TMTbjvhTtq+JQcXLQJSN7aPDkyA3XHF97jyNdT9x
         FvshFRnCA8mhdB2ppj/6RJv2R2B960xbgBUCpeYE4trbVSdt6qg5zTuaW5pfZckjEV3Z
         veCGfFf4ttuwsVPxS0A+X8OA2jxTAaMd47EtKPv/GIw62nKmpPkKLtKK2Lzu+njr9ETs
         xRl00k1KY7RtvvV+HbXP0H2MJ+NxM4ndM4Xa2u76CC6rHo1/sEYUhM3UKPtRWrpKO+JM
         N4zSVj5A96+wODInnqMtcVjXl6tHJBTAqzfRj4Dvw20FC7yKBw+7hrm3Bn11Qrp9PzPS
         7nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j2bGVjqPT7Pn8kjChLvmqQS0Jlg6df0AQr+Wz7oQLNA=;
        b=L6INMQJsyAOlDuEK0uK+cXyPjAKooBGFKBMD08IkgABBZdeohnZlJ/8NIuRKTL/19t
         cVievBItXgSrJFy5V/qHYNCbOOkzo4q9KeP/EWIub1PILyIsyoHqd9lG8JXbyuBxVuju
         VYGHVjM5KI9+A7/pRroiXweJXBxth0aQ4/8Mdnv4vbhITHxLmd1DgdvUdo6scOFHciUR
         Gxevxe0zXrXsvJ/a7Pn/vuexu9uDPRGnaXHZaY+ENI+DF9OhyI14PrYs/qtXi4G68+om
         Gw4uRR6p9H/ZX8h4+vpG5xKyglg/od1F5efMstI4nNDrKyNprI2+WxKkqPjsTThKuZkp
         pA9w==
X-Gm-Message-State: AOAM533XhC9fVp4MOiEhtX3vEhiVyA3GmGUGle/5Klm7p7FBhcDVmPUg
        o8EOhdy2+3tsC1A+8KxBLBxUyCvKwEQ=
X-Google-Smtp-Source: ABdhPJyp+6IxTvWy3I1OrxOTz10xxaiGxR0L8a3xZ7L5bUMkjJFmd+Da5irgPUxHHo55NWaVmfs7OA==
X-Received: by 2002:a1c:7f52:: with SMTP id a79mr986184wmd.31.1630359292448;
        Mon, 30 Aug 2021 14:34:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm16097864wrx.30.2021.08.30.14.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:34:52 -0700 (PDT)
Message-Id: <4f886575dcfb97d5bbd04fe7551e03935ac0af69.1630359290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 21:34:37 +0000
Subject: [PATCH 02/15] scalar: start documenting the command
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

This commit establishes the infrastructure to build the manual page for
the `scalar` command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/.gitignore |  3 +++
 contrib/scalar/Makefile   | 14 +++++++++++++-
 contrib/scalar/scalar.txt | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 contrib/scalar/scalar.txt

diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
index ff3d47e84d0..00441073f59 100644
--- a/contrib/scalar/.gitignore
+++ b/contrib/scalar/.gitignore
@@ -1,2 +1,5 @@
+/*.xml
+/*.1
+/*.html
 /*.exe
 /scalar
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index 40c03ad10e1..85c186634e9 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -6,6 +6,7 @@ ifndef V
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
+	QUIET          = @
 else
 	export V
 endif
@@ -30,5 +31,16 @@ $(TARGETS): $(GITLIBS) scalar.c
 
 clean:
 	$(RM) $(TARGETS)
+	$(RM) scalar.1 scalar.html scalar.xml
 
-.PHONY: all clean FORCE
+docs: scalar.html scalar.1
+
+scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
+
+scalar.html scalar.1: scalar.txt
+	$(QUIET_SUBDIR0)../../Documentation$(QUIET_SUBDIR1) \
+		MAN_TXT=../contrib/scalar/scalar.txt \
+		../contrib/scalar/$@
+	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
+
+.PHONY: all clean docs FORCE
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
new file mode 100644
index 00000000000..5f7131861a5
--- /dev/null
+++ b/contrib/scalar/scalar.txt
@@ -0,0 +1,38 @@
+scalar(1)
+=========
+
+NAME
+----
+scalar - an opinionated repository management tool
+
+SYNOPSIS
+--------
+[verse]
+scalar <command> [<options>]
+
+DESCRIPTION
+-----------
+
+Scalar is an opinionated repository management tool. By creating new
+repositories or registering existing repositories with Scalar, your Git
+experience will speed up. Scalar sets advanced Git config settings,
+maintains your repositories in the background, and helps reduce data sent
+across the network.
+
+An important Scalar concept is the enlistment: this is the top-level directory
+of the project. It usually contains the subdirectory `src/` which is a Git
+worktree. This encourages the separation between tracked files (inside `src/`)
+and untracked files, such as build artifacts (outside `src/`). When registering
+an existing Git worktree with Scalar whose name is not `src`, the enlistment
+will be identical to the worktree.
+
+The `scalar` command implements various subcommands, and different options
+depending on the subcommand.
+
+SEE ALSO
+--------
+linkgit:git-maintenance[1].
+
+Scalar
+---
+Associated with the linkgit:git[1] suite
-- 
gitgitgadget

