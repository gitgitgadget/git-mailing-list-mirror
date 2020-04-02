Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1515FC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 14:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6A9206CC
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 14:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7q1TOvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbgDBO7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:59:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45725 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388782AbgDBO7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 10:59:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id t7so4548432wrw.12
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1Rb63qFsi36SLpLUu0UIdRhg0z+UIEdo84861D6XwaU=;
        b=Y7q1TOvgVJYsalxGBl7y2MZC5aLKJemynBM2vAGqmJCuWRk82oGhoru9oWTBqna3eW
         WKpTQ9K5ayxwssRcZu2+4ykmgJrcLxqSgjku41dCEB4Fe0eLQWSrgIrpklt+tD9p52Ba
         Kp8j4ahNEVQUXVDPZFkIW5B3Ro0Yhg+I/EPeqBoq0Cahwk+n3rXeJo7ukPynkfI6+WhX
         qI5MgyL2Nf6qu2P3X7HQ0Fp2nEB+DNx3PfGddmW04Xsj/x4KO69UQEZkszFNXbV953qx
         mWlbD6FuRQjpwDRTLLQlBeTqNZtgmu445RS5dfpsVgVdUXso0BmhNbHzN6xaA+nVfMoF
         e03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1Rb63qFsi36SLpLUu0UIdRhg0z+UIEdo84861D6XwaU=;
        b=othZuQN5GBgyHjvSZG4fFTBwOOxPa8+fD8+/GGG7m3MpueBIzoW4Gh+0juCsWVaJyl
         Z7rwLuDBWg+A+Yno03bhauVZ0clPjHPE7T6uqZYcxYc4v3jLTyBwsECOWceyNrSkKtaV
         7bXXbprTl3LyUGiUjqUmqHlKz4V7cAG64rNXwtk4+jk1xLoc5KrFXYNaV/XgChVJ75z4
         6q2YKkb/BAgCfBV8M9ilnc7lbkFSyaW9T9+lYkNcGR7NUViQ3Bi+9DglMctxosKOtulz
         k7y8DVE1lx6CTWV3CLmWmS6EXMgJLzKQYFJvbF/OMZUPLH1XY5kTmOxQExwetu6PdKv7
         yM7Q==
X-Gm-Message-State: AGi0PuaG04pd+xu3PrT/qB2L5M7hffhZM0kuRuaEzIzsk+ofJbnnOllR
        1Vtj/7tTnRshSEx3shOPw28Xa3ee
X-Google-Smtp-Source: APiQypLabeisg5aV4ufI5fdZgCmprrAPtO/6BZdJ++p+4EUwugD8phPoPLEGqOTDcE7xOU93RoA94A==
X-Received: by 2002:a5d:464a:: with SMTP id j10mr3867271wrs.3.1585839576519;
        Thu, 02 Apr 2020 07:59:36 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id u17sm8450297wri.45.2020.04.02.07.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 07:59:35 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 09/19] rebase: use apply_autostash() from sequencer.c
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <03bdaeebc993058bf14a0d196f5a1a68800e538e.1584782450.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <66697cd4-ca4e-804c-311d-8132bb1c0a8b@gmail.com>
Date:   Thu, 2 Apr 2020 15:59:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <03bdaeebc993058bf14a0d196f5a1a68800e538e.1584782450.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 21/03/2020 09:21, Denton Liu wrote:
> The apply_autostash() function in builtin/rebase.c is similar enough to
> the apply_autostash() function in sequencer.c that they are almost
> interchangeable.

You say they are almost interchangeable and then use them as if they are 
completely interchangeable. I think they are interchangeable, the only 
difference I could see is that the code in rebase.c redirects stdin when 
forking 'git stash apply' but the sequencer does not, I don't think this 
matters.

Best Wishes

Phillip

  Make the sequencer.c version extern and use it in
> rebase.
> 
> The rebase version was introduced in 6defce2b02 (builtin rebase: support
> `--autostash` option, 2018-09-04) as part of the shell to C conversion.
> It opted to duplicate the function because, at the time, there was
> another in-progress project converting interactive rebase from shell to
> C as well and they did not want to clash with them by refactoring
> sequencer.c version of apply_autostash(). Since both efforts are long
> done, we can freely combine them together now.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   builtin/rebase.c | 49 ++----------------------------------------------
>   sequencer.c      |  2 +-
>   sequencer.h      |  2 ++
>   3 files changed, 5 insertions(+), 48 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 1146463099..ceb115247a 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -712,51 +712,6 @@ static int rebase_write_basic_state(struct rebase_options *opts)
>   	return 0;
>   }
>   
> -static int apply_autostash(struct rebase_options *opts)
> -{
> -	const char *path = state_dir_path("autostash", opts);
> -	struct strbuf autostash = STRBUF_INIT;
> -	struct child_process stash_apply = CHILD_PROCESS_INIT;
> -
> -	if (!file_exists(path))
> -		return 0;
> -
> -	if (!read_oneliner(&autostash, path, READ_ONELINER_WARN_NON_EXISTENCE))
> -		return error(_("Could not read '%s'"), path);
> -	/* Ensure that the hash is not mistaken for a number */
> -	strbuf_addstr(&autostash, "^0");
> -	argv_array_pushl(&stash_apply.args,
> -			 "stash", "apply", autostash.buf, NULL);
> -	stash_apply.git_cmd = 1;
> -	stash_apply.no_stderr = stash_apply.no_stdout =
> -		stash_apply.no_stdin = 1;
> -	if (!run_command(&stash_apply))
> -		printf(_("Applied autostash.\n"));
> -	else {
> -		struct argv_array args = ARGV_ARRAY_INIT;
> -		int res = 0;
> -
> -		argv_array_pushl(&args,
> -				 "stash", "store", "-m", "autostash", "-q",
> -				 autostash.buf, NULL);
> -		if (run_command_v_opt(args.argv, RUN_GIT_CMD))
> -			res = error(_("Cannot store %s"), autostash.buf);
> -		argv_array_clear(&args);
> -		strbuf_release(&autostash);
> -		if (res)
> -			return res;
> -
> -		fprintf(stderr,
> -			_("Applying autostash resulted in conflicts.\n"
> -			  "Your changes are safe in the stash.\n"
> -			  "You can run \"git stash pop\" or \"git stash drop\" "
> -			  "at any time.\n"));
> -	}
> -
> -	strbuf_release(&autostash);
> -	return 0;
> -}
> -
>   static int finish_rebase(struct rebase_options *opts)
>   {
>   	struct strbuf dir = STRBUF_INIT;
> @@ -764,7 +719,7 @@ static int finish_rebase(struct rebase_options *opts)
>   	int ret = 0;
>   
>   	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
> -	apply_autostash(opts);
> +	apply_autostash(state_dir_path("autostash", opts));
>   	close_object_store(the_repository->objects);
>   	/*
>   	 * We ignore errors in 'gc --auto', since the
> @@ -1209,7 +1164,7 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
>   	} else if (status == 2) {
>   		struct strbuf dir = STRBUF_INIT;
>   
> -		apply_autostash(opts);
> +		apply_autostash(state_dir_path("autostash", opts));
>   		strbuf_addstr(&dir, opts->state_dir);
>   		remove_dir_recursively(&dir, 0);
>   		strbuf_release(&dir);
> diff --git a/sequencer.c b/sequencer.c
> index ad40a8b3fc..b52668f8de 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3655,7 +3655,7 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
>   	return -1;
>   }
>   
> -static int apply_autostash(const char *path)
> +int apply_autostash(const char *path)
>   {
>   	struct strbuf stash_sha1 = STRBUF_INIT;
>   	struct child_process child = CHILD_PROCESS_INIT;
> diff --git a/sequencer.h b/sequencer.h
> index 5c9662a60a..bab910f012 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -191,6 +191,8 @@ void commit_post_rewrite(struct repository *r,
>   			 const struct commit *current_head,
>   			 const struct object_id *new_head);
>   
> +int apply_autostash(const char *path);
> +
>   #define SUMMARY_INITIAL_COMMIT   (1 << 0)
>   #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
>   void print_commit_summary(struct repository *repo,
> 
