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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7649C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 16:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8AB6044F
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 16:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbhDLQwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345393AbhDLQrO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 12:47:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C791CC061374
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 09:39:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p6so6910933wrn.9
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dY4mwU+L6XQobKtslK9iE5j5pPrWoEPEUnpytd/6mAg=;
        b=JHV8XNeoSb4KlNYyK2Hm3WmNFyJZCiZZkFzpGjyiXzRhklcgsvhmYUHN6tlJt7e9Eg
         mN/03pETnDpPkAki/7gZRGNPMnX2fkDTtONGgf2H56fkBGdcYTa9MC0eZdA8E9MmjpXX
         EnIOoIKpC5NNMqVcjZbnpDTIEiGc2Rwy3uwSGnf3KCIfcT3d85fyolAeBScGf8/EXFQQ
         hdkNP6DSOOUKppqmT2Lqz1k+QEIN0BlKz6IpWbtMgUwOn2uVgT1YuRQwFzolry5p6qoA
         DoNXO043lrO2S4ocWUBPJdWgGTeFudL8qJ95+VpHD8W6c8W3eKkCgWhKpMBTp+c79Hca
         rGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dY4mwU+L6XQobKtslK9iE5j5pPrWoEPEUnpytd/6mAg=;
        b=he/P5gMJyPJzUNALU1WyUG3yie2QfPxvNgFgK7dIU+5L56JZDRSTR6Y/bsrGNlVERK
         yZHorVx8lT4QjBNNbOkwbrx1QHgqTGejTb+lQyT3vo6Md/QjFxPPF+I4ImnuKDcc8nvZ
         UQ9pfPPlbCk+zaJW8K39ulusaW+yGQp0XprUlSoa4bUo2KYDOHE2D8AGzUjbLvHx/MWN
         xr95oMAmy1oBgNbbGky9b7wRMcr/4Nv/9601KlTWiHM7OLbKASyzLnAAF9khZ30lh1Py
         5X5StUVk71IwUzlwuxDHftEIsFLhCnqOGKiQRk0XrCvcWBj8g/itOW/Bz0MIOEryAeQn
         VgMg==
X-Gm-Message-State: AOAM531WVSUe1uri8jDvhuziXygNv3TtPZHj4KeZMu0UisSlMP45+F04
        hiKyZaJDH64d8XGnlv6zzWT8vacIc34=
X-Google-Smtp-Source: ABdhPJxLb9IEqO2/EqoFtxCljjc7UMGhy/ovsXKp6eGHFYpoXi0ex28/o7xbel7uOpzQ9m0ARYFZuQ==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr22319703wrx.19.1618245569517;
        Mon, 12 Apr 2021 09:39:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm255108wrw.95.2021.04.12.09.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 09:39:28 -0700 (PDT)
Message-Id: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 16:39:25 +0000
Subject: [PATCH v9 0/2] [GSOC] trailer: add new .cmd config option
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
$ARG:

 1. if the user's script has more than one $ARG, only the first one will be
    replaced, which is incorrected.
 2. $ARG is textually replaced without shell syntax, which may result a
    broken command when $ARG include some unmatching single quote, very
    unsafe.

Now pass trailer value as $1 to the trailer command with another
trailer.<token>.cmd config, to solve these above two problems,

We are now writing documents that are more readable and correct than before.

ZheNing Hu (2):
  [GSOC] docs: correct descript of trailer.<token>.command
  [GSOC] trailer: add new .cmd config option

 Documentation/git-interpret-trailers.txt | 96 ++++++++++++++++++++----
 t/t7513-interpret-trailers.sh            | 84 +++++++++++++++++++++
 trailer.c                                | 37 ++++++---
 3 files changed, 190 insertions(+), 27 deletions(-)


base-commit: 142430338477d9d1bb25be66267225fb58498d92
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/913

Range-diff vs v8:

 1:  505903811df8 ! 1:  8129ef6c476b [GSOC] docs: correct descript of trailer.<token>.command
     @@ Commit message
          it to increase its readability.
      
          In addition, clarify that `$ARG` in command can only be
     -    replaced once since `$ARG` is text replacement.
     +    replaced once.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## Documentation/git-interpret-trailers.txt ##
     -@@ Documentation/git-interpret-trailers.txt: trailer.<token>.command::
     - 	specified <token>.
     +@@ Documentation/git-interpret-trailers.txt: trailer.<token>.ifmissing::
     + 	that option for trailers with the specified <token>.
     + 
     + trailer.<token>.command::
     +-	This option can be used to specify a shell command that will
     +-	be called to automatically add or modify a trailer with the
     +-	specified <token>.
     ++	This option can be used to specify a shell command that will be called:
     ++	once to automatically add a trailer with the specified <token>, and then
     ++	each time a '--trailer <token>=<value>' argument to modify the <value> of
     ++	the trailer that this option would produce.
       +
     - When this option is specified, the behavior is as if a special
     +-When this option is specified, the behavior is as if a special
      -'<token>=<value>' argument were added at the beginning of the command
      -line, where <value> is taken to be the standard output of the
      -specified command with any leading and trailing whitespace trimmed
      -off.
     -+'--trailer <token>=<value>' argument was added at the beginning of
     -+the "git interpret-trailers" command, where <value> is taken to be the
     -+standard output of the specified command with any leading and trailing
     -+whitespace trimmed off.
     ++When the specified command is first called to add a trailer
     ++with the specified <token>, the behavior is as if a special
     ++'--trailer <token>=<value>' argument was added at the beginning
     ++of the "git interpret-trailers" command, where <value>
     ++is taken to be the standard output of the command with any
     ++leading and trailing whitespace trimmed off.
       +
      -If the command contains the `$ARG` string, this string will be
      -replaced with the <value> part of an existing trailer with the same
      -<token>, if any, before the command is launched.
     -+The first occurrence of substring `$ARG` will be replaced with the
     -+<value> part of an existing trailer with the same <token>, if any,
     -+before the command is launched.
     ++If some '--trailer <token>=<value>' arguments are also passed
     ++on the command line, the command is called again once for each
     ++of these arguments with the same <token>. And the <value> part
     ++of these arguments, if any, will be used to replace the first
     ++occurrence of substring `$ARG` in the command. This way the
     ++command can produce a <value> computed from the <value> passed
     ++in the '--trailer <token>=<value>' argument.
       +
     - If some '<token>=<value>' arguments are also passed on the command
     +-If some '<token>=<value>' arguments are also passed on the command
      -line, when a 'trailer.<token>.command' is configured, the command will
      -also be executed for each of these arguments. And the <value> part of
      -these arguments, if any, will be used to replace the `$ARG` string in
      -the command.
     -+line, when a 'trailer.<token>.command' is configured, the command is run
     -+once for each these arguments with the same <token>. And the <value>
     -+part of these arguments, if any, will be used to replace the first `$ARG`
     -+string in the command.
     ++For consistency, the first occurrence of substring `$ARG` is
     ++also replaced, this time with the empty string, in the command
     ++when the command is first called to add a trailer with the
     ++specified <token>.
       
       EXAMPLES
       --------
 2:  3dc8983a4702 ! 2:  7f645ec95f48 [GSOC] trailer: add new .cmd config option
     @@ Commit message
      
          The `trailer.<token>.command` configuration variable
          specifies a command (run via the shell, so it does not have
     -    to be a single name of or path to the command, but can be a
     +    to be a single name or path to the command, but can be a
          shell script), and the first occurrence of substring $ARG is
          replaced with the value given to the `interpret-trailer`
     -    command for the token.  This has two downsides:
     +    command for the token in a '--trailer <token>=<value>' argument.
     +
     +    This has two downsides:
      
          * The use of $ARG in the mechanism misleads the users that
          the value is passed in the shell variable, and tempt them
     @@ Commit message
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## Documentation/git-interpret-trailers.txt ##
     -@@ Documentation/git-interpret-trailers.txt: trailer.<token>.command::
     - 	be called to automatically add or modify a trailer with the
     - 	specified <token>.
     - +
     --When this option is specified, the behavior is as if a special
     --'--trailer <token>=<value>' argument was added at the beginning of
     --the "git interpret-trailers" command, where <value> is taken to be the
     --standard output of the specified command with any leading and trailing
     --whitespace trimmed off.
     -+When this option is specified, the first occurrence of substring $ARG is
     -+replaced with the value given to the `interpret-trailer` command for the
     -+same token. It passes the value through `$ARG`, otherwise this option behaves
     -+in the same way as 'trailer.<token>.cmd'.
     +@@ Documentation/git-interpret-trailers.txt: trailer.<token>.ifmissing::
     + 	that option for trailers with the specified <token>.
     + 
     + trailer.<token>.command::
     ++	This option behaves in the same way as 'trailer.<token>.cmd', except
     ++	that it doesn't pass anything as argument to the specified command.
     ++	Instead the first occurrence of substring $ARG is replaced by the
     ++	value that would be passed as argument.
     +++
     ++The 'trailer.<token>.command' option has been deprecated in favor of
     ++'trailer.<token>.cmd' due to the fact that $ARG in the user's command is
     ++only replaced once and that the original way of replacing $ARG is not safe.
      ++
     -+The 'trailer.<token>.command' option has been deprecated due to the fact
     -+that $ARG in the user's command can only be replaced once and that the
     -+original way of replacing $ARG was not safe. Now the preferred option is
     -+'trailer.<token>.cmd', which uses a positional argument to pass the value.
     - +
     --The first occurrence of substring `$ARG` will be replaced with the
     --<value> part of an existing trailer with the same <token>, if any,
     --before the command is launched.
      +When both 'trailer.<token>.cmd' and 'trailer.<token>.command' are given
      +for the same <token>, 'trailer.<token>.cmd' is used and
      +'trailer.<token>.command' is ignored.
      +
      +trailer.<token>.cmd::
     -+	The command specified by this configuration variable is run
     -+	with a single argument, which is the <value> part of a
     -+	`--trailer <token>=<value>` on the command line. The output
     -+	from the command is then used as the value for the <token>
     -+	in the resulting trailer.
     -++
     -+When this option is specified, the behavior is as if a
     -+'--trailer <token>=<value>' argument was added at the beginning of
     -+the "git interpret-trailers" command, the command specified by this
     -+configuration variable will be called with an empty string as the
     -+argument.
     + 	This option can be used to specify a shell command that will be called:
     + 	once to automatically add a trailer with the specified <token>, and then
     + 	each time a '--trailer <token>=<value>' argument to modify the <value> of
     +@@ Documentation/git-interpret-trailers.txt: leading and trailing whitespace trimmed off.
     + If some '--trailer <token>=<value>' arguments are also passed
     + on the command line, the command is called again once for each
     + of these arguments with the same <token>. And the <value> part
     +-of these arguments, if any, will be used to replace the first
     +-occurrence of substring `$ARG` in the command. This way the
     +-command can produce a <value> computed from the <value> passed
     +-in the '--trailer <token>=<value>' argument.
     ++of these arguments, if any, will be passed to the command as its
     ++first argument. This way the command can produce a <value> computed
     ++from the <value> passed in the '--trailer <token>=<value>' argument.
       +
     --If some '<token>=<value>' arguments are also passed on the command
     --line, when a 'trailer.<token>.command' is configured, the command is run
     --once for each these arguments with the same <token>. And the <value>
     --part of these arguments, if any, will be used to replace the first `$ARG`
     --string in the command.
     -+If some '--trailer <token>=<value>' arguments are also passed on the
     -+command line, when a 'trailer.<token>.cmd' is configured, the command
     -+is run once for each `--trailer <token>=<value>` on the command line
     -+with the same <token>. And the <value> part of these arguments, if any,
     -+will be passed to the command as its first argument.
     +-For consistency, the first occurrence of substring `$ARG` is
     +-also replaced, this time with the empty string, in the command
     +-when the command is first called to add a trailer with the
     +-specified <token>.
     ++For consistency, the $1 is also passed, this time with the empty string,
     ++in the command when the command is first called to add a trailer with
     ++the specified <token>.
       
       EXAMPLES
       --------

-- 
gitgitgadget
