Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29020C4742C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 13:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A0222265
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 13:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="K26eKPr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgKPN6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 08:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgKPN6X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 08:58:23 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46028C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 05:58:23 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id v20so5468034qvx.4
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 05:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mpTeIbCsm+ceLE8xkZvFXPiFKeg6LcFwj71mdAfAGZI=;
        b=K26eKPr5jv9rnj5YyJ3shfhmDIcTEmDnUdgnvzJYZ+8lTRX5C0sPTPou2s9pplQ2Kd
         RkSsrOlDE0nhwHaIoSmlD8OzeYZtjRAPOa2V80nLHUmb5O/Y32k1gstQu98fvckKIASw
         eCC3bUVlKlV2liRkrZ4kz0Ybl0ZUD2MwTw3SuTcnddZZiKqkEmsMR5hmskCwaLNDdL7i
         A0ldirlI5Mxrximk53uRvr9I321YmaBpJWb91aAzUzNoW1W6kAm9HaWI6JD1qNYfixqX
         RElHSwWvgsAuBw+emG6C2rKFc7OrzEedpD2YaBqI3h23p/3MdVqdptE4N1uZIivA1PXf
         AzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpTeIbCsm+ceLE8xkZvFXPiFKeg6LcFwj71mdAfAGZI=;
        b=abJ/dqi+6WDJ87hYvY24kwX0xhLVg8linV+PEP+Sb0nIofse/Ax0PqJW5EpmSbfMdO
         Fei8j/chpd15wlngy0PV/fAA88claKxwJF706ngQOiNT3VUAc/SkUa5heExfTLEbfl6q
         MK85buVo0SstVx+D1zNdJY84L2q0CbmY+LCCphdsKjEhchDCjpgyWiGo67bKVFTX/6m8
         WtIkvg6UyPbjudT3pAKC1wLBB/zsxxl0JggI+ijEgQDSpfajFtVLmqBYHgNOMYxp+j5R
         iMjNXZ7eST0gzIQHjIP+29hl5IjtJXSTm7xOyt8Hb3L09X1+3RGjDHOqMFjL204gAqqK
         LgPQ==
X-Gm-Message-State: AOAM531NwhYJSyhMLwWldYOaHZZULwJeK1AAYQHzWtglddkZSvCQFJQm
        YsiKUZPeMPN79PalUtqoCBdFnjgvCaWIMA==
X-Google-Smtp-Source: ABdhPJxnmoES9I2vJKy2dBr6q+UpX9L1NKIb/qCOigX7v/D6drFHscBYOXEt++9AsPYZbwsK0GViGA==
X-Received: by 2002:ad4:53c8:: with SMTP id k8mr15696267qvv.40.1605535101807;
        Mon, 16 Nov 2020 05:58:21 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id 199sm12350006qkm.62.2020.11.16.05.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 05:58:21 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com
Subject: [PATCH v2] rm: honor sparse checkout patterns
Date:   Mon, 16 Nov 2020 10:58:06 -0300
Message-Id: <c17158e3b105d7c0679515446c5fd7b8d5fc8435.1605535068.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make git-rm honor the 'sparse.restrictCmds' setting, by restricting its
operation to the paths that match both the command line pathspecs and
the repository's sparsity patterns. This better matches the expectations
of users with sparse-checkout definitions, while still allowing them
to optionally enable the old behavior with 'sparse.restrictCmds=false'
or the global '--no-restrict-to-sparse-paths' option.

Suggested-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Based on mt/grep-sparse-checkout.

Changes since v1:
- Reworded git-rm docs to avoid confusion for those who never used
  sparse-checkout.
- Included an advice about disabling sparse.restrictCmds when the
  given pathspec doesn't match any files and sparse-checkout is enabled.
- Added test for `git rm -r` removing a dir that is only partially
  included in the sparse-checkout.
- Adjusted test in t7011 to use `-c sparse.restrictCmds=false`, instead
  of removing it.

 Documentation/config/sparse.txt  |  3 +-
 Documentation/git-rm.txt         | 10 +++++++
 builtin/rm.c                     | 24 ++++++++++------
 t/t3600-rm.sh                    | 47 ++++++++++++++++++++++++++++++++
 t/t7011-skip-worktree-reading.sh |  4 +--
 5 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
index 494761526e..79d7d173e9 100644
--- a/Documentation/config/sparse.txt
+++ b/Documentation/config/sparse.txt
@@ -12,7 +12,8 @@ When this option is true (default), some git commands may limit their behavior
 to the paths specified by the sparsity patterns, or to the intersection of
 those paths and any (like `*.c`) that the user might also specify on the
 command line. When false, the affected commands will work on full trees,
-ignoring the sparsity patterns. For now, only git-grep honors this setting.
+ignoring the sparsity patterns. For now, only git-grep and git-rm honor this
+setting.
 +
 Note: commands which export, integrity check, or create history will always
 operate on full trees (e.g. fast-export, format-patch, fsck, commit, etc.),
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index ab750367fd..33bec8c249 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -25,6 +25,16 @@ When `--cached` is given, the staged content has to
 match either the tip of the branch or the file on disk,
 allowing the file to be removed from just the index.
 
+CONFIGURATION
+-------------
+
+sparse.restrictCmds::
+	When sparse-checkouts are in use, by default git-rm will only
+	match and remove paths within the sparse-checkout patterns.
+	This behavior can be changed with the `sparse.restrictCmds`
+	setting or the global `--no-restrict-to-sparse-paths` option.
+	For more details, see the full `sparse.restrictCmds` definition
+	in linkgit:git-config[1].
 
 OPTIONS
 -------
diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f..90f6bb4cae 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -14,6 +14,7 @@
 #include "string-list.h"
 #include "submodule.h"
 #include "pathspec.h"
+#include "sparse-checkout.h"
 
 static const char * const builtin_rm_usage[] = {
 	N_("git rm [<options>] [--] <file>..."),
@@ -254,7 +255,7 @@ static struct option builtin_rm_options[] = {
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	struct lock_file lock_file = LOCK_INIT;
-	int i;
+	int i, sparse_paths_only;
 	struct pathspec pathspec;
 	char *seen;
 
@@ -293,8 +294,13 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	seen = xcalloc(pathspec.nr, 1);
 
+	sparse_paths_only = core_apply_sparse_checkout &&
+			    restrict_to_sparse_paths(the_repository);
+
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
+		if (sparse_paths_only && ce_skip_worktree(ce))
+			continue;
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
@@ -310,14 +316,16 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		int seen_any = 0;
 		for (i = 0; i < pathspec.nr; i++) {
 			original = pathspec.items[i].original;
-			if (!seen[i]) {
-				if (!ignore_unmatch) {
-					die(_("pathspec '%s' did not match any files"),
-					    original);
-				}
-			}
-			else {
+			if (seen[i]) {
 				seen_any = 1;
+			} else if (!ignore_unmatch) {
+				const char *sparse_config_advice =
+					_("; disable sparse.restrictCmds if you intend to edit"
+					  " outside the current sparse-checkout definition");
+
+				die(_("pathspec '%s' did not match any files%s"),
+				    original,
+				    sparse_paths_only ? sparse_config_advice : "");
 			}
 			if (!recursive && seen[i] == MATCHED_RECURSIVELY)
 				die(_("not removing '%s' recursively without -r"),
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index efec8d13b6..25cd7187fa 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -892,4 +892,51 @@ test_expect_success 'rm empty string should fail' '
 	test_must_fail git rm -rf ""
 '
 
+test_expect_success 'rm should respect --[no]-restrict-to-sparse-paths' '
+	git init sparse-repo &&
+	(
+		cd sparse-repo &&
+		touch a b c &&
+		git add -A &&
+		git commit -m files &&
+		git sparse-checkout set "/a" &&
+
+		# By default, it should not rm paths outside the sparse-checkout
+		test_must_fail git rm b 2>stderr &&
+		test_i18ngrep "fatal: pathspec .b. did not match any files" stderr &&
+		test_i18ngrep "disable sparse.restrictCmds if you intend to edit outside" stderr &&
+
+		# But it should rm them with --no-restrict-to-sparse-paths
+		git --no-restrict-to-sparse-paths rm b &&
+
+		# And also with sparse.restrictCmds=false
+		git reset &&
+		git -c sparse.restrictCmds=false rm b
+	)
+'
+
+test_expect_success 'recursive rm should respect --[no]-restrict-to-sparse-paths' '
+	git init sparse-repo-2 &&
+	(
+		cd sparse-repo-2 &&
+		mkdir -p sub/dir &&
+		touch sub/f1 sub/dir/f2 &&
+		git add -A &&
+		git commit -m files &&
+		git sparse-checkout set "sub/dir" &&
+
+		git rm -r sub &&
+		echo "D  sub/dir/f2" >expected &&
+		git status --porcelain -uno >actual &&
+		test_cmp expected actual &&
+
+		git reset &&
+		git --no-restrict-to-sparse-paths rm -r sub &&
+		echo "D  sub/dir/f2" >expected-no-restrict &&
+		echo "D  sub/f1"     >>expected-no-restrict &&
+		git status --porcelain -uno >actual-no-restrict &&
+		test_cmp expected-no-restrict actual-no-restrict
+	)
+'
+
 test_done
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index 26852586ac..08ede90e14 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -132,9 +132,9 @@ test_expect_success 'diff-files does not examine skip-worktree dirty entries' '
 	test -z "$(git diff-files -- one)"
 '
 
-test_expect_success 'git-rm succeeds on skip-worktree absent entries' '
+test_expect_success 'git-rm succeeds on skip-worktree absent entries when sparse.restrictCmds=false' '
 	setup_absent &&
-	git rm 1
+	git -c sparse.restrictCmds=false rm 1
 '
 
 test_expect_success 'commit on skip-worktree absent entries' '
-- 
2.28.0

