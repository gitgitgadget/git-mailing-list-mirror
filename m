Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9879BC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 21:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D2A2077D
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 21:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc9AT8mT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgDCVPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:15:04 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:32955 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgDCVPE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 17:15:04 -0400
Received: by mail-qv1-f66.google.com with SMTP id p19so4384761qve.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t/n5Cp5GRQO5HLWtic8iXCsKH4EuKLF89+YQk18uNi0=;
        b=Rc9AT8mTsNZEp8C1dj5RG1lSzn7zpEU+zQxHd3nJa7h0JlM++sepsewcm/xxUlgD6p
         2bRd4z4Luy48HAS2op8fBRllQwFqlo8nA6DKtyFp7B/BzwWQKi8g7dU4izIj/L7ztqgf
         7nXmLGidLYV4K2mLmONoNsTL5t9XMkGFjRDv7WtULF1ZUXs2Ml3t8ts1IAJ1c0dTg+Rf
         H5wlS1fRO22B0P2JiRku8odb8mJy9FlUql+8NfZ2i6JwokGyA+KjYix1tPCEYKr/vUrn
         1tEm6Mm2YUbE06gSlH5kTwjqTI6ymQd/n0LLxR+vAyI2RnrY3n1laAuJkr4QmdX8aGLK
         mE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t/n5Cp5GRQO5HLWtic8iXCsKH4EuKLF89+YQk18uNi0=;
        b=nnx6HlNNEVAM1OaNQyKFceRvYPT4vfcRIfB/DEoAftsB57MvXTCJM+FvH6ZsE7muZa
         bPV+PBx0f7pViiLMlwGu/4k6fqzje1VhltjOzjuv3+ORTNaTR2mNOtRiTIZQk0LeYeAP
         06HEa0/Cy+96BuRNNv27e/A73GolAW9ucPUKXz7uXmOTT9OrDNhz5vq9QmSFXsZCw8Zy
         8ZQXDbwcL/FLomT39AowVOcDRWSzBMJAdmor0X3rGmYMh6KfIyTRpRDaG0351SyHUuYZ
         qZNb4DRob9AfAd3niq8774kyfddulodq/puOOafeMqyyzHQnldog5i9rXtKJ2w68k5cb
         6JUw==
X-Gm-Message-State: AGi0PuY/bm4lf5JXZsid/a9E3RaPMkS7YRPVIwr7oT2Kryczlksz1ywR
        nv2Rywuoy9XhF93lslXd9lw=
X-Google-Smtp-Source: APiQypLUaWidzc/ntpZWMP8LhTHIkUou+BEwQUd+gX2GEkMXGIOwBuPxdcF8NZU20R73nwNbal3fMQ==
X-Received: by 2002:a05:6214:7e6:: with SMTP id bp6mr10577032qvb.47.1585948501551;
        Fri, 03 Apr 2020 14:15:01 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z18sm8033620qtz.77.2020.04.03.14.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 14:15:00 -0700 (PDT)
Date:   Fri, 3 Apr 2020 17:14:58 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/19] merge: teach --autostash option
Message-ID: <20200403211458.GA14409@generichostname>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <9e3d4393cae8813cc4718c6ffcc28231b1344fbe.1584782450.git.liu.denton@gmail.com>
 <cd7cb5aa-0a08-29dc-e1cc-f65a4010622f@gmail.com>
 <20200403103126.GA3163329@generichostname>
 <20200403105639.GA3193506@generichostname>
 <faa275d4-ca5d-9ab9-cbcb-aebd5e53e20b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa275d4-ca5d-9ab9-cbcb-aebd5e53e20b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, Apr 03, 2020 at 02:09:26PM +0100, Phillip Wood wrote:
> Hi Denton
> 
> On 03/04/2020 11:56, Denton Liu wrote:
> > On Fri, Apr 03, 2020 at 06:31:26AM -0400, Denton Liu wrote:
> > > > > diff --git a/builtin/reset.c b/builtin/reset.c
> > > > > index 18228c312e..038c8532eb 100644
> > > > > --- a/builtin/reset.c
> > > > > +++ b/builtin/reset.c
> > > > > @@ -25,6 +25,7 @@
> > > > >    #include "cache-tree.h"
> > > > >    #include "submodule.h"
> > > > >    #include "submodule-config.h"
> > > > > +#include "sequencer.h"
> > > > >    #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
> > > > > @@ -437,8 +438,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
> > > > >    		if (reset_type == HARD && !update_ref_status && !quiet)
> > > > >    			print_new_head_line(lookup_commit_reference(the_repository, &oid));
> > > > >    	}
> > > > > -	if (!pathspec.nr)
> > > > > +	if (!pathspec.nr) {
> > > > > +		if (reset_type == HARD)
> > > > > +			save_autostash(git_path_merge_autostash(the_repository));
> > > > > +
> > > > >    		remove_branch_state(the_repository, 0);
> > > > 
> > > > This removes the autostash file for all reset types but we only keep the
> > > > stash in the case of 'reset --hard' which is confusing.
> > > 
> > > I was worried that this change would be controversial... The rationale
> > > behind this change was that with `reset --hard`, we want to leave a
> > > clean working tree behind so we save it into the stash reflog. In all
> > > other cases, remove_branch_state() will apply the saved stash entry
> > > which should be fine since users don't expect a clean worktree with the
> > > other reset types.
> > > 
> > > I considered saving the autostash in all cases of reset but
> > > `git merge --abort` invokes `git reset --merge` behind the scenes so
> > > we'd have to consider that. Perhaps we can make all resets save the
> > > stash entry and, in the case of `merge --abort`, we can add some extra
> > > logic to subvert this so that the stash entry is applied?
> > 
> > Perhaps something like this?
> > 
> > -- >8 --
> > commit 14d0b569cb7675f00d32d3d7fad7564fcaeca458
> > Author: Denton Liu <liu.denton@gmail.com>
> > Date:   Fri Apr 3 06:50:34 2020 -0400
> > 
> >      squash! merge: teach --autostash option
> >      Stash is saved when any reset is run, when git merge --abort is run,
> >      stash is applied.
> 
> I think this is the easiest behavior to understand, it avoids changing the
> behavior of reset, in particular it stops 'reset --mixed/--soft' from
> suddenly starting to touch the working tree.

Great, I'll use this approach then.

> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index 9573d77096..31b82d614c 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -1242,6 +1242,8 @@ static int merging_a_throwaway_tag(struct commit *commit)
> >   	return is_throwaway_tag;
> >   }
> > +static GIT_PATH_FUNC(git_path_merge_autostash_saved, "MERGE_AUTOSTASH_SAVED")
> > +
> >   int cmd_merge(int argc, const char **argv, const char *prefix)
> >   {
> >   	struct object_id result_tree, stash, head_oid;
> > @@ -1295,9 +1297,16 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
> >   		if (!file_exists(git_path_merge_head(the_repository)))
> >   			die(_("There is no merge to abort (MERGE_HEAD missing)."));
> > +		if (file_exists(git_path_merge_autostash(the_repository))) {
> > +			if (rename(git_path_merge_autostash(the_repository),
> > +						git_path_merge_autostash_saved()))
> > +				die_errno(_("failed to rename autostash"));
> 
> This is a bit of a performance, can't we just remember the stash oid in a
> variable and tweak the apply code?

This makes me a little bit sad because we basically have to duplicate
the file-handling portion of apply_save_autostash() but I agree that
doing your way should be better.

> > +		}
> > +
> >   		/* Invoke 'git reset --merge' */
> >   		ret = cmd_reset(nargc, nargv, prefix);
> > -		apply_autostash(git_path_merge_autostash(the_repository));
> > +
> > +		apply_autostash(git_path_merge_autostash_saved());
> 
> Calling cmd_reset() was already a bit dodgy by our normal rules, now we're
> calling other functions after it though I guess given the current autostash
> implementation it's mostly in a separate process.
> 
> I think this is a good direction to go in
> BTW what message gets printed when the stash is saved?

This is the message that is printed:

	$ git reset --hard
	HEAD is now at c4c4222 commit 1
	Autostash exists; creating a new stash entry.
	Your changes are safe in the stash.
	You can run "git stash pop" or "git stash drop" at any time.

Thanks,

Denton

> Best Wishes
> 
> Phillip
> 
> >   		goto done;
> >   	}
> > diff --git a/builtin/reset.c b/builtin/reset.c
> > index 038c8532eb..060470c455 100644
> > --- a/builtin/reset.c
> > +++ b/builtin/reset.c
> > @@ -439,9 +439,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
> >   			print_new_head_line(lookup_commit_reference(the_repository, &oid));
> >   	}
> >   	if (!pathspec.nr) {
> > -		if (reset_type == HARD)
> > -			save_autostash(git_path_merge_autostash(the_repository));
> > -
> > +		save_autostash(git_path_merge_autostash(the_repository));
> >   		remove_branch_state(the_repository, 0);
> >   	}
> > > 
> > > I'm not sure about what the most intuitive behaviour is. I thought that
> > > this implementation would be the best but I'm not entirely sure. I'd
> > > appreciate some more discussion on this.
> > > 
> > > Thanks,
> > > 
> > > Denton
> > > 
> > > > Best Wishes
> > > > 
> > > > Phillip
> > > > 
> > > > > +	}
> > > > >    	return update_ref_status;
> > > > >    }
