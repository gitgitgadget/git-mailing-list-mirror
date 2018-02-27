Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648431F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeB0Cdd (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:33 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35730 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeB0Cd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:28 -0500
Received: by mail-qk0-f194.google.com with SMTP id s188so21754515qkb.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F4P3826u+W/8WcUYeyktsOHh4Pg05tuyzRfiOtqZEu8=;
        b=m4nrjFQGuqUk5oKykje7yHmEl0s5aRI+i+CBqk+Uvd4nn92F3sF1OmE+MYNZGib010
         uWa/goFz1FswYCXNQC4K94cBr7P9T+UVU2CV1F7T+KAUGKE9eeVbVXXRDniUwfRK1YnV
         OjQhXlyHeyApATpAejIoVB/ufAT7cJYXDdxw/ZQKV+iypNVGsAcMkMuc8I/BVNTelugt
         ChDVUzbJoGyB4ZcEhybGKUp/udDLWrdisgr9COVL+bRE0Ki5N7/Fiva1pCZECArFt6ZZ
         cnc4qJu0yh1WjyhHyqgZBirEmdjXzK3ShKCfDd8GlZVzKGg/vy0vtC5/sEJ6d676ECrG
         xg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F4P3826u+W/8WcUYeyktsOHh4Pg05tuyzRfiOtqZEu8=;
        b=VpQRmHk3JuJELazGYOvUUdP2X3aXpK9/uczSpDC+N5/urwVntvCcek6xZpJBqXYzgt
         j8SkBDOhlkH1E8xeC9sycpxxvwPxdtSpW872XvMwL1GDgpByoKkbCdoH09mIFxyAJwOY
         DgxcZpr3ZIrn78SRhwhc90+s+5LlVrGEugIrDYO7wAlcJxHJLwO0JIJrpSaH4PnjcKZS
         cscYr9IoJoFmMMUvObwRRci9aweB/NTsD//nrUL9g0tvGGb9fcq59w14ewfdZa/oFczW
         GMwHz/JVCJRy96nGowf6ZJ18tM68Bfw6eBj/j9qI8Lyno8iEnn5rBlEHqhsLsRuW2X+z
         PcKA==
X-Gm-Message-State: APf1xPA1rmHF/vO6LfZWRn7mjjcG2dQz9a77F/4Srt9j9Sl/o+6eGodW
        9VKTecdNRmlX6K6mK8pqjc0Z31CuVfs=
X-Google-Smtp-Source: AG47ELtz8gXfi6Zfb/zuM0bl4DrvhUFieT984nsT9ITHzn73StdJT08Z4Bt6Pkd4RtbBBj0aKapSBg==
X-Received: by 10.55.89.194 with SMTP id n185mr21163187qkb.111.1519698807528;
        Mon, 26 Feb 2018 18:33:27 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:26 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 12/13] commit-graph: build graph from starting commits
Date:   Mon, 26 Feb 2018 21:33:06 -0500
Message-Id: <1519698787-190494-13-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to read commits from stdin when the
--stdin-commits flag is specified. Commits reachable from these
commits are added to the graph. This is a much faster way to construct
the graph than inspecting all packed objects, but is restricted to
known tips.

For the Linux repository, 700,000+ commits were added to the graph
file starting from 'master' in 7-9 seconds, depending on the number
of packfiles in the repo (1, 24, or 120).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 14 +++++++++++++-
 builtin/commit-graph.c             | 27 +++++++++++++++++++++------
 commit-graph.c                     | 27 +++++++++++++++++++++++++--
 commit-graph.h                     |  4 +++-
 t/t5318-commit-graph.sh            | 13 +++++++++++++
 5 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index b945510..0710a68 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -34,7 +34,13 @@ COMMANDS
 Write a commit graph file based on the commits found in packfiles.
 +
 With the `--stdin-packs` option, generate the new commit graph by
-walking objects only in the specified packfiles.
+walking objects only in the specified packfiles. (Cannot be combined
+with --stdin-commits.)
++
+With the `--stdin-commits` option, generate the new commit graph by
+walking commits starting at the commits specified in stdin as a list
+of OIDs in hex, one OID per line. (Cannot be combined with
+--stdin-packs.)
 
 'read'::
 
@@ -58,6 +64,12 @@ $ git commit-graph write
 $ echo <pack-index> | git commit-graph write --stdin-packs
 ------------------------------------------------
 
+* Write a graph file containing all reachable commits.
++
+------------------------------------------------
+$ git show-ref -s | git commit-graph write --stdin-commits
+------------------------------------------------
+
 * Read basic information from the commit-graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index eebca57..1c7b7e7 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
@@ -18,13 +18,14 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs|--stdin-commits]"),
 	NULL
 };
 
 static struct opts_commit_graph {
 	const char *obj_dir;
 	int stdin_packs;
+	int stdin_commits;
 } opts;
 
 static int graph_read(int argc, const char **argv)
@@ -79,6 +80,8 @@ static int graph_write(int argc, const char **argv)
 {
 	const char **pack_indexes = NULL;
 	int packs_nr = 0;
+	const char **commit_hex = NULL;
+	int commits_nr = 0;
 	const char **lines = NULL;
 	int lines_nr = 0;
 	int lines_alloc = 0;
@@ -89,6 +92,8 @@ static int graph_write(int argc, const char **argv)
 			N_("The object directory to store the graph")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			N_("scan packfiles listed by stdin for commits")),
+		OPT_BOOL(0, "stdin-commits", &opts.stdin_commits,
+			N_("start walk at commits listed by stdin")),
 		OPT_END(),
 	};
 
@@ -96,10 +101,12 @@ static int graph_write(int argc, const char **argv)
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
 
+	if (opts.stdin_packs && opts.stdin_commits)
+		die(_("cannot use both --stdin-commits and --stdin-packs"));
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
 
-	if (opts.stdin_packs) {
+	if (opts.stdin_packs || opts.stdin_commits) {
 		struct strbuf buf = STRBUF_INIT;
 		lines_nr = 0;
 		lines_alloc = 128;
@@ -110,13 +117,21 @@ static int graph_write(int argc, const char **argv)
 			lines[lines_nr++] = strbuf_detach(&buf, NULL);
 		}
 
-		pack_indexes = lines;
-		packs_nr = lines_nr;
+		if (opts.stdin_packs) {
+			pack_indexes = lines;
+			packs_nr = lines_nr;
+		}
+		if (opts.stdin_commits) {
+			commit_hex = lines;
+			commits_nr = lines_nr;
+		}
 	}
 
 	write_commit_graph(opts.obj_dir,
 			   pack_indexes,
-			   packs_nr);
+			   packs_nr,
+			   commit_hex,
+			   commits_nr);
 
 	return 0;
 }
diff --git a/commit-graph.c b/commit-graph.c
index 4e9f1d5..dbb9801 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -531,7 +531,9 @@ static void close_reachable(struct packed_oid_list *oids)
 
 void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
-			int nr_packs)
+			int nr_packs,
+			const char **commit_hex,
+			int nr_commits)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -572,7 +574,28 @@ void write_commit_graph(const char *obj_dir,
 			close_pack(p);
 		}
 		strbuf_release(&packname);
-	} else
+	}
+
+	if (commit_hex) {
+		for (i = 0; i < nr_commits; i++) {
+			const char *end;
+			struct object_id oid;
+			struct commit *result;
+
+			if (commit_hex[i] && parse_oid_hex(commit_hex[i], &oid, &end))
+				continue;
+
+			result = lookup_commit_reference_gently(&oid, 1);
+
+			if (result) {
+				ALLOC_GROW(oids.list, oids.nr + 1, oids.alloc);
+				oidcpy(&oids.list[oids.nr], &(result->object.oid));
+				oids.nr++;
+			}
+		}
+	}
+
+	if (!pack_indexes && !commit_hex)
 		for_each_packed_object(add_packed_commits, &oids, 0);
 
 	close_reachable(&oids);
diff --git a/commit-graph.h b/commit-graph.h
index 65fe770..4c70281 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -38,7 +38,9 @@ struct commit_graph *load_commit_graph_one(const char *graph_file);
 
 void write_commit_graph(const char *obj_dir,
 			const char **pack_indexes,
-			int nr_packs);
+			int nr_packs,
+			const char **commit_hex,
+			int nr_commits);
 
 #endif
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 6bc529c..9589238 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -177,6 +177,19 @@ test_expect_success 'build graph from latest pack with closure' '
 graph_git_behavior 'graph from pack, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'graph from pack, commit 8 vs merge 2' full commits/8 merge/2
 
+test_expect_success 'build graph from commits with closure' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git tag -a -m "merge" tag/merge merge/2 &&
+	git rev-parse tag/merge >commits-in &&
+	git rev-parse merge/1 >>commits-in &&
+	cat commits-in | git commit-graph write --stdin-commits &&
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "6"
+'
+
+graph_git_behavior 'graph from commits, commit 8 vs merge 1' full commits/8 merge/1
+graph_git_behavior 'graph from commits, commit 8 vs merge 2' full commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone --bare --no-local full bare &&
-- 
2.7.4

