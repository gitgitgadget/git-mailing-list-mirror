Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665C8C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiBJECA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:02:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiBJEBv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:01:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FC824587
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:01:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q7so7166468wrc.13
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=gMVAQr5ZC8Eq6TcIo5ApDFZd7t7O4sek0CiQqU35rPg=;
        b=SZGTlQRaKPUSjItMM3k4C1k2hiPsqXdXv+3/1nEjjt0WqA1l17ck86zYWX/HiCEbJn
         /dR/iZjJzMKhXAxWu6dGASM3pyM5qs/rLYsr6yfJBEz0Y4kAaHJJ3D4oB37nlpQdpo0K
         43vKgMcXeSLzZyLmyGbOIVZBOrkkfx6p7ZE9alejeBu2Lor9qC20uZie1cxhZBJgGCvE
         T2MeacsDK8Z+TheXQXALsQcPuz8CLKMjBfoGNOvIxahYk0PnC27RZ69tgKoMb4+HO5y9
         ZYakJ1WQ1nUzbS7sn0TjPStllLaCYAN+izfRwmfrbILS2o+WHTA5NWk5GV4OFLuzDCiJ
         cmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=gMVAQr5ZC8Eq6TcIo5ApDFZd7t7O4sek0CiQqU35rPg=;
        b=mF24Kvtw7F5N2TiUMzoJ+d7f7Q6nUCZOmlDBYENwONGt/pPw3wnpa8bw+hX/Y8M87I
         tUl9bGIm6svOYrplXRQlPjXiWEFHkplAmWQYdAZdjvTOYtJ71E3GK0OqlgdA2lG+Anql
         zkcqbmjSvJM8zQuJkK4k6zs2HV07uzE0wM+PosFYRqGKSTGYZitTQsXO5kl/KAOFSbTa
         ChWk7JvjHoCud4XIIuKsN1Ag6fCPn91mHtrgmTbGZV5CoqFR4DW7KGGpbiXiJoWPw5/H
         HNPo4T0GhaNpdb4H/NzkuRmi0HpLzjb4gyyGhk4RJmgNWYgzVglYggemSXuxyMuaZV2v
         AqZw==
X-Gm-Message-State: AOAM532r+IZS5xVD3HFpmbkSObyI3xO/urZuKwv0eJ+GeX/xu0WiQy5e
        yvVVF+JlMZnSye2xRlDagRewMNrYgRk=
X-Google-Smtp-Source: ABdhPJy0mJ50eqvhsPgZ31VkLq7F44GVglpvVedY4YA4p1TQKGPbMQeRwc/0/AD+bU8mJ9T9R57Zvw==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr3524867wrx.463.1644465710313;
        Wed, 09 Feb 2022 20:01:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm17182464wrw.116.2022.02.09.20.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:01:49 -0800 (PST)
Message-Id: <6c51324a6623b62c385ec707a773c21375596584.1644465706.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
        <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Feb 2022 04:01:46 +0000
Subject: [PATCH v4 3/3] cat-file: add --batch-command mode
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
 builtin/cat-file.c             | 124 +++++++++++++++++++
 t/t1006-cat-file.sh            | 211 ++++++++++++++++++++++++++++++++-
 3 files changed, 358 insertions(+), 1 deletion(-)

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
index 709510c6564..713658cc222 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -20,6 +20,7 @@
 enum batch_mode {
 	BATCH_MODE_CONTENTS,
 	BATCH_MODE_INFO,
+	BATCH_MODE_QUEUE_AND_DISPATCH,
 };
 
 struct batch_options {
@@ -513,6 +514,118 @@ static int batch_unordered_packed(const struct object_id *oid,
 				      data);
 }
 
+typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
+			       struct strbuf *, struct expand_data *);
+
+struct queued_cmd {
+	parse_cmd_fn_t fn;
+	char *line;
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
+static void dispatch_calls(struct batch_options *opt,
+		struct strbuf *output,
+		struct expand_data *data,
+		struct queued_cmd *cmd,
+		int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++){
+		cmd[i].fn(opt, cmd[i].line, output, data);
+		free(cmd[i].line);
+	}
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
+	struct queued_cmd *queued_cmd = NULL;
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
+
+			dispatch_calls(opt, output, data, queued_cmd, nr);
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
+		ALLOC_GROW(queued_cmd, nr + 1, alloc);
+		call.fn = cmd->fn;
+		call.line = xstrdup_or_null(p);
+		queued_cmd[nr++] = call;
+	}
+
+	if (opt->buffer_output && nr)
+		dispatch_calls(opt, output, data, queued_cmd, nr);
+
+	free(queued_cmd);
+	strbuf_release(&input);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -595,6 +708,10 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
+	if (opt->batch_mode == BATCH_MODE_QUEUE_AND_DISPATCH) {
+		batch_objects_command(opt, &output, &data);
+		goto cleanup;
+	}
 	while (strbuf_getline(&input, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
@@ -613,6 +730,7 @@ static int batch_objects(struct batch_options *opt)
 		batch_one_object(input.buf, &output, opt, &data);
 	}
 
+ cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
 	warn_on_object_refname_ambiguity = save_warning;
@@ -645,6 +763,8 @@ static int batch_option_callback(const struct option *opt,
 		bo->batch_mode = BATCH_MODE_CONTENTS;
 	} else if (!strcmp(opt->long_name, "batch-check")) {
 		bo->batch_mode = BATCH_MODE_INFO;
+	} else if (!strcmp(opt->long_name, "batch-command")) {
+		bo->batch_mode = BATCH_MODE_QUEUE_AND_DISPATCH;
 	} else {
 		BUG("%s given to batch-option-callback", opt->long_name);
 	}
@@ -696,6 +816,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
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
index 145eee11df9..a20c8dae85d 100755
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
+	test_when_finished 'rm input' &&
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
@@ -373,6 +487,72 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
     "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
 '
 
+batch_command_info_input="info $hello_sha1
+info $tree_sha1
+info $commit_sha1
+info $tag_sha1
+info deadbeef
+flush
+"
+
+batch_command_info_output="$hello_sha1 blob $hello_size
+$tree_sha1 tree $tree_size
+$commit_sha1 commit $commit_size
+$tag_sha1 tag $tag_size
+deadbeef missing"
+
+test_expect_success "--batch-command with multiple info calls gives correct format" '
+	test "$batch_command_info_output" = "$(echo_without_newline \
+	"$batch_command_info_input" | git cat-file --batch-command --buffer)"
+'
+
+batch_command_contents_input="contents $hello_sha1
+contents $commit_sha1
+contents $tag_sha1
+contents deadbeef
+flush
+"
+
+batch_command_output="$hello_sha1 blob $hello_size
+$hello_content
+$commit_sha1 commit $commit_size
+$commit_content
+$tag_sha1 tag $tag_size
+$tag_content
+deadbeef missing"
+
+test_expect_success "--batch-command with multiple contents calls gives correct format" '
+	test "$(maybe_remove_timestamp "$batch_command_output" 1)" = \
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
+deadbeef missing"
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
@@ -963,5 +1143,34 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
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
 
 test_done
-- 
gitgitgadget
