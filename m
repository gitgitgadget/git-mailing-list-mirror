Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE336C33CB3
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1A620661
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 00:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VTkhEaPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgAaA2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:28:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42267 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgAaA2V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 19:28:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so2504882pgb.9
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 16:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EVo7eNDEX8Qbmsi6sSdyfKrkD6MOuxr798kJYyE2VfI=;
        b=VTkhEaPNKWtJ1yyaqeVK1QCW9X1CnPWGgYZzNQtvS4fv3Vmbajg8q4SruEVULcYtY8
         L+qNO7tQIundUbwcEmOSF5E5JEkgJWPVOo9Tr8s92bmTN6SfiEyuBznlaCm+gbWTXeN1
         oYvcjUSQsEvxgVm2XxzjwC6qTEgmlFG/tPo8Z6yT8mCWLwrLDVBOceOWlZaX8+a8VSaN
         a8R9+HGuD+MvmfKAwXFGXrNumLkiZh0FgUpK16ahBBLnInWnnc8KJUeE0TvxDNUIznfP
         2xreoQa5tZ9AUCpfbD4p1neqrwOIUU+MauXP/iaan9jGIvg+F1anIgKf38wutHyv2yRj
         WDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EVo7eNDEX8Qbmsi6sSdyfKrkD6MOuxr798kJYyE2VfI=;
        b=JU9n4a7oQVaVipPtkwgCp9Ih2YV2hkxdkYKySAnqnv53Y5173OAuNW9RyWUdBGUMsh
         vsGar2Yo2cr5vK+6kfFWpU2aUCU++Cb8jd0rQa6XJ8wX8vGU8T41rMiLcUbSFDqCQMV2
         ByKnyeVh5zKy6ZyTjxPq678GqvjWKm/6L+7w0qNfHjkvG4a+Nuc6OziBK7NPGknW2QAW
         a6NdlmI6Z/eRRaxcgtb8E49/SIKdEGO1e0tFMYZ4fgc1XLU8GSFHYYMSnBvur/jIiedL
         Me/y8zj2BVH91a1sou77Yl5DdV5T1Mc6iCTrcsQUf7EnvWoEUHpeyxs5Knn78SS8nRgR
         lWXw==
X-Gm-Message-State: APjAAAVtaadImHR5L9DnLCSpsNyphq0Ux/cfF4+EBXk/iloVqHLACkXD
        MT517pd5q0tlaZjRgjfIySr9tRInZKDgsA==
X-Google-Smtp-Source: APXvYqyibBPcVbGvfkWsVO9Dj4F2nbDf9uPA736a8S/18DsmkDrW0ihrDVnkfSJ0+HhSkh9CRz2gFg==
X-Received: by 2002:a63:3f4f:: with SMTP id m76mr7146538pga.353.1580430500386;
        Thu, 30 Jan 2020 16:28:20 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id m101sm7929491pje.13.2020.01.30.16.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 16:28:20 -0800 (PST)
Date:   Thu, 30 Jan 2020 16:28:19 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH 2/3] builtin/commit-graph.c: introduce '--input=<source>'
Message-ID: <8effe35bcd1dadee3a29d996f269353cf6e4982d.1580430057.git.me@ttaylorr.com>
References: <cover.1580430057.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580430057.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'write' mode of the 'commit-graph' supports input from a number of
different sources: pack indexes over stdin, commits over stdin, commits
reachable from all references, and so on. Each of these options are
specified with a unique option: '--stdin-packs', '--stdin-commits', etc.

Similar to our replacement of 'git config [--<type>]' with 'git config
[--type=<type>]' (c.f., fb0dc3bac1 (builtin/config.c: support
`--type=<type>` as preferred alias for `--<type>`, 2018-04-18)), softly
deprecate '[--<input>]' in favor of '[--input=<source>]'.

This makes it more clear to implement new options that are combinations
of other options (such as, for example, "none", a combination of the old
"--append" and a new sentinel to specify to _not_ look in other packs,
which we will implement in a future patch).

Unfortunately, the new enumerated type is a bitfield, even though it
makes much more sense as '0, 1, 2, ...'. Even though *almost* all
options are pairwise exclusive, '--stdin-{packs,commits}' *is*
compatible with '--append'. For this reason, use a bitfield.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-commit-graph.txt | 26 +++++-----
 builtin/commit-graph.c             | 77 ++++++++++++++++++++++--------
 t/t5318-commit-graph.sh            | 46 +++++++++---------
 t/t5324-split-commit-graph.sh      | 44 ++++++++---------
 4 files changed, 114 insertions(+), 79 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 8d61ba9f56..cbf80226e9 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -41,21 +41,21 @@ COMMANDS
 
 Write a commit-graph file based on the commits found in packfiles.
 +
-With the `--stdin-packs` option, generate the new commit graph by
+With the `--input=stdin-packs` option, generate the new commit graph by
 walking objects only in the specified pack-indexes. (Cannot be combined
-with `--stdin-commits` or `--reachable`.)
+with `--input=stdin-commits` or `--input=reachable`.)
 +
-With the `--stdin-commits` option, generate the new commit graph by
-walking commits starting at the commits specified in stdin as a list
+With the `--input=stdin-commits` option, generate the new commit graph
+by walking commits starting at the commits specified in stdin as a list
 of OIDs in hex, one OID per line. (Cannot be combined with
-`--stdin-packs` or `--reachable`.)
+`--input=stdin-packs` or `--input=reachable`.)
 +
-With the `--reachable` option, generate the new commit graph by walking
-commits starting at all refs. (Cannot be combined with `--stdin-commits`
-or `--stdin-packs`.)
+With the `--input=reachable` option, generate the new commit graph by
+walking commits starting at all refs. (Cannot be combined with
+`--input=stdin-commits` or `--input=stdin-packs`.)
 +
-With the `--append` option, include all commits that are present in the
-existing commit-graph file.
+With the `--input=append` option, include all commits that are present
+in the existing commit-graph file.
 +
 With the `--split[=<strategy>]` option, write the commit-graph as a
 chain of multiple commit-graph files stored in
@@ -107,20 +107,20 @@ $ git commit-graph write
   using commits in `<pack-index>`.
 +
 ------------------------------------------------
-$ echo <pack-index> | git commit-graph write --stdin-packs
+$ echo <pack-index> | git commit-graph write --input=stdin-packs
 ------------------------------------------------
 
 * Write a commit-graph file containing all reachable commits.
 +
 ------------------------------------------------
-$ git show-ref -s | git commit-graph write --stdin-commits
+$ git show-ref -s | git commit-graph write --input=stdin-commits
 ------------------------------------------------
 
 * Write a commit-graph file containing all commits in the current
   commit-graph file along with those reachable from `HEAD`.
 +
 ------------------------------------------------
-$ git rev-parse HEAD | git commit-graph write --stdin-commits --append
+$ git rev-parse HEAD | git commit-graph write --input=stdin-commits --input=append
 ------------------------------------------------
 
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index f03b46d627..03d815e652 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -10,7 +10,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
-	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
+	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
 	   "[--[no-]progress] <split options>"),
 	NULL
 };
@@ -22,22 +22,48 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--object-dir <objdir>] [--append] "
-	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
+	   "[--split[=<strategy>]] [--input=<reachable|stdin-packs|stdin-commits>] "
 	   "[--[no-]progress] <split options>"),
 	NULL
 };
 
+enum commit_graph_input {
+	COMMIT_GRAPH_INPUT_REACHABLE     = (1 << 1),
+	COMMIT_GRAPH_INPUT_STDIN_PACKS   = (1 << 2),
+	COMMIT_GRAPH_INPUT_STDIN_COMMITS = (1 << 3),
+	COMMIT_GRAPH_INPUT_APPEND        = (1 << 4)
+};
+
 static struct opts_commit_graph {
 	const char *obj_dir;
-	int reachable;
-	int stdin_packs;
-	int stdin_commits;
-	int append;
+	enum commit_graph_input input;
 	int split;
 	int shallow;
 	int progress;
 } opts;
 
+static int option_parse_input(const struct option *opt, const char *arg,
+			      int unset)
+{
+	enum commit_graph_input *to = opt->value;
+	if (unset || !strcmp(arg, "packs")) {
+		*to = 0;
+		return 0;
+	}
+
+	if (!strcmp(arg, "reachable"))
+		*to |= COMMIT_GRAPH_INPUT_REACHABLE;
+	else if (!strcmp(arg, "stdin-packs"))
+		*to |= COMMIT_GRAPH_INPUT_STDIN_PACKS;
+	else if (!strcmp(arg, "stdin-commits"))
+		*to |= COMMIT_GRAPH_INPUT_STDIN_COMMITS;
+	else if (!strcmp(arg, "append"))
+		*to |= COMMIT_GRAPH_INPUT_APPEND;
+	else
+		die(_("unrecognized --input source, %s"), arg);
+	return 0;
+}
+
 static struct object_directory *find_odb_or_die(struct repository *r,
 						const char *obj_dir)
 {
@@ -137,14 +163,21 @@ static int graph_write(int argc, const char **argv)
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			N_("dir"),
 			N_("The object directory to store the graph")),
-		OPT_BOOL(0, "reachable", &opts.reachable,
-			N_("start walk at all refs")),
-		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
-			N_("scan pack-indexes listed by stdin for commits")),
-		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
-			N_("start walk at commits listed by stdin")),
-		OPT_BOOL(0, "append", &opts.append,
-			N_("include all commits already in the commit-graph file")),
+		OPT_CALLBACK(0, "input", &opts.input, NULL,
+			N_("include commits from this source in the graph"),
+			option_parse_input),
+		OPT_BIT(0, "reachable", &opts.input,
+			N_("start walk at all refs"),
+			COMMIT_GRAPH_INPUT_REACHABLE),
+		OPT_BIT(0, "stdin-packs", &opts.input,
+			N_("scan pack-indexes listed by stdin for commits"),
+			COMMIT_GRAPH_INPUT_STDIN_PACKS),
+		OPT_BIT(0, "stdin-commits", &opts.input,
+			N_("start walk at commits listed by stdin"),
+			COMMIT_GRAPH_INPUT_STDIN_COMMITS),
+		OPT_BIT(0, "append", &opts.input,
+			N_("include all commits already in the commit-graph file"),
+			COMMIT_GRAPH_INPUT_APPEND),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
 			N_("allow writing an incremental commit-graph file"),
@@ -170,11 +203,13 @@ static int graph_write(int argc, const char **argv)
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
 
-	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
-		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
+	if ((!!(opts.input & COMMIT_GRAPH_INPUT_REACHABLE) +
+	     !!(opts.input & COMMIT_GRAPH_INPUT_STDIN_PACKS) +
+	     !!(opts.input & COMMIT_GRAPH_INPUT_STDIN_COMMITS)) > 1)
+		die(_("use at most one of --input=reachable, --input=stdin-commits, or --input=stdin-packs"));
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
-	if (opts.append)
+	if (opts.input & COMMIT_GRAPH_INPUT_APPEND)
 		flags |= COMMIT_GRAPH_WRITE_APPEND;
 	if (opts.split)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
@@ -184,22 +219,22 @@ static int graph_write(int argc, const char **argv)
 	read_replace_refs = 0;
 	odb = find_odb_or_die(the_repository, opts.obj_dir);
 
-	if (opts.reachable) {
+	if (opts.input & COMMIT_GRAPH_INPUT_REACHABLE) {
 		if (write_commit_graph_reachable(odb, flags, &split_opts))
 			return 1;
 		return 0;
 	}
 
 	string_list_init(&lines, 0);
-	if (opts.stdin_packs || opts.stdin_commits) {
+	if (opts.input & (COMMIT_GRAPH_INPUT_STDIN_PACKS | COMMIT_GRAPH_INPUT_STDIN_COMMITS)) {
 		struct strbuf buf = STRBUF_INIT;
 
 		while (strbuf_getline(&buf, stdin) != EOF)
 			string_list_append(&lines, strbuf_detach(&buf, NULL));
 
-		if (opts.stdin_packs)
+		if (opts.input & COMMIT_GRAPH_INPUT_STDIN_PACKS)
 			pack_indexes = &lines;
-		if (opts.stdin_commits) {
+		if (opts.input & COMMIT_GRAPH_INPUT_STDIN_COMMITS) {
 			commit_hex = &lines;
 			flags |= COMMIT_GRAPH_WRITE_CHECK_OIDS;
 		}
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 0bf98b56ec..6533724bc5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -23,10 +23,10 @@ test_expect_success 'write graph with no packs' '
 	test_path_is_missing $objdir/info/commit-graph
 '
 
-test_expect_success 'exit with correct error on bad input to --stdin-packs' '
+test_expect_success 'exit with correct error on bad input to --input=stdin-packs' '
 	cd "$TRASH_DIRECTORY/full" &&
 	echo doesnotexist >in &&
-	test_expect_code 1 git commit-graph write --stdin-packs <in 2>stderr &&
+	test_expect_code 1 git commit-graph write --input=stdin-packs <in 2>stderr &&
 	test_i18ngrep "error adding pack" stderr
 '
 
@@ -40,12 +40,12 @@ test_expect_success 'create commits and repack' '
 	git repack
 '
 
-test_expect_success 'exit with correct error on bad input to --stdin-commits' '
+test_expect_success 'exit with correct error on bad input to --input=stdin-commits' '
 	cd "$TRASH_DIRECTORY/full" &&
-	echo HEAD | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
+	echo HEAD | test_expect_code 1 git commit-graph write --input=stdin-commits 2>stderr &&
 	test_i18ngrep "invalid commit object id" stderr &&
 	# valid tree OID, but not a commit OID
-	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --stdin-commits 2>stderr &&
+	git rev-parse HEAD^{tree} | test_expect_code 1 git commit-graph write --input=stdin-commits 2>stderr &&
 	test_i18ngrep "invalid commit object id" stderr
 '
 
@@ -227,7 +227,7 @@ graph_git_behavior 'cleared graph, commit 8 vs merge 2' full commits/8 merge/2
 
 test_expect_success 'build graph from latest pack with closure' '
 	cd "$TRASH_DIRECTORY/full" &&
-	cat new-idx | git commit-graph write --stdin-packs &&
+	cat new-idx | git commit-graph write --input=stdin-packs &&
 	test_path_is_file $objdir/info/commit-graph &&
 	graph_read_expect "9" "extra_edges"
 '
@@ -240,7 +240,7 @@ test_expect_success 'build graph from commits with closure' '
 	git tag -a -m "merge" tag/merge merge/2 &&
 	git rev-parse tag/merge >commits-in &&
 	git rev-parse merge/1 >>commits-in &&
-	cat commits-in | git commit-graph write --stdin-commits &&
+	cat commits-in | git commit-graph write --input=stdin-commits &&
 	test_path_is_file $objdir/info/commit-graph &&
 	graph_read_expect "6"
 '
@@ -250,7 +250,7 @@ graph_git_behavior 'graph from commits, commit 8 vs merge 2' full commits/8 merg
 
 test_expect_success 'build graph from commits with append' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse merge/3 | git commit-graph write --stdin-commits --append &&
+	git rev-parse merge/3 | git commit-graph write --input=stdin-commits --input=append &&
 	test_path_is_file $objdir/info/commit-graph &&
 	graph_read_expect "10" "extra_edges"
 '
@@ -260,7 +260,7 @@ graph_git_behavior 'append graph, commit 8 vs merge 2' full commits/8 merge/2
 
 test_expect_success 'build graph using --reachable' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write --reachable &&
+	git commit-graph write --input=reachable &&
 	test_path_is_file $objdir/info/commit-graph &&
 	graph_read_expect "11" "extra_edges"
 '
@@ -301,14 +301,14 @@ test_expect_success 'perform fast-forward merge in full repo' '
 test_expect_success 'check that gc computes commit-graph' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit --allow-empty -m "blank" &&
-	git commit-graph write --reachable &&
+	git commit-graph write --input=reachable &&
 	cp $objdir/info/commit-graph commit-graph-before-gc &&
 	git reset --hard HEAD~1 &&
 	git config gc.writeCommitGraph true &&
 	git gc &&
 	cp $objdir/info/commit-graph commit-graph-after-gc &&
 	! test_cmp_bin commit-graph-before-gc commit-graph-after-gc &&
-	git commit-graph write --reachable &&
+	git commit-graph write --input=reachable &&
 	test_cmp_bin commit-graph-after-gc $objdir/info/commit-graph
 '
 
@@ -318,18 +318,18 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 	git clone full replace &&
 	(
 		cd replace &&
-		git commit-graph write --reachable &&
+		git commit-graph write --input=reachable &&
 		test_path_is_file .git/objects/info/commit-graph &&
 		git replace HEAD~1 HEAD~2 &&
 		git -c core.commitGraph=false log >expect &&
 		git -c core.commitGraph=true log >actual &&
 		test_cmp expect actual &&
-		git commit-graph write --reachable &&
+		git commit-graph write --input=reachable &&
 		git -c core.commitGraph=false --no-replace-objects log >expect &&
 		git -c core.commitGraph=true --no-replace-objects log >actual &&
 		test_cmp expect actual &&
 		rm -rf .git/objects/info/commit-graph &&
-		git commit-graph write --reachable &&
+		git commit-graph write --input=reachable &&
 		test_path_is_file .git/objects/info/commit-graph
 	)
 '
@@ -340,7 +340,7 @@ test_expect_success 'commit grafts invalidate commit-graph' '
 	git clone full graft &&
 	(
 		cd graft &&
-		git commit-graph write --reachable &&
+		git commit-graph write --input=reachable &&
 		test_path_is_file .git/objects/info/commit-graph &&
 		H1=$(git rev-parse --verify HEAD~1) &&
 		H3=$(git rev-parse --verify HEAD~3) &&
@@ -348,12 +348,12 @@ test_expect_success 'commit grafts invalidate commit-graph' '
 		git -c core.commitGraph=false log >expect &&
 		git -c core.commitGraph=true log >actual &&
 		test_cmp expect actual &&
-		git commit-graph write --reachable &&
+		git commit-graph write --input=reachable &&
 		git -c core.commitGraph=false --no-replace-objects log >expect &&
 		git -c core.commitGraph=true --no-replace-objects log >actual &&
 		test_cmp expect actual &&
 		rm -rf .git/objects/info/commit-graph &&
-		git commit-graph write --reachable &&
+		git commit-graph write --input=reachable &&
 		test_path_is_missing .git/objects/info/commit-graph
 	)
 '
@@ -364,10 +364,10 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 	git clone --depth 2 "file://$TRASH_DIRECTORY/full" shallow &&
 	(
 		cd shallow &&
-		git commit-graph write --reachable &&
+		git commit-graph write --input=reachable &&
 		test_path_is_missing .git/objects/info/commit-graph &&
 		git fetch origin --unshallow &&
-		git commit-graph write --reachable &&
+		git commit-graph write --input=reachable &&
 		test_path_is_file .git/objects/info/commit-graph
 	)
 '
@@ -380,7 +380,7 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 
 test_expect_success 'git commit-graph verify' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
+	git rev-parse commits/8 | git commit-graph write --input=stdin-commits &&
 	git commit-graph verify >output
 '
 
@@ -591,7 +591,7 @@ test_expect_success 'setup non-the_repository tests' '
 	test_commit -C repo two &&
 	git -C repo config core.commitGraph true &&
 	git -C repo rev-parse two | \
-		git -C repo commit-graph write --stdin-commits
+		git -C repo commit-graph write --input=stdin-commits
 '
 
 test_expect_success 'parse_commit_in_graph works for non-the_repository' '
@@ -637,7 +637,7 @@ test_expect_success 'corrupt commit-graph write (broken parent)' '
 		EOF
 		broken="$(git hash-object -w -t commit --literally broken)" &&
 		git commit-tree -p "$broken" -m "good commit" "$empty" >good &&
-		test_must_fail git commit-graph write --stdin-commits \
+		test_must_fail git commit-graph write --input=stdin-commits \
 			<good 2>test_err &&
 		test_i18ngrep "unable to parse commit" test_err
 	)
@@ -658,7 +658,7 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 		EOF
 		broken="$(git hash-object -w -t commit --literally broken)" &&
 		git commit-tree -p "$broken" -m "good" "$tree" >good &&
-		test_must_fail git commit-graph write --stdin-commits \
+		test_must_fail git commit-graph write --input=stdin-commits \
 			<good 2>test_err &&
 		test_i18ngrep "unable to parse commit" test_err
 	)
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index a165b48afe..dd74295885 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -35,7 +35,7 @@ test_expect_success 'create commits and write commit-graph' '
 		test_commit $i &&
 		git branch commits/$i || return 1
 	done &&
-	git commit-graph write --reachable &&
+	git commit-graph write --input=reachable &&
 	test_path_is_file $infodir/commit-graph &&
 	graph_read_expect 3
 '
@@ -87,7 +87,7 @@ test_expect_success 'add more commits, and write a new base graph' '
 	git reset --hard commits/4 &&
 	git merge commits/6 &&
 	git branch merge/2 &&
-	git commit-graph write --reachable &&
+	git commit-graph write --input=reachable &&
 	graph_read_expect 12
 '
 
@@ -99,7 +99,7 @@ test_expect_success 'fork and fail to base a chain on a commit-graph file' '
 		rm .git/objects/info/commit-graph &&
 		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
 		test_commit new-commit &&
-		git commit-graph write --reachable --split &&
+		git commit-graph write --input=reachable --split &&
 		test_path_is_file $graphdir/commit-graph-chain &&
 		test_line_count = 1 $graphdir/commit-graph-chain &&
 		verify_chain_files_exist $graphdir
@@ -112,7 +112,7 @@ test_expect_success 'add three more commits, write a tip graph' '
 	git merge commits/5 &&
 	git merge merge/2 &&
 	git branch merge/3 &&
-	git commit-graph write --reachable --split &&
+	git commit-graph write --input=reachable --split &&
 	test_path_is_missing $infodir/commit-graph &&
 	test_path_is_file $graphdir/commit-graph-chain &&
 	ls $graphdir/graph-*.graph >graph-files &&
@@ -125,7 +125,7 @@ graph_git_behavior 'split commit-graph: merge 3 vs 2' merge/3 merge/2
 test_expect_success 'add one commit, write a tip graph' '
 	test_commit 11 &&
 	git branch commits/11 &&
-	git commit-graph write --reachable --split &&
+	git commit-graph write --input=reachable --split &&
 	test_path_is_missing $infodir/commit-graph &&
 	test_path_is_file $graphdir/commit-graph-chain &&
 	ls $graphdir/graph-*.graph >graph-files &&
@@ -138,7 +138,7 @@ graph_git_behavior 'three-layer commit-graph: commit 11 vs 6' commits/11 commits
 test_expect_success 'add one commit, write a merged graph' '
 	test_commit 12 &&
 	git branch commits/12 &&
-	git commit-graph write --reachable --split &&
+	git commit-graph write --input=reachable --split &&
 	test_path_is_file $graphdir/commit-graph-chain &&
 	test_line_count = 2 $graphdir/commit-graph-chain &&
 	ls $graphdir/graph-*.graph >graph-files &&
@@ -157,7 +157,7 @@ test_expect_success 'create fork and chain across alternate' '
 		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
 		test_commit 13 &&
 		git branch commits/13 &&
-		git commit-graph write --reachable --split &&
+		git commit-graph write --input=reachable --split &&
 		test_path_is_file $graphdir/commit-graph-chain &&
 		test_line_count = 3 $graphdir/commit-graph-chain &&
 		ls $graphdir/graph-*.graph >graph-files &&
@@ -166,7 +166,7 @@ test_expect_success 'create fork and chain across alternate' '
 		git -c core.commitGraph=false rev-list HEAD >actual &&
 		test_cmp expect actual &&
 		test_commit 14 &&
-		git commit-graph write --reachable --split --object-dir=.git/objects/ &&
+		git commit-graph write --input=reachable --split --object-dir=.git/objects/ &&
 		test_line_count = 3 $graphdir/commit-graph-chain &&
 		ls $graphdir/graph-*.graph >graph-files &&
 		test_line_count = 1 graph-files
@@ -182,7 +182,7 @@ test_expect_success 'test merge stragety constants' '
 		git config core.commitGraph true &&
 		test_line_count = 2 $graphdir/commit-graph-chain &&
 		test_commit 14 &&
-		git commit-graph write --reachable --split --size-multiple=2 &&
+		git commit-graph write --input=reachable --split --size-multiple=2 &&
 		test_line_count = 3 $graphdir/commit-graph-chain
 
 	) &&
@@ -192,7 +192,7 @@ test_expect_success 'test merge stragety constants' '
 		git config core.commitGraph true &&
 		test_line_count = 2 $graphdir/commit-graph-chain &&
 		test_commit 14 &&
-		git commit-graph write --reachable --split --size-multiple=10 &&
+		git commit-graph write --input=reachable --split --size-multiple=10 &&
 		test_line_count = 1 $graphdir/commit-graph-chain &&
 		ls $graphdir/graph-*.graph >graph-files &&
 		test_line_count = 1 graph-files
@@ -203,7 +203,7 @@ test_expect_success 'test merge stragety constants' '
 		git config core.commitGraph true &&
 		test_line_count = 2 $graphdir/commit-graph-chain &&
 		test_commit 15 &&
-		git commit-graph write --reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
+		git commit-graph write --input=reachable --split --size-multiple=10 --expire-time=1980-01-01 &&
 		test_line_count = 1 $graphdir/commit-graph-chain &&
 		ls $graphdir/graph-*.graph >graph-files &&
 		test_line_count = 3 graph-files
@@ -215,7 +215,7 @@ test_expect_success 'test merge stragety constants' '
 		test_line_count = 2 $graphdir/commit-graph-chain &&
 		test_commit 16 &&
 		test_commit 17 &&
-		git commit-graph write --reachable --split --max-commits=1 &&
+		git commit-graph write --input=reachable --split --max-commits=1 &&
 		test_line_count = 1 $graphdir/commit-graph-chain &&
 		ls $graphdir/graph-*.graph >graph-files &&
 		test_line_count = 1 graph-files
@@ -227,7 +227,7 @@ test_expect_success 'remove commit-graph-chain file after flattening' '
 	(
 		cd flatten &&
 		test_line_count = 2 $graphdir/commit-graph-chain &&
-		git commit-graph write --reachable &&
+		git commit-graph write --input=reachable &&
 		test_path_is_missing $graphdir/commit-graph-chain &&
 		ls $graphdir >graph-files &&
 		test_line_count = 0 graph-files
@@ -306,7 +306,7 @@ test_expect_success 'verify across alternates' '
 		echo "$altdir" >.git/objects/info/alternates &&
 		git commit-graph verify --object-dir="$altdir/" &&
 		test_commit extra &&
-		git commit-graph write --reachable --split &&
+		git commit-graph write --input=reachable --split &&
 		tip_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
 		corrupt_file "$tip_file" 100 "\01" &&
 		test_must_fail git commit-graph verify --shallow 2>test_err &&
@@ -319,7 +319,7 @@ test_expect_success 'add octopus merge' '
 	git reset --hard commits/10 &&
 	git merge commits/3 commits/4 &&
 	git branch merge/octopus &&
-	git commit-graph write --reachable --split &&
+	git commit-graph write --input=reachable --split &&
 	git commit-graph verify --progress 2>err &&
 	test_line_count = 3 err &&
 	test_i18ngrep ! warning err &&
@@ -329,7 +329,7 @@ test_expect_success 'add octopus merge' '
 graph_git_behavior 'graph exists' merge/octopus commits/12
 
 test_expect_success 'split across alternate where alternate is not split' '
-	git commit-graph write --reachable &&
+	git commit-graph write --input=reachable &&
 	test_path_is_file .git/objects/info/commit-graph &&
 	cp .git/objects/info/commit-graph . &&
 	git clone --no-hardlinks . alt-split &&
@@ -338,7 +338,7 @@ test_expect_success 'split across alternate where alternate is not split' '
 		rm -f .git/objects/info/commit-graph &&
 		echo "$(pwd)"/../.git/objects >.git/objects/info/alternates &&
 		test_commit 18 &&
-		git commit-graph write --reachable --split &&
+		git commit-graph write --input=reachable --split &&
 		test_line_count = 1 $graphdir/commit-graph-chain
 	) &&
 	test_cmp commit-graph .git/objects/info/commit-graph
@@ -351,10 +351,10 @@ test_expect_success '--split=merge-all always merges incrementals' '
 	git rev-list -3 HEAD~4 >a &&
 	git rev-list -2 HEAD~2 >b &&
 	git rev-list -2 HEAD >c &&
-	git commit-graph write --split=no-merge --stdin-commits <a &&
-	git commit-graph write --split=no-merge --stdin-commits <b &&
+	git commit-graph write --split=no-merge --input=stdin-commits <a &&
+	git commit-graph write --split=no-merge --input=stdin-commits <b &&
 	test_line_count = 2 $graphdir/commit-graph-chain &&
-	git commit-graph write --split=merge-all --stdin-commits <c &&
+	git commit-graph write --split=merge-all --input=stdin-commits <c &&
 	test_line_count = 1 $graphdir/commit-graph-chain
 '
 
@@ -364,8 +364,8 @@ test_expect_success '--split=no-merge always writes an incremental' '
 	git reset --hard commits/2 &&
 	git rev-list HEAD~1 >a &&
 	git rev-list HEAD >b &&
-	git commit-graph write --split --stdin-commits <a &&
-	git commit-graph write --split=no-merge --stdin-commits <b &&
+	git commit-graph write --split --input=stdin-commits <a &&
+	git commit-graph write --split=no-merge --input=stdin-commits <b &&
 	test_line_count = 2 $graphdir/commit-graph-chain
 '
 
-- 
2.25.0.dirty

