Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E512DC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B523B6115B
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhDHUmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbhDHUmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 16:42:09 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C99C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 13:41:56 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id i9so1422329qvo.3
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5gIvRDDz8Qe/YOR/OuJc/6t5q7IAUPDyk5yc8yfa/o=;
        b=NPLMOnK+gd/v07ooSNXPR/1wY8P/dq+QaiXFU1wc4/YRHlUm9HF7Y2Mrf3f3mZqbTW
         4LKAofjktGVllZkp8+Xucae0aGTW7t2Qtz+HtsqvhyUzjlpAPshyhQ+K+qeD22EfAcKn
         0+0/YU1VdiYkKpta4eomrbvQ6xVPrn34SmYaQa2Un1j7l1Awto6Oc7TdlKko4fDHvxiZ
         9gkqCe1KpObMAyfX6E2jHNHnRFraeuacBW7EL4J4LI7IZfHQu8/Mfz8PeasRTEtNlveo
         CkJv08bWG39WzVm+UpSwGJ7LHfcRTYnN67D5DjzKOSKP7IklWyhwzFE+lEaFS1HbiiqV
         M5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5gIvRDDz8Qe/YOR/OuJc/6t5q7IAUPDyk5yc8yfa/o=;
        b=HNDZ9HRChSY+JH9pZhVk2mOuIZsxzlft/hrADAgeTf6WFrgnhin9YyMf/kUqaxfnPY
         8ceGyt3V4wehR09vQ1ahZinlM/Qwa3zFGFU39DBzfTUkch6sM8HYtn54S5BMDk9CeIFe
         sH9XswmxYZ4n4ZEdngTLClExw5pzl6D1Uq8ptITExqqWD16tBRsNzbGr/Pf7EXfzV997
         41RyGiEPH1QR6eNW0MKctsu0faUBuXxBzRfxvP8/usUfXEDoTUhlgVsHPtLi2vez5mJY
         yD4HWTGbQTx7WcebzSIu0kTPl7nkZTl44k9+j2UYOFfr313J9xc7ZVCN4OYIQxlLTLLG
         7dhg==
X-Gm-Message-State: AOAM530PAq2tAQKSEEJg9hEg/LVyqN+UQnUXMYnvO0dRqqa5LByrVCvm
        BjKahyevezbI07RWMNYIUj097ZjKVdASnA==
X-Google-Smtp-Source: ABdhPJw3OYWmWPVD6GOxNcKSxPMcWKsqPHQOW0leK3j36M3XzAIfkQkUetc8rPQvynvOj3WCLxxaUA==
X-Received: by 2002:a0c:ca87:: with SMTP id a7mr3092468qvk.62.1617914515441;
        Thu, 08 Apr 2021 13:41:55 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id c73sm384733qkg.6.2021.04.08.13.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:41:55 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, stolee@gmail.com
Subject: [PATCH v4 7/7] rm: honor sparse checkout patterns
Date:   Thu,  8 Apr 2021 17:41:28 -0300
Message-Id: <4459976ae9c508509c3989ba6684eecc7e051fc9.1617914011.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617914011.git.matheus.bernardino@usp.br>
References: <cover.1617914011.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git add` refrains from adding or updating index entries that are
outside the current sparse checkout, but `git rm` doesn't follow the
same restriction. This is somewhat counter-intuitive and inconsistent.
So make `rm` honor the sparsity rules and advise on how to remove
SKIP_WORKTREE entries just like `add` does. Also add some tests for the
new behavior.

Suggested-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config/advice.txt  |  5 +-
 Documentation/git-rm.txt         |  4 +-
 builtin/rm.c                     | 35 +++++++++-----
 t/t3602-rm-sparse-checkout.sh    | 78 ++++++++++++++++++++++++++++++++
 t/t7011-skip-worktree-reading.sh |  5 --
 5 files changed, 108 insertions(+), 19 deletions(-)
 create mode 100755 t/t3602-rm-sparse-checkout.sh

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 851b83cf30..8b2849ff7b 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -120,6 +120,7 @@ advice.*::
 		Advice shown if a user runs the add command without providing
 		the pathspec parameter.
 	updateSparsePath::
-		Advice shown when linkgit:git-add[1] is asked to update index
-		entries outside the current sparse checkout.
+		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
+		is asked to update index entries outside the current sparse
+		checkout.
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
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
new file mode 100755
index 0000000000..e9e9a15c74
--- /dev/null
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='git rm in sparse checked out working trees'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' "
+	mkdir -p sub/dir &&
+	touch a b c sub/d sub/dir/e &&
+	git add -A &&
+	git commit -m files &&
+
+	cat >sparse_error_header <<-EOF &&
+	The following pathspecs didn't match any eligible path, but they do match index
+	entries outside the current sparse checkout:
+	EOF
+
+	cat >sparse_hint <<-EOF &&
+	hint: Disable or modify the sparsity rules if you intend to update such entries.
+	hint: Disable this message with \"git config advice.updateSparsePath false\"
+	EOF
+
+	echo b | cat sparse_error_header - >sparse_entry_b_error &&
+	cat sparse_entry_b_error sparse_hint >b_error_and_hint
+"
+
+for opt in "" -f --dry-run
+do
+	test_expect_success "rm${opt:+ $opt} does not remove sparse entries" '
+		git sparse-checkout set a &&
+		test_must_fail git rm $opt b 2>stderr &&
+		test_cmp b_error_and_hint stderr &&
+		git ls-files --error-unmatch b
+	'
+done
+
+test_expect_success 'recursive rm does not remove sparse entries' '
+	git reset --hard &&
+	git sparse-checkout set sub/dir &&
+	git rm -r sub &&
+	git status --porcelain -uno >actual &&
+	echo "D  sub/dir/e" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rm obeys advice.updateSparsePath' '
+	git reset --hard &&
+	git sparse-checkout set a &&
+	test_must_fail git -c advice.updateSparsePath=false rm b 2>stderr &&
+	test_cmp sparse_entry_b_error stderr
+'
+
+test_expect_success 'do not advice about sparse entries when they do not match the pathspec' '
+	git reset --hard &&
+	git sparse-checkout set a &&
+	test_must_fail git rm nonexistent 2>stderr &&
+	grep "fatal: pathspec .nonexistent. did not match any files" stderr &&
+	! grep -F -f sparse_error_header stderr
+'
+
+test_expect_success 'do not warn about sparse entries when pathspec matches dense entries' '
+	git reset --hard &&
+	git sparse-checkout set a &&
+	git rm "[ba]" 2>stderr &&
+	test_must_be_empty stderr &&
+	git ls-files --error-unmatch b &&
+	test_must_fail git ls-files --error-unmatch a
+'
+
+test_expect_success 'do not warn about sparse entries with --ignore-unmatch' '
+	git reset --hard &&
+	git sparse-checkout set a &&
+	git rm --ignore-unmatch b 2>stderr &&
+	test_must_be_empty stderr &&
+	git ls-files --error-unmatch b
+'
+
+test_done
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 26852586ac..1761a2b1b9 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -132,11 +132,6 @@ test_expect_success 'diff-files does not examine skip-worktree dirty entries' '
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
2.30.1

