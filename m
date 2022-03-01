Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF621C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 07:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiCAHXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiCAHXi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 02:23:38 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7121925EB5
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:22:55 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x5so20719218edd.11
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GWdW7E63clbLwvtzlZxXDqczoXs09urZDEjbzGONoz0=;
        b=HFkz0MnxPas8ve1WyoZMNB9f3l0FJZYw+V17L6p4oVLimKWGFL6IPr/q+UW2p+lkJb
         jv/QAATNBisSkWug5JDs6wvS/ei6tmODJyYp0bu078cZflPUwk218PagX2M8YlWac6BV
         ewvdGmiKUyKew7EoPvQ5VrKUH6VUr5AciCYOPv3qEKlLVWTYHQnUlJ4jxbsHvMALg+Ik
         0xZURyOBPh94sSmUC/LsgOyTVdI0JGr/nBNQBNsDesxULihvCVp5r05EUjYGxCU+Oteb
         5qQJ8C0GKhXOPmn2MnAaB5Pat/jnBgtzBnGaWVg2YbJiNeq+bwdMEceXiArMVl+MDApH
         HpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GWdW7E63clbLwvtzlZxXDqczoXs09urZDEjbzGONoz0=;
        b=r5odlx20fYpNM/w2qGRjLWyuGux/6QAO/30NJ3xceZQgyen/mIecjsetwdD6L7DVQk
         5HJZEgCV8GyQiaIWDb5SrgXXzSy0CTwrEhUhJSSwuab5umRAoYcXxjo12AaKHw+hJ1sY
         C/AeAZiZDy4yq9rmrELn3gyzLFGWoWvY0Zd1yg44RNLgEYUrMQ1ajHE8qiw73AfDdDPM
         HFqExqeCYQTazHilxvQXW/gXX0IJySoapSPvkwiCYjIasOklPixxv/TcKCR55y1W7it/
         SjtA+G2l4GaH2c/LtHNVgbIJKOoQ/Z3cC5mSj0ERwHqvsfaFW8pskK/RfgpdFXG0vetr
         3btQ==
X-Gm-Message-State: AOAM532G3Smsjhms6OVmUKEDlpjZhrVxqqTMmRt7FAqtDVc1tsJpRnTW
        B7dKXnlfCRvdbTHvFOu/FlY=
X-Google-Smtp-Source: ABdhPJzVXseD05lFcDITpuGSbiJ38Ji6/0pvLEKr401U81vpvQlV6qaTLv2TMugGpCpvutMn/iGEtA==
X-Received: by 2002:a05:6402:3549:b0:412:b31c:5509 with SMTP id f9-20020a056402354900b00412b31c5509mr23395520edd.224.1646119373784;
        Mon, 28 Feb 2022 23:22:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709066d8700b006d4b4d137fbsm5060132ejt.50.2022.02.28.23.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:22:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOwqS-001vJv-DF;
        Tue, 01 Mar 2022 08:22:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 13/13] submodule--helper update-clone: check for
 --filter and --init
Date:   Tue, 01 Mar 2022 08:21:58 +0100
References: <20220301000816.56177-1-chooglen@google.com>
 <20220301044132.39474-1-chooglen@google.com>
 <20220301044132.39474-14-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220301044132.39474-14-chooglen@google.com>
Message-ID: <220301.86o82q16ib.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Glen Choo wrote:

> "git submodule update --filter" also requires the "--init" option. Teach
> update-clone to do this usage check in C and remove the check from
> git-submodule.sh.
>
> In addition, change update-clone's usage string so that it teaches users
> about "git submodule update" instead of "git submodule--helper
> update-clone" (the string is copied from git-submodule.sh). This should
> be more helpful to users since they don't invoke update-clone directly.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> Since we expect users to act upon the usage string, I've updated it to
> reflect "git submodule update" [1] (since that's what users actually
> invoke), but I feel a bit iffy about not being able to use
> usage_with_options() (because the options and usage string are for
> different commands).
>
> This might indicate that this is work we should put off until the
> conversion to C is mostly complete, but on the other hand, the usage
> string is still more helpful than it used to be because we never
> presented users with the options anyway.
>
> [1] It's not immediately obvious which command we prefer to show - some
> other commands use "git submodule--helper" and others use "git
> submodule".
>
>  builtin/submodule--helper.c | 20 +++++++++++++++++++-
>  git-submodule.sh            |  5 -----
>  2 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2ffc070319..3e8a05a052 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2543,7 +2543,12 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>  	};
>  
>  	const char *const git_submodule_helper_usage[] = {
> -		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
> +		N_("git submodule [--quiet] update"
> +		"[--init [--filter=<filter-spec>]] [--remote]"
> +		"[-N|--no-fetch] [-f|--force]"
> +		"[--checkout|--merge|--rebase]"
> +		"[--[no-]recommend-shallow] [--reference <repository>]"
> +		"[--recursive] [--[no-]single-branch] [--] [<path>...]"),

Since this has <repository>, <path> etc. it should still be marked for
translation with N_().
