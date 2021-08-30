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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CB6C4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D413460FA0
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbhH3VgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbhH3Vfw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:35:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEABC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b6so24349038wrh.10
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+Qa3XTFOfDZ3LXiRJgrvog5lC/X+p4vAfXQw6nc+d2U=;
        b=b1K453pLxs7TFkCh5evxBbxnRnwU3RU8Rr06pZYeqeC6fXVXgeBF9sTdiXqKXyreqs
         brZi/rAxRbQMFZDyB+/UGbpAPJZJlBWx1SG5DQsmQAvb2i/F9CBjffMxVK+hXcob8nyU
         pWG+FAqUAhq89OJTvUMPCwzZrMYXY+sNRnODhp/yZDyUeYpDxng+e2ZfEkOxSfyCt0tD
         fkrCImp3A4UpFb2lvMOtLnI4jrg6+cS/nBBHkG3Ktn378XPdXjRCzoS1VR9A7gSdYzTl
         ct0Hao0gxzb8gmOYOdqp2tXyRDDcy9RpBIvjVlg0R4rLCuJQh3+cpyUT4C5HhlOPYNI3
         SmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+Qa3XTFOfDZ3LXiRJgrvog5lC/X+p4vAfXQw6nc+d2U=;
        b=STdO9O/vPKKGWpgcJ9/be5FyYQm5i6+yfOjFFR0G8MTs1okK7ph4PDUpWo0r/DPTL9
         JojQA746Hzyn0FgFDoBmsAXuNIdl+uJl9pFVENTW9V1vIC3JAmke0kB3852qnPnky0k8
         q71cabneOZiFiVPlpPEaUP/rIP/U45i43/no06dQyyn7Yx54tCzkYcgLyI4YX32bgOzD
         552WhB5a1Nc7NAFFHCkAJIvA5QoaP05Y5lwdQ2EtLDuB2OJTJvIC6yR1l2P4kbo0TyJ9
         P0mn9ra9xmJdWMO9nGQaI6rvg6TcsD6lwwbB3XNTLW4kN2OGNQfg//RsmipUfhfWrxiJ
         oNMw==
X-Gm-Message-State: AOAM530xwY47fTKEFjxk8amNCHbiTqgB8vKQOJe7PlwivpduCsUbIyte
        EbEahKMoaoEUHSJj1BKwffYWrUhVEd0=
X-Google-Smtp-Source: ABdhPJxzq2a1Ay1UMBDY2zlNOtlRHgGmqUp6c4eJBpaV9ulUAr4E8BN6Pqtg1si5GePVrMydObHlCw==
X-Received: by 2002:adf:f84d:: with SMTP id d13mr28239016wrq.292.1630359296389;
        Mon, 30 Aug 2021 14:34:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm16101156wrx.10.2021.08.30.14.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:34:56 -0700 (PDT)
Message-Id: <9af1c37c2ea8b51cb2941b0b62460925eb76dfe4.1630359290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 21:34:44 +0000
Subject: [PATCH 09/15] scalar: teach 'clone' to support the --single-branch
 option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 13cdfa94d16..908eaa84df1 100644
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
index 90d59f1d79f..bb9411b38cb 100644
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
     Instead of checking out the branch pointed to by the cloned repository's
     HEAD, check out the `<name>` branch instead.
 
+--[no-]single-branch::
+    Clone only the history leading to the tip of a single branch,
+    either specified by the `--branch` option or the primary
+    branch remote's `HEAD` points at.
++
+Further fetches into the resulting repository will only update the
+remote-tracking branch for the branch this option was used for the initial
+cloning. If the HEAD at the remote did not point at any branch when
+`--single-branch` clone was made, no remote-tracking branch is created.
+
 --[no-]full-clone::
     A sparse-checkout is initialized by default. This behavior can be turned
     off via `--full-clone`.
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

