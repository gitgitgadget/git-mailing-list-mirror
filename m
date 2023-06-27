Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD204EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjF0OLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjF0OLT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:11:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18272D76
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:11:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso16922265e9.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687875076; x=1690467076;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wNk+9Qm+4KCyRLKjS7gqnGcgEpbLwtiiNAuRR7zS0mo=;
        b=rauZ3xGZvWD3hnYKJDp4lv8f8h6q4SFsUi35PYYU2jMcWn5orOwepmxlpMutW+cT4o
         FwFcTerJN6hN9T3mlnynRFKovai+IWtg5EGLvGXbJd29eLvKQ+0Xyo8p1ClMw08zO3hE
         T4gjuPKB2kxKnOV+wQugvm+JpCUDzsYfzZ9FTlGTuODE+j0IULgRSyWUxkJBZZ/eIPzn
         j7Rqj6FtGwQgQJCbYtJmdsRiT3aKS2Q40/K8qr19vMa8IXNeQpgb5fKmi7ReY03BmrkO
         T8L3Vw8U4NCph8IgFBMb0+6S8YO7hrQqhqjQ1PwHckdj0rZTdpdYYgHGuYo3UlKaaUg4
         CDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875076; x=1690467076;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNk+9Qm+4KCyRLKjS7gqnGcgEpbLwtiiNAuRR7zS0mo=;
        b=Gw/gcqeR8zBMSKAyQMKpwItqp+eg+a1N0lsTc8YA4n9kufvSBcYKPtSCQ8VfUB5fzQ
         piL2Dw6hPshLbI1pzq5M64HENB0VGuCY1Mutcbvnx+TSUu5NHQbhNAOyixOXLcD6Ez3l
         afHJJEYosNl22q4wO3fgrfVWk9Ib0udzh5/kDz9sTHEekqPqgLPQW/0LWqxNxb6/B1Sk
         ihe7O9dXlbMRpbyGmdXr6KymeN9wp8nZ9PzSJS5VNaGYs+xkGu0EniouPdmXakcTk4Rh
         RDPaVMdHzEEq8SzfXhbrOI8myW5zu/QSEz4892Vf5ryOver4SKZggZK7xBR5ip0yTCzL
         fptg==
X-Gm-Message-State: AC+VfDzYGqvJ9tdtyhRxjCUY75PCdyhgpA4cXFH9RZvb9vcKlHgKP3X0
        Jx30Mr9Jh8HDv3eSveJInEAngwoIHrE=
X-Google-Smtp-Source: ACHHUZ7KhbsRruyPSwah/52OeF6FFSpOyVsKny2H1KnNce16curfeAl5wB0Vw/s80pwzaDZ8S85iOw==
X-Received: by 2002:a1c:791a:0:b0:3fa:76e2:e6d5 with SMTP id l26-20020a1c791a000000b003fa76e2e6d5mr11964508wme.37.1687875075129;
        Tue, 27 Jun 2023 07:11:15 -0700 (PDT)
Received: from localhost.localdomain ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003fb9ebb6b88sm2581935wmj.39.2023.06.27.07.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:11:14 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 3/3] diff --no-index: support reading from named pipes
Date:   Tue, 27 Jun 2023 15:10:16 +0100
Message-ID: <990e71882bfdc697285c5b04b92c290679ca22ab.1687874975.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.1.852.g22d29fd9ba
In-Reply-To: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In some shells, such as bash and zsh, it's possible to use a command
substitution to provide the output of a command as a file argument to
another process, like so:

  diff -u <(printf "a\nb\n") <(printf "a\nc\n")

However, this syntax does not produce useful results with "git diff
--no-index". On macOS, the arguments to the command are named pipes
under /dev/fd, and git diff doesn't know how to handle a named pipe. On
Linux, the arguments are symlinks to pipes, so git diff "helpfully"
diffs these symlinks, comparing their targets like "pipe:[1234]" and
"pipe:[5678]".

To address this "diff --no-index" is changed so that if a path given on
the commandline is a named pipe or a symbolic link that resolves to a
named pipe then we read the data to diff from that pipe. This is
implemented by generalizing the code that already exists to handle
reading from stdin when the user passes the path "-".

As process substitution is not support by POSIX this change is tested by
using a pipe and a symbolic link to a pipe.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff-no-index.c          | 80 ++++++++++++++++++++++++----------------
 t/t4053-diff-no-index.sh | 25 +++++++++++++
 2 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 7b9327f8f3..45fbd7cdbe 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -41,7 +41,7 @@ static int read_directory_contents(const char *path, struct string_list *list)
  */
 static const char file_from_standard_input[] = "-";
 
-static int get_mode(const char *path, int *mode)
+static int get_mode(const char *path, int is_pipe, int *mode)
 {
 	struct stat st;
 
@@ -51,7 +51,7 @@ static int get_mode(const char *path, int *mode)
 	else if (!strcasecmp(path, "nul"))
 		*mode = 0;
 #endif
-	else if (path == file_from_standard_input)
+	else if (is_pipe)
 		*mode = create_ce_mode(0666);
 	else if (lstat(path, &st))
 		return error("Could not access '%s'", path);
@@ -60,13 +60,18 @@ static int get_mode(const char *path, int *mode)
 	return 0;
 }
 
-static void populate_from_stdin(struct diff_filespec *s)
+static void populate_from_pipe(struct diff_filespec *s, int is_stdin)
 {
 	struct strbuf buf = STRBUF_INIT;
 	size_t size = 0;
+	int fd = 0;
 
-	if (strbuf_read(&buf, 0, 0) < 0)
+	if (!is_stdin)
+		fd = xopen(s->path, O_RDONLY);
+	if (strbuf_read(&buf, fd, 0) < 0)
 		die_errno("error while reading from stdin");
+	if (!is_stdin)
+		close(fd);
 
 	s->should_munmap = 0;
 	s->data = strbuf_detach(&buf, &size);
@@ -75,40 +80,43 @@ static void populate_from_stdin(struct diff_filespec *s)
 	s->is_stdin = 1;
 }
 
-static struct diff_filespec *noindex_filespec(const char *name, int mode)
+static struct diff_filespec *noindex_filespec(const char *name, int is_pipe,
+					      int mode)
 {
 	struct diff_filespec *s;
 
 	if (!name)
 		name = "/dev/null";
 	s = alloc_filespec(name);
 	fill_filespec(s, null_oid(), 0, mode);
-	if (name == file_from_standard_input)
-		populate_from_stdin(s);
+	if (is_pipe)
+		populate_from_pipe(s, name == file_from_standard_input);
 	return s;
 }
 
 static int queue_diff(struct diff_options *o,
-		      const char *name1, const char *name2)
+		      const char *name1, int is_pipe1,
+		      const char *name2, int is_pipe2)
 {
 	int mode1 = 0, mode2 = 0;
 
-	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
+	if (get_mode(name1, is_pipe1, &mode1) ||
+	    get_mode(name2, is_pipe2, &mode2))
 		return -1;
 
 	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
 		struct diff_filespec *d1, *d2;
 
 		if (S_ISDIR(mode1)) {
 			/* 2 is file that is created */
-			d1 = noindex_filespec(NULL, 0);
-			d2 = noindex_filespec(name2, mode2);
+			d1 = noindex_filespec(NULL, 0, 0);
+			d2 = noindex_filespec(name2, is_pipe2, mode2);
 			name2 = NULL;
 			mode2 = 0;
 		} else {
 			/* 1 is file that is deleted */
-			d1 = noindex_filespec(name1, mode1);
-			d2 = noindex_filespec(NULL, 0);
+			d1 = noindex_filespec(name1, is_pipe1, mode1);
+			d2 = noindex_filespec(NULL, 0, 0);
 			name1 = NULL;
 			mode1 = 0;
 		}
@@ -173,7 +181,7 @@ static int queue_diff(struct diff_options *o,
 				n2 = buffer2.buf;
 			}
 
-			ret = queue_diff(o, n1, n2);
+			ret = queue_diff(o, n1, 0, n2, 0);
 		}
 		string_list_clear(&p1, 0);
 		string_list_clear(&p2, 0);
@@ -189,8 +197,8 @@ static int queue_diff(struct diff_options *o,
 			SWAP(name1, name2);
 		}
 
-		d1 = noindex_filespec(name1, mode1);
-		d2 = noindex_filespec(name2, mode2);
+		d1 = noindex_filespec(name1, is_pipe1, mode1);
+		d2 = noindex_filespec(name2, is_pipe2, mode2);
 		diff_queue(&diff_queued_diff, d1, d2);
 		return 0;
 	}
@@ -213,18 +221,11 @@ static void append_basename(struct strbuf *path, const char *dir, const char *fi
  * Note that we append the basename of F to D/, so "diff a/b/file D"
  * becomes "diff a/b/file D/file", not "diff a/b/file D/a/b/file".
  */
-static void fixup_paths(const char **path, struct strbuf *replacement)
+static void fixup_paths(const char **path, int *is_dir, struct strbuf *replacement)
 {
-	unsigned int isdir0, isdir1;
-
-	if (path[0] == file_from_standard_input ||
-	    path[1] == file_from_standard_input)
-		return;
-	isdir0 = is_directory(path[0]);
-	isdir1 = is_directory(path[1]);
-	if (isdir0 == isdir1)
-		return;
-	if (isdir0) {
+	if (is_dir[0] == is_dir[1])
+		return;
+	if (is_dir[0]) {
 		append_basename(replacement, path[0], path[1]);
 		path[0] = replacement->buf;
 	} else {
@@ -246,6 +247,8 @@ int diff_no_index(struct rev_info *revs,
 	int ret = 1;
 	const char *paths[2];
 	char *to_free[ARRAY_SIZE(paths)] = { 0 };
+	int is_dir[ARRAY_SIZE(paths)] = { 0 };
+	int is_pipe[ARRAY_SIZE(paths)] = { 0 };
 	struct strbuf replacement = STRBUF_INIT;
 	const char *prefix = revs->prefix;
 	struct option no_index_options[] = {
@@ -267,18 +270,30 @@ int diff_no_index(struct rev_info *revs,
 	FREE_AND_NULL(options);
 	for (i = 0; i < 2; i++) {
 		const char *p = argv[i];
-		if (!strcmp(p, "-"))
+		if (!strcmp(p, "-")) {
 			/*
 			 * stdin should be spelled as "-"; if you have
 			 * path that is "-", spell it as "./-".
 			 */
 			p = file_from_standard_input;
-		else if (prefix)
-			p = to_free[i] = prefix_filename(prefix, p);
+			is_pipe[i] = 1;
+		} else {
+			struct stat st;
+
+			if (prefix)
+				p = to_free[i] = prefix_filename(prefix, p);
+			if (stat(p, &st))
+				;
+			else if (S_ISDIR(st.st_mode))
+				is_dir[i] = 1;
+			else if (S_ISFIFO(st.st_mode))
+				is_pipe[i] = 1;
+		}
 		paths[i] = p;
 	}
 
-	fixup_paths(paths, &replacement);
+	if (!is_pipe[0] && !is_pipe[1])
+		fixup_paths(paths, is_dir, &replacement);
 
 	revs->diffopt.skip_stat_unmatch = 1;
 	if (!revs->diffopt.output_format)
@@ -295,7 +310,8 @@ int diff_no_index(struct rev_info *revs,
 	setup_diff_pager(&revs->diffopt);
 	revs->diffopt.flags.exit_with_status = 1;
 
-	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
+	if (queue_diff(&revs->diffopt,
+		       paths[0], is_pipe[0], paths[1], is_pipe[1]))
 		goto out;
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index d14b194ea2..30b9e2c2f0 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -223,4 +223,29 @@ test_expect_success "diff --no-index treats '-' as stdin" '
 	test_write_lines 1 | git diff --no-index -- a/1 - >actual &&
 	test_must_be_empty actual
 '
+
+test_expect_success PIPE,SYMLINKS 'diff --no-index reads from pipes' '
+	mkfifo old &&
+	mkfifo new &&
+	ln -s new new-link &&
+	{
+		(test_write_lines a b c >old) &
+		(test_write_lines a x c >new) &
+	} &&
+
+	cat >expect <<-EOF &&
+	diff --git a/old b/new-link
+	--- a/old
+	+++ b/new-link
+	@@ -1,3 +1,3 @@
+	 a
+	-b
+	+x
+	 c
+	EOF
+
+	test_expect_code 1 git diff --no-index old new-link >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.40.1.852.g22d29fd9ba

