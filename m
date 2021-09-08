Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B0C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E682961104
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350582AbhIHTZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350510AbhIHTZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:25:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976CCC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:24:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso2341696wmi.5
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j2bGVjqPT7Pn8kjChLvmqQS0Jlg6df0AQr+Wz7oQLNA=;
        b=iwjuOV6ZWbjZqPodLFr29IGqUrEF+91WpXlvTnx5zQkTiWNONr3zzOhESbprNgcP7m
         LQKyLPoj+c02TXjZ+cVu71pKq2wKZyAKdlB5DHTkVxcA4VJeyKFEdCD49crw/F2nmojd
         dga4XbA6duQvC+/0M740El+z/pyjq7ksTieoIWkEuFMxrVF8LIhsannKWC1WtqDoNeTO
         CnlUW5QuOpPcimXx/+7DCkEZvWoV2XmTOp10PK26Y77xhSUlMgTqzlMAw733sRVRwth2
         /aPbhA6vu34xmPo2WS1iPHTSU4ZAj3g3wJCV5V/onhuQYFctJdYD/FaF1mfmqwmrmy1I
         TncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j2bGVjqPT7Pn8kjChLvmqQS0Jlg6df0AQr+Wz7oQLNA=;
        b=tckukNlVHRCljGWgE/48D3ISjXBEp6FKx8kcon9MCS6vWVTInVj4Bglm2GHIdk2gte
         9nhfAHb8bppM01R2EkaWveb1M0V7iRAPYhRKZpJ7fgENmn3NBuo9tCpZrHdmnC3sWfEf
         sl/xyXZn45tj2Crqaa3T5+44xJmgFCOH59O5spvAOPoil6xWTunZAYS7mpIIbjODK/Rn
         mXjSEioqW/EjfRiYvx+jPnCtwGs9rpq2IXYDPhBQ72H/49nk6+twh2gk78voA51hJiDb
         31TdG4seSMve2+b9ZPRlOkyrLyUX6OVJUvN1Bh7Vt3qdAsw2TeAF8+lx28q4LOXExQZp
         TWCQ==
X-Gm-Message-State: AOAM5312RvjOtCqWQT8q+KgXubnaF5u3mZpKWHFS5L5fHlXEAH7GnOCr
        yFPhaOp4dFPnPtVFHV5wCUEqsRPLWeU=
X-Google-Smtp-Source: ABdhPJzndYybyTW92dDBkT16Y1iYdQOkDcNXgKGtwWj5sosUi1If1N+r4G+auv8hp1HZqL5bYef+RQ==
X-Received: by 2002:a1c:d2:: with SMTP id 201mr4994586wma.67.1631129088279;
        Wed, 08 Sep 2021 12:24:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm24207wmj.9.2021.09.08.12.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:24:47 -0700 (PDT)
Message-Id: <4f886575dcfb97d5bbd04fe7551e03935ac0af69.1631129086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 19:24:32 +0000
Subject: [PATCH v3 02/15] scalar: start documenting the command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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

