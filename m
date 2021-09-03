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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884CDC433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6507F60EB7
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350330AbhICR4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350168AbhICRz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:55:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE9C0613D9
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 10:54:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q14so9289966wrp.3
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=scWMqUXIR603LE5pZOKGG1TjixAzorthpNx8SGDq9bA=;
        b=PaQZArABRvkzmJHp1W+9vbTLNlNMnR+JQEa+kI1SI7Ne2H+CvLGiPhF51joEgF+RnK
         yJjRpn5LNcywmN7RL634XyLZeaGalfA/6UBOjhIBNubC3uKvdxQkZcIx4BUnC5y/+kS+
         o9W8ORSkbiQczd++UxplKVE1Nl05i1p1YPPv96t6fVyesD65hKajh2Q+o3gwjvzb8gqr
         4ic5vfL2fARrbGfC49YY2VgET1kgTgrO0GHUk6le7kWKP1fWyxQSmixJIDwIyvAEFSOi
         MpcJ1N7kjiyF9BzrZoE76PO08gALFYhPNVQxCJUm1a9ssX221rt7e6j8MdSMp8c7PY8A
         azFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=scWMqUXIR603LE5pZOKGG1TjixAzorthpNx8SGDq9bA=;
        b=bpGkugab63L9cSYKgut+UMQ1m3j3c8nHsYDE2lTi7QT9cxv2C0IccN4czGvuN34h//
         43XENi5PE+5LQA045fmopp/M9UOW5iHGp3sr1t1ynRxh7t3Wu8hbuxTcrEN7TaKZAUAQ
         itGbB+e/nmuykus7qNy5tI3E770hSmXX41I9oPxzYHf7Ssn2kHXz5s3iq2AGdJay4gg5
         Aau25OQ9reE+8+CnWbDRvt8WbMBnSvKINzi9miRVKBFrGlF4itzXlAj+8T47fOLEECo2
         UDN+mlwKBYKJS612bSoK0IJIvHzxTs0+lxaBIMGi1ECnTaWmjLK0UGs1EFlGWikU1c1f
         ZI8Q==
X-Gm-Message-State: AOAM533hTMQx+4rQ2l2TyDEdyLEgUnW/AeS7xaWSlQr55zXZGBoVRk6X
        RrhZSq2ZJwBU1pxhv5mmILi6ULzrhTg=
X-Google-Smtp-Source: ABdhPJwS+GPii/0hkBt3YnY4K8Rt9rwNzxcnZmlTVXdetVwOytHG7XIubMom9lsM793Nle+kvTuPBQ==
X-Received: by 2002:adf:e887:: with SMTP id d7mr295992wrm.79.1630691696200;
        Fri, 03 Sep 2021 10:54:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m30sm2981215wrb.3.2021.09.03.10.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:54:55 -0700 (PDT)
Message-Id: <b3c4b3dccc6d943990d5256944284ac3fbc39fec.1630691688.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Sep 2021 17:54:41 +0000
Subject: [PATCH v2 09/15] scalar: teach 'clone' to support the --single-branch
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
index d4e3cb73fda..6ceb528f347 100644
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

