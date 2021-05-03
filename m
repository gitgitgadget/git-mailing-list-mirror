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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3261C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861BD61159
	for <git@archiver.kernel.org>; Mon,  3 May 2021 15:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhECPmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 11:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhECPmC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 11:42:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D54C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 08:41:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l2so6052393wrm.9
        for <git@vger.kernel.org>; Mon, 03 May 2021 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OAA1rJZFJ5ztEgkEndO5DRmjtmS1nMv6T696uBKV7qo=;
        b=fR/Jmew5iViHjwiPY1z4lCZrX8V5P5P+OM6VTszFKhNExmR3i3gt8rbLxtrUpWreu+
         V/klNQ8akDDIJKcckVTB+kkJvnFsJ1F0xr058CmJD6x66NPKPNI8Io7sXZqY8Rt1m9pz
         1tUsLtHBt341R2WXEPCsI9qN8ul9Ihs3zeqGm7d9uczyUXX12KL806b0UfX4s1VxAXo7
         X+5c6E696djWhM+oIQ8ZHqV7yrqjikgc7dWC16WpvFihxvBqX05AwtkojGNxmcWcD5qs
         EvbCIMoBKq0n6bWZdwgzOe6IE2kcI3/jC9jfIBmoCHNyQpvGbPXjnyh+VCzUAigEm6W+
         kBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OAA1rJZFJ5ztEgkEndO5DRmjtmS1nMv6T696uBKV7qo=;
        b=qBfx2SHo48z7+j/sYQwBjD8lSTDEgB/F06pVR7xF3JzEL+4qtRnMW2bAO3jUE/pbRg
         cBkxnn3dbeVqe+kWktI4LgBy9P3rEtn3zIynVR40bTpirKEqXqEtBXQxtyJ2f8odMefC
         Km2+vDbwR7VHDQ1peBKJb//BZCzR7RcNg30tHm07lIB3wePgOeqXbQ/Rypx+GeW75tkp
         alWeUM42N9yyLRMTUfg7fkfS01yI/mUs3Ddx84UohxFwFW3K+D0ay1ki/Obe/abC3lqY
         hX1S5cK7DlY5gaFKH1swbH3UdszA7u15umbNHoz80XLaf/Ner6rhUhjHqhpRD7H4FI/x
         nICw==
X-Gm-Message-State: AOAM531yIwGtdzrdUYSX1+I6iQ6Fdoi5I9qHA59ANWAs1vRnCO0xuKHu
        hMRvEuPSycVeLa7sIKekmEzpS8pdX5U=
X-Google-Smtp-Source: ABdhPJyQ8KxdfpaSDsDM72/ELc2FEOWounYhXZV+w2gDEtKgyQRbHfvFBaPNgjM4FqaSau8fyDmyNQ==
X-Received: by 2002:adf:fc11:: with SMTP id i17mr21910446wrr.368.1620056467204;
        Mon, 03 May 2021 08:41:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm15782257wru.27.2021.05.03.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:41:06 -0700 (PDT)
Message-Id: <pull.913.v12.git.1620056466.gitgitgadget@gmail.com>
In-Reply-To: <pull.913.v11.git.1618672417.gitgitgadget@gmail.com>
References: <pull.913.v11.git.1618672417.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 May 2021 15:41:03 +0000
Subject: [PATCH v12 0/2] [GSOC] trailer: add new .cmd config option
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

Change from last version: Change docs example "Count-count" to "Helped-by".

ZheNing Hu (2):
  [GSOC] docs: correct descript of trailer.<token>.command
  [GSOC] trailer: add new .cmd config option

 Documentation/git-interpret-trailers.txt | 94 ++++++++++++++++++++----
 t/t7513-interpret-trailers.sh            | 84 +++++++++++++++++++++
 trailer.c                                | 35 ++++++---
 3 files changed, 187 insertions(+), 26 deletions(-)


base-commit: 142430338477d9d1bb25be66267225fb58498d92
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-913%2Fadlternative%2Ftrailer-pass-ARG-env-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-913/adlternative/trailer-pass-ARG-env-v12
Pull-Request: https://github.com/gitgitgadget/git/pull/913

Range-diff vs v11:

 1:  34210e5bd3da ! 1:  8129ef6c476b [GSOC] docs: correct description of .command
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] docs: correct description of .command
     +    [GSOC] docs: correct descript of trailer.<token>.command
      
          In the original documentation of `trailer.<token>.command`,
          some descriptions are easily misunderstood. So let's modify
 2:  9c0fc91aba24 ! 2:  edb7f1961ddb [GSOC] trailer: add new .cmd config option
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
     @@ Commit message
          refer to the value as positional argument, $1, in their
          scripts. At the same time, in order to allow
          `git interpret-trailers` to better simulate the behavior
     -    of `git command -s`, the first implicitly executed command
     -    will not pass positional parameters, users can use this
     -    feature to suppress its output.
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
     -+It is worth mentioning that the command is first called to add a
     -+trailer with the specified <token> and without positional argument.
     -+Users can make use of this output when they need automatically add
     -+some trailers. On the other hand, users can use a trick to suppress
     -+this output by judging whether the number of positional parameters
     -+is equal to one, if it is true, execute the commands, otherwise exit
     -+with non-zero to suppress the output.
     ++of these arguments, if any, will be passed to the command as its
     ++first argument. This way the command can produce a <value> computed
     ++from the <value> passed in the '--trailer <token>=<value>' argument.
       
       EXAMPLES
       --------
     @@ Documentation/git-interpret-trailers.txt: subject
       Fix #42
       ------------
       
     -+* Configure a 'cnt' trailer with a cmd use a global script `gcount`
     -+to record commit counts of a specified author and show how it works:
     ++* Configure a 'help' trailer with a cmd use a script `glog-find-author`
     ++  which search specified author identity from git log in git repository
     ++  and show how it works:
      ++
      +------------
     -+$ cat ~/bin/gcount
     ++$ cat ~/bin/glog-find-author
      +#!/bin/sh
     -+if test "$#" != 1
     -+then
     -+	exit 1
     -+else
     -+	test -n "$1" && git shortlog -s --author="$1" HEAD || true
     -+fi
     -+$ git config trailer.cnt.key "Commit-count: "
     -+$ git config trailer.cnt.ifExists "addIfDifferentNeighbor"
     -+$ git config trailer.cnt.cmd "~/bin/gcount"
     -+$ git interpret-trailers --trailer="cnt:Junio" --trailer="cnt:Linus Torvalds"<<EOF
     ++test -n "$1" && git log --author="$1" --pretty="%an <%ae>" -1 || true
     ++$ git config trailer.help.key "Helped-by: "
     ++$ git config trailer.help.ifExists "addIfDifferentNeighbor"
     ++$ git config trailer.help.cmd "~/bin/glog-find-author"
     ++$ git interpret-trailers --trailer="help:Junio" --trailer="help:Couder" <<EOF
      +> subject
     -+>
     ++> 
      +> message
     -+>
     ++> 
      +> EOF
      +subject
      +
      +message
      +
     -+Commit-count: 22484     Junio C Hamano
     -+Commit-count: 1117      Linus Torvalds
     ++Helped-by: Junio C Hamano <gitster@pobox.com>
     ++Helped-by: Christian Couder <christian.couder@gmail.com>
      +------------
      +
     -+* Configure a 'ref' trailer with a cmd use a global script `glog-grep`
     ++* Configure a 'ref' trailer with a cmd use a script `glog-grep`
      +  to grep last relevant commit from git log in the git repository
      +  and show how it works:
      ++
      +------------
      +$ cat ~/bin/glog-grep
      +#!/bin/sh
     -+if test "$#" != 1
     -+then
     -+	exit 1
     -+else
     -+	test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
     -+fi
     ++test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
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
     -+	Bug-maker: maybe is
      +	Bug-maker: maybe is him
      +	Bug-maker: maybe is me
      +	EOF
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
      +	git config trailer.bug.cmd "echo \"\$1\" is" &&
      +	cat >expected2 <<-EOF &&
      +
     -+	Bug-maker: is
      +	Bug-maker: him is him
      +	Bug-maker: me is me
      +	EOF
     @@ t/t7513-interpret-trailers.sh: test_expect_success 'setup' '
      +	EOF
      +	cat >echoscript <<-EOF &&
      +	#!/bin/sh
     -+	if test "\$#" != 1
     -+	then
     -+		exit 1
     -+	else
     -+		echo who is "\$1"
     -+	fi
     ++	echo who is "\$1"
      +	EOF
      +	chmod +x echoscript &&
      +	git interpret-trailers --trailer "bug: him" --trailer "bug:me" \
      +		>actual2 &&
      +	test_cmp expected2 actual2
      +'
     -+
     -+test_expect_success 'with cmd, $1 and without --trailer' '
     -+	test_when_finished "git config --remove-section trailer.bug" &&
     -+	test_when_finished "git config --remove-section trailer.gub" &&
     -+	git config trailer.bug.key "Bug-maker: " &&
     -+	git config trailer.bug.ifExists "replace" &&
     -+	git config trailer.bug.cmd "./echoscript" &&
     -+	git config trailer.gub.key "Gub-maker: " &&
     -+	git config trailer.gub.ifExists "replace" &&
     -+	git config trailer.gub.cmd "./echoscript2" &&
     -+	cat >expected2 <<-EOF &&
     -+
     -+	Gub-maker: si ohw
     -+	EOF
     -+	cat >echoscript <<-EOF &&
     -+	#!/bin/sh
     -+	if test "\$#" != 1
     -+	then
     -+		exit 1
     -+	else
     -+		echo who is "\$1"
     -+	fi
     -+	EOF
     -+	cat >echoscript2 <<-EOF &&
     -+		echo si ohw "\$1"
     -+	EOF
     -+	chmod +x echoscript &&
     -+	chmod +x echoscript2 &&
     -+	git interpret-trailers >actual2 &&
     -+	test_cmp expected2 actual2
     -+'
      +
       test_expect_success 'without config' '
       	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
     @@ trailer.c: static void free_arg_item(struct arg_item *item)
       	free(item->conf.command);
      +	free(item->conf.cmd);
       	free(item->token);
     --	free(item->value);
     -+	if (item->value)
     -+		FREE_AND_NULL(item->value);
     + 	free(item->value);
       	free(item);
     - }
     - 
      @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
       	return 1;
       }
     @@ trailer.c: static int check_if_different(struct trailer_item *in_tok,
       	cp.env = local_repo_env;
       	cp.no_stdin = 1;
       	cp.use_shell = 1;
     - 
     - 	if (capture_command(&cp, &buf, 1024)) {
     --		error(_("running trailer command '%s' failed"), cmd.buf);
     - 		strbuf_release(&buf);
     --		result = xstrdup("");
     -+		if (!conf->cmd || arg) {
     -+			error(_("running trailer command '%s' failed"), cmd.buf);
     -+			result = xstrdup("");
     -+		} else
     -+			result = NULL;
     - 	} else {
     - 		strbuf_trim(&buf);
     - 		result = strbuf_detach(&buf, NULL);
      @@ trailer.c: static char *apply_command(const char *command, const char *arg)
       
       static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
       {
      -	if (arg_tok->conf.command) {
     --		const char *arg;
     --		if (arg_tok->value && arg_tok->value[0]) {
      +	if (arg_tok->conf.command || arg_tok->conf.cmd) {
     -+		const char *arg = NULL;
     -+
     -+		if ((arg_tok->value && arg_tok->value[0]) ||
     -+		   (arg_tok->conf.cmd && !arg_tok->value)) {
     + 		const char *arg;
     + 		if (arg_tok->value && arg_tok->value[0]) {
       			arg = arg_tok->value;
     - 		} else {
     - 			if (in_tok && in_tok->value)
      @@ trailer.c: static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg
       			else
       				arg = xstrdup("");
       		}
      -		arg_tok->value = apply_command(arg_tok->conf.command, arg);
     --		free((char *)arg);
      +		arg_tok->value = apply_command(&arg_tok->conf, arg);
     -+		if (arg)
     -+			free((char *)arg);
     + 		free((char *)arg);
       	}
       }
     - 
     -@@ trailer.c: static void apply_arg_if_exists(struct trailer_item *in_tok,
     - 		break;
     - 	case EXISTS_REPLACE:
     - 		apply_item_command(in_tok, arg_tok);
     -+		if (!arg_tok->value) {
     -+			free_arg_item(arg_tok);
     -+			return;
     -+		}
     - 		add_arg_to_input_list(on_tok, arg_tok);
     - 		list_del(&in_tok->list);
     - 		free_trailer_item(in_tok);
     - 		break;
     - 	case EXISTS_ADD:
     - 		apply_item_command(in_tok, arg_tok);
     -+		if (!arg_tok->value) {
     -+			free_arg_item(arg_tok);
     -+			return;
     -+		}
     - 		add_arg_to_input_list(on_tok, arg_tok);
     - 		break;
     - 	case EXISTS_ADD_IF_DIFFERENT:
     - 		apply_item_command(in_tok, arg_tok);
     -+		if (!arg_tok->value) {
     -+			free_arg_item(arg_tok);
     -+			return;
     -+		}
     - 		if (check_if_different(in_tok, arg_tok, 1, head))
     - 			add_arg_to_input_list(on_tok, arg_tok);
     - 		else
     -@@ trailer.c: static void apply_arg_if_exists(struct trailer_item *in_tok,
     - 		break;
     - 	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
     - 		apply_item_command(in_tok, arg_tok);
     -+		if (!arg_tok->value) {
     -+			free_arg_item(arg_tok);
     -+			return;
     -+		}
     - 		if (check_if_different(on_tok, arg_tok, 0, head))
     - 			add_arg_to_input_list(on_tok, arg_tok);
     - 		else
     -@@ trailer.c: static void apply_arg_if_missing(struct list_head *head,
     - 	case MISSING_ADD:
     - 		where = arg_tok->conf.where;
     - 		apply_item_command(NULL, arg_tok);
     -+		if (!arg_tok->value) {
     -+			free_arg_item(arg_tok);
     -+			return;
     -+		}
     - 		to_add = trailer_from_arg(arg_tok);
     - 		if (after_or_end(where))
     - 			list_add_tail(&to_add->list, head);
      @@ trailer.c: static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
       	dst->name = xstrdup_or_null(src->name);
       	dst->key = xstrdup_or_null(src->key);
     @@ trailer.c: static int git_trailer_config(const char *conf_key, const char *value
       	case TRAILER_WHERE:
       		if (trailer_set_where(&conf->where, value))
       			warning(_("unknown value '%s' for key '%s'"), value, conf_key);
     -@@ trailer.c: static void process_command_line_args(struct list_head *arg_head,
     - 				     xstrdup(token_from_item(item, NULL)),
     - 				     xstrdup(""),
     - 				     &item->conf, NULL);
     -+		else if (item->conf.cmd)
     -+			add_arg_item(arg_head,
     -+				     xstrdup(token_from_item(item, NULL)),
     -+				     NULL,
     -+				     &item->conf, NULL);
     - 	}
     - 
     - 	/* Add an arg item for each trailer on the command line */

-- 
gitgitgadget
