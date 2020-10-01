Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B53AC47420
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 08:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B1F20B1F
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 08:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBqeO9Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgJAIVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgJAIVh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 04:21:37 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB4C0613E2
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 01:21:35 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so4435582qke.8
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLtTwKHiBgE0JoQUBA/GU0Uqj02c91oqRD3866C3LVw=;
        b=GBqeO9DwkH07ZLWnytP0ilmFsOnf2eHCC3mvXVMvAJQyx6KRtjHzxEbiaFnCGMXLkw
         XEpHXuZPPiMyWcPiAWas4SCX0T6QEA7oTh5O0c+i38g1sD7CmDlL13qKKwmwaYZNCgFP
         THjruRuukcUu7ujUdEjPdcYRVXnbApGmJMzi/oBec89XAjpgkwYKMwe582iY9PLHo54z
         kr5TLukjzHb59eYFywpL0JS2UoMQHk9OtZ5BrL7p9jGCBGl+RKmSKE+9cZmltEsCm4bj
         f1dUbMF+uHanuLKXCHwibAaRv62byJvO59UFBEgskpOQgUrjsz3wXEicx8rPmCvXwuLr
         QgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLtTwKHiBgE0JoQUBA/GU0Uqj02c91oqRD3866C3LVw=;
        b=YXrs5qRCVPUxkQ7syDSYjx7owYsQW82UrsMx9zP+c9hP+KVVMiwIsr+/t+wGi7p86J
         +MeuM+pC+cdDNx+Qxo9TXKFNVaW32BVdS70/8ASQ/LehZoclSewfW3OBhEIvbTrkHOCr
         BQBT3qDSoAEglJv9iExnXrQPxZrAPQSWWmGRZi2vZBc98my7cU9yVdzT09js/QUncgFX
         XkBuStp2y/oFiy6daM1z0CJU3H80Zazf3qjkt149F5Ek7jCRI70aYnVkY1gcBAl0cIsb
         xPhywaRtX8kTmBLWNdJu2gp/4s63ZtJh2Ky2gs/CyKcm6etW28/suyQa7awB5rqvFJvE
         EwMw==
X-Gm-Message-State: AOAM531n9zIaCA6n3lgE+yr2Mo/EIQSCi4xBkHUtajjHVNmuYLldMVTw
        KFeq4HEOW27gLLLd56NnleerSO7AwWQpvw==
X-Google-Smtp-Source: ABdhPJyUE8cbPx7QfzW+2471TwL8nb9+jBvOKCTDBeL5prMMz8vdMyaY/WSjrUr0lNOgSKT1r6aO4Q==
X-Received: by 2002:ae9:ed07:: with SMTP id c7mr6967529qkg.38.1601540494521;
        Thu, 01 Oct 2020 01:21:34 -0700 (PDT)
Received: from localhost.localdomain ([124.123.104.31])
        by smtp.gmail.com with ESMTPSA id y21sm5274805qkj.97.2020.10.01.01.21.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 01:21:33 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v9 3/3] t, doc: update tests, reference for "--force-if-includes"
Date:   Thu,  1 Oct 2020 13:51:18 +0530
Message-Id: <20201001082118.19441-4-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
 <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update test cases for the new option, and document its usage
and update related references.

Update test cases for the new option, and document its usage
and update related references.

 - t/t5533-push-cas.sh:
   Update test cases for "compare-and-swap" when used along with
   "--force-if-includes" helps mitigate overwrites when remote
   refs are updated in the background; allows forced updates when
   changes from remote are integrated locally.

 - Documentation:
   Add reference for the new option, configuration setting
   ("push.useForceIfIncludes") and advise messages.

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 Documentation/config/advice.txt |   9 ++-
 Documentation/config/push.txt   |   6 ++
 Documentation/git-push.txt      |  26 +++++-
 t/t5533-push-cas.sh             | 137 ++++++++++++++++++++++++++++++++
 4 files changed, 174 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index bdd37c3eaa..acbd0c09aa 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -10,9 +10,8 @@ advice.*::
 		that the check is disabled.
 	pushUpdateRejected::
 		Set this variable to 'false' if you want to disable
-		'pushNonFFCurrent',
-		'pushNonFFMatching', 'pushAlreadyExists',
-		'pushFetchFirst', and 'pushNeedsForce'
+		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
+		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
 		simultaneously.
 	pushNonFFCurrent::
 		Advice shown when linkgit:git-push[1] fails due to a
@@ -41,6 +40,10 @@ advice.*::
 		we can still suggest that the user push to either
 		refs/heads/* or refs/tags/* based on the type of the
 		source object.
+	pushRefNeedsUpdate::
+		Shown when linkgit:git-push[1] rejects a forced update of
+		a branch when its remote-tracking ref has updates that we
+		do not have locally.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index f5e5b38c68..21b256e0a4 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -114,3 +114,9 @@ push.recurseSubmodules::
 	specifying '--recurse-submodules=check|on-demand|no'.
 	If not set, 'no' is used by default, unless 'submodule.recurse' is
 	set (in which case a 'true' value means 'on-demand').
+
+push.useForceIfIncludes::
+	If set to "true", it is equivalent to specifying
+	`--force-if-includes` as an option to linkgit:git-push[1]
+	in the command line. Adding `--no-force-if-includes` at the
+	time of push overrides this configuration setting.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3b8053447e..ab103c82cf 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
 	   [-u | --set-upstream] [-o <string> | --push-option=<string>]
 	   [--[no-]signed|--signed=(true|false|if-asked)]
-	   [--force-with-lease[=<refname>[:<expect>]]]
+	   [--force-with-lease[=<refname>[:<expect>]] [--force-if-includes]]
 	   [--no-verify] [<repository> [<refspec>...]]
 
 DESCRIPTION
@@ -320,6 +320,14 @@ seen and are willing to overwrite, then rewrite history, and finally
 force push changes to `master` if the remote version is still at
 `base`, regardless of what your local `remotes/origin/master` has been
 updated to in the background.
++
+Alternatively, specifying `--force-if-includes` as an ancillary option
+along with `--force-with-lease[=<refname>]` (i.e., without saying what
+exact commit the ref on the remote side must be pointing at, or which
+refs on the remote side are being protected) at the time of "push" will
+verify if updates from the remote-tracking refs that may have been
+implicitly updated in the background are integrated locally before
+allowing a forced update.
 
 -f::
 --force::
@@ -341,6 +349,22 @@ one branch, use a `+` in front of the refspec to push (e.g `git push
 origin +master` to force a push to the `master` branch). See the
 `<refspec>...` section above for details.
 
+--[no-]force-if-includes::
+	Force an update only if the tip of the remote-tracking ref
+	has been integrated locally.
++
+This option enables a check that verifies if the tip of the
+remote-tracking ref is reachable from one of the "reflog" entries of
+the local branch based in it for a rewrite. The check ensures that any
+updates from the remote have been incorporated locally by rejecting the
+forced update if that is not the case.
++
+If the option is passed without specifying `--force-with-lease`, or
+specified along with `--force-with-lease=<refname>:<expect>`, it is
+a "no-op".
++
+Specifying `--no-force-if-includes` disables this behavior.
+
 --repo=<repository>::
 	This option is equivalent to the <repository> argument. If both
 	are specified, the command-line argument takes precedence.
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 0b0eb1d025..7813e8470e 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -13,6 +13,46 @@ setup_srcdst_basic () {
 	)
 }
 
+# For tests with "--force-if-includes".
+setup_src_dup_dst () {
+	rm -fr src dup dst &&
+	git init --bare dst &&
+	git clone --no-local dst src &&
+	git clone --no-local dst dup
+	(
+		cd src &&
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+		git push origin
+	) &&
+	(
+		cd dup &&
+		git fetch &&
+		git merge origin/master &&
+		git switch -c branch master~2 &&
+		test_commit D &&
+		test_commit E &&
+		git push origin --all
+	) &&
+	(
+		cd src &&
+		git switch master &&
+		git fetch --all &&
+		git branch branch --track origin/branch &&
+		git rebase origin/master
+	) &&
+	(
+		cd dup &&
+		git switch master &&
+		test_commit F &&
+		test_commit G &&
+		git switch branch &&
+		test_commit H &&
+		git push origin --all
+	)
+}
+
 test_expect_success setup '
 	# create template repository
 	test_commit A &&
@@ -256,4 +296,101 @@ test_expect_success 'background updates of REMOTE can be mitigated with a non-up
 	)
 '
 
+test_expect_success 'background updates to remote can be mitigated with "--force-if-includes"' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	git ls-remote dst refs/heads/master >expect.master &&
+	git ls-remote dst refs/heads/branch >expect.branch &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit I &&
+		git switch master &&
+		test_commit J &&
+		git fetch --all &&
+		test_must_fail git push --force-with-lease --force-if-includes --all
+	) &&
+	git ls-remote dst refs/heads/master >actual.master &&
+	git ls-remote dst refs/heads/branch >actual.branch &&
+	test_cmp expect.master actual.master &&
+	test_cmp expect.branch actual.branch
+'
+
+test_expect_success 'background updates to remote can be mitigated with "push.useForceIfIncludes"' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	git ls-remote dst refs/heads/master >expect.master &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit I &&
+		git switch master &&
+		test_commit J &&
+		git fetch --all &&
+		git config --local push.useForceIfIncludes true &&
+		test_must_fail git push --force-with-lease=master origin master
+	) &&
+	git ls-remote dst refs/heads/master >actual.master &&
+	test_cmp expect.master actual.master
+'
+
+test_expect_success '"--force-if-includes" should be disabled for --force-with-lease="<refname>:<expect>"' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	git ls-remote dst refs/heads/master >expect.master &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit I &&
+		git switch master &&
+		test_commit J &&
+		remote_head="$(git rev-parse refs/remotes/origin/master)" &&
+		git fetch --all &&
+		test_must_fail git push --force-if-includes --force-with-lease="master:$remote_head" 2>err &&
+		grep "stale info" err
+	) &&
+	git ls-remote dst refs/heads/master >actual.master &&
+	test_cmp expect.master actual.master
+'
+
+test_expect_success '"--force-if-includes" should allow forced update after a rebase ("pull --rebase")' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit I &&
+		git switch master &&
+		test_commit J &&
+		git pull --rebase origin master &&
+		git push --force-if-includes --force-with-lease="master"
+	)
+'
+
+test_expect_success '"--force-if-includes" should allow forced update after a rebase ("pull --rebase", local rebase)' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit I &&
+		git switch master &&
+		test_commit J &&
+		git pull --rebase origin master &&
+		git rebase --onto HEAD~4 HEAD~1 &&
+		git push --force-if-includes --force-with-lease="master"
+	)
+'
+
+test_expect_success '"--force-if-includes" should allow deletes' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		git pull --rebase origin branch &&
+		git push --force-if-includes --force-with-lease="branch" origin :branch
+	)
+'
+
 test_done
-- 
2.28.0

