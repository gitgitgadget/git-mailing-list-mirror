Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43357C43461
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D80610E5
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhDINiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhDINh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 09:37:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1985DC061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 06:37:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f12so5726001wro.0
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uH+loQO2oEzf41cgXL05sa0Fu/3ZTLIQMiec0JtoFyc=;
        b=qtRRqJKxXfrsMf5fzrFFmDxy5nw241Z3OHZmS13cbTgNGYBG3LzkVLu6lEqBlvlDeJ
         lH7asNWLZtA5mmX8mcbvAVdoCZVHjdfHNSS5XEKToEcotuzeX0EAc/Haa7ClUWy8C7cT
         48l5udMaAt0M7DuxttwBGDTwbo728eeLWir7AfBJiIhQuT61qZ8Pm+O1kWaYxNeqH0AK
         7F+0S80dTlPjR0/q0OxMJqixBsj6odOgKrA64Mz2bTvXHCHw2ecjlhUt+q387OllL+i3
         40d8wFeazqbC7ybKp/zoLrWKVa47rLhlYM0clIQzMxNmCm7apztzFfqLlbV8KcbR+dpv
         8G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uH+loQO2oEzf41cgXL05sa0Fu/3ZTLIQMiec0JtoFyc=;
        b=OCt/XhuD2qrvtEXuC0GUEzp3eVS9M1huBjXvQ16KE7mmt1py9jizsaNWzMrwnizY5c
         RpyhyleUp4tYrsF52JipJ3imw1zcvp1RfStRDG7oRyyRfOahK7X6G6LuCl9648K4yGG8
         uWL0oaiBENramtM93oueI1a5E7c0rJKhx/u+khkoxTOoob1vupZxayce+TmMQ42HCmnr
         OFLlIM0eGE1Rt9/N1Vb0Kh4GGO3/XNfVyTtpx7iOX80jzErPiRBWwOGyIBEJfgzh4XSF
         0PakQsiS9soUNAKpn4E15JS09YNDCmGUmsWM07MxSZ551USi6yzij0yLS1UunFXEUYgy
         3MbQ==
X-Gm-Message-State: AOAM5300tYGcKpEbrtNGUX2llhWB0QPb1nujx/mFf7Majzp9UL4oKCs/
        pSWRkb0otY3dDhirlr/SWXTDwSLPpMI=
X-Google-Smtp-Source: ABdhPJyqKvY8/srxF+CLjiDE2sCWMCLampBIpc9ExS6Wyp2WRlQ3F+y2VfAv1uMqQvh4ZPqkIhBljA==
X-Received: by 2002:adf:fccd:: with SMTP id f13mr10367685wrs.222.1617975464685;
        Fri, 09 Apr 2021 06:37:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14sm5080135wrq.45.2021.04.09.06.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:37:44 -0700 (PDT)
Message-Id: <3dc8983a47020fb417bb8c6c3d835e609b13c155.1617975462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
References: <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com>
        <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 13:37:42 +0000
Subject: [PATCH v8 2/2] [GSOC] trailer: add new .cmd config option
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
replaced, and worse, if the value had an unmatched single
quote (imagine a name like "O'Connor", substituted into
NAME='$ARG' to make it NAME='O'Connor'), it would result in
a broken command that is not syntactically correct (or
worse).

Introduce a new `trailer.<token>.cmd` configuration that
takes higher precedence to deprecate and eventually remove
`trailer.<token>.command`, which passes the value as an
argument to the command.  Instead of "$ARG", users can
refer to the value as positional argument, $1, in their
scripts.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-interpret-trailers.txt | 90 ++++++++++++++++++++----
 t/t7513-interpret-trailers.sh            | 84 ++++++++++++++++++++++
 trailer.c                                | 37 +++++++---
 3 files changed, 187 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 3e5aa3a65ae9..1a874a93f49b 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -236,21 +236,38 @@ trailer.<token>.command::
 	be called to automatically add or modify a trailer with the
 	specified <token>.
 +
-When this option is specified, the behavior is as if a special
-'--trailer <token>=<value>' argument was added at the beginning of
-the "git interpret-trailers" command, where <value> is taken to be the
-standard output of the specified command with any leading and trailing
-whitespace trimmed off.
+When this option is specified, the first occurrence of substring $ARG is
+replaced with the value given to the `interpret-trailer` command for the
+same token. It passes the value through `$ARG`, otherwise this option behaves
+in the same way as 'trailer.<token>.cmd'.
++
+The 'trailer.<token>.command' option has been deprecated due to the fact
+that $ARG in the user's command can only be replaced once and that the
+original way of replacing $ARG was not safe. Now the preferred option is
+'trailer.<token>.cmd', which uses a positional argument to pass the value.
 +
-The first occurrence of substring `$ARG` will be replaced with the
-<value> part of an existing trailer with the same <token>, if any,
-before the command is launched.
+When both 'trailer.<token>.cmd' and 'trailer.<token>.command' are given
+for the same <token>, 'trailer.<token>.cmd' is used and
+'trailer.<token>.command' is ignored.
+
+trailer.<token>.cmd::
+	The command specified by this configuration variable is run
+	with a single argument, which is the <value> part of a
+	`--trailer <token>=<value>` on the command line. The output
+	from the command is then used as the value for the <token>
+	in the resulting trailer.
++
+When this option is specified, the behavior is as if a
+'--trailer <token>=<value>' argument was added at the beginning of
+the "git interpret-trailers" command, the command specified by this
+configuration variable will be called with an empty string as the
+argument.
 +
-If some '<token>=<value>' arguments are also passed on the command
-line, when a 'trailer.<token>.command' is configured, the command is run
-once for each these arguments with the same <token>. And the <value>
-part of these arguments, if any, will be used to replace the first `$ARG`
-string in the command.
+If some '--trailer <token>=<value>' arguments are also passed on the
+command line, when a 'trailer.<token>.cmd' is configured, the command
+is run once for each `--trailer <token>=<value>` on the command line
+with the same <token>. And the <value> part of these arguments, if any,
+will be passed to the command as its first argument.
 
 EXAMPLES
 --------
@@ -333,6 +350,53 @@ subject
 Fix #42
 ------------
 
+* Configure a 'cnt' trailer with a cmd use a global script `gcount`
+to record commit counts of a specified author and show how it works:
++
+------------
+$ cat ~/bin/gcount
+#!/bin/sh
+test -n "$1" && git shortlog -s --author="$1" HEAD || true
+$ git config trailer.cnt.key "Commit-count: "
+$ git config trailer.cnt.ifExists "replace"
+$ git config trailer.cnt.cmd "~/bin/gcount"
+$ git interpret-trailers --trailer="cnt:Junio" <<EOF
+> subject
+> 
+> message
+> 
+> EOF
+subject
+
+message
+
+Commit-count: 22484     Junio C Hamano
+------------
+
+* Configure a 'ref' trailer with a cmd use a global script `glog-grep`
+  to grep last relevant commit from git log in the git repository
+  and show how it works:
++
+------------
+$ cat ~/bin/glog-grep
+#!/bin/sh
+test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
+$ git config trailer.ref.key "Reference-to: "
+$ git config trailer.ref.ifExists "replace"
+$ git config trailer.ref.cmd "~/bin/glog-grep"
+$ git interpret-trailers --trailer="ref:Add copyright notices." <<EOF
+> subject
+> 
+> message
+> 
+> EOF
+subject
+
+message
+
+Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
+------------
+
 * Configure a 'see' trailer with a command to show the subject of a
   commit that is related, and show how it works:
 +
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6602790b5f4c..68353af3e62e 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -51,6 +51,69 @@ test_expect_success 'setup' '
 	EOF
 '
 
+test_expect_success 'with cmd' '
+	test_when_finished "git config --remove-section trailer.bug" &&
+	git config trailer.bug.key "Bug-maker: " &&
+	git config trailer.bug.ifExists "add" &&
+	git config trailer.bug.cmd "echo \"maybe is\"" &&
+	cat >expected2 <<-EOF &&
+
+	Bug-maker: maybe is
+	Bug-maker: maybe is him
+	Bug-maker: maybe is me
+	EOF
+	git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
+		>actual2 &&
+	test_cmp expected2 actual2
+'
+
+test_expect_success 'with cmd and $1' '
+	test_when_finished "git config --remove-section trailer.bug" &&
+	git config trailer.bug.key "Bug-maker: " &&
+	git config trailer.bug.ifExists "replace" &&
+	git config trailer.bug.cmd "echo \"\$1\" is" &&
+	cat >expected2 <<-EOF &&
+
+	Bug-maker: me is me
+	EOF
+	git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
+		>actual2 &&
+	test_cmp expected2 actual2
+'
+
+test_expect_success 'with cmd and $1 with sh -c' '
+	test_when_finished "git config --remove-section trailer.bug" &&
+	git config trailer.bug.key "Bug-maker: " &&
+	git config trailer.bug.ifExists "replace" &&
+	git config trailer.bug.cmd "sh -c \"echo who is \"\$1\"\"" &&
+	cat >expected2 <<-EOF &&
+
+	Bug-maker: who is me
+	EOF
+	git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
+		>actual2 &&
+	test_cmp expected2 actual2
+'
+
+test_expect_success 'with cmd and $1 with shell script' '
+	test_when_finished "git config --remove-section trailer.bug" &&
+	git config trailer.bug.key "Bug-maker: " &&
+	git config trailer.bug.ifExists "replace" &&
+	git config trailer.bug.cmd "./echoscript" &&
+	cat >expected2 <<-EOF &&
+
+	Bug-maker: who is me
+	EOF
+	cat >echoscript <<-EOF &&
+	#!/bin/sh
+	echo who is "\$1"
+	EOF
+	chmod +x echoscript &&
+	git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
+		>actual2 &&
+	test_cmp expected2 actual2
+'
+
 test_expect_success 'without config' '
 	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
 
@@ -1274,6 +1337,27 @@ test_expect_success 'setup a commit' '
 	git commit -m "Add file a.txt"
 '
 
+test_expect_success 'cmd takes precedence over command' '
+	test_when_finished "git config --unset trailer.fix.cmd" &&
+	git config trailer.fix.ifExists "replace" &&
+	git config trailer.fix.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%aN)\" \
+	--abbrev-commit --abbrev=14 \"\$1\" || true" &&
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
 	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
diff --git a/trailer.c b/trailer.c
index be4e9726421c..bd384befe15b 100644
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
+		if (arg)
+			strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
+		strvec_push(&cp.args, cmd.buf);
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
-- 
gitgitgadget
