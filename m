Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3179C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8674361058
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhKDXYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 19:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhKDXYv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 19:24:51 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9350C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 16:22:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j9so6782478pgh.1
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 16:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w87QbXwmRHo+lYQmftCKqWv4GwfvCaSQP+S/H7+c7x0=;
        b=WaQYvr+k7M5VlqRX5hxL+0/ZW01mCv2PjeR5PpBrkj0Rge25krVCo+J+x+03E6+q+P
         YpQKP0lTGRg/OHGUPwetxCBfTR0fYtGXn5Hz03e8FTjDmIv+0eamEXIfxbvtcS8Vm+au
         n+4ujKIlXGCKJBeixCM8ostEVAKTtyYQb0lwRILuIi1deMQQ1k+Qy/g0HP5eF5Ggk/iH
         fM8gwjVb4U3Z9F4tSW7wmXw1hwE7HBnA5/bceOruO31x/saW8Zbo6DkbF1uWaRKOCP0h
         xp5qTWnyAhHOiwPE4qhPT8uEruqzkUBnyEbHxzjg3Vg7sYFCpiNNflM0tgO3r0NS96FZ
         kBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w87QbXwmRHo+lYQmftCKqWv4GwfvCaSQP+S/H7+c7x0=;
        b=X6DvB742zr1EtrRvbnKrsOt9OnhW++PvPeRx3wqnCnU2LegFT67uPVkpk74BeO9hg4
         9iN+nQLkGBq07PtVxYbRkTkHmPXGrkXuYhKDW1CyyzxiNALrXQVeLXJAS4OH4T/SVw+A
         1kTwVymVDv21b/4QyxnIdnh2Y1hMDOKLhPJbFpZYgbMZkjxrPhwTTO/NqUDHLK0emsh4
         4lfS5phey6fCn9ziJHvV/5kx1e5ZPvTpaAzW4IRvrwkkIH+d1nXAiJzHygrllBJJxRGw
         fHk4eEYP45nzMhYhUHQ9wiBlICmVgVkuHxUK7lB8RcEd0OeGkDs96h9lvk8I0qwjIibK
         cS4Q==
X-Gm-Message-State: AOAM530zFLEdLBkKXerK3hDR++HkyTWma87zUJbKDtR91gIaPNupbmMa
        TAmoeGYCKmJeYbeQwEgeHoCRjg==
X-Google-Smtp-Source: ABdhPJynR3YPbOrE1pLrtLjWeYyfE26FeW1K4tfNDW8kfFnkr0yTzR9ovMr5sGdbFpLmKhTOa1gVJQ==
X-Received: by 2002:a05:6a00:140c:b0:44b:e251:fe13 with SMTP id l12-20020a056a00140c00b0044be251fe13mr55740612pfu.10.1636068132061;
        Thu, 04 Nov 2021 16:22:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:35a1:c171:b6f3:d46c])
        by smtp.gmail.com with ESMTPSA id 26sm1208728pgw.24.2021.11.04.16.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 16:22:11 -0700 (PDT)
Date:   Thu, 4 Nov 2021 16:22:07 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 3/4] submodule: record superproject gitdir during
 absorbgitdirs
Message-ID: <YYRrH6Hw/C1qj5MV@google.com>
References: <20211014203416.2802639-4-emilyshaffer@google.com>
 <20211018231818.89219-1-jonathantanmy@google.com>
 <b208eb06-21c7-2199-0bc8-597669a165a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b208eb06-21c7-2199-0bc8-597669a165a1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 12:14:07PM -0400, Derrick Stolee wrote:
> 
> On 10/18/2021 7:18 PM, Jonathan Tan wrote:
> >> Already during 'git submodule add' we record a pointer to the
> >> superproject's gitdir. However, this doesn't help brand-new
> >> submodules created with 'git init' and later absorbed with 'git
> >> submodule absorbgitdir'. Let's start adding that pointer during 'git
> >> submodule absorbgitdir' too.
> > 
> > s/absorbgitdir/absorbgitdirs/ (note the "s" at the end)
> > 
> >> @@ -2114,6 +2115,15 @@ static void relocate_single_git_dir_into_superproject(const char *path)
> >>  
> >>  	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
> >>  
> >> +	/* cache pointer to superproject's gitdir */
> >> +	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */
> >> +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
> >> +	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
> >> +			       relative_path(absolute_path(get_git_dir()),
> >> +					     real_new_git_dir, &sb));
> >> +
> >> +	strbuf_release(&config_path);
> >> +	strbuf_release(&sb);
> >>  	free(old_git_dir);
> >>  	free(real_old_git_dir);
> >>  	free(real_new_git_dir);
> > 
> > Here [1] you mention that you'll delete the NEEDSWORK, but it's still
> > there.
> > 
> > Having said that, it might be better to make a test in which we call
> > this command while in a worktree of a superproject. The test might
> > reveal that (as pointed out to me internally) you might need to use the
> > common dir functions instead of the git dir functions to point to the
> > directory that you want (git-worktree.txt distinguishes the 2 if you
> > search for GIT_COMMON_DIR).
> 
> I came here to say the same thing. It's a bit too direct to compute
> the location of a config file this way, so we should expose a method
> that can create one for a given Git directory.
> 
> Since you're setting this config value inside the submodule's config,
> what does it mean for a submodule to also be a worktree (and hence
> require config.worktree)? What happens in this rough scenario?
> 
>   1. git init sub
>   2. git init super
>   3. git -C sub worktree add super/sub
>   4. git -C super submodule absorbgitdir sub
> 
> I haven't actually tried running these things, but it seems unusual
> and unexpected. This doesn't even account for cases where the repo
> root and a worktree are both submodules within the superproject.
> 
> If we already have protections preventing these worktrees as
> submodules, then perhaps there is no need for work here. I'm not
> familiar enough with the area to make a claim one way or another.

Yeah, I think there is actually a test case covering this in t7412:

137 test_expect_success 'setup a submodule with multiple worktrees' '
138         # first create another unembedded git dir in a new submodule
139         git init sub3 &&
140         test_commit -C sub3 first &&
141         git submodule add ./sub3 &&
142         test_tick &&
143         git commit -m "add another submodule" &&
144         git -C sub3 worktree add ../sub3_second_work_tree
145 '
146
147 test_expect_success 'absorbing fails for a submodule with multiple worktrees' '
148         test_must_fail git submodule absorbgitdirs sub3 2>error &&
149         test_i18ngrep "not supported" error
150 '

That is, I think because 'sub/' in your scenario above has multiple
worktrees, the absorbgitdirs will fail. So I won't do additional work
here. Thanks.

 - Emily

> 
> Thanks,
> -Stolee
