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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DEBC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 13:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F0F6112E
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 13:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhDDNMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhDDNMA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 09:12:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEEDC061756
        for <git@vger.kernel.org>; Sun,  4 Apr 2021 06:11:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o6so1608102wmq.3
        for <git@vger.kernel.org>; Sun, 04 Apr 2021 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OxF/TMr9eUFO224rtWbqPOPwYOpDXv+QjSBSecNTNY8=;
        b=F+oTwzYGBPsJuf0kN9U+yPBNTgxk3KIj9Rm90UAH5hcuKCVG44cIAjHgoYKsX2Wrt6
         3CPtQWaKm2xpkQmar0n562J6GdHi/zx0eSgSdH5Y0UDwFoSPnaNURFiqqj5vspnBXpma
         da+Ro4BNlecR4E9dcTavR7v2LuYk9uZAFO/GFDbj4AaZ+vCmS6Z0L+Z7CN1IfQCllFjR
         IxYQ7kzadJ2TAyOZ1yTN2bg7c2RBblpFzzFTy99lhQaCRlM85J8lEGR9Mke9EpRvQUzI
         3KTZXUdP7f7FdgDPsjkJEPBi+gH92j8/Tk/m48ZvFAGDYFydZoOFLeddEmbq+Cuu6EtN
         cqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OxF/TMr9eUFO224rtWbqPOPwYOpDXv+QjSBSecNTNY8=;
        b=cPChBCJBccjuIKJHmlC5BIRzOew/WWFPStveJvBKvzeeeIisEDLFf7HLKZ34nSXCnS
         k/LaRVO0z3x77IyNS2iR1bRZUmuIDeSnb5p4fR/T+S9/2fS/7jXVNPpt6/x+XzvASTE1
         tEKl9Fuum1ArgBvznndWanRGICXqOjo/YCYmlKIZGwmoPniJzKeaQDLDK/CkySG69I7M
         TTTBUJxgt+Otz1uO7vsyMtdyV2agDPy9caj018sQ5yXQatTa1WMFGXcEH8yR+ivH0Dct
         8wxZHbIQnUUR4Z/tOQ3rw7Sq8ozl5oCXBc8m3w5mXwT8vM3y3N8PyIKNc3DcknJzDJuU
         4zig==
X-Gm-Message-State: AOAM53293bi6CN5bI6SGcNE1EKfiDjmonoJBeDE282RLFy4buaA3A1uR
        ONKjTkGMfkNkuclyNnlmJFGw6ohbbJs=
X-Google-Smtp-Source: ABdhPJxSTxEm7Odki3Li5YtE0e9WOF2dinmod8OX/g+iVZZWEllke7bRWPtnE7Vt20GQCnL+bCey6Q==
X-Received: by 2002:a7b:c0c3:: with SMTP id s3mr20669051wmh.11.1617541914070;
        Sun, 04 Apr 2021 06:11:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm26029987wra.8.2021.04.04.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 06:11:53 -0700 (PDT)
Message-Id: <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com>
References: <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 04 Apr 2021 13:11:51 +0000
Subject: [PATCH v7] [GSOC] trailer: add new trailer.<token>.cmd config option
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
NAME='$ARG' to make it NAME='O'Connor'), it would result in
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
    
    We are now writing documents that are more readable and correct than
    before.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/913

Range-diff vs v6:

 1:  3aed77d077b9 ! 1:  1e9a6572ac6f [GSOC] trailer: add new trailer.<token>.cmd config option
     @@ Commit message
          pair), which a user would expect to stay intact, would be
          replaced, and worse, if the value had an unmatching single
          quote (imagine a name like "O'Connor", substituted into
     -    NAME='$ARG' to make it NAME='O'Connor), it would result in
     +    NAME='$ARG' to make it NAME='O'Connor'), it would result in
          a broken command that is not syntactically correct (or
          worse).
      
     @@ Documentation/git-interpret-trailers.txt: trailer.<token>.command::
      -off.
      +When this option is specified, the first occurrence of substring $ARG is
      +replaced with the value given to the `interpret-trailer` command for the
     -+same token.
     ++same token. This option behaves in a similar way as ".cmd", however, it
     ++passes the value through $ARG.
       +
      -If the command contains the `$ARG` string, this string will be
      -replaced with the <value> part of an existing trailer with the same
     @@ Documentation/git-interpret-trailers.txt: trailer.<token>.command::
      +
      +trailer.<token>.cmd::
      +	The command specified by this configuration variable is run
     -+	with a single parameter, which is the <value> part of an
     -+	existing trailer with the same <token>.  The output from the
     -+	command is then used as the value for the <token> in the
     -+	resulting trailer.
     ++	with a single argument, which is the <value> part of a
     ++	`--trailer <token>=<value>` on the command line. The output
     ++	from the command is then used as the value for the <token>
     ++	in the resulting trailer.
      ++
     -+When this option is specified, If there is no trailer with same <token>,
     -+the behavior is as if a special '<token>=<value>' argument were added at
     -+the beginning of the command, <value> will be passed to the user's
     -+command as an empty value.
     ++When this option is specified, the behavior is as if a '<token>=<value>'
     ++argument were added at the beginning of the "git interpret-trailers"
     ++command, the command specified by this configuration variable will be
     ++called with an empty string as the argument.
       +
       If some '<token>=<value>' arguments are also passed on the command
     - line, when a 'trailer.<token>.command' is configured, the command will
     - also be executed for each of these arguments. And the <value> part of
     +-line, when a 'trailer.<token>.command' is configured, the command will
     +-also be executed for each of these arguments. And the <value> part of
      -these arguments, if any, will be used to replace the `$ARG` string in
      -the command.
     -+these arguments, if any, will be passed to the command as first parameter.
     ++line, when a 'trailer.<token>.cmd' is configured, the command is run
     ++once for each `--trailer <token>=<value>` on the command line with the
     ++same <token>. And the <value> part of these arguments, if any, will be
     ++passed to the command as its first argument.
       
       EXAMPLES
       --------
     @@ Documentation/git-interpret-trailers.txt: subject
       Fix #42
       ------------
       
     -+* Configure a 'see' trailer with a cmd use a global script `git-one`
     -+  to show the subject of a commit that is related, and show how it works:
     ++* Configure a 'cnt' trailer with a cmd use a global script `gcount`
     ++to record commit counts of a specified author and show how it works:
      ++
      +------------
     -+$ cat ~/bin/git-one
     ++$ cat ~/bin/gcount
      +#!/bin/sh
     -+git show -s --pretty=reference "$1"
     -+$ git config trailer.see.key "See-also: "
     -+$ git config trailer.see.ifExists "replace"
     -+$ git config trailer.see.ifMissing "doNothing"
     -+$ git config trailer.see.cmd "~/bin/git-one"
     -+$ git interpret-trailers <<EOF
     ++test -n "$1" && git shortlog -s --author="$1" HEAD || true
     ++$ git config trailer.cnt.key "Commit-count: "
     ++$ git config trailer.cnt.ifExists "replace"
     ++$ git config trailer.cnt.cmd "~/bin/gcount"
     ++$ git interpret-trailers --trailer="cnt:Junio" <<EOF
      +> subject
      +> 
      +> message
      +> 
     -+> see: HEAD~2
      +> EOF
      +subject
      +
      +message
      +
     -+See-also: fe3187e (subject of related commit, 2021-4-2)
     ++Commit-count: 22484     Junio C Hamano
      +------------
      +
     -+* Configure a 'who' trailer with a cmd use a global script `git-who`
     -+  to find the recent matching "author <mail>" pair in git log and
     -+  show how it works:
     ++* Configure a 'ref' trailer with a cmd use a global script `glog-grep`
     ++  to grep last relevant commit from git log in the git repository
     ++  and show how it works:
      ++
      +------------
     -+$ cat ~/bin/git-who
     -+ #!/bin/sh
     -+    git log -1 --format="%an <%ae>" --author="$1"
     -+$ git config trailer.help.key "Helped-by: "
     -+$ git config trailer.help.ifExists "replace"
     -+$ git config trailer.help.cmd "~/bin/git-who"
     -+$ git interpret-trailers --trailer="help:gitster@" <<EOF
     ++$ cat ~/bin/glog-grep
     ++#!/bin/sh
     ++test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
     ++$ git config trailer.ref.key "Reference-to: "
     ++$ git config trailer.ref.ifExists "replace"
     ++$ git config trailer.ref.cmd "~/bin/glog-grep"
     ++$ git interpret-trailers --trailer="ref:Add copyright notices." <<EOF
      +> subject
      +> 
      +> message
     @@ Documentation/git-interpret-trailers.txt: subject
      +
      +message
      +
     -+Helped-by: Junio C Hamano <gitster@pobox.com>
     ++Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
      +------------
      +
       * Configure a 'see' trailer with a command to show the subject of a
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
       '
       
      +test_expect_success 'with cmd' '
     -+	test_when_finished "git config --unset trailer.bug.key && \
     -+			    git config --unset trailer.bug.ifExists && \
     -+			    git config --unset trailer.bug.cmd" &&
     ++	test_when_finished "git config --remove-section trailer.bug" &&
      +	git config trailer.bug.key "Bug-maker: " &&
      +	git config trailer.bug.ifExists "add" &&
      +	git config trailer.bug.cmd "echo \"maybe is\"" &&
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
      +'
      +
      +test_expect_success 'with cmd and $1' '
     -+	test_when_finished "git config --unset trailer.bug.key && \
     -+			    git config --unset trailer.bug.ifExists && \
     -+			    git config --unset trailer.bug.cmd" &&
     ++	test_when_finished "git config --remove-section trailer.bug" &&
      +	git config trailer.bug.key "Bug-maker: " &&
      +	git config trailer.bug.ifExists "replace" &&
      +	git config trailer.bug.cmd "echo \"\$1\" is" &&
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
      +'
      +
      +test_expect_success 'with cmd and $1 with sh -c' '
     -+	test_when_finished "git config --unset trailer.bug.key && \
     -+			    git config --unset trailer.bug.ifExists && \
     -+			    git config --unset trailer.bug.cmd" &&
     ++	test_when_finished "git config --remove-section trailer.bug" &&
      +	git config trailer.bug.key "Bug-maker: " &&
      +	git config trailer.bug.ifExists "replace" &&
      +	git config trailer.bug.cmd "sh -c \"echo who is \"\$1\"\"" &&
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
      +'
      +
      +test_expect_success 'with cmd and $1 with shell script' '
     -+	test_when_finished "git config --unset trailer.bug.key && \
     -+			    git config --unset trailer.bug.ifExists && \
     -+			    git config --unset trailer.bug.cmd" &&
     ++	test_when_finished "git config --remove-section trailer.bug" &&
      +	git config trailer.bug.key "Bug-maker: " &&
      +	git config trailer.bug.ifExists "replace" &&
      +	git config trailer.bug.cmd "./echoscript" &&
     @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
      -
      -	strvec_push(&cp.args, cmd.buf);
      +	if (conf->cmd) {
     -+		// cp.shell_no_implicit_args = 1;
      +		strbuf_addstr(&cmd, conf->cmd);
      +		strvec_push(&cp.args, cmd.buf);
      +		if (arg)
      +			strvec_push(&cp.args, arg);
      +	} else if (conf->command) {
      +		strbuf_addstr(&cmd, conf->command);
     -+		strvec_push(&cp.args, cmd.buf);
      +		if (arg)
      +			strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
     ++		strvec_push(&cp.args, cmd.buf);
      +	}
       	cp.env = local_repo_env;
       	cp.no_stdin = 1;


 Documentation/git-interpret-trailers.txt | 86 +++++++++++++++++++----
 t/t7513-interpret-trailers.sh            | 87 +++++++++++++++++++++++-
 trailer.c                                | 37 +++++++---
 3 files changed, 186 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 96ec6499f001..83600e93390d 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -236,21 +236,36 @@ trailer.<token>.command::
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
+same token. This option behaves in a similar way as ".cmd", however, it
+passes the value through $ARG.
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
+	with a single argument, which is the <value> part of a
+	`--trailer <token>=<value>` on the command line. The output
+	from the command is then used as the value for the <token>
+	in the resulting trailer.
++
+When this option is specified, the behavior is as if a '<token>=<value>'
+argument were added at the beginning of the "git interpret-trailers"
+command, the command specified by this configuration variable will be
+called with an empty string as the argument.
 +
 If some '<token>=<value>' arguments are also passed on the command
-line, when a 'trailer.<token>.command' is configured, the command will
-also be executed for each of these arguments. And the <value> part of
-these arguments, if any, will be used to replace the `$ARG` string in
-the command.
+line, when a 'trailer.<token>.cmd' is configured, the command is run
+once for each `--trailer <token>=<value>` on the command line with the
+same <token>. And the <value> part of these arguments, if any, will be
+passed to the command as its first argument.
 
 EXAMPLES
 --------
@@ -333,6 +348,53 @@ subject
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
index 6602790b5f4c..6d26a2606604 100755
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
 
@@ -1274,9 +1337,31 @@ test_expect_success 'setup a commit' '
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

base-commit: 142430338477d9d1bb25be66267225fb58498d92
-- 
gitgitgadget
