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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC44FC433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 15:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BE2619FF
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 15:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhCXPmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbhCXPmk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 11:42:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A28C061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 08:42:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so1452087wmj.1
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=VNnvW9uqT+FQSQEz32ZB83NGuLXWwCwVisK9xLBby1g=;
        b=iwPbWHSuiKDLD3ewbkA/cz5OfMZqbzF6qyTxafiAwV9g61kdaEadObIgr43wKD6Gpi
         2WKYuygRqWMd+68FUO6tf6VZ4KaCQT2wtgIBnFtADGOBAF5w/u68FGHSA5RvEQ+NMbf/
         /NQJrzpkCi4fTckFBAu+OukRmipdp2XeaV2OZPdCrryuO5LYnv2sAaHZoMx85IVCJ5YN
         2gdyep1HPQBeYJPZm4Ky32yKPtwM5puCknJM71v1KzegrtE/UjaLbdbr8fNIIeC0C9yS
         ldM2oi5LNCNZv2RQsqS8y9oGA0n/rDUCannTUSb5PyA6A060jSdOpxM4wjk9D/yWlXV8
         MYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=VNnvW9uqT+FQSQEz32ZB83NGuLXWwCwVisK9xLBby1g=;
        b=NnNmxjhTja07jp9PWwVZwil25RGuLRSgD2aLLAfGBtHad/6FqvhuPd33GMJEa66mXn
         roDxfUx4dGskqoNbuu5d6jcSoybUMtcMZdSzIBlWItBSeM6d03U4s9BzK5qp8TPs5qVx
         jTQogYJbgU97xuXPIVi5ch/OFueAF28+g5bAxxffxJlS+EGEJcO1UK+sU5+pH5lwOKPD
         GkmOBeFaq/BI0K9YVFsRviQH+zxtaal0lp1QmvfFSvjUFvvCjJKEl0rkE37IEpEsL9Kx
         fzhk9bke9GKQ/dRYUHmEn+CMeyHSWGnZ8nbTvqw9B8UD3UwH+m5gaFiLe8EU30Gm4FGt
         8z5Q==
X-Gm-Message-State: AOAM533Gp3dWyE7JmjUWgGWTFudOW2gikUGRdyjWSsly86nivztosa4B
        GI7FemNSs3aIrfrwQmrQAK4SXH9LU5M=
X-Google-Smtp-Source: ABdhPJz/0Jh1KDufzCem2Kp/j6nT97QsMtJMTomurBQnziy0CCJGKM21zNjL3QckWxysCOknD0PFtQ==
X-Received: by 2002:a1c:4d09:: with SMTP id o9mr3519841wmh.15.1616600558274;
        Wed, 24 Mar 2021 08:42:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4sm3728856wrx.86.2021.03.24.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:42:37 -0700 (PDT)
Message-Id: <pull.913.v2.git.1616600555906.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.git.1616511182942.gitgitgadget@gmail.com>
References: <pull.913.git.1616511182942.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 15:42:35 +0000
Subject: [PATCH v2] [GSOC]trailer: pass arg as positional parameter
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

In the original implementation of `trailer.<token>.command`,
use `strbuf_replace` to replace $ARG in the <value> of the
trailer, but it have a problem: `strbuf_replace` replace the
$ARG in command only once, If the user's trailer command have
used more than one $ARG, error will occur.

If directly modify the implementation of the original
`trailer.<token>.command`, The user’s previous `'$ARG'` in
trailer command will not be replaced. So now add new
config "trailer.<token>.cmd", pass trailer's value as
positional parameter 1 to the user's command, users can
use $1 as trailer's value, to implement original variable
replacement.

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/913

Range-diff vs v1:

 1:  abc5b04d152f ! 1:  185356d6fc90 [GSOC]trailer: change $ARG to environment variable
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC]trailer: change $ARG to environment variable
     +    [GSOC]trailer: pass arg as positional parameter
      
          In the original implementation of `trailer.<token>.command`,
     -    use `strbuf_replace` to replace `$ARG` in the <value> of the trailer,
     -    but it have a problem:`strbuf_replace` replace the `$ARG` in command
     -    only once, If the user's trailer command have used more then one `$ARG`,
     -    error will occur.
     +    use `strbuf_replace` to replace $ARG in the <value> of the
     +    trailer, but it have a problem: `strbuf_replace` replace the
     +    $ARG in command only once, If the user's trailer command have
     +    used more than one $ARG, error will occur.
      
     -    So pass `$ARG` as an environment variable to the trailer command,
     -    all `$ARG` in the command will be replaced, which will fix this problem.
     +    If directly modify the implementation of the original
     +    `trailer.<token>.command`, The user’s previous `'$ARG'` in
     +    trailer command will not be replaced. So now add new
     +    config "trailer.<token>.cmd", pass trailer's value as
     +    positional parameter 1 to the user's command, users can
     +    use $1 as trailer's value, to implement original variable
     +    replacement.
     +
     +    Original `trailer.<token>.command` can still be used until git
     +    completely abandoned it.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## Documentation/git-interpret-trailers.txt ##
     -@@ Documentation/git-interpret-trailers.txt: line, where <value> is taken to be the standard output of the
     - specified command with any leading and trailing whitespace trimmed
     - off.
     - +
     --If the command contains the `$ARG` string, this string will be
     -+If the command contains the `$ARG` string (`$ARG` is an exported
     -+environment variable), this string will be
     - replaced with the <value> part of an existing trailer with the same
     - <token>, if any, before the command is launched.
     - +
     +@@ Documentation/git-interpret-trailers.txt: also be executed for each of these arguments. And the <value> part of
     + these arguments, if any, will be used to replace the `$ARG` string in
     + the command.
     + 
     ++trailer.<token>.cmd::
     ++	Similar to 'trailer.<token>.command'. But the difference is that
     ++	`$1` is used in the command to replace the value of the trailer
     ++	instead of the original `$ARG`, which means that we can quote the
     ++	trailer value multiple times in the command.
     ++	E.g. `trailer.sign.cmd="test -n \"$1\" && echo \"$1\" || true "`
     ++
     + EXAMPLES
     + --------
     + 
      
       ## t/t7513-interpret-trailers.sh ##
     -@@ t/t7513-interpret-trailers.sh: test_expect_success 'with command using $ARG' '
     - 	test_cmp expected actual
     +@@ t/t7513-interpret-trailers.sh: test_expect_success 'setup a commit' '
     + 	git commit -m "Add file a.txt"
       '
       
     -+test_expect_success 'with command using more than one $ARG' '
     ++test_expect_success 'with cmd using $1' '
     ++	test_when_finished "git config --unset trailer.fix.cmd" &&
      +	git config trailer.fix.ifExists "replace" &&
     -+	git config trailer.fix.command "test -n $ARG && git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG || true" &&
     ++	git config trailer.fix.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%s)\" \
     ++		--abbrev-commit --abbrev=14 \"\$1\" || true" &&
      +	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
     -+	cat complex_message_body >expected &&
     -+	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
     ++	cat complex_message_body >expected2 &&
     ++	sed -e "s/ Z\$/ /" >>expected2 <<-EOF &&
      +		Fixes: $FIXED
      +		Acked-by= Z
      +		Reviewed-by:
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'with command using $ARG' '
      +		Signed-off-by: A U Thor <author@example.com>
      +	EOF
      +	git interpret-trailers --trailer "review:" --trailer "fix=HEAD" \
     -+		<complex_message >actual &&
     -+	test_cmp expected actual
     ++		<complex_message >actual2 &&
     ++	test_cmp expected2 actual2
      +'
      +
     - test_expect_success 'with failing command using $ARG' '
     + test_expect_success 'with command using $ARG' '
       	git config trailer.fix.ifExists "replace" &&
     - 	git config trailer.fix.command "false \$ARG" &&
     +-	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
     ++	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" \
     ++		--abbrev-commit --abbrev=14 \$ARG" &&
     + 	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
     + 	cat complex_message_body >expected &&
     + 	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
      
       ## trailer.c ##
     -@@ trailer.c: static char *separators = ":";
     - 
     - static int configured;
     - 
     --#define TRAILER_ARG_STRING "$ARG"
     -+#define TRAILER_ARG_STRING "ARG"
     +@@ trailer.c: struct conf_info {
     + 	char *name;
     + 	char *key;
     + 	char *command;
     ++	int is_new_cmd;
     + 	enum trailer_where where;
     + 	enum trailer_if_exists if_exists;
     + 	enum trailer_if_missing if_missing;
     +@@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
     + 	return 1;
     + }
       
     - static const char *git_generated_prefixes[] = {
     - 	"Signed-off-by: ",
     -@@ trailer.c: static char *apply_command(const char *command, const char *arg)
     +-static char *apply_command(const char *command, const char *arg)
     ++static char *apply_command(const char *command, int is_new_cmd , const char *arg)
     + {
     + 	struct strbuf cmd = STRBUF_INIT;
       	struct strbuf buf = STRBUF_INIT;
     - 	struct child_process cp = CHILD_PROCESS_INIT;
     +@@ trailer.c: static char *apply_command(const char *command, const char *arg)
       	char *result;
     -+	const char *const *var;
       
       	strbuf_addstr(&cmd, command);
     -+	for (var = local_repo_env; *var; var++)
     -+		strvec_push(&cp.env_array, *var);
     - 	if (arg)
     +-	if (arg)
      -		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
     -+		strvec_pushf(&cp.env_array, "%s=%s", TRAILER_ARG_STRING, arg);
     - 
     +-
       	strvec_push(&cp.args, cmd.buf);
     --	cp.env = local_repo_env;
     -+
     ++	if (arg) {
     ++		if (is_new_cmd)
     ++			strvec_push(&cp.args, arg);
     ++		else
     ++			strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
     ++	}
     + 	cp.env = local_repo_env;
       	cp.no_stdin = 1;
       	cp.use_shell = 1;
     +@@ trailer.c: static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
     + 			else
     + 				arg = xstrdup("");
     + 		}
     +-		arg_tok->value = apply_command(arg_tok->conf.command, arg);
     ++		arg_tok->value = apply_command(arg_tok->conf.command, arg_tok->conf.is_new_cmd, arg);
     + 		free((char *)arg);
     + 	}
     + }
     +@@ trailer.c: static struct arg_item *get_conf_item(const char *name)
     + 	return item;
     + }
     + 
     +-enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_WHERE,
     +-			 TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
     ++enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_CMD,
     ++			TRAILER_WHERE, TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
       
     + static struct {
     + 	const char *name;
     +@@ trailer.c: static struct {
     + } trailer_config_items[] = {
     + 	{ "key", TRAILER_KEY },
     + 	{ "command", TRAILER_COMMAND },
     ++	{ "cmd", TRAILER_CMD },
     + 	{ "where", TRAILER_WHERE },
     + 	{ "ifexists", TRAILER_IF_EXISTS },
     + 	{ "ifmissing", TRAILER_IF_MISSING }
     +@@ trailer.c: static int git_trailer_config(const char *conf_key, const char *value, void *cb)
     + 	case TRAILER_COMMAND:
     + 		if (conf->command)
     + 			warning(_("more than one %s"), conf_key);
     ++		conf->is_new_cmd = 0;
     ++		conf->command = xstrdup(value);
     ++		break;
     ++	case TRAILER_CMD:
     ++		if (conf->command)
     ++			warning(_("more than one %s"), conf_key);
     ++		conf->is_new_cmd = 1;
     + 		conf->command = xstrdup(value);
     + 		break;
     + 	case TRAILER_WHERE:


 Documentation/git-interpret-trailers.txt |  7 +++++++
 t/t7513-interpret-trailers.sh            | 22 +++++++++++++++++++-
 trailer.c                                | 26 +++++++++++++++++-------
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f001..38656b1b3841 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -252,6 +252,13 @@ also be executed for each of these arguments. And the <value> part of
 these arguments, if any, will be used to replace the `$ARG` string in
 the command.
 
+trailer.<token>.cmd::
+	Similar to 'trailer.<token>.command'. But the difference is that
+	`$1` is used in the command to replace the value of the trailer
+	instead of the original `$ARG`, which means that we can quote the
+	trailer value multiple times in the command.
+	E.g. `trailer.sign.cmd="test -n \"$1\" && echo \"$1\" || true "`
+
 EXAMPLES
 --------
 
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6602790b5f4c..7cb81201442a 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1274,9 +1274,29 @@ test_expect_success 'setup a commit' '
 	git commit -m "Add file a.txt"
 '
 
+test_expect_success 'with cmd using $1' '
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
 test_expect_success 'with command using $ARG' '
 	git config trailer.fix.ifExists "replace" &&
-	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
+	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" \
+		--abbrev-commit --abbrev=14 \$ARG" &&
 	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
diff --git a/trailer.c b/trailer.c
index be4e9726421c..80f47657ff1a 100644
--- a/trailer.c
+++ b/trailer.c
@@ -14,6 +14,7 @@ struct conf_info {
 	char *name;
 	char *key;
 	char *command;
+	int is_new_cmd;
 	enum trailer_where where;
 	enum trailer_if_exists if_exists;
 	enum trailer_if_missing if_missing;
@@ -216,7 +217,7 @@ static int check_if_different(struct trailer_item *in_tok,
 	return 1;
 }
 
-static char *apply_command(const char *command, const char *arg)
+static char *apply_command(const char *command, int is_new_cmd , const char *arg)
 {
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
@@ -224,10 +225,13 @@ static char *apply_command(const char *command, const char *arg)
 	char *result;
 
 	strbuf_addstr(&cmd, command);
-	if (arg)
-		strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
-
 	strvec_push(&cp.args, cmd.buf);
+	if (arg) {
+		if (is_new_cmd)
+			strvec_push(&cp.args, arg);
+		else
+			strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
+	}
 	cp.env = local_repo_env;
 	cp.no_stdin = 1;
 	cp.use_shell = 1;
@@ -257,7 +261,7 @@ static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
 			else
 				arg = xstrdup("");
 		}
-		arg_tok->value = apply_command(arg_tok->conf.command, arg);
+		arg_tok->value = apply_command(arg_tok->conf.command, arg_tok->conf.is_new_cmd, arg);
 		free((char *)arg);
 	}
 }
@@ -454,8 +458,8 @@ static struct arg_item *get_conf_item(const char *name)
 	return item;
 }
 
-enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_WHERE,
-			 TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
+enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_CMD,
+			TRAILER_WHERE, TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
 
 static struct {
 	const char *name;
@@ -463,6 +467,7 @@ static struct {
 } trailer_config_items[] = {
 	{ "key", TRAILER_KEY },
 	{ "command", TRAILER_COMMAND },
+	{ "cmd", TRAILER_CMD },
 	{ "where", TRAILER_WHERE },
 	{ "ifexists", TRAILER_IF_EXISTS },
 	{ "ifmissing", TRAILER_IF_MISSING }
@@ -540,6 +545,13 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
 	case TRAILER_COMMAND:
 		if (conf->command)
 			warning(_("more than one %s"), conf_key);
+		conf->is_new_cmd = 0;
+		conf->command = xstrdup(value);
+		break;
+	case TRAILER_CMD:
+		if (conf->command)
+			warning(_("more than one %s"), conf_key);
+		conf->is_new_cmd = 1;
 		conf->command = xstrdup(value);
 		break;
 	case TRAILER_WHERE:

base-commit: 142430338477d9d1bb25be66267225fb58498d92
-- 
gitgitgadget
