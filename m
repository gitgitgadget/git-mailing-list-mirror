Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75E6C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 19:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978116109E
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 19:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhJNTx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 15:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbhJNTx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 15:53:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA8DC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 12:51:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k7so22163640wrd.13
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=AHaahpW5+ntq6i5onb3iQ/k9KeG+ZQGi3uJHIfqnVxU=;
        b=U5FWdvbPoFjBYikJ/2kRYyQswdaDd/1I0WZSxTwZsQ9T7nZgOhgrAs/0zRIzo6ErgR
         Tm5CssdRogoBjB7yQJYRLGe8PiWy1oYVEo5QcOs8HciwgClXMrmBr02OySM+yKMkDHeo
         OVxfcWOWpD0ULcsVeBb8n/8GXc2dk8AZLPueL3mvs67WZBFdY9EvWN3Q7dbuxoIRXzmf
         Qh4FhjRTwWZ/Dpc7tnamgdgQVn/iVBlK3aGnLteA+wHOt7q59NaPua8sUfGHlFdYyPZ/
         S0xv4S1lECqrXvFGPuLUTQcPUjKSiIrFa8Q+WDr3gcpyUfWMFE0/r1q+KpdTg9eh1Tij
         46Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=AHaahpW5+ntq6i5onb3iQ/k9KeG+ZQGi3uJHIfqnVxU=;
        b=ZvRewYDGGjbSdjnKzbjz4UB3zXgwvVcBp9WwEqcCK9HGrcSxrvoYC9QbXT0ljKlhxw
         vUp5Hv7C9gkepmuiB7b3cv02OF0azX6e/6OJyHmeqoEn2kE+9g6GnjA8fOYKhfdL5/SH
         YK8cFD7ETBo0BQzCN3wXmr6VORsL91XLWUC5k4NkZrdv8RTxjRbndtS94bPjYFhGvHWC
         KdZcxqXFHmuk0vC3FXN+aw+O2bvFGhQWEFocPEXUr5fiNuAO3kxo1wtMG/fEtFey1ngs
         XGO+qbDsKmHl4kxDyyQnaYE+RvknF8aOQrWep2jV48Bqlhgji0Zln7aRLiaw4LFQLhpN
         5X6g==
X-Gm-Message-State: AOAM531hzNT6sYSxD65gN4grOmuTMnSelv06op56eH8+sVzZ4D29y1px
        ELoZ840miFzkv3232ihcoWygMv405nk9Kg==
X-Google-Smtp-Source: ABdhPJzzZaUsUL/+bjuRqYeNcYqnxB87LS2D2xjFudUyhigHy61LAt7uUdacJFTFbyGnZ8I09tjljA==
X-Received: by 2002:adf:e30d:: with SMTP id b13mr9180736wrj.438.1634241079099;
        Thu, 14 Oct 2021 12:51:19 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r128sm2305214wma.44.2021.10.14.12.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:51:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] introduce submodule.superprojectGitDir cache
Date:   Thu, 14 Oct 2021 21:25:51 +0200
References: <20210616004508.87186-1-emilyshaffer@google.com>
 <20210616004508.87186-3-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210616004508.87186-3-emilyshaffer@google.com>
Message-ID: <87r1cnfkqx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 15 2021, Emily Shaffer wrote:

> Teach submodules a reference to their superproject's gitdir. This allows
> us to A) know that we're running from a submodule, and B) have a
> shortcut to the superproject's vitals, for example, configs.
>
> By using a relative path instead of an absolute path, we can move the
> superproject directory around on the filesystem without breaking the
> submodule's cache.
>
> Since this cached value is only introduced during new submodule creation
> via `git submodule add`, though, there is more work to do to allow the
> cache to be created at other times.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/config/submodule.txt | 12 +++++++++
>  builtin/submodule--helper.c        |  4 +++
>  t/t7400-submodule-basic.sh         | 40 ++++++++++++++++--------------
>  3 files changed, 38 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> index d7a63c8c12..7c459cc19e 100644
> --- a/Documentation/config/submodule.txt
> +++ b/Documentation/config/submodule.txt
> @@ -90,3 +90,15 @@ submodule.alternateErrorStrategy::
>  	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
>  	or `info`, and if there is an error with the computed alternate, the
>  	clone proceeds as if no alternate was specified.
> +
> +submodule.superprojectGitDir::
> +	The relative path from the submodule's worktree  to the superproject's
> +	gitdir. This config should only be present in projects which are
> +	submodules, but is not guaranteed to be present in every submodule. It
> +	is set automatically during submodule creation.
> ++
> +	In situations where more than one superproject references the same
> +	submodule worktree, the value of this config and the behavior of
> +	operations which use it are undefined. To reference a single project
> +	from multiple superprojects, it is better to create a worktree of the
> +	submodule for each superproject.
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d55f6262e9..d60fcd2c7d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1910,6 +1910,10 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
>  					   error_strategy);
>  
> +	git_config_set_in_file(p, "submodule.superprojectGitdir",
> +			       relative_path(absolute_path(get_git_dir()),
> +					     path, &sb));
> +
>  	free(sm_alternate);
>  	free(error_strategy);
>  

Am I correct that what this series really does is avoid needing to:

1. Run the equivalent of $(git rev-parse --absolute-git-dir), let's call
   the result of that $X.
2. Feed that to the equvialent of $(git -C $X/../ rev-parse
   --absolute-git-dir)
3. Check if the relationship between the two is really that of a
   submodule, i.e. running "git submodule status", check if $X contains
   ".git/modules/" etc.

I see an earlier iteration of this series had such a shell-out, and that
this is the "cache":
https://lore.kernel.org/git/20210423001539.4059524-5-emilyshaffer@google.com/;
and your v1 cover letter seems to support the above summary:
https://lore.kernel.org/git/20210611225428.1208973-1-emilyshaffer@google.com/

I think it's fine to fine to add such a cache in principle if it's needed.

But I'm a bit iffy on a series that's structured in a way as to not
start by asserting that we should have given semantics without the
cache, and then adds the cache later as an optional optimization.

Particularly as the whole submodule business is moving to C, so isn't
this whole caching business something we can avoid doing, and instead
just call a C function? The optimization part of this was not calling
"git rev-parse" on every submodule invocation wasn't it, not avoiding a
few syscalls that deal with the FS.

Your initial RFC had modifications to git-submodule.sh, in the interim
it seems that's been moved sufficiently to C that we're modifying just
the submodule.c here.

I'm not very familiar with setup_git_directory_gently_1(),
discover_git_directory() etc, but wherever you are in a git worktree
we'll chdir() to the top-level when running built-ins.

So that gives us step #1 of the above. And #2 would be adding "/../" to
the end of that path and running those functions again? Perhaps with a
#3 for "is there a submodule relationship?".

Even if we still have some bits in shellscript etc, couldn't we then
setenv() that in some GIT_* variable, e.g. GIT_SUPERPROJECT_DIR?

Or is the problem really that this isn't a cache, because we can't say
with absolute certainty that there is such a gitdir/submodule
relationship, except at the time of running "git submodule" in the
former for some reason?
