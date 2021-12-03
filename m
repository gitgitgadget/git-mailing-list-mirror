Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC87C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381171AbhLCNiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381095AbhLCNiH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B3AC061761
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:34:42 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l16so5734191wrp.11
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zMOqWXrQqZ2IHpZK6hFdtyVBHSAW6HN1jJsmuhexxWc=;
        b=Eq8S1TwMAJmIW52/lbqXYKHKD3jjAwbYfz7kn+xNCOBJQAYNkpOwjdYKfIMaDkxHLR
         rOLdiL9zqRMPhHiM1tEw0wkTjnKj+tCFzb/Q/QzZxeTus/sEEzPUFtI/U0FkWsVEpmjP
         mgGaOKg2Tjzo0vGUfoTOIYNUfmAS6KsvGWJzHQTg8Uvgy1ixpcWHxdrGDjQ0r59BinuQ
         DIIRgWQUV3s+oNCW0Zim7qdfL4q2xalKvQuQ+DlDdc2ZDaxJ1sbV2XPZA9fWZe3nWB9t
         cGcJ03n1xgn2C3F3gQDLi0MoVAlO2B6duEGFTu/BzzRN0mPs0yqHySKXEIwMBwiL3kPR
         AQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zMOqWXrQqZ2IHpZK6hFdtyVBHSAW6HN1jJsmuhexxWc=;
        b=uG/GMde3o5oX1o9Jck1sEbVpelIpDuCqthkR0+hyKBXv0oDsGc7WzpD9+eEK2XzDlr
         VveeuaMbJ85JwkR3X8/t86robQbaUJDEbrUpnVdI4YmeNu8CGKHPWztWMuPIAKiHJCef
         0zYK6RWM3g8OsHU4XREQ+3mJlkocgmJfAopcIM3Sa307B/IBJ/tRPMqsRRONtUTRFLZG
         N5OQQQojchZp0xlzriVElMDLvxRq66uu6ilOgwIsZRQU1BIGAdQdFT587ap8nm1iGdIR
         if5hlmxPMUJdLIQxYK7RwVkAdf/FbMFXrPg3toqJ2v4pqxmNK8rDu2D6uFpmlqub07hG
         yjpg==
X-Gm-Message-State: AOAM5332ehxOK1PhzHnofh+qeU1qRjoXuny7SuNxZpZR/fMKHDCtXKRV
        Bedjh2ndGAk8OPQ/6mWOq3ECUh9G2pA=
X-Google-Smtp-Source: ABdhPJyjyJcwDv9pWjhRmSxPbhW+6i4pXMNCsDoPKTmoIaTyn2CKUHZUPJ/J1lAQUndYrLX001My3A==
X-Received: by 2002:a5d:658c:: with SMTP id q12mr21990578wru.34.1638538480598;
        Fri, 03 Dec 2021 05:34:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm5853285wmc.40.2021.12.03.05.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:34:40 -0800 (PST)
Message-Id: <45aca840764d1e4f99b5dc1e1a0c5e8b1532da03.1638538470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:34:24 +0000
Subject: [PATCH v10 10/15] scalar: teach 'clone' to support the
 --single-branch option
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
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like `git clone`, the `scalar clone` command now also offers to
restrict the clone to a single branch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          |  9 +++++++--
 contrib/scalar/scalar.txt        | 12 +++++++++++-
 contrib/scalar/t/t9099-scalar.sh |  6 +++++-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 60a9466421b..61b66e48aa8 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -327,12 +327,15 @@ static char *remote_default_branch(const char *url)
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
-	int full_clone = 0;
+	int full_clone = 0, single_branch = 0;
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
 		OPT_BOOL(0, "full-clone", &full_clone,
 			 N_("when cloning, create full working directory")),
+		OPT_BOOL(0, "single-branch", &single_branch,
+			 N_("only download metadata for the branch that will "
+			    "be checked out")),
 		OPT_END(),
 	};
 	const char * const clone_usage[] = {
@@ -403,7 +406,9 @@ static int cmd_clone(int argc, const char **argv)
 
 	if (set_config("remote.origin.url=%s", url) ||
 	    set_config("remote.origin.fetch="
-		       "+refs/heads/*:refs/remotes/origin/*") ||
+		       "+refs/heads/%s:refs/remotes/origin/%s",
+		       single_branch ? branch : "*",
+		       single_branch ? branch : "*") ||
 	    set_config("remote.origin.promisor=true") ||
 	    set_config("remote.origin.partialCloneFilter=blob:none")) {
 		res = error(_("could not configure remote in '%s'"), dir);
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index e8730967f16..56f744a4aa9 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -8,7 +8,7 @@ scalar - an opinionated repository management tool
 SYNOPSIS
 --------
 [verse]
-scalar clone [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
+scalar clone [--single-branch] [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
 scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
@@ -57,6 +57,16 @@ HEAD[:<directory>]`.
 	Instead of checking out the branch pointed to by the cloned
 	repository's HEAD, check out the `<name>` branch instead.
 
+--[no-]single-branch::
+	Clone only the history leading to the tip of a single branch, either
+	specified by the `--branch` option or the primary branch remote's
+	`HEAD` points at.
++
+Further fetches into the resulting repository will only update the
+remote-tracking branch for the branch this option was used for the initial
+cloning. If the HEAD at the remote did not point at any branch when
+`--single-branch` clone was made, no remote-tracking branch is created.
+
 --[no-]full-clone::
 	A sparse-checkout is initialized by default. This behavior can be
 	turned off via `--full-clone`.
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 984d69e8f75..f60e086d6f9 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -45,13 +45,17 @@ test_expect_success 'set up repository to clone' '
 
 test_expect_success 'scalar clone' '
 	second=$(git rev-parse --verify second:second.t) &&
-	scalar clone "file://$(pwd)" cloned &&
+	scalar clone "file://$(pwd)" cloned --single-branch &&
 	(
 		cd cloned/src &&
 
 		git config --get --global --fixed-value maintenance.repo \
 			"$(pwd)" &&
 
+		git for-each-ref --format="%(refname)" refs/remotes/origin/ >actual &&
+		echo "refs/remotes/origin/parallel" >expect &&
+		test_cmp expect actual &&
+
 		test_path_is_missing 1/2 &&
 		test_must_fail git rev-list --missing=print $second &&
 		git rev-list $second &&
-- 
gitgitgadget

