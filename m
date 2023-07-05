Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FAAEB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 19:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjGETuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjGETuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 15:50:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3101985
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 12:50:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992acf67388so704251966b.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586610; x=1691178610;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YuiuopAFI+9CkSUb76FTvtN013GrgQYBYvhrAoKbW6k=;
        b=YZKYOHV4b7n+cMxHeavpuuwNNTtuvNqmiQILSHK0+UxY3E6iB1aAj5FGtiRMVA321k
         Go0z6v+BEfVGBfT/6cWG4304K4e3sFxNPIhmSm4HBASuTUsgfL2kN+Imk4D43mB1G0nN
         VzDk4m4jEw6YJAVQdEvS/Cpfgf0AApntyRl5fdyqtziW8DGluYMRZocSEjQhUTF23Lzb
         DcBpL+SCjfPFyezL+5hVmf1bATkChUS+9yRgXmOll2xjTkO9FwIv0UlVTSOlWyMYfOPN
         wa2Q6sobWdSxcW/OTxSE6l90aB2tbHpXDKZBxvMCZsLluGw6Mqh6QbFBKRs+tYBhI2gJ
         zayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586610; x=1691178610;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuiuopAFI+9CkSUb76FTvtN013GrgQYBYvhrAoKbW6k=;
        b=VY9ga9NsxFPj3HIpeTHCsLDCITDy4Ltl/VWhHEbPXhlruWWWjesFF6KFLuPXfAaGbj
         LiUmGkRdnvoTSmMYdL3RyBQ3x2YY9XR4/WTpE+WKV9L9ZjaGkmSwGOMLCveXQJ/HXdHz
         UryltC0tyYG+AGPdA+UZDo3+h1y19voqZP2i25HbnGWOL1GqyvtOdoKDR9bOqGf126gA
         l6iIz5huvssfkV8WrOF9vOf3lbl8eR2gDV6T5fB3uYJqahRj3jqW7UVDg0IJdVBbU7zK
         kXPbQEp9fkf6nPIaJIZWma/9UGLT6CE0w69Puf/Hde0Ttwaz8a9Q1jzFtG58ILBibmyC
         rIzQ==
X-Gm-Message-State: AC+VfDxpzZsnsAEO3mBURwNK1jA8aSrJsF5TMxEnZWsTH++Vw4l330BM
        qcTUvl5URsnGBDwu2A3rsCXrri9gZic=
X-Google-Smtp-Source: APBJJlFF8XwMumraLJ8L96zmmpKxUsWF1zFMPAcM4WvQfeeSt1cpEzDzqidtwi3I2aCTFYSXoKZXOA==
X-Received: by 2002:a17:906:bc88:b0:992:8892:141d with SMTP id lv8-20020a170906bc8800b009928892141dmr9798870ejb.22.1688586610057;
        Wed, 05 Jul 2023 12:50:10 -0700 (PDT)
Received: from localhost.localdomain ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id bx1-20020a170906a1c100b00992665694f7sm10078341ejb.107.2023.07.05.12.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:50:09 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 4/4] diff --no-index: support reading from named pipes
Date:   Wed,  5 Jul 2023 20:49:30 +0100
Message-ID: <4e05a0be54f66f2b394642762832e426a545426c.1688586536.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.1.852.g0a1e0755a6
In-Reply-To: <cover.1688586536.git.phillip.wood@dunelm.org.uk>
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk> <cover.1688586536.git.phillip.wood@dunelm.org.uk>
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

If the user tries to compare a named pipe to a directory then we die as
we do when trying to compare stdin to a directory.

As process substitution is not support by POSIX this change is tested by
using a pipe and a symbolic link to a pipe.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff-no-index.c          | 113 +++++++++++++++++++++++++++++----------
 t/t4053-diff-no-index.sh |  40 ++++++++++++++
 2 files changed, 125 insertions(+), 28 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 4470e0271d..4771cf02aa 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -41,74 +41,119 @@ static int read_directory_contents(const char *path, struct string_list *list)
  */
 static const char file_from_standard_input[] = "-";
 
-static int get_mode(const char *path, int *mode)
+/*
+ * For paths given on the command-line we treat "-" as stdin and named
+ * pipes and symbolic links to named pipes specially.
+ */
+enum special {
+	SPECIAL_NONE,
+	SPECIAL_STDIN,
+	SPECIAL_PIPE,
+};
+
+static int get_mode(const char *path, int *mode, enum special *special)
 {
 	struct stat st;
 
-	if (!path || !strcmp(path, "/dev/null"))
+	if (!path || !strcmp(path, "/dev/null")) {
 		*mode = 0;
 #ifdef GIT_WINDOWS_NATIVE
-	else if (!strcasecmp(path, "nul"))
+	} else if (!strcasecmp(path, "nul")) {
 		*mode = 0;
 #endif
-	else if (path == file_from_standard_input)
+	} else if (path == file_from_standard_input) {
 		*mode = create_ce_mode(0666);
-	else if (lstat(path, &st))
+		*special = SPECIAL_STDIN;
+	} else if (lstat(path, &st)) {
 		return error("Could not access '%s'", path);
-	else
+	} else {
 		*mode = st.st_mode;
+	}
+	/*
+	 * For paths on the command-line treat named pipes and symbolic
+	 * links that resolve to a named pipe specially.
+	 */
+	if (special &&
+	    (S_ISFIFO(*mode) ||
+	     (S_ISLNK(*mode) && !stat(path, &st) && S_ISFIFO(st.st_mode)))) {
+		*mode = create_ce_mode(0666);
+		*special = SPECIAL_PIPE;
+	}
+
 	return 0;
 }
 
-static void populate_from_stdin(struct diff_filespec *s)
+static void populate_common(struct diff_filespec *s, struct strbuf *buf)
 {
-	struct strbuf buf = STRBUF_INIT;
 	size_t size = 0;
 
-	if (strbuf_read(&buf, 0, 0) < 0)
-		die_errno("error while reading from stdin");
-
 	s->should_munmap = 0;
-	s->data = strbuf_detach(&buf, &size);
+	s->data = strbuf_detach(buf, &size);
 	s->size = size;
 	s->should_free = 1;
 	s->is_stdin = 1;
 }
 
-static struct diff_filespec *noindex_filespec(const char *name, int mode)
+static void populate_from_pipe(struct diff_filespec *s)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int fd = xopen(s->path, O_RDONLY);
+
+	if (strbuf_read(&buf, fd, 0) < 0)
+		die_errno("error while reading from '%s'", s->path);
+	close(fd);
+	populate_common(s, &buf);
+}
+
+static void populate_from_stdin(struct diff_filespec *s)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (strbuf_read(&buf, 0, 0) < 0)
+		die_errno("error while reading from stdin");
+	populate_common(s, &buf);
+}
+
+static struct diff_filespec *noindex_filespec(const char *name, int mode,
+					      enum special special)
 {
 	struct diff_filespec *s;
 
 	if (!name)
 		name = "/dev/null";
 	s = alloc_filespec(name);
 	fill_filespec(s, null_oid(), 0, mode);
-	if (name == file_from_standard_input)
+	if (special == SPECIAL_STDIN)
 		populate_from_stdin(s);
+	else if (special == SPECIAL_PIPE)
+		populate_from_pipe(s);
 	return s;
 }
 
 static int queue_diff(struct diff_options *o,
-		      const char *name1, const char *name2)
+		      const char *name1, const char *name2, int recursing)
 {
 	int mode1 = 0, mode2 = 0;
+	enum special special1 = SPECIAL_NONE, special2 = SPECIAL_NONE;
 
-	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
+	/* Paths can only be special if we're not recursing. */
+	if (get_mode(name1, &mode1, recursing ? NULL : &special1) ||
+	    get_mode(name2, &mode2, recursing ? NULL : &special2))
 		return -1;
 
 	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
 		struct diff_filespec *d1, *d2;
 
 		if (S_ISDIR(mode1)) {
 			/* 2 is file that is created */
-			d1 = noindex_filespec(NULL, 0);
-			d2 = noindex_filespec(name2, mode2);
+			d1 = noindex_filespec(NULL, 0, SPECIAL_NONE);
+			d2 = noindex_filespec(name2, mode2, special2);
 			name2 = NULL;
 			mode2 = 0;
 		} else {
 			/* 1 is file that is deleted */
-			d1 = noindex_filespec(name1, mode1);
-			d2 = noindex_filespec(NULL, 0);
+			d1 = noindex_filespec(name1, mode1, special1);
+			d2 = noindex_filespec(NULL, 0, SPECIAL_NONE);
 			name1 = NULL;
 			mode1 = 0;
 		}
@@ -173,7 +218,7 @@ static int queue_diff(struct diff_options *o,
 				n2 = buffer2.buf;
 			}
 
-			ret = queue_diff(o, n1, n2);
+			ret = queue_diff(o, n1, n2, 1);
 		}
 		string_list_clear(&p1, 0);
 		string_list_clear(&p2, 0);
@@ -189,8 +234,8 @@ static int queue_diff(struct diff_options *o,
 			SWAP(name1, name2);
 		}
 
-		d1 = noindex_filespec(name1, mode1);
-		d2 = noindex_filespec(name2, mode2);
+		d1 = noindex_filespec(name1, mode1, special1);
+		d2 = noindex_filespec(name2, mode2, special2);
 		diff_queue(&diff_queued_diff, d1, d2);
 		return 0;
 	}
@@ -215,15 +260,27 @@ static void append_basename(struct strbuf *path, const char *dir, const char *fi
  */
 static void fixup_paths(const char **path, struct strbuf *replacement)
 {
-	unsigned int isdir0, isdir1;
-
-	isdir0 = path[0] != file_from_standard_input && is_directory(path[0]);
-	isdir1 = path[1] != file_from_standard_input && is_directory(path[1]);
+	struct stat st;
+	unsigned int isdir0 = 0, isdir1 = 0;
+	unsigned int ispipe0 = 0, ispipe1 = 0;
+
+	if (path[0] != file_from_standard_input && !stat(path[0], &st)) {
+		isdir0 = S_ISDIR(st.st_mode);
+		ispipe0 = S_ISFIFO(st.st_mode);
+	}
+
+	if (path[1] != file_from_standard_input && !stat(path[1], &st)) {
+		isdir1 = S_ISDIR(st.st_mode);
+		ispipe1 = S_ISFIFO(st.st_mode);
+	}
 
 	if ((path[0] == file_from_standard_input && isdir1) ||
 	    (isdir0 && path[1] == file_from_standard_input))
 		die(_("cannot compare stdin to a directory"));
 
+	if ((isdir0 && ispipe1) || (ispipe0 && isdir1))
+		die(_("cannot compare a named pipe to a directory"));
+
 	if (isdir0 == isdir1)
 		return;
 	if (isdir0) {
@@ -297,7 +354,7 @@ int diff_no_index(struct rev_info *revs,
 	setup_diff_pager(&revs->diffopt);
 	revs->diffopt.flags.exit_with_status = 1;
 
-	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
+	if (queue_diff(&revs->diffopt, paths[0], paths[1], 0))
 		goto out;
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 4870443609..a28b9ff243 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -229,4 +229,44 @@ test_expect_success 'diff --no-index refuses to diff stdin and a directory' '
 	grep "fatal: cannot compare stdin to a directory" err
 '
 
+test_expect_success PIPE 'diff --no-index refuses to diff a named pipe and a directory' '
+	test_when_finished "rm -f pipe" &&
+	mkfifo pipe &&
+	{
+		(>pipe) &
+	} &&
+	test_when_finished "kill $!" &&
+	test_must_fail git diff --no-index -- pipe a 2>err &&
+	grep "fatal: cannot compare a named pipe to a directory" err
+'
+
+test_expect_success PIPE,SYMLINKS 'diff --no-index reads from pipes' '
+	test_when_finished "rm -f old new new-link" &&
+	mkfifo old &&
+	mkfifo new &&
+	ln -s new new-link &&
+	{
+		(test_write_lines a b c >old) &
+	} &&
+	test_when_finished "! kill $!" &&
+	{
+		(test_write_lines a x c >new) &
+	} &&
+	test_when_finished "! kill $!" &&
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
2.40.1.852.g0a1e0755a6

