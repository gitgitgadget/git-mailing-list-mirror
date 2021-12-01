Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C32FC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 13:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbhLANqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 08:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhLANqy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 08:46:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D15CC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 05:43:33 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z5so36764519edd.3
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 05:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pRXLsNTSNQhc+eu6qTK4fYJUl5CQ8DftDJm14KBunwg=;
        b=crEuacCvrlaUWLr+F4U0UX5KIjJ5ep/CFPVifGjOr239EYBqkP7b+bK9OmfFqoqzoq
         BUp63ply+iOlp37YG5Wq8tHc8G67/ztRCE1kOSVhEIY/dBdkDUGbC3t9941wkctavVFd
         Ke9gBOdMfD80u6v3PvRwguvlVcGIvP0dZzd8u7HI6RUBJ3scgOytYFJx1CmHzYcwshU6
         IzAtCJoAwZhvOiXDqRyNFYV50/2tp4P47RVEu8sPxyGMMIqQCDU8vGUA3ZelnMAw7otz
         3w1zhVgS9OuOTxXnfOT3VYnt9CCRSXR0BbQtgIPk9RepphY+kyeIi/SKKtIUx1W6/gFD
         slJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pRXLsNTSNQhc+eu6qTK4fYJUl5CQ8DftDJm14KBunwg=;
        b=B4xuh+4zojmUSBBoYycbr/wdAm3O7Rn3M74iksAwxembB25KUpxL81OX7m29cs3tJD
         oKhdHwaXTM5CtOu/r4z3iEY4h0qtwjoPm7OpxkyZPDHcmOc1np9ybImRbtcvoBLEQH6m
         YLJ9PDpn+08D2s7pLe6RKuCfvjpBhr+6/5GxTmobQjZ1czcG6ZTXA6pLbwJDnrIyRkuK
         v/C6E5gphDtYUF5zM368BCPBLPnwz3fQXYU2GtFWD4Ucx7sUVWp79lKiaut1vvF9Cyb1
         TPIPX6UH+tjof64LFfCIlaHFLOYUmNINVjbI+doOVKAwy37lQpRVkq7TDi+WfysxIC8w
         kt+g==
X-Gm-Message-State: AOAM531Or56FQ45+f4XY96Z2w4+1yzCDHsk7W5ncbwtbUQDHUYZj0wZG
        n8O+1IkD24LMJWY1sqoFdupNuyaVmzCMKQ==
X-Google-Smtp-Source: ABdhPJy3z16u0mto8ZqXl1o8yG//g/8/MwZmAC0CISUsjGRX1CkZuNmP9l+tleE/SKpD/UZfnpA7uA==
X-Received: by 2002:a17:907:6289:: with SMTP id nd9mr7172991ejc.101.1638366211649;
        Wed, 01 Dec 2021 05:43:31 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ch28sm13300189edb.72.2021.12.01.05.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 05:43:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msPtS-001FWG-Pj;
        Wed, 01 Dec 2021 14:43:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] add -i: default to the built-in implementation
Date:   Wed, 01 Dec 2021 14:37:47 +0100
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
 <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>
Message-ID: <211201.86pmqgbful.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 9a5315edfdf (Merge branch 'js/patch-mode-in-others-in-c',
> 2020-02-05), Git acquired a built-in implementation of `git add`'s
> interactive mode that could be turned on via the config option
> `add.interactive.useBuiltin`.
>
> The first official Git version to support this knob was v2.26.0.
>
> In 2df2d81ddd0 (add -i: use the built-in version when
> feature.experimental is set, 2020-09-08), this built-in implementation
> was also enabled via `feature.experimental`. The first version with this
> change was v2.29.0.
>
> More than a year (and very few bug reports) later, it is time to declare
> the built-in implementation mature and to turn it on by default.
>
> We specifically leave the `add.interactive.useBuiltin` configuration in
> place, to give users an "escape hatch" in the unexpected case should
> they encounter a previously undetected bug in that implementation.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/config/add.txt |  6 +++---
>  builtin/add.c                | 15 +++++----------
>  ci/run-build-and-tests.sh    |  2 +-
>  t/README                     |  2 +-
>  t/t2016-checkout-patch.sh    |  2 +-
>  5 files changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
> index c9f748f81cb..3e859f34197 100644
> --- a/Documentation/config/add.txt
> +++ b/Documentation/config/add.txt
> @@ -7,6 +7,6 @@ add.ignore-errors (deprecated)::
>  	variables.
>  
>  add.interactive.useBuiltin::
> -	[EXPERIMENTAL] Set to `true` to use the experimental built-in
> -	implementation of the interactive version of linkgit:git-add[1]
> -	instead of the Perl script version. Is `false` by default.
> +	Set to `false` to fall back to the original Perl implementation of
> +	the interactive version of linkgit:git-add[1] instead of the built-in
> +	version. Is `true` by default.

I think this would be a bit better if we just stole the version you
added for stash.useBuiltin entirely. I.e. from your 336ad8424cb (stash:
document stash.useBuiltin, 2019-05-14), with the relevant s/shell
script/Perl/g etc. replaced.

I.e. that version encouraged users to report any bugs, because we were
really going to remove it soon, as we then did for rebase.useBuiltin in
9bcde4d5314 (rebase: remove transitory rebase.useBuiltin setting & env,
2021-03-23).

The wording in the opening paragraph is also a bit more to the point
there, i.e. calling it "legacy" rather than "original [...]
implementation".

(I notice that the stash.useBuiltin is still there in-tree, hrm...)

> diff --git a/builtin/add.c b/builtin/add.c
> index ef6b619c45e..8ef230a345b 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -237,17 +237,12 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>  	int use_builtin_add_i =
>  		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
>  
> -	if (use_builtin_add_i < 0) {
> -		int experimental;
> -		if (!git_config_get_bool("add.interactive.usebuiltin",
> -					 &use_builtin_add_i))
> -			; /* ok */
> -		else if (!git_config_get_bool("feature.experimental", &experimental) &&
> -			 experimental)
> -			use_builtin_add_i = 1;
> -	}
> +	if (use_builtin_add_i < 0 &&
> +	    git_config_get_bool("add.interactive.usebuiltin",
> +				&use_builtin_add_i))
> +		use_builtin_add_i = 1;
>  
> -	if (use_builtin_add_i == 1) {
> +	if (use_builtin_add_i != 0) {

Style/idiom: This should just be "if (use_builtin_add_i)".

I.e. before we cared about not catching -1 here, but now that it's true
by default we don't care about the distinction between -1 or 1 anymore,
we just want it not to be 0 here.
