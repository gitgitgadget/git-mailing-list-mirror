Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8E1C48BCD
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F46D610A7
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFJJep (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJJeo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 05:34:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA0DC061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:32:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so6092174wmd.5
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kLMfFq9H1RUKG4vru3WlRkDgYG9xcrG50Ylz7Ri0ENw=;
        b=WqRiSaWIfWLoBQvMXgutYLI3zw3mPziUqvAv3qz9fyCpIUfGrLN1kJagJayusn39yi
         olHG/HYF4DWFHo/ATK8Dvb+0THZF0ZiwMEVT0Wj10qje0E/mFk6QAyoPR3Q162A9Ft9L
         5Uw/zw6iT7QLFxCC3k0JrsM7/zoKn04vh4mo6YL2E5gpGjOEPfSFWpkcn9vZz2JGNPvG
         f2+9QFO3NF7Fq+cRxQYM9tMbhVgxruStUUEnWx0owfM8F7yN5NK6cQ0sIlpeATOaxPng
         kOM4PBMVPhFjZWKKeCfYsB2YcUTGRq0ulDLjdnirT+t1Ja2ShYhUnH8kUCdsUhboxdpv
         rHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kLMfFq9H1RUKG4vru3WlRkDgYG9xcrG50Ylz7Ri0ENw=;
        b=QNj6yQB4vMagHVw6HrWRy6SfWlEQ1GoOQR2iB7ArFQE93s0yhV+qKpOakv7RFqXW1I
         I0cHhuFDm3A7ixw4in5LBVcY0RA0zEwVgSN+cwulP+FHGBdlnTVotU5s3WCJjl4Sw7hG
         SUTarcL3KpfSMyBqnXCz63KuKugxfZpkma0FYo5CQW4ucK1mcA4buKLuYxJ8zULHVLmf
         NFIX73dohGfc05h4wXCG48wvqgnCXyFXzhf1igcdGEg6yjtnPQZR1ruHknmxf5iR4xKX
         p7nb3yy8ee1LTlKLwx+XOqQDSuZzPPmENR7nKV7eAtI0Gddd7kygEnWH5mNuncxFMks+
         lcwQ==
X-Gm-Message-State: AOAM530eAmHs6tEgppV/6K3+Kh0IQlFS/En6r7e5VJTJFx1BHWkwUTru
        RzcF/LFOMGUyb915lwC2wEE=
X-Google-Smtp-Source: ABdhPJyvczA42DVGRWf4kku1KrpDZDcZW3sCGUjxGzzcUG0WCfh4YFuKislpzt8Tpoa2BdgQywA82A==
X-Received: by 2002:a1c:2384:: with SMTP id j126mr4020132wmj.59.1623317548648;
        Thu, 10 Jun 2021 02:32:28 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id o3sm3044217wrm.78.2021.06.10.02.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 02:32:28 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/7] checkout: fix merge.conflictstyle handling
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-5-felipe.contreras@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b4b9264d-1c17-1a62-f0ec-2791ab20adeb@gmail.com>
Date:   Thu, 10 Jun 2021 10:32:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210609192842.696646-5-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/06/2021 20:28, Felipe Contreras wrote:
> Currently both merge.conflictStyle and `git commit --merge
> --conflict=diff3` don't work together, since the former wrongly
> overrides the later.
> 
> The way merge configurations are handled is not correct.
> It should be possible to do git_config(merge_recursive_config, ...) just
> like we can with git_diff_basic_config and others.

It would be helpful to explain what the problem with 
merge_recursive_config() actually is rather than just saying "it should 
be possible ..."

> Therefore builtins like `git merge` can't call this function at the
> right time.
 >
> We shuffle the functions a little bit so at least merge_recursive_config
> doesn't call git_xmerge_config directly and thus override previous
> configurations.

Rather than papering of the problem, how difficult would it be to add a 
field to ll_merge_options and pass the conflict style with that rather 
than fiddling with the order that we set a global variable.

Does this change affect 'am/apply -3'? - Do they still read the config 
setting properly?

Best Wishes

Phillip

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>   builtin/merge-recursive.c          |  3 +++
>   builtin/merge.c                    |  4 ++++
>   merge-recursive.c                  |  2 +-
>   sequencer.c                        |  5 +++++
>   t/t6440-config-conflict-markers.sh | 31 ++++++++++++++++++++++++++++++
>   5 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
> index a4bfd8fc51..80f9279b4c 100644
> --- a/builtin/merge-recursive.c
> +++ b/builtin/merge-recursive.c
> @@ -4,6 +4,7 @@
>   #include "tag.h"
>   #include "merge-recursive.h"
>   #include "xdiff-interface.h"
> +#include "config.h"
>   
>   static const char builtin_merge_recursive_usage[] =
>   	"git %s <base>... -- <head> <remote> ...";
> @@ -30,6 +31,8 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
>   	char *better1, *better2;
>   	struct commit *result;
>   
> +	git_config(git_xmerge_config, NULL);
> +
>   	init_merge_options(&o, the_repository);
>   	if (argv[0] && ends_with(argv[0], "-subtree"))
>   		o.subtree_shift = "";
> diff --git a/builtin/merge.c b/builtin/merge.c
> index eddb8ae70d..7aa3dbb111 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -43,6 +43,7 @@
>   #include "commit-reach.h"
>   #include "wt-status.h"
>   #include "commit-graph.h"
> +#include "xdiff-interface.h"
>   
>   #define DEFAULT_TWOHEAD (1<<0)
>   #define DEFAULT_OCTOPUS (1<<1)
> @@ -659,6 +660,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>   	if (status)
>   		return status;
>   	status = git_gpg_config(k, v, NULL);
> +	if (status)
> +		return status;
> +	status = git_xmerge_config(k, v, NULL);
>   	if (status)
>   		return status;
>   	return git_diff_ui_config(k, v, cb);
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d146bb116f..10e6e1e4d1 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3845,7 +3845,7 @@ static void merge_recursive_config(struct merge_options *opt)
>   		} /* avoid erroring on values from future versions of git */
>   		free(value);
>   	}
> -	git_config(git_xmerge_config, NULL);
> +	git_config(git_default_config, NULL);
>   }
>   
>   void init_merge_options(struct merge_options *opt,
> diff --git a/sequencer.c b/sequencer.c
> index 0bec01cf38..9e2bdca0f6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -34,6 +34,7 @@
>   #include "commit-reach.h"
>   #include "rebase-interactive.h"
>   #include "reset.h"
> +#include "xdiff-interface.h"
>   
>   #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>   
> @@ -224,6 +225,10 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
>   	if (status)
>   		return status;
>   
> +	status = git_xmerge_config(k, v, NULL);
> +	if (status)
> +		return status;
> +
>   	return git_diff_basic_config(k, v, NULL);
>   }
>   
> diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
> index 44f79ac91b..485ad0eee0 100755
> --- a/t/t6440-config-conflict-markers.sh
> +++ b/t/t6440-config-conflict-markers.sh
> @@ -89,4 +89,35 @@ test_expect_success 'notes' '
>   	)
>   '
>   
> +test_expect_success 'checkout' '
> +	test_create_repo checkout &&
> +	(
> +		test_commit checkout &&
> +
> +		fill a b c d e >content &&
> +		git add content &&
> +		git commit -m initial &&
> +
> +		git checkout -b simple master &&
> +		fill a c e >content &&
> +		git commit -a -m simple &&
> +
> +		fill b d >content &&
> +		git checkout --merge master &&
> +		! grep -E "\|+" content &&
> +
> +		git config merge.conflictstyle merge &&
> +
> +		git checkout -f simple &&
> +		fill b d >content &&
> +		git checkout --merge --conflict=diff3 master &&
> +		grep -E "\|+" content &&
> +
> +		git checkout -f simple &&
> +		fill b d >content &&
> +		git checkout --merge --conflict=merge master &&
> +		! grep -E "\|+" content
> +	)
> +'
> +
>   test_done
> 
