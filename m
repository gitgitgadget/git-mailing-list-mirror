Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33663C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 22:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1181560EB4
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 22:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhKDWMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 18:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhKDWMV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 18:12:21 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9158C061203
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 15:09:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s136so6639741pgs.4
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 15:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P+NjZcQIee//6MVMyd3dzURaLWq7WUAfJ0BubZqye1w=;
        b=P8OkQvFR3wz8m3u9Aw0T+zY6xtkY1rSh6upleRYosJZgd5RjA1kEFem9S5ZNc34SgO
         XrUTrvSt37uQV18vM78d4VhgA1wxza2Q44yZqew7gA6+Z0Te5Na8oHoqaTP7hVCkUOPJ
         0313bLOTeYDFDLJH25HuMieSaNl8W75JYxMxQXwmy3j6DvqNSETbLapaF+GDQkwW8C7C
         YcYF89uu5IKa2RciCp4vwvmh+ZbVuXe8s8TU68omrV1Nbkl8rGGNz7EPNhv7LgkcnhLZ
         AMEbD2BCBQxdYWvBimz6+UFtnb7gdPkpYBYEQu+R36F4pbS6Om3wPOZF4qt7Hf7rnd46
         QOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+NjZcQIee//6MVMyd3dzURaLWq7WUAfJ0BubZqye1w=;
        b=r0gpEN4tu6OIQIA56AFnIi7tFbEtIwuf+7QNCvDsLYJmBHyXKG5l7fTEWpfbyA3EKV
         MAJgNl6HTRkFoIbx9ovT9ZZ/YzJQU3sKNIvJHUsHitVvdeFnst041IZjbwoHCx0HHMxh
         HlFW1LYZRQibkEBKK32Q8X/U5VPGJLjeKuU8GaU1tUUVShJtffAdc2xa36reqXHVemXi
         8IGpV5UUgrn07ocSv1DVK+MBTQgJGmzUxvZxMIWA1dIQuQPWRx+6b9Qfsl8YBuHoij1p
         G5dJ5d5sNVq6ZBt66qfUDeAw22n5t0DqntPVHFuxBsZMHwCg0SWcLVQRr8SXAk/KiFDr
         Xntg==
X-Gm-Message-State: AOAM531tab4f3xU3weAjkgPt5pXkotqW83UfKwyCeZ0TyRjgIde0oli0
        4PSolmDuiE2KK82xv1DQSZ/tb7egqHo4XA==
X-Google-Smtp-Source: ABdhPJzZyz4/FFk0rGRmF/S7TdK6v78AWUHGC7Fgt4v/rTDgqCsA+iKfz810YdrK1T1NNbIL0BdQjQ==
X-Received: by 2002:a63:90c4:: with SMTP id a187mr27241063pge.297.1636063782113;
        Thu, 04 Nov 2021 15:09:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:35a1:c171:b6f3:d46c])
        by smtp.gmail.com with ESMTPSA id n9sm7803292pjk.3.2021.11.04.15.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 15:09:41 -0700 (PDT)
Date:   Thu, 4 Nov 2021 15:09:36 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/4] submodule: record superproject gitdir during
 absorbgitdirs
Message-ID: <YYRaII8YWVxlBqsF@google.com>
References: <20211014203416.2802639-4-emilyshaffer@google.com>
 <20211018231818.89219-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018231818.89219-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 18, 2021 at 04:18:18PM -0700, Jonathan Tan wrote:
> 
> > Already during 'git submodule add' we record a pointer to the
> > superproject's gitdir. However, this doesn't help brand-new
> > submodules created with 'git init' and later absorbed with 'git
> > submodule absorbgitdir'. Let's start adding that pointer during 'git
> > submodule absorbgitdir' too.
> 
> s/absorbgitdir/absorbgitdirs/ (note the "s" at the end)
> 
> > @@ -2114,6 +2115,15 @@ static void relocate_single_git_dir_into_superproject(const char *path)
> >  
> >  	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
> >  
> > +	/* cache pointer to superproject's gitdir */
> > +	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */
> > +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
> > +	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
> > +			       relative_path(absolute_path(get_git_dir()),
> > +					     real_new_git_dir, &sb));
> > +
> > +	strbuf_release(&config_path);
> > +	strbuf_release(&sb);
> >  	free(old_git_dir);
> >  	free(real_old_git_dir);
> >  	free(real_new_git_dir);
> 
> Here [1] you mention that you'll delete the NEEDSWORK, but it's still
> there.
> 
> Having said that, it might be better to make a test in which we call
> this command while in a worktree of a superproject. The test might
> reveal that (as pointed out to me internally) you might need to use the
> common dir functions instead of the git dir functions to point to the
> directory that you want (git-worktree.txt distinguishes the 2 if you
> search for GIT_COMMON_DIR).

Huh, something interesting happened, actually.

I wrote a little test:

  test_expect_success 'absorbgitdirs works when called from a superproject worktree' '
          # set up a worktree of the superproject
          git worktree add wt &&
          (
          cd wt &&
 
          # create a new unembedded git dir
          git init sub4 &&
          test_commit -C sub4 first &&
          git submodule add ./sub4 &&
          test_tick &&
 
          # absorb the git dir
          git submodule absorbgitdirs sub4 &&
 
          # make sure the submodule cached the superproject gitdir correctly
          submodule_gitdir="$(git -C sub4 rev-parse --absolute-git-dir)" &&
          superproject_gitdir="$(git rev-parse --absolute-git-dir)" &&
 
          test-tool path-utils relative_path "$superproject_gitdir" \
                  "$submodule_gitdir" >expect &&
          git -C sub4 config submodule.superprojectGitDir >actual &&
 
          test_pause &&
          test_cmp expect actual
          )
  '

However, the `git submodule absorbgitdirs` command didn't do quite what
I expected.

When I made a new worktree, that worktree's gitdir showed up in
'$TEST_DIR/.git/worktrees/wt/'. That's not very surprising. But what did
surprise me was that when I called `git submodule absorbgitdirs sub4`,
sub4's gitdir ended up in '$TEST_DIR/.git/worktrees/wt/modules/sub4',
rather than in '$TEST_DIR/.git/modules/sub4'. That's a little
surprising!

Anyway, this test has a sort of pernicious mistake too - I'm checking
relative path between 'git rev-parse --absolute-git-dir's, but the
relative path from .git/worktrees/wt/ to .git/worktrees/wt/modules/sub4
is the same as the relative path from .git/ to .git/modules/sub4, so
this test actually passes.

I'll change the tests here and elsewhere to use 'git rev-parse
--path-format=absolute --git-common-dir', but I think that still leaves
a kind of dangerous state for people working a lot with worktrees and
submodules - if I like to make throwaway worktrees in my regular
workflow, and I create a new submodule in one, and then get rid of the
worktree when I'm done with the task that added the new submodule, I
think it will explode if I try to checkout the branch I was using in
that worktree.

I tried it out locally:

 # setup
 git init test && cd test
 git commit --allow-empty -m "first commit"
 git worktree add wt
 (
   cd wt
   git init sub
   git -C sub commit --allow-empty -m "first-commit"
   git submodule add ./sub
   git commit -m "add submodule (as initted)
   git submodule absorbgitdirs sub
   # This told me "Migrating git directory of 'sub' from
   # test/wt/sub/.git to test/.git/worktrees/wt/modules/sub, oops
 )

 # Make it possible to checkout wt branch somewhere else
 git -C wt checkout HEAD --detach

 # Try and delete the worktree; presumably my work is done
 git worktree remove wt

At this point, Git wouldn't let me remove the worktree:
  fatal: working trees containing submodules cannot be moved or removed

But wouldn't it be better to just absorb the submodule into the common
dir instead...?

By the way, when I tried checking out 'wt' branch from the original
worktree without deleting the new worktree, and then running 'git
submodule update', Git cloned 'sub' from .git/worktrees/wt/modules/sub
into .git/modules/sub. That was pretty surprising too!


Anyway, all of that is kind of a tangent. The takeaways I got are
twofold:

1) Yes, use common dir, not gitdir, in all the cached
path-to-superproject stuff.
2) Someone (me?) should send a patch keeping the "you can't delete a
submodule with a gitdir in it" die(), but *also* changing the behavior
to put the new submodule gitdir into get_common_dir() instead of
get_git_dir().

I'll try to send (2) separately - I think it will be a pretty small change,
and by keeping around the die() for deleting a worktree that already has
a submodule gitdir in it, we won't be risking deleting anybody's
existing work.

 - Emily

> 
> Besides that, all 4 patches look good (including the description of the
> new config variable).
> 
> [1] https://lore.kernel.org/git/YWc2iJ7FQJYCnQ7w@google.com/
