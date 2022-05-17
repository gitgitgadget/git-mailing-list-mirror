Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A13C433F5
	for <git@archiver.kernel.org>; Tue, 17 May 2022 14:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbiEQOxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 10:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349471AbiEQOxV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 10:53:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53848E60
        for <git@vger.kernel.org>; Tue, 17 May 2022 07:52:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i9so3669778edr.8
        for <git@vger.kernel.org>; Tue, 17 May 2022 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KyQLN/VmE05UPTrvFiRT5Z/7ZmMfpQ26L9vnPyy/35Q=;
        b=qz3HTLKJV9z/ridewKfd0S+WId9SxF4BiJVKZpfYRyUOKgQyELLMVvFun8cR1CP6ys
         6Vm8Z1ICkMIuvEB3SM/4Uy17Fqf2+GHfyVxkeDGlzKlb7TPq4ApP1hiVFWC3wJ2bC2V7
         grKVZxU0GbUfeGLCqGhChCBZ8bJvnip7ZtjO75vaXxrNdkB+DpTDUxCzwKmzCHBSPEMv
         pYkF+UvK++Uu7xDL1jVkxLZJ/OnGkyOh+y00Fm+SGrPy42QbbXe5KUuWr+b5BtY5z5JI
         Jqv4iOZItuyWdnovTm7VodU13tuHcDuXbd3Q7W4YZXBVe3+weHqtkKZcEeWh1Hoq4RI5
         tQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KyQLN/VmE05UPTrvFiRT5Z/7ZmMfpQ26L9vnPyy/35Q=;
        b=i12zYFhPXLdGkJ4JXq3iW30pvVDGmPhXcZy+GY9yPzUSJCzuCWPcghkbhFAHAcUWu1
         upgvaa+1VpoyP+QGV35pb9VAXa6JwzHNYzuchn+21sNnLypxXM772FKcZr0p+gzgXWdF
         c9HOSI/Sb0S83VbCt47YPHTgxt/ljUrP1AOkrVPR9FoIan2sqXa5wlQOgN23rUVSf1e0
         RVSMMB+N5tqlny0koFFFb/24WgLnz6PdW5lA9Oyfx/hP6Cdz2XkyftqWoZpVDui1ZYkC
         QQWrpYEaW+SHQofeqnz7i1bOotk7lBewO847xKwNOKS11J5YhFUozfq9p0pv2zNjcPjK
         hQhg==
X-Gm-Message-State: AOAM532J5mlQL4rI0ny8aQbp7bvRPdodt8sWIOcMoi20cbxorR50OXGd
        qXnF9gPsf5V3UIsSA0tfN++6J2xel8A=
X-Google-Smtp-Source: ABdhPJz0zBxTmzUsAocjVSku/ROFGbZC5QG1vgRTnLoKs+ryQiRfffqb3abYR/uJNagFl/LrRRZbDw==
X-Received: by 2002:a05:6402:42d4:b0:416:5cac:a9a0 with SMTP id i20-20020a05640242d400b004165caca9a0mr19549104edc.86.1652799162059;
        Tue, 17 May 2022 07:52:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t25-20020a170906a11900b006f3ef214dd0sm1126331ejy.54.2022.05.17.07.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:52:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nqyYy-001dIC-8L;
        Tue, 17 May 2022 16:52:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 3/7] scalar: validate the optional enlistment argument
Date:   Tue, 17 May 2022 16:51:59 +0200
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
 <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
 <da9f52a82406ffc909e9c5f2b6b5e77818d972c0.1652210824.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <da9f52a82406ffc909e9c5f2b6b5e77818d972c0.1652210824.git.gitgitgadget@gmail.com>
Message-ID: <220517.867d6k6wjr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 10 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `scalar` command needs a Scalar enlistment for many subcommands, and
> looks in the current directory for such an enlistment (traversing the
> parent directories until it finds one).
>
> These is subcommands can also be called with an optional argument
> specifying the enlistment. Here, too, we traverse parent directories as
> needed, until we find an enlistment.
>
> However, if the specified directory does not even exist, or is not a
> directory, we should stop right there, with an error message.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/scalar/scalar.c          | 6 ++++--
>  contrib/scalar/t/t9099-scalar.sh | 5 +++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index 1ce9c2b00e8..00dcd4b50ef 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -43,9 +43,11 @@ static void setup_enlistment_directory(int argc, const char **argv,
>  		usage_with_options(usagestr, options);
>  
>  	/* find the worktree, determine its corresponding root */
> -	if (argc == 1)
> +	if (argc == 1) {
>  		strbuf_add_absolute_path(&path, argv[0]);
> -	else if (strbuf_getcwd(&path) < 0)
> +		if (!is_directory(path.buf))
> +			die(_("'%s' does not exist"), path.buf);
> +	} else if (strbuf_getcwd(&path) < 0)
>  		die(_("need a working directory"));
>  
>  	strbuf_trim_trailing_dir_sep(&path);
> diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
> index 2e1502ad45e..9d83fdf25e8 100755
> --- a/contrib/scalar/t/t9099-scalar.sh
> +++ b/contrib/scalar/t/t9099-scalar.sh
> @@ -85,4 +85,9 @@ test_expect_success 'scalar delete with enlistment' '
>  	test_path_is_missing cloned
>  '
>  
> +test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
> +	! scalar run config cloned 2>err &&

Needs to use test_must_fail, not !
