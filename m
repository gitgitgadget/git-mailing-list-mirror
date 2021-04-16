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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18889C43462
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 08:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0131611AE
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 08:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbhDPIs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 04:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241083AbhDPIsX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 04:48:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC6C061756
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 01:47:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so1669808wmi.5
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 01:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n0DzGXcqwLhLMGV9VFP/o9PGk9B3l3vtWeA9LEUCH9k=;
        b=lgd/fcXdvM3a/mvKWLeTDDflCIMcjTYz/hUFfNJ572I4zChcaYWT305qvmOvR7pfzJ
         v7FXN+trhHraKZm+bs43vdHve7a9Mb+l7iekr3o1/gDx7aSJNXjB6ng9v9Bn+u/WLuNx
         QmlCTY/8ZoYHzOghQ/Mg8QA82TzbOCAiHRbtCBXP5TDJ3aJ+4opdGTqIQOhsMoOp+sK/
         ONJ+IruN8IULlcK9jlbXQVDuMiuPo7ftXuv/7SOyeNmbDWZzvw6u6NBI9TZDy2qgVCPL
         3iJ+SRvD+t0Gx1C07ariE7kyQYlrbOHq9kHdmi9F7JBlcZ9elVPkaA+jrxakNvKZ1u7H
         DhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n0DzGXcqwLhLMGV9VFP/o9PGk9B3l3vtWeA9LEUCH9k=;
        b=rQZuVyxpA0DYQcxc/i1LF0fkfBDdWQMkplBo6M7ZsfDsZPoexnPWy/ccjnEW1c6Y9C
         piapVbsxxaiIBeVzRDOQOGudxLI9U74mLSbWt2pewJh8traW2zJwTeQkUk95EQk34Ek4
         vsWDHuFo2wPhp0m/8i0nPiLU32iQjKkKacaPIUe0VFTjhQnKjUj71a9mz2TeX5dQB/OU
         lC2wtx10R3Cu0zSROHyTQzCZ62ANx1+axGfYRS+rthDfRRMtOp5ek3nlwVxcpHx10sJj
         5seFWMCaOeY+8e7dztgf0Eck0uk2tI09/+PLzSudRDcjsRuqSXwpPT93Xfvie3YWQZAG
         LC0A==
X-Gm-Message-State: AOAM533zkYjxDfA/Vl2s8PnxkL7QLBREEt7AIF39sPD7zPR5SgoZnSE0
        tKamMukd03CnKpUo6T1jaROk2T53yr0=
X-Google-Smtp-Source: ABdhPJzt1l7VB9jiKkd7lpdFC5vn/wwbNC6UKWo+EbE7DLN5XYw2N4Hh5b+nUP34lToAXKHC/BuMmw==
X-Received: by 2002:a05:600c:2112:: with SMTP id u18mr6965099wml.33.1618562876605;
        Fri, 16 Apr 2021 01:47:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm7922511wmi.7.2021.04.16.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:47:56 -0700 (PDT)
Message-Id: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
References: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Apr 2021 08:47:53 +0000
Subject: [PATCH v10 0/2] [GSOC] trailer: add new .cmd config option
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

At the same time, the trailer.<token>.command has another design
disadvantages: It will automatically execute with a empty value in <token>
<value> pair, which will create a trailer that we don’t expect.

Now pass trailer value as $1 to the trailer command with another
trailer.<token>.cmd config, to solve these above problems.

We are now writing documents that are more readable and correct than before.

ZheNing Hu (2):
  [GSOC] docs: correct descript of trailer.<token>.command
  [GSOC] trailer: add new .cmd config option

 Documentation/git-interpret-trailers.txt | 93 ++++++++++++++++++++----
 t/t7513-interpret-trailers.sh            | 84 +++++++++++++++++++++
 trailer.c                                | 35 ++++++---
 3 files changed, 186 insertions(+), 26 deletions(-)


base-commit: 142430338477d9d1bb25be66267225fb58498d92
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v10
Pull-Request: https://github.com/gitgitgadget/git/pull/913

Range-diff vs v9:

 1:  8129ef6c476b = 1:  8129ef6c476b [GSOC] docs: correct descript of trailer.<token>.command
 2:  7f645ec95f48 ! 2:  daa889bd0ade [GSOC] trailer: add new .cmd config option
     @@ Commit message
          replaced with the value given to the `interpret-trailer`
          command for the token in a '--trailer <token>=<value>' argument.
      
     -    This has two downsides:
     +    This has three downsides:
      
          * The use of $ARG in the mechanism misleads the users that
          the value is passed in the shell variable, and tempt them
     @@ Commit message
          a broken command that is not syntactically correct (or
          worse).
      
     +    * The first occurrence of substring `$ARG` will be replaced
     +    with the empty string, in the command when the command is
     +    first called to add a trailer with the specified <token>.
     +    This is a bad design, the nature of automatic execution
     +    causes it to add a trailer that we don't expect.
     +
          Introduce a new `trailer.<token>.cmd` configuration that
          takes higher precedence to deprecate and eventually remove
          `trailer.<token>.command`, which passes the value as an
          argument to the command.  Instead of "$ARG", users can
          refer to the value as positional argument, $1, in their
     -    scripts.
     +    scripts. At the same time, in order to allow
     +    `git interpret-trailers` to better simulate the behavior
     +    of `git command -s`, 'trailer.<token>.cmd' will not
     +    automatically execute.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Helped-by: Christian Couder <christian.couder@gmail.com>
     @@ Documentation/git-interpret-trailers.txt: leading and trailing whitespace trimme
      -occurrence of substring `$ARG` in the command. This way the
      -command can produce a <value> computed from the <value> passed
      -in the '--trailer <token>=<value>' argument.
     -+of these arguments, if any, will be passed to the command as its
     -+first argument. This way the command can produce a <value> computed
     -+from the <value> passed in the '--trailer <token>=<value>' argument.
     - +
     +-+
      -For consistency, the first occurrence of substring `$ARG` is
      -also replaced, this time with the empty string, in the command
      -when the command is first called to add a trailer with the
      -specified <token>.
     -+For consistency, the $1 is also passed, this time with the empty string,
     -+in the command when the command is first called to add a trailer with
     -+the specified <token>.
     ++of these arguments, if any, will be passed to the command as its
     ++first argument. This way the command can produce a <value> computed
     ++from the <value> passed in the '--trailer <token>=<value>' argument.
       
       EXAMPLES
       --------
     @@ Documentation/git-interpret-trailers.txt: subject
      +#!/bin/sh
      +test -n "$1" && git shortlog -s --author="$1" HEAD || true
      +$ git config trailer.cnt.key "Commit-count: "
     -+$ git config trailer.cnt.ifExists "replace"
     ++$ git config trailer.cnt.ifExists "addIfDifferentNeighbor"
      +$ git config trailer.cnt.cmd "~/bin/gcount"
     -+$ git interpret-trailers --trailer="cnt:Junio" <<EOF
     ++$ git interpret-trailers --trailer="cnt:Junio" --trailer="cnt:Linus Torvalds"<<EOF
      +> subject
      +> 
      +> message
     @@ Documentation/git-interpret-trailers.txt: subject
      +message
      +
      +Commit-count: 22484     Junio C Hamano
     ++Commit-count: 1117      Linus Torvalds
      +------------
      +
      +* Configure a 'ref' trailer with a cmd use a global script `glog-grep`
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
      +	git config trailer.bug.cmd "echo \"maybe is\"" &&
      +	cat >expected2 <<-EOF &&
      +
     -+	Bug-maker: maybe is
      +	Bug-maker: maybe is him
      +	Bug-maker: maybe is me
      +	EOF
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
      +test_expect_success 'with cmd and $1' '
      +	test_when_finished "git config --remove-section trailer.bug" &&
      +	git config trailer.bug.key "Bug-maker: " &&
     -+	git config trailer.bug.ifExists "replace" &&
     ++	git config trailer.bug.ifExists "add" &&
      +	git config trailer.bug.cmd "echo \"\$1\" is" &&
      +	cat >expected2 <<-EOF &&
      +
     ++	Bug-maker: him is him
      +	Bug-maker: me is me
      +	EOF
      +	git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
     @@ trailer.c: static int git_trailer_config(const char *conf_key, const char *value
       	case TRAILER_WHERE:
       		if (trailer_set_where(&conf->where, value))
       			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
     -@@ trailer.c: static void process_command_line_args(struct list_head *arg_head,
     - 	/* Add an arg item for each configured trailer with a command */
     - 	list_for_each(pos, &conf_head) {
     - 		item = list_entry(pos, struct arg_item, list);
     --		if (item->conf.command)
     -+		if (item->conf.cmd || item->conf.command)
     - 			add_arg_item(arg_head,
     - 				     xstrdup(token_from_item(item, NULL)),
     - 				     xstrdup(""),

-- 
gitgitgadget
