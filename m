Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF56C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AB3610A4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhDINh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDINh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 09:37:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF92DC061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 06:37:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g66-20020a1c39450000b0290125d187ba22so2464204wma.2
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y6M6OvFdDljzUJohJJCMMEjt5hTwMyTfh34lylihP+M=;
        b=Er+IWtRDTG9yzEuAzxy4K4fGHRpVgF9Alpx1IYxxQKw42aaT/E6Ye5Vp7ejLL2Gs0D
         yClql9jzb085An5Plc/iYlMCkkSZIIUpz1hviMj/aGJwUf/84liW5byRprS96cCW2NGd
         bSjXPxvq56mvLylZZ+sVZo23fLzknPlyL63nv9PDEneZNkCBtPR+wTUlV1V3w23w1m6n
         MA04dYpZELrYhBABpExHl95XuJJnRhcYbhk7GgpkEhiVkA1IcPeboJ5nVzHOtfwqyENe
         Z3Zv4F9+BK8W9+Yro8hNi5YOCxNsoo9tFEUmlrR5aZqNRLFQdXa8mw/+F9kxixn2bmQ8
         j2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y6M6OvFdDljzUJohJJCMMEjt5hTwMyTfh34lylihP+M=;
        b=b8bBDymhmYHWVQF9+XxTfrSlP9clfqvxAHtweBV/Lze/DAHknkHvVoEi2cbHH0r5sH
         hqoEabxvfeeM1n5DTpkWUQ8jSyZRixYwNwbh/y+qGThMHYgsVefcqofjmIN0GPGKRtAd
         VWGXshPWUK16TUu+Kfn9kZwFJtJr4U5oKlrPLrhH21fwGGu4GxXVfX/qlZbMkjggOI8L
         T1bS15Lkn7afJqL1e1OMlzTmiagXdHgB8qaj6G1p0Pe8OoLE0OuVqxW7bi8i8NPOnjij
         zDA+OvxagfU2hq3fwi7TNpM10lpIDyDxA3lSiY4ki7Or/Aohkn01hmJlga+4NnCK7iXS
         00sg==
X-Gm-Message-State: AOAM533CZmy+kABPx2aX0QjJMmecBXaiQi+fFpIDKu+54xwkM8nEV2Go
        ewrSuU1c1GWAuTzB4tNOecIWMGIYgHc=
X-Google-Smtp-Source: ABdhPJwlbkpDQB/iu8alycvSRL4xgN4nKzgZDxVhbhe5sQ2Btm0OKCdmf96x7aO5xhCyA5rebbOXcw==
X-Received: by 2002:a05:600c:3553:: with SMTP id i19mr13810507wmq.1.1617975463591;
        Fri, 09 Apr 2021 06:37:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y124sm4094408wmg.41.2021.04.09.06.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:37:43 -0700 (PDT)
Message-Id: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com>
References: <pull.913.v7.git.1617541912381.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 13:37:40 +0000
Subject: [PATCH v8 0/2] [GSOC] trailer: add new .cmd config option
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

 Documentation/git-interpret-trailers.txt | 90 ++++++++++++++++++++----
 t/t7513-interpret-trailers.sh            | 84 ++++++++++++++++++++++
 trailer.c                                | 37 +++++++---
 3 files changed, 187 insertions(+), 24 deletions(-)


base-commit: 142430338477d9d1bb25be66267225fb58498d92
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/913

Range-diff vs v7:

 -:  ------------ > 1:  505903811df8 [GSOC] docs: correct descript of trailer.<token>.command
 1:  1e9a6572ac6f ! 2:  3dc8983a4702 [GSOC] trailer: add new trailer.<token>.cmd config option
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] trailer: add new trailer.<token>.cmd config option
     +    [GSOC] trailer: add new .cmd config option
      
          The `trailer.<token>.command` configuration variable
          specifies a command (run via the shell, so it does not have
     @@ Commit message
          * Because $ARG is textually replaced without regard to the
          shell language syntax, even '$ARG' (inside a single-quote
          pair), which a user would expect to stay intact, would be
     -    replaced, and worse, if the value had an unmatching single
     +    replaced, and worse, if the value had an unmatched single
          quote (imagine a name like "O'Connor", substituted into
          NAME='$ARG' to make it NAME='O'Connor'), it would result in
          a broken command that is not syntactically correct (or
     @@ Commit message
      
          Introduce a new `trailer.<token>.cmd` configuration that
          takes higher precedence to deprecate and eventually remove
     -    `trailer.<token>.command`, which passes the value as a
     -    parameter to the command.  Instead of "$ARG", the users will
     +    `trailer.<token>.command`, which passes the value as an
     +    argument to the command.  Instead of "$ARG", users can
          refer to the value as positional argument, $1, in their
          scripts.
      
     @@ Documentation/git-interpret-trailers.txt: trailer.<token>.command::
       	specified <token>.
       +
      -When this option is specified, the behavior is as if a special
     --'<token>=<value>' argument were added at the beginning of the command
     --line, where <value> is taken to be the standard output of the
     --specified command with any leading and trailing whitespace trimmed
     --off.
     +-'--trailer <token>=<value>' argument was added at the beginning of
     +-the "git interpret-trailers" command, where <value> is taken to be the
     +-standard output of the specified command with any leading and trailing
     +-whitespace trimmed off.
      +When this option is specified, the first occurrence of substring $ARG is
      +replaced with the value given to the `interpret-trailer` command for the
     -+same token. This option behaves in a similar way as ".cmd", however, it
     -+passes the value through $ARG.
     - +
     --If the command contains the `$ARG` string, this string will be
     --replaced with the <value> part of an existing trailer with the same
     --<token>, if any, before the command is launched.
     -+".command" has been deprecated due to the $ARG in the user's command can
     -+only be replaced once and the original way of replacing $ARG was not safe.
     -+Now the preferred option is using "trailer.<token>.cmd", which use position
     -+argument to pass the value.
     ++same token. It passes the value through `$ARG`, otherwise this option behaves
     ++in the same way as 'trailer.<token>.cmd'.
      ++
     -+When both .cmd and .command are given for the same <token>,
     -+.cmd is used and .command is ignored.
     ++The 'trailer.<token>.command' option has been deprecated due to the fact
     ++that $ARG in the user's command can only be replaced once and that the
     ++original way of replacing $ARG was not safe. Now the preferred option is
     ++'trailer.<token>.cmd', which uses a positional argument to pass the value.
     + +
     +-The first occurrence of substring `$ARG` will be replaced with the
     +-<value> part of an existing trailer with the same <token>, if any,
     +-before the command is launched.
     ++When both 'trailer.<token>.cmd' and 'trailer.<token>.command' are given
     ++for the same <token>, 'trailer.<token>.cmd' is used and
     ++'trailer.<token>.command' is ignored.
      +
      +trailer.<token>.cmd::
      +	The command specified by this configuration variable is run
     @@ Documentation/git-interpret-trailers.txt: trailer.<token>.command::
      +	from the command is then used as the value for the <token>
      +	in the resulting trailer.
      ++
     -+When this option is specified, the behavior is as if a '<token>=<value>'
     -+argument were added at the beginning of the "git interpret-trailers"
     -+command, the command specified by this configuration variable will be
     -+called with an empty string as the argument.
     ++When this option is specified, the behavior is as if a
     ++'--trailer <token>=<value>' argument was added at the beginning of
     ++the "git interpret-trailers" command, the command specified by this
     ++configuration variable will be called with an empty string as the
     ++argument.
       +
     - If some '<token>=<value>' arguments are also passed on the command
     --line, when a 'trailer.<token>.command' is configured, the command will
     --also be executed for each of these arguments. And the <value> part of
     --these arguments, if any, will be used to replace the `$ARG` string in
     --the command.
     -+line, when a 'trailer.<token>.cmd' is configured, the command is run
     -+once for each `--trailer <token>=<value>` on the command line with the
     -+same <token>. And the <value> part of these arguments, if any, will be
     -+passed to the command as its first argument.
     +-If some '<token>=<value>' arguments are also passed on the command
     +-line, when a 'trailer.<token>.command' is configured, the command is run
     +-once for each these arguments with the same <token>. And the <value>
     +-part of these arguments, if any, will be used to replace the first `$ARG`
     +-string in the command.
     ++If some '--trailer <token>=<value>' arguments are also passed on the
     ++command line, when a 'trailer.<token>.cmd' is configured, the command
     ++is run once for each `--trailer <token>=<value>` on the command line
     ++with the same <token>. And the <value> part of these arguments, if any,
     ++will be passed to the command as its first argument.
       
       EXAMPLES
       --------
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup a commit' '
      +	test_when_finished "git config --unset trailer.fix.cmd" &&
      +	git config trailer.fix.ifExists "replace" &&
      +	git config trailer.fix.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%aN)\" \
     -+		--abbrev-commit --abbrev=14 \"\$1\" || true" &&
     ++	--abbrev-commit --abbrev=14 \"\$1\" || true" &&
      +	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" \
      +		--abbrev-commit --abbrev=14 \$ARG" &&
      +	FIXED=$(git log -1 --oneline --format="%h (%aN)" --abbrev-commit --abbrev=14 HEAD) &&
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup a commit' '
      +
       test_expect_success 'with command using $ARG' '
       	git config trailer.fix.ifExists "replace" &&
     --	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
     -+	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" \
     -+		--abbrev-commit --abbrev=14 \$ARG" &&
     - 	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
     - 	cat complex_message_body >expected &&
     - 	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
     + 	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
      
       ## trailer.c ##
      @@ trailer.c: struct conf_info {

-- 
gitgitgadget
