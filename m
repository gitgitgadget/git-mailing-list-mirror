Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE481F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeB0Cdk (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:40 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38716 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeB0Cd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:27 -0500
Received: by mail-qk0-f194.google.com with SMTP id s198so21725228qke.5
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y1T+kzf0QKDOnGU3/FWob+SydCmnPNhWMkfZcFtXFwE=;
        b=iiQQIDCOGSIloJ5fzjoMjBjqFa0wWEOVKaGkeXnb5NtQlBqJ4doGdJbEDZv231HF1a
         MOgzsaeUY7rPBcY4amXC7dqZeL9HUwIfjuD6VNIkNeTep8NyTCE3Pp8y4lnex+ZQ981P
         XE02n5BBDCYLSCdYMe+LJp+MkatKfpfdfDX3x5QEJqaTl96TMg8xqtEuALS5KaGTaRZN
         sQzaJWE/hG2wx4VzjWPboLBdvPPPRu99jH8tT3Zr0A8wYU/yxxCFmhvHBCnmMCxUJjtf
         op+0Hs1MmMLjxQd5wfwA4lx4tX8gBlRfDYaYj2gEtW6BkzphOHbQ6S1yO+dchHgEgbeI
         uziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y1T+kzf0QKDOnGU3/FWob+SydCmnPNhWMkfZcFtXFwE=;
        b=CnuBf5Vnb4fJq/2Z6YBxVWkM7SSpZpn12iFfdBRsDn+vuWd2m5QQt+jExhNRiErCzp
         Nx+gSQfdBoHkejmKn38FRVhUv2KSOsTPmdkxS151SCwPQlGNB0mR57SIbKL3R88g1YLh
         zUY3+1/pwf65MVzBwfhYN//vENdn4keDgEmeR1JcZSCdHXNG2zsz5XdAAuiP8z6Ti0+Y
         0FY3yePQL1VCMYVkgOzw3/wpcq7wHfKkouHQZYVceqXoUdXgNKcUy10kHhqPn4JhwGIO
         EMUI95Sjqyg+gJsZ31bHm0y3JlYDq+GjBC9J6HM18IYVw4UatXtPO8f7EbtBljnbJTdP
         xZeQ==
X-Gm-Message-State: APf1xPAdxZJg9aQ1sQVV8A4AF2iU7JAuGbwh+VuhpO8BiX1sFZFEJDfE
        W90IcJkx3bBmo3FmMjNiBE8YcM8oR5o=
X-Google-Smtp-Source: AG47ELvqPs5GH5mYmgzyk3ssJi/BQXNT+bmdOGPfOxOlm8Eb9DJaq1rU1LzuS1Oa2RT2pBs0KTKiug==
X-Received: by 10.55.150.199 with SMTP id y190mr21218582qkd.334.1519698806368;
        Mon, 26 Feb 2018 18:33:26 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:25 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 11/13] commit-graph: read only from specific pack-indexes
Date:   Mon, 26 Feb 2018 21:33:05 -0500
Message-Id: <1519698787-190494-12-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach git-commit-graph to inspect the objects only in a certain list
of pack-indexes within the given pack directory. This allows updating
the commit graph iteratively.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 11 ++++++++++-
 builtin/commit-graph.c             | 33 ++++++++++++++++++++++++++++++---
 commit-graph.c                     | 26 ++++++++++++++++++++++++--
 commit-graph.h                     |  4 +++-
 packfile.c                         |  4 ++--
 packfile.h                         |  2 ++
 t/t5318-commit-graph.sh            | 10 ++++++++++
 7 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 51cb038..b945510 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -32,7 +32,9 @@ COMMANDS
 'write'::
 
 Write a commit graph file based on the commits found in packfiles.
-Includes all commits from the existing commit graph file.
++
+With the `--stdin-packs` option, generate the new commit graph by
+walking objects only in the specified packfiles.
 
 'read'::
 
@@ -49,6 +51,13 @@ EXAMPLES
 $ git commit-graph write
 ------------------------------------------------
 
+* Write a graph file, extending the current graph file using commits
+* in <pack-index>.
++
+------------------------------------------------
+$ echo <pack-index> | git commit-graph write --stdin-packs
+------------------------------------------------
+
 * Read basic information from the commit-graph file.
 +
 ------------------------------------------------
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0e164be..eebca57 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,7 @@
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
-	N_("git commit-graph write [--object-dir <objdir>]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs]"),
 	NULL
 };
 
@@ -18,12 +18,13 @@ static const char * const builtin_commit_graph_read_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>]"),
+	N_("git commit-graph write [--object-dir <objdir>] [--stdin-packs]"),
 	NULL
 };
 
 static struct opts_commit_graph {
 	const char *obj_dir;
+	int stdin_packs;
 } opts;
 
 static int graph_read(int argc, const char **argv)
@@ -76,10 +77,18 @@ static int graph_read(int argc, const char **argv)
 
 static int graph_write(int argc, const char **argv)
 {
+	const char **pack_indexes = NULL;
+	int packs_nr = 0;
+	const char **lines = NULL;
+	int lines_nr = 0;
+	int lines_alloc = 0;
+
 	static struct option builtin_commit_graph_write_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			N_("dir"),
 			N_("The object directory to store the graph")),
+		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
+			N_("scan packfiles listed by stdin for commits")),
 		OPT_END(),
 	};
 
@@ -90,7 +99,25 @@ static int graph_write(int argc, const char **argv)
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
 
-	write_commit_graph(opts.obj_dir);
+	if (opts.stdin_packs) {
+		struct strbuf buf = STRBUF_INIT;
+		lines_nr = 0;
+		lines_alloc = 128;
+		ALLOC_ARRAY(lines, lines_alloc);
+
+		while (strbuf_getline(&buf, stdin) != EOF) {
+			ALLOC_GROW(lines, lines_nr + 1, lines_alloc);
+			lines[lines_nr++] = strbuf_detach(&buf, NULL);
+		}
+
+		pack_indexes = lines;
+		packs_nr = lines_nr;
+	}
+
+	write_commit_graph(opts.obj_dir,
+			   pack_indexes,
+			   packs_nr);
+
 	return 0;
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index 184b8da..4e9f1d5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -529,7 +529,9 @@ static void close_reachable(struct packed_oid_list *oids)
 	}
 }
 
-void write_commit_graph(const char *obj_dir)
+void write_commit_graph(const char *obj_dir,
+			const char **pack_indexes,
+			int nr_packs)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -552,7 +554,27 @@ void write_commit_graph(const char *obj_dir)
 		oids.alloc = 1024;
 	ALLOC_ARRAY(oids.list, oids.alloc);
 
-	for_each_packed_object(add_packed_commits, &oids, 0);
+	if (pack_indexes) {
+		struct strbuf packname = STRBUF_INIT;
+		int dirlen;
+		strbuf_addf(&packname, "%s/pack/", obj_dir);
+		dirlen = packname.len;
+		for (i = 0; i < nr_packs; i++) {
+			struct packed_git *p;
+			strbuf_setlen(&packname, dirlen);
+			strbuf_addstr(&packname, pack_indexes[i]);
+			p = add_packed_git(packname.buf, packname.len, 1);
+			if (!p)
+				die("error adding pack %s", packname.buf);
+			if (open_pack_index(p))
+				die("error opening index for %s", packname.buf);
+			for_each_object_in_pack(p, add_packed_commits, &oids);
+			close_pack(p);
+		}
+		strbuf_release(&packname);
+	} else
+		for_each_packed_object(add_packed_commits, &oids, 0);
+
 	close_reachable(&oids);
 
 	QSORT(oids.list, oids.nr, commit_compare);
diff --git a/commit-graph.h b/commit-graph.h
index b223b9b..65fe770 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -36,7 +36,9 @@ struct commit_graph {
 
 struct commit_graph *load_commit_graph_one(const char *graph_file);
 
-void write_commit_graph(const char *obj_dir);
+void write_commit_graph(const char *obj_dir,
+			const char **pack_indexes,
+			int nr_packs);
 
 #endif
 
diff --git a/packfile.c b/packfile.c
index 5d07f33..f14179f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -304,7 +304,7 @@ void close_pack_index(struct packed_git *p)
 	}
 }
 
-static void close_pack(struct packed_git *p)
+void close_pack(struct packed_git *p)
 {
 	close_pack_windows(p);
 	close_pack_fd(p);
@@ -1850,7 +1850,7 @@ int has_pack_index(const unsigned char *sha1)
 	return 1;
 }
 
-static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
+int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
 {
 	uint32_t i;
 	int r = 0;
diff --git a/packfile.h b/packfile.h
index a7fca59..b341f2b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -63,6 +63,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
 extern void close_pack_windows(struct packed_git *);
+extern void close_pack(struct packed_git *);
 extern void close_all_packs(void);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
@@ -140,6 +141,7 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
+extern int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn, void *data);
 extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
 
 /*
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 9a0cd71..6bc529c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -167,6 +167,16 @@ test_expect_success 'write graph with nothing new' '
 graph_git_behavior 'cleared graph, commit 8 vs merge 1' full commits/8 merge/1
 graph_git_behavior 'cleared graph, commit 8 vs merge 2' full commits/8 merge/2
 
+test_expect_success 'build graph from latest pack with closure' '
+	cd "$TRASH_DIRECTORY/full" &&
+	cat new-idx | git commit-graph write --stdin-packs &&
+	test_path_is_file $objdir/info/commit-graph &&
+	graph_read_expect "9" "large_edges"
+'
+
+graph_git_behavior 'graph from pack, commit 8 vs merge 1' full commits/8 merge/1
+graph_git_behavior 'graph from pack, commit 8 vs merge 2' full commits/8 merge/2
+
 test_expect_success 'setup bare repo' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone --bare --no-local full bare &&
-- 
2.7.4

