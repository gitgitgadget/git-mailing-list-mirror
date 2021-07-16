Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F6DC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 09:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBA8613D8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 09:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhGPJg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 05:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhGPJg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 05:36:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265BDC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 02:33:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id l1so12058308edr.11
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2cqsVl1dAlGYuH545BktI8ZqrkPIcuFSC5CbzNMYHN8=;
        b=ua25IY4v2foGHVi58TnQOtt9CtoxAEXqbWf/loVOhPTMcY9JKc6p8QPInzVI1CKo7k
         rDwwO/yc5fdnktuDQC2HacIs1JikNmhUQPiytYfzV8HIkDJBo5ntkWDYoEnEpUbOyj91
         enMaGXlAiwP5OzT2of0CaLuznOwH3ZyIqONXiEeLszN+UvBomkYxReQkcKMQ6IJIeMRC
         3pcDQclwcAibelh4dGUtJjrSDOKD+WJM0y6cPqdE4hyFp2z1ORrFp0IyEGQpSkEUMTTd
         +4Yj7xyiuxkaDzJclMgA278TKSvkRcsZ4oJv8p6R1hbQn4O+eyuNUdaXO/yHRU3L25ZD
         cgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2cqsVl1dAlGYuH545BktI8ZqrkPIcuFSC5CbzNMYHN8=;
        b=mOaXUoKGH7f4IeitGBW0qPANDOxbmU9lDCTVgWpUoQng56QuVXQm0qXDhKrID+pZkV
         vwnFIUKNKt8SP2wnLCNuIhZg6V5896ELLiH3JY1ZZr+jzuaC0q7Tuzo9pv16+yK5Uw1E
         pBhVRjN0ghCtf07OnmVXR7bxuoDYGacnBmq3kItDY513Wax7nX0Mo+JUcnr+GCEyLCn8
         PwW68Feoyou7HOS0WfFlDmT3Z60JPUCfT2kdjbwvKC3P6xe1lr3W7WGR5EXpLpm8BBDR
         7rPgUNeREj7yXL/Qf2yYP21EBCR/4c525FSC1rgTbsRTVO2rFvdklEkstwtVF44SFjNs
         tu0A==
X-Gm-Message-State: AOAM5326Zv4rkBgV5AJik/1PtpyxN+KQ36S/G9tHP8X3M3zby2PGuAzt
        4U+s0nd8AfCGHjBTyllz0NbGm9tiC9Y=
X-Google-Smtp-Source: ABdhPJySZ9fBJaxVbRG2LH3zApjbW3KUzP1Zza5h4/HuzMkmWUkUHeU3NqunsClTD7zGIJtUMApIJw==
X-Received: by 2002:a05:6402:190c:: with SMTP id e12mr13169627edz.176.1626428012492;
        Fri, 16 Jul 2021 02:33:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gu15sm2683183ejb.63.2021.07.16.02.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 02:33:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/5] pull: abort by default when fast-forwarding is not
 possible
Date:   Fri, 16 Jul 2021 11:32:06 +0200
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <7e12c45fc9a94e7b56a6efdc085ebe081dd40afc.1626316849.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <7e12c45fc9a94e7b56a6efdc085ebe081dd40afc.1626316849.git.gitgitgadget@gmail.com>
Message-ID: <87czriy557.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, Elijah Newren via GitGitGadget wrote:

> -static void show_advice_pull_non_ff(void)
> +static void NORETURN die_pull_non_ff(void)
>  {
> -	advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> -		 "discouraged. You can squelch this message by running one of the following\n"
> -		 "commands sometime before your next pull:\n"
> -		 "\n"
> -		 "  git config pull.rebase false  # merge (the default strategy)\n"
> -		 "  git config pull.rebase true   # rebase\n"
> -		 "  git config pull.ff only       # fast-forward only\n"
> -		 "\n"
> -		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
> -		 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> -		 "or --ff-only on the command line to override the configured default per\n"
> -		 "invocation.\n"));
> +	die(_("You have divergent branches and need to specify how to reconcile them.\n"
> +	      "You can do so by running one of the following commands sometime before\n"
> +	      "your next pull:\n"
> +	      "\n"
> +	      "  git config pull.rebase false  # merge (the default strategy)\n"
> +	      "  git config pull.rebase true   # rebase\n"
> +	      "  git config pull.ff only       # fast-forward only\n"
> +	      "\n"
> +	      "You can replace \"git config\" with \"git config --global\" to set a default\n"
> +	      "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> +	      "or --ff-only on the command line to override the configured default per\n"
> +	      "invocation.\n"));
>  }

Dying and advise() shouldn't be mutually exclusive, we should reword the
advise() message to idate for this being a die(), and then:

>  int cmd_pull(int argc, const char **argv, const char *prefix)
> @@ -1074,9 +1074,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  		if (opt_ff) {
>  			if (!strcmp(opt_ff, "--ff-only"))
>  				die_ff_impossible();
> -		} else {
> -			if (rebase_unspecified && opt_verbosity >= 0)
> -				show_advice_pull_non_ff();
> +		} else if (rebase_unspecified) {
> +			die_pull_non_ff();
>  		}

Here we should:

    show_advice_pull_non_ff();
    die(_("some much briefer summary"))

I.e. we should not being showing giantic advice-y die() messages, the
die messages should always be brief, but we might also show advice just
before dying.
