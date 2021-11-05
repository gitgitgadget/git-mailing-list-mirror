Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A301C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2432861262
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhKEJKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhKEJKu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 05:10:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97792C061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 02:08:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j21so30571768edt.11
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gODJMhLBj62ItsrSb22iDCXBCQEfb/IYeMoc3G+1tps=;
        b=XdnzooY5PgdT/XunTAiIy8ozddUCHs2Mhwfii/Si2J9krhoTazvfK5jE7ZS11r4LXr
         LAxHdwli1efVeGflz2w0EchhLtdD+HMHxGkDtmaupy2Hp1OVxLgg1/5xa2oXs1oF3QJY
         +AVSn2HBvElUl7EyHwHMpag6EoAbNs3IYi59MWXCqLp5dOrBE92WY3nOq0XMLGXsAYMK
         zvTqDFN+pPHI2Q+hZHQoBcragVFRYRMLxnW3fQv42D45UiQGHuSI78blT6lpAxPW7dSX
         i4XoGgUN3vCG6Y8LKHEq8tBMBROGjcH+0HoNdsBHGQs+m0Ngwr6yIWpaxnPkZlF40N7w
         Gafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gODJMhLBj62ItsrSb22iDCXBCQEfb/IYeMoc3G+1tps=;
        b=V67UDZv8sYlc8e62hsGrCq6tvndqcxBfhfHcZkD6K2mXLwK5ZG1AfCbV3IVl/dUweZ
         uzlzq/ape7eS2EFEXjs91YqwJdn1FT1kcF1AELwcUTQIdT98FRLttp6+X9h35q4lC7ZQ
         okZA00L0/xiUk/zP1Az+YQpoQPlQncaUzdDGIBMUHSuBXl+d1DXf8ZjutSsNRvyKiKjp
         c5eti53EHPaGGKvTKWVpqq0RFMiF6yvK55lCAaChLGhTYp4qOQ991kSYCxVeFrUwI6zw
         E+LURnVTeyZTfgxe+bVOTHYAaqB4pZfdkOMR+7wiXu9i6vOfaYpfhIOnLYxI01Ot9E3r
         5rUw==
X-Gm-Message-State: AOAM533FB7FdGpGtFPs600jW1ZhJ5Pc/9+5aeLpt9EeyUXez95I7/FAC
        B/GhmfgcEtWHDb6niSVBpIA=
X-Google-Smtp-Source: ABdhPJwHcGldDwcfK3M2w2rrrYOoTa1p841EGGmuXqGuVPHUgo0hbUX3C3xE2S/xSzjr/2Etl5Iukw==
X-Received: by 2002:a05:6402:158:: with SMTP id s24mr77725155edu.189.1636103289095;
        Fri, 05 Nov 2021 02:08:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f22sm4176878edu.26.2021.11.05.02.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 02:08:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mivCi-000HRL-9w;
        Fri, 05 Nov 2021 10:08:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>
Subject: Re: [PATCH v5 4/4] submodule: record superproject gitdir during
 'update'
Date:   Fri, 05 Nov 2021 09:51:12 +0100
References: <20211104234942.3473650-1-emilyshaffer@google.com>
 <20211104234942.3473650-5-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211104234942.3473650-5-emilyshaffer@google.com>
Message-ID: <211105.86wnlngebr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 04 2021, Emily Shaffer wrote:

> A recorded hint path to the superproject's gitdir might be added during
> 'git submodule add', but in some cases - like submodules which were
> created before 'git submodule add' learned to record that info - it might
> be useful to update the hint. Let's do it during 'git submodule
> update', when we already have a handle to the superproject while calling
> operations on the submodules.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  git-submodule.sh            | 14 ++++++++++++++
>  t/t7406-submodule-update.sh | 12 ++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 652861aa66..873d64eb99 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -449,6 +449,20 @@ cmd_update()
>  			;;
>  		esac
>  
> +		# Cache a pointer to the superproject's common dir. This may have
> +		# changed, unless it's a fresh clone. Writes it to worktree
> +		# if applicable, otherwise to local.
> +		if test -z "$just_cloned"
> +		then
> +			sm_gitdir="$(git -C "$sm_path" rev-parse --absolute-git-dir)"
> +			relative_gitdir="$(git rev-parse --path-format=relative \
> +							 --prefix "${sm_gitdir}" \
> +							 --git-common-dir)"
> +
> +			git -C "$sm_path" config --worktree \
> +				submodule.superprojectgitdir "$relative_gitdir"
> +		fi
> +

Aside from the "is this really needed anymore?" comment on this caching
strategy in general I had in [1] does this really need to be adding new
shell code to git-submodule.sh given that we're actively trying to get
rid of it entirely and move it over to C.

I.e. here we've just called "git submodule--helper
run-update-procedure", and we pass it "$sm_path" (but not "$recursive",
but could easily do so).

It needs to clone this new submodule, so presumably it already has a
"$sm_gitdir" equivalent, and we can turn that into the same relative
path, no?

Can't we call this with a git_config_set*() somewhere in that code?

*investigates a bit*

Okey, so I see that [2] is part of a series that Atharva Raykar had a
version of (including this new git-submodule.sh code above) [3] rebased
on top of an older version of this topic. I.e. this bit is that part of that patch:

+       git_config_set_in_file(config_path, "submodule.superprojectGitdir",
+                              relative_path(get_git_dir(),
+                                            update_data->sm_path, &sb));

I also vaguely recall that Junio ejected his topic to make room for this
topic first.

Maybe I've missed some update on this but is his [2][3] broken in
combination with your topic here? And re[1] is whatever "caching" is
being done here still beneficial once this is all moved to C?

In your [4] there seems to be an agreement to do it the other way
around, but as noted in the mail linked from [1] maybe the caching isn't
needed anymore then?

1. https://lore.kernel.org/git/211105.861r3vhtot.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/20211013051805.45662-8-raykar.ath@gmail.com/
3. https://lore.kernel.org/git/20211013051805.45662-1-raykar.ath@gmail.com/
4. https://lore.kernel.org/git/YWiXL+plA7GHfuVv@google.com/
