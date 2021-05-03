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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85E3C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32D061159
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhECPmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 11:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhECPmD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 11:42:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B6DC061761
        for <git@vger.kernel.org>; Mon,  3 May 2021 08:41:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so3784948wmn.2
        for <git@vger.kernel.org>; Mon, 03 May 2021 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IpBy9U2UM2sT4xMTv3nKpwGvpj/9daNqBSpCMjL0Dxs=;
        b=kog+2K9QloHfea2i1+dMRDa3V4XeLLsz4Y1PBkj12KDcwW8MIu/GP3Irhh/FoYBMfq
         noVaQaeEInsI+LLGpq+851p+2IoVGgqu/66yqrIjIXhrGZX/nqGIsMPERo2ForqQ9fp7
         J/+RdmBl6n3AI7OoS3vPBk1iF4+n7GLmdw/Spb1oHyJXx6NMR40W0g7oT9MCXBS21e14
         kNbc0+OW/rX+sRM48qZ2MV2Dy89AxIOjza/I3lssDfNzbiw0d1TjPDWX8+EN2y1T3wnd
         0Qatty7lB27SyjR3zwba4XIePsD07eviNmgPjLQltPTkAZb1kmS/rL27uebtcmfHnTVQ
         8oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IpBy9U2UM2sT4xMTv3nKpwGvpj/9daNqBSpCMjL0Dxs=;
        b=crxuqDWsk3gPT8ssWmHh4mtWuuH3RHwFsvdfsh0uV3VhfzrUaRaH9mZVol4a8yFuJz
         xrGHGAD8JtDtrMPtsYBSnsucGXxTEKprzqD+89Mw5fXwvXePvYn0IoLNH0c9TuhTY6+s
         ELVEvnDfZwfvxfvCoK3ZKwS+WytsC0bjE1Y4Ax02CVC91lD6pJpgWxoKaslm4AYDa/8s
         erQt6IQkf6d3UxTVGMmJV6Vq7PBhKXJe5ncL1z9BoqkdFKwEiGp2ORPS3dSMx5H8Ro9D
         3RglgsFV+owWd57Z0LyFBHOqflK+aqRj675VaQapu6jzub4EITaLKHOGkhLcbvtygdF7
         vihQ==
X-Gm-Message-State: AOAM532S2p+O2fDoqOmM1gF5kL+iYtcUVm3aKvA6PgOF6N3s1G05JJq4
        pZAUJAqb6P7fvXK8JfxltZjHjkoVLVA=
X-Google-Smtp-Source: ABdhPJxhgPAhjPvlMeEmu7o37PU7gaww7oVb2UPZQLr+qsKilgJw4rE51d0YeYH4rcyESkHDds8f8w==
X-Received: by 2002:a1c:e409:: with SMTP id b9mr33040720wmh.189.1620056468299;
        Mon, 03 May 2021 08:41:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm9704wmq.29.2021.05.03.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:41:08 -0700 (PDT)
Message-Id: <edb7f1961ddbcd64bdc35769c88d6b7be57bb016.1620056466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v12.git.1620056466.gitgitgadget@gmail.com>
References: <pull.913.v11.git.1618672417.gitgitgadget@gmail.com>
        <pull.913.v12.git.1620056466.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 May 2021 15:41:05 +0000
Subject: [PATCH v12 2/2] [GSOC] trailer: add new .cmd config option
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
to be a single name or path to the command, but can be a
shell script), and the first occurrence of substring $ARG is
replaced with the value given to the `interpret-trailer`
command for the token in a '--trailer <token>=<value>' argument.

This has three downsides:

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

* The first occurrence of substring `$ARG` will be replaced
with the empty string, in the command when the command is
first called to add a trailer with the specified <token>.
This is a bad design, the nature of automatic execution
causes it to add a trailer that we don't expect.

Introduce a new `trailer.<token>.cmd` configuration that
takes higher precedence to deprecate and eventually remove
`trailer.<token>.command`, which passes the value as an
argument to the command.  Instead of "$ARG", users can
refer to the value as positional argument, $1, in their
scripts. At the same time, in order to allow
`git interpret-trailers` to better simulate the behavior
of `git command -s`, 'trailer.<token>.cmd' will not
automatically execute.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-interpret-trailers.txt | 75 ++++++++++++++++++---
 t/t7513-interpret-trailers.sh            | 84 ++++++++++++++++++++++++
 trailer.c                                | 35 +++++++---
 3 files changed, 175 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 6f2a7a130464..1f76e0270053 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -232,6 +232,20 @@ trailer.<token>.ifmissing::
 	that option for trailers with the specified <token>.
 
 trailer.<token>.command::
+	This option behaves in the same way as 'trailer.<token>.cmd', except
+	that it doesn't pass anything as argument to the specified command.
+	Instead the first occurrence of substring $ARG is replaced by the
+	value that would be passed as argument.
++
+The 'trailer.<token>.command' option has been deprecated in favor of
+'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
+only replaced once and that the original way of replacing $ARG is not safe.
++
+When both 'trailer.<token>.cmd' and 'trailer.<token>.command' are given
+for the same <token>, 'trailer.<token>.cmd' is used and
+'trailer.<token>.command' is ignored.
+
+trailer.<token>.cmd::
 	This option can be used to specify a shell command that will be called:
 	once to automatically add a trailer with the specified <token>, and then
 	each time a '--trailer <token>=<value>' argument to modify the <value> of
@@ -247,15 +261,9 @@ leading and trailing whitespace trimmed off.
 If some '--trailer <token>=<value>' arguments are also passed
 on the command line, the command is called again once for each
 of these arguments with the same <token>. And the <value> part
-of these arguments, if any, will be used to replace the first
-occurrence of substring `$ARG` in the command. This way the
-command can produce a <value> computed from the <value> passed
-in the '--trailer <token>=<value>' argument.
-+
-For consistency, the first occurrence of substring `$ARG` is
-also replaced, this time with the empty string, in the command
-when the command is first called to add a trailer with the
-specified <token>.
+of these arguments, if any, will be passed to the command as its
+first argument. This way the command can produce a <value> computed
+from the <value> passed in the '--trailer <token>=<value>' argument.
 
 EXAMPLES
 --------
@@ -338,6 +346,55 @@ subject
 Fix #42
 ------------
 
+* Configure a 'help' trailer with a cmd use a script `glog-find-author`
+  which search specified author identity from git log in git repository
+  and show how it works:
++
+------------
+$ cat ~/bin/glog-find-author
+#!/bin/sh
+test -n "$1" && git log --author="$1" --pretty="%an <%ae>" -1 || true
+$ git config trailer.help.key "Helped-by: "
+$ git config trailer.help.ifExists "addIfDifferentNeighbor"
+$ git config trailer.help.cmd "~/bin/glog-find-author"
+$ git interpret-trailers --trailer="help:Junio" --trailer="help:Couder" <<EOF
+> subject
+> 
+> message
+> 
+> EOF
+subject
+
+message
+
+Helped-by: Junio C Hamano <gitster@pobox.com>
+Helped-by: Christian Couder <christian.couder@gmail.com>
+------------
+
+* Configure a 'ref' trailer with a cmd use a script `glog-grep`
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
index 6602790b5f4c..04885d0a5e5c 100755
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
+	git config trailer.bug.ifExists "add" &&
+	git config trailer.bug.cmd "echo \"\$1\" is" &&
+	cat >expected2 <<-EOF &&
+
+	Bug-maker: him is him
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
index be4e9726421c..7c7cb61a945c 100644
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
-- 
gitgitgadget
