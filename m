Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D1AC433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387189AbiBHWZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386600AbiBHU6M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 15:58:12 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55864C0612C3
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 12:58:10 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e3so633545wra.0
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 12:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rQkNrb9oEMxdbn1Hyo7CGrg4y8/20JQnJ+xN7PXqCKQ=;
        b=lrQ4lNK0tdYtP3V4+HntOa6IpkYHIGEm+QvxQdZOg2iUOu8Kn780D8PD6CEbfeDWqO
         XlcoknUT0GTn6JrgsTOXydPN+uiC4y5P+jEuQn+Glp6qzcgEeD3qd7uH54VWHl2KE1z/
         X/kR9iO48gTBzxNRGzeey+JQ0oas3GgHI23ouyTpwy68iltcSkWm4mWfUC/GOzqwWa5c
         z9j4hfyc0DLMuVyjKyVrxc2m8Oxi4Hl4eqJvIrjOt11MDjaWjRUlHfv96Mxu9sNdUTEC
         h2+ZB5d5x6qvkQdbeAbo35CLYOCpuB+Uch+ZpAsWysUxEBJ+wAEZquzX5lcZypmygRII
         dWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rQkNrb9oEMxdbn1Hyo7CGrg4y8/20JQnJ+xN7PXqCKQ=;
        b=uwj+wlJm8lCW6y7Klv+kp4uhGnygHCkp9WWLawp4iVxmfPZuLWZhu/aQnDtaOKPH/r
         pC5XmMjNM9ljfKcAl8iL3UbaQSscR+fmiQacZwtrfkH2fPU+iDhQl03NBonx/78f1h6Z
         BnhSTDBOE90fkFrT7sWMQFjgQJLWr4Kzxa1JUAT9DfI6yIAlnh6XtyJ2e//0O97tsdEz
         hFtkBTJOtW9eNA/u6ICR8OxJPiyhMcem2yzBFwO3Ig8VP6FqgFZwv85T4MSFxdu+ljMP
         71H75C5xCDgzPXv8wAyVll1uvGuOElxa56gyswsDriVjXrEGpZhD7ujdiXoS2GIlziZg
         y5Gg==
X-Gm-Message-State: AOAM533ai3ISXKupTlMOewoKa50uh2rt+QdC2+r8G+2J8FHHSRsJwv5y
        8ngnhhfhr1WabYNXqTIc2hXuI4hubc4=
X-Google-Smtp-Source: ABdhPJxjaXhiqdjFL0zLhNzo8hfdqVidY/xjdIG9JjGImyBN5IEW63mE9wwt3p4TAXaGYtBeVrzkPg==
X-Received: by 2002:a05:6000:16cb:: with SMTP id h11mr4867376wrf.594.1644353888624;
        Tue, 08 Feb 2022 12:58:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm6509515wrc.41.2022.02.08.12.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:58:08 -0800 (PST)
Message-Id: <1ab5524ee874fc7af65efaca37fb7cd933ea8913.1644353884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
References: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
        <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 20:58:04 +0000
Subject: [PATCH v3 3/3] cat-file: add --batch-command mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Add a new flag --batch-command that accepts commands and arguments
from stdin, similar to git-update-ref --stdin.

At GitLab, we use a pair of long running cat-file processes when
accessing object content. One for iterating over object metadata with
--batch-check, and the other to grab object contents with --batch.

However, if we had --batch-command, we wouldn't need to keep both
processes around, and instead just have one --batch-command process
where we can flip between getting object info, and getting object
contents. Since we have a pair of cat-file processes per repository,
this means we can get rid of roughly half of long lived git cat-file
processes. Given there are many repositories being accessed at any given
time, this can lead to huge savings.

git cat-file --batch-command

will enter an interactive command mode whereby the user can enter in
commands and their arguments that get queued in memory:

<command1> [arg1] [arg2] LF
<command2> [arg1] [arg2] LF

When --buffer mode is used, commands will be queued in memory until a
flush command is issued that execute them:

flush LF

The reason for a flush command is that when a consumer process (A)
talks to a git cat-file process (B) and interactively writes to and
reads from it in --buffer mode, (A) needs to be able to control when
the buffer is flushed to stdout.

Currently, from (A)'s perspective, the only way is to either

1. kill (B)'s process
2. send an invalid object to stdin.

1. is not ideal from a performance perspective as it will require
spawning a new cat-file process each time, and 2. is hacky and not a
good long term solution.

With this mechanism of queueing up commands and letting (A) issue a
flush command, process (A) can control when the buffer is flushed and
can guarantee it will receive all of the output when in --buffer mode.
--batch-command also will not allow (B) to flush to stdout until a flush
is received.

This patch adds the basic structure for adding command which can be
extended in the future to add more commands. It also adds the following
two commands (on top of the flush command):

contents <object> LF
info <object> LF

The contents command takes an <object> argument and prints out the object
contents.

The info command takes a <object> argument and prints out the object
metadata.

These can be used in the following way with --buffer:

info <sha1> LF
contents <sha1> LF
contents <sha1> LF
info <sha1> LF
flush
info <sha1> LF
flush

When used without --buffer:

info <sha1> LF
contents <sha1> LF
contents <sha1> LF
info <sha1> LF
info <sha1> LF

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-cat-file.txt |  24 ++++
 builtin/cat-file.c             | 140 ++++++++++++++++++++--
 t/t1006-cat-file.sh            | 207 ++++++++++++++++++++++++++++++++-
 3 files changed, 361 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index bef76f4dd06..d77a61c47de 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -96,6 +96,30 @@ OPTIONS
 	need to specify the path, separated by whitespace.  See the
 	section `BATCH OUTPUT` below for details.
 
+--batch-command::
+	Enter a command mode that reads commands and arguments from stdin.
+	May not be combined with any other options or arguments except
+	`--textconv` or `--filters`, in which case the input lines also need to
+	specify the path, separated by whitespace.  See the section
+	`BATCH OUTPUT` below for details.
++
+--
+contents <object>::
+	Print object contents for object reference <object>. This corresponds to
+	the output of --batch.
+
+info <object>::
+	Print object info for object reference <object>. This corresponds to the
+	output of --batch-check.
+
+flush::
+	Used in --buffer mode to execute all preceding commands that were issued
+	since the beginning or since the last flush was issued. When --buffer
+	is used, no output will come until flush is issued. When --buffer is not
+	used, commands are flushed each time without issuing `flush`.
+--
++
+
 --batch-all-objects::
 	Instead of reading a list of objects on stdin, perform the
 	requested batch operation on all objects in the repository and
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1c673385868..ec266ff95e9 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -17,15 +17,16 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 
-enum batch_command {
-	BATCH_COMMAND_CONTENTS,
-	BATCH_COMMAND_INFO,
+enum batch_mode {
+	BATCH_MODE_CONTENTS,
+	BATCH_MODE_INFO,
+	BATCH_MODE_PARSE_CMDS,
 };
 
 struct batch_options {
 	int enabled;
 	int follow_symlinks;
-	enum batch_command command_mode;
+	enum batch_mode batch_mode;
 	int buffer_output;
 	int all_objects;
 	int unordered;
@@ -391,7 +392,7 @@ static void batch_object_write(const char *obj_name,
 	strbuf_addch(scratch, '\n');
 	batch_write(opt, scratch->buf, scratch->len);
 
-	if (opt->command_mode == BATCH_COMMAND_CONTENTS) {
+	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
 		print_object_or_die(opt, data);
 		batch_write(opt, "\n", 1);
 	}
@@ -513,6 +514,117 @@ static int batch_unordered_packed(const struct object_id *oid,
 				      data);
 }
 
+typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
+			       struct strbuf *, struct expand_data *);
+
+struct queued_cmd {
+	parse_cmd_fn_t fn;
+	const char *line;
+};
+
+static void parse_cmd_contents(struct batch_options *opt,
+			     const char *line,
+			     struct strbuf *output,
+			     struct expand_data *data)
+{
+	opt->batch_mode = BATCH_MODE_CONTENTS;
+	batch_one_object(line, output, opt, data);
+}
+
+static void parse_cmd_info(struct batch_options *opt,
+			   const char *line,
+			   struct strbuf *output,
+			   struct expand_data *data)
+{
+	opt->batch_mode = BATCH_MODE_INFO;
+	batch_one_object(line, output, opt, data);
+}
+
+static void flush_batch_calls(struct batch_options *opt,
+		struct strbuf *output,
+		struct expand_data *data,
+		struct queued_cmd *cmds,
+		int nr)
+{
+	int i;
+	for (i = 0; i < nr; i++)
+		cmds[i].fn(opt, cmds[i].line, output, data);
+
+	fflush(stdout);
+}
+
+static const struct parse_cmd {
+	const char *prefix;
+	parse_cmd_fn_t fn;
+	unsigned takes_args;
+} commands[] = {
+	{ "contents", parse_cmd_contents, 1},
+	{ "info", parse_cmd_info, 1},
+};
+
+static void batch_objects_command(struct batch_options *opt,
+				    struct strbuf *output,
+				    struct expand_data *data)
+{
+	struct strbuf input = STRBUF_INIT;
+	struct queued_cmd *cmds = NULL;
+	size_t alloc = 0, nr = 0;
+
+	while (!strbuf_getline(&input, stdin)) {
+		int i;
+		const struct parse_cmd *cmd = NULL;
+		const char *p = NULL, *cmd_end;
+		struct queued_cmd call = {0};
+
+		if (!input.len)
+			die(_("empty command in input"));
+		if (isspace(*input.buf))
+			die(_("whitespace before command: '%s'"), input.buf);
+
+		if (skip_prefix(input.buf, "flush", &cmd_end)) {
+			if (!opt->buffer_output)
+				die(_("flush is only for --buffer mode"));
+			if (*cmd_end)
+				die(_("flush takes no arguments"));
+			if (!nr)
+				error(_("nothing to flush"));
+
+			flush_batch_calls(opt, output, data, cmds, nr);
+			nr = 0;
+			continue;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+			if (!skip_prefix(input.buf, commands[i].prefix, &cmd_end))
+				continue;
+
+			cmd = &commands[i];
+			if (cmd->takes_args)
+				p = cmd_end + 1;
+			break;
+		}
+
+		if (!cmd)
+			die(_("unknown command: '%s'"), input.buf);
+
+		if (!opt->buffer_output) {
+			cmd->fn(opt, p, output, data);
+			continue;
+		}
+		
+		ALLOC_GROW(cmds, nr + 1, alloc);
+		call.fn = cmd->fn;
+		call.line = xstrdup(p);
+		cmds[nr++] = call;
+	}
+
+	if (opt->buffer_output && nr)
+		flush_batch_calls(opt, output, data, cmds, nr);
+
+	free(cmds);
+	strbuf_release(&input);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -541,7 +653,7 @@ static int batch_objects(struct batch_options *opt)
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
 	 */
-	if (opt->command_mode == BATCH_COMMAND_CONTENTS)
+	if (opt->batch_mode == BATCH_MODE_CONTENTS)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
@@ -595,6 +707,10 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
+	if (opt->batch_mode == BATCH_MODE_PARSE_CMDS) {
+		batch_objects_command(opt, &output, &data);
+		goto cleanup;
+	}
 	while (strbuf_getline(&input, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
@@ -613,6 +729,7 @@ static int batch_objects(struct batch_options *opt)
 		batch_one_object(input.buf, &output, opt, &data);
 	}
 
+ cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
 	warn_on_object_refname_ambiguity = save_warning;
@@ -640,11 +757,12 @@ static int batch_option_callback(const struct option *opt,
 	}
 
 	bo->enabled = 1;
-
 	if (!strcmp(opt->long_name, "batch"))
-		bo->command_mode = BATCH_COMMAND_CONTENTS;
+		bo->batch_mode = BATCH_MODE_CONTENTS;
 	if (!strcmp(opt->long_name, "batch-check"))
-		bo->command_mode = BATCH_COMMAND_INFO;
+		bo->batch_mode = BATCH_MODE_INFO;
+	if (!strcmp(opt->long_name, "batch-command"))
+		bo->batch_mode = BATCH_MODE_PARSE_CMDS;
 
 	bo->format = arg;
 
@@ -693,6 +811,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			N_("like --batch, but don't emit <contents>"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			batch_option_callback),
+		OPT_CALLBACK_F(0, "batch-command", &batch, N_("format"),
+			N_("read commands from stdin"),
+			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
+			batch_option_callback),
 		OPT_CMDMODE(0, "batch-all-objects", &opt,
 			    N_("with --batch[-check]: ignores stdin, batches all known objects"), 'b'),
 		/* Batch-specific options */
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 145eee11df9..635667f8168 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -177,6 +177,24 @@ $content"
 	test_cmp expect actual
     '
 
+    for opt in --buffer --no-buffer
+    do
+	test -z "$content" ||
+		test_expect_success "--batch-command $opt output of $type content is correct" '
+		maybe_remove_timestamp "$batch_output" $no_ts >expect &&
+		maybe_remove_timestamp "$(test_write_lines "contents $sha1" \
+		| git cat-file --batch-command $opt)" $no_ts >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "--batch-command $opt output of $type info is correct" '
+		echo "$sha1 $type $size" >expect &&
+		test_write_lines "info $sha1" \
+		| git cat-file --batch-command $opt >actual &&
+		test_cmp expect actual
+	'
+    done
+
     test_expect_success "custom --batch-check format" '
 	echo "$type $sha1" >expect &&
 	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
@@ -213,6 +231,70 @@ $content"
     '
 }
 
+run_buffer_test_flush () {
+	type=$1
+	sha1=$2
+	size=$3
+
+	mkfifo input &&
+	test_when_finished 'rm input; exec 8<&-' &&
+	mkfifo output &&
+	exec 9<>output &&
+	test_when_finished 'rm output; exec 9<&-'
+	(
+		# TODO - Ideally we'd pipe the output of cat-file
+		# through "sed s'/$/\\/'" to make sure that that read
+		# would consume all the available
+		# output. Unfortunately we cannot do this as we cannot
+		# control when sed flushes its output. We could write
+		# a test helper in C that appended a '\' to the end of
+		# each line and flushes its output after every line.
+		git cat-file --buffer --batch-command <input 2>err &
+		echo $! &&
+		wait $!
+	) >&9 &
+	sh_pid=$! &&
+	read cat_file_pid <&9 &&
+	test_when_finished "kill $cat_file_pid
+			    kill $sh_pid; wait $sh_pid; :" &&
+	echo "$sha1 $type $size" >expect &&
+	test_write_lines "info $sha1" flush "info $sha1" >input
+	# TODO - consume all available input, not just one
+	# line (see above).
+	read actual <&9 &&
+	echo "$actual" >actual &&
+	test_cmp expect actual &&
+	test_must_be_empty err
+}
+
+run_buffer_test_no_flush () {
+	type=$1
+	sha1=$2
+	size=$3
+
+	touch output &&
+	test_when_finished 'rm output' &&
+	mkfifo input &&
+	test_when_finished 'rm input' &&
+	mkfifo pid &&
+	exec 9<>pid &&
+	test_when_finished 'rm pid; exec 9<&-'
+	(
+		git cat-file --buffer --batch-command <input >output &
+		echo $! &&
+		wait $!
+		echo $?
+	) >&9 &
+	sh_pid=$! &&
+	read cat_file_pid <&9 &&
+	test_when_finished "kill $cat_file_pid
+			    kill $sh_pid; wait $sh_pid; :" &&
+	test_write_lines "info $sha1" "info $sha1" &&
+	kill $cat_file_pid &&
+	read status <&9 &&
+	test_must_be_empty output
+}
+
 hello_content="Hello World"
 hello_size=$(strlen "$hello_content")
 hello_sha1=$(echo_without_newline "$hello_content" | git hash-object --stdin)
@@ -224,6 +306,14 @@ test_expect_success "setup" '
 
 run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
 
+test_expect_success PIPE '--batch-command --buffer with flush for blob info' '
+       run_buffer_test_flush blob $hello_sha1 $hello_size
+'
+
+test_expect_success PIPE '--batch-command --buffer without flush for blob info' '
+       run_buffer_test_no_flush blob $hello_sha1 $hello_size false
+'
+
 test_expect_success '--batch-check without %(rest) considers whole line' '
 	echo "$hello_sha1 blob $hello_size" >expect &&
 	git update-index --add --cacheinfo 100644 $hello_sha1 "white space" &&
@@ -238,6 +328,14 @@ tree_pretty_content="100644 blob $hello_sha1	hello"
 
 run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
 
+test_expect_success PIPE '--batch-command --buffer with flush for tree info' '
+       run_buffer_test_flush tree $tree_sha1 $tree_size
+'
+
+test_expect_success PIPE '--batch-command --buffer without flush for tree info' '
+       run_buffer_test_no_flush tree $tree_sha1 $tree_size false
+'
+
 commit_message="Initial commit"
 commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
 commit_size=$(($(test_oid hexsz) + 137))
@@ -249,6 +347,14 @@ $commit_message"
 
 run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$commit_content" 1
 
+test_expect_success PIPE '--batch-command --buffer with flush for commit info' '
+       run_buffer_test_flush commit $commit_sha1 $commit_size
+'
+
+test_expect_success PIPE '--batch-command --buffer without flush for commit info' '
+       run_buffer_test_no_flush commit $commit_sha1 $commit_size false
+'
+
 tag_header_without_timestamp="object $hello_sha1
 type blob
 tag hellotag
@@ -263,11 +369,19 @@ tag_size=$(strlen "$tag_content")
 
 run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1
 
+test_expect_success PIPE '--batch-command --buffer with flush for tag info' '
+       run_buffer_test_flush tag $tag_sha1 $tag_size
+'
+
+test_expect_success PIPE '--batch-command --buffer without flush for tag info' '
+       run_buffer_test_no_flush tag $tag_sha1 $tag_size false
+'
+
 test_expect_success \
     "Reach a blob from a tag pointing to it" \
     "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
 
-for batch in batch batch-check
+for batch in batch batch-check batch-command
 do
     for opt in t s e p
     do
@@ -373,6 +487,62 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
     "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
 '
 
+batch_command_info_input="info $hello_sha1
+info $tree_sha1
+info $commit_sha1
+info $tag_sha1
+info deadbeef
+info 
+flush
+"
+
+test_expect_success "--batch-command with multiple info calls gives correct format" '
+	test "$batch_check_output" = "$(echo_without_newline \
+	"$batch_command_info_input" | git cat-file --batch-command --buffer)"
+'
+
+batch_command_contents_input="contents $hello_sha1
+contents $commit_sha1
+contents $tag_sha1
+contents deadbeef
+contents 
+flush
+"
+
+test_expect_success "--batch-command with multiple contents calls gives correct format" '
+	test "$(maybe_remove_timestamp "$batch_output" 1)" = \
+	"$(maybe_remove_timestamp "$(echo_without_newline "$batch_command_contents_input" | git cat-file --batch-command)" 1)"
+'
+
+batch_command_mixed_input="info $hello_sha1
+contents $hello_sha1
+info $commit_sha1
+contents $commit_sha1
+info $tag_sha1
+contents $tag_sha1
+contents deadbeef
+info 
+flush
+"
+
+batch_command_mixed_output="$hello_sha1 blob $hello_size
+$hello_sha1 blob $hello_size
+$hello_content
+$commit_sha1 commit $commit_size
+$commit_sha1 commit $commit_size
+$commit_content
+$tag_sha1 tag $tag_size
+$tag_sha1 tag $tag_size
+$tag_content
+deadbeef missing
+ missing"
+
+test_expect_success "--batch-command with mixed calls gives correct format" '
+	test "$(maybe_remove_timestamp "$batch_command_mixed_output" 1)" = \
+	"$(maybe_remove_timestamp "$(echo_without_newline \
+	"$batch_command_mixed_input" | git cat-file --batch-command --buffer)" 1)"
+'
+
 test_expect_success 'setup blobs which are likely to delta' '
 	test-tool genrandom foo 10240 >foo &&
 	{ cat foo && echo plus; } >foo-plus &&
@@ -963,5 +1133,40 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
 	echo "$orig commit $orig_size" >expect &&
 	test_cmp expect actual
 '
+test_expect_success 'batch-command empty command' '
+	echo "" >cmd &&
+	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
+	grep -E "^fatal:.*empty command in input.*" err
+'
+
+test_expect_success 'batch-command whitespace before command' '
+	echo " info deadbeef" >cmd &&
+	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
+	grep -E "^fatal:.*whitespace before command.*" err
+'
+
+test_expect_success 'batch-command unknown command' '
+	echo unknown_command >cmd &&
+	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
+	grep -E "^fatal:.*unknown command.*" err
+'
+
+test_expect_success 'batch-command flush with arguments' '
+	echo "flush arg" >cmd &&
+	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>err &&
+	grep -E "^fatal:.*flush takes no arguments.*" err
+'
+
+test_expect_success 'batch-command flush without --buffer' '
+	echo "flush arg" >cmd &&
+	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
+	grep -E "^fatal:.*flush is only for --buffer mode.*" err
+'
+
+test_expect_success 'batch-command flush empty queue' '
+	echo flush >cmd &&
+	test_expect_code 0 git cat-file --batch-command --buffer <cmd 2>err &&
+	grep -E "^error:.*nothing to flush.*" err
+'
 
 test_done
-- 
gitgitgadget
