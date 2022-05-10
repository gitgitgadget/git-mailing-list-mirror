Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACDCC4332F
	for <git@archiver.kernel.org>; Tue, 10 May 2022 13:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243623AbiEJNjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbiEJNii (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 09:38:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B36DF56
        for <git@vger.kernel.org>; Tue, 10 May 2022 06:28:41 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t11so13482176qto.11
        for <git@vger.kernel.org>; Tue, 10 May 2022 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Do/uDs0niBM5XpL9HbN6F3tubKcmTmBk0+ppGbdXGfA=;
        b=KARwDn+7pPE4N84jSk7m1BLvy3/HRCUYlZwXuNlZy+iOapJ/kw2sdFvQ1nYz+4MTzB
         /kDdVVWOBXfv9f8Wg/iMM776kUjXjPVIpPjMl7y7rIeoe/Q7dL/wUmkUzJ+m9YuA0kXx
         U8GZM6wmcWNPsJEFO5CQ6VQEcaCv01P9RYTgob/uYCt1ZOW7kcDQTvSO6DBBYn5FWIJ8
         3LRaWegeRABidYnUPON1SCaGZZWsWkA6RL/zf15RrDyFgYIy6X3brWbRZvrdQRLK1rJJ
         YvmfpPenP8AZWPhlAX9lrcA19gO4hI07U64qLllcW1WLPnLXzUocnmemKQ5iLf9LrRye
         r3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Do/uDs0niBM5XpL9HbN6F3tubKcmTmBk0+ppGbdXGfA=;
        b=GPBOCZREmUe7E4eXNFCrkI7xz9nAlCdjSkKrztOx8IkWHkrd55onnBFr1yngLekToW
         RE0SskebRUh3Ip4ESCDK4XdKvz18eNKjSasNLZ9K98axUj0fkuJm9Wt29ukKgpPp9uRN
         hGES7Bm2cezv5H8zh81aw/oDMHaSrfDEK30kF3f7Lo1f2vJwRjM8kAUKBqFIbSYefhm4
         nxouNeMHb9r12P2Iabdj9haJEeHVUrO1VdjcbnEdrwQHwFHrngRN7ScxredZvBLelMD4
         nrNsJ80gHao3tCx+x73E+Eiv1GAaXqzNiL+5woUTmhbaK6qR9jfN66JhAxVmVj16IMpR
         ftKw==
X-Gm-Message-State: AOAM5328tW0qnwTPXUA8TcsjqDaLEKjWSTd348INSzhhNZ3mQQ4MqX84
        XiLRwWJHCDcjvv10ZlhshOkEei1XYypuug==
X-Google-Smtp-Source: ABdhPJxXwObDzPSOzvG64crSP3CTHzb7KqM7GkG4GyXx+J4gdbgYdlk6ke/nv704PNKi5187uyWQvA==
X-Received: by 2002:ac8:7d82:0:b0:2f3:e463:d66e with SMTP id c2-20020ac87d82000000b002f3e463d66emr2544938qtd.565.1652189320484;
        Tue, 10 May 2022 06:28:40 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id o12-20020ac8554c000000b002f39b99f6a8sm8952808qtr.66.2022.05.10.06.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 06:28:40 -0700 (PDT)
Subject: Re: [PATCH] pull: only pass '--recurse-submodules' to subcommands
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <3234941c-5190-819f-fe3a-f528942c6b44@gmail.com>
Date:   Tue, 10 May 2022 09:28:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2022-05-09 à 19:27, Glen Choo via GitGitGadget a écrit :
> From: Glen Choo <chooglen@google.com>

First, regarding the commit message title (I never know where to comment
on that since I can't quote it :P)

> Re: [PATCH] pull: only pass '--recurse-submodules' to subcommands

I understand the intent, i.e. "only pass the CLI flag, not any config, to subcommands"
but only because I already know what the patch is about. It could be
read to mean "pass --recurse-submodules only to subcommands, and not to 
something else". Since this is really a bug that affects the underlying 
'git fetch', maybe something like this ?

    pull: pass '--recurse-submodules' to 'fetch' from CLI, not config

> 
> Fix a bug in "git pull" where `submodule.recurse` is preferred over
> `fetch.recurseSubmodules` 

here I would add "for the underlying 'git fetch'"

(Documentation/config/fetch.txt says that
> `fetch.recurseSubmodules` should be preferred.). Do this by passing the
> value of the "--recurse-submodules" CLI option to the underlying fetch,
> instead of passing a value that combines the CLI option and config
> variables.
> 
> In other words, this bug occurred because builtin/pull.c is conflating
> two similar-sounding, but different concepts:
> 
> - Whether "git pull" itself should care about submodules e.g. whether it
>   should update the submodule worktrees after performing a merge.

nit: "or rebase".

> - The value of "--recurse-submodules" to pass to the underlying "git
>   fetch".
> 
> Thus, when `submodule.recurse` is set, the underlying "git fetch" gets
> invoked with "--recurse-submodules", overriding the value of
> `fetch.recurseSubmodules`.

the wording is a litlle bit misleading here, as submodule.recurse could
be set to 'false', and then 'git fetch' will be invoked with '--recurse-submodules=false'.

> An alternative (and more obvious) approach to fix the bug would be to
> teach "git pull" to understand `fetch.recurseSubmodules`, but the
> proposed solution works better because:
> 
> - We don't maintain two identical config-parsing implementions in "git
>   pull" and "git fetch".
> - It works better with other commands invoked by "git pull" e.g. "git
>   merge" won't accidentally respect `fetch.recurseSubmodules`.

I'm not sure of the meaning of the second bullet, since "git merge" should
never perform a fetch ?... 

> 
> Reported-by: Huang Zou <huang.zou@schrodinger.com>
> Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>     pull: only pass '--recurse-submodules' to subcommands
>     
>     Thanks Huang Zou for the report [1], and Philippe Blain for the initial
>     investigation.
>     
>     This patch fixes the original bug, but not in the 'obvious' way of
>     teaching "git pull" to parse fetch.recurseSubmodules. Instead, "git
>     pull" now propagates its value of "--recurse-submodules" to "git fetch"
>     (ignoring any config values), and leaves the config parsing to "git
>     fetch".
>     
>     I think this works better because we get a nice separation of "config
>     that git pull cares about" and "config that its subprocess care about",
>     and as a result:
>     
>      * We don't maintain two identical config-parsing implementations in
>        "git pull" and "git fetch".
>      * It works better with other commands invoked by "git pull" e.g. "git
>        merge" won't accidentally respect fetch.recurseSubmodules.
>     
>     PS I'm having a hard time writing today, let me know how the commit
>     message/cover letter can be improved :)
>     
>     [1]
>     https://lore.kernel.org/git/CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com
>     
>     In-Reply-To:
>     CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1262%2Fchooglen%2Fpull%2Ffetch-recurse-submodules-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1262/chooglen/pull/fetch-recurse-submodules-v1
> Pull-Request: https://github.com/git/git/pull/1262
> 
>  builtin/pull.c            | 10 +++++++---
>  t/t5572-pull-submodule.sh | 14 ++++++++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 4d667abc19d..01155ba67b2 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -72,6 +72,7 @@ static const char * const pull_usage[] = {
>  static int opt_verbosity;
>  static char *opt_progress;
>  static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
>  
>  /* Options passed to git-merge or git-rebase */
>  static enum rebase_type opt_rebase = -1;
> @@ -120,7 +121,7 @@ static struct option pull_options[] = {
>  		N_("force progress reporting"),
>  		PARSE_OPT_NOARG),
>  	OPT_CALLBACK_F(0, "recurse-submodules",
> -		   &recurse_submodules, N_("on-demand"),
> +		   &recurse_submodules_cli, N_("on-demand"),
>  		   N_("control for recursive fetching of submodules"),
>  		   PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
>  
> @@ -536,8 +537,8 @@ static int run_fetch(const char *repo, const char **refspecs)
>  		strvec_push(&args, opt_tags);
>  	if (opt_prune)
>  		strvec_push(&args, opt_prune);
> -	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
> -		switch (recurse_submodules) {
> +	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
> +		switch (recurse_submodules_cli) {
>  		case RECURSE_SUBMODULES_ON:
>  			strvec_push(&args, "--recurse-submodules=on");
>  			break;
> @@ -1001,6 +1002,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  
>  	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
>  
> +	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
> +		recurse_submodules = recurse_submodules_cli;
> +

I agree with you and Junio that this implementation is very clear
and concise. Nice!

>  	if (cleanup_arg)
>  		/*
>  		 * this only checks the validity of cleanup_arg; we don't need
> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> index fa6b4cca65c..65aaa7927fb 100755
> --- a/t/t5572-pull-submodule.sh
> +++ b/t/t5572-pull-submodule.sh
> @@ -107,6 +107,20 @@ test_expect_success " --[no-]recurse-submodule and submodule.recurse" '
>  	test_path_is_file super/sub/merge_strategy_4.t
>  '
>  
> +test_expect_success "fetch.recurseSubmodules option triggers recursive fetch (but not recursive update)" '
> +	test_commit -C child merge_strategy_5 &&
> +	git -C parent submodule update --remote &&
> +	git -C parent add sub &&
> +	git -C parent commit -m "update submodule" &&
> +
> +	git -C super -c fetch.recursesubmodules=true pull --no-rebase &&
> +	# Check that the submodule commit was fetched
> +	sub_oid=$(git -C super rev-parse FETCH_HEAD:sub) &&
> +	git -C super/sub cat-file -e $sub_oid &&
> +	# Check that the submodule worktree did not update
> +	! test_path_is_file super/sub/merge_strategy_5.t
> +'
> +

OK so here we test the following situation:

fetch.recurseSubmodules  submodule.recurse  --recurse-submodules  fetch result  pull result
-----------------------  -----------------  --------------------  ------------  ------------
true                     unset              absent                recursive     not recursive

I think this is a good start, but since the default behaviour 
of Git is the following:

fetch.recurseSubmodules  submodule.recurse  --recurse-submodules  fetch result  pull result
-----------------------  -----------------  --------------------  ------------  ------------
default: on-demand       default: false     unset                 on-demand     not recursive

we end up testing something not very far from the default behaviour. I think
this answers Junio's question as to why the test does not fail when applied
without the fix. So I think for completeness, we should add more tests,
including (maybe) the configuration that Huang reported:


fetch.recurseSubmodules  submodule.recurse  --recurse-submodules  fetch result   pull result
-----------------------  -----------------  --------------------  -------------  ------------
false                    true                absent               not recursive*  recursive

* the submodule will be fetched by 'git submodule update', not by the 'git fetch' ran by 'git pull'

and probably also this configuration that I think is what Huang wanted to achieve:

fetch.recurseSubmodules  submodule.recurse  --recurse-submodules  fetch result   pull result
-----------------------  -----------------  --------------------  -------------  ------------
on-demand                false               absent               on-demand      recursive

and probably this one also:

fetch.recurseSubmodules  submodule.recurse  --recurse-submodules  fetch result   pull result
-----------------------  -----------------  --------------------  -------------  ------------
on-demand                true               absent                on-demand      recursive

and maybe some others with an explicit '--recurse-submodules' flag on the CLI.

I must tell you that I think there is another bug I think in the 'git fetch' config parsing 
for 'fetch.recurseSubmodules' and 'submodule.recurse'. Even if 'fetch.recurseSubmodules'
is documented as overriding 'submodule.recurse', this is actually not  enforced
in 'git_fetch_config', currently it's a "last one wins" situation so the actualy behaviour
depends on which config is encountered last in the config file(s)...

Thanks for taking this on,

Philippe.
