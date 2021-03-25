Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A37C433E2
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 11:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1583619EE
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 11:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCYLxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 07:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCYLxY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 07:53:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24F0C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 04:53:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v4so1946808wrp.13
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FJPQ61cJcXyfVDV0AjWyuTg53vLr2wwIY7u8y8djYUE=;
        b=RizxcSQw6F6q6/SBXl6fwA+q7WK37czoTXfSPKhXq1K5si7uIl/yF0GOzh0T/DdcTp
         lsyRouqXUtsM2WWNRhh8SFuX5J0Df5dJK6rf2lo8aZitFf0sPeoR1XAmop7wSvrsojb4
         mImkkVUDQUMxO/sITNV/fa6iVgFwOKX1arr5GarAr3H1XYbz2n9ImyLEHQcstjOMOoUd
         kW9wSsE01Py8n7SQSIrVbf94f/JRvaQA96wF74azhBTGV9PLkq2CSH2yz02X3M+hhZSh
         W/0B4N0zJ1/J9BdzSq4Zyb3wO0yKoOr8Aifqr6oz2TsTHT7MTHNJME0+TTUaZ0oFoFPn
         xVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FJPQ61cJcXyfVDV0AjWyuTg53vLr2wwIY7u8y8djYUE=;
        b=Copd5xOv6jLJtE349j9XFgb44R7+Ge0yWlhHa9RH4HR8rcNdJLQGg+otxWmuzrqHl+
         7HWwfMAcL3HZDlU+ZjO0uYkh5QKgKUxxkZokkqjlHryu6Syz08amulHOMQTOUpyPkMon
         y0VaQrQyzSNZJxDRPiwgqM0VPnBtRZLUWDKQ9A3PBw5/8BQ0xD8N9LZ+lzSXQ6HQvNUs
         r/NtoWvr8UqUO4/ruyltnoL9a36OcoJwvka1P0k+JmYxGD9sgqvk28Of2omEyxWNVXDF
         TRhe5T1ohXZq7gd+Ad6++6DZSlYSNRW9aTY40B4Ns5fiOtfXUTVsJxF7G9b86kJT6uyn
         /lBA==
X-Gm-Message-State: AOAM5323ndjM4ZORT25bRKYrjOut/owo4Th2SdEqO0GYrZoOs7bLnU8q
        qwUxalIaAyyKp21S/JSRvKJJcTbDRxU=
X-Google-Smtp-Source: ABdhPJx0NDXshrgeA+7ob1WA/nseW/D4loBEAncyGpGAZxr+V8Ir+lAdn9f9mL0rtjh2WuwEtHG+7g==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr8460499wrw.421.1616673202471;
        Thu, 25 Mar 2021 04:53:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm6115054wmb.35.2021.03.25.04.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 04:53:21 -0700 (PDT)
Message-Id: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v2.git.1616600555906.gitgitgadget@gmail.com>
References: <pull.913.v2.git.1616600555906.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Mar 2021 11:53:20 +0000
Subject: [PATCH v3] [GSOC]trailer: pass arg as positional parameter
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Original implementation of `trailer.<token>.command` use
`strbuf_replace` to replace $ARG in command with the <value>
of the trailer, but it have a problem: `strbuf_replace`
replace the $ARG only once, If the user's trailer command
have used more than one $ARG, the remaining replacement will
fail.

If directly modify the implementation of the original
`trailer.<token>.command`, The user’s previous `'$ARG'` in
trailer command will not be replaced. So now add new config
"trailer.<token>.cmd", pass trailer's value as positional
parameter 1 to the user's command, the user can use $1 as
trailer's value, to implement original variable replacement.

If the user has these two configuration: "trailer.<token>.cmd"
and "trailer.<token>.command", "cmd" will execute and "command"
will not executed.

Original `trailer.<token>.command` can still be used until git
completely abandoned it.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC]trailer: pass arg as positional parameter
    
    In https://lore.kernel.org/git/xmqqv99i4ck2.fsf@gitster.g/ Junio and
    Christian talked about the problem of using strbuf_replace() to replace
    $ARG.
    
    Now pass trailer value as $1 to the trailer command with another
    trailer.<token>.cmd config.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/913

Range-diff vs v2:

 1:  185356d6fc90 ! 1:  b268ecd7b395 [GSOC]trailer: pass arg as positional parameter
     @@ Metadata
       ## Commit message ##
          [GSOC]trailer: pass arg as positional parameter
      
     -    In the original implementation of `trailer.<token>.command`,
     -    use `strbuf_replace` to replace $ARG in the <value> of the
     -    trailer, but it have a problem: `strbuf_replace` replace the
     -    $ARG in command only once, If the user's trailer command have
     -    used more than one $ARG, error will occur.
     +    Original implementation of `trailer.<token>.command` use
     +    `strbuf_replace` to replace $ARG in command with the <value>
     +    of the trailer, but it have a problem: `strbuf_replace`
     +    replace the $ARG only once, If the user's trailer command
     +    have used more than one $ARG, the remaining replacement will
     +    fail.
      
          If directly modify the implementation of the original
          `trailer.<token>.command`, The user’s previous `'$ARG'` in
     -    trailer command will not be replaced. So now add new
     -    config "trailer.<token>.cmd", pass trailer's value as
     -    positional parameter 1 to the user's command, users can
     -    use $1 as trailer's value, to implement original variable
     -    replacement.
     +    trailer command will not be replaced. So now add new config
     +    "trailer.<token>.cmd", pass trailer's value as positional
     +    parameter 1 to the user's command, the user can use $1 as
     +    trailer's value, to implement original variable replacement.
     +
     +    If the user has these two configuration: "trailer.<token>.cmd"
     +    and "trailer.<token>.command", "cmd" will execute and "command"
     +    will not executed.
      
          Original `trailer.<token>.command` can still be used until git
          completely abandoned it.
     @@ Documentation/git-interpret-trailers.txt: also be executed for each of these arg
      +trailer.<token>.cmd::
      +	Similar to 'trailer.<token>.command'. But the difference is that
      +	`$1` is used in the command to replace the value of the trailer
     -+	instead of the original `$ARG`, which means that we can quote the
     ++	instead of the original `$ARG`, which means that we can pass the
      +	trailer value multiple times in the command.
     -+	E.g. `trailer.sign.cmd="test -n \"$1\" && echo \"$1\" || true "`
     ++	E.g. `git config trailer.sign.cmd "test -n \"$1\" && echo \"$1\" || true "`.
     ++	If the user has these two configuration: "trailer.<token>.cmd"
     ++	and "trailer.<token>.command", "cmd" will be executed and "command"
     ++	will not be executed.
      +
       EXAMPLES
       --------
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup a commit' '
       	git commit -m "Add file a.txt"
       '
       
     -+test_expect_success 'with cmd using $1' '
     ++test_expect_success 'with cmd and $1' '
      +	test_when_finished "git config --unset trailer.fix.cmd" &&
      +	git config trailer.fix.ifExists "replace" &&
      +	git config trailer.fix.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%s)\" \
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup a commit' '
      +		<complex_message >actual2 &&
      +	test_cmp expected2 actual2
      +'
     ++
     ++test_expect_success 'cmd takes precedence over command' '
     ++	test_when_finished "git config --unset trailer.fix.cmd" &&
     ++	git config trailer.fix.ifExists "replace" &&
     ++	git config trailer.fix.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%aN)\" \
     ++		--abbrev-commit --abbrev=14 \"\$1\" || true" &&
     ++	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" \
     ++		--abbrev-commit --abbrev=14 \$ARG" &&
     ++	FIXED=$(git log -1 --oneline --format="%h (%aN)" --abbrev-commit --abbrev=14 HEAD) &&
     ++	cat complex_message_body >expected2 &&
     ++	sed -e "s/ Z\$/ /" >>expected2 <<-EOF &&
     ++		Fixes: $FIXED
     ++		Acked-by= Z
     ++		Reviewed-by:
     ++		Signed-off-by: Z
     ++		Signed-off-by: A U Thor <author@example.com>
     ++	EOF
     ++	git interpret-trailers --trailer "review:" --trailer "fix=HEAD" \
     ++		<complex_message >actual2 &&
     ++	test_cmp expected2 actual2
     ++'
      +
       test_expect_success 'with command using $ARG' '
       	git config trailer.fix.ifExists "replace" &&
     @@ trailer.c: struct conf_info {
       	char *name;
       	char *key;
       	char *command;
     -+	int is_new_cmd;
     ++	char *cmd;
       	enum trailer_where where;
       	enum trailer_if_exists if_exists;
       	enum trailer_if_missing if_missing;
     +@@ trailer.c: static void free_arg_item(struct arg_item *item)
     + 	free(item->conf.name);
     + 	free(item->conf.key);
     + 	free(item->conf.command);
     ++	free(item->conf.cmd);
     + 	free(item->token);
     + 	free(item->value);
     + 	free(item);
      @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
       	return 1;
       }
       
      -static char *apply_command(const char *command, const char *arg)
     -+static char *apply_command(const char *command, int is_new_cmd , const char *arg)
     ++static char *apply_command(const char *command, const char *cmd_, const char *arg)
       {
       	struct strbuf cmd = STRBUF_INIT;
       	struct strbuf buf = STRBUF_INIT;
     -@@ trailer.c: static char *apply_command(const char *command, const char *arg)
     + 	struct child_process cp = CHILD_PROCESS_INIT;
       	char *result;
       
     - 	strbuf_addstr(&cmd, command);
     +-	strbuf_addstr(&cmd, command);
      -	if (arg)
      -		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
      -
     - 	strvec_push(&cp.args, cmd.buf);
     -+	if (arg) {
     -+		if (is_new_cmd)
     +-	strvec_push(&cp.args, cmd.buf);
     ++	if (cmd_) {
     ++		strbuf_addstr(&cmd, cmd_);
     ++		strvec_push(&cp.args, cmd.buf);
     ++		if (arg)
      +			strvec_push(&cp.args, arg);
     -+		else
     ++	} else if (command) {
     ++		strbuf_addstr(&cmd, command);
     ++		strvec_push(&cp.args, cmd.buf);
     ++		if (arg)
      +			strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
      +	}
       	cp.env = local_repo_env;
       	cp.no_stdin = 1;
       	cp.use_shell = 1;
     +@@ trailer.c: static char *apply_command(const char *command, const char *arg)
     + 
     + static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
     + {
     +-	if (arg_tok->conf.command) {
     ++	if (arg_tok->conf.command || arg_tok->conf.cmd) {
     + 		const char *arg;
     + 		if (arg_tok->value && arg_tok->value[0]) {
     + 			arg = arg_tok->value;
      @@ trailer.c: static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
       			else
       				arg = xstrdup("");
       		}
      -		arg_tok->value = apply_command(arg_tok->conf.command, arg);
     -+		arg_tok->value = apply_command(arg_tok->conf.command, arg_tok->conf.is_new_cmd, arg);
     ++		arg_tok->value = apply_command(arg_tok->conf.command, arg_tok->conf.cmd, arg);
       		free((char *)arg);
       	}
       }
     +@@ trailer.c: static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
     + 	dst->name = xstrdup_or_null(src->name);
     + 	dst->key = xstrdup_or_null(src->key);
     + 	dst->command = xstrdup_or_null(src->command);
     ++	dst->cmd = xstrdup_or_null(src->cmd);
     + }
     + 
     + static struct arg_item *get_conf_item(const char *name)
      @@ trailer.c: static struct arg_item *get_conf_item(const char *name)
       	return item;
       }
     @@ trailer.c: static struct {
       	{ "ifexists", TRAILER_IF_EXISTS },
       	{ "ifmissing", TRAILER_IF_MISSING }
      @@ trailer.c: static int git_trailer_config(const char *conf_key, const char *value, void *cb)
     - 	case TRAILER_COMMAND:
     - 		if (conf->command)
       			warning(_("more than one %s"), conf_key);
     -+		conf->is_new_cmd = 0;
     -+		conf->command = xstrdup(value);
     -+		break;
     -+	case TRAILER_CMD:
     -+		if (conf->command)
     -+			warning(_("more than one %s"), conf_key);
     -+		conf->is_new_cmd = 1;
       		conf->command = xstrdup(value);
       		break;
     ++	case TRAILER_CMD:
     ++		if (conf->cmd)
     ++			warning(_("more than one %s"), conf_key);
     ++		conf->cmd = xstrdup(value);
     ++		break;
       	case TRAILER_WHERE:
     + 		if (trailer_set_where(&conf->where, value))
     + 			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
     +@@ trailer.c: static void process_command_line_args(struct list_head *arg_head,
     + 	/* Add an arg item for each configured trailer with a command */
     + 	list_for_each(pos, &conf_head) {
     + 		item = list_entry(pos, struct arg_item, list);
     +-		if (item->conf.command)
     ++		if (item->conf.cmd || item->conf.command)
     + 			add_arg_item(arg_head,
     + 				     xstrdup(token_from_item(item, NULL)),
     + 				     xstrdup(""),


 Documentation/git-interpret-trailers.txt | 10 ++++++
 t/t7513-interpret-trailers.sh            | 43 +++++++++++++++++++++++-
 trailer.c                                | 37 ++++++++++++++------
 3 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f001..f796041514bf 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -252,6 +252,16 @@ also be executed for each of these arguments. And the <value> part of
 these arguments, if any, will be used to replace the `$ARG` string in
 the command.
 
+trailer.<token>.cmd::
+	Similar to 'trailer.<token>.command'. But the difference is that
+	`$1` is used in the command to replace the value of the trailer
+	instead of the original `$ARG`, which means that we can pass the
+	trailer value multiple times in the command.
+	E.g. `git config trailer.sign.cmd "test -n \"$1\" && echo \"$1\" || true "`.
+	If the user has these two configuration: "trailer.<token>.cmd"
+	and "trailer.<token>.command", "cmd" will be executed and "command"
+	will not be executed.
+
 EXAMPLES
 --------
 
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6602790b5f4c..059beec0c0de 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1274,9 +1274,50 @@ test_expect_success 'setup a commit' '
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
index be4e9726421c..634d3f1ff04a 100644
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
@@ -216,18 +218,24 @@ static int check_if_different(struct trailer_item *in_tok,
 	return 1;
 }
 
-static char *apply_command(const char *command, const char *arg)
+static char *apply_command(const char *command, const char *cmd_, const char *arg)
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
+	if (cmd_) {
+		strbuf_addstr(&cmd, cmd_);
+		strvec_push(&cp.args, cmd.buf);
+		if (arg)
+			strvec_push(&cp.args, arg);
+	} else if (command) {
+		strbuf_addstr(&cmd, command);
+		strvec_push(&cp.args, cmd.buf);
+		if (arg)
+			strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
+	}
 	cp.env = local_repo_env;
 	cp.no_stdin = 1;
 	cp.use_shell = 1;
@@ -247,7 +255,7 @@ static char *apply_command(const char *command, const char *arg)
 
 static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
 {
-	if (arg_tok->conf.command) {
+	if (arg_tok->conf.command || arg_tok->conf.cmd) {
 		const char *arg;
 		if (arg_tok->value && arg_tok->value[0]) {
 			arg = arg_tok->value;
@@ -257,7 +265,7 @@ static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
 			else
 				arg = xstrdup("");
 		}
-		arg_tok->value = apply_command(arg_tok->conf.command, arg);
+		arg_tok->value = apply_command(arg_tok->conf.command, arg_tok->conf.cmd, arg);
 		free((char *)arg);
 	}
 }
@@ -430,6 +438,7 @@ static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
 	dst->name = xstrdup_or_null(src->name);
 	dst->key = xstrdup_or_null(src->key);
 	dst->command = xstrdup_or_null(src->command);
+	dst->cmd = xstrdup_or_null(src->cmd);
 }
 
 static struct arg_item *get_conf_item(const char *name)
@@ -454,8 +463,8 @@ static struct arg_item *get_conf_item(const char *name)
 	return item;
 }
 
-enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_WHERE,
-			 TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
+enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_CMD,
+			TRAILER_WHERE, TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
 
 static struct {
 	const char *name;
@@ -463,6 +472,7 @@ static struct {
 } trailer_config_items[] = {
 	{ "key", TRAILER_KEY },
 	{ "command", TRAILER_COMMAND },
+	{ "cmd", TRAILER_CMD },
 	{ "where", TRAILER_WHERE },
 	{ "ifexists", TRAILER_IF_EXISTS },
 	{ "ifmissing", TRAILER_IF_MISSING }
@@ -542,6 +552,11 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
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
@@ -708,7 +723,7 @@ static void process_command_line_args(struct list_head *arg_head,
 	/* Add an arg item for each configured trailer with a command */
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct arg_item, list);
-		if (item->conf.command)
+		if (item->conf.cmd || item->conf.command)
 			add_arg_item(arg_head,
 				     xstrdup(token_from_item(item, NULL)),
 				     xstrdup(""),

base-commit: 142430338477d9d1bb25be66267225fb58498d92
-- 
gitgitgadget
