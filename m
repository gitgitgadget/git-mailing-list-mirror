Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A0C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9728F60FDB
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbhDOVZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbhDOVZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 17:25:30 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58E1C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 14:25:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j7so12822479plx.2
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CEg53zDdNCy5YctuCxzTz6yx53Ibhust2203nf8SjnM=;
        b=miycVesrPVzjnQ8p+qCCS6W1rATNAYv0Jb58jxhycO4fLsuvTlRLhsGGHY456PISPb
         gLvRZhDIQuDI5gGigz83qPCZRme/rVeBLeF2yxTV+GSzzgz8stTe95ZvsVbBZGAmEyIZ
         VZutwjWm9jcU8XlNQyWv1rbMyNxnf1nIvfnCPhYf9qnuyM02nEaaJ5BYBLeP4b/f+w7K
         r6QBeuyB/seAJlf2UVIL1XMZIQN9glkfIsFEYCacohDkNQil3Edchbmd8yv1yqdQ+CCk
         GBfKZNs5zPUj0V29PdKHq2/kgLuWFFjtHXC9HUrWapIdgonyf6DGjTypPCtQWfNYnfUa
         LmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CEg53zDdNCy5YctuCxzTz6yx53Ibhust2203nf8SjnM=;
        b=jIl+5hAvmEiYTlrKT6VDBYRByoSpWBTJw0SMBq794kpAVXqVZMH1VquOmIqkmxGGb3
         tLSVjRfrrlWOoHkvaqGGINozvQFOnW2WHayNwvliPiMY1RlbZOssuqGohe0V1VquU+5Q
         maglhI3X0rXhj2P85262XfJBpTXlEDlEJXd5BA1Z6hj1FHP+OACHNJ8KDzkXxE56d517
         ejhOYlmuKH643R2v7mhYQthzTIT2Ub7irsuk8mFTgQn8ayCzeDqMwjddQSDYtXBwSZgp
         DaPpU59MoY/fDmHM+tNHJH+JSQSsq5UVgnKuNgExy8qDbc5RF051q0pcnKIAAGKQiEsH
         D+IQ==
X-Gm-Message-State: AOAM530kc4zTA6cs1cKpXHaAi+nfnUOYr4d2C3krv9cH+F0asT3znGlF
        +0O6RkVN4hvm99gBDjJP2L5eQP0xc9/coA==
X-Google-Smtp-Source: ABdhPJznlpMsGKvC3pwBYxNqNLMm3p4sTQmBWAipcdLKMT7ou90N4oIpZyV9WnN7yarmGjZaEiga/g==
X-Received: by 2002:a17:902:ce85:b029:eb:46e1:2da2 with SMTP id f5-20020a170902ce85b02900eb46e12da2mr6021752plg.38.1618521906060;
        Thu, 15 Apr 2021 14:25:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:fe63:cb36:e487:f45e])
        by smtp.gmail.com with ESMTPSA id 18sm3007746pgn.82.2021.04.15.14.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:25:05 -0700 (PDT)
Date:   Thu, 15 Apr 2021 14:25:01 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Future structure of submodules and .git/, .git/modules/*
 organization
Message-ID: <YHivLSiJmZ0VtKs3@google.com>
References: <20210408233936.533342-1-emilyshaffer@google.com>
 <87v98p17im.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v98p17im.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 12:32:17PM +0200, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Apr 09 2021, Emily Shaffer wrote:
> 
> > I'm hoping to work on some other submodule-centric stuff over the coming
> > months, and it might end up being very useful to be able to tell "am I a
> > submodule?" and "how do I talk to my superproject?" more generally - so
> > I'm really open to figuring out a better way than this, if folks have
> > ideas.
> >
> > Patch 1 is a small refactor that we can take or leave - I found
> > "SCOPE_SUBMODULE" to be pretty ambiguous, especially since it seems to
> > refer to configs from .gitmodules. Even though I decided that
> > "superproject" was a better name than "submodule" I still wasn't super
> > happy with the ambiguity. But we can drop it if folks don't want to
> > rename.
> 
> This is less on your patch, and more on the larger work you're
> suggesting, but the two are kind of related. Skip to the paragraph
> starting with "But why" below for the relevance :)
> 
> I very much wish that we could eventually make the use of submodules
> totally transparent, i.e. (taking the example of git.git):
> 
>  * You clone, and we just get objects from
>    https://github.com/cr-marcstevens/sha1collisiondetection.git too
> 
>  * The fact that we have:
> 
>    160000 commit 855827c583bc30645ba427885caa40c5b81764d2  sha1collisiondetection
> 
>    Would become totally invisible to most users unless they run some
>    gutsy ls-tree/files comand.
> 
>    We used to have a full git dir at sha1collisiondetection/.git and all
>    the UX issues that entailed (e.g. switching to an old commit without
>    the submodule).
> 
>    Now it's a stub and the actual repo is at
>    .git/modules/sha1collisiondetection/, so we're kind of partially
>    there.

Side note: when I was writing the tests for patch 2 in this series I
noticed it was still really easy to end up with a full git dir at e.g.
sha1collisiondetection/.git, if you are trying to create a new repo to
use as a submodule (easily could be the case when working on a
"greenfield" project and you're the original author). There is
definitely a reason that I copied the (IMO) hack from the other
submodule test suite using the trash directory as a remote for my new
submodule. ;) I wonder whether I was just doing it wrong, or if we need
some established flow (maybe with `git submodule` subcommand) to create
a brand new submodule, not cloned from somewhere, and put its gitdir
inside of .git/modules?

>  * I would think that the next (but big) logical step would be to use
>    some combination of delta islands, upcoming sparse indexes etc. to
>    actually share the object stores of the parent and submodule.

Interesting - I'm trying to think of reasons not to and coming up blank,
but I also don't have much firsthand experience with the area of the
code that looks through the object store, so what do I know?

>    Things like "git fsck" which now just punt on COMMIT would need to
>    become smarter, but e.g. we could repack (or not, with islands)
>    between parent and submodule.
> 
> I would think that this end goal makes more sense than the current
> status quo of teaching every command that needs to e.g. grep the tree to
> have a "--recurse-submodules". The distinction would be invisible to the
> likes of "git-grep".

Yeah, I see where you're going, I think. Teaching everyone
--recurse-submodules or to respect the config setting
(core.recurseSubmodules? whatever it is) is inherently fragile, since it
relies on human reviewers to remember to chide patch authors to think of
the submodules use case. Neat.

> It would mean more complexity in e.g. "git commit", but we can imagine
> if you wanted a cross-submodule commit it could do those commits
> recursively, update parent COMMIT entries etc. (and even, optionally,
> push out the submodule changes). That particular thing being so ad-hoc
> is a *very* frequent pain point in submodule use.

Yeah, it sounds like you're describing the approach I was hoping to use
for commit-with-recursion:

 - Note each submodule with staged changes, as well as the superproject
 - (Optional? but might be nice) Open an editor with all the commit
   messages separated by scissors, so you can easily refer back to or
   modify the submodule commit messages while writing the superproject
   commit message
 - Generate all the submodule commits with the supplied commit-msgs
 - Take the commit IDs of all the newly created commits, stage them in
   the superproject, and generate the superproject commit with the
   supplied commit-msg

Maybe the editor bit is too much, but Jonathan Nieder at least really
liked that idea :) But the bit you're talking about - generating the
submodules first and then staging and committing in the superproject "on
the fly" - was the approach I was hoping to take.

> 
> But why am I talking about this here when all you're suggesting is
> another config level?
> 
> Well, I think (but have not carefully thought about) that this
> CONFIG_SCOPE_GITMODULES is probably a narrow net improvement now. If you
> set most options in your .git/config to you that's the same logical
> project, why shouldn't you get your diff setting or whatever because you
> cd'd to a submodule "in the same project" (from the view of the user).
> 
> But I think that for a wider "improve submodules" effort it's worth
> someone (and right now, that sounds like it's you) thinking about where
> we're going with the feature. Maybe with some technical doc identifying
> the most common pain points, what we propose (or could envision) doing
> about them.
> 
> So e.g. in this case, having per-submodule config could be a step
> forward, but it could also be one more step of walking in a circle.
> 
> I.e. don't think any user asked for or wanted to stitch together
> multiple .git directories into one linked pseudo-checkout, that's
> ultimately something we're exposing as an implementation detail. If we
> no longer expose that implementation detail, would we be stuck
> supporting what's ultimately a workaround feature?
> 
> None of that means we shouldn't have that one step forward that solves
> real problems today.
> 
> But I think we should think about the end goal(s) sooner than
> later.

Yeah, this is actually a good nudge for me. Internally we've got a big
nice doc explaining all our submodule plans for the next 6-9 months -
but I should probably get to sharing that with the list ;) I'd say to
look for it either this Friday or next Friday.

> E.g. in your case, do you *really* want another config level, or
> is it just the easiest way to get what you actually want, which is for a
> "git config" in the submodule dir to perhaps consider its .git/config
> and .git/modules/sha1collisiondetection/config as the same file for the
> purposes of config parsing? Sans things like the remote URLs etc.

As for this specific case, I want what is in the patch. Using a new
config file doesn't feel like a compromise to me - I actually would
prefer users to be able to explicitly choose shared vs. repo-specific
configs, rather than for we Git devs to implicitly decide which configs
are fine to share and which aren't. (I could also see having explicitly
shared or non-shared configs making it easier for wrappers to leverage
the Git config infrastructure, without mirroring our own "list of
configs to not share to submodule" for themselves.)

This RFC is mostly here to enable shared hooks, as you might have
guessed - but even with hooks, it's easy to imagine wanting a blend of
inherited vs. per-repo hooks. For example, I want to inherit a hook to
create a Gerrit Change-Id footer in my superproject and all my
submodules, definitely - but if my superproject is written in C and
includes a submodule which is in, I dunno, Rust or Zig or Perl or
whatever people are writing these days, I definitely don't want to try
and run my C linter from my superproject on my 15 Rust submodules - and
I definitely don't want to disable it in each one.

 - Emily
