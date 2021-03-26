Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C48C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 16:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA6961931
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 16:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhCZQNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 12:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhCZQNK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 12:13:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A606C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 09:13:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so3287168wmj.2
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hZtLXCG0r9uP80UlO5RtzzfeWz91Ak12le2VJMzHfz8=;
        b=MNyt8P5U/ERCha6K1fSrXI+TWZp4RjBJylRtjcbc357uEFXMBreyZOwMS6GRnImDmx
         yarPw/VXhqImJQ5J7sefSKm1SfDMbFyIm+SIaUmCjqPjZQuWPSH4lnxchDSSuaT7kn2K
         ngvQFEscg/aSUnDHiFo39wWjnaFhEMzdB6lL4GkG7U/E0rFQQ6wAT20T+81uO9/0d+4A
         M8+riYrEqtQrhXB9aQXqmawBMpCoMITTwyAAaFWnTzhcojkMqp8X8+hOUvSgwQyciS3P
         Fcr4wFzHpYNHcsDrSPfdwUqLlDOp2DYrqk3KEtgpboaB1Ah/4kLYT/28q51uCDmq4RW1
         R6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hZtLXCG0r9uP80UlO5RtzzfeWz91Ak12le2VJMzHfz8=;
        b=GMVCfWdp2jqeXC78VDsBDG5hw90OvpE9b7n+ud33b+GAy1DcGMO8extgyV66zbMAP4
         w+4qtDmml3wxgPNbzeM3+qqsZWLKYj4e2eW6dLkoLoE/lnAvxLC8z/89ZPgC1Intrv4/
         X73mauO//0o2xy19FVe/yyDlErp3LJcAVVNpTNdlE41hqVWGZlGo6RzoR1cpTVvaAxpi
         CEOYgZIOtovMviWUssSF0mvIuPq2JBL+HmS1e4K8/EBMUt/VUFxJ7awQXkpLNYq5qxpo
         +P5gLjQriQYmcbuGh3+zhJBXTusvioSMEaiIPikSUyMAM3FM5jtm/blfh5k2uNo1EEyk
         F1jg==
X-Gm-Message-State: AOAM532rlpD+SQ9gR0I9oyyB++uFpnI/uIpRggZ7X7tvfmjKlLNgjq3U
        fnC2vae6RMwURs2/4zfN2QMmcGWRWIc=
X-Google-Smtp-Source: ABdhPJzfH1gT/mSQrrA+QCFp2hYGtVxwHRVJP96VSRGAwzkeZ5mgH3+B4O3D+fDWwEpAmHbRhGMgQQ==
X-Received: by 2002:a7b:c214:: with SMTP id x20mr13906585wmi.186.1616775186922;
        Fri, 26 Mar 2021 09:13:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v18sm13592391wru.85.2021.03.26.09.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 09:13:06 -0700 (PDT)
Message-Id: <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 16:13:05 +0000
Subject: [PATCH v4] [GSOC]trailer: pass arg as positional parameter
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
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC]trailer: pass arg as positional parameter
    
    In https://lore.kernel.org/git/xmqqv99i4ck2.fsf@gitster.g/ Junio and
    Christian talked about the problem of using strbuf_replace() to replace
    $ARG.
    
    Now pass trailer value as $1 to the trailer command with another
    trailer.<token>.cmd config.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/913

Range-diff vs v3:

 1:  b268ecd7b395 ! 1:  e2bbdcb943c2 [GSOC]trailer: pass arg as positional parameter
     @@ Metadata
       ## Commit message ##
          [GSOC]trailer: pass arg as positional parameter
      
     -    Original implementation of `trailer.<token>.command` use
     -    `strbuf_replace` to replace $ARG in command with the <value>
     -    of the trailer, but it have a problem: `strbuf_replace`
     -    replace the $ARG only once, If the user's trailer command
     -    have used more than one $ARG, the remaining replacement will
     -    fail.
     +    The `trailer.<token>.command` configuration variable
     +    specifies a command (run via the shell, so it does not have
     +    to be a single name of or path to the command, but can be a
     +    shell script), and the first occurrence of substring $ARG is
     +    replaced with the value given to the `interpret-trailer`
     +    command for the token.  This has two downsides:
      
     -    If directly modify the implementation of the original
     -    `trailer.<token>.command`, The user’s previous `'$ARG'` in
     -    trailer command will not be replaced. So now add new config
     -    "trailer.<token>.cmd", pass trailer's value as positional
     -    parameter 1 to the user's command, the user can use $1 as
     -    trailer's value, to implement original variable replacement.
     +    * The use of $ARG in the mechanism misleads the users that
     +    the value is passed in the shell variable, and tempt them
     +    to use $ARG more than once, but that would not work, as
     +    the second and subsequent $ARG are not replaced.
      
     -    If the user has these two configuration: "trailer.<token>.cmd"
     -    and "trailer.<token>.command", "cmd" will execute and "command"
     -    will not executed.
     +    * Because $ARG is textually replaced without regard to the
     +    shell language syntax, even '$ARG' (inside a single-quote
     +    pair), which a user would expect to stay intact, would be
     +    replaced, and worse, if the value had an unmatching single
     +    quote (imagine a name like "O'Connor", substituted into
     +    NAME='$ARG' to make it NAME='O'Connor), it would result in
     +    a broken command that is not syntactically correct (or
     +    worse).
      
     -    Original `trailer.<token>.command` can still be used until git
     -    completely abandoned it.
     +    Introduce a new `trailer.<token>.cmd` configuration that
     +    takes higher precedence to deprecate and eventually remove
     +    `trailer.<token>.command`, which passes the value as a
     +    parameter to the command.  Instead of "$ARG", the users will
     +    refer to the value as positional argument, $1, in their
     +    scripts.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## Documentation/git-interpret-trailers.txt ##
     @@ Documentation/git-interpret-trailers.txt: also be executed for each of these arg
       the command.
       
      +trailer.<token>.cmd::
     -+	Similar to 'trailer.<token>.command'. But the difference is that
     -+	`$1` is used in the command to replace the value of the trailer
     -+	instead of the original `$ARG`, which means that we can pass the
     -+	trailer value multiple times in the command.
     -+	E.g. `git config trailer.sign.cmd "test -n \"$1\" && echo \"$1\" || true "`.
     -+	If the user has these two configuration: "trailer.<token>.cmd"
     -+	and "trailer.<token>.command", "cmd" will be executed and "command"
     -+	will not be executed.
     ++	The command specified by this configuration variable is run
     ++	with a single parameter, which is the <value> part of an
     ++	existing trailer with the same <token>.  The output from the
     ++	command is then used as the value for the <token> in the
     ++	resulting trailer.
     ++	The command is expected to replace `trailer.<token>.cmd`.
     ++	When both .cmd and .command are given for the same <token>,
     ++        .cmd is used and .command is ignored.
      +
       EXAMPLES
       --------
       
     +@@ Documentation/git-interpret-trailers.txt: $ git format-patch -1
     + $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Reviewed-by: Bob <bob@example.com>' 0001-foo.patch >0001-bar.patch
     + ------------
     + 
     +-* Configure a 'sign' trailer with a command to automatically add a
     ++* Configure a 'sign' trailer with a cmd to automatically add a
     +   'Signed-off-by: ' with the author information only if there is no
     +   'Signed-off-by: ' already, and show how it works:
     + +
     +@@ Documentation/git-interpret-trailers.txt: $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
     + $ git config trailer.sign.key "Signed-off-by: "
     + $ git config trailer.sign.ifmissing add
     + $ git config trailer.sign.ifexists doNothing
     +-$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
     ++$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
     + $ git interpret-trailers <<EOF
     + > EOF
     + 
     +@@ Documentation/git-interpret-trailers.txt: subject
     + Fix #42
     + ------------
     + 
     +-* Configure a 'see' trailer with a command to show the subject of a
     ++* Configure a 'see' trailer with a cmd to show the subject of a
     +   commit that is related, and show how it works:
     + +
     + ------------
     + $ git config trailer.see.key "See-also: "
     + $ git config trailer.see.ifExists "replace"
     + $ git config trailer.see.ifMissing "doNothing"
     +-$ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
     ++$ git config trailer.see.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \"\$1\"|| true "
     + $ git interpret-trailers <<EOF
     + > subject
     + > 
      
       ## t/t7513-interpret-trailers.sh ##
      @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup a commit' '
     @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
       }
       
      -static char *apply_command(const char *command, const char *arg)
     -+static char *apply_command(const char *command, const char *cmd_, const char *arg)
     ++static char *apply_command(struct conf_info *conf, const char *arg)
       {
       	struct strbuf cmd = STRBUF_INIT;
       	struct strbuf buf = STRBUF_INIT;
     @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
      -		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
      -
      -	strvec_push(&cp.args, cmd.buf);
     -+	if (cmd_) {
     -+		strbuf_addstr(&cmd, cmd_);
     ++	if (conf->cmd) {
     ++		strbuf_addstr(&cmd, conf->cmd);
      +		strvec_push(&cp.args, cmd.buf);
      +		if (arg)
      +			strvec_push(&cp.args, arg);
     -+	} else if (command) {
     -+		strbuf_addstr(&cmd, command);
     ++	} else if (conf->command) {
     ++		strbuf_addstr(&cmd, conf->command);
      +		strvec_push(&cp.args, cmd.buf);
      +		if (arg)
      +			strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
     @@ trailer.c: static void apply_item_command(struct trailer_item *in_tok, struct ar
       				arg = xstrdup("");
       		}
      -		arg_tok->value = apply_command(arg_tok->conf.command, arg);
     -+		arg_tok->value = apply_command(arg_tok->conf.command, arg_tok->conf.cmd, arg);
     ++		arg_tok->value = apply_command(&arg_tok->conf, arg);
       		free((char *)arg);
       	}
       }


 Documentation/git-interpret-trailers.txt | 18 +++++++---
 t/t7513-interpret-trailers.sh            | 43 +++++++++++++++++++++++-
 trailer.c                                | 37 ++++++++++++++------
 3 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f001..b73f9c8d71eb 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -252,6 +252,16 @@ also be executed for each of these arguments. And the <value> part of
 these arguments, if any, will be used to replace the `$ARG` string in
 the command.
 
+trailer.<token>.cmd::
+	The command specified by this configuration variable is run
+	with a single parameter, which is the <value> part of an
+	existing trailer with the same <token>.  The output from the
+	command is then used as the value for the <token> in the
+	resulting trailer.
+	The command is expected to replace `trailer.<token>.cmd`.
+	When both .cmd and .command are given for the same <token>,
+        .cmd is used and .command is ignored.
+
 EXAMPLES
 --------
 
@@ -301,7 +311,7 @@ $ git format-patch -1
 $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Reviewed-by: Bob <bob@example.com>' 0001-foo.patch >0001-bar.patch
 ------------
 
-* Configure a 'sign' trailer with a command to automatically add a
+* Configure a 'sign' trailer with a cmd to automatically add a
   'Signed-off-by: ' with the author information only if there is no
   'Signed-off-by: ' already, and show how it works:
 +
@@ -309,7 +319,7 @@ $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
 $ git config trailer.sign.key "Signed-off-by: "
 $ git config trailer.sign.ifmissing add
 $ git config trailer.sign.ifexists doNothing
-$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
+$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
 $ git interpret-trailers <<EOF
 > EOF
 
@@ -333,14 +343,14 @@ subject
 Fix #42
 ------------
 
-* Configure a 'see' trailer with a command to show the subject of a
+* Configure a 'see' trailer with a cmd to show the subject of a
   commit that is related, and show how it works:
 +
 ------------
 $ git config trailer.see.key "See-also: "
 $ git config trailer.see.ifExists "replace"
 $ git config trailer.see.ifMissing "doNothing"
-$ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
+$ git config trailer.see.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \"\$1\"|| true "
 $ git interpret-trailers <<EOF
 > subject
 > 
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
index be4e9726421c..278e40974a4c 100644
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
+		arg_tok->value = apply_command(&arg_tok->conf, arg);
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
