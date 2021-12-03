Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D4EC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381116AbhLCNiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381060AbhLCNiF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:05 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888AC06175A
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:34:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v11so5707622wrw.10
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RfUF/RYS/teZLMILSS48GFBpV9FtCRub18a9JOXeUIU=;
        b=gLubrGDW+AwbySKXDCTMPCdwGprvVV3vx9sZTNGQUabQgI01ByIla+LSi0GxB0yggh
         k8d3TVAcNRMOxCBIJXYXIT4LRiyMpn2lRb+aWDmCYlzFzx9GYflnkM12Md28TbU2uiz9
         Ewq2WCOIIXeLYqzYGxGz75WGMD0PHFUQYLUBMSamZDNne2LoFGlaHlAyjfGo18/H7S7V
         96i7PC+TvFpeefD4ffpQSMTnA7AKT/STaEzl5otKp1meZSNYEzBEKsa5pvXwu/kGjR0O
         3tNFblBm0L5pZcICU/EgW1AzBJrEYN6nWhwZHFtv5v3oCRZCxx3Ha5InM2c+CI6uB10B
         dbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RfUF/RYS/teZLMILSS48GFBpV9FtCRub18a9JOXeUIU=;
        b=3vEwhD/S6XLYJw2jJ2uiWtzXOrXGWQkAHNYcdQylzqC/OA+NVhtv6blbig/ONuqyyD
         YWm/MiZ20KGIOfAlwWafS70M+j7UNHNQMq201ZkbasCAFMfBq+KcUC4oIZdj671gusyL
         yJn9M6g7ux+W5RfojdwVrNTEP5bF3bV6XrpLnOWMELOMHRvHcCLDQUJK6SM58YNENE+z
         ql3405PoWZ58XAdAsVkB+C187DW+I3yLzKSQYYQbhWe4QrV9k6HrDVL1ZWUoBmp82EiP
         DL7Fxwwim3AQomv7GIhvzyQJWIM0cMuZQ8miNxDW3dv3FNUnsz40YFpuRpJIqrPiM50p
         3cSg==
X-Gm-Message-State: AOAM532+YcK64iTJT4HqTDV7G8ji+RFsjAAY/FQ/txfLeHGrZFR5sAJ5
        7gtMYYv6Zm1PtoXpWjNeI47MBHQPUwY=
X-Google-Smtp-Source: ABdhPJxsftngAc9YYYolBcYwTTBZsPyoeyzYpssTfVZ23nMZM2TyhPtgb6o7zZEGYoLNu7eiGI6mtA==
X-Received: by 2002:adf:ef52:: with SMTP id c18mr22031886wrp.162.1638538477104;
        Fri, 03 Dec 2021 05:34:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm3372149wrr.10.2021.12.03.05.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:34:36 -0800 (PST)
Message-Id: <376056066a09f19eae4e7bfade076c210a9944a6.1638538470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:34:20 +0000
Subject: [PATCH v10 06/15] scalar: 'unregister' stops background maintenance
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

