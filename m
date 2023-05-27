Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AF8C77B73
	for <git@archiver.kernel.org>; Sat, 27 May 2023 07:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjE0H6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 May 2023 03:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjE0H6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2023 03:58:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA581BD
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b011cffef2so13409345ad.3
        for <git@vger.kernel.org>; Sat, 27 May 2023 00:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685174299; x=1687766299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9E2StsDd4XM2e4NNPlwxRBu0P/BIgaVhRv7acUzq8U=;
        b=MnskAM9xAe+darvH9s3BOGOXxC5n8iNRSRDxumEbPacvAalwYTfSD3uEWGZZe08e7x
         KJwswMK/w2Yi+DLmnBq/VIn0ut0ejinWkrLk1BtY6IPMgvK9JRg6+HL1cdH7WUaipxYg
         Xzq5jXL4PwvzEqsWBYY/niP94jz8UwDhAr5quu4/YI3jhP7PXltTGG13QLpEDPaZ0r0V
         xcbE/jccRCu2Rvqlt1AuLALwjm/7aNL6hUdLvmWx8YncGzeU0qlz8T+ISfpZPgs3QPGy
         9lOBUgA9oPEsysiVGIxjWVqujCYsb4VOf2759EgOfkOJnGK8Gq2BT4T4DAE2bKLj/9sz
         gesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685174299; x=1687766299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9E2StsDd4XM2e4NNPlwxRBu0P/BIgaVhRv7acUzq8U=;
        b=We5vjCXY7WAApx+tSUqhsJLjshbgVJrM6XYO5SEHIHiawre/W3Ry5b3H3N3ft4uOI3
         mYoNe2sDczIXh7nlM6/7LE9Nt2Iig3rw70kgE1xQhJPWdhJGSnqxgLtEV7BL2nM4NyK0
         5yzAlSVKk07EhSFPrsG+6oYDHAKacoR2P9dfAOfseImug5p9a0s/8vPJ0CtR/x+Phj9r
         qjjNeqM+NRgfxZbAuK164Pn/K/YXj7EqqXKrKwAwixdPGOURrHMYI284DEO/c10BnMyH
         92y62PbUlRuAmgWrebwc7VAEqCMsZjgCjZqUQejKU5iDiQMWDgTeRHTYHH+eHbnTjedB
         tF3A==
X-Gm-Message-State: AC+VfDyCojtSMjpGeB3Tlkam3j8fUHkZNRbg8K0XnTiGcrytVuHSOBzf
        9FlK8+MCsO2b1l/KQwxFn3g=
X-Google-Smtp-Source: ACHHUZ57h1Nf1p36WdBpnlBuu6SLZoS4K4cMvdrkHmbduDIsANslazgOAKFkHkFd4PdEMZ65pP8spw==
X-Received: by 2002:a17:903:280f:b0:1ac:a6b0:1c87 with SMTP id kp15-20020a170903280f00b001aca6b01c87mr4646210plb.48.1685174299400;
        Sat, 27 May 2023 00:58:19 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001a6b2813c13sm4355239plr.172.2023.05.27.00.58.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 May 2023 00:58:19 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com,
        peff@peff.net, code@khaugsbakk.name
Subject: [PATCH v11 7/7] notes: introduce "--no-separator" option
Date:   Sat, 27 May 2023 15:57:54 +0800
Message-ID: <7105778c30102069ffadcdbb7086a62083b4c766.1685174012.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.40.0.356.g367cb1d4
In-Reply-To: <cover.1685174011.git.dyroneteng@gmail.com>
References: <cover.1685174011.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Sometimes, the user may want to add or append multiple notes
without any separator to be added between them.

Disscussion:

  https://public-inbox.org/git/3f86a553-246a-4626-b1bd-bacd8148318a@app.fastmail.com/

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/git-notes.txt | 11 +++++----
 builtin/notes.c             | 37 ++++++++++++++++++++--------
 t/t3301-notes.sh            | 49 ++++++++++++++++++++++++++++++++++---
 3 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 5f3a9479..bc1bfa37 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -9,9 +9,9 @@ SYNOPSIS
 --------
 [verse]
 'git notes' [list [<object>]]
-'git notes' add [-f] [--allow-empty] [--separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [--separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [--allow-empty] [<object>] [--[no-]stripspace]
 'git notes' show [<object>]
 'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
@@ -171,10 +171,11 @@ OPTIONS
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
---separator <paragraph-break>::
+--[no-]separator, --separator=<paragraph-break>::
 	Specify a string used as a custom inter-paragraph separator
-	(a newline is added at the end as needed).  Defaults to a
-	blank line.
+	(a newline is added at the end as needed). If `--no-separator`, no
+	separators will be added between paragraphs.  Defaults to a blank
+	line.
 
 --[no-]stripspace::
 	Strip leading and trailing whitespace from the note message.
diff --git a/builtin/notes.c b/builtin/notes.c
index 2140a697..00268e94 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -28,12 +28,12 @@
 #include "worktree.h"
 #include "write-or-die.h"
 
-static char *separator = "\n";
+static const char *separator = "\n";
 static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
-	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
 	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
-	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] append [--allow-empty] [--[no-]separator|--separator=<paragraph-break>] [--[no-]stripspace] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
 	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
 	N_("git notes [--ref <notes-ref>] show [<object>]"),
 	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
@@ -239,8 +239,11 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 
 static void append_separator(struct strbuf *message)
 {
-	size_t sep_len = strlen(separator);
-	if (sep_len && separator[sep_len - 1] == '\n')
+	size_t sep_len = 0;
+
+	if (!separator)
+		return;
+	else if ((sep_len = strlen(separator)) && separator[sep_len - 1] == '\n')
 		strbuf_addstr(message, separator);
 	else
 		strbuf_addf(message, "%s%s", separator, "\n");
@@ -249,8 +252,8 @@ static void append_separator(struct strbuf *message)
 static void concat_messages(struct note_data *d)
 {
 	struct strbuf msg = STRBUF_INIT;
-
 	size_t i;
+
 	for (i = 0; i < d->msg_nr ; i++) {
 		if (d->buf.len)
 			append_separator(&d->buf);
@@ -341,6 +344,16 @@ static int parse_reedit_arg(const struct option *opt, const char *arg, int unset
 	return parse_reuse_arg(opt, arg, unset);
 }
 
+static int parse_separator_arg(const struct option *opt, const char *arg,
+			       int unset)
+{
+	if (unset)
+		*(const char **)opt->value = NULL;
+	else
+		*(const char **)opt->value = arg ? arg : "\n";
+	return 0;
+}
+
 static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -481,8 +494,10 @@ static int add(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
 		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
-		OPT_STRING(0, "separator", &separator, N_("separator"),
-			N_("insert <paragraph-break> between paragraphs")),
+		OPT_CALLBACK_F(0, "separator", &separator,
+			N_("<paragraph-break>"),
+			N_("insert <paragraph-break> between paragraphs"),
+			PARSE_OPT_OPTARG, parse_separator_arg),
 		OPT_BOOL(0, "stripspace", &d.stripspace,
 			N_("remove unnecessary whitespace")),
 		OPT_END()
@@ -654,8 +669,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
-		OPT_STRING(0, "separator", &separator, N_("separator"),
-			N_("insert <paragraph-break> between paragraphs")),
+		OPT_CALLBACK_F(0, "separator", &separator,
+			N_("<paragraph-break>"),
+			N_("insert <paragraph-break> between paragraphs"),
+			PARSE_OPT_OPTARG, parse_separator_arg),
 		OPT_BOOL(0, "stripspace", &d.stripspace,
 			N_("remove unnecessary whitespace")),
 		OPT_END()
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index dbadcf13..d734000d 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -382,6 +382,7 @@ test_expect_success 'create note with combination of -m and -F' '
 '
 
 test_expect_success 'create note with combination of -m and -F and --separator' '
+	test_when_finished git notes remove HEAD &&
 	cat >expect-combine_m_and_F <<-\EOF &&
 	foo
 	-------
@@ -395,7 +396,22 @@ test_expect_success 'create note with combination of -m and -F and --separator'
 	EOF
 	echo "xyzzy" >note_a &&
 	echo "zyxxy" >note_b &&
-	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --separator "-------" &&
+	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --separator="-------" &&
+	git notes show >actual &&
+	test_cmp expect-combine_m_and_F actual
+'
+
+test_expect_success 'create note with combination of -m and -F and --no-separator' '
+	cat >expect-combine_m_and_F <<-\EOF &&
+	foo
+	xyzzy
+	bar
+	zyxxy
+	baz
+	EOF
+	echo "xyzzy" >note_a &&
+	echo "zyxxy" >note_b &&
+	git notes add -m "foo" -F note_a -m "bar" -F note_b -m "baz" --no-separator &&
 	git notes show >actual &&
 	test_cmp expect-combine_m_and_F actual
 '
@@ -541,7 +557,7 @@ test_expect_success 'listing non-existing notes fails' '
 	test_must_be_empty actual
 '
 
-test_expect_success 'append: specify an empty separator' '
+test_expect_success 'append: specify a separator with an empty arg' '
 	test_when_finished git notes remove HEAD &&
 	cat >expect <<-\EOF &&
 	notes-1
@@ -555,6 +571,33 @@ test_expect_success 'append: specify an empty separator' '
 	test_cmp expect actual
 '
 
+test_expect_success 'append: specify a separator without arg' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-1
+
+	notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --separator -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'append: specify as --no-separator' '
+	test_when_finished git notes remove HEAD &&
+	cat >expect <<-\EOF &&
+	notes-1
+	notes-2
+	EOF
+
+	git notes add -m "notes-1" &&
+	git notes append --no-separator -m "notes-2" &&
+	git notes show >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'append: specify separator with line break' '
 	test_when_finished git notes remove HEAD &&
 	cat >expect <<-\EOF &&
@@ -615,7 +658,7 @@ test_expect_success 'append note with combination of -m and -F and --separator'
 
 	echo "f-notes-1" >note_a &&
 	echo "f-notes-2" >note_b &&
-	git notes append -m "m-notes-1" -F note_a -m "m-notes-2" -F note_b -m "m-notes-3" --separator "-------" &&
+	git notes append -m "m-notes-1" -F note_a -m "m-notes-2" -F note_b -m "m-notes-3" --separator="-------" &&
 	git notes show >actual &&
 	test_cmp expect-combine_m_and_F actual
 '
-- 
2.40.0.356.g367cb1d4

