Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EDDC433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 22:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiAYWvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiAYWud (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 17:50:33 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512B9C061751
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:50:32 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id s6so19746297qvv.11
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 14:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Af7gC2Zap5U0nvRwhTDgslqzGH17C5Sfzvn9LWrvB8Y=;
        b=hU+o7DVepkWzGsZYnIYXKazSVHMGydRA3m4WG1wlAbSpS3H8ZOimFfI5oeMysNrYei
         i+2kdGIM8FymfzQhFsiEEFVT9s2JVZerElBvYubhShvhanYi3O1YRS+jQN3xcbdjeAsj
         Zp+KjaVFN4DGWmwGbMa4eMHGAbdzDAt/7ZUqphqdYoHliBN084VbpT7qEr+dx6Ywuz8U
         iC8ObOF+QZapuuIup64x7NcxLWZkkN66UybikXD3lGaxJR0vL5yincqLSgtj21thrF3a
         Y2PxuPnXYNXhKe9Ylw+k0eN2D+Dd8UU8Wh0WJBlpfb+rVU4LdmMfM9n9JcOHB2ontJTI
         Juxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Af7gC2Zap5U0nvRwhTDgslqzGH17C5Sfzvn9LWrvB8Y=;
        b=CdUG1oMnFZQ7kJbSycIcUakefF/eMnHTdxZoBBDs6EmfajTEJZyu4wKui74MnkLPZE
         iveFQYwpE6BoZ3l6cB89rhnJmDVLeNWN730mjcx5nVdsZvelJwboiciphWQ2Bv05w5Qr
         k2xJis+C1Ty3U7U4VlDTWbrfa23TZ6bZIhgq69ziX6LUc2BI7qJG0aW+3Ii8iXdP3SPV
         kWX4Ox9k6tSOf45T9TQosFvhm60calhoeSkS4DORjGZ/TyfG02akRAy3D1GwMLq+Q7xF
         CFuznTM9brBVnOwO2NfT9x7OlI2P9l4ZHrToG8dNC46/aF7DFLrn22ifrrI0LOpy3E0B
         1NsQ==
X-Gm-Message-State: AOAM530kGIDVnur0/Kt8M1pRVupSo9BzMiTbBklbqNw6m84mgB8IDOMr
        t3jJDIdhz61T8Ujfm02eRFl1i5IcuMJV+w==
X-Google-Smtp-Source: ABdhPJy8BoP/KSsd+g5r5Ddl6J9pJYhqg9Lcy2wJeUl21H5Hi+Qx+lEp8Q94kdewJvZsQHKqBmXGwg==
X-Received: by 2002:a05:6214:f0f:: with SMTP id gw15mr9988116qvb.5.1643151031186;
        Tue, 25 Jan 2022 14:50:31 -0800 (PST)
Received: from Johns-MBP.myfiosgateway.com (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id l17sm1154080qtu.79.2022.01.25.14.50.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Jan 2022 14:50:30 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, me@ttaylorr.com, phillip.wood123@gmail.com,
        John Cai <johncai86@gmail.com>
Subject: [RFC v2] cat-file: add a --stdin-cmd mode
Date:   Tue, 25 Jan 2022 17:50:08 -0500
Message-Id: <20220125225008.45944-1-johncai86@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This RFC patch proposes a new flag --stdin-cmd that works with
git-cat-file --batch. Similar to git-update-ref --stdin, it will accept
commands and arguments from stdin.

The start of this idea was discussed in [1], where the original
motivation was to be able to control when the buffer was flushed to
stdout in --buffer mode.

However, this can actually be much more useful in situations when
git-cat-file --batch is being used as a long lived backend query
process. At GitLab, we use a pair of cat-file processes. One for
iterating over object metadata with --batch-check, and the other to grab
object contents with --batch. However, if we had --stdin-cmd, we could
get rid of the second --batch-check process, and just have one progress
where we can flip between getting object info, and getting object contents.
This can lead to huge savings.

git cat-file --batch --stdin-cmd

$ <command> [arg1] [arg2] NL

We can also add a -z mode to allow for NUL-terminated lines

$ <command> [arg1] [arg2] NUL

This patch adds three commands: object, info, fflush

$ object <sha1> NL
$ info <sha1> NL
$ fflush NL

These three would be immediately useful in GitLab's context, but one can
imagine this mode to be further extended for other things.

For instance, a non-trivial part of "cat-file --batch" time is spent
on parsing its argument and seeing if it's a revision, ref etc. So we
could add a command that only accepts a full-length 40
character SHA-1.

This would be the first step in adding such an interface to
git-cat-file.

[1] https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgadget@gmail.com/

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
Changes from v1:

- changed option name to batch-command.
- changed command function interface to receive the whole line after the command
  name to put the onus of parsing arguments to each individual command function.
- pass in whole line to batch_one_object in both parse_cmd_object and
  parse_cmd_info to support spaces in the object reference.
- removed addition of -z to include in a separate patch series
- added documentation.
---
 Documentation/git-cat-file.txt |  15 +++++
 builtin/cat-file.c             | 114 ++++++++++++++++++++++++++++++++-
 strvec.c                       |  23 +++++++
 strvec.h                       |   8 +++
 t/t1006-cat-file.sh            |  32 +++++++++
 5 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index bef76f4dd0..8aefa45e4c 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -96,6 +96,21 @@ OPTIONS
 	need to specify the path, separated by whitespace.  See the
 	section `BATCH OUTPUT` below for details.
 
+-batch-command::
+	Enter a command mode that reads from stdin. May not be combined with any
+	other options or arguments except `--textconv` or `--filters`, in which
+	case the input lines also need to specify the path, separated by
+	whitespace.  See the section `BATCH OUTPUT` below for details.
+
+object <object>::
+	Print object contents for object reference <object>
+
+info <object>::
+	Print object info for object reference <object>
+
+flush::
+	Flush to stdout immediately when used with --buffer
+
 --batch-all-objects::
 	Instead of reading a list of objects on stdin, perform the
 	requested batch operation on all objects in the repository and
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7b3f42950e..30794284d5 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -16,6 +16,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "promisor-remote.h"
+#include "strvec.h"
 
 struct batch_options {
 	int enabled;
@@ -26,7 +27,10 @@ struct batch_options {
 	int unordered;
 	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
 	const char *format;
+	int stdin_cmd;
+	int end_null;
 };
+static char line_termination = '\n';
 
 static const char *force_path;
 
@@ -508,6 +512,102 @@ static int batch_unordered_packed(const struct object_id *oid,
 				      data);
 }
 
+enum batch_state {
+	/* Non-transactional state open for commands. */
+	BATCH_STATE_OPEN,
+};
+
+static void parse_cmd_object(struct batch_options *opt,
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
+static void parse_cmd_fflush(struct batch_options *opt,
+			     const char *line,
+			     struct strbuf *output,
+			     struct expand_data *data)
+{
+	fflush(stdout);
+}
+
+typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
+			       struct strbuf *, struct expand_data *);
+
+static const struct parse_cmd {
+	const char *prefix;
+	parse_cmd_fn_t fn;
+	unsigned args;
+	enum batch_state state;
+} commands[] = {
+	{ "object", parse_cmd_object, 1, BATCH_STATE_OPEN },
+	{ "info", parse_cmd_info, 1, BATCH_STATE_OPEN },
+	{ "fflush", parse_cmd_fflush, 0, BATCH_STATE_OPEN },
+};
+
+static void batch_objects_stdin_cmd(struct batch_options *opt,
+				    struct strbuf *output,
+				    struct expand_data *data)
+{
+	struct strbuf input = STRBUF_INIT;
+	enum batch_state state = BATCH_STATE_OPEN;
+
+	/* Read each line dispatch its command */
+	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
+		int i;
+		const struct parse_cmd *cmd = NULL;
+		const char *p;
+
+		if (*input.buf == line_termination)
+			die("empty command in input");
+		else if (isspace(*input.buf))
+			die("whitespace before command: %s", input.buf);
+
+		for (i = 0; i < ARRAY_SIZE(commands); i++) {
+			const char *prefix = commands[i].prefix;
+			char c;
+			const char *cmd_name;
+			if (!skip_prefix(input.buf, prefix, &cmd_name))
+				continue;
+			/*
+			 * If the command has arguments, verify that it's
+			 * followed by a space. Otherwise, it shall be followed
+			 * by a line terminator.
+			 */
+			c = commands[i].args ? ' ' : line_termination;
+			if (input.buf[strlen(prefix)] != c)
+				continue;
+
+			cmd = &commands[i];
+			break;
+		}
+		if (!cmd)
+			die("unknown command: %s", input.buf);
+
+		p = input.buf + strlen(cmd->prefix) + 1;
+		const char *pos = strstr(p, &line_termination);
+
+		switch (state) {
+		case BATCH_STATE_OPEN:
+			break;
+		}
+		cmd->fn(opt, xstrndup(p, pos-p), output, data);
+	}
+	strbuf_release(&input);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -515,6 +615,7 @@ static int batch_objects(struct batch_options *opt)
 	struct expand_data data;
 	int save_warning;
 	int retval = 0;
+	const int stdin_cmd = opt->stdin_cmd;
 
 	if (!opt->format)
 		opt->format = "%(objectname) %(objecttype) %(objectsize)";
@@ -590,7 +691,8 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (strbuf_getline(&input, stdin) != EOF) {
+	while (!stdin_cmd &&
+	       strbuf_getline(&input, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
@@ -608,6 +710,9 @@ static int batch_objects(struct batch_options *opt)
 		batch_one_object(input.buf, &output, opt, &data);
 	}
 
+	if (stdin_cmd)
+		batch_objects_stdin_cmd(opt, &output, &data);
+
 	strbuf_release(&input);
 	strbuf_release(&output);
 	warn_on_object_refname_ambiguity = save_warning;
@@ -636,6 +741,7 @@ static int batch_option_callback(const struct option *opt,
 
 	bo->enabled = 1;
 	bo->print_contents = !strcmp(opt->long_name, "batch");
+	bo->stdin_cmd = !strcmp(opt->long_name, "batch-command");
 	bo->format = arg;
 
 	return 0;
@@ -683,6 +789,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			N_("like --batch, but don't emit <contents>"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			batch_option_callback),
+		OPT_CALLBACK_F(0, "batch-command", &batch, N_(""),
+			 N_("enters batch mode that accepts commands"),
+			 PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			 batch_option_callback),
 		OPT_CMDMODE(0, "batch-all-objects", &opt,
 			    N_("with --batch[-check]: ignores stdin, batches all known objects"), 'b'),
 		/* Batch-specific options */
@@ -738,6 +848,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	/* Batch defaults */
 	if (batch.buffer_output < 0)
 		batch.buffer_output = batch.all_objects;
+	if (batch.end_null)
+		line_termination = '\0';
 
 	/* Return early if we're in batch mode? */
 	if (batch.enabled) {
diff --git a/strvec.c b/strvec.c
index 61a76ce6cb..7dca04bf7a 100644
--- a/strvec.c
+++ b/strvec.c
@@ -85,6 +85,29 @@ void strvec_split(struct strvec *array, const char *to_split)
 	}
 }
 
+size_t strvec_split_delim(struct strvec *array, const char *string,
+			  int delim, int maxsplit)
+{
+	size_t count = 0;
+	const char *p = string, *end;
+
+	for (;;) {
+		count++;
+		if (maxsplit >= 0 && count > maxsplit) {
+			strvec_push(array, p);
+			return count;
+		}
+		end = strchr(p, delim);
+		if (end) {
+			strvec_push_nodup(array, xmemdupz(p, end - p));
+			p = end + 1;
+		} else {
+			strvec_push(array, p);
+			return count;
+		}
+	}
+}
+
 void strvec_clear(struct strvec *array)
 {
 	if (array->v != empty_strvec) {
diff --git a/strvec.h b/strvec.h
index 9f55c8766b..c474918b91 100644
--- a/strvec.h
+++ b/strvec.h
@@ -73,6 +73,14 @@ void strvec_pop(struct strvec *);
 /* Splits by whitespace; does not handle quoted arguments! */
 void strvec_split(struct strvec *, const char *);
 
+/**
+ * strvec_split_delim() is a split function that behaves more like its
+ * string_list_split() cousin than the whitespace-splitting
+ * strvec_split().
+ */
+size_t strvec_split_delim(struct strvec *array, const char *string,
+			  int delim, int maxsplit);
+
 /**
  * Free all memory associated with the array and return it to the
  * initial, empty state.
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 145eee11df..935ab1cd34 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -964,4 +964,36 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
 	test_cmp expect actual
 '
 
+F='%s\0'
+
+test_expect_success 'batch-command unknown command' '
+	echo unknown_command >cmd &&
+	test_expect_code 128 git cat-file --batch-command < cmd 2>err &&
+	grep -E "^fatal:.*unknown command.*" err
+'
+
+test_expect_success 'setup object data' '
+	content="Object Data" &&
+	size=$(strlen "$content") &&
+	sha1=$(echo_without_newline "$content" | git hash-object -w --stdin)
+'
+
+test_expect_success 'batch-command calling object works' '
+	echo "object $sha1" | git cat-file --batch-command >actual &&
+	echo "$sha1 blob $size" >expect &&
+	echo `git cat-file -p "$sha1"` >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'batch-command calling info works' '
+	echo "info $sha1" | git cat-file --batch-command >actual &&
+	echo "$sha1 blob $size" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'batch-command fflush works' '
+	printf "fflush\n" > cmd &&
+	test_expect_code 0 git cat-file --batch-command < cmd 2>err
+'
+
 test_done
-- 
2.34.1

