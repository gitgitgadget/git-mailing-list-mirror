Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4C1C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B227464E7A
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhBQVEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhBQVEC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:04:02 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E18C061793
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:03:09 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id h8so33298qkk.6
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZA/aBBmrTcvTv505cVVfcbJfxu1v1A507x3c1UtuzKI=;
        b=zRfl3ZUJ274ziDtxctkevEY3QxZEqXKNMQ4IBMY6B+UaP+jrCRvqgAltJF9NAn8u4h
         tSqF7Z1AK6v9WUDXBLAi+gIDqcO/iaDA8eHiOO0njCEngusdVzIRXcgS+wNxC8yR6FgQ
         hLYqHfAFrDFFpIXcL2nITENLg40uNvnGFA5zRe2BZA4UW+32Yyr9En4vjhZ1juHhAOuS
         rRPVR4nF/08qjHxSv2V+vBj48+b2VmnFG3/ZsA+NSZXwEjrrnyM3nzpC4xWZHEDTJwhC
         5/Bd8NwUjZQjLZP/hxHTgfzDKPRysaH8KxBTqzXQbVLOu6B4XodHvgTS49zwElV5Eo5+
         iIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZA/aBBmrTcvTv505cVVfcbJfxu1v1A507x3c1UtuzKI=;
        b=SYlz4lh2GK50L+W2xsX+KqEgN7Pqz+tfWfMWOu+u+9cwl/Cx9MQlhLwiigmQPegZm1
         UQzryWNrStGRKAbCJzaQyszQkhr0W/MfwNwhiOKis+xxAOxp+RyC1DS7Bq7m3s5kHkS0
         XxRaWTlhL75BxjHDER6nfgk9LeDK0qAitCVe21l9E6cr151PovgVuVOBphZl7iPMa3cq
         lqil3kqRa9U7NVwswn0ANg2cuD9G3dowNyzP57C+dGJvj0CeFpxZINTrfHlgpc1nGCOv
         oFC77UwRGVyvKyN6dvX9NMOKtQ0c18KbLQPZ8T7POFZk0RMGunSKHJx46v0B6gR9Vu5M
         vRYw==
X-Gm-Message-State: AOAM531ICn9ffd1P+Ttpqr+SpvSA/sJkOCrE6zgZKhaW6COyl/uiziX5
        AcKELt3+W1BSdGD/W4DFDSHhoqXC+4ZxPg==
X-Google-Smtp-Source: ABdhPJx2iXNqBfj3Lg22P/hBIuekWQ6SS0RPkR4YHyHVs5kayCc21xPwlubTX6cAbSeJtQzsnCxe4A==
X-Received: by 2002:a37:78f:: with SMTP id 137mr1189954qkh.208.1613595788175;
        Wed, 17 Feb 2021 13:03:08 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o194sm2438459qke.101.2021.02.17.13.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:03:07 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com
Subject: [RFC PATCH 7/7] rm: honor sparse checkout patterns
Date:   Wed, 17 Feb 2021 18:02:30 -0300
Message-Id: <61a77cd5f45ba02c7dff4b7932abdebb17c1667f.1613593946.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613593946.git.matheus.bernardino@usp.br>
References: <cover.1613593946.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git add` refrains from adding or updating paths outside the sparsity
rules, but `git rm` doesn't follow the same restrictions. This is
somewhat counter-intuitive and inconsistent. So make `rm` honor the
sparse checkout and advise on how to remove SKIP_WORKTREE entries, just
like `add` does. Also add a few tests for the new behavior.

Suggested-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config/advice.txt  |  5 +--
 Documentation/git-rm.txt         |  4 ++-
 builtin/rm.c                     | 35 ++++++++++++++-------
 t/t3600-rm.sh                    | 54 ++++++++++++++++++++++++++++++++
 t/t7011-skip-worktree-reading.sh |  5 ---
 5 files changed, 84 insertions(+), 19 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index d53eafa00b..bdd423ade4 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -120,6 +120,7 @@ advice.*::
 		Advice shown if a user runs the add command without providing
 		the pathspec parameter.
 	updateSparsePath::
-		Advice shown if the pathspec given to linkgit:git-add[1] only
-		matches index entries outside the current sparse-checkout.
+		Advice shown if the pathspec given to linkgit:git-add[1] or
+		linkgit:git-rm[1] only matches index entries outside the
+		current sparse-checkout.
 --
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index ab750367fd..26e9b28470 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -23,7 +23,9 @@ branch, and no updates to their contents can be staged in the index,
 though that default behavior can be overridden with the `-f` option.
 When `--cached` is given, the staged content has to
 match either the tip of the branch or the file on disk,
-allowing the file to be removed from just the index.
+allowing the file to be removed from just the index. When
+sparse-checkouts are in use (see linkgit:git-sparse-checkout[1]),
+`git rm` will only remove paths within the sparse-checkout patterns.
 
 
 OPTIONS
diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f..d23a3b2164 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
+#include "advice.h"
 #include "config.h"
 #include "lockfile.h"
 #include "dir.h"
@@ -254,7 +255,7 @@ static struct option builtin_rm_options[] = {
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	struct lock_file lock_file = LOCK_INIT;
-	int i;
+	int i, ret = 0;
 	struct pathspec pathspec;
 	char *seen;
 
@@ -295,6 +296,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
+		if (ce_skip_worktree(ce))
+			continue;
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
@@ -308,24 +311,34 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr) {
 		const char *original;
 		int seen_any = 0;
+		char *skip_worktree_seen = NULL;
+		struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
+
 		for (i = 0; i < pathspec.nr; i++) {
 			original = pathspec.items[i].original;
-			if (!seen[i]) {
-				if (!ignore_unmatch) {
-					die(_("pathspec '%s' did not match any files"),
-					    original);
-				}
-			}
-			else {
+			if (seen[i])
 				seen_any = 1;
-			}
+			else if (ignore_unmatch)
+				continue;
+			else if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen))
+				string_list_append(&only_match_skip_worktree, original);
+			else
+				die(_("pathspec '%s' did not match any files"), original);
+
 			if (!recursive && seen[i] == MATCHED_RECURSIVELY)
 				die(_("not removing '%s' recursively without -r"),
 				    *original ? original : ".");
 		}
 
+		if (only_match_skip_worktree.nr) {
+			advise_on_updating_sparse_paths(&only_match_skip_worktree);
+			ret = 1;
+		}
+		free(skip_worktree_seen);
+		string_list_clear(&only_match_skip_worktree, 0);
+
 		if (!seen_any)
-			exit(0);
+			exit(ret);
 	}
 
 	if (!index_only)
@@ -405,5 +418,5 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
 
-	return 0;
+	return ret;
 }
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 7547f11a5c..0e5cf945d9 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -907,4 +907,58 @@ test_expect_success 'rm empty string should fail' '
 	test_must_fail git rm -rf ""
 '
 
+test_expect_success 'setup repo for tests with sparse-checkout' '
+	git init sparse &&
+	(
+		cd sparse &&
+		mkdir -p sub/dir &&
+		touch a b c sub/d sub/dir/e &&
+		git add -A &&
+		git commit -m files
+	) &&
+
+	cat >sparse_entry_b_error <<-EOF &&
+	The following pathspecs only matched index entries outside the current
+	sparse checkout:
+	b
+	EOF
+
+	cat >b_error_and_hint sparse_entry_b_error - <<-EOF
+	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: Disable this message with "git config advice.updateSparsePath false"
+	EOF
+'
+
+test_expect_success 'rm should respect sparse-checkout' '
+	git -C sparse sparse-checkout set "/a" &&
+	test_must_fail git -C sparse rm b 2>stderr &&
+	test_i18ncmp b_error_and_hint stderr
+'
+
+test_expect_success 'rm obeys advice.updateSparsePath' '
+	git -C sparse reset --hard &&
+	git -C sparse sparse-checkout set "/a" &&
+	test_must_fail git -C sparse -c advice.updateSparsePath=false rm b 2>stderr &&
+	test_i18ncmp sparse_entry_b_error stderr
+
+'
+
+test_expect_success 'recursive rm should respect sparse-checkout' '
+	(
+		cd sparse &&
+		git reset --hard &&
+		git sparse-checkout set "sub/dir" &&
+		git rm -r sub &&
+		git status --porcelain -uno >../actual
+	) &&
+	echo "D  sub/dir/e" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
+	test_must_fail git -C sparse rm nonexistent 2>stderr &&
+	test_i18ngrep "fatal: pathspec .nonexistent. did not match any files" stderr &&
+	test_i18ngrep ! "The following pathspecs only matched index entries" stderr
+'
+
 test_done
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 37525cae3a..f87749951f 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -141,11 +141,6 @@ test_expect_success 'diff-files does not examine skip-worktree dirty entries' '
 	test -z "$(git diff-files -- one)"
 '
 
-test_expect_success 'git-rm succeeds on skip-worktree absent entries' '
-	setup_absent &&
-	git rm 1
-'
-
 test_expect_success 'commit on skip-worktree absent entries' '
 	git reset &&
 	setup_absent &&
-- 
2.29.2

