Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0894C388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 21:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02A0216FD
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 21:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="AHxXxK5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgKLVCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 16:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgKLVCW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 16:02:22 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BAFC0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 13:02:20 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id r12so3520530qvq.13
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 13:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qtNM/p728mGUBjNJZyxAbRSgmYbQeIYFOF+mstAAnsk=;
        b=AHxXxK5vrzyZg+hjiJMnTUeEnhKxE5sBgCPSJiHOWBaSIRrksi+zZ74cd5exdKxo5F
         KUf4nR4hpGz5UT82IZn+NI5xN2EewWUJmolBe7pNQamidskhhmfoOVCLOr6yMgBbkIdS
         8/bc9hENcwFQ5c90Kz0KGX27ioFcPZaohdg4YE96T8CnoT7M1EoB58vk9R8W6woliLWN
         +V/3tBr6DsjLDMIIjZQm6jj3XcWc+1YT+flGSfo57cyTDZtf5J/x3q2eDnj1ngPq8etO
         xv6G9QFN42Sd97sTZKCq3FEUEoe8ddG+isNrK5IWkj7MIRxuw/b5CQPQ2zuZltuLCxHE
         ittg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qtNM/p728mGUBjNJZyxAbRSgmYbQeIYFOF+mstAAnsk=;
        b=Z7Hy40g/j0X26KdbKANaLITBzgxnBSaChMn2dwhaEr+LBaHZWunAKTR0V6CMMWX6Df
         /8fcEM6zXZ9jCMysdvy/nODRXKcN020GqoFVzDoiVBCuTHi9BxRqd7WiFZ1Tp1bEJtzJ
         vgMItT/HfJoN82pw9/reUZkdXaA3aJpd1fhS5GgAxtdNU/DLZX4k0Hgrt9Rcw+BQrJ2z
         jO3dPZ1oiDtc/KMUHlEC1JOlcV8trKeNua+k7F2Rj2xs67r8LHK5cTFU9iLQ6/QeELvY
         UDZQWyjel/YQxO9iOvCV9/kXr3P2mc6qFaJaxOixC/4+3PiiiJHnTHrTrfZZTVhFXeCT
         467w==
X-Gm-Message-State: AOAM5320Oy52YPmSJrtQS9/S7AXBm0JmFFZujz1QZ3xVBj2RtX8dYoOf
        UZAHwfqevTC5USUyBU/aApK+OKiFkst0eg==
X-Google-Smtp-Source: ABdhPJyX/CCj4Dfu9eooFgCTSrV5//2Id0uA+llOg8aQLBHZq+X3KS5NRho1N/ucDZTZq7P9IZmnSg==
X-Received: by 2002:a05:6214:12e8:: with SMTP id w8mr1439244qvv.16.1605214939395;
        Thu, 12 Nov 2020 13:02:19 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id w5sm5626859qkf.31.2020.11.12.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:02:17 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com
Subject: [PATCH] rm: honor sparse checkout patterns
Date:   Thu, 12 Nov 2020 18:01:09 -0300
Message-Id: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
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

This is based on mt/grep-sparse-checkout.
Original feature request: https://github.com/gitgitgadget/git/issues/786

 Documentation/config/sparse.txt  |  3 ++-
 Documentation/git-rm.txt         |  9 +++++++++
 builtin/rm.c                     |  7 ++++++-
 t/t3600-rm.sh                    | 22 ++++++++++++++++++++++
 t/t7011-skip-worktree-reading.sh |  5 -----
 5 files changed, 39 insertions(+), 7 deletions(-)

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
index ab750367fd..25dda8ff35 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -25,6 +25,15 @@ When `--cached` is given, the staged content has to
 match either the tip of the branch or the file on disk,
 allowing the file to be removed from just the index.
 
+CONFIGURATION
+-------------
+
+sparse.restrictCmds::
+	By default, git-rm only matches and removes paths within the
+	sparse-checkout patterns. This behavior can be changed with the
+	`sparse.restrictCmds` setting or the global
+	`--no-restrict-to-sparse-paths` option. For more details, see the
+	full `sparse.restrictCmds` definition in linkgit:git-config[1].
 
 OPTIONS
 -------
diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f..e1fe71c321 100644
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
 
@@ -293,8 +294,12 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	seen = xcalloc(pathspec.nr, 1);
 
+	sparse_paths_only = restrict_to_sparse_paths(the_repository);
+
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
+		if (sparse_paths_only && ce_skip_worktree(ce))
+			continue;
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index efec8d13b6..7bf55b42eb 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -892,4 +892,26 @@ test_expect_success 'rm empty string should fail' '
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
 test_done
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
2.28.0

