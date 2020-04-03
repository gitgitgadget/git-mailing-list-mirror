Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BA5C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5940F2078C
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgFeUXXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbgDCKbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:31:32 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45061 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKbb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 06:31:31 -0400
Received: by mail-qv1-f67.google.com with SMTP id g4so3266799qvo.12
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=reiPqg/Y+3RF3IsvV37DTBwGR41xDGNsDQCEDvWjBxw=;
        b=YgFeUXXBxOHVIfA4sDgwtJAfXquP6H1n83X8+J2NqD+PLnQbuk5Su08w2oQ3612rrd
         D/6VmNgbDETY6xAM0iovCREO6HJnJvh+f1lIfBmOHWD+IwMlQg8jFMkqvoDN3BkQClyr
         g20oXF9wxYZ95Y6E3KsmWqNGGTsSnNgRRG40s6xZDlJgDEFXZ6zmjy7Xddis+g2vM8xb
         YL7s60dX9KsKZkBvX+fMoMVh8Lg+R3t6wejuLq7MK/02CS/FOARajvwOG4VjmurJUNLG
         I5mLjh42Z8UCO8p/pFkVGzdpaBGljLdQwqgaaL9kNXWLQ0ZO2Q2PBazwfw/mk451p9yU
         4rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=reiPqg/Y+3RF3IsvV37DTBwGR41xDGNsDQCEDvWjBxw=;
        b=obWju9FYwY68RC9Wru26yh0LkaqLkbtM/vhFMhKu83byaqMNRWvIHhnJ21KmIr5w9i
         Gm47Jrow/0whuVyMXCWdHnn5YyHPklZdTl4BBQLPFYl6jCXu0ZF3qNfi1liiA6XgnnqG
         OUJ4/S+3Oz0WEvsX9+UeZOK8ty8YBJ4mie+b+jaYlTufJ72z0d/oSSJTCKmnOqUSy5lU
         9JhQcFojhIUSdmRv3OF2EdHZAAv4NurUUEZL2OCPYRk7JEJd21v4X8CjHCJmts4WOSed
         yiQKZcjZnLQ1+341qPER0NQ+HO7d9IcQgHT4f9ew2bXmO5xyotDUY9o8Yv3c5Co2/j0a
         BlpA==
X-Gm-Message-State: AGi0Pua7IA7CKuN4IdHdaOaO+jxrlzsr1NhgEwdlJ8vRgqXWyRujK2Xg
        JLTInTp2fgGOpESg1PxG1aE=
X-Google-Smtp-Source: APiQypI2B0yxJ/sNa52IEOUsWwvqe85SCfMzI9pIUjFux5LUkaSYxBXbXq9nGXRzT9dQhhNxHhNLgQ==
X-Received: by 2002:ad4:524c:: with SMTP id s12mr7594125qvq.52.1585909890439;
        Fri, 03 Apr 2020 03:31:30 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id x9sm6112561qtk.7.2020.04.03.03.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 03:31:29 -0700 (PDT)
Date:   Fri, 3 Apr 2020 06:31:26 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/19] merge: teach --autostash option
Message-ID: <20200403103126.GA3163329@generichostname>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <9e3d4393cae8813cc4718c6ffcc28231b1344fbe.1584782450.git.liu.denton@gmail.com>
 <cd7cb5aa-0a08-29dc-e1cc-f65a4010622f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd7cb5aa-0a08-29dc-e1cc-f65a4010622f@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Thanks for your detailed review on the series. I've updated everything
according to your comments except for the parts below:

On Thu, Apr 02, 2020 at 04:24:54PM +0100, Phillip Wood wrote:
> > diff --git a/branch.c b/branch.c
> > index 579494738a..bf2536c70d 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -344,6 +344,7 @@ void remove_merge_branch_state(struct repository *r)
> >   	unlink(git_path_merge_rr(r));
> >   	unlink(git_path_merge_msg(r));
> >   	unlink(git_path_merge_mode(r));
> > +	apply_autostash(git_path_merge_autostash(r));
> >   }
> >   void remove_branch_state(struct repository *r, int verbose)
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 7ba33a3bec..c11894423a 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -1687,6 +1687,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> >   	unlink(git_path_merge_mode(the_repository));
> >   	unlink(git_path_squash_msg(the_repository));
> > +	apply_autostash(git_path_merge_autostash(the_repository));
> > +
> 
> It's hard to tell from the limited context but do we want to run
> commit_index_files() before applying the autostash?

I don't think it really matters which order we run it in. When we run
apply_autostash(), we only ever touch the working tree, not the index so
it doesn't matter if it's run before or after. I'd prefer to keep it
here because if we ever refactor this to use
remove_merge_branch_state(), the person working on this will be able to
perform the refactor more easily without having to worry about implicit
ordering dependencies.

> I wonder if this should
> be using remove_merge_branch_state() instead of duplicating it as well.

We can _almost_ use remove_branch_state() even! Unfortunately,
remove_merge_branch_state() calls `unlink(git_path_merge_rr(r))` which
we cannot do since repo_rerere() relies on it later. Perhaps we can
can move repo_rerere() earlier?
 
> > diff --git a/builtin/reset.c b/builtin/reset.c
> > index 18228c312e..038c8532eb 100644
> > --- a/builtin/reset.c
> > +++ b/builtin/reset.c
> > @@ -25,6 +25,7 @@
> >   #include "cache-tree.h"
> >   #include "submodule.h"
> >   #include "submodule-config.h"
> > +#include "sequencer.h"
> >   #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
> > @@ -437,8 +438,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
> >   		if (reset_type == HARD && !update_ref_status && !quiet)
> >   			print_new_head_line(lookup_commit_reference(the_repository, &oid));
> >   	}
> > -	if (!pathspec.nr)
> > +	if (!pathspec.nr) {
> > +		if (reset_type == HARD)
> > +			save_autostash(git_path_merge_autostash(the_repository));
> > +
> >   		remove_branch_state(the_repository, 0);
> 
> This removes the autostash file for all reset types but we only keep the
> stash in the case of 'reset --hard' which is confusing.

I was worried that this change would be controversial... The rationale
behind this change was that with `reset --hard`, we want to leave a
clean working tree behind so we save it into the stash reflog. In all
other cases, remove_branch_state() will apply the saved stash entry
which should be fine since users don't expect a clean worktree with the
other reset types.

I considered saving the autostash in all cases of reset but
`git merge --abort` invokes `git reset --merge` behind the scenes so
we'd have to consider that. Perhaps we can make all resets save the
stash entry and, in the case of `merge --abort`, we can add some extra
logic to subvert this so that the stash entry is applied?

I'm not sure about what the most intuitive behaviour is. I thought that
this implementation would be the best but I'm not entirely sure. I'd
appreciate some more discussion on this.

Thanks,

Denton

> Best Wishes
> 
> Phillip
> 
> > +	}
> >   	return update_ref_status;
> >   }
