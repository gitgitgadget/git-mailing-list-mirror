Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F37B1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 22:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfBUWiR (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 17:38:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40979 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUWiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 17:38:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id n2so237206wrw.8
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 14:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84ICIEhC+81UHaFSxIJY8vcx3RB+4x7+JovVQfbCLgg=;
        b=FHKCUeMPcqIPZplYEsYO61AXs+WymEXxsHrwdHBCnJux2qKi38xZmg0NOum3LhcRlo
         Vu/rzgeRJPmoVoXaFwoybhKjny6Bvo23xY0R+inCwzemQCHJ0IzGuZsVNMI3CtKdSTe7
         +r7cj2LkqBMABKovIhfCmytKnJbNW2inuKV243hep0358J2qVmJWbF+F3hcoyOHPov3P
         ktgEJxkEqNQEjTDHmgt2CLFgsWFobnkqrJDOIoGGEHD/icrGi9shNdnGzBzNyoCUbyj7
         5+Cbd3pfbxknuJ4jb/aL4pPjTmod5ZUzvJrLYTD0zMBmYEdyO5xm11v3JHj3M0j2F4/Z
         jtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84ICIEhC+81UHaFSxIJY8vcx3RB+4x7+JovVQfbCLgg=;
        b=UTepLMWlpZpWR1qwjGBxHNdr27eCcQC4UuzdldyVa9MulH8eu05WDI6fyqpocaO/5l
         P7tiDaZfol0rjQT1XdytKO4ZUjHYMZgOM2t/HeFA/PsT5IGBxr8vVPVAD7FGIc2C+fdo
         87VqtyxIjoDD0sg+nWFUuQu0Xd20T5P0Yn8c7IKzDgZQCNw3SYRm/RxAAl6EVVuTnxZi
         iaSdbxqkw6AR3iBFBmK0k26WuWvVNyJDR5BRvXrxlwD9sMe1SZ+e0OEAawD4Vpwmt9Rn
         69BT7GFjd1dOXwmd2iWNbdzg06X2ewmYWtpwI2qV6plW582DtG06RU/yePfP6Ix1ovQs
         TFuw==
X-Gm-Message-State: AHQUAuagFaGXDOZryg/7dLgN/RhlmNmkCFfJofPOt3xMA9+P6JR+d5zM
        G0ut9ITVhyXkyvtSjeg3E4gKN5/5XCU=
X-Google-Smtp-Source: AHgI3IZe9C3t6AfBEJiN1V+JH4zkzwD5qqOxRTTUgLg4vlkyKP3zrC8EGO2bBtOq/P2kNE4FaiU4ig==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr506211wro.255.1550788694305;
        Thu, 21 Feb 2019 14:38:14 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v196sm110803wmf.15.2019.02.21.14.38.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 14:38:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/8] commit-graph: don't early exit(1) on e.g. "git status"
Date:   Thu, 21 Feb 2019 23:37:49 +0100
Message-Id: <20190221223753.20070-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190221223753.20070-1-avarab@gmail.com>
References: <20190221223753.20070-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the commit-graph loading code work as a library that returns an
error code instead of calling exit(1) when the commit-graph is
corrupt. This means that e.g. "status" will now report commit-graph
corruption as an "error: [...]" at the top of its output, but then
proceed to work normally.

This required splitting up the load_commit_graph_one() function so
that the code that deals with open()-ing and stat()-ing the graph can
now be called independently as open_commit_graph().

This is needed because "commit-graph verify" where the graph doesn't
exist isn't an error. See the third paragraph in
283e68c72f ("commit-graph: add 'verify' subcommand",
2018-06-27). There's a bug in that logic where we conflate the
intended ENOENT with other errno values (e.g. EACCES), but this change
doesn't address that. That'll be addressed in a follow-up change.

I'm then splitting most of the logic out of load_commit_graph_one()
into load_commit_graph_one_fd_st(), which allows for providing an
existing file descriptor and stat information to the loading
code. This isn't strictly needed, but it would be redundant and
confusing to open() and stat() the file twice for some of the
codepaths, this allows for calling open_commit_graph() followed by
load_commit_graph_one_fd_st(). The "graph_file" still needs to be
passed to that function for the the "graph file %s is too small" error
message.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c  | 21 +++++++++++++++++----
 commit-graph.c          | 42 +++++++++++++++++++++++++++++------------
 commit-graph.h          |  3 +++
 t/t5318-commit-graph.sh |  2 +-
 4 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 4ae502754c..32bcc63427 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -42,6 +42,9 @@ static int graph_verify(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
 	char *graph_name;
+	int open_ok;
+	int fd;
+	struct stat st;
 
 	static struct option builtin_commit_graph_verify_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -58,11 +61,14 @@ static int graph_verify(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 
 	graph_name = get_commit_graph_filename(opts.obj_dir);
-	graph = load_commit_graph_one(graph_name);
+	open_ok = open_commit_graph(graph_name, &fd, &st);
+	if (!open_ok)
+		return 0;
+	graph = load_commit_graph_one_fd_st(graph_name, fd, &st);
 	FREE_AND_NULL(graph_name);
 
 	if (!graph)
-		return 0;
+		return 1;
 
 	UNLEAK(graph);
 	return verify_commit_graph(the_repository, graph);
@@ -72,6 +78,9 @@ static int graph_read(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
 	char *graph_name;
+	int open_ok;
+	int fd;
+	struct stat st;
 
 	static struct option builtin_commit_graph_read_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -88,10 +97,14 @@ static int graph_read(int argc, const char **argv)
 		opts.obj_dir = get_object_directory();
 
 	graph_name = get_commit_graph_filename(opts.obj_dir);
-	graph = load_commit_graph_one(graph_name);
 
+	open_ok = open_commit_graph(graph_name, &fd, &st);
+	if (!open_ok)
+		die_errno(_("Could not open commit-graph '%s'"), graph_name);
+
+	graph = load_commit_graph_one_fd_st(graph_name, fd, &st);
 	if (!graph)
-		die("graph file %s does not exist", graph_name);
+		return 1;
 
 	FREE_AND_NULL(graph_name);
 
diff --git a/commit-graph.c b/commit-graph.c
index 980fbf47ea..b1ba7a09cc 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -80,25 +80,31 @@ static int commit_graph_compatible(struct repository *r)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one(const char *graph_file)
+int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
+{
+	*fd = git_open(graph_file);
+	if (*fd < 0)
+		return 0;
+	if (fstat(*fd, st)) {
+		close(*fd);
+		return 0;
+	}
+	return 1;
+}
+
+struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
+						 int fd, struct stat *st)
 {
 	void *graph_map;
 	size_t graph_size;
-	struct stat st;
 	struct commit_graph *ret;
-	int fd = git_open(graph_file);
 
-	if (fd < 0)
-		return NULL;
-	if (fstat(fd, &st)) {
-		close(fd);
-		return NULL;
-	}
-	graph_size = xsize_t(st.st_size);
+	graph_size = xsize_t(st->st_size);
 
 	if (graph_size < GRAPH_MIN_SIZE) {
 		close(fd);
-		die(_("graph file %s is too small"), graph_file);
+		error(_("graph file %s is too small"), graph_file);
+		return 0;
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	ret = parse_commit_graph(graph_map, fd, graph_size);
@@ -106,12 +112,24 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	if (!ret) {
 		munmap(graph_map, graph_size);
 		close(fd);
-		exit(1);
 	}
 
 	return ret;
 }
 
+struct commit_graph *load_commit_graph_one(const char *graph_file)
+{
+
+	struct stat st;
+	int fd;
+	int open_ok = open_commit_graph(graph_file, &fd, &st);
+
+	if (!open_ok)
+		return NULL;
+
+	return load_commit_graph_one_fd_st(graph_file, fd, &st);
+}
+
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size)
 {
diff --git a/commit-graph.h b/commit-graph.h
index 275f97d006..e4f17071e2 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -11,6 +11,7 @@
 struct commit;
 
 char *get_commit_graph_filename(const char *obj_dir);
+int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 
 /*
  * Given a commit struct, try to fill the commit struct info, including:
@@ -53,6 +54,8 @@ struct commit_graph {
 };
 
 struct commit_graph *load_commit_graph_one(const char *graph_file);
+struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
+						 int fd, struct stat *st);
 
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index b3f3e515fc..0d012f55e5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -377,7 +377,7 @@ corrupt_graph_verify() {
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
 	test_i18ngrep "$grepstr" err &&
-	test_might_fail git status --short
+	git status --short
 }
 
 # usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
-- 
2.21.0.rc0.258.g878e2cd30e

