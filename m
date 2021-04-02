Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EA4C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 13:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC886112E
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 13:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhDBN0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 09:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBN0R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 09:26:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6991C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 06:26:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so4770492wrd.1
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KjJU8WVw3Z9OE3lFyQMc3oMftTmNEBPaB3cgHB7EVxk=;
        b=ea8yUM5g71ap8SDrqrJOK7U7KgL8qCnzFCQrCzE/J0BJ1ljYIri4UtavmPCl+eCohY
         L4P52rW6JDGMHPr8HOZeEJ0FUG9bhq64Yr2OfM53yL8uefEXvLBp5ZuIfYi7dr+XcU+6
         OCGw6S8FI7Ciy5YBfT1zXELHVAIgaG1iTqb/Ob/37e7TIYcGW8RelLjWwdGe08yGlpsq
         nl4biFDJeuHFHXHu4nRNiIyH1eZFyOWpO3NQFiARID4+v3nB3zyh+7436XeV5Kp0EXwt
         VJGeNNwwvUrM+ZkVifzG9fZGqUEjNAQoooCLonff9ydsJWZxCbmI8iqdKJAkzCVrNLLd
         W9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KjJU8WVw3Z9OE3lFyQMc3oMftTmNEBPaB3cgHB7EVxk=;
        b=RgnyXZdmNdTfFFi6wPYr6dTMHl+0Nio5z881VBrQ/nHYbBRQkvOPSQsQTyyAQkA5rN
         hL/nDKZH+8FIufIzwhJxtKgChV5jHbdco60qUwA/G51V+9lRk6db1t3HZ2E5hyAxZexr
         C6RRxoll7dmqMNpwFBAp8AnrANGlHspjISeoL1n/2Bb1Ukf3ggPu3mLIQBpwDwNX9/+o
         TWLIqUtsnSe3bQGtbmYUrz+i0Cfv6o7gTbSl2vYnKosEeLdNjAIKbHPTPJKrYn9Y8PHV
         Kn2rl5xKb7BDAA3SJzXFmEdiP14JTVENwvlKR+ydlkCatFxSiuSRKdbfLl+gyCk6GCmf
         P9aA==
X-Gm-Message-State: AOAM531NsFdutbZXqtCsL4mu4vfGUKH0NUlzlmbcPneWcg5SuFNfBSUG
        mZSuws1KXRVnq3comvWyd383Hed9OEM=
X-Google-Smtp-Source: ABdhPJwHfW6xSDRypzW4XVLJ87fxI/ZQIqBBJOfwN4Ei1ENtWIj7043pUNGztehlPiichRs/NlC9Ww==
X-Received: by 2002:a5d:5487:: with SMTP id h7mr15637053wrv.348.1617369974544;
        Fri, 02 Apr 2021 06:26:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm15002841wrw.50.2021.04.02.06.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 06:26:14 -0700 (PDT)
Message-Id: <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Apr 2021 13:26:12 +0000
Subject: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config option
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
    [GSOC] trailer: add new trailer..cmd config option
    
    In https://lore.kernel.org/git/xmqqv99i4ck2.fsf@gitster.g/ Junio and
    Christian talked about the problem of using strbuf_replace() to replace
    $ARG:
    
     1. if user's script have more than one $ARG, only the first one will be
        replaced, which is incorrected.
     2. $ARG is textually replaced without shell syntax, which may result a
        broken command when $ARG include some unmatching single quote, very
        unsafe.
    
    Now pass trailer value as $1 to the trailer command with another
    trailer.<token>.cmd config, to solve these above two problems,

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/913

Range-diff vs v5:

 1:  4c59cab53a0d < -:  ------------ [GSOC] run-command: add shell_no_implicit_args option
 2:  5894d8c4b364 ! 1:  3aed77d077b9 [GSOC]trailer: pass arg as positional parameter
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC]trailer: pass arg as positional parameter
     +    [GSOC] trailer: add new trailer.<token>.cmd config option
      
          The `trailer.<token>.command` configuration variable
          specifies a command (run via the shell, so it does not have
     @@ Documentation/git-interpret-trailers.txt: subject
       Fix #42
       ------------
       
     -+* Configure a 'see' trailer with a cmd to show the subject of a
     -+  commit that is related, and show how it works:
     ++* Configure a 'see' trailer with a cmd use a global script `git-one`
     ++  to show the subject of a commit that is related, and show how it works:
      ++
      +------------
     ++$ cat ~/bin/git-one
     ++#!/bin/sh
     ++git show -s --pretty=reference "$1"
      +$ git config trailer.see.key "See-also: "
      +$ git config trailer.see.ifExists "replace"
      +$ git config trailer.see.ifMissing "doNothing"
     -+$ git config trailer.see.cmd "git show -s --pretty=reference \"\$1\""
     ++$ git config trailer.see.cmd "~/bin/git-one"
      +$ git interpret-trailers <<EOF
      +> subject
      +> 
     @@ Documentation/git-interpret-trailers.txt: subject
      +
      +message
      +
     -+See-also: fe3187489d69c4 (subject of related commit, 2021-3-20)
     ++See-also: fe3187e (subject of related commit, 2021-4-2)
      +------------
      +
     -+* Configure a 'bug' trailer with a cmd to show when and where
     -+  was the bug introduced, and show how it works:
     ++* Configure a 'who' trailer with a cmd use a global script `git-who`
     ++  to find the recent matching "author <mail>" pair in git log and
     ++  show how it works:
      ++
      +------------
     -+$ git config trailer.bug.key "Bug-from: "
     -+$ git config trailer.bug.ifExists "replace"
     -+$ git config trailer.bug.cmd "git log --grep \"\$1\" -1 --pretty=\"%h %aD\""
     -+$ git interpret-trailers --trailer="bug:the information manager from hell" <<EOF
     ++$ cat ~/bin/git-who
     ++ #!/bin/sh
     ++    git log -1 --format="%an <%ae>" --author="$1"
     ++$ git config trailer.help.key "Helped-by: "
     ++$ git config trailer.help.ifExists "replace"
     ++$ git config trailer.help.cmd "~/bin/git-who"
     ++$ git interpret-trailers --trailer="help:gitster@" <<EOF
      +> subject
      +> 
      +> message
     @@ Documentation/git-interpret-trailers.txt: subject
      +
      +message
      +
     -+Bug-from: 57d84f8d93 Mon, 6 Aug 2012 18:27:09 +0700
     ++Helped-by: Junio C Hamano <gitster@pobox.com>
      +------------
      +
       * Configure a 'see' trailer with a command to show the subject of a
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
       
      +test_expect_success 'with cmd' '
      +	test_when_finished "git config --unset trailer.bug.key && \
     -+	git config --unset trailer.bug.ifExists && \
     -+	git config --unset trailer.bug.cmd" &&
     ++			    git config --unset trailer.bug.ifExists && \
     ++			    git config --unset trailer.bug.cmd" &&
      +	git config trailer.bug.key "Bug-maker: " &&
      +	git config trailer.bug.ifExists "add" &&
     -+	git config trailer.bug.cmd "echo \"\$@\"" &&
     -+	cat >>expected2 <<-EOF &&
     ++	git config trailer.bug.cmd "echo \"maybe is\"" &&
     ++	cat >expected2 <<-EOF &&
      +
     -+	Bug-maker: 
     -+	Bug-maker: jocker
     -+	Bug-maker: batman
     ++	Bug-maker: maybe is
     ++	Bug-maker: maybe is him
     ++	Bug-maker: maybe is me
      +	EOF
     -+	git interpret-trailers --trailer "bug: jocker" --trailer "bug:batman" \
     ++	git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
     ++		>actual2 &&
     ++	test_cmp expected2 actual2
     ++'
     ++
     ++test_expect_success 'with cmd and $1' '
     ++	test_when_finished "git config --unset trailer.bug.key && \
     ++			    git config --unset trailer.bug.ifExists && \
     ++			    git config --unset trailer.bug.cmd" &&
     ++	git config trailer.bug.key "Bug-maker: " &&
     ++	git config trailer.bug.ifExists "replace" &&
     ++	git config trailer.bug.cmd "echo \"\$1\" is" &&
     ++	cat >expected2 <<-EOF &&
     ++
     ++	Bug-maker: me is me
     ++	EOF
     ++	git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
     ++		>actual2 &&
     ++	test_cmp expected2 actual2
     ++'
     ++
     ++test_expect_success 'with cmd and $1 with sh -c' '
     ++	test_when_finished "git config --unset trailer.bug.key && \
     ++			    git config --unset trailer.bug.ifExists && \
     ++			    git config --unset trailer.bug.cmd" &&
     ++	git config trailer.bug.key "Bug-maker: " &&
     ++	git config trailer.bug.ifExists "replace" &&
     ++	git config trailer.bug.cmd "sh -c \"echo who is \"\$1\"\"" &&
     ++	cat >expected2 <<-EOF &&
     ++
     ++	Bug-maker: who is me
     ++	EOF
     ++	git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
     ++		>actual2 &&
     ++	test_cmp expected2 actual2
     ++'
     ++
     ++test_expect_success 'with cmd and $1 with shell script' '
     ++	test_when_finished "git config --unset trailer.bug.key && \
     ++			    git config --unset trailer.bug.ifExists && \
     ++			    git config --unset trailer.bug.cmd" &&
     ++	git config trailer.bug.key "Bug-maker: " &&
     ++	git config trailer.bug.ifExists "replace" &&
     ++	git config trailer.bug.cmd "./echoscript" &&
     ++	cat >expected2 <<-EOF &&
     ++
     ++	Bug-maker: who is me
     ++	EOF
     ++	cat >echoscript <<-EOF &&
     ++	#!/bin/sh
     ++	echo who is "\$1"
     ++	EOF
     ++	chmod +x echoscript &&
     ++	git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
      +		>actual2 &&
      +	test_cmp expected2 actual2
      +'
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup a commit' '
       	git commit -m "Add file a.txt"
       '
       
     -+test_expect_success 'with cmd and $1' '
     -+	test_when_finished "git config --unset trailer.fix.cmd" &&
     -+	git config trailer.fix.ifExists "replace" &&
     -+	git config trailer.fix.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%s)\" \
     -+		--abbrev-commit --abbrev=14 \"\$1\" || true" &&
     -+	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
     -+	cat complex_message_body >expected2 &&
     -+	sed -e "s/ Z\$/ /" >>expected2 <<-EOF &&
     -+		Fixes: $FIXED
     -+		Acked-by= Z
     -+		Reviewed-by:
     -+		Signed-off-by: Z
     -+		Signed-off-by: A U Thor <author@example.com>
     -+	EOF
     -+	git interpret-trailers --trailer "review:" --trailer "fix=HEAD" \
     -+		<complex_message >actual2 &&
     -+	test_cmp expected2 actual2
     -+'
     -+
      +test_expect_success 'cmd takes precedence over command' '
      +	test_when_finished "git config --unset trailer.fix.cmd" &&
      +	git config trailer.fix.ifExists "replace" &&
     @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
      -
      -	strvec_push(&cp.args, cmd.buf);
      +	if (conf->cmd) {
     -+		cp.shell_no_implicit_args = 1;
     ++		// cp.shell_no_implicit_args = 1;
      +		strbuf_addstr(&cmd, conf->cmd);
      +		strvec_push(&cp.args, cmd.buf);
      +		if (arg)
     @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
       	cp.env = local_repo_env;
       	cp.no_stdin = 1;
       	cp.use_shell = 1;
     --	cp.shell_no_implicit_args = 1;
     - 
     - 	if (capture_command(&cp, &buf, 1024)) {
     - 		error(_("running trailer command '%s' failed"), cmd.buf);
      @@ trailer.c: static char *apply_command(const char *command, const char *arg)
       
       static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)


 Documentation/git-interpret-trailers.txt | 82 +++++++++++++++++---
 t/t7513-interpret-trailers.sh            | 95 +++++++++++++++++++++++-
 trailer.c                                | 38 +++++++---
 3 files changed, 193 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f001..67649ec6134c 100644
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
@@ -333,6 +346,55 @@ subject
 Fix #42
 ------------
 
+* Configure a 'see' trailer with a cmd use a global script `git-one`
+  to show the subject of a commit that is related, and show how it works:
++
+------------
+$ cat ~/bin/git-one
+#!/bin/sh
+git show -s --pretty=reference "$1"
+$ git config trailer.see.key "See-also: "
+$ git config trailer.see.ifExists "replace"
+$ git config trailer.see.ifMissing "doNothing"
+$ git config trailer.see.cmd "~/bin/git-one"
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
+See-also: fe3187e (subject of related commit, 2021-4-2)
+------------
+
+* Configure a 'who' trailer with a cmd use a global script `git-who`
+  to find the recent matching "author <mail>" pair in git log and
+  show how it works:
++
+------------
+$ cat ~/bin/git-who
+ #!/bin/sh
+    git log -1 --format="%an <%ae>" --author="$1"
+$ git config trailer.help.key "Helped-by: "
+$ git config trailer.help.ifExists "replace"
+$ git config trailer.help.cmd "~/bin/git-who"
+$ git interpret-trailers --trailer="help:gitster@" <<EOF
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
+------------
+
 * Configure a 'see' trailer with a command to show the subject of a
   commit that is related, and show how it works:
 +
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6602790b5f4c..923923e57573 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -51,6 +51,77 @@ test_expect_success 'setup' '
 	EOF
 '
 
+test_expect_success 'with cmd' '
+	test_when_finished "git config --unset trailer.bug.key && \
+			    git config --unset trailer.bug.ifExists && \
+			    git config --unset trailer.bug.cmd" &&
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
+	test_when_finished "git config --unset trailer.bug.key && \
+			    git config --unset trailer.bug.ifExists && \
+			    git config --unset trailer.bug.cmd" &&
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
+	test_when_finished "git config --unset trailer.bug.key && \
+			    git config --unset trailer.bug.ifExists && \
+			    git config --unset trailer.bug.cmd" &&
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
+	test_when_finished "git config --unset trailer.bug.key && \
+			    git config --unset trailer.bug.ifExists && \
+			    git config --unset trailer.bug.cmd" &&
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
 
@@ -1274,9 +1345,31 @@ test_expect_success 'setup a commit' '
 	git commit -m "Add file a.txt"
 '
 
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
index be4e9726421c..6aeff6a1bd33 100644
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
@@ -216,18 +218,25 @@ static int check_if_different(struct trailer_item *in_tok,
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
+		// cp.shell_no_implicit_args = 1;
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
@@ -247,7 +256,7 @@ static char *apply_command(const char *command, const char *arg)
 
 static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
 {
-	if (arg_tok->conf.command) {
+	if (arg_tok->conf.command || arg_tok->conf.cmd) {
 		const char *arg;
 		if (arg_tok->value && arg_tok->value[0]) {
 			arg = arg_tok->value;
@@ -257,7 +266,7 @@ static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
 			else
 				arg = xstrdup("");
 		}
-		arg_tok->value = apply_command(arg_tok->conf.command, arg);
+		arg_tok->value = apply_command(&arg_tok->conf, arg);
 		free((char *)arg);
 	}
 }
@@ -430,6 +439,7 @@ static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
 	dst->name = xstrdup_or_null(src->name);
 	dst->key = xstrdup_or_null(src->key);
 	dst->command = xstrdup_or_null(src->command);
+	dst->cmd = xstrdup_or_null(src->cmd);
 }
 
 static struct arg_item *get_conf_item(const char *name)
@@ -454,8 +464,8 @@ static struct arg_item *get_conf_item(const char *name)
 	return item;
 }
 
-enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_WHERE,
-			 TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
+enum trailer_info_type { TRAILER_KEY, TRAILER_COMMAND, TRAILER_CMD,
+			TRAILER_WHERE, TRAILER_IF_EXISTS, TRAILER_IF_MISSING };
 
 static struct {
 	const char *name;
@@ -463,6 +473,7 @@ static struct {
 } trailer_config_items[] = {
 	{ "key", TRAILER_KEY },
 	{ "command", TRAILER_COMMAND },
+	{ "cmd", TRAILER_CMD },
 	{ "where", TRAILER_WHERE },
 	{ "ifexists", TRAILER_IF_EXISTS },
 	{ "ifmissing", TRAILER_IF_MISSING }
@@ -542,6 +553,11 @@ static int git_trailer_config(const char *conf_key, const char *value, void *cb)
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
@@ -708,7 +724,7 @@ static void process_command_line_args(struct list_head *arg_head,
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
