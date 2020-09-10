Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C59C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1AC620C09
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="CXo2Q21I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgIJRYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIJRWV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:22:21 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBBFC06179B
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:22:09 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so5427466qtv.12
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wql2jSbmB/wKgLMAMdl4Eiy44fK9XQwDEfPhW74A0uA=;
        b=CXo2Q21I9CBIqfHtp4uX4HM/RNHCUlPE/NrMLApeL9PrV+JTnhNBQc5CdGhHG3Fwqn
         wjEEaXlPhey05kadu5FY05AhsTUxc+iItWOHxE3jNqrFUhdgX070m+3cDPzgohxBlgeo
         +aXTIDWpkfmxyTYwZc8VpWakDOAUk+0dXRombAeAAgNPAOk7Fkh7P0yfmtWFf+6UDoaa
         lr9AePsRnBfdGp6AZmlHCW2JiOMQUJ6JD++dEr/pl1sZHjeSRYbjClSp+Rx7HC7d3W0V
         Uku++GsMpYWgyr44ajalrX4YWFQM3/4fUok4bHKmfj1gwnBbDTlTYRVgYTmSCF22DeWx
         Hzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wql2jSbmB/wKgLMAMdl4Eiy44fK9XQwDEfPhW74A0uA=;
        b=uh1BE1vmTTUkflK+x/+7VgdWDexBaPeEe/hQqQEqS8YM9Oxnl3zKAYutVk+PfidlAU
         81kG7YnmDd727jui8XQKaSg1RcXbOaSuWQw6TDRhOi+RpBKOSzR80DaDGTU1wCfP+/ka
         OsocMqV979LU/bgLu5jYNTSg4VUBUSk+JcYNjn8Rc0u3R0LsxKtFiFWsvQhkxZ03lAOy
         X+wnZmwh/dc2uts4AAPy+jDpRB4Lq6o3STY9447UHMgBF3DUZNpeJ0o2ZfuQwkqUedHx
         YnrZIdfXmDp0eStx9il1+ZpMdgqVUhLEDWbqMIuIyga4gD74Iq5yKZyZCH/jMNpyZC55
         3Ahg==
X-Gm-Message-State: AOAM533+n2DBOlpY1eoThvfz55q6pkXsCNWn7bmXfMrZ4CG1goc29kZj
        IrYstjaYbsUMcjfDVIbyfJR9w0IkQKQ0bA==
X-Google-Smtp-Source: ABdhPJwZO7XyaFAZAFJWm9IsXaQ3RntQG/c9ppEoIvcKj7YHNHo/QwBW5lDo8/LUOzDA3TRVlrg1Lg==
X-Received: by 2002:ac8:4059:: with SMTP id j25mr8944474qtl.155.1599758528031;
        Thu, 10 Sep 2020 10:22:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id h18sm7037437qkl.12.2020.09.10.10.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:22:07 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v6 9/9] config: add setting to ignore sparsity patterns in some cmds
Date:   Thu, 10 Sep 2020 14:21:28 -0300
Message-Id: <92bc5351cf5fdbf7435ba4d99530d6ce02f957c4.1599758167.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599758167.git.matheus.bernardino@usp.br>
References: <cover.1599758167.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When sparse checkout is enabled, some users expect the output of certain
commands (such as grep, diff, and log) to be also restricted within the
sparsity patterns. This would allow them to effectively work only on the
subset of files in which they are interested; and allow some commands to
possibly perform better, by not considering uninteresting paths. For
this reason, we taught grep to honor the sparsity patterns, in the
previous patch. But, on the other hand, allowing grep and the other
commands mentioned to optionally ignore the patterns also make for some
interesting use cases. E.g. using grep to search for a function
documentation that resides outside the sparse checkout.

In any case, there is no current way for users to configure the behavior
they want for these commands. Aiming to provide this flexibility, let's
introduce the sparse.restrictCmds setting (and the analogous
--[no]-restrict-to-sparse-paths global option). The default value is
true. For now, grep is the only one affected by this setting, but the
goal is to have support for more commands, in the future.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config.txt               |   2 +
 Documentation/config/grep.txt          |   8 ++
 Documentation/config/sparse.txt        |  20 ++++
 Documentation/git.txt                  |   4 +
 Makefile                               |   1 +
 builtin/grep.c                         |  13 ++-
 contrib/completion/git-completion.bash |   2 +
 git.c                                  |   5 +
 sparse-checkout.c                      |  18 ++++
 sparse-checkout.h                      |  11 +++
 t/t7817-grep-sparse-checkout.sh        | 132 ++++++++++++++++++++++++-
 t/t9902-completion.sh                  |   4 +-
 12 files changed, 214 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/config/sparse.txt
 create mode 100644 sparse-checkout.c
 create mode 100644 sparse-checkout.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3042d80978..3b6e0901b8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -438,6 +438,8 @@ include::config/sequencer.txt[]
 
 include::config/showbranch.txt[]
 
+include::config/sparse.txt[]
+
 include::config/splitindex.txt[]
 
 include::config/ssh.txt[]
diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index dd51db38e1..a3275ab4b7 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -28,3 +28,11 @@ grep.fullName::
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
 	is executed outside of a git repository.  Defaults to false.
+
+ifdef::git-grep[]
+sparse.restrictCmds::
+	See base definition in linkgit:git-config[1]. grep honors
+	sparse.restrictCmds by limiting searches to the sparsity paths in three
+	cases: when searching the working tree, when searching the index with
+	--cached, and when searching a specified commit.
+endif::git-grep[]
diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
new file mode 100644
index 0000000000..494761526e
--- /dev/null
+++ b/Documentation/config/sparse.txt
@@ -0,0 +1,20 @@
+sparse.restrictCmds::
+	Only meaningful in conjunction with core.sparseCheckout. This option
+	extends sparse checkouts (which limit which paths are written to the
+	working tree), so that output and operations are also limited to the
+	sparsity paths where possible and implemented. The purpose of this
+	option is to (1) focus output for the user on the portion of the
+	repository that is of interest to them, and (2) enable potentially
+	dramatic performance improvements, especially in conjunction with
+	partial clones.
++
+When this option is true (default), some git commands may limit their behavior
+to the paths specified by the sparsity patterns, or to the intersection of
+those paths and any (like `*.c`) that the user might also specify on the
+command line. When false, the affected commands will work on full trees,
+ignoring the sparsity patterns. For now, only git-grep honors this setting.
++
+Note: commands which export, integrity check, or create history will always
+operate on full trees (e.g. fast-export, format-patch, fsck, commit, etc.),
+unaffected by any sparsity patterns. Also, writing commands such as
+sparse-checkout and read-tree will not be affected by this configuration.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2fc92586b5..d857509573 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -180,6 +180,10 @@ If you just want to run git as if it was started in `<path>` then use
 	Do not perform optional operations that require locks. This is
 	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
 
+--[no-]restrict-to-sparse-paths::
+	Overrides the sparse.restrictCmds configuration (see
+	linkgit:git-config[1]) for this execution.
+
 --list-cmds=group[,group...]::
 	List commands by group. This is an internal/experimental
 	option and may change or be removed in the future. Supported
diff --git a/Makefile b/Makefile
index 65f8cfb236..778c9e499e 100644
--- a/Makefile
+++ b/Makefile
@@ -982,6 +982,7 @@ LIB_OBJS += sha1-name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
+LIB_OBJS += sparse-checkout.o
 LIB_OBJS += split-index.o
 LIB_OBJS += stable-qsort.o
 LIB_OBJS += strbuf.o
diff --git a/builtin/grep.c b/builtin/grep.c
index a32815de0a..3fa364e91c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -25,6 +25,7 @@
 #include "submodule-config.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "sparse-checkout.h"
 
 static char const * const grep_usage[] = {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
@@ -498,6 +499,7 @@ static int grep_cache(struct grep_opt *opt,
 	int nr;
 	struct strbuf name = STRBUF_INIT;
 	int name_base_len = 0;
+	int sparse_paths_only =	restrict_to_sparse_paths(repo);
 	if (repo->submodule_prefix) {
 		name_base_len = strlen(repo->submodule_prefix);
 		strbuf_addstr(&name, repo->submodule_prefix);
@@ -509,7 +511,7 @@ static int grep_cache(struct grep_opt *opt,
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
-		if (ce_skip_worktree(ce))
+		if (sparse_paths_only && ce_skip_worktree(ce))
 			continue;
 
 		strbuf_setlen(&name, name_base_len);
@@ -715,9 +717,10 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     int is_root_tree)
 {
 	struct pattern_list *patterns = NULL;
+	int sparse_paths_only = restrict_to_sparse_paths(opt->repo);
 	int ret;
 
-	if (is_root_tree)
+	if (is_root_tree && sparse_paths_only)
 		patterns = get_sparsity_patterns(opt->repo);
 
 	ret = do_grep_tree(opt, pathspec, tree, base, tn_len, is_root_tree,
@@ -1258,6 +1261,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
+
+		if (opt_restrict_to_sparse_paths >= 0) {
+			die(_("--[no-]restrict-to-sparse-paths is incompatible"
+				  " with --no-index and --untracked"));
+		}
+
 		hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
 	} else if (0 <= opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents"));
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9147fba3d5..de12766a70 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3402,6 +3402,8 @@ __git_main ()
 			--namespace=
 			--no-replace-objects
 			--help
+			--restrict-to-sparse-paths
+			--no-restrict-to-sparse-paths
 			"
 			;;
 		*)
diff --git a/git.c b/git.c
index 8bd1d7551d..81206b424c 100644
--- a/git.c
+++ b/git.c
@@ -5,6 +5,7 @@
 #include "run-command.h"
 #include "alias.h"
 #include "shallow.h"
+#include "sparse-checkout.h"
 
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
@@ -311,6 +312,10 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			} else {
 				exit(list_cmds(cmd));
 			}
+		} else if (!strcmp(cmd, "--restrict-to-sparse-paths")) {
+			opt_restrict_to_sparse_paths = 1;
+		} else if (!strcmp(cmd, "--no-restrict-to-sparse-paths")) {
+			opt_restrict_to_sparse_paths = 0;
 		} else {
 			fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
diff --git a/sparse-checkout.c b/sparse-checkout.c
new file mode 100644
index 0000000000..96c5ed5446
--- /dev/null
+++ b/sparse-checkout.c
@@ -0,0 +1,18 @@
+#include "cache.h"
+#include "config.h"
+#include "sparse-checkout.h"
+
+int opt_restrict_to_sparse_paths = -1;
+
+int restrict_to_sparse_paths(struct repository *repo)
+{
+	int ret;
+
+	if (opt_restrict_to_sparse_paths >= 0)
+		return opt_restrict_to_sparse_paths;
+
+	if (repo_config_get_bool(repo, "sparse.restrictcmds", &ret))
+		ret = 1;
+
+	return ret;
+}
diff --git a/sparse-checkout.h b/sparse-checkout.h
new file mode 100644
index 0000000000..a4805e443a
--- /dev/null
+++ b/sparse-checkout.h
@@ -0,0 +1,11 @@
+#ifndef SPARSE_CHECKOUT_H
+#define SPARSE_CHECKOUT_H
+
+struct repository;
+
+extern int opt_restrict_to_sparse_paths;
+
+/* Whether or not cmds should restrict behavior on sparse paths, in this repo */
+int restrict_to_sparse_paths(struct repository *repo);
+
+#endif /* SPARSE_CHECKOUT_H */
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
index b3109e3479..f93a4f71d1 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -80,10 +80,10 @@ test_expect_success 'setup' '
 	test_path_is_file sub2/a
 '
 
-# The test below checks a special case: the sparsity patterns exclude '/b'
+# The two tests below check a special case: the sparsity patterns exclude '/b'
 # and sparse checkout is enabled, but the path exists in the working tree (e.g.
 # manually created after `git sparse-checkout init`). In this case, grep should
-# skip it.
+# skip the file by default, but not with --no-restrict-to-sparse-paths.
 test_expect_success 'grep in working tree should honor sparse checkout' '
 	cat >expect <<-EOF &&
 	a:text
@@ -93,6 +93,16 @@ test_expect_success 'grep in working tree should honor sparse checkout' '
 	git grep "text" >actual &&
 	test_cmp expect actual
 '
+test_expect_success 'grep w/ --no-restrict-to-sparse-paths for sparsely excluded but present paths' '
+	cat >expect <<-EOF &&
+	a:text
+	b:new-text
+	EOF
+	echo "new-text" >b &&
+	test_when_finished "rm b" &&
+	git --no-restrict-to-sparse-paths grep "text" >actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'grep unmerged file despite not matching sparsity patterns' '
 	cat >expect <<-EOF &&
@@ -157,7 +167,7 @@ test_expect_success 'grep <tree-ish> should ignore sparsity patterns' '
 '
 
 # Note that sub2/ is present in the worktree but it is excluded by the sparsity
-# patterns, so grep should not recurse into it.
+# patterns, so grep should only recurse into it with --no-restrict-to-sparse-paths.
 test_expect_success 'grep --recurse-submodules should honor sparse checkout in submodule' '
 	cat >expect <<-EOF &&
 	a:text
@@ -166,6 +176,15 @@ test_expect_success 'grep --recurse-submodules should honor sparse checkout in s
 	git grep --recurse-submodules "text" >actual &&
 	test_cmp expect actual
 '
+test_expect_success 'grep --recurse-submodules should search in excluded submodules w/ --no-restrict-to-sparse-paths' '
+	cat >expect <<-EOF &&
+	a:text
+	sub/B/b:text
+	sub2/a:text
+	EOF
+	git --no-restrict-to-sparse-paths grep --recurse-submodules "text" >actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'grep --recurse-submodules --cached should honor sparse checkout in submodule' '
 	cat >expect <<-EOF &&
@@ -192,4 +211,111 @@ test_expect_success 'grep --recurse-submodules <commit-ish> should honor sparse
 	test_cmp expect_tag-to-commit actual_tag-to-commit
 '
 
+for cmd in 'git --no-restrict-to-sparse-paths grep' \
+	   'git -c sparse.restrictCmds=false grep' \
+	   'git -c sparse.restrictCmds=true --no-restrict-to-sparse-paths grep'
+do
+
+	test_expect_success "$cmd --cached should ignore sparsity patterns" '
+		cat >expect <<-EOF &&
+		a:text
+		b:text
+		dir/c:text
+		EOF
+		$cmd --cached "text" >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "$cmd <commit-ish> should ignore sparsity patterns" '
+		commit=$(git rev-parse HEAD) &&
+		cat >expect_commit <<-EOF &&
+		$commit:a:text
+		$commit:b:text
+		$commit:dir/c:text
+		EOF
+		cat >expect_tag-to-commit <<-EOF &&
+		tag-to-commit:a:text
+		tag-to-commit:b:text
+		tag-to-commit:dir/c:text
+		EOF
+		$cmd "text" $commit >actual_commit &&
+		test_cmp expect_commit actual_commit &&
+		$cmd "text" tag-to-commit >actual_tag-to-commit &&
+		test_cmp expect_tag-to-commit actual_tag-to-commit
+	'
+done
+
+test_expect_success 'grep --recurse-submodules --cached w/ --no-restrict-to-sparse-paths' '
+	cat >expect <<-EOF &&
+	a:text
+	b:text
+	dir/c:text
+	sub/A/a:text
+	sub/B/b:text
+	sub2/a:text
+	EOF
+	git --no-restrict-to-sparse-paths grep --recurse-submodules --cached \
+		"text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --recurse-submodules <commit-ish> w/ --no-restrict-to-sparse-paths' '
+	commit=$(git rev-parse HEAD) &&
+	cat >expect_commit <<-EOF &&
+	$commit:a:text
+	$commit:b:text
+	$commit:dir/c:text
+	$commit:sub/A/a:text
+	$commit:sub/B/b:text
+	$commit:sub2/a:text
+	EOF
+	cat >expect_tag-to-commit <<-EOF &&
+	tag-to-commit:a:text
+	tag-to-commit:b:text
+	tag-to-commit:dir/c:text
+	tag-to-commit:sub/A/a:text
+	tag-to-commit:sub/B/b:text
+	tag-to-commit:sub2/a:text
+	EOF
+	git --no-restrict-to-sparse-paths grep --recurse-submodules "text" \
+		$commit >actual_commit &&
+	test_cmp expect_commit actual_commit &&
+	git --no-restrict-to-sparse-paths grep --recurse-submodules "text" \
+		tag-to-commit >actual_tag-to-commit &&
+	test_cmp expect_tag-to-commit actual_tag-to-commit
+'
+
+test_expect_success 'should respect the sparse.restrictCmds values from submodules' '
+	cat >expect <<-EOF &&
+	a:text
+	sub/A/a:text
+	sub/B/b:text
+	EOF
+	test_config -C sub sparse.restrictCmds false &&
+	git grep --cached --recurse-submodules "text" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'should propagate --[no]-restrict-to-sparse-paths to submodules' '
+	cat >expect <<-EOF &&
+	a:text
+	b:text
+	dir/c:text
+	sub/A/a:text
+	sub/B/b:text
+	sub2/a:text
+	EOF
+	test_config -C sub sparse.restrictCmds true &&
+	git --no-restrict-to-sparse-paths grep --cached --recurse-submodules "text" >actual &&
+	test_cmp expect actual
+'
+
+for opt in '--untracked' '--no-index'
+do
+	test_expect_success "--[no]-restrict-to-sparse-paths and $opt are incompatible" "
+		test_must_fail git --restrict-to-sparse-paths grep $opt . 2>actual &&
+		test_i18ngrep 'restrict-to-sparse-paths is incompatible with' actual
+	"
+done
+
 test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8425b9a531..a8c2ac9d70 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1928,6 +1928,8 @@ test_expect_success 'double dash "git" itself' '
 	--namespace=
 	--no-replace-objects Z
 	--help Z
+	--restrict-to-sparse-paths Z
+	--no-restrict-to-sparse-paths Z
 	EOF
 '
 
@@ -1970,7 +1972,7 @@ test_expect_success 'general options' '
 	test_completion "git --nam" "--namespace=" &&
 	test_completion "git --bar" "--bare " &&
 	test_completion "git --inf" "--info-path " &&
-	test_completion "git --no-r" "--no-replace-objects "
+	test_completion "git --no-rep" "--no-replace-objects "
 '
 
 test_expect_success 'general options plus command' '
-- 
2.28.0

