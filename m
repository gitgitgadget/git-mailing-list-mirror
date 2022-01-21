Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D78C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 17:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380962AbiAURyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 12:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344348AbiAURyW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 12:54:22 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B7C06173D
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 09:54:22 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h15so10849703qtx.0
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 09:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rMcKufTpGJiFoMuDeX7W2G3L0mwK3Regy2riylMbZpc=;
        b=bJ9yLti4PU17VD/6UjCeLFFyjTmgGZdCftomPrUdi4uIV+uthXAETyr+YL+SfYGh/z
         3WSvJn5mNrxQ0MF+Adgk73LB/yoLHpgrFXC55OtoDC8T/hUC/9XBU0LU10R1nv1bp62r
         fU+JQzFIYObcHbmP/MniF8b9fNidPq5yxKjeOuZmogp1sfoEE7LbwwSWUwyZzecasgm0
         hit2VXm2VsDTRHc2g3haEuO88rjE6gNRE/+CqkIYhIOsZ128y8fNBaIfatZAu94AyJ0v
         87XLhFO6+iqyp++Nd5sAsEWQYPY+rjb1oIWyql543w4DjVKJhp5evIsID6Jo62bvoNay
         0cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rMcKufTpGJiFoMuDeX7W2G3L0mwK3Regy2riylMbZpc=;
        b=ijLSFdZB2oMEj0HI5kSm26u6C9PX97M+BgdZX6kjk7G9LKNmYtdQ8+V6NPIcRi+Jgp
         hJQtqpRDH1Uy4rOr9VPZPWUQzpLpktBhjWTk67XIBjixwRQznSQd59CD7ib4Cbz6QzdX
         bJ4tClDeRk3ioOMmPklJWGhK6gp5KnRoPTnMpDQn7Ye71d1OQtYGheH6pqJ2/HxXB3LP
         E5fJasIJ51Avd0KYh1EEvSl8xN+iwiH2G/kepWYjyu3za5ZBxKyxADEvNX/q5ayyB8N8
         IKL9hGOMNDQmGmMgF8k9bt7diqx39785yTnOMYleOofCtVdrp/0Qx6QPkfgzhrLH3H2d
         myIQ==
X-Gm-Message-State: AOAM532Tal8o2Fu+5MzNWDsiGnA7Qq+PLp1/5lZ1cXvspP9sIfX7ryhY
        pMqeMZfFrBAXVCK/bznzG/8Vv/s96FDBBQ==
X-Google-Smtp-Source: ABdhPJyt+BfWvvtJ0Z9Jvwdgkg5AXGpfZk0rOeMjQsJ8X+IdWCkS5m/SJzU2d5vyaNUUUGqln3QNLg==
X-Received: by 2002:a05:622a:178a:: with SMTP id s10mr2520932qtk.404.1642787661447;
        Fri, 21 Jan 2022 09:54:21 -0800 (PST)
Received: from Johns-MBP.myfiosgateway.com (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id r137sm3338116qke.42.2022.01.21.09.54.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Jan 2022 09:54:21 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, me@ttaylorr.com, John Cai <johncai86@gmail.com>
Subject: [RFC] cat-file: add a --stdin-cmd mode
Date:   Fri, 21 Jan 2022 12:54:05 -0500
Message-Id: <20220121175405.45753-1-johncai86@gmail.com>
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
 builtin/cat-file.c  | 137 +++++++++++++++++++++++++++++++++++++++++++-
 strvec.c            |  23 ++++++++
 strvec.h            |   8 +++
 t/t1006-cat-file.sh |  72 +++++++++++++++++++++++
 4 files changed, 239 insertions(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7b3f42950e..2679b34b43 100644
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
 
@@ -508,6 +512,126 @@ static int batch_unordered_packed(const struct object_id *oid,
 				      data);
 }
 
+enum batch_state {
+	/* Non-transactional state open for commands. */
+	BATCH_STATE_OPEN,
+};
+
+static void parse_cmd_object(struct batch_options *opt,
+			     const int argc, const char **argv,
+			     struct strbuf *output,
+			     struct expand_data *data)
+{
+	batch_one_object(argv[0], output, opt, data);
+}
+
+static void parse_cmd_info(struct batch_options *opt,
+			     const int argc, const char **argv,
+			     struct strbuf *output,
+			     struct expand_data *data)
+{
+	opt->print_contents = 0;
+	batch_one_object(argv[0], output, opt, data);
+}
+
+static void parse_cmd_fflush(struct batch_options *opt,
+			     const int argc, const char **argv,
+			     struct strbuf *output,
+			     struct expand_data *data)
+{
+	fflush(stdout);
+}
+
+typedef void (*parse_cmd_fn_t)(struct batch_options *, const int,
+			       const char **, struct strbuf *,
+			       struct expand_data *);
+
+static const struct parse_cmd {
+	const char *prefix;
+	parse_cmd_fn_t fn;
+	unsigned args;
+	enum batch_state state;
+} command[] = {
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
+		struct strvec args = STRVEC_INIT;
+		size_t n;
+		const char *p;
+
+		if (*input.buf == line_termination)
+			die("empty command in input");
+		else if (isspace(*input.buf))
+			die("whitespace before command: %s", input.buf);
+
+		for (i = 0; i < ARRAY_SIZE(command); i++) {
+			const char *prefix = command[i].prefix;
+			char c;
+
+			if (!starts_with(input.buf, prefix))
+				continue;
+
+			/*
+			 * If the command has arguments, verify that it's
+			 * followed by a space. Otherwise, it shall be followed
+			 * by a line terminator.
+			 */
+			c = command[i].args ? ' ' : line_termination;
+			if (input.buf[strlen(prefix)] != c)
+				continue;
+
+			cmd = &command[i];
+			break;
+		}
+		if (!cmd)
+			die("unknown command: %s", input.buf);
+
+		/*
+		 * Read additional arguments. Do not raise an error in
+		 * case there is an early EOF to let the command
+		 * handle missing arguments with a proper error message
+		 */
+		p = input.buf + strlen(cmd->prefix) + 1;
+		if (*p == line_termination || !*p) {
+			n = 0;
+		} else {
+			const char *pos = strstr(p, "\n");
+			char *str = xstrndup(p, pos - p);
+
+			n = strvec_split_delim(&args, str, ' ', - 1);
+			free(str);
+		}
+
+		if (n < cmd->args)
+			die("%s: too few arguments", cmd->prefix);
+		if (n > cmd->args)
+			die("%s: too many arguments", cmd->prefix);
+
+		switch (state) {
+		case BATCH_STATE_OPEN:
+			/* TODO: command state management */
+			break;
+		}
+		cmd->fn(opt, args.nr, args.v, output, data);
+		strvec_clear(&args);
+	}
+
+	strbuf_release(&input);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -515,6 +639,7 @@ static int batch_objects(struct batch_options *opt)
 	struct expand_data data;
 	int save_warning;
 	int retval = 0;
+	const int stdin_cmd = opt->stdin_cmd;
 
 	if (!opt->format)
 		opt->format = "%(objectname) %(objecttype) %(objectsize)";
@@ -590,7 +715,8 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (strbuf_getline(&input, stdin) != EOF) {
+	while (!stdin_cmd &&
+	       strbuf_getline(&input, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
@@ -608,6 +734,9 @@ static int batch_objects(struct batch_options *opt)
 		batch_one_object(input.buf, &output, opt, &data);
 	}
 
+	if (stdin_cmd)
+		batch_objects_stdin_cmd(opt, &output, &data);
+
 	strbuf_release(&input);
 	strbuf_release(&output);
 	warn_on_object_refname_ambiguity = save_warning;
@@ -685,6 +814,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			batch_option_callback),
 		OPT_CMDMODE(0, "batch-all-objects", &opt,
 			    N_("with --batch[-check]: ignores stdin, batches all known objects"), 'b'),
+		OPT_BOOL(0, "stdin-cmd", &batch.stdin_cmd,
+			 N_("with --batch[-check]: enters stdin 'command mode")),
+		OPT_BOOL('z', NULL, &batch.end_null, N_("with --stdin-cmd, use NUL termination")),
+
 		/* Batch-specific options */
 		OPT_GROUP(N_("Change or optimize batch output")),
 		OPT_BOOL(0, "buffer", &batch.buffer_output, N_("buffer --batch output")),
@@ -738,6 +871,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
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
index 145eee11df..8f339746ec 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -964,4 +964,76 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
 	test_cmp expect actual
 '
 
+F='%s\0'
+
+test_expect_success 'stdin-cmd not enough arguments' '
+	echo "object " >cmd &&
+	test_expect_code 128 git cat-file --batch --stdin-cmd < cmd 2>err &&
+	grep -E "^fatal:.*too few arguments" err
+'
+
+test_expect_success 'stdin-cmd too many arguments' '
+	echo "object foo bar" >cmd &&
+	test_expect_code 128 git cat-file --batch --stdin-cmd < cmd 2>err &&
+	grep -E "^fatal:.*too many arguments" err
+'
+
+test_expect_success 'stdin-cmd unknown command' '
+	echo unknown_command >cmd &&
+	test_expect_code 128 git cat-file --batch --stdin-cmd < cmd 2>err &&
+	grep -E "^fatal:.*unknown command.*" err &&
+	test_expect_code 128 git cat-file --batch --stdin-cmd -z < cmd 2>err &&
+	grep -E "^fatal:.*unknown command.*" err
+'
+
+test_expect_success 'setup object data' '
+	content="Object Data" &&
+	size=$(strlen "$content") &&
+	sha1=$(echo_without_newline "$content" | git hash-object -w --stdin)
+'
+
+test_expect_success 'stdin-cmd calling object works' '
+	echo "object $sha1" | git cat-file --batch --stdin-cmd >actual &&
+	echo "$sha1 blob $size" >expect &&
+	echo `git cat-file -p "$sha1"` >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin-cmd -z calling object works' '
+	printf $F "object $sha1" | git cat-file --batch --stdin-cmd -z >actual &&
+	echo "$sha1 blob $size" >expect &&
+	echo `git cat-file -p "$sha1"` >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup object data' '
+	content="Object Data" &&
+	size=$(strlen "$content") &&
+	sha1=$(echo_without_newline "$content" | git hash-object -w --stdin)
+'
+
+test_expect_success 'stdin-cmd calling object works' '
+	echo "object $sha1" | git cat-file --batch --stdin-cmd >actual &&
+	echo "$sha1 blob $size" >expect &&
+	echo `git cat-file -p "$sha1"` >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin-cmd -z calling object works' '
+	printf $F "object $sha1" | git cat-file --batch --stdin-cmd -z >actual &&
+	echo "$sha1 blob $size" >expect &&
+	echo `git cat-file -p "$sha1"` >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin-cmd fflush works' '
+	printf "fflush\n" > cmd &&
+	test_expect_code 0 git cat-file --batch --stdin-cmd < cmd 2>err
+'
+
+test_expect_success 'stdin-cmd -z fflush works' '
+	printf $F 'fflush' > cmd &&
+	test_expect_code 0 git cat-file --batch --stdin-cmd -z < cmd 2>err
+'
+
 test_done
-- 
2.34.1

