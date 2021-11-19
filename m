Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BC1C433FE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhKSXHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhKSXHA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:07:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F4AC06175B
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u18so20650412wrg.5
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aNTH9FlmLUV1D0smRDtl/JcI0aq3IqqJlw7lcxaJwfw=;
        b=jrKderguPTCnCJhw91fM+6Q8m0ZwqxSVB5qJEXbflUXRIXYK74E32RtGnUXc3CknYE
         8dGLxUvZ1thtZIGUJ9nedhU3qMZtzxpCAa5E1YQNKEHvUWKvue+Hhvps2X9xJY57UiPs
         hudCkRr8n/w1QTxA3pmcIwYR4TV6pjUx3kov8/xDvEZD0DSRZCb0vc0+4keLPsWnwIH0
         2mG7lA4GdWgYTqKpOtSkSQSjfbdVB0OVTiYjuJeXnY4LRr3Y42Y4GrOcBkso/yHuD1/4
         XunMO5HrZldl1y/fB8qjV/XZsbe0zgwDKQqrmcVP9cF73vlIhveHoMaTn2fZ5sUDOX83
         8F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aNTH9FlmLUV1D0smRDtl/JcI0aq3IqqJlw7lcxaJwfw=;
        b=xugSPnVvVG/ZYjn0aIlWpMGWqft7x5qZIbyaEznAiMsSzB9yAoUu7pm3QKu3nk3Nnn
         62Ro5Q9+e+P19owwz5gT3ytgl9AQJnSHkuz+GJOfJF8nPeKjcB2QMvqv/N11qo9kzW6d
         FhuKcezosSBg7Nc/R0IcEyslE/34mJtGuF4dk+WcoXvr36FDbg5VYZfr1SWzqD06S42O
         PscoizemsCvQFHVsG/NJO6gwzsyBiFEbmU3mcBk89W7f/ix1gTgq73A8L+oCqPawyBJ4
         OGo7+/59atx2t2ElJYDzH7iAjUya8CvQA6GTsKDqLvBRunicphWhGmJwwnUNBHUEVkK7
         nvvA==
X-Gm-Message-State: AOAM533Uvh4E0M+21ORZE0Cl2L4ONIElV97uYmaDCkvXkFmSxavjYELe
        HcNy7vEVT5K97T3TPOp+d0WxmW6Lhcg=
X-Google-Smtp-Source: ABdhPJwWvYFHaMepKHQq4ZNT4zMn5dqN4MLLPo7kX0nMzDJEnBdO4Ux7H7vV6MQ3eM8LnLioxeRkzg==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr12367646wrm.60.1637363033975;
        Fri, 19 Nov 2021 15:03:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x4sm13014397wmi.3.2021.11.19.15.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:53 -0800 (PST)
Message-Id: <b00d68b37b07fa9cf68c8898398eddcd4d0d9571.1637363025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:39 +0000
Subject: [PATCH v8 12/17] scalar: teach 'clone' to support the --single-branch
 option
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
index 43f83dde33b..516a75be3c4 100644
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

