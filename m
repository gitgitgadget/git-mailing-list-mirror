Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FA332022A
	for <e@80x24.org>; Mon, 31 Oct 2016 22:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965036AbcJaWjD (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 18:39:03 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35035 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965025AbcJaWi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 18:38:59 -0400
Received: by mail-pf0-f174.google.com with SMTP id s8so83232363pfj.2
        for <git@vger.kernel.org>; Mon, 31 Oct 2016 15:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jeJF3Fffnt7v4FzAoKlQ04mDOqGKKofkfsvp5XicdhU=;
        b=JivrhtBQOILKa96smegQBQCpbAEzjYI8WsMuzVxo4L4e0slc8F2YqJmIgI/hVX+xUJ
         lW0myzOT3W1/hN9gqbJCl8ocBF1B7lxe+ntmVT7LKZ4K2mMHE5nFzYfbLO9ZqTN1f9px
         IDuq3EnZtofD0C3blyFI3FxfTmU1aEAmdIhrUapgGBhf+eAw4xmrlE1wY2/PS9QOItEO
         xd/lYHnrShZxrOg3Gz3FDxteVWFTeDk9MmdsGT19mxwvEEJ69UguWM2bXA3x5F8KUiZk
         lSWnbizDv8Elh/nePzD+F6Q1rPJWFJPQzuj5+BQZbtAaakyfYEVhQBWy3pTGeRyQw46r
         lhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jeJF3Fffnt7v4FzAoKlQ04mDOqGKKofkfsvp5XicdhU=;
        b=EoE/RjVqhlmfzyo5+RV8iToqhuj5+coL6UNJ2EVRoE6SgB0So6CxEv1yzyG2tRZxV+
         yXUaAW/RhzJc5CArwTskBW2HcWsKNoNRQGxLJUJ+RpbrJfSVgSZ0d0cMoW8OfgANZS3p
         g0ZpubdwgHksznavPlML1dn5y9Ab+15qqrp3BxG43GfNlmHip4Xrl2pXzJGPtz4SY8n5
         Jb6MsMXHTe+q1/W2N/t6LWEOz9cSIeoy2MjDEi3+CtKYKJKeALFGbM4yGGo/+Z8VKFBp
         dpYmhq7mYcbETQKC8eCbInBfZkmVLMG4VaYLZO17rcTRI2uDx1UsdKSRmQgRNK0DQcdA
         6yHw==
X-Gm-Message-State: ABUngvdNm2cRn6uVysW1UUXq2dXMHEtIBw1OloOH9heaPkoBPtsesMVFu69wQp4XUux1koQn
X-Received: by 10.99.170.79 with SMTP id x15mr44292969pgo.105.1477953538285;
        Mon, 31 Oct 2016 15:38:58 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id uh10sm37847280pab.5.2016.10.31.15.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 15:38:57 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, sbeller@google.com
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 6/6] grep: search history of moved submodules
Date:   Mon, 31 Oct 2016 15:38:16 -0700
Message-Id: <1477953496-103596-7-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1477953496-103596-1-git-send-email-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
 <1477953496-103596-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a submodule was renamed at any point since it's inception then if you
were to try and grep on a commit prior to the submodule being moved, you
wouldn't be able to find a working directory for the submodule since the
path in the past is different from the current path.

This patch teaches grep to find the .git directory for a submodule in
the parents .git/modules/ directory in the event the path to the
submodule in the commit that is being searched differs from the state of
the currently checked out commit.  If found, the child process that is
spawned to grep the submodule will chdir into its gitdir instead of a
working directory.

In order to override the explicit setting of submodule child process's
gitdir environment variable (which was introduced in '10f5c526')
`GIT_DIR_ENVIORMENT` needs to be pushed onto child process's env_array.
This allows the searching of history from a submodule's gitdir, rather
than from a working directory.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/grep.c                     | 18 +++++++++++++----
 t/t7814-grep-recurse-submodules.sh | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2f10930..032d476 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -548,6 +548,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 		name = gs->name;
 
 	prepare_submodule_repo_env(&cp.env_array);
+	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
 
 	/* Add super prefix */
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
@@ -612,10 +613,19 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 {
 	if (!(is_submodule_initialized(path) &&
 	      is_submodule_checked_out(path))) {
-		warning("skiping submodule '%s%s' since it is not initialized and checked out",
-			super_prefix ? super_prefix : "",
-			path);
-		return 0;
+		/*
+		 * If searching history, check for the presense of the
+		 * submodule's gitdir before skipping the submodule.
+		 */
+		if (sha1) {
+			path = git_path("modules/%s",
+					submodule_from_path(null_sha1, path)->name);
+
+			if(!(is_directory(path) && is_git_directory(path)))
+				return 0;
+		} else {
+			return 0;
+		}
 	}
 
 #ifndef NO_PTHREADS
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 3d1892d..ee173ad 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -127,6 +127,47 @@ test_expect_success 'grep tree and pathspecs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep history with moved submoules' '
+	git init parent &&
+	echo "foobar" >parent/file &&
+	git -C parent add file &&
+	git -C parent commit -m "add file" &&
+
+	git init sub &&
+	echo "foobar" >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+
+	git -C parent submodule add ../sub &&
+	git -C parent commit -m "add submodule" &&
+
+	cat >expect <<-\EOF &&
+	file:foobar
+	sub/file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules > actual &&
+	test_cmp expect actual &&
+
+	git -C parent mv sub sub-moved &&
+	git -C parent commit -m "moved submodule" &&
+
+	cat >expect <<-\EOF &&
+	file:foobar
+	sub-moved/file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules > actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	HEAD^:file:foobar
+	HEAD^:sub/file:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules HEAD^ > actual &&
+	test_cmp expect actual &&
+
+	rm -rf parent sub
+'
+
 test_incompatible_with_recurse_submodules ()
 {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
-- 
2.8.0.rc3.226.g39d4020

