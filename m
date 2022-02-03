Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E909C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 19:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353698AbiBCTIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353692AbiBCTIL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 14:08:11 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9196C06173B
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 11:08:10 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u15so6939317wrt.3
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=txLxXjKYV0WtGvv5x6+PTEiv3kbFzGAYQ+8ryDUQOOU=;
        b=JzKPhABOCHN9/i7gfHVnatch2Rgp9Ter3EHlvo/q7FZQG2EWb+9T4Tl2zQ4xUQ++Go
         zqrp/pZaeR+xZLBk26CtMTPfDnQrzrmbvS3u2/9wbexSuAq96qXkdaCpOrEMoynsHGd9
         chAOiFyBDAzbxGqnAx9fQi+7ZutsloPfZrNMVODE4TSEtHevXZCJOgo477G6uhzbfgu9
         oP7zy3wMcP15eZKb9tDMopnts3q+ITuMFDHi0tXFIyqAjpyvgrVKYMv6SZcWdl3jZryc
         /d9y+5uHwivvKg1M+U4PHBEgKu4TWgCIzuKhZPAGRRkg4lDyYRr8frs40/3v8gsDEsR8
         csbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=txLxXjKYV0WtGvv5x6+PTEiv3kbFzGAYQ+8ryDUQOOU=;
        b=xVwLzs02ZMJNtn5Y9YGXQK93acuFLTvJe/1tKpenRTXK8nGgZVdgNu63Nwjv3nCnBu
         bBRCvm4TMBL121auEA406YbZU7p5IwjM2uqrWqCiO4WADIzhJ36YMfXyM9jJbFLHa6gG
         ySi0WNeCUN2puaZs810tNo4Ge3lPbUq+OZpJ1fR4CBKo6WtBIYpdVCVP0IEe9zyXbUt+
         pFkVRD3b2ZLvLvAf4d+tptBfP6pDNaTq7oFpGbjSivI7fUb0VJ4D+H/5jcHMz+qh0RVO
         quCS7fz7nbNdY6hE8EsMo+v30U/JzR+XvQxxjjd2PATwENzdg48TkMBjfnnHHKNkBNen
         Wkew==
X-Gm-Message-State: AOAM5302s97V2MRGahRLDog2qkAypRlMq/j0seMTHlyiMo2HrM45zOjL
        WNR65qRZobAakLPVhj9E4ckLv2+3yno=
X-Google-Smtp-Source: ABdhPJzJ8W36vL4gUIb4OMcAgRnFFECdIdRNWUNTrAk5G3RuES7y1GP0iOg08vHwnF+JajFxxxJtIg==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr30820500wrz.512.1643915289127;
        Thu, 03 Feb 2022 11:08:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17sm10055138wru.107.2022.02.03.11.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 11:08:08 -0800 (PST)
Message-Id: <ebd2a1356017905245744babf32c5b78a0af1639.1643915286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 19:08:06 +0000
Subject: [PATCH 2/2] catfile.c: add --batch-command mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Add new flag --batch-command that will accept commands and arguments
from stdin, similar to git-update-ref --stdin.

At GitLab, we use a pair of long running cat-file processes when
accessing object content. One for iterating over object metadata with
--batch-check, and the other to grab object contents with --batch.

However, if we had --batch-command, we wouldnt need to keep both
processes around, and instead just have one process where we can flip
between getting object info, and getting object contents. This means we
can get rid of roughly half of long lived git cat-file processes. This
can lead to huge savings since on a given server there could be hundreds
of git cat-file processes running.

git cat-file --batch-command

would enter an interactive command mode whereby the user can enter in
commands and their arguments:

<command> [arg1] [arg2] NL

This patch adds the basic structure for add command which can be
extended in the future to add more commands.

This patch also adds the following commands:

contents <object> NL
info <object> NL

The contents command takes an <object> argument and prints out the object
contents.

The info command takes a <object> argument and prints out the object
metadata.

In addition, we need a set of commands that enable a "read session".

When a separate process (A) is connected to a git cat-file process (B)
and is interactively writing to and reading from it in --buffer mode,
(A) needs to be able to know when the buffer is flushed to stdout.
Currently, from (A)'s perspective, the only way is to either 1. exit
(B)'s process or 2. send an invalid object to stdin. 1. is not ideal
from a performance perspective as it will require spawning a new cat-file
process each time, and 2. is hacky and not a good long term solution.

With the following commands, process (A) can begin a "session" and
send a list of object names over stdin. When "get contents" or "get info"
is issued, this list of object names will be fed into batch_one_object()
to retrieve either info or contents. Finally an fflush() will be called
to end the session.

begin NL
get contents NL
get info NL

These can be used in the following way:

begin
<sha1>
<sha1>
<sha1>
<sha1>
get info

begin
<sha1>
<sha1>
<sha1>
<sha1>
get contents

With this mechanism, process (A) can be guaranteed to receive all of the
output even in --buffer mode.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-cat-file.txt |  27 +++++
 builtin/cat-file.c             | 184 ++++++++++++++++++++++++++++++---
 t/t1006-cat-file.sh            |  46 ++++++++-
 3 files changed, 242 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 27b27e2b300..d1ba0b12e54 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -90,6 +90,33 @@ OPTIONS
 	need to specify the path, separated by whitespace.  See the
 	section `BATCH OUTPUT` below for details.
 
+--batch-command::
+	Enter a command mode that reads commands and arguments from stdin.
+	May not be combined with any other options or arguments except
+	`--textconv` or `--filters`, in which case the input lines also need to
+	specify the path, separated by whitespace.  See the section
+	`BATCH OUTPUT` below for details.
+
+contents <object>::
+	Print object contents for object reference <object>
+
+info <object>::
+	Print object info for object reference <object>
+
+begin::
+	Begins a session to read object names off of stdin. A session can be
+	terminated with `get contents` or `get info`.
+
+get contents::
+	After a read session is begun with the `begin` command, and object
+	names have been fed into stdin, end the session and retrieve contents of
+	all the objects requested.
+
+get info::
+	After a read session is begun with the `begin` command, and object
+	names have been fed into stdin, end the session and retrieve info of
+	all the objects requested.
+
 --batch-all-objects::
 	Instead of reading a list of objects on stdin, perform the
 	requested batch operation on all objects in the repository and
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 858bca208ff..29d5cd6857b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -26,6 +26,7 @@ struct batch_options {
 	int unordered;
 	int mode; /* may be 'w' or 'c' for --filters or --textconv */
 	const char *format;
+	int command;
 };
 
 static const char *force_path;
@@ -512,6 +513,151 @@ static int batch_unordered_packed(const struct object_id *oid,
 				      data);
 }
 
+static void parse_cmd_object(struct batch_options *opt,
+			     const char *line,
+			     struct strbuf *output,
+			     struct expand_data *data,
+			     struct string_list revs)
+{
+	opt->print_contents = 1;
+	batch_one_object(line, output, opt, data);
+}
+
+static void parse_cmd_info(struct batch_options *opt,
+			   const char *line,
+			   struct strbuf *output,
+			   struct expand_data *data,
+			   struct string_list revs)
+{
+	opt->print_contents = 0;
+	batch_one_object(line, output, opt, data);
+}
+
+static void parse_cmd_begin(struct batch_options *opt,
+			   const char *line,
+			   struct strbuf *output,
+			   struct expand_data *data,
+			   struct string_list revs)
+{
+	/* nothing needs to be done here */
+}
+
+static void parse_cmd_get(struct batch_options *opt,
+			   const char *line,
+			   struct strbuf *output,
+			   struct expand_data *data,
+			   struct string_list revs)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, &revs) {
+		batch_one_object(item->string, output, opt, data);
+	}
+	if (opt->buffer_output)
+		fflush(stdout);
+}
+static void parse_cmd_get_info(struct batch_options *opt,
+			   const char *line,
+			   struct strbuf *output,
+			   struct expand_data *data,
+			   struct string_list revs)
+{
+	opt->print_contents = 0;
+	parse_cmd_get(opt, line, output, data, revs);
+}
+
+static void parse_cmd_get_objects(struct batch_options *opt,
+			   const char *line,
+			   struct strbuf *output,
+			   struct expand_data *data,
+			   struct string_list revs)
+{
+	opt->print_contents = 1;
+	parse_cmd_get(opt, line, output, data, revs);
+	if (opt->buffer_output)
+		fflush(stdout);
+}
+
+enum batch_state {
+	BATCH_STATE_COMMAND,
+	BATCH_STATE_INPUT,
+};
+
+typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
+			       struct strbuf *, struct expand_data *,
+			       struct string_list revs);
+
+static const struct parse_cmd {
+	const char *prefix;
+	parse_cmd_fn_t fn;
+	unsigned takes_args;
+	enum batch_state next_state;
+} commands[] = {
+	{ "contents", parse_cmd_object, 1, BATCH_STATE_COMMAND},
+	{ "info", parse_cmd_info, 1, BATCH_STATE_COMMAND},
+	{ "begin", parse_cmd_begin, 0, BATCH_STATE_INPUT},
+	{ "get info", parse_cmd_get_info, 0, BATCH_STATE_COMMAND},
+	{ "get contents", parse_cmd_get_objects, 0, BATCH_STATE_COMMAND},
+};
+
+static void batch_objects_command(struct batch_options *opt,
+				    struct strbuf *output,
+				    struct expand_data *data)
+{
+	struct strbuf input = STRBUF_INIT;
+	enum batch_state state = BATCH_STATE_COMMAND;
+	struct string_list revs = STRING_LIST_INIT_DUP;
+
+	/* Read each line dispatch its command */
+	while (!strbuf_getline(&input, stdin)) {
+		int i;
+		const struct parse_cmd *cmd = NULL;
+		const char *p, *cmd_end;
+
+		if (state == BATCH_STATE_COMMAND) {
+			if (*input.buf == '\n')
+				die("empty command in input");
+			else if (isspace(*input.buf))
+				die("whitespace before command: %s", input.buf);
+		}
+
+		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+			const char *prefix = commands[i].prefix;
+			char c;
+			if (!skip_prefix(input.buf, prefix, &cmd_end))
+				continue;
+			/*
+			 * If the command has arguments, verify that it's
+			 * followed by a space. Otherwise, it shall be followed
+			 * by a line terminator.
+			 */
+			c = commands[i].takes_args ? ' ' : '\n';
+			if (*cmd_end && *cmd_end != c)
+				die("arguments invalid for command: %s", commands[i].prefix);
+
+			cmd = &commands[i];
+			if (cmd->takes_args)
+				p = cmd_end + 1;
+			break;
+		}
+
+		if (input.buf[input.len - 1] == '\n')
+			input.buf[--input.len] = '\0';
+
+		if (state == BATCH_STATE_INPUT && !cmd){
+			string_list_append(&revs, input.buf);
+			continue;
+		}
+
+		if (!cmd)
+			die("unknown command: %s", input.buf);
+
+		state = cmd->next_state;
+		cmd->fn(opt, p, output, data, revs);
+	}
+	strbuf_release(&input);
+	string_list_clear(&revs, 0);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -519,6 +665,7 @@ static int batch_objects(struct batch_options *opt)
 	struct expand_data data;
 	int save_warning;
 	int retval = 0;
+	const int command = opt->command;
 
 	if (!opt->format)
 		opt->format = "%(objectname) %(objecttype) %(objectsize)";
@@ -594,22 +741,25 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (strbuf_getline(&input, stdin) != EOF) {
-		if (data.split_on_whitespace) {
-			/*
-			 * Split at first whitespace, tying off the beginning
-			 * of the string and saving the remainder (or NULL) in
-			 * data.rest.
-			 */
-			char *p = strpbrk(input.buf, " \t");
-			if (p) {
-				while (*p && strchr(" \t", *p))
-					*p++ = '\0';
+	if (command)
+		batch_objects_command(opt, &output, &data);
+	else {
+		while (strbuf_getline(&input, stdin) != EOF) {
+			if (data.split_on_whitespace) {
+				/*
+				 * Split at first whitespace, tying off the beginning
+				 * of the string and saving the remainder (or NULL) in
+				 * data.rest.
+				 */
+				char *p = strpbrk(input.buf, " \t");
+				if (p) {
+					while (*p && strchr(" \t", *p))
+						*p++ = '\0';
+				}
+				data.rest = p;
 			}
-			data.rest = p;
+			batch_one_object(input.buf, &output, opt, &data);
 		}
-
-		batch_one_object(input.buf, &output, opt, &data);
 	}
 
 	strbuf_release(&input);
@@ -646,6 +796,7 @@ static int batch_option_callback(const struct option *opt,
 
 	bo->enabled = 1;
 	bo->print_contents = !strcmp(opt->long_name, "batch");
+	bo->command = !strcmp(opt->long_name, "batch-command");
 	bo->format = arg;
 
 	return 0;
@@ -682,6 +833,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			N_("show info about objects fed from the standard input"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			batch_option_callback),
+		OPT_CALLBACK_F(0, "batch-command", &batch, N_(""),
+			 N_("enters batch mode that accepts commands"),
+			 PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
+			 batch_option_callback),
+
 		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
 			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
 		OPT_BOOL(0, "batch-all-objects", &batch.all_objects,
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 39382fa1958..7360d049113 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -85,6 +85,34 @@ $content"
 	test_cmp expect actual
     '
 
+    test -z "$content" ||
+    test_expect_success "--batch-command output of $type content is correct" '
+	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
+	maybe_remove_timestamp "$(echo contents $sha1 | git cat-file --batch-command)" $no_ts >actual &&
+	test_cmp expect actual
+    '
+
+    test -z "$content" ||
+    test_expect_success "--batch-command session for $type content is correct" '
+	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
+	maybe_remove_timestamp \
+		"$(test_write_lines "begin" "$sha1" "get contents" | git cat-file --batch-command)" \
+		$no_ts >actual &&
+	test_cmp expect actual
+    '
+
+    test_expect_success "--batch-command output of $type info is correct" '
+	echo "$sha1 $type $size" >expect &&
+	echo "info $sha1" | git cat-file --batch-command >actual &&
+	test_cmp expect actual
+    '
+
+    test_expect_success "--batch-command session for $type info is correct" '
+	echo "$sha1 $type $size" >expect &&
+	test_write_lines "begin" "$sha1" "get info" | git cat-file --batch-command >actual &&
+	test_cmp expect actual
+    '
+
     test_expect_success "custom --batch-check format" '
 	echo "$type $sha1" >expect &&
 	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
@@ -141,6 +169,7 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
 '
 
 tree_sha1=$(git write-tree)
+
 tree_size=$(($(test_oid rawsz) + 13))
 tree_pretty_content="100644 blob $hello_sha1	hello"
 
@@ -175,7 +204,7 @@ test_expect_success \
     "Reach a blob from a tag pointing to it" \
     "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
 
-for batch in batch batch-check
+for batch in batch batch-check batch-command
 do
     for opt in t s e p
     do
@@ -281,6 +310,15 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
     "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
 '
 
+test_expect_success "--batch-command with multiple sha1s gives correct format" '
+    echo "$batch_check_output" >expect &&
+    echo begin >input &&
+    echo_without_newline "$batch_check_input" >>input &&
+    echo "get info" >>input &&
+    git cat-file --batch-command <input >actual &&
+    test_cmp expect actual
+'
+
 test_expect_success 'setup blobs which are likely to delta' '
 	test-tool genrandom foo 10240 >foo &&
 	{ cat foo && echo plus; } >foo-plus &&
@@ -872,4 +910,10 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
 	test_cmp expect actual
 '
 
+test_expect_success 'batch-command unknown command' '
+	echo unknown_command >cmd &&
+	test_expect_code 128 git cat-file --batch-command < cmd 2>err &&
+	grep -E "^fatal:.*unknown command.*" err
+'
+
 test_done
-- 
gitgitgadget
