Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380A1C433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 10:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF13061962
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 10:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhCaKGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhCaKFw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 06:05:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0D6C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 03:05:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so19051156wrc.3
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 03:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c9tIz5EE8oCq1ynp0WJE8QCgdNDZmUoBg58/qUTggKY=;
        b=NWY2r7vX2eIEApipJ+PsyKQvJQlnwIT634q0VzHFGoHL0gq1L7Kdc3fK8E5ZA1KuNS
         iPrGMymsv4zilPyCXuqzzBxOE6qB8n94vtgkdT2a9nzK9IHenooSiscv0Hwa98ErIqkq
         88HwM1iQ2QR1b2TsCW+sIA20SjwPlwTg54rHeVxhED/ft4Jwerv+wqmguQTP0KUv9ErP
         PplbYo0SrONoQ33VuibrKx29sN4BNTciOJx01fSJsSvQ/fWpCPLYrWGGUz9009fFsU5c
         ecrKX5XKolT7EO2SqWjQ5ZSwyOBbSpufi/qelkkI27KrRvPxC7wf5DPH6gnQ8aXRxHYP
         Jydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c9tIz5EE8oCq1ynp0WJE8QCgdNDZmUoBg58/qUTggKY=;
        b=ACYObuSn66weNsYh5ciHUOXCSSA93SqKNpLT4oTyHrkegOwTgnihzz4tfDVR3jNXbt
         iAabS5tQZCoDt8s3k4BYHJ99ojUU8bDbiE4F0qlEBlR2+wwk+5Q7JPuTo+pH8Y6U56ma
         IO7Cp5NppFJIGv6OE0sDcKuXtvtT1Z2jAlF3T4j7hsX+cwA1YQTuFfrITeuc4gCNlPqO
         xu+PfJNtzuZRDHw8gv0+UO61CZnQQg8aAvvnes9/jSTVuh4eRShB7UsvMYeZS5+pI7AU
         0Q/hWKpuiiKPVEMe5eptDpUxHn5lfPUbJZMsgznzAX5tJ/3mUzOMzW93JQEnYScGM96z
         YZpA==
X-Gm-Message-State: AOAM530fZXQ88Ba7k7dgIcPRovbvF71Y07qz9u2n1GdXO3JJxoGWIX3F
        cDk4shC5+AYtnr2lzgTRw//lcmHhOr0=
X-Google-Smtp-Source: ABdhPJx4KsqpyRurPejB+0hDeYIlovp8Ni/cEXPg0ssvbxpxdBFlCaqG4l7UBllZdvVfhdDq5gyj4A==
X-Received: by 2002:a5d:4d09:: with SMTP id z9mr2663120wrt.426.1617185150574;
        Wed, 31 Mar 2021 03:05:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm3289951wrw.51.2021.03.31.03.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 03:05:50 -0700 (PDT)
Message-Id: <5894d8c4b36466326b0427bfda0d6981e52a0907.1617185147.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
References: <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com>
        <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Mar 2021 10:05:47 +0000
Subject: [PATCH v5 2/2] [GSOC]trailer: pass arg as positional parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

The `trailer.<token>.command` configuration variable
specifies a command (run via the shell, so it does not have
to be a single name of or path to the command, but can be a
shell script), and the first occurrence of substring $ARG is
replaced with the value given to the `interpret-trailer`
command for the token.  This has two downsides:

* The use of $ARG in the mechanism misleads the users that
the value is passed in the shell variable, and tempt them
to use $ARG more than once, but that would not work, as
the second and subsequent $ARG are not replaced.

* Because $ARG is textually replaced without regard to the
shell language syntax, even '$ARG' (inside a single-quote
pair), which a user would expect to stay intact, would be
replaced, and worse, if the value had an unmatching single
quote (imagine a name like "O'Connor", substituted into
NAME='$ARG' to make it NAME='O'Connor), it would result in
a broken command that is not syntactically correct (or
worse).

Introduce a new `trailer.<token>.cmd` configuration that
takes higher precedence to deprecate and eventually remove
`trailer.<token>.command`, which passes the value as a
parameter to the command.  Instead of "$ARG", the users will
refer to the value as positional argument, $1, in their
scripts.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-interpret-trailers.txt | 75 ++++++++++++++++++++----
 t/t7513-interpret-trailers.sh            | 61 ++++++++++++++++++-
 trailer.c                                | 39 ++++++++----
 3 files changed, 152 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f001..bbd1c9bfd65e 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -236,21 +236,34 @@ trailer.<token>.command::
 	be called to automatically add or modify a trailer with the
 	specified <token>.
 +
-When this option is specified, the behavior is as if a special
-'<token>=<value>' argument were added at the beginning of the command
-line, where <value> is taken to be the standard output of the
-specified command with any leading and trailing whitespace trimmed
-off.
+When this option is specified, the first occurrence of substring $ARG is
+replaced with the value given to the `interpret-trailer` command for the
+same token.
 +
-If the command contains the `$ARG` string, this string will be
-replaced with the <value> part of an existing trailer with the same
-<token>, if any, before the command is launched.
+".command" has been deprecated due to the $ARG in the user's command can
+only be replaced once and the original way of replacing $ARG was not safe.
+Now the preferred option is using "trailer.<token>.cmd", which use position
+argument to pass the value.
++
+When both .cmd and .command are given for the same <token>,
+.cmd is used and .command is ignored.
+
+trailer.<token>.cmd::
+	The command specified by this configuration variable is run
+	with a single parameter, which is the <value> part of an
+	existing trailer with the same <token>.  The output from the
+	command is then used as the value for the <token> in the
+	resulting trailer.
++
+When this option is specified, If there is no trailer with same <token>,
+the behavior is as if a special '<token>=<value>' argument were added at
+the beginning of the command, <value> will be passed to the user's
+command as an empty value.
 +
 If some '<token>=<value>' arguments are also passed on the command
 line, when a 'trailer.<token>.command' is configured, the command will
 also be executed for each of these arguments. And the <value> part of
-these arguments, if any, will be used to replace the `$ARG` string in
-the command.
+these arguments, if any, will be passed to the command as first parameter.
 
 EXAMPLES
 --------
@@ -333,6 +346,48 @@ subject
 Fix #42
 ------------
 
+* Configure a 'see' trailer with a cmd to show the subject of a
+  commit that is related, and show how it works:
++
+------------
+$ git config trailer.see.key "See-also: "
+$ git config trailer.see.ifExists "replace"
+$ git config trailer.see.ifMissing "doNothing"
+$ git config trailer.see.cmd "git show -s --pretty=reference \"\$1\""
+$ git interpret-trailers <<EOF
+> subject
+> 
+> message
+> 
+> see: HEAD~2
+> EOF
+subject
+
+message
+
+See-also: fe3187489d69c4 (subject of related commit, 2021-3-20)
+------------
+
+* Configure a 'bug' trailer with a cmd to show when and where
+  was the bug introduced, and show how it works:
++
+------------
+$ git config trailer.bug.key "Bug-from: "
+$ git config trailer.bug.ifExists "replace"
+$ git config trailer.bug.cmd "git log --grep \"\$1\" -1 --pretty=\"%h %aD\""
+$ git interpret-trailers --trailer="bug:the information manager from hell" <<EOF
+> subject
+> 
+> message
+> 
+> EOF
+subject
+
+message
+
+Bug-from: 57d84f8d93 Mon, 6 Aug 2012 18:27:09 +0700
+------------
+
 * Configure a 'see' trailer with a command to show the subject of a
   commit that is related, and show how it works:
 +
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6602790b5f4c..aec240f1dc05 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -51,6 +51,24 @@ test_expect_success 'setup' '
 	EOF
 '
 
+test_expect_success 'with cmd' '
+	test_when_finished "git config --unset trailer.bug.key && \
+	git config --unset trailer.bug.ifExists && \
+	git config --unset trailer.bug.cmd" &&
+	git config trailer.bug.key "Bug-maker: " &&
+	git config trailer.bug.ifExists "add" &&
+	git config trailer.bug.cmd "echo \"\$@\"" &&
+	cat >>expected2 <<-EOF &&
+
+	Bug-maker: 
+	Bug-maker: jocker
+	Bug-maker: batman
+	EOF
+	git interpret-trailers --trailer "bug: jocker" --trailer "bug:batman" \
+		>actual2 &&
+	test_cmp expected2 actual2
+'
+
 test_expect_success 'without config' '
 	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
 
@@ -1274,9 +1292,50 @@ test_expect_success 'setup a commit' '
 	git commit -m "Add file a.txt"
 '
 
+test_expect_success 'with cmd and $1' '
+	test_when_finished "git config --unset trailer.fix.cmd" &&
+	git config trailer.fix.ifExists "replace" &&
+	git config trailer.fix.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%s)\" \
+		--abbrev-commit --abbrev=14 \"\$1\" || true" &&
+	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
+	cat complex_message_body >expected2 &&
+	sed -e "s/ Z\$/ /" >>expected2 <<-EOF &&
+		Fixes: $FIXED
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Signed-off-by: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=HEAD" \
+		<complex_message >actual2 &&
+	test_cmp expected2 actual2
+'
+
+test_expect_success 'cmd takes precedence over command' '
+	test_when_finished "git config --unset trailer.fix.cmd" &&
+	git config trailer.fix.ifExists "replace" &&
+	git config trailer.fix.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%aN)\" \
+		--abbrev-commit --abbrev=14 \"\$1\" || true" &&
+	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" \
+		--abbrev-commit --abbrev=14 \$ARG" &&
+	FIXED=$(git log -1 --oneline --format="%h (%aN)" --abbrev-commit --abbrev=14 HEAD) &&
+	cat complex_message_body >expected2 &&
+	sed -e "s/ Z\$/ /" >>expected2 <<-EOF &&
+		Fixes: $FIXED
+		Acked-by= Z
+		Reviewed-by:
+		Signed-off-by: Z
+		Signed-off-by: A U Thor <author@example.com>
+	EOF
+	git interpret-trailers --trailer "review:" --trailer "fix=HEAD" \
+		<complex_message >actual2 &&
+	test_cmp expected2 actual2
+'
+
 test_expect_success 'with command using $ARG' '
 	git config trailer.fix.ifExists "replace" &&
-	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
+	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" \
+		--abbrev-commit --abbrev=14 \$ARG" &&
 	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
diff --git a/trailer.c b/trailer.c
index 35dd0f4c8512..a000293d6e7e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -14,6 +14,7 @@ struct conf_info {
 	char *name;
 	char *key;
 	char *command;
+	char *cmd;
 	enum trailer_where where;
 	enum trailer_if_exists if_exists;
 	enum trailer_if_missing if_missing;
@@ -127,6 +128,7 @@ static void free_arg_item(struct arg_item *item)
 	free(item->conf.name);
 	free(item->conf.key);
 	free(item->conf.command);
+	free(item->conf.cmd);
 	free(item->token);
 	free(item->value);
 	free(item);
@@ -216,22 +218,28 @@ static int check_if_different(struct trailer_item *in_tok,
 	return 1;
 }
 
-static char *apply_command(const char *command, const char *arg)
+static char *apply_command(struct conf_info *conf, const char *arg)
 {
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *result;
 
-	strbuf_addstr(&cmd, command);
-	if (arg)
-		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
-
-	strvec_push(&cp.args, cmd.buf);
+	if (conf->cmd) {
+		cp.shell_no_implicit_args = 1;
+		strbuf_addstr(&cmd, conf->cmd);
+		strvec_push(&cp.args, cmd.buf);
+		if (arg)
+			strvec_push(&cp.args, arg);
+	} else if (conf->command) {
+		strbuf_addstr(&cmd, conf->command);
+		strvec_push(&cp.args, cmd.buf);
+		if (arg)
+			strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
+	}
 	cp.env = local_repo_env;
 	cp.no_stdin = 1;
 	cp.use_shell = 1;
-	cp.shell_no_implicit_args = 1;
 
 	if (capture_command(&cp, &buf, 1024)) {
 		error(_("running trailer command '%s' failed"), cmd.buf);
@@ -248,7 +256,7 @@ static char *apply_command(const char *command, const char *arg)
 
 static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
 {
-	if (arg_tok->conf.command) {
+	if (arg_tok->conf.command || arg_tok->conf.cmd) {
 		const char *arg;
 		if (arg_tok->value && arg_tok->value[0]) {
 			arg = arg_tok->value;
@@ -258,7 +266,7 @@ static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
 			else
 				arg = xstrdup("");
 		}
-		arg_tok->value = apply_command(arg_tok->conf.command, arg);
+		arg_tok->value = apply_command(&arg_tok->conf, arg);
 		free((char *)arg);
 	}
 }
@@ -431,6 +439,7 @@ static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
 	dst->name = xstrdup_or_null(src->name);
 	dst->key = xstrdup_or_null(src->key);
 	dst->command = xstrdup_or_null(src->command);
+	dst->cmd = xstrdup_or_null(src->cmd);
 }
 
 static struct arg_item *get_conf_item(const char *name)
@@ -455,8 +464,8 @@ static struct arg_item *get_conf_item(const char *name)
 	return item;
 }
 
-enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_WHERE,
-			 TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
+enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_CMD,
+			TRAILER_WHERE, TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
 
 static struct {
 	const char *name;
@@ -464,6 +473,7 @@ static struct {
 } trailer_config_items[] = {
 	{ "key", TRAILER_KEY },
 	{ "command", TRAILER_COMMAND },
+	{ "cmd", TRAILER_CMD },
 	{ "where", TRAILER_WHERE },
 	{ "ifexists", TRAILER_IF_EXISTS },
 	{ "ifmissing", TRAILER_IF_MISSING }
@@ -543,6 +553,11 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 			warning(_("more than one %s"), conf_key);
 		conf->command = xstrdup(value);
 		break;
+	case TRAILER_CMD:
+		if (conf->cmd)
+			warning(_("more than one %s"), conf_key);
+		conf->cmd = xstrdup(value);
+		break;
 	case TRAILER_WHERE:
 		if (trailer_set_where(&conf->where, value))
 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
@@ -709,7 +724,7 @@ static void process_command_line_args(struct list_head *arg_head,
 	/* Add an arg item for each configured trailer with a command */
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct arg_item, list);
-		if (item->conf.command)
+		if (item->conf.cmd || item->conf.command)
 			add_arg_item(arg_head,
 				     xstrdup(token_from_item(item, NULL)),
 				     xstrdup(""),
-- 
gitgitgadget
