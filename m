Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AE6C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhKSXG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhKSXGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:06:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6709C061748
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:52 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s13so20670755wrb.3
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qaR47xznf9Xy5jW3JgfZrlmIasnjgC8KJcW13Zq+3oA=;
        b=JqQ8bUE3z6WaqxU/ijkxhQbkKWGmHORhA7EzIwzjh/Vl7g7bakGkae7cp2xfse3T3o
         uf2gNGcwLBhRakeH0OTzLThF/ltQSVC5MhoXp8rBB73QBnHv5lEv8+meOh9qz6vtQje9
         hpdGClMi+HHEep/VIWuy53zUMK0vE+TNFvfDcAX+CwgVpQz6o2QzAzVdengQPip/nhoK
         Piqm24+s1I+nIYd05iKpbvfYtOyGPxfGiXR7CMsGTp2MT5pwVxyzbAY1832hxWBde17E
         WYlupb1Zh7FQRGeL5y1VW4GFqFhixyAN/oqGIrm8MquUPWLt4KoH/Wm9NK5YhLsN7ClM
         g6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qaR47xznf9Xy5jW3JgfZrlmIasnjgC8KJcW13Zq+3oA=;
        b=DZMqO6PmJ28Y4HIN8FRDq18nW96NJ+uqA8T0gPsoWP0mHVNI1tcdQG9dn1gPiPPATi
         527nsrRA8MJnFay9bio8vscf7SgHxsRdyhzAfj82dMnxhsfMJtsqWfhT2qTFmWDfh2t3
         H8q5O1FupBU1nqOukwzUA8Xh+0yaGGwiqwWHfSXoXk6D3O08ozTqJ6udYaE5bcrttnoK
         qTwIvv8ETWynwoGfRC3QQAXJ6MGJ6+kIW1o3EFdy7sYL7RdkOQk3soBLHieYl6puBnYK
         FWHTAdIxjO1c/IFYxxk9pANx7B5uQ9UWRYz2dmaOl8SOr4UiSllMxGeMXd2Lkrh7M+ml
         eXQw==
X-Gm-Message-State: AOAM530uNE0XciPSDITtXJAFMZH6IQ9sfxmKSxnLaQ6aeMbNLtCq5Eso
        4+DOrrifkyerkd2JQQPaVWRQfaWPHGc=
X-Google-Smtp-Source: ABdhPJyUa8b4U8vgjvCL2saZMeMoeMPnhn5v8B6mneTxMoJ6TuMnGY4x3isY012rTwLK+dRkQY0uWQ==
X-Received: by 2002:a5d:4904:: with SMTP id x4mr12585081wrq.139.1637363031178;
        Fri, 19 Nov 2021 15:03:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm1009194wrp.79.2021.11.19.15.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:50 -0800 (PST)
Message-Id: <64c6a75353ef10977e56c7a30266d69e8de991ba.1637363025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:35 +0000
Subject: [PATCH v8 08/17] scalar: 'unregister' stops background maintenance
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
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Just like `scalar register` starts the scheduled background maintenance,
`scalar unregister` stops it. Note that we use `git maintenance start`
in `scalar register`, but we do not use `git maintenance stop` in
`scalar unregister`: this would stop maintenance for _all_ repositories,
not just for the one we want to unregister.

The `unregister` command also removes the corresponding entry from the
`[scalar]` section in the global Git config.

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 50 ++++++++++++++++++++++++++++++++-------
 contrib/scalar/scalar.txt |  8 +++++++
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 03d5f84c764..bab0271c37d 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -198,12 +198,12 @@ static int set_recommended_config(void)
 	return 0;
 }
 
-static int start_maintenance(void)
+static int toggle_maintenance(int enable)
 {
-	return run_git("maintenance", "start", NULL);
+	return run_git("maintenance", enable ? "start" : "unregister", NULL);
 }
 
-static int add_enlistment(void)
+static int add_or_remove_enlistment(int add)
 {
 	int res;
 
@@ -214,24 +214,39 @@ static int add_enlistment(void)
 		      "scalar.repo", the_repository->worktree, NULL);
 
 	/*
-	 * If the setting is already there, then do nothing.
+	 * If we want to add and the setting is already there, then do nothing.
+	 * If we want to remove and the setting is not there, then do nothing.
 	 */
-	if (!res)
+	if ((add && !res) || (!add && res))
 		return 0;
 
-	return run_git("config", "--global", "--add",
+	return run_git("config", "--global", add ? "--add" : "--unset",
+		       add ? "--no-fixed-value" : "--fixed-value",
 		       "scalar.repo", the_repository->worktree, NULL);
 }
 
 static int register_dir(void)
 {
-	int res = add_enlistment();
+	int res = add_or_remove_enlistment(1);
 
 	if (!res)
 		res = set_recommended_config();
 
 	if (!res)
-		res = start_maintenance();
+		res = toggle_maintenance(1);
+
+	return res;
+}
+
+static int unregister_dir(void)
+{
+	int res = 0;
+
+	if (toggle_maintenance(0) < 0)
+		res = -1;
+
+	if (add_or_remove_enlistment(0) < 0)
+		res = -1;
 
 	return res;
 }
@@ -254,11 +269,30 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int cmd_unregister(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar unregister [<enlistment>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	setup_enlistment_directory(argc, argv, usage, options, NULL);
+
+	return unregister_dir();
+}
+
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
 	{ "register", cmd_register },
+	{ "unregister", cmd_unregister },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 568987064b2..d9a79984492 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 scalar register [<enlistment>]
+scalar unregister [<enlistment>]
 
 DESCRIPTION
 -----------
@@ -45,6 +46,13 @@ Note: when this subcommand is called in a worktree that is called `src/`, its
 parent directory is considered to be the Scalar enlistment. If the worktree is
 _not_ called `src/`, it itself will be considered to be the Scalar enlistment.
 
+Unregister
+~~~~~~~~~~
+
+unregister [<enlistment>]::
+	Remove the specified repository from the list of repositories
+	registered with Scalar and stop the scheduled background maintenance.
+
 SEE ALSO
 --------
 linkgit:git-maintenance[1].
-- 
gitgitgadget

