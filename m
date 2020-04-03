Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CFFC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 22:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2FD206A3
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 22:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpkVuMho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgDCWZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:25:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40349 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgDCWZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 18:25:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id z15so3658262qki.7
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nHJRqP9gLr4CunvR1hoZsdDNPc4r7DB5i90N7z1M/tk=;
        b=qpkVuMhoUp7v18vt02qjYO05c0w1oiB2dYESZ9lAWAT0/O918S5DhKa7DMXau+vuPr
         HveY64Muad+Z7Z8vSE07iMAjbTkX0ls+aQhI7bAYBpykSdv3cHv9JTEuvKpCaa9aktxb
         hXs0Ruqh8Vw7MLK9Up5g65AcDlT/Z1ToeJLbfYdU4dMSq6yqZR7yejEDgCc20A5aMgEJ
         9bm8B3M0LFlBbzfS0IicTQE1w8YoSfgqyWur/Wv/8Awo/fE0KW2NFSi8IDU+b5O4AwHD
         Dguu0+riXnF3VXkklQCYiB0tpjNsKL7DDD+vZbZcG21/7MlG3COM85/ov5BrZvy8wXiF
         fv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nHJRqP9gLr4CunvR1hoZsdDNPc4r7DB5i90N7z1M/tk=;
        b=rYGyyKeVBnFFdJYrB/MwlkgkTVRMTZU5EdeJItyEeB7auyVHCfyBFfqQMjWl+tUoKs
         jlraU4+GTqdLiqppTPOQu8VJ1ldPdXGszTa30CkgQyUIfIg3gIWrNMvjRXOXBHDTc4P7
         lnYmJLUpO2I5cO0J0nRYyLi5bIh0YytJGtdlJbQWwN0GPwnA6GpRvIq6eqli/1EpZ4AA
         UoKRouO8zfGieQhHGS21hRMO6hDjZ5NZ5nbl7WKCsFMdIdL7Gc+slTORfYJHfHcLOvH+
         dbHFQM9VRo/w8cb6AHqGRTz0wT/9C3FWtcbxb2tdZNYlRPaEHrLO/VwIBkGWTvYuFFmA
         D/Hw==
X-Gm-Message-State: AGi0PuaIwONwU/5LiLJWLKNOXGLPJ1LnL4AUeWVnwIJB1dtpGCIR6PWf
        L+eAfEt2ccKlakIkwV2FI0Y=
X-Google-Smtp-Source: APiQypJK3BxEr4lUFwDZO2zj29+Au5Xk2epaQbvLuem+0IfZ5xkyGVJUWyaP/iNz8uDx4b6xDCKNqA==
X-Received: by 2002:ae9:e014:: with SMTP id m20mr11477586qkk.434.1585952755803;
        Fri, 03 Apr 2020 15:25:55 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id 31sm7643827qta.56.2020.04.03.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 15:25:54 -0700 (PDT)
Date:   Fri, 3 Apr 2020 18:25:52 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/19] merge: teach --autostash option
Message-ID: <20200403222552.GA35842@generichostname>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <9e3d4393cae8813cc4718c6ffcc28231b1344fbe.1584782450.git.liu.denton@gmail.com>
 <cd7cb5aa-0a08-29dc-e1cc-f65a4010622f@gmail.com>
 <20200403103126.GA3163329@generichostname>
 <194df5e2-4e5d-3150-d8a4-bb55bdef75be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194df5e2-4e5d-3150-d8a4-bb55bdef75be@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, Apr 03, 2020 at 02:34:30PM +0100, Phillip Wood wrote:
> > On Thu, Apr 02, 2020 at 04:24:54PM +0100, Phillip Wood wrote:
> > > > diff --git a/branch.c b/branch.c
> > > > index 579494738a..bf2536c70d 100644
> > > > --- a/branch.c
> > > > +++ b/branch.c
> > > > @@ -344,6 +344,7 @@ void remove_merge_branch_state(struct repository *r)
> > > >    	unlink(git_path_merge_rr(r));
> > > >    	unlink(git_path_merge_msg(r));
> > > >    	unlink(git_path_merge_mode(r));
> > > > +	apply_autostash(git_path_merge_autostash(r));
> > > >    }
> > > >    void remove_branch_state(struct repository *r, int verbose)
> > > > diff --git a/builtin/commit.c b/builtin/commit.c
> > > > index 7ba33a3bec..c11894423a 100644
> > > > --- a/builtin/commit.c
> > > > +++ b/builtin/commit.c
> > > > @@ -1687,6 +1687,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> > > >    	unlink(git_path_merge_mode(the_repository));
> > > >    	unlink(git_path_squash_msg(the_repository));
> > > > +	apply_autostash(git_path_merge_autostash(the_repository));
> > > > +
> > > 
> > > It's hard to tell from the limited context but do we want to run
> > > commit_index_files() before applying the autostash?
> > 
> > I don't think it really matters which order we run it in. When we run
> > apply_autostash(), we only ever touch the working tree, not the index so
> > it doesn't matter if it's run before or after. I'd prefer to keep it
> > here because if we ever refactor this to use
> > remove_merge_branch_state(), the person working on this will be able to
> > perform the refactor more easily without having to worry about implicit
> > ordering dependencies.
> 
> Thinking a bit more about this we definitely want to commit the index files
> before applying the stash as that is done in a separate process so we want
> our index written to disk first.
> 
> 'git stash apply' does touch the index while it's merging and then tries to
> reset it to the pre-merge state if the merge has no conflicts. If the user
> runs
>     git add new-file
>     git merge --autostash branch
> and new-file is not in branch then 'git stash apply' will add new-file to
> the index
> 
> 
> > > I wonder if this should
> > > be using remove_merge_branch_state() instead of duplicating it as well.
> > 
> > We can _almost_ use remove_branch_state() even! Unfortunately,
> > remove_merge_branch_state() calls `unlink(git_path_merge_rr(r))` which
> > we cannot do since repo_rerere() relies on it later. Perhaps we can
> > can move repo_rerere() earlier?
> 
> I think we should move apply_autostash() down so that repo_rerere() is
> called with the index that we've committed before we apply the stash which
> might add conflicts or new files. We should probably run the post-commit and
> post-rewrite hooks before we apply the autostash as well to avoid changing
> the existing behaviour.
> 
> If we aim for something like
>   commit_index_files()
>   repo_rerere()
>   stash_oid = read_autostash_oid()
>   cleanup_branch_state()
>   run_post_commit_hook()
>   run_post_rewrite_hook()
>   print_commit_summary()
>   apply_autostash(stash_oid)
> 
> Then we keep the existing behaviour for rerere and the hooks, and the commit
> summary is printed before all the status junk that apply_autostash() spews
> out

Makes sense, I'll make this change.

> We probably need to check the where 'git merge' applies the autostash as
> well to make sure it is writing the index to disk, calling the post-merge
> hook and printing any messages before applying the stash

It currently applies the autostash in finish(). After reviewing it, I've
moved the apply_autostash() call to the end of that function.

Actually, going back to review some more callsites of apply_autostash(),
the one in remove_merge_branch_state() doesn't really make sense. We
should really be calling save_autostash() in there so that we don't
accidentally dirty the worktree unexpectedly. The bonus to this is that
I've removed the save_autostash() call in `git reset` so it should just
be able to call remove_branch_state() and have everything just work.

As a result of these changes, we now only introduce three callsites of
apply_autostash(), which are all explicit:

	1. At the end of `git commit`
	2. At the end of finish() in `git merge`
	3. At the end of `git merge --abort`

I'll send up a new version later today.

Thanks for helping shape this topic up,

Denton

> Best Wishes
> 
> Phillip
