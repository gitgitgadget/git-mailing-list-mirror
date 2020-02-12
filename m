Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F7C2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 05:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCA420714
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 05:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="X+3M+5Qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgBLFr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 00:47:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39249 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgBLFr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 00:47:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id 84so659277pfy.6
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 21:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7eQvBVyTrq0SRczsIwlhjgYiy6wnWYK3Kj5+dDu1YOw=;
        b=X+3M+5QiCZ4jTQcVd8IyljY6LFXke2lKAHM1Ez1Iqa2NhSKpldxMwvx5kqpLryqgAm
         RE6X1ekQmp86xqKbKz/CxhHf83DTxdMWeMPpZoUz+05yxZfd3A+8cQsSiOQxLhKIeyoZ
         P8rHiCWGxpOJsoTteP7ZWGH05vNz4qrg7IfiTeBqHo99Q2wAECjZK7uHFWaETSQX6eUD
         RJvo+HPYMq5AcZYS7J1N6uBHJgjcmHWW7YkiKRP/2n/HJKM6t72tHmuvxTC6T7l6F+b5
         gnn+DaOQv0JzB8tLvExIw0JUaQIbUQXTO4Un/1jF5gtDmw2S9b8b842KCxjwRAMcdGn9
         hBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7eQvBVyTrq0SRczsIwlhjgYiy6wnWYK3Kj5+dDu1YOw=;
        b=sIuFLliySeS1cz7F1HZ2hBcPzjvjHK5NKuYckjhfxqtpauYxdmHCxeyJOMUCuESWJm
         Nl8O+zLa7H8L9tCl3OM7ZgriMDlGwh08udlOoW8IboO4N3DIvRtDrZnmMVzkWGiAPe5l
         4nXn5WeSyYgl8wOBLHF23njUf58uX/UweCJWfZLKoAGTEbJueHCxIS/dqC+3RNk93npO
         pliqfG5tg4Cw/oj6nGiTezcy89QHhcxdwvdxEwavdlFBnN57LlmbjZWU7uMF6WvgloWT
         w6gGnjz36+xYEzBrAwa5U+yFWz/G0h51Q11Tyuzet0J25v/HbYqcDaEK+vC5zrLxouZX
         ncpA==
X-Gm-Message-State: APjAAAWWVmkbOQho3o+PZlyCwgw1fxbnUVY7x7sMIexvZ/ToPmL8HLOA
        /jLezvuo3L2UAvCKdhELzd9lphnxQ+5KVQ==
X-Google-Smtp-Source: APXvYqxCsiDhMXbxmKStKVvkus7VRgfhJ7zxPbzBRUGPa16fgtBKcjo54eQ5oilb2WXbT6MhTEf2Qw==
X-Received: by 2002:a63:4f0c:: with SMTP id d12mr11068311pgb.322.1581486476812;
        Tue, 11 Feb 2020 21:47:56 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:e4b4:608a:57ae:c0a6])
        by smtp.gmail.com with ESMTPSA id y18sm6716971pfe.19.2020.02.11.21.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 21:47:56 -0800 (PST)
Date:   Tue, 11 Feb 2020 21:47:55 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v3 2/3] builtin/commit-graph.c: introduce '--input=<source>'
Message-ID: <655fe6307676973900c8df833a429252d50c176f.1581486293.git.me@ttaylorr.com>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1581486293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1581486293.git.me@ttaylorr.com>
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
 builtin/commit-graph.c             | 83 +++++++++++++++++++++---------
 t/t5318-commit-graph.sh            |  4 +-
 t/t5324-split-commit-graph.sh      |  2 +-
 4 files changed, 76 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 269c355b0a..0a320cccdd 100644
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
@@ -106,20 +106,20 @@ $ git commit-graph write
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
index 4d3c1c46c2..0ff25896d0 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,8 +9,9 @@
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append] "
-	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
+	N_("git commit-graph write [--object-dir <objdir>] "
+	   "[--split[=<strategy>]] "
+	   "[--input=<reachable|stdin-packs|stdin-commits|append>] "
 	   "[--[no-]progress] <split options>"),
 	NULL
 };
@@ -21,18 +22,23 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append] "
-	   "[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits] "
+	N_("git commit-graph write [--object-dir <objdir>] "
+	   "[--split[=<strategy>]] "
+	   "[--input=<reachable|stdin-packs|stdin-commits|append>] "
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
@@ -57,6 +63,28 @@ static struct object_directory *find_odb(struct repository *r,
 	return odb;
 }
 
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
 static int graph_verify(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
@@ -149,14 +177,21 @@ static int graph_write(int argc, const char **argv)
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
@@ -182,11 +217,13 @@ static int graph_write(int argc, const char **argv)
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
@@ -196,22 +233,22 @@ static int graph_write(int argc, const char **argv)
 	read_replace_refs = 0;
 	odb = find_odb(the_repository, opts.obj_dir);
 
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
index 07b3207595..1aa81d2383 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
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
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index bb2b724178..6894106727 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -42,7 +42,7 @@ test_expect_success 'create commits and write commit-graph' '
 		test_commit $i &&
 		git branch commits/$i || return 1
 	done &&
-	git commit-graph write --reachable &&
+	git commit-graph write --input=reachable &&
 	test_path_is_file $infodir/commit-graph &&
 	graph_read_expect 3
 '
-- 
2.25.0.119.gaa12b7378b

