Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088C6C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 10:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C367420772
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 10:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCEdaC+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgFAK0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAK0M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 06:26:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A22BC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 03:26:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u26so11739383wmn.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZTyHSLJbrD/4EVR8IgZ8f2KdBvknYD2F5de8Uo12mNk=;
        b=BCEdaC+QX0lmk/yphFq7PYtEt11MfTXhlAt+FaO0JeCItJeSwaFq4fYXE2OajV6+hJ
         XPHAvqSOGosIzivI5ifWjMFCZhX6Epeu8IcLAJkoVhYq2hOn7VXvDOYAJO+hFIhU96j5
         q74GwJhO3ASsotEKFBKONJ7tAwgEitaaIJuDSV9PjEI+1GinMr2ll7ELmwKxP+uZrrrM
         Ug3udX4FSJVmcUIOgNUy7W461z1y3KlcfeBvpNw0Kvy3j+YLeAwYJHJnbYLxiRGk9d+5
         xGqRv+QLy8ntj2l0DSK/SFNr7LsRqglHvgo7EK2onVA9o2G3HF2ezeVva+AH7RHBWCYB
         2uAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZTyHSLJbrD/4EVR8IgZ8f2KdBvknYD2F5de8Uo12mNk=;
        b=AxPOqjmkNFtJYhdzk3l/YrLSdWEXak+bbwrsnrYAXhe678kVq8iwxRwyty3jfhtR7C
         lDeCzMWO1r69LddFTagR/mP6D/iBZBbLF8Uo15Yd3SaYbEFY1JfPtdzCjZuJpB+Twrxh
         31hOiCkdKTBiLHzMdAesmojZZf1VsLJbrTWlQuuSHrqBFQ/4AJC0vGW0ZblBmsOgU61N
         Hoi1UAWIE2Mky4ZRQMEaueeT6diDSfBrOCyEmdhAlDKhrelRN3iZCwCgVyn0hP3/Ldj+
         vP5KETbAOsXv9d+lv0MfyEq75AFVNnA0q6o1jPifIKrs902F0hJJXJgDdTZp6HdYFDbx
         Qylg==
X-Gm-Message-State: AOAM532xJv5SCQ41PoApNdmQ8x+mBEWCSghqY9CXTkks1KGcSEyn3BbE
        G/ZWsFuT6TAd5s9AKUe4ejnREiJR
X-Google-Smtp-Source: ABdhPJx6IVmKpMei42hsktwDiHhhfGO8jp5H/jISAVBDZCIniF0R/v8L8IHYbAj4UmxeQbQ5PQb6Kg==
X-Received: by 2002:a1c:8107:: with SMTP id c7mr20895366wmd.20.1591007170249;
        Mon, 01 Jun 2020 03:26:10 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id d15sm20744832wrq.30.2020.06.01.03.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 03:26:09 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] rebase -i: add --ignore-whitespace flag
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200527173356.47364-1-phillip.wood123@gmail.com>
 <20200527173356.47364-2-phillip.wood123@gmail.com>
 <nycvar.QRO.7.76.6.2005290437350.56@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5003e918-5f24-2bf1-fbb0-1730961af8d7@gmail.com>
Date:   Mon, 1 Jun 2020 11:26:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2005290437350.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi dscho

Thanks for taking a look at this

On 29/05/2020 03:38, Johannes Schindelin wrote:
> Hi Phillip,
> 
> sorry to be _so_ late in the game. (And sorry for sending this to you
> twice, I managed to skip all the Cc:s due to the Reply-To: header the
> first time round.)
> 
> On Wed, 27 May 2020, Phillip Wood wrote:
> 
>> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>>
>> Rebase is implemented with two different backends - 'apply' and 'merge'
>> each of which support a different set of options. In particuar the apply
>> backend supports a number of options implemented by 'git am' that are
>> not available to the merge backend. As part of an on going effort to
> 
> As a non-native speaker, I am thrown off when reading "available to"
> instead of the grammatically correct (I believe) "available in". Likewise,
> "on going" instead of "ongoing" just disrupts my workflow.
> 
> Maybe these can be fixed?

Sure

>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 27a07d4e78..5d8e117276 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -86,6 +86,7 @@ struct rebase_options {
>>  	int signoff;
>>  	int allow_rerere_autoupdate;
>>  	int autosquash;
>> +	int ignore_whitespace;
>>  	char *gpg_sign_opt;
>>  	int autostash;
>>  	char *cmd;
>> @@ -108,6 +109,7 @@ struct rebase_options {
>>
>>  static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>>  {
>> +	struct strbuf strategy_buf = STRBUF_INIT;
>>  	struct replay_opts replay = REPLAY_OPTS_INIT;
>>
>>  	replay.action = REPLAY_INTERACTIVE_REBASE;
>> @@ -126,14 +128,20 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>>  	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>>  	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>>  	replay.strategy = opts->strategy;
>> +
>>  	if (opts->strategy_opts)
>> -		parse_strategy_opts(&replay, opts->strategy_opts);
>> +		strbuf_addstr(&strategy_buf, opts->strategy_opts);
>> +	if (opts->ignore_whitespace)
>> +		strbuf_addstr(&strategy_buf, " --ignore-space-change");
>> +	if (strategy_buf.len)
>> +		parse_strategy_opts(&replay, strategy_buf.buf);
> 
> Quite honestly, this is very, very ugly.
> 
> I would have expected this at a way earlier layer, namely in
> `cmd__rebase()`. Something along these lines:

Yes your version is definitely better, I'll update with that (I had left
this patch mostly alone as unlike the later ones the original actually
worked)

> 
> -- snip --
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 37ba76ac3d26..748e08aee2f2 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1289,6 +1289,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	struct strbuf revisions = STRBUF_INIT;
>  	struct strbuf buf = STRBUF_INIT;
>  	struct object_id merge_base;
> +	int ignore_whitespace = 0;
>  	enum action action = ACTION_NONE;
>  	const char *gpg_sign = NULL;
>  	struct string_list exec = STRING_LIST_INIT_NODUP;
> @@ -1318,9 +1319,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>  		OPT_BOOL(0, "signoff", &options.signoff,
>  			 N_("add a Signed-off-by: line to each commit")),
> -		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
> -				  NULL, N_("passed to 'git am'"),
> -				  PARSE_OPT_NOARG),
> +		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
> +			 N_("passed to 'git am'")),
>  		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
>  				  &options.git_am_opts, NULL,
>  				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
> @@ -1682,6 +1682,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		imply_merge(&options, "--rebase-merges");
>  	}
> 
> +	if (ignore_whitespace) {
> +		if (options.type == REBASE_APPLY)
> +			argv_array_push(&options.git_am_opts,
> +					"--ignore-whitespace");
> +		else
> +			string_list_append(&stragey_options,
> +					   "--ignore-space-change");
> +	}
> +
>  	if (strategy_options.nr) {
>  		int i;
> 
> -- snap --
> 
> 
>>
>>  	if (opts->squash_onto) {
>>  		oidcpy(&replay.squash_onto, opts->squash_onto);
>>  		replay.have_squash_onto = 1;
>>  	}
>>
>> +	strbuf_release(&strategy_buf);
>>  	return replay;
>>  }
>>
>> @@ -539,6 +547,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>>  	argc = parse_options(argc, argv, prefix, options,
>>  			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
>>
>> +	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
> 
> I am not sure what this is about: `opts.strategy_opts` is of type `char
> *`, i.e. it is supposed to be already allocated.
> 
> Not that `cmd_rebase__interactive()` matters _all_ that much anymore, of
> course: it is only used by the --preserve-merges backend, which will
> hopefully be retired soon.
> 
>> +
>>  	if (!is_null_oid(&squash_onto))
>>  		opts.squash_onto = &squash_onto;
>>
>> @@ -991,6 +1001,8 @@ static int run_am(struct rebase_options *opts)
>>  	am.git_cmd = 1;
>>  	argv_array_push(&am.args, "am");
>>
>> +	if (opts->ignore_whitespace)
>> +		argv_array_push(&am.args, "--ignore-whitespace");
>>  	if (opts->action && !strcmp("continue", opts->action)) {
>>  		argv_array_push(&am.args, "--resolved");
>>  		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
>> @@ -1495,16 +1507,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>  			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>>  		OPT_BOOL(0, "signoff", &options.signoff,
>>  			 N_("add a Signed-off-by: line to each commit")),
>> -		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
>> -				  NULL, N_("passed to 'git am'"),
>> -				  PARSE_OPT_NOARG),
>>  		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
>>  				  &options.git_am_opts, NULL,
>>  				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>>  		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
>>  				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>>  		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>>  				  N_("passed to 'git apply'"), 0),
>> +		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
>> +			 N_("ignore changes in whitespace")),
>>  		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
>>  				  N_("action"), N_("passed to 'git apply'"), 0),
>>  		OPT_BIT('f', "force-rebase", &options.flags,
>> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
>> index 50e7960702..55ca46786d 100755
>> --- a/t/t3422-rebase-incompatible-options.sh
>> +++ b/t/t3422-rebase-incompatible-options.sh
>> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>>  }
>>
>>  test_rebase_am_only --whitespace=fix
>> -test_rebase_am_only --ignore-whitespace
>>  test_rebase_am_only --committer-date-is-author-date
>>  test_rebase_am_only -C4
>>
>> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
>> new file mode 100755
>> index 0000000000..fb5e747e86
>> --- /dev/null
>> +++ b/t/t3436-rebase-more-options.sh
>> @@ -0,0 +1,86 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2019 Rohit Ashiwal
>> +#
>> +
>> +test_description='tests to ensure compatibility between am and interactive backends'
>> +
>> +. ./test-lib.sh
>> +
>> +. "$TEST_DIRECTORY"/lib-rebase.sh
>> +
>> +# This is a special case in which both am and interactive backends
>> +# provide the same output. It was done intentionally because
>> +# both the backends fall short of optimal behaviour.
>> +test_expect_success 'setup' '
>> +	git checkout -b topic &&
>> +	q_to_tab >file <<-\EOF &&
>> +	line 1
>> +	Qline 2
>> +	line 3
>> +	EOF
>> +	git add file &&
>> +	git commit -m "add file" &&
>> +	cat >file <<-\EOF &&
>> +	line 1
>> +	new line 2
>> +	line 3
>> +	EOF
>> +	git commit -am "update file" &&
>> +	git tag side &&
>> +
>> +	git checkout --orphan master &&
>> +	sed -e "s/^|//" >file <<-\EOF &&
>> +	|line 1
>> +	|        line 2
>> +	|line 3
>> +	EOF
>> +	git add file &&
>> +	git commit -m "add file" &&
>> +	git tag main
>> +'
> 
> The file contents are repeated in an awfully repetitive manner. That not
> only makes things a bit hard to read, it also makes it all too easy to
> slip in bugs by mistake. How about something like this instead?
> 
> 	test_commit file &&
> 
> 	test_write_lines line1 Qline2 line3 >templ &&
> 
> 	q_to_tab <templ >file.t &&
> 	git commit -m tab file.t &&
> 
> 	sed "s/Q/new /" <templ >file.t &&
> 	git commit -m new file.t &&
> 	git tag side &&
> 
> 	git checkout file -- &&
> 	sed "s/Q/        /" <templ >file.t &&
> 	git commit -m spaces file.t

I'm not totally convinced by this, I'd prefer to be able to read the
contents rather than having to work out what sed is doing. What about

test_write_lines "line 1" "	line 2" "line 3" >file &&
add and commit
test_write_lines "line 1" "new line 2" "line 3" >file &&
commit and tag
test_write_lines "line 1" "  line 2" "line 3" >file &&
commit and tag

It does not get rid of the repetition but it does dispense with having
the work out what sed and q_to_tab are doing

> ... and then...
> 
>> +
>> +test_expect_success '--ignore-whitespace works with apply backend' '
>> +	cat >expect <<-\EOF &&
>> +	line 1
>> +	new line 2
>> +	line 3
>> +	EOF
> 
> 	sed "s/Q/new /" <templ >expect
> 
>> +	test_must_fail git rebase --apply main side &&
>> +	git rebase --abort &&
>> +	git rebase --apply --ignore-whitespace main side &&
>> +	test_cmp expect file
> 
> Personally, I prefer to read the contents of `expect` directly before the
> `test_cmp expect file.t`

I can move it but if we use sed you cannot see the contents

>> +'
>> +
>> +test_expect_success '--ignore-whitespace works with merge backend' '
>> +	cat >expect <<-\EOF &&
>> +	line 1
>> +	new line 2
>> +	line 3
>> +	EOF
> 
> Isn't this totally identical to the `expect` constructed earlier? And in
> any case, isn't this identical to `git show main:file.t`, which is what we
> _actually_ expect: for the file contents to be identical to the tagged
> `main`? I.e.

Well spotted I'll update (I think it's actually the same as side)

> 	git diff --exit-code main
> 
>> +	test_must_fail git rebase --merge main side &&
>> +	git rebase --abort &&
>> +	git rebase --merge --ignore-whitespace main side &&
>> +	test_cmp expect file
>> +'
>> +
>> +test_expect_success '--ignore-whitespace is remembered when continuing' '
>> +	cat >expect <<-\EOF &&
>> +	line 1
>> +	new line 2
>> +	line 3
>> +	EOF
>> +	(
>> +		set_fake_editor &&
>> +		FAKE_LINES="break 1" git rebase -i --ignore-whitespace main side
>> +	) &&
>> +	git rebase --continue &&
>> +	test_cmp expect file
> 
> It is a bit funny to see these two invocations _specifically_ pulled out
> from the subshell, that's not how we do things in other test scripts:
> instead, we run all the Git commands _inside_ the subshell, and all the
> verifications after the subshell.

The idea was to only set the variable where it is used.

Best Wishes

Phillip

> I believe that with my suggestions, this test script will be a ton easier
> to read and to maintain. At least it will be a lot DRYer.
> 
> Ciao,
> Dscho
> 
>> +'
>> +
>> +# This must be the last test in this file
>> +test_expect_success '$EDITOR and friends are unchanged' '
>> +	test_editor_unchanged
>> +'
>> +
>> +test_done
>> --
>> 2.26.2
>>
>>

