Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B97C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 18:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F60E611C0
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 18:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhJNSmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJNSmx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 14:42:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E4C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 11:40:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id np13so5395595pjb.4
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Pe9b1HekYZ33BwlhEp1Zx0nb5Nw0rl4m+Iw5Teq1Rc=;
        b=brKh7IwRnM/5SJI9TPrw9t4eMjIio9C4zGUIVibouqqZTt5Ag/pJVLYDOZn/KNLsvR
         XygTTh+O2TdlqzP/RoYQVIhAo1YWt2oLbhZcBep/c3GqiSMCn4qxBFqh08whljM2PYMz
         26dP1uVBELYbEF3lOFqElrwD3rLHE/K6Gu3pgm1Rpz2cj5HxpvOdGgqAf+hQkTewdebU
         0LWSLyLdqgm0vx3/9bdBmK4wqvizTNWrk/6maKM6HN5A9PegUgFkwCXHLNLPiPvP2kkn
         S1lFnkJOmu5huanxT4yl9kfByRwxxfmiNqINFu6Z/WhvBAkD5yIwJnlykIMc5CapNeL3
         J6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Pe9b1HekYZ33BwlhEp1Zx0nb5Nw0rl4m+Iw5Teq1Rc=;
        b=znBPtza5QhshjfRpdL0pBRUgJqz9uIDRYp9PoztlIdt2alTl+R6FgRV6DILxsoqDyn
         iyD6uPBCmzMwokh0TeBwysDeqG5HDd3ozWBVeYTYUKaaMYtAeXAYzjkdDIhDyykYtx0L
         Yn8jz9oH7MAKLWPSYm94E7Qt+RaW1SRzfKXA+D+ugWnwVtL1Mb1n/E9BTH7RFhap5IGz
         947z9jJ+YR0IQWH+wUKSzEhmJfUGUZ1IwOwy82LDjtdi5K93rT7jOrPPo5p7mez1FUPw
         dQBGb5flXcbKqhP3R+f8kBQ8/p+2+b0n1NyamqS7NU7X04u2ty1t7x3iKryueKuYXkOG
         j8Ww==
X-Gm-Message-State: AOAM533zUN7q46+kOYCy1MhTQd7wK5zsiGjZRjrg0Ue+pcZ2SFkTAg3x
        7Gifg1gfVqSTxjCI2UeUakcKRQ==
X-Google-Smtp-Source: ABdhPJx8EqM+iGWIw7nfo8X15HyYzv2n6qyivPJTjlN2SEJVaFAf4aaclyo86G1ogPcB8lHoSqpDRg==
X-Received: by 2002:a17:90b:3581:: with SMTP id mm1mr22078557pjb.93.1634236847818;
        Thu, 14 Oct 2021 11:40:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:e9ae:673a:ec5:a064])
        by smtp.gmail.com with ESMTPSA id qe17sm3530149pjb.39.2021.10.14.11.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:40:47 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:40:42 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] submodule: record superproject gitdir during
 absorbgitdirs
Message-ID: <YWh5qvHdTyjoToYX@google.com>
References: <20210819200953.2105230-4-emilyshaffer@google.com>
 <20210904172746.3031-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904172746.3031-1-matheus.bernardino@usp.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 04, 2021 at 02:27:46PM -0300, Matheus Tavares wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > Already during 'git submodule add' we record a pointer to the
> > superproject's gitdir. However, this doesn't help brand-new
> > submodules created with 'git init' and later absorbed with 'git
> > submodule absorbgitdir'. Let's start adding that pointer during 'git
> > submodule absorbgitdir' too.
> > 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> >  submodule.c                        | 10 ++++++++++
> >  t/t7412-submodule-absorbgitdirs.sh |  9 ++++++++-
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/submodule.c b/submodule.c
> > index 0b1d9c1dde..4b314bf09c 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -2065,6 +2065,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
> 
> This function has only one caller, `absorb_git_dir_into_superproject()`.
> Perhaps it would be better to set submodule.superprojectGitdir in the caller,
> right after the `else` block in which `relocate...()` is called. This way,
> the config would also be set in the case of nested submodules where the inner
> one already had its gitdir absorbed (which is the case handled by the code in
> the `if` block).

Since relocate_single_git_dir() is the only place where the final
submodule gitdir is resolved, I'll leave the code block where it is;
neither side of the if/else in absorb_git_dir...() learns the final
"new" gitdir, so I'd rather not re-derive it.

Anyway, wouldn't the submodule-who-is-also-a-superproject have gone
through this same codepath itself? I'll see if I can find a test to
validate that.

> 
> >  	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
> >  	char *new_git_dir;
> >  	const struct submodule *sub;
> > +	struct strbuf config_path = STRBUF_INIT, sb = STRBUF_INIT;
> >  
> >  	if (submodule_uses_worktrees(path))
> >  		die(_("relocate_gitdir for submodule '%s' with "
> > @@ -2096,6 +2097,15 @@ static void relocate_single_git_dir_into_superproject(const char *path)
> >  
> >  	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
> >  
> > +	/* cache pointer to superproject's gitdir */
> > +	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */
> 
> s/experimental/extensions/
> 
> On the Review Club, I mentioned we might want to save
> submodule.superprojectGitdir at the worktree config file. But Jonathan and Josh
> gave a better suggestion, which is to cache the superproject gitdir relative to
> the submodule's gitdir, instead of its working tree.
> 
> This way, the worktree config wouldn't be an issue. And more importantly, this
> would prevent `git mv` from making the cached path stale, as Stolee pointed out
> upthread.

Yep, done. Thanks.

> 
> > +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
> > +	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
> > +			       relative_path(get_super_prefix_or_empty(),
> > +					     path, &sb));
> 
> 
> In this code, `the_repository` corresponds to the superproject, right? I
> think `get_super_prefix_or_empty()` should instead be
> `absolute_path(get_git_dir())`, like you did on the previous patch.
> 
> And since the first argument to `relative_path()` will be an absolute path, I
> believe we also need to convert the second one to an absolute path. Otherwise,
> `relative_path()` would return the first argument as-is [1]. (I played around
> with using `get_git_dir()` directly as the first argument, but it seems this
> can sometimes already be absolute, in case of nested submodules.)
> 
> If we store the path as relative to the submodule's gitdir, it should be
> simpler, as `real_new_git_dir` is already absolute:
> 	
> 	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
> 			       relative_path(absolute_path(get_git_dir())
> 					     real_new_git_dir, &sb));
> 
> [1]: I'm not sure if this is intended or if it's a bug. I was expecting that,
> before comparing its two arguments, `relative_path()` would convert any
> relative path given as argument to absolute, using the current working dir path.
> But that's not the case.

Thanks, fixed.

> 
> > +	strbuf_release(&config_path);
> > +	strbuf_release(&sb);
> >  	free(old_git_dir);
> >  	free(real_old_git_dir);
> >  	free(real_new_git_dir);
> > diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> > index 1cfa150768..e2d78e01df 100755
> > --- a/t/t7412-submodule-absorbgitdirs.sh
> > +++ b/t/t7412-submodule-absorbgitdirs.sh
> > @@ -30,7 +30,14 @@ test_expect_success 'absorb the git dir' '
> >  	git status >actual.1 &&
> >  	git -C sub1 rev-parse HEAD >actual.2 &&
> >  	test_cmp expect.1 actual.1 &&
> > -	test_cmp expect.2 actual.2
> > +	test_cmp expect.2 actual.2 &&
> > +
> > +	# make sure the submodule cached the superproject gitdir correctly
> > +	test-tool path-utils real_path . >expect &&
> 
> This should be '.git' instead of '.', since the config caches the path to the
> superproject's gitdir. But ...
> 
> > +	test-tool path-utils real_path \
> > +		"$(git -C sub1 config submodule.superprojectGitDir)" >actual &&
> 
> ... I think we could also avoid converting to an absolute path here, so that we
> can test whether the setting is really caching a relative path. I.e., the test
> could be:
> 
> 	super_gitdir="$(git rev-parse --absolute-git-dir)" &&
> 	test-tool path-utils relative_path "$super_gitdir" "$PWD/sub1" >expect &&
> 	git -C sub1 config submodule.superprojectGitDir >actual &&
> 	test_cmp expect actual

Sure.

> 
> > +
> > +	test_cmp expect actual
> >  '
> 
> It may also be interesting to test if the config is correctly set when
> absorbing the gitdir of nested submodules:
> 
> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index e2d78e01df..c2e5e7dd1c 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -70,3 +70,8 @@ test_expect_success 'absorb the git dir in a nested submodule' '
>  	test_cmp expect.1 actual.1 &&
> -	test_cmp expect.2 actual.2
> +	test_cmp expect.2 actual.2 &&
> +
> +	sub1_gitdir="$(git -C sub1 rev-parse --absolute-git-dir)" &&
> +	test-tool path-utils relative_path "$sub1_gitdir" "$PWD/sub1/nested" >expect &&
> +	git -C sub1/nested config submodule.superprojectGitDir >actual &&
> +	test_cmp expect actual

Ah, thanks. I tried it out, even without the changes you mentioned
above, and this test passes. So I think as I expected, it works because
'sub1' goes through relocate_single_git_dir() as well as 'sub1/nested'.

Thanks for the careful review.

 - Emily
