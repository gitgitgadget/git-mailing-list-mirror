Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47890C5479D
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 02:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjALCtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 21:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbjALCsg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 21:48:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39244858C
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o13so14271277pjg.2
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 18:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+7JCtNpCj9j7PNrYcHdDVZ+tZSELi7Lm2cCzOXCHZE=;
        b=jPLqmKRDR7/9SX7mGBZ5DKpOraKZOznDK2oRjObJw2H1s2IMLO+i+S5yX4Gjownn16
         GoCEneQMhBLkq/WbJLpi4fM06Q7wjxh58gWovuh3LhbQ7+7qvoBT/pmE7XqEHo0Eouh7
         O2/uXKwXmm6/9nUShQXyAoPNwhXyWHD/a4ezDOhQ2Ld+VypsMsHRefVRvR0FpxvW5bxV
         XqYyNuoimgmy0DkJaQWvPtTkA+ADWRLGwLpnj/b9ZD6MIUPfE3um6hedTX4Up9xiX/SZ
         9Y5fMe2XN3kuF23w+kVXuWya2hJIQOf+2O3p/3wJtzDriyoi1knU8pkTchyd+l+geuB6
         q3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+7JCtNpCj9j7PNrYcHdDVZ+tZSELi7Lm2cCzOXCHZE=;
        b=WI5G3QN8anlgGCbrNKB+v4yUgeQYxU8Vq6n7c2Kh2fo6ECy5CHOtOC3oUyI2hGX93W
         +fcvL0MGl9eME0SLqD+ZGlGpriEdlDrGX+CgNYN25Qmw/B4vLAsocpgVeatUh4G0oYK1
         BmFVxGRXUnD5hvycKAQa8k0C+8GqACCno4+rnoCHnOvNnugpTkUCwyR8lRx57EWAK5nd
         q+mpdXXoXuD/Jto6tFs+rsXgw3oVBsWi1yR2kHBnK+JZ3SEphq4FnfVSvNQm8r40AtYh
         g+CW0EB1rl7QUCx+Lq4AGWQiCMDIw1LcwAnxvXROctNwFLGrMzuykgDYZeBn+34433Xr
         s/7g==
X-Gm-Message-State: AFqh2kocjkzpB/a8ZdbvF47iqgFEOgUoHGOAf1fw7Q3TFaMLK5x89k7a
        g3jMf35JJ+uDGW7L4OVli2w=
X-Google-Smtp-Source: AMrXdXseCWVRU9jzsfhnxhAi6CrH7IuCAG/n111bdO9P/7kD2CA3lH1qtkuKS7VUBEnEGa5KXy+PHQ==
X-Received: by 2002:a17:903:482:b0:192:f961:c391 with SMTP id jj2-20020a170903048200b00192f961c391mr29322575plb.53.1673491709230;
        Wed, 11 Jan 2023 18:48:29 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b001926392adf9sm10855227plh.271.2023.01.11.18.48.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2023 18:48:28 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com,
        sunshine@sunshineco.com
Subject: [PATCH v4 5/5] notes.c: introduce "--separator" option
Date:   Thu, 12 Jan 2023 10:48:09 +0800
Message-Id: <f7edbd0e508243ab55c13721a21b78bf50278a21.1673490953.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g6952793f2d9.dirty
In-Reply-To: <cover.1673490953.git.dyroneteng@gmail.com>
References: <cover.1673490953.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When appending to a given notes object and the appended note is not
empty too, we will insert a blank line at first which separates the
existing note and the appended one, which as the separator.

Sometimes, we want to use a specified <text> as the separator. For
example, if we specify as:

    * --separator='------': we will insert "------\n" as the separator,
    because user do not provide the line break char at last, we will add
    the trailing '\n' compatibly.

    * --separator='------\n': we will insert as-is because it contains
    the line break at last.

    * --separator='': we specify an empty separator which means will
    append the message directly without inserting any separator at
    first.

    * not specified --separator option: will use '\n' as the separator
    when do appending and this is the default behavour.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-notes.txt | 18 +++++++++--
 builtin/notes.c             | 49 +++++++++++++++++++++++++++---
 t/t3301-notes.sh            | 59 +++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index efbc10f0f5..227fa88317 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git notes' [list [<object>]]
 'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' append [--allow-empty] [--separator] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [--allow-empty] [<object>]
 'git notes' show [<object>]
 'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
@@ -86,7 +86,11 @@ the command can read the input given to the `post-rewrite` hook.)
 
 append::
 	Append to the notes of an existing object (defaults to HEAD).
-	Creates a new notes object if needed.
+	Creates a new notes object if needed. If the note of the given
+	object and the note to be appended are not empty, a blank line
+	will be inserted between them as the separator ("blank line" is
+	the default behavior, `--separator` option supports to specify
+	a customized one).
 
 edit::
 	Edit the notes for a given object (defaults to HEAD).
@@ -159,6 +163,16 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
+--separator <text>::
+	Specify the <text> to be inserted between existing note and appended
+	message, the <text> acts as a separator.
+	If <text> is empty (`--separator=''`), will append the message to
+	existing note directly without insert any separator.
+	If <text> is nonempty, will use as-is. One thing to notice is if
+	the <text> lacks newline charactor, will add the newline automatically.
+	If not specify this option, a blank line will be inserted as the
+	separator.
+
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
diff --git a/builtin/notes.c b/builtin/notes.c
index f2efb3736c..6746ad3232 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -24,6 +24,8 @@
 #include "notes-utils.h"
 #include "worktree.h"
 
+static char *separator = "\n";
+
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
 	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
@@ -209,7 +211,7 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 	}
 }
 
-static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
+static int parse_msg_arg_add(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
 
@@ -225,6 +227,43 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static void insert_separator(struct strbuf *message)
+{
+	const char *insert;
+
+	if (!separator)
+		separator = "\n";
+	if (*separator == '\0')
+		/* separator is empty; use as-is (no blank line) */
+		return;
+	else if (separator[strlen(separator) - 1] == '\n')
+		/* user supplied newline; use as-is */
+		insert = separator;
+	else
+		/* separator lacks newline; add it ourselves */
+		insert = xstrfmt("%s%s", separator,"\n");
+	strbuf_insertstr(message, 0, insert);
+}
+
+static int parse_msg_arg_append(const struct option *opt, const char *arg, int unset)
+{
+	struct note_data *d = opt->value;
+	struct strbuf append = STRBUF_INIT;
+
+	BUG_ON_OPT_NEG(unset);
+
+	strbuf_addstr(&append, arg);
+	if (d->buf.len){
+		insert_separator(&append);
+	}
+	strbuf_addbuf(&d->buf, &append);
+	strbuf_stripspace(&d->buf, 0);
+
+	d->given = 1;
+	strbuf_release(&append);
+	return 0;
+}
+
 static int parse_file_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
@@ -406,7 +445,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
-			parse_msg_arg),
+			parse_msg_arg_add),
 		OPT_CALLBACK_F('F', "file", &d, N_("file"),
 			N_("note contents in a file"), PARSE_OPT_NONEG,
 			parse_file_arg),
@@ -572,7 +611,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
-			parse_msg_arg),
+			parse_msg_arg_append),
 		OPT_CALLBACK_F('F', "file", &d, N_("file"),
 			N_("note contents in a file"), PARSE_OPT_NONEG,
 			parse_file_arg),
@@ -584,6 +623,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
+		OPT_STRING(0, "separator", &separator, N_("text"),
+			N_("insert <text> as separator before appending to an existing note")),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
@@ -619,7 +660,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		char *prev_buf = read_object_file(note, &type, &size);
 
 		if (d.buf.len && prev_buf && size)
-			strbuf_insertstr(&d.buf, 0, "\n");
+			insert_separator(&d.buf);
 		if (prev_buf && size)
 			strbuf_insert(&d.buf, 0, prev_buf, size);
 		free(prev_buf);
git format-patch a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1  --thread -v 4 --output-directory=outgoing/git-notes-append/v4 --cover-letter  --range-diff 196e80358ediff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index e7807e052a..e8bc9934ed 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -521,6 +521,65 @@ test_expect_success 'listing non-existing notes fails' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'append: specify an empty separator' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+		notes-1
+		notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --separator="" -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+
+'
+
+test_expect_success 'append: specify separatoro with line break' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+		notes-1
+		-------
+		notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	separator=$(printf "%s\n" "-------") &&
+	git notes append --separator="$separator" -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append: specify separator without line break' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+		notes-1
+		-------
+		notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --separator="-------" -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append: specify separator with multiple messages' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+		notes-1
+		-------
+		notes-2
+		-------
+		notes-3
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --separator="-------" -m "notes-2" -m "notes-3" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'append to existing note with "git notes append"' '
 	cat >expect <<-EOF &&
 		Initial set of notes
-- 
2.38.1.386.g6952793f2d9.dirty

