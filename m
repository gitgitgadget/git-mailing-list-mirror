Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC560C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 17:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356575AbiASR6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356567AbiASR6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 12:58:48 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8FDC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:58:47 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c66so6702393wma.5
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=h7lg997a9OK7H4YUOj/VxyEbxdTIqmp/rP1JYS43B3M=;
        b=SSJU2aud5TicSdFZIpeqGSuYk/x4fWAOdGown6CnY/SHiVTM/qP2nXV1y+fcP3AUz+
         KxgGHTPXP/LvRhRHCa/TQYxYUL0w8PDZQO5l4cpuRyXewqvAHtEtYIOt3UKb5MIoEVwf
         IzIFnxlEEH1Z+eoBySyTp4wGmK7fjvOcuQ9ti3GkcDPkWE/8/JLpRKv1Fz/n7lY+3PpR
         AhC7/YpkAbfCJ+rb8//Hii4etlZo4A9pmscu0gWKM3aWrFCVg+rzWvACzWVvGATd+x0j
         r659CyPj9AWUcIu250Z3qKkW5vlVmFL8ejQo7/eha6KzoG+VtPKoYD7C28CaIP6lMoFp
         0QlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=h7lg997a9OK7H4YUOj/VxyEbxdTIqmp/rP1JYS43B3M=;
        b=wbIEgFXPFnJ2B7thxFNXxGQC2v1syUqSsvp13GoPgtFPajziG2JgGeSUdzSD5myQtx
         o30YU7HwjWDIdBM1AfjcsnECqwE+NCJ6yf8LDKUqUgCwy0zItiuc8SMGe1nP3y6c4g8v
         rj0tqIdrVmJfId7vJbB6nlxWH6d7+N5k0c51CzTK7THKdd3s9/P2OxNN1nsErB4QF3wQ
         csyqSTHpNj0MNItz79K7RAsn0CWgaAMLziZIer5iiO6qPrcVqEyiaPSCmGaIqo02ZaaQ
         9pwV21Z+ybmZ5YcGw98mPd4XnFL5n1ZvaysW0pOm/XLZ3A3RHjZX2Iv89Z2PS0ku9KRQ
         4NsQ==
X-Gm-Message-State: AOAM533EUOLBllvyKkzONQnPKUcVGTrObBV2JoYjwimZ+CDUPo97P78I
        jkVSmDHOheVQ0bOcen4JFhs21HsTjyA=
X-Google-Smtp-Source: ABdhPJw8bEkFCIyTmAcaMUa0j2QFKMnqh14wZ0TvTwDuCE8qJVriU1P6G8tDOO3h4qr+c0CpBgvhBw==
X-Received: by 2002:a1c:9d41:: with SMTP id g62mr4634263wme.125.1642615125871;
        Wed, 19 Jan 2022 09:58:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm441267wrw.92.2022.01.19.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 09:58:45 -0800 (PST)
Message-Id: <63fb5d156c74eb6605383a837db3e3afb024cc0e.1642615122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1191.git.git.1642615122.gitgitgadget@gmail.com>
References: <pull.1191.git.git.1642615122.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Jan 2022 17:58:42 +0000
Subject: [PATCH 2/2] cat-file: add a --stdin-cmd mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Teach cat-file to accept a --stdin-cmd which causes cat-file to enter a
command mode to receive commands and arguments on stdin..

batch_objects_stdin_cmd() handles a line from stdin, which it expects a
command name and arguments. -z will tell --stdin-cmd to look for NUL
as the line termination.

This commit adds two commands, fflush and object. fflush immediately
flushes the buffer. object takes a sha as an argument and passes it to
batch_one_object().

The code allows for additional commands to be added as parse_cmd structs.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/cat-file.c  | 128 +++++++++++++++++++++++++++++++++++++++++++-
 t/t1006-cat-file.sh |  72 +++++++++++++++++++++++++
 2 files changed, 199 insertions(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7b3f42950ec..f56dbc85388 100644
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
 
@@ -508,6 +512,117 @@ static int batch_unordered_packed(const struct object_id *oid,
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
+		for (i = 0; i < args.nr; i++)
+			fprintf(stderr, "%d: <%s>\n", i, args.v[i]);
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
@@ -515,6 +630,7 @@ static int batch_objects(struct batch_options *opt)
 	struct expand_data data;
 	int save_warning;
 	int retval = 0;
+	const int stdin_cmd = opt->stdin_cmd;
 
 	if (!opt->format)
 		opt->format = "%(objectname) %(objecttype) %(objectsize)";
@@ -590,7 +706,8 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (strbuf_getline(&input, stdin) != EOF) {
+	while (!stdin_cmd &&
+	       strbuf_getline(&input, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
@@ -608,6 +725,9 @@ static int batch_objects(struct batch_options *opt)
 		batch_one_object(input.buf, &output, opt, &data);
 	}
 
+	if (stdin_cmd)
+		batch_objects_stdin_cmd(opt, &output, &data);
+
 	strbuf_release(&input);
 	strbuf_release(&output);
 	warn_on_object_refname_ambiguity = save_warning;
@@ -685,6 +805,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
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
@@ -738,6 +862,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	/* Batch defaults */
 	if (batch.buffer_output < 0)
 		batch.buffer_output = batch.all_objects;
+	if (batch.end_null)
+		line_termination = '\0';
 
 	/* Return early if we're in batch mode? */
 	if (batch.enabled) {
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 145eee11df9..8f339746ecf 100755
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
gitgitgadget
