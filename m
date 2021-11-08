Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A240C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58AE610F8
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbhKHXO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhKHXO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 18:14:27 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4510C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 15:11:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id o14so17381440plg.5
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 15:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lujAQz5KoRsJa0NWpGgWSB0rZMtqcVfaaD6Ll9C1paA=;
        b=V0+xFLUJQ328CXoHlmKCp2XetJz6mPZC7hBK+3ZQPD/ZQvP1i60YHjj6gj7xB7riCO
         c2dE48MclfbZBzWgpM9a0f/sGzb09VNtd/cbD96/BMs8u1R1Kp/7bG2mrFe+jl+jXOpE
         AqhNh2omY3HueEz1t3rLCoC7Sv7DmDexahfI9s+iJk2r6ebgSa9axzJNyN8MSuwpRbqK
         P9JMCiSiTEhXaYVUhoyOrhI4bpYVE90VF+shmH3y2wsMCFKBpPV6qsMB2JCEcy3UPzAv
         QVEtZ04dQZ/iR0PhbaIU/XswPzsP/MnQaNieRVOXjDOL4cRYci0ljJrbP5X1MEXH2i5O
         AJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lujAQz5KoRsJa0NWpGgWSB0rZMtqcVfaaD6Ll9C1paA=;
        b=graBEEMU1T58WpXp9EkO9IcmgjsM/qQdja26CH928pkNGjaC99hlSE6KTV2bDO4j8s
         Qc0do3T3JgoyLmAdTA90He5s8ngFw7V1stC1bQUFxT/2pMnQwVw7r3hIC0V5pcr7xRWD
         5Zd11YV6+1RfMcYyzaez/WKdvSnZH+n/lFwrMhhEDbRFy3daaihvRN3UAB2mbM3ZH9O+
         YA8c4TG4B24+5tVVd+zc50IpplQzeFklraXn/cioDs5paOrbrR6zKjfx6ySJ71qoEq2Z
         hpxYIkc5lmbgIbQT75uc7imEbffuLKk7nF29R8jbV19Zr60rcPLbqRIeRond4xca3bBB
         JJmA==
X-Gm-Message-State: AOAM530RfM+AlLHHK+t6DdC3mVzmpn9q14Lc8dQxdrShgn2s5Mj7yNDh
        H/8mnEwMav4/s99iO6zPrX8wSg==
X-Google-Smtp-Source: ABdhPJxD+dsonMgxkLDJUSbkPKn8drXE0/Wg2ooYMEhDoLjgIdiSJmYlB1ZwLYGUhctIZNKpvl/qTQ==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr2167787pjg.79.1636413101855;
        Mon, 08 Nov 2021 15:11:41 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:f405:d461:2b86:9d34])
        by smtp.gmail.com with ESMTPSA id 142sm13378685pgh.22.2021.11.08.15.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 15:11:40 -0800 (PST)
Date:   Mon, 8 Nov 2021 15:11:36 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v5 0/4] cache parent project's gitdir in submodules
Message-ID: <YYmuqEQUaB1a8Gs1@google.com>
References: <20211104234942.3473650-1-emilyshaffer@google.com>
 <920c3133-b6ee-b82c-0876-f06713e9337b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <920c3133-b6ee-b82c-0876-f06713e9337b@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 07, 2021 at 08:24:43PM -0500, Derrick Stolee wrote:
> 
> On 11/4/2021 7:49 PM, Emily Shaffer wrote:
> 
> > The only real change here is a slight semantics change to map from
> > <submodule gitdir> to <superproject common git dir>. In every case
> > *except* for when the superproject has a worktree, this changes nothing.
> > For the case when the superproject has a worktree, this means that now
> > submodules will refer to the general superproject common dir (e.g. no
> > worktree-specific refs or configs or whatnot).
> > 
> > I *think* that because a submodule should exist in the context of the
> > common dir, not the worktree gitdir, that is ok. However, it does mean
> > it would be difficult to do something like sharing a config specific to
> > the worktree (the initial goal of this series).
> > 
> > $ROOT/.git
> > $ROOT/.git/config.superproject <- shared by $ROOT/.git/modules/sub
> > $ROOT/.git/modules/sub <- points to $ROOT/.git
> > $ROOT/.git/worktrees/wt
> > $ROOT/.git/worktrees/wt/config.superproject <- contains a certain config-based pre-commit hook
> > 
> > If the submodule only knows about the common dir, that is tough, because
> > the submodule would basically have to guess which worktree it's in from
> > its own path. There would be no way for '$WT/sub' to inherit
> > '$ROOT/.git/worktrees/wt/config.superproject'.
> > 
> > That said... right now, we don't support submodules in worktrees very
> > well at all. A submodule in a worktree will get a brand new gitdir in
> > $ROOT/.git/worktrees/modules/ (and that brand new gitdir would point to
> > the super's common dir). So I think we can punt on this entire question
> > until we teach submodules and worktrees to play more gracefully together
> > (it's on my long list...),
> 
> (I omit a portion that will be discussed later.)
> 
> > Or, to summarize the long ramble above: "this is still kind of weird
> > with worktrees, but let's fix it later when we fix worktrees more
> > thoroughly".
> 
> I'm concerned about punting here, because making a messy situation worse
> is unlikely to have a clean way out. Could we set up a design that works
> with superproject worktrees?
> 
> You mentioned that submodules cannot have worktrees. At least, you said
> that 'absorbgitdirs' does not allow them. Could those subprojects still
> exist and be registered as submodules without using that command?
> 
> What I'm trying to hint at is that if the submodules can't have
> worktrees, then maybe we could make their 'config.worktree' files be
> relative to the superproject worktrees. Then, these submodules could
> point to the commondir in their base config and _also_ to the worktree
> gitdir in their config.worktree.
> 
> The issue that is immediately obvious here is that my definition is
> circular: we need to know the superproject worktree in order to discover
> the config.worktree which contains the information about the superproject
> worktree.
> 
> > and at that time we can probably introduce a
> > pointer from $ROOT/.git/modules/sub/worktrees/wt/ to
> > $ROOT/.git/worktrees/wt/....
> 
> Your idea here appears to assume that if the superproject has worktrees,
> then the submodule is divided into worktrees in an exact correspondence.
> This would allow the submodule's config.worktree to point to the
> superproject's worktree (or possibly it could be inferred from the
> submodule's worktree relative to the submodule's commondir).
> 
> This seems like an interesting way forward, but requires changing how
> 'git absorbgitdirs' works, along with changes to 'git worktree' or other
> submodule commands when the submodule first appears during a 'git checkout'
> in a worktree. I imagine there are a lot of "gotchas" here. It is worth
> spending some time imagining how to create this setup and/or enforce it
> as submodules are added in the lifecycle of a repository, if only to
> validate the config design presented by this series.

Yeah, I think we may be overthinking it, especially with the concerns
about common dir vs. gitdir. More specifically - I think we accidentally
did the right thing in the previous iteration by using the gitdir :)

I think we can probably put it pretty simply:
submodule.superprojectGitDir should point from the most local gitdir of
the submodule to the most local gitdir of the superproject.

Luckily there are not so many permutations to worry about here.

Super doesn't have worktrees, sub doesn't have worktrees:
.git/
  modules/
    sub/
      config <- contains a pointer to ".git/"
  config

Super doesn't have worktrees, sub does have worktrees (and as you
suggest above, right now this would have to be created carefully and
manually, but later we probably want this to Just Work):
.git/
  modules/
    sub/
      config
      config.worktree <- contains a pointer to ".git/"
      worktrees/
        sub-wt/
	config <- contains a pointer to ".git/"
  config

Super has worktrees, sub doesn't have worktrees:
Actually, I think in the future this might not be possible, if we want
to make `git worktree add --recurse-submodules` work gracefully (and I
do want that). But in the interim, in practice it looks like this:
.git/
  modules/
    sub/
      config <- contains a pointer to ".git/"
  worktrees/
    super-wt/
      modules/
        sub/
	  config <- contains a pointer to ".git/worktrees/super-wt"
      config
  config
This case is pretty weird anyway, because in order for a submodule to be
present in multiple worktrees of the superproject, the submodule itself
needs to either have multiple worktrees or multiple repos. But on the
flip side, today it's impossible for a single submodule gitdir to need
to know about more superproject worktrees than the one it was
initted/whatever into.

Both super and sub have worktrees:
And this won't exist until we have graceful support of `git worktree add
--recurse-submodules` or with some manual effort, now.
.git/
  modules/
    sub/
      worktrees/
        sub-wt/
	  config <- contains a pointer to ".git/worktrees/super-wt/"
      config
      config.worktree <- contains a pointer to ".git/"
  worktrees/
    super-wt/
      config
  config
  config.worktree

I think this will give us access to both the worktree gitdir *and* the
common gitdir:

  ~/git/.git/worktrees/git-second [GIT_DIR!]$ git rev-parse --git-common-dir
  /usr/local/google/home/emilyshaffer/git/.git

So that means from any submodule, we can determine:
 - submodule's gitdir (from the .git link in the submodule wt)
 - submodule's common dir (from existing commands)
 - gitdir of superproject which submodule inhabits (from the config in
   the submodule's gitdir, or the submodule's config.worktree)
 - common dir of superproject (from existing commands + prior config)

The upshot to me, then, means that we should be 1) making sure to get
the path to the gitdir, not the common dir, of the superproject; and 2)
using helpers to write to the worktree config, not to the local config,
of the submodule. In other words, we want to avoid the following:

.git/
  modules/
    sub/
      worktrees/
        wt/
	  config
      config <- "submodule.superprojectGitDir = ../../../.." as written by the worktree

Will take a look at the rest of the comments too, but this sounds like a
reasonable approach to me.

 - Emily

> 
> Thanks,
> -Stolee
