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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EEFC433FE
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3284A60F90
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350278AbhICRz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350168AbhICRzx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:55:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D976C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:54:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q11so9286425wrr.9
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j2bGVjqPT7Pn8kjChLvmqQS0Jlg6df0AQr+Wz7oQLNA=;
        b=khVwKVlPB4p1Jm4rjlVrDEywvkdzsHCtbrzg47g/bIQ04LLE413gsQqGxiDRIwQiuJ
         NPAgtbSCRUrpMX3dOHztBx15fIqGkGGaaXhLjLX9JAmu3kagZMTitLPNitA4WH1QIFsu
         OZzBR2RNVHj1HVzPw+A233/GscCmPm/ZK+THwab041JJ1xx2R/yZjbZo2TbxhNGMih8H
         DQu3EsfD9J0bui6ECkelUG69e0dTa68qxvfbhoqpwii+50uCC2PKXBujF/rf8SpwMJTc
         p+A9Oi14/gOuA2UUz5PU+HmYkLRVae9wdRWAoChRZCLbPT3pHTl1dPFVqiXLal7X/UXh
         5+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j2bGVjqPT7Pn8kjChLvmqQS0Jlg6df0AQr+Wz7oQLNA=;
        b=jGWWYR/mi6n5ujn4z3NTywOtdeCzFIynW7qQHtX7X64MdjPn+S7gPCGCFlwaX4BulI
         xFvPDdFn0Tt5JpF2OCSvBPqvjVHx7CncJg7EcpC5DdTRBkbPZ2q5adacPfhhMJhxV465
         RaqvZYto32NzLbAJjLvg4W9+HD0cT31IIUDF0l0hJZggj88knZfL+BMpf3T9h9tCz6gZ
         G5dh9M72BD0s0AO2hPmyfXbUsN3Npts0TmSi1/S/xlvs7dGGszrv3H45CJGsSNBPvPtD
         DHm26li+t5TrHAiM+wrZY1yPpk0TBPR7X31mZNDVYdcuRiJFTX524Ewe8eZiOtpIVq3j
         ej9w==
X-Gm-Message-State: AOAM531/UwzYxIKNssLRRMP9yIRkQBbIsa2jaw0PSWTdLsA5U1fiA2T9
        h6nGsmWBqx0BpBflPRv2/M9nnJHQalU=
X-Google-Smtp-Source: ABdhPJxyagg6X4WCI/YICEwcvs3fi4hiCjw3aRVQ9RpXsbrAJ/V08qywLSGIBIOXEHGI16+5DB9AQg==
X-Received: by 2002:a5d:404e:: with SMTP id w14mr268703wrp.391.1630691691038;
        Fri, 03 Sep 2021 10:54:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm516680wrt.23.2021.09.03.10.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:54:50 -0700 (PDT)
Message-Id: <4f886575dcfb97d5bbd04fe7551e03935ac0af69.1630691688.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Sep 2021 17:54:34 +0000
Subject: [PATCH v2 02/15] scalar: start documenting the command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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

