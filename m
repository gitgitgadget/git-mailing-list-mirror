Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E8CC433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 16:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343980AbiBGQqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390302AbiBGQdh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 11:33:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69946C0401CF
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 08:33:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w11so25866446wra.4
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 08:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=qbeRocRya4l8CFund2/AXnHbrJ4UDGDoA1IJBUNHyqs=;
        b=YhWGb0N1Z/+tIPnuhC8abhNYs4RcPdAm0yfee1G7SFWcyU13IMwtVKkFwaNcCCS3yk
         aZoU9CZG4181UAS/IFj+q6KldQII01rumWVOKDP5gKdqeANYPnrDv+m2Kat+DGvsObz0
         fXp8ixzreAd8VV4BzQF3K8vu4wZ8Vp/DEnqXgJw/SXUgg0DUjfg24AgaVf+Jz8fzhBn+
         Qq7VA1wPW5JZYwyz22AiuoMyqrBWvkmFHgklWYpqK3ASzgITfAqnJRFBpo0Pj5zKCrsq
         /CkO3lyw/mtMjnSv/i7ecsXQdfOcoSbVdBNJgHkJvOoa27bq2p9n9wys5A2lWaStj7en
         Q+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=qbeRocRya4l8CFund2/AXnHbrJ4UDGDoA1IJBUNHyqs=;
        b=LqL8EPogk4FdhO8YlwOlgf/7zEvRn0X5tU6rMyz7zkL/tiVXLsRyAK5Oqb1NUvlLt6
         mjuczuzOwBE8gulMxRC7qQCqZRYK4tt7TWQcKWupLc8K79jzFPW+PtaW2C2DDvaAOs2F
         0opeIz7pxxF+kXMT8P3R1HZBq55+BhX/C0PmccGcRaocjd/H1aw2uHDmS4e8uvD9sGdJ
         Zp7R5lAHiKKtRge8HH2unixqaFLi66ozPhSFI6z8EJpk5YLg2f+gSMdZfNk+tNBdq3um
         eSjgMVQB0j5aTTkBpJeUeMYIfeKM2jl5UFpoIg7iMlYP8kwH2fFIcaMjM3ds/NijA/yg
         v9yw==
X-Gm-Message-State: AOAM5337P0AuxmTYb44r4/t7Tf2n/Z9W8KGqxmUIh4goDdiZsNDFKiVu
        fVqsCqwziEKseFL1rvum+oCSGePvMIQ=
X-Google-Smtp-Source: ABdhPJwWn+b0hxgc2eC4q9llfDrOjjdP75fNO7vVonSKuvFhWo4Smp/cX+4t1cfs6pW5/TboEH7uSg==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr230685wri.434.1644251614726;
        Mon, 07 Feb 2022 08:33:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm10626618wre.83.2022.02.07.08.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 08:33:34 -0800 (PST)
Message-Id: <1b63164ad4d9ec6b5fa6f733b6095b2779298b36.1644251611.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
        <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 16:33:31 +0000
Subject: [PATCH v2 2/2] cat-file: add --batch-command mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
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
time, this can lead to huge savings since on a given server.

git cat-file --batch-command

will enter an interactive command mode whereby the user can enter in
commands and their arguments that get queued in memory:

<command1> [arg1] [arg2] NL
<command2> [arg1] [arg2] NL

When --buffer mode is used, commands will be queued in memory until a
flush command is issued that execute them:

flush NL

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

This patch adds the basic structure for adding command which can be
extended in the future to add more commands. It also adds the following
two commands (on top of the flush command):

contents <object> NL
info <object> NL

The contents command takes an <object> argument and prints out the object
contents.

The info command takes a <object> argument and prints out the object
metadata.

These can be used in the following way with --buffer:

contents <sha1> NL
object <sha1> NL
object <sha1> NL
contents <sha1> NL
flush
contents <sha1> NL
flush

When used without --buffer:

contents <sha1> NL
object <sha1> NL
object <sha1> NL
contents <sha1> NL
contents <sha1> NL

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-cat-file.txt |  19 ++++
 builtin/cat-file.c             | 124 +++++++++++++++++++++
 t/t1006-cat-file.sh            | 197 ++++++++++++++++++++++++++++++++-
 3 files changed, 339 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index bef76f4dd06..618dbd15338 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -96,6 +96,25 @@ OPTIONS
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
+flush::
+	Execute all preceding commands that were issued since the beginning or
+	since the last flush command was issued. Only used with --buffer. When
+	--buffer is not used, commands are flushed each time without issuing
+	`flush`.
+
 --batch-all-objects::
 	Instead of reading a list of objects on stdin, perform the
 	requested batch operation on all objects in the repository and
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5f015e71096..6bfab74b58a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -26,6 +26,7 @@ struct batch_options {
 	int unordered;
 	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
 	const char *format;
+	int command;
 };
 
 static const char *force_path;
@@ -508,6 +509,118 @@ static int batch_unordered_packed(const struct object_id *oid,
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
+	opt->print_contents = 1;
+	batch_one_object(line, output, opt, data);
+}
+
+static void parse_cmd_info(struct batch_options *opt,
+			   const char *line,
+			   struct strbuf *output,
+			   struct expand_data *data)
+{
+	opt->print_contents = 0;
+	batch_one_object(line, output, opt, data);
+}
+
+static void flush_batch_calls(struct batch_options *opt,
+		struct strbuf *output,
+		struct expand_data *data,
+		struct queued_cmd *cmds,
+		int queued)
+{
+	int i;
+	for(i = 0; i < queued; i++){
+		cmds[i].fn(opt, cmds[i].line, output, data);
+	}
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
+	int queued = 0;
+
+	while (!strbuf_getline(&input, stdin)) {
+		int i;
+		const struct parse_cmd *cmd = NULL;
+		const char *p, *cmd_end;
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
+			if (!queued)
+				die(_("nothing to flush"));
+			flush_batch_calls(opt, output, data, cmds, queued);
+			queued = 0;
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
+		queued++;
+		if (queued > nr) {
+			ALLOC_GROW(cmds, nr+1, alloc);
+			nr++;
+		}
+
+		call.fn = cmd->fn;
+		call.line = xstrdup(p);
+		cmds[queued-1] = call;
+	}
+	free(cmds);
+	strbuf_release(&input);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -515,6 +628,7 @@ static int batch_objects(struct batch_options *opt)
 	struct expand_data data;
 	int save_warning;
 	int retval = 0;
+	const int command = opt->command;
 
 	if (!opt->format)
 		opt->format = "%(objectname) %(objecttype) %(objectsize)";
@@ -590,6 +704,10 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
+	if (command) {
+		batch_objects_command(opt, &output, &data);
+		goto cleanup;
+	}
 	while (strbuf_getline(&input, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
@@ -608,6 +726,7 @@ static int batch_objects(struct batch_options *opt)
 		batch_one_object(input.buf, &output, opt, &data);
 	}
 
+ cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
 	warn_on_object_refname_ambiguity = save_warning;
@@ -636,6 +755,7 @@ static int batch_option_callback(const struct option *opt,
 
 	bo->enabled = 1;
 	bo->print_contents = !strcmp(opt->long_name, "batch");
+	bo->command = !strcmp(opt->long_name, "batch-command");
 	bo->format = arg;
 
 	return 0;
@@ -683,6 +803,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
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
index 145eee11df9..c57a35ea20a 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -177,6 +177,20 @@ $content"
 	test_cmp expect actual
     '
 
+    test -z "$content" ||
+    test_expect_success "--batch-command output of $type content is correct" '
+	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
+	maybe_remove_timestamp "$(test_write_lines "contents $sha1" \
+	| git cat-file --batch-command)" $no_ts >actual &&
+	test_cmp expect actual
+    '
+
+    test_expect_success "--batch-command output of $type info is correct" '
+	echo "$sha1 $type $size" >expect &&
+	test_write_lines "info $sha1" | git cat-file --batch-command >actual &&
+	test_cmp expect actual
+    '
+
     test_expect_success "custom --batch-check format" '
 	echo "$type $sha1" >expect &&
 	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
@@ -213,6 +227,64 @@ $content"
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
+	# check output is flushed on exit
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
@@ -224,6 +296,14 @@ test_expect_success "setup" '
 
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
@@ -238,6 +318,14 @@ tree_pretty_content="100644 blob $hello_sha1	hello"
 
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
@@ -249,6 +337,14 @@ $commit_message"
 
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
@@ -263,11 +359,19 @@ tag_size=$(strlen "$tag_content")
 
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
@@ -373,6 +477,62 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
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
@@ -963,5 +1123,40 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
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
+	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>err &&
+	grep -E "^fatal:.*nothing to flush.*" err
+'
 
 test_done
-- 
gitgitgadget
