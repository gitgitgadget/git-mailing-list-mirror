Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFF0C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 13:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjBPNFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 08:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjBPNF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 08:05:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5648E3C
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 05:05:21 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z14-20020a17090abd8e00b00233bb9d6bdcso2060641pjr.4
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 05:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8Q7ScmnU0VyqPLRyJ9osRe5bKrAOzvf+/pkHVqEimw=;
        b=mZcXi3b2049HtkJPu2vypkVqMDEpEeZc2mZCNgcpWYNxpdadiF3nY7kbFqSEj0BIPB
         fFvmSJ5yh79oGtslNOgHerbHgqajz993BpStH3w0pHjzpeMYHNiqEMkrt6ATh0VeSywl
         oX2//U1jAcGTzI5VsdG9TMUPRJFKEeetKLKpF2qhhQycXXfSaFmS/wwKbk6yUjQ3hSwY
         A+Dwbwf7lqFMCPXYt5elpuO6JHpOq0l4VeBDGJFAi15uQlblX49gnJYDWmshm99u6Clq
         EPVSQkd+1xJ4xgqD8oNQtbkHWIPkySdF7aHonycIsbh2fw1YxKPHTUl6kTpCKroMaYjV
         xKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8Q7ScmnU0VyqPLRyJ9osRe5bKrAOzvf+/pkHVqEimw=;
        b=iEUqCYv3nVw9TvQxolRH5lg0TXOQEAuUU4SEEz52lZ6RrXLF6zqHP74ZNvqMniogcg
         JpV2RLf08ox/kiDqJH1KUe5FfhtXlWbskeWVS4M+u5VIvwuCAxyn5x66SR7TM0RCqWPM
         Nd522xUVXXS2d9/wfycPJzrYBEnK38Vsm62Cb964msU22ieJDfJro9ElBKMTBTDsYeop
         aFXHiQcsp8sck7QZio/oS1miPt3QzOUWLZmR9XKsZ7Bhuxz3fP0VHlDKYGnNtYv+2FW7
         EhweBLYJVYRijjAt1WPTDKLFspV3kODJGVLW6ktdW/dAiVkVWSxNcbRWYcbpIruwpBzi
         RA0A==
X-Gm-Message-State: AO0yUKWRdSNF5Zciv/9yS6bBLd+LagsBKvvEZ6DkMbJJHWDy5KcuPIyI
        gVWa2A+7M06znFY6/ItcfqfVYANZfLfagQ==
X-Google-Smtp-Source: AK7set+XbPAa881oRcC+yigav0hVeexFg2Sid8Xr2M7xAatqVkTWm9FWCVAlhNBJjGaIpVl1q21IaA==
X-Received: by 2002:a17:903:120e:b0:197:35fc:6a5d with SMTP id l14-20020a170903120e00b0019735fc6a5dmr6619215plh.30.1676552720686;
        Thu, 16 Feb 2023 05:05:20 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.52])
        by smtp.gmail.com with ESMTPSA id jk3-20020a170903330300b0019a75ea08e5sm1274581plb.33.2023.02.16.05.05.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2023 05:05:20 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v5 3/3] notes.c: introduce "--separator" option
Date:   Thu, 16 Feb 2023 21:05:05 +0800
Message-Id: <a74c96d6dd23f2f1df6d3492093f3fd27451e24c.1676551077.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.39.2.459.g31d98a8e.dirty
In-Reply-To: <cover.1676551077.git.dyroneteng@gmail.com>
References: <cover.1676551077.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When appending to a given notes object and the appended note is not
empty too, we will insert a blank line at first which separates the
existing note and the appended one, which as the separator.

Sometimes, we want to use a specified <separator> as the separator. For
example, if we specify as:

    * --separator='------': we will insert "------\n" as the separator,
    because user do not provide the line break char at last, we will add
    the trailing '\n' compatibly.

    * --separator='------\n': we will insert as-is because it contains
    the line break at last.

    * not specified --separator option: will use '\n' as the separator
    when do appending and this is the default behavour.

    * --separator='': we specify an empty separator which has the same
    behavour with --separator='\n' and or not specified the option.

In addition, if a user specifies multple "-m" with "--separator", the
separator should be inserted between the messages too, so we use
OPT_STRING_LIST instead of OPT_CALLBACK_F to parse "-m" option, make
sure the option value of "--separator" been parsed already when we need
it.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-notes.txt | 12 ++++++--
 builtin/notes.c             | 31 +++++++++++++++++---
 t/t3301-notes.sh            | 58 +++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index efbc10f0..5abe6092 100644
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
@@ -86,7 +86,9 @@ the command can read the input given to the `post-rewrite` hook.)
 
 append::
 	Append to the notes of an existing object (defaults to HEAD).
-	Creates a new notes object if needed.
+	Creates a new notes object if needed. If the note and the
+	message are not empty, "\n" will be inserted between them.
+	Use the `--separator` option to insert other delimiters.
 
 edit::
 	Edit the notes for a given object (defaults to HEAD).
@@ -159,6 +161,12 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
+--separator <separator>::
+	The '<separator>' inserted between the note and message
+	by 'append', "\n" by default. A custom separator can be
+	provided, if it doesn't end in a "\n", one will be added
+	implicitly .
+
 --ref <ref>::
 	Manipulate the notes tree in <ref>.  This overrides
 	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
diff --git a/builtin/notes.c b/builtin/notes.c
index 553ae2bd..524976fe 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -24,6 +24,7 @@
 #include "notes-utils.h"
 #include "worktree.h"
 
+static char *separator = NULL;
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
 	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
@@ -209,6 +210,16 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 	}
 }
 
+static void insert_separator(struct strbuf *message, size_t pos)
+{
+	if (!separator)
+		strbuf_insertstr(message, pos, "\n");
+	else if (separator[strlen(separator) - 1] == '\n')
+		strbuf_insertstr(message, pos, separator);
+	else
+		strbuf_insertf(message, pos, "%s%s", separator, "\n");
+}
+
 static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 {
 	struct note_data *d = opt->value;
@@ -567,11 +578,12 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const struct object_id *note;
 	char *logmsg;
 	const char * const *usage;
+	size_t message_idx;
 	struct note_data d = { .buf = STRBUF_INIT };
+	struct string_list message = STRING_LIST_INIT_DUP;
 	struct option options[] = {
-		OPT_CALLBACK_F('m', "message", &d, N_("message"),
-			N_("note contents as a string"), PARSE_OPT_NONEG,
-			parse_msg_arg),
+		OPT_STRING_LIST('m', "message", &message, N_("message"),
+			N_("note contents as a string")),
 		OPT_CALLBACK_F('F', "file", &d, N_("file"),
 			N_("note contents in a file"), PARSE_OPT_NONEG,
 			parse_file_arg),
@@ -583,6 +595,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
+		OPT_STRING(0, "separator", &separator, N_("separator"),
+			N_("insert <separator> as separator before appending a message")),
 		OPT_END()
 	};
 	int edit = !strcmp(argv[0], "edit");
@@ -596,6 +610,15 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		usage_with_options(usage, options);
 	}
 
+	for (message_idx = 0; message_idx < message.nr; message_idx++) {
+		if (d.buf.len)
+			insert_separator(&d.buf, d.buf.len);
+		strbuf_insertstr(&d.buf, d.buf.len,
+				 message.items[message_idx].string);
+		strbuf_stripspace(&d.buf, 0);
+		d.given = 1;
+	}
+
 	if (d.given && edit)
 		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
 			"for the 'edit' subcommand.\n"
@@ -618,7 +641,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		char *prev_buf = read_object_file(note, &type, &size);
 
 		if (d.buf.len && prev_buf && size)
-			strbuf_insertstr(&d.buf, 0, "\n");
+			insert_separator(&d.buf, 0);
 		if (prev_buf && size)
 			strbuf_insert(&d.buf, 0, prev_buf, size);
 		free(prev_buf);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 3288aaec..fe00497b 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -521,6 +521,64 @@ test_expect_success 'listing non-existing notes fails' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'append: specify an empty separator' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-1
+
+	notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --separator="" -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append: specify separatoro with line break' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-1
+	-------
+	notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --separator="-------$LF" -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append: specify separator without line break' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-1
+	-------
+	notes-2
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
+	notes-1
+	-------
+	notes-2
+	-------
+	notes-3
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
2.39.2.459.g31d98a8e.dirty

