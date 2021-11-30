Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393EDC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbhK3L6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhK3L6R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:58:17 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7B4C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso19318311wms.2
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RfUF/RYS/teZLMILSS48GFBpV9FtCRub18a9JOXeUIU=;
        b=e2z/w9IvjFXCtoldOcmW1bhK53Spl3536/MijUfqmLHiHXWKEitas/uynVozTWf/hp
         Y0SNdmtLXw6CzAntSsDNjLvkEjaAduUgmwiSwxVDcDJ6ZMaEugwoci1JG2HHNBPIKyLZ
         tsvKUUKllOOJO3aLhpFC3hSsRLsRXPG3EXV2xYrHG7ugMDWqizUiImmiDtvRhQ5sby7n
         kcmJwRE17Flk71FylK7GtL+B7EZutVUNwZzHuZhv9FUmEIxf4zN/ag0VggPuIqeXTxAy
         sia/BAAV5dnUywefX3AgduwgSXtJS9ICCcsiyqcoE2RiJoxO5VStcj3jIlm5OGWoCvIe
         It1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RfUF/RYS/teZLMILSS48GFBpV9FtCRub18a9JOXeUIU=;
        b=5uOtPlteZq6Nq85krMOrl5+NmF5tWEAli4vghixQui0LJcWqKp8ExMjTPOtI5ms1mh
         I4xG0BaSAzYaS1+DFAkMoXJlkH3ndzg5NSOfSqLbO86eWsA2IBP7YiT2ivKifuzZNnqu
         BSdRXsbWMjwlZ7LcXzx1xn/XOG4rphwgpO9mXLWai4DuKqsJfJhpwGXkivZZOCf0UtqP
         B8V2+ghhYZSgKxff0BoBxCL6xLtEEsgWq3/ZPDEIjaslQb9k2TOXHp6gxDgjlA/vBFzW
         g7L37D+w1kML9sLr2veJb+zgZw9ElpN59uC91bLGXYBapomfua5nuukKDU5GYOjsv+z6
         kPHQ==
X-Gm-Message-State: AOAM532dC5UuX39yotV/SDbsiPzH/9fwVD7YuT4VovyN7abjar9HGuzt
        KPLStihDzvoEMehblJRHSUHZ857cbDQ=
X-Google-Smtp-Source: ABdhPJyU7oBh6oIP4LiuER2KWyCwSvZS7xYwhxstLnG5ivUJkCPNOxsbcvqZXdatA9+n4wWlTmhomA==
X-Received: by 2002:a7b:c744:: with SMTP id w4mr4560149wmk.50.1638273296583;
        Tue, 30 Nov 2021 03:54:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm15859519wrz.22.2021.11.30.03.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:54:56 -0800 (PST)
Message-Id: <09a15f86c3d1a79d76c73e051c6895496ea0e8a7.1638273289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 11:54:40 +0000
Subject: [PATCH v9 08/17] scalar: 'unregister' stops background maintenance
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
index 55a304442d4..9ab9dffe3ac 100644
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

