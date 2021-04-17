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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2067C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A257160FF1
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 15:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhDQPOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 11:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbhDQPOG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 11:14:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F4C061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 08:13:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p19so15788806wmq.1
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0ip48a3GTZ9NTg6WbmZz2tK6sQK5wfKirs/Xp3zCmRY=;
        b=QkuQjskjpYR64jzaZyV+9M1Tpgc3n0SBq4KFbk9uQRx+uLllZiHsbwfTDAOSSODhr3
         ZfMYUMs5Maxd4VA9mVIvHQVjbFs6XGaB0MGVSiWVIBhYn7SbQ+14zBzyg18UNxj7pA0M
         n8EKkq6BY03bjDXwyqqi/D2HocVM6NALIoW22J5O+qsJW7+E9IJ9WmShmrt30heoTSjH
         Kw4WSAogCRSdBhBvYHy3kTTs6simrdBekBs52A17iOMNwIxQJiSspLTK4+1sWS2Qbipl
         z4kx50bdxC80j0B8TXmC/kwOX0y60JktB3suYqacZJ3R+KSr1j8YymuTdITMkz1B5Kof
         TfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0ip48a3GTZ9NTg6WbmZz2tK6sQK5wfKirs/Xp3zCmRY=;
        b=p+VR7MrnLJ/OGqHWgkIuTPwQIpBQYxKJB735ov5awJU3WHStcVn8JYxiZzF0TBTNgD
         PgRfbLJGKsrhjoMglIj2sPG08jkcABht1WJz7hlTV3Ft2BfB5ZnAnfD5PlEuNV067sJA
         TE1F3GUD5Potbvowg+vyQMpUY/J9HGTN9DJ/Bc/1pG1n1C0Es9LSmAsMlOJKtrROljfJ
         wJ9pdC8eU7OXV0JICPj7bZ70+48FWlsv3ep7CuGv9orKYAVhRvHIENISD3ylyi47ye4G
         cjDKQqp55cpQpbbj/jWmGUu8eNO/bfVh8OVdBnif1XsSmrnKQo5P4rWFNqvuqypO0ctT
         4BUw==
X-Gm-Message-State: AOAM530cj+e1s6dlIB4g+dtBvQzTS92fgx7SCCDsTSrDuIhr7X9wsDzj
        cyMBd7SfKSfLO2zLt6oAD6NUWSF1MZs=
X-Google-Smtp-Source: ABdhPJyldd391yvug+zVtpAdOezzh09pfgawNl9uDdGl3lADQfjuAnpZPVeiixkV4iPhP4ZNM9fUnA==
X-Received: by 2002:a05:600c:4e8c:: with SMTP id f12mr10148540wmq.123.1618672419021;
        Sat, 17 Apr 2021 08:13:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm13679865wmb.39.2021.04.17.08.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 08:13:38 -0700 (PDT)
Message-Id: <pull.913.v11.git.1618672417.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
References: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Apr 2021 15:13:35 +0000
Subject: [PATCH v11 0/2] [GSOC] trailer: add new .cmd config option
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
trailer.<token>.cmd config, to solve these above problems.

We are now writing documents that are more readable and correct than before.

ZheNing Hu (2):
  [GSOC] docs: correct description of .command
  [GSOC] trailer: add new .cmd config option

 Documentation/git-interpret-trailers.txt | 111 ++++++++++++++++++---
 t/t7513-interpret-trailers.sh            | 122 +++++++++++++++++++++++
 trailer.c                                |  79 ++++++++++++---
 3 files changed, 280 insertions(+), 32 deletions(-)


base-commit: 142430338477d9d1bb25be66267225fb58498d92
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v11
Pull-Request: https://github.com/gitgitgadget/git/pull/913

Range-diff vs v10:

 1:  8129ef6c476b ! 1:  34210e5bd3da [GSOC] docs: correct descript of trailer.<token>.command
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] docs: correct descript of trailer.<token>.command
     +    [GSOC] docs: correct description of .command
      
          In the original documentation of `trailer.<token>.command`,
          some descriptions are easily misunderstood. So let's modify
 2:  daa889bd0ade ! 2:  9c0fc91aba24 [GSOC] trailer: add new .cmd config option
     @@ Commit message
          replaced with the value given to the `interpret-trailer`
          command for the token in a '--trailer <token>=<value>' argument.
      
     -    This has three downsides:
     +    This has two downsides:
      
          * The use of $ARG in the mechanism misleads the users that
          the value is passed in the shell variable, and tempt them
     @@ Commit message
          a broken command that is not syntactically correct (or
          worse).
      
     -    * The first occurrence of substring `$ARG` will be replaced
     -    with the empty string, in the command when the command is
     -    first called to add a trailer with the specified <token>.
     -    This is a bad design, the nature of automatic execution
     -    causes it to add a trailer that we don't expect.
     -
          Introduce a new `trailer.<token>.cmd` configuration that
          takes higher precedence to deprecate and eventually remove
          `trailer.<token>.command`, which passes the value as an
     @@ Commit message
          refer to the value as positional argument, $1, in their
          scripts. At the same time, in order to allow
          `git interpret-trailers` to better simulate the behavior
     -    of `git command -s`, 'trailer.<token>.cmd' will not
     -    automatically execute.
     +    of `git command -s`, the first implicitly executed command
     +    will not pass positional parameters, users can use this
     +    feature to suppress its output.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Helped-by: Christian Couder <christian.couder@gmail.com>
     @@ Documentation/git-interpret-trailers.txt: leading and trailing whitespace trimme
      -occurrence of substring `$ARG` in the command. This way the
      -command can produce a <value> computed from the <value> passed
      -in the '--trailer <token>=<value>' argument.
     --+
     ++of these arguments, if any, will be passed to the command as its
     ++first argument. This way the command can produce a <value> computed
     ++from the <value> passed in the '--trailer <token>=<value>' argument.
     + +
      -For consistency, the first occurrence of substring `$ARG` is
      -also replaced, this time with the empty string, in the command
      -when the command is first called to add a trailer with the
      -specified <token>.
     -+of these arguments, if any, will be passed to the command as its
     -+first argument. This way the command can produce a <value> computed
     -+from the <value> passed in the '--trailer <token>=<value>' argument.
     ++It is worth mentioning that the command is first called to add a
     ++trailer with the specified <token> and without positional argument.
     ++Users can make use of this output when they need automatically add
     ++some trailers. On the other hand, users can use a trick to suppress
     ++this output by judging whether the number of positional parameters
     ++is equal to one, if it is true, execute the commands, otherwise exit
     ++with non-zero to suppress the output.
       
       EXAMPLES
       --------
     @@ Documentation/git-interpret-trailers.txt: subject
      +------------
      +$ cat ~/bin/gcount
      +#!/bin/sh
     -+test -n "$1" && git shortlog -s --author="$1" HEAD || true
     ++if test "$#" != 1
     ++then
     ++	exit 1
     ++else
     ++	test -n "$1" && git shortlog -s --author="$1" HEAD || true
     ++fi
      +$ git config trailer.cnt.key "Commit-count: "
      +$ git config trailer.cnt.ifExists "addIfDifferentNeighbor"
      +$ git config trailer.cnt.cmd "~/bin/gcount"
      +$ git interpret-trailers --trailer="cnt:Junio" --trailer="cnt:Linus Torvalds"<<EOF
      +> subject
     -+> 
     ++>
      +> message
     -+> 
     ++>
      +> EOF
      +subject
      +
     @@ Documentation/git-interpret-trailers.txt: subject
      +------------
      +$ cat ~/bin/glog-grep
      +#!/bin/sh
     -+test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
     ++if test "$#" != 1
     ++then
     ++	exit 1
     ++else
     ++	test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
     ++fi
      +$ git config trailer.ref.key "Reference-to: "
      +$ git config trailer.ref.ifExists "replace"
      +$ git config trailer.ref.cmd "~/bin/glog-grep"
      +$ git interpret-trailers --trailer="ref:Add copyright notices." <<EOF
      +> subject
     -+> 
     ++>
      +> message
     -+> 
     ++>
      +> EOF
      +subject
      +
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
      +	git config trailer.bug.cmd "echo \"maybe is\"" &&
      +	cat >expected2 <<-EOF &&
      +
     ++	Bug-maker: maybe is
      +	Bug-maker: maybe is him
      +	Bug-maker: maybe is me
      +	EOF
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
      +	git config trailer.bug.cmd "echo \"\$1\" is" &&
      +	cat >expected2 <<-EOF &&
      +
     ++	Bug-maker: is
      +	Bug-maker: him is him
      +	Bug-maker: me is me
      +	EOF
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
      +	EOF
      +	cat >echoscript <<-EOF &&
      +	#!/bin/sh
     -+	echo who is "\$1"
     ++	if test "\$#" != 1
     ++	then
     ++		exit 1
     ++	else
     ++		echo who is "\$1"
     ++	fi
      +	EOF
      +	chmod +x echoscript &&
      +	git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
      +		>actual2 &&
      +	test_cmp expected2 actual2
      +'
     ++
     ++test_expect_success 'with cmd, $1 and without --trailer' '
     ++	test_when_finished "git config --remove-section trailer.bug" &&
     ++	test_when_finished "git config --remove-section trailer.gub" &&
     ++	git config trailer.bug.key "Bug-maker: " &&
     ++	git config trailer.bug.ifExists "replace" &&
     ++	git config trailer.bug.cmd "./echoscript" &&
     ++	git config trailer.gub.key "Gub-maker: " &&
     ++	git config trailer.gub.ifExists "replace" &&
     ++	git config trailer.gub.cmd "./echoscript2" &&
     ++	cat >expected2 <<-EOF &&
     ++
     ++	Gub-maker: si ohw
     ++	EOF
     ++	cat >echoscript <<-EOF &&
     ++	#!/bin/sh
     ++	if test "\$#" != 1
     ++	then
     ++		exit 1
     ++	else
     ++		echo who is "\$1"
     ++	fi
     ++	EOF
     ++	cat >echoscript2 <<-EOF &&
     ++		echo si ohw "\$1"
     ++	EOF
     ++	chmod +x echoscript &&
     ++	chmod +x echoscript2 &&
     ++	git interpret-trailers >actual2 &&
     ++	test_cmp expected2 actual2
     ++'
      +
       test_expect_success 'without config' '
       	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
     @@ trailer.c: static void free_arg_item(struct arg_item *item)
       	free(item->conf.command);
      +	free(item->conf.cmd);
       	free(item->token);
     - 	free(item->value);
     +-	free(item->value);
     ++	if (item->value)
     ++		FREE_AND_NULL(item->value);
       	free(item);
     + }
     + 
      @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
       	return 1;
       }
     @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
       	cp.env = local_repo_env;
       	cp.no_stdin = 1;
       	cp.use_shell = 1;
     + 
     + 	if (capture_command(&cp, &buf, 1024)) {
     +-		error(_("running trailer command '%s' failed"), cmd.buf);
     + 		strbuf_release(&buf);
     +-		result = xstrdup("");
     ++		if (!conf->cmd || arg) {
     ++			error(_("running trailer command '%s' failed"), cmd.buf);
     ++			result = xstrdup("");
     ++		} else
     ++			result = NULL;
     + 	} else {
     + 		strbuf_trim(&buf);
     + 		result = strbuf_detach(&buf, NULL);
      @@ trailer.c: static char *apply_command(const char *command, const char *arg)
       
       static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
       {
      -	if (arg_tok->conf.command) {
     +-		const char *arg;
     +-		if (arg_tok->value && arg_tok->value[0]) {
      +	if (arg_tok->conf.command || arg_tok->conf.cmd) {
     - 		const char *arg;
     - 		if (arg_tok->value && arg_tok->value[0]) {
     ++		const char *arg = NULL;
     ++
     ++		if ((arg_tok->value && arg_tok->value[0]) ||
     ++		   (arg_tok->conf.cmd && !arg_tok->value)) {
       			arg = arg_tok->value;
     + 		} else {
     + 			if (in_tok && in_tok->value)
      @@ trailer.c: static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
       			else
       				arg = xstrdup("");
       		}
      -		arg_tok->value = apply_command(arg_tok->conf.command, arg);
     +-		free((char *)arg);
      +		arg_tok->value = apply_command(&arg_tok->conf, arg);
     - 		free((char *)arg);
     ++		if (arg)
     ++			free((char *)arg);
       	}
       }
     + 
     +@@ trailer.c: static void apply_arg_if_exists(struct trailer_item *in_tok,
     + 		break;
     + 	case EXISTS_REPLACE:
     + 		apply_item_command(in_tok, arg_tok);
     ++		if (!arg_tok->value) {
     ++			free_arg_item(arg_tok);
     ++			return;
     ++		}
     + 		add_arg_to_input_list(on_tok, arg_tok);
     + 		list_del(&in_tok->list);
     + 		free_trailer_item(in_tok);
     + 		break;
     + 	case EXISTS_ADD:
     + 		apply_item_command(in_tok, arg_tok);
     ++		if (!arg_tok->value) {
     ++			free_arg_item(arg_tok);
     ++			return;
     ++		}
     + 		add_arg_to_input_list(on_tok, arg_tok);
     + 		break;
     + 	case EXISTS_ADD_IF_DIFFERENT:
     + 		apply_item_command(in_tok, arg_tok);
     ++		if (!arg_tok->value) {
     ++			free_arg_item(arg_tok);
     ++			return;
     ++		}
     + 		if (check_if_different(in_tok, arg_tok, 1, head))
     + 			add_arg_to_input_list(on_tok, arg_tok);
     + 		else
     +@@ trailer.c: static void apply_arg_if_exists(struct trailer_item *in_tok,
     + 		break;
     + 	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
     + 		apply_item_command(in_tok, arg_tok);
     ++		if (!arg_tok->value) {
     ++			free_arg_item(arg_tok);
     ++			return;
     ++		}
     + 		if (check_if_different(on_tok, arg_tok, 0, head))
     + 			add_arg_to_input_list(on_tok, arg_tok);
     + 		else
     +@@ trailer.c: static void apply_arg_if_missing(struct list_head *head,
     + 	case MISSING_ADD:
     + 		where = arg_tok->conf.where;
     + 		apply_item_command(NULL, arg_tok);
     ++		if (!arg_tok->value) {
     ++			free_arg_item(arg_tok);
     ++			return;
     ++		}
     + 		to_add = trailer_from_arg(arg_tok);
     + 		if (after_or_end(where))
     + 			list_add_tail(&to_add->list, head);
      @@ trailer.c: static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
       	dst->name = xstrdup_or_null(src->name);
       	dst->key = xstrdup_or_null(src->key);
     @@ trailer.c: static int git_trailer_config(const char *conf_key, const char *value
       	case TRAILER_WHERE:
       		if (trailer_set_where(&conf->where, value))
       			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
     +@@ trailer.c: static void process_command_line_args(struct list_head *arg_head,
     + 				     xstrdup(token_from_item(item, NULL)),
     + 				     xstrdup(""),
     + 				     &item->conf, NULL);
     ++		else if (item->conf.cmd)
     ++			add_arg_item(arg_head,
     ++				     xstrdup(token_from_item(item, NULL)),
     ++				     NULL,
     ++				     &item->conf, NULL);
     + 	}
     + 
     + 	/* Add an arg item for each trailer on the command line */

-- 
gitgitgadget
