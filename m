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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC2AC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8849D61104
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351008AbhIHT0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350963AbhIHT0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:26:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353B9C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:24:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n14-20020a05600c3b8e00b002f8bd2f8ab6so2421756wms.5
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6iE+bMIqkngcQSCxet0E12DWukuDqNQkL7dWIME6eT0=;
        b=nA/6BE7zqbO55p2zFQ495M/IkAi/AREzUCEYy8xX/zYdXt3cjuc4A0lfBT5NMaLAVc
         2PNVfnxtTBpNBWfjMwZlFTelKN+7+t65kRb0vtxervn4n1lo8IG29iOgn/DBNhRCHqGV
         8un0Sg/ISe5c75UYhWRma5zKfQhKnX+KhtBVxrK8wXWdbhIREjJZDSXHhl9zdYUBnpMq
         sY3VZXVveEi8iVkdC9GpDNojQbUtM4cA6jfsETd6119uN6a1FdD95HvVpkSWSNHxUCpl
         crc6uOvF+h6EtmwSa40o/04Dp+oV8Ovy4n8rhcTDAKeYsW8OKil20PWucpH3EB6kN4bu
         0NJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6iE+bMIqkngcQSCxet0E12DWukuDqNQkL7dWIME6eT0=;
        b=WqA9F9p/L1pSjnIISlHGcjvKu476qzuv45j65r8g3Bhi6aUD29xGtM9PMsFkONDcCw
         DDlRfuTCtQIobUGklfoWa1qIuYuOSqsjWdUkEUDVlAd/DgwNjE31TeRttgoIpes9Keh+
         F0TfVbHd/SCKaLYbjL/TW64zXtCO3clkSp0vW0mp8JwIhpXkmyJVOyi6SXEepVwSlPSH
         MEgP22Rx9fbjFWOXs0pvlhLqNnOQXhk4c0arIfSFWpQUwey2NKL2u2fVQfDxLWK95zcF
         wgiMscgaAGkPGy0ZypM1UQYC8VmEL3H5SGtNf6XWNy9DOjws5QaA5TXBbjkwUhQZK7ir
         hIug==
X-Gm-Message-State: AOAM531mhxPHiKDwStmWw58fYb8pUliDp7dZMvK7z5Lt2mJajw3rXruK
        8s2N3UOi+5OKjvsjBO3QizKeJvn0f+c=
X-Google-Smtp-Source: ABdhPJyfZ0TjgKwnJf+5KEkHWIzRJa9vjg7osa38yxeEfy4AvnBJ/GXh6CxZZypIISNBKIg13iGqKw==
X-Received: by 2002:a05:600c:4786:: with SMTP id k6mr5015435wmo.177.1631129092791;
        Wed, 08 Sep 2021 12:24:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm31936wrc.19.2021.09.08.12.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:24:52 -0700 (PDT)
Message-Id: <414dbe7d859a39c14063b69d672837e7c99c410e.1631129086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 19:24:39 +0000
Subject: [PATCH v3 09/15] scalar: teach 'clone' to support the --single-branch
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
index bf18003b297..7dd1f28948f 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -333,12 +333,15 @@ static char *remote_default_branch(const char *url)
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
@@ -409,7 +412,9 @@ static int cmd_clone(int argc, const char **argv)
 
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
index d65fb5f1491..46999cf7c84 100644
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
@@ -56,6 +56,16 @@ subdirectories outside your sparse-checkout by using `git ls-tree HEAD`.
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
index 295398f62cc..9a35ab4fde6 100755
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

