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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995EAC433FE
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DDF960F26
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 14:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhINOpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhINOon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 10:44:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908BEC061148
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x6so20595755wrv.13
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6iE+bMIqkngcQSCxet0E12DWukuDqNQkL7dWIME6eT0=;
        b=J+pVAJccC6mjmz0ZJBE8uws0yF+8cLbxdNf737rRc8VMMkxPp+Cut8jkSmyehQGdqf
         wdzD9EMMeSvKVABq3GK268kNUNplI5se9HuEsOnpWAcggkGFr7E4MMzVyXsC59XEEXyk
         T+uq1cdjXy8zNKcIGzZOiDW+Pp4QlGXZqC1+Ngt+EPfCc+m3IJP5M5vMonbAW4J2Cvl1
         A8DMHvNuotYg8iTgUfKfIYTPq6az1Np+y2XBUqMChKNu9mXJ0kT1tvqVYEWRH2vNMv+w
         0lvo+bKJdB4/NqOHwAnRFaKmTL7IgvAzcw1IY7R2zOMLEusyiwYanzwCRR6jNrOFkRNA
         IIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6iE+bMIqkngcQSCxet0E12DWukuDqNQkL7dWIME6eT0=;
        b=w+Q5my1yE80cz7giiKNhyKFaWZZh2m5a78/Scqx7X8c0eTxLlQAjN9gVpV7On1MyVR
         YCB7gqlps1TLHVDdg1E3oaLM7Hkky3zWcwkX2uNIXJH/VJbvLOlYr+4f2/iTzOP6H7md
         UcnnkcqeNWEvLM+BZCL+3lHmEc8s5OzdJb3ItXMOm9j+cBfryVDR8tLQX3gibiHpV65f
         zCSxTerSLcBfdsdN1yYd3lQ/F5oX1D7YIDOqJgviTbG+hNc9hHAKvtbwdnqweoEAVlSv
         g0Tx00+tT8ueHrNzmcj1BHdqhDjggHWvo7gIMTmwWoEqoCK7CsBPNK0iSsfoccFjnyEu
         baNg==
X-Gm-Message-State: AOAM532N7neK5lFoFMVdz6LQ/c3L0iABsmUP3CXrTCc6B4hSzYfX/ORC
        7ngP+qW80Zd1pDni1Dsw0YBJf8cPoqI=
X-Google-Smtp-Source: ABdhPJya0xSp6YUCfdKyJxa2EhIzE09fABFIlC0hQ+Xaq1lmrCoCdcMXlAqzqs3vD9jSzwknhyIEoQ==
X-Received: by 2002:adf:8070:: with SMTP id 103mr19005878wrk.74.1631630364220;
        Tue, 14 Sep 2021 07:39:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm9958016wrv.24.2021.09.14.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:39:23 -0700 (PDT)
Message-Id: <0acdaeb739669620d6e8ee59037ecd5ae52cf007.1631630356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 14:39:10 +0000
Subject: [PATCH v4 09/15] scalar: teach 'clone' to support the --single-branch
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

