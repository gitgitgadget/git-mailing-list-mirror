Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B3E20248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfCTLQ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:16:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35798 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfCTLQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:16:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so1600953wmd.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cJoOyFzvF9MT99DTZ0Vn4l2KraCMS9S6isn7DaCJnXY=;
        b=W6JGR48jddG33F02y95QYlbqyDQuiO0nS26IeWeIJrvvvpEbMjkFMGmHMEa4bCxw+z
         GU7y2b9wiReMwgmAqDpkxOvd4hC3vGePMaPFsJsm6iaUkNlTDMOVoHRUqYEJokeHZBgL
         ZwEzoXD2X+St4uAri/USrw+yhHwIXQ7WeRVrQw9SFOW11kBau8q10aUG+4w+6liClVRz
         sTT6JejLO4KroZPuHuRX3qRvmdO2cdDiFGykDT5gLyVCX8+TB5Dw8JrJ65vZz2UYVkjW
         /bOJ19NtkYr0nRua1l7jF1nrQ1HJdXdpNpLNNPiDDRfAkLqait1dP6tbbi/FaCCCz3Vh
         P4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cJoOyFzvF9MT99DTZ0Vn4l2KraCMS9S6isn7DaCJnXY=;
        b=csMBtgqQWLnO1s1YJVEZyA3VeBEHqTlgSd3Fsgal7Yt0KLAUJXX6Ltgu36suOc0RdN
         Tfg+YHYUOW4O3FPVeQUbGVkJcd3LYV+u16sJ8D2pnRzhbqlRd967ZZdfn9X6TJO2n99w
         Mz/A9EMohdcIf5l+6tEUJAwp2aqppz0i6STZi2pZK8KnveSElbf946RmeRfoSf3s2++2
         tttzKllOw75civIvR/oI5TqqMNf3BglvS1CQ36skoMG4qkT6P5v2xgCS4cF+rtOtB+JZ
         UHoAtLvSqeSopz95ssC6RhvZ4o+47z5titwV4HCAKGndZ9lyf2BI87LYUBw5YOW1AaEj
         pDlA==
X-Gm-Message-State: APjAAAU/qj7y8jdEFn9JhDb4ZpI062TYTSlhomnPsoOlhOxSeszVfjgF
        hqg6BIV4xdOqIbYatJfLLQo=
X-Google-Smtp-Source: APXvYqwfGXMBe8z0ZdqLGFBECWDhv4do26YwgMB0tGUr5N2B7sUO52bD4NZuQKyHjbr1n5Lay1ILuw==
X-Received: by 2002:a1c:9ad1:: with SMTP id c200mr2606921wme.140.1553080617167;
        Wed, 20 Mar 2019 04:16:57 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.googlemail.com with ESMTPSA id t202sm6570057wmt.0.2019.03.20.04.16.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:16:56 -0700 (PDT)
Subject: Re: [PATCH v4 22/26] switch: reject if some operation is in progress
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, rybak.a.v@gmail.com
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
 <20190317124926.17137-23-pclouds@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <83ddb0c1-26f4-f1ff-3d26-543d8fee0bce@gmail.com>
Date:   Wed, 20 Mar 2019 11:16:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190317124926.17137-23-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy

The new switch command is shaping up nicely

On 17/03/2019 12:49, Nguyễn Thái Ngọc Duy wrote:
> Unless you know what you're doing, switching to another branch to do
> something then switching back could be confusing. Worse, you may even
> forget that you're in the middle of something. By the time you realize,
> you may have done a ton of work and it gets harder to go back.
> 
> The new option --ignore-in-progress is added to override this check.
> However it's probably just safer to create a separate worktree for
> that separate thing you want to work on and leave this worktree
> alone (unless of course creating or preparing worktrees are not cheap).
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/checkout.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2aeaac092d..21a585eaa9 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -24,6 +24,7 @@
>  #include "tree.h"
>  #include "tree-walk.h"
>  #include "unpack-trees.h"
> +#include "wt-status.h"
>  #include "xdiff-interface.h"
>  
>  static const char * const checkout_usage[] = {
> @@ -56,6 +57,7 @@ struct checkout_opts {
>  	int accept_pathspec;
>  	int switch_branch_doing_nothing_is_ok;
>  	int only_merge_on_switching_branches;
> +	int can_switch_when_in_progress;
>  
>  	const char *new_branch;
>  	const char *new_branch_force;
> @@ -1257,6 +1259,26 @@ static int checkout_branch(struct checkout_opts *opts,
>  	    !new_branch_info->path)
>  		die_expecting_a_branch(new_branch_info);
>  
> +	if (!opts->can_switch_when_in_progress) {
> +		struct wt_status_state state;
> +
> +		memset(&state, 0, sizeof(state));
> +		wt_status_get_state(the_repository, &state, 0);
> +
> +		if (state.merge_in_progress)
> +			die(_("cannot switch branch while merging"));
> +		if (state.am_in_progress)
> +			die(_("cannot switch branch in the middle of an am session"));
> +		if (state.rebase_in_progress || state.rebase_in_progress)

I think one of those should be state.rebase_interactive_in_progress

Best Wishes

Phillip

> +			die(_("cannot switch branch while rebasing"));
> +		if (state.cherry_pick_in_progress)
> +			die(_("cannot switch branch while cherry-picking"));
> +		if (state.revert_in_progress)
> +			die(_("cannot switch branch while reverting"));
> +		if (state.bisect_in_progress)
> +			die(_("cannot switch branch while bisecting"));
> +	}
> +
>  	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
>  	    !opts->ignore_other_worktrees) {
>  		int flag;
> @@ -1514,6 +1536,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	opts.only_merge_on_switching_branches = 0;
>  	opts.accept_pathspec = 1;
>  	opts.implicit_detach = 1;
> +	opts.can_switch_when_in_progress = 1;
>  
>  	options = parse_options_dup(checkout_options);
>  	options = add_common_options(&opts, options);
> @@ -1539,6 +1562,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
>  			 N_("second guess 'git switch <no-such-branch>'")),
>  		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
>  			 N_("throw away local modifications")),
> +		OPT_BOOL(0, "ignore-in-progress", &opts.can_switch_when_in_progress,
> +			 N_("allow to switch branch when some operation is still in progress")),
>  		OPT_END()
>  	};
>  	int ret;
> @@ -1549,6 +1574,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
>  	opts.switch_branch_doing_nothing_is_ok = 0;
>  	opts.only_merge_on_switching_branches = 1;
>  	opts.implicit_detach = 0;
> +	opts.can_switch_when_in_progress = 0;
>  
>  	options = parse_options_dup(switch_options);
>  	options = add_common_options(&opts, options);
> 

