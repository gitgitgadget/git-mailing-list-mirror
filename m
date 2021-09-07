Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B486C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7FF6109D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344448AbhIGM4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhIGM4r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:56:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC6C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:55:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eb14so13769874edb.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=WFE8SUbYgfivbQ7/7Mz5BcsKM+mZCpvTNiHDvbIaIYg=;
        b=cFz0t/rjG6lAZnk59YTkdVUPpnpHfaZz9cCxJS4aJZdB8G2ZP8P0kl1sSzfoKkoJ5T
         0YO+fITp218YpadiFMKrdL5AvRHIjWLLDZlxI1Ao65JQHZvgyIEHc+0WQW8eYGyoY7bS
         LJfbDCCxluhT1bfhx6nITWmFIBN1CCF9tfUfU/4ScCU+DWspeY7nXT4oZXapbTCXQGAW
         sRz2qFiJASj96GghPU3wVfVkZ/45n33IkgdmQF/Iz4rGkZ4Jv0tDEKkC++Sf54AoeePu
         5XFYWiI05j8DcEWnVpDgEPWP3vE3GPK8boYmBTyFeJmHNqJyjF2PAGZ8znp/RHmC/7AN
         j8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=WFE8SUbYgfivbQ7/7Mz5BcsKM+mZCpvTNiHDvbIaIYg=;
        b=dhytP3dUMyJzH2vfeqXjxGSW7Wfasptsnr1zRYi5cLHFw7WxWW6nOb82nxBp14/3c+
         YoP5+dGvFbh0ip8Ks4zBMjIR82cb85Xj7T8+heeD3oGWKrWppKzJOWnIDCRf5kHqgZtL
         gn+njPrZ8/cZfoNzjkmcUNWA6rAIrRtMy5+1TUrdf9MEnj9cK8mEPQWIsYi2pSUGeHoo
         +oEoWTcMpidMKD6cgBibkr+iB+32/jQQcJYk6mvKW6VKC8C3rlkOBNTYbo90QEkSH+Qr
         xjAJSXI0iOa5F3Yyd1Zdi75kD8yMpo1A/EuMxaJmYi9yUuK4eojaW/9nNBi4jNkM/0LE
         k7xw==
X-Gm-Message-State: AOAM533TehiBlCr+lTi8y/R8Dzl0uHsBlxHycqjEgZBbv+0LI3FDh0rp
        XUtl3zOYf7qXmRY4/kPjvXeXatG4HTomoA==
X-Google-Smtp-Source: ABdhPJzb+3yTh7UCVF69L4mqcyjN6neHsjfIB4XxJsDk8gtJz1DljjsjT8GqAOKAdjCRnYRRAlycaA==
X-Received: by 2002:a05:6402:51c9:: with SMTP id r9mr18649241edd.65.1631019339577;
        Tue, 07 Sep 2021 05:55:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v12sm6516661ede.16.2021.09.07.05.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:55:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        emilyshaffer@google.com, gitster@pobox.com, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH 09/13] submodule--helper: remove update-module-mode
 subcommand
Date:   Tue, 07 Sep 2021 14:49:49 +0200
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210907115932.36068-10-raykar.ath@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210907115932.36068-10-raykar.ath@gmail.com>
Message-ID: <87k0jslf3p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Atharva Raykar wrote:

> This subcommand was once useful for 'submodule update', but now that we
> have converted the shell code to C, it is no longer used.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> ---
>  builtin/submodule--helper.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a628660d6b..e3e85600c3 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1993,29 +1993,6 @@ static void determine_submodule_update_strategy(struct repository *r,
>  	free(key);
>  }
>  
> -static int module_update_module_mode(int argc, const char **argv, const char *prefix)
> -{
> -	const char *path, *update = NULL;
> -	int just_cloned;
> -	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
> -
> -	if (argc < 3 || argc > 4)
> -		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
> -
> -	just_cloned = git_config_int("just_cloned", argv[1]);
> -	path = argv[2];
> -
> -	if (argc == 4)
> -		update = argv[3];
> -
> -	determine_submodule_update_strategy(the_repository,
> -					    just_cloned, path, update,
> -					    &update_strategy);
> -	fputs(submodule_strategy_to_string(&update_strategy), stdout);
> -
> -	return 0;
> -}
> -
>  struct update_clone_data {
>  	const struct submodule *sub;
>  	struct object_id oid;
> @@ -3463,7 +3440,6 @@ static struct cmd_struct commands[] = {
>  	{"clone", module_clone, 0},
>  	{"add-clone", add_clone, 0},
>  	{"update", module_update, 0},
> -	{"update-module-mode", module_update_module_mode, 0},
>  	{"run-update-procedure", run_update_procedure, 0},
>  	{"ensure-core-worktree", ensure_core_worktree, 0},
>  	{"relative-path", resolve_relative_path, 0},

So in https://lore.kernel.org/git/87sfyglfl9.fsf@evledraar.gmail.com I
suggested squashing the shell removal, but I see now that here later in
09-13/13.

So yeah, having 08/13 stand-alone is easier to read then, but I think
then squashing all of 09-13 together is better. I.e. there's no reason
to remove these one at a time, let's just remove them all at once.

That also makes it clear that it's a remove-only change aside from your
"refactor while at it" of renaming this function:

    -static int do_run_update_procedure(struct update_data *ud, struct string_list *err)
    +static int run_update_procedure(struct update_data *ud, struct string_list *err)

We could either skip that, or split that later refactoring into another
commit.

Thanks for working on this, I'm exciting to see more of git-submodule.sh
go away. Hopefully these comments I left are useful / will aid future
reviewer readability of this series.
