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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6A8C433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 10:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6702961962
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 10:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhCaKFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 06:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbhCaKFv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 06:05:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBDFC061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 03:05:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j7so19083254wrd.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=did08hwveUk0avbfYUQJ+J4kkzqm6u0bGR6Xg7tnnrM=;
        b=XD84bScAONEUC76oQsUKpqHgXLOYOFRpvUmSLZ5a7ysmHzYwp44Att/4NtfTUcI1e8
         F/lla6MB6gzp2HOeEya9XzFACV1WV3vXVt41bZY9+0j+tdDuc9uF0XftmJF6eVvX+GHA
         qG1BnDl/6j3WGGCGCSv7iDj+J7q5FOB8FZdSlfzPeJZ4zYwDHckW66rewSpDRLzmDay3
         s2+z1b9So12ErR6Uvkl9JwFDBUKl4GZCy4C+nDIVo1BCnpzb2C4af1S3lcIkH3BRX6zw
         u3alzUUjQOfM85tltmarLrZ+VJN63rfvPFfDrDudNcaF+tYild470URTdgU/fwpHOYNs
         sR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=did08hwveUk0avbfYUQJ+J4kkzqm6u0bGR6Xg7tnnrM=;
        b=FAdRDs/0Tr4bvK42tFvXGTLL/mVYMql5Co9W4Nz7550wRixwur9ntpg+xZ6cHYcNKa
         n2ST+Acw6F1NWld8dZILk4E1/qZxSmVluvf1GPsHycATDQ8ec1JdYb2WXVUtDhzpAL+9
         j97UCP11c1hfYhFWpA5d5jWIWyj2vewD25C8UcRY97CM/wXdOczzmuQYbgz2WoZYXHUM
         MOIdyEBdZ3FPM/LxwpAkbbiUNgFYVBF9uDh+DtUdEKqBbgkpzf0646p/ZMTLv8+cJ5Fa
         AlHz/c7SFKMdsYxpfFjPJMGOlb051X/c/XgFjjyzv7bKr6P7aV/5f+ub83hyKG3by4Bq
         iXsw==
X-Gm-Message-State: AOAM531WbCPvSSnM0eUo09XPGJTpbkHNlnzZSpjuCQ6nSmMdtjU9MwS0
        cKB2Oe91Hm6o+HP13WCdAeOs4jGHIe4=
X-Google-Smtp-Source: ABdhPJxl3u5VMUWB+G55g01UU+EeM/oD4nx3mFWCHW53dEl4O96N6RyizVExN9Upp9XO13epj9980Q==
X-Received: by 2002:adf:d217:: with SMTP id j23mr2809896wrh.113.1617185149273;
        Wed, 31 Mar 2021 03:05:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm3574183wrt.21.2021.03.31.03.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 03:05:48 -0700 (PDT)
Message-Id: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com>
References: <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Mar 2021 10:05:45 +0000
Subject: [PATCH v5 0/2] [GSOC]trailer: pass arg as positional parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In https://lore.kernel.org/git/xmqqv99i4ck2.fsf@gitster.g/ Junio and
Christian talked about the problem of using strbuf_replace() to replace
$ARG.

Now pass trailer value as $1 to the trailer command with another
trailer.<token>.cmd config.

ZheNing Hu (2):
  [GSOC] run-command: add shell_no_implicit_args option
  [GSOC]trailer: pass arg as positional parameter

 Documentation/git-interpret-trailers.txt | 75 ++++++++++++++++++++----
 run-command.c                            |  8 +--
 run-command.h                            |  1 +
 t/t7513-interpret-trailers.sh            | 61 ++++++++++++++++++-
 trailer.c                                | 38 ++++++++----
 5 files changed, 157 insertions(+), 26 deletions(-)


base-commit: 142430338477d9d1bb25be66267225fb58498d92
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/913

Range-diff vs v4:

 -:  ------------ > 1:  4c59cab53a0d [GSOC] run-command: add shell_no_implicit_args option
 1:  e2bbdcb943c2 ! 2:  5894d8c4b364 [GSOC]trailer: pass arg as positional parameter
     @@ Commit message
          scripts.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Christian Couder <christian.couder@gmail.com>
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## Documentation/git-interpret-trailers.txt ##
     -@@ Documentation/git-interpret-trailers.txt: also be executed for each of these arguments. And the <value> part of
     - these arguments, if any, will be used to replace the `$ARG` string in
     - the command.
     - 
     +@@ Documentation/git-interpret-trailers.txt: trailer.<token>.command::
     + 	be called to automatically add or modify a trailer with the
     + 	specified <token>.
     + +
     +-When this option is specified, the behavior is as if a special
     +-'<token>=<value>' argument were added at the beginning of the command
     +-line, where <value> is taken to be the standard output of the
     +-specified command with any leading and trailing whitespace trimmed
     +-off.
     ++When this option is specified, the first occurrence of substring $ARG is
     ++replaced with the value given to the `interpret-trailer` command for the
     ++same token.
     + +
     +-If the command contains the `$ARG` string, this string will be
     +-replaced with the <value> part of an existing trailer with the same
     +-<token>, if any, before the command is launched.
     ++".command" has been deprecated due to the $ARG in the user's command can
     ++only be replaced once and the original way of replacing $ARG was not safe.
     ++Now the preferred option is using "trailer.<token>.cmd", which use position
     ++argument to pass the value.
     +++
     ++When both .cmd and .command are given for the same <token>,
     ++.cmd is used and .command is ignored.
     ++
      +trailer.<token>.cmd::
      +	The command specified by this configuration variable is run
      +	with a single parameter, which is the <value> part of an
      +	existing trailer with the same <token>.  The output from the
      +	command is then used as the value for the <token> in the
      +	resulting trailer.
     -+	The command is expected to replace `trailer.<token>.cmd`.
     -+	When both .cmd and .command are given for the same <token>,
     -+        .cmd is used and .command is ignored.
     -+
     - EXAMPLES
     - --------
     - 
     -@@ Documentation/git-interpret-trailers.txt: $ git format-patch -1
     - $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Reviewed-by: Bob <bob@example.com>' 0001-foo.patch >0001-bar.patch
     - ------------
     - 
     --* Configure a 'sign' trailer with a command to automatically add a
     -+* Configure a 'sign' trailer with a cmd to automatically add a
     -   'Signed-off-by: ' with the author information only if there is no
     -   'Signed-off-by: ' already, and show how it works:
     +++
     ++When this option is specified, If there is no trailer with same <token>,
     ++the behavior is as if a special '<token>=<value>' argument were added at
     ++the beginning of the command, <value> will be passed to the user's
     ++command as an empty value.
       +
     -@@ Documentation/git-interpret-trailers.txt: $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
     - $ git config trailer.sign.key "Signed-off-by: "
     - $ git config trailer.sign.ifmissing add
     - $ git config trailer.sign.ifexists doNothing
     --$ git config trailer.sign.command 'echo "$(git config user.name) <$(git config user.email)>"'
     -+$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.email)>"'
     - $ git interpret-trailers <<EOF
     - > EOF
     + If some '<token>=<value>' arguments are also passed on the command
     + line, when a 'trailer.<token>.command' is configured, the command will
     + also be executed for each of these arguments. And the <value> part of
     +-these arguments, if any, will be used to replace the `$ARG` string in
     +-the command.
     ++these arguments, if any, will be passed to the command as first parameter.
       
     + EXAMPLES
     + --------
      @@ Documentation/git-interpret-trailers.txt: subject
       Fix #42
       ------------
       
     --* Configure a 'see' trailer with a command to show the subject of a
      +* Configure a 'see' trailer with a cmd to show the subject of a
     ++  commit that is related, and show how it works:
     +++
     ++------------
     ++$ git config trailer.see.key "See-also: "
     ++$ git config trailer.see.ifExists "replace"
     ++$ git config trailer.see.ifMissing "doNothing"
     ++$ git config trailer.see.cmd "git show -s --pretty=reference \"\$1\""
     ++$ git interpret-trailers <<EOF
     ++> subject
     ++> 
     ++> message
     ++> 
     ++> see: HEAD~2
     ++> EOF
     ++subject
     ++
     ++message
     ++
     ++See-also: fe3187489d69c4 (subject of related commit, 2021-3-20)
     ++------------
     ++
     ++* Configure a 'bug' trailer with a cmd to show when and where
     ++  was the bug introduced, and show how it works:
     +++
     ++------------
     ++$ git config trailer.bug.key "Bug-from: "
     ++$ git config trailer.bug.ifExists "replace"
     ++$ git config trailer.bug.cmd "git log --grep \"\$1\" -1 --pretty=\"%h %aD\""
     ++$ git interpret-trailers --trailer="bug:the information manager from hell" <<EOF
     ++> subject
     ++> 
     ++> message
     ++> 
     ++> EOF
     ++subject
     ++
     ++message
     ++
     ++Bug-from: 57d84f8d93 Mon, 6 Aug 2012 18:27:09 +0700
     ++------------
     ++
     + * Configure a 'see' trailer with a command to show the subject of a
         commit that is related, and show how it works:
       +
     - ------------
     - $ git config trailer.see.key "See-also: "
     - $ git config trailer.see.ifExists "replace"
     - $ git config trailer.see.ifMissing "doNothing"
     --$ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
     -+$ git config trailer.see.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \"\$1\"|| true "
     - $ git interpret-trailers <<EOF
     - > subject
     - > 
      
       ## t/t7513-interpret-trailers.sh ##
     +@@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
     + 	EOF
     + '
     + 
     ++test_expect_success 'with cmd' '
     ++	test_when_finished "git config --unset trailer.bug.key && \
     ++	git config --unset trailer.bug.ifExists && \
     ++	git config --unset trailer.bug.cmd" &&
     ++	git config trailer.bug.key "Bug-maker: " &&
     ++	git config trailer.bug.ifExists "add" &&
     ++	git config trailer.bug.cmd "echo \"\$@\"" &&
     ++	cat >>expected2 <<-EOF &&
     ++
     ++	Bug-maker: 
     ++	Bug-maker: jocker
     ++	Bug-maker: batman
     ++	EOF
     ++	git interpret-trailers --trailer "bug: jocker" --trailer "bug:batman" \
     ++		>actual2 &&
     ++	test_cmp expected2 actual2
     ++'
     ++
     + test_expect_success 'without config' '
     + 	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
     + 
      @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup a commit' '
       	git commit -m "Add file a.txt"
       '
     @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
      -
      -	strvec_push(&cp.args, cmd.buf);
      +	if (conf->cmd) {
     ++		cp.shell_no_implicit_args = 1;
      +		strbuf_addstr(&cmd, conf->cmd);
      +		strvec_push(&cp.args, cmd.buf);
      +		if (arg)
     @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
       	cp.env = local_repo_env;
       	cp.no_stdin = 1;
       	cp.use_shell = 1;
     +-	cp.shell_no_implicit_args = 1;
     + 
     + 	if (capture_command(&cp, &buf, 1024)) {
     + 		error(_("running trailer command '%s' failed"), cmd.buf);
      @@ trailer.c: static char *apply_command(const char *command, const char *arg)
       
       static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)

-- 
gitgitgadget
