Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F8CC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AA2613C4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348070AbhDMTpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 15:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346095AbhDMTpp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 15:45:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FF1C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:45:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d10so12688667pgf.12
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9311lcTGbcDIyGpTXN/pztCyzXA9BEnebmLoAI7gTIA=;
        b=auddxnFn9+4TB5n6L4WzveSRws8oDSVOTzgpURX9F+Rd5NAnPceM1UQo/kKT8dJbLf
         tcmosT6pZSaLRpLHdR7OMj/s9Vz3HvCbKRczPJZdPXEKPmgtDtwb7SQhDOjPPtWj4A2i
         b7ps8X0GtxfM0Z1rbJ01Jfz2I7cx5tmqliC7TeDOnHuZkdzlUTEAOM6MeWZNJk7ChnII
         1Xi7GxMAKVAzr7OnQoICf5WwnvqB9klQaMx8xuszDgGgqM538Pg5vAHnzXZw52VMGbxM
         v+rNojB9UhwF28kW9gVJpfgyJ34pDvLX2Cxr/rN3mbDad6y31QisR5CepdQuvoF/BOwa
         9ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9311lcTGbcDIyGpTXN/pztCyzXA9BEnebmLoAI7gTIA=;
        b=Qw0PX0bjzHH4gqD/YyAUw/qzg5i4d5ydKBEojqzODvR72FlQVgUAAX38u+H8X5xb7J
         nJa619v7ZdLPDdg1j83Zo/Uas2hKopkAC5QhargadMeFmHT3ZFpxHQzXhjkNXN5liXGv
         ET3XE6zThnhL6soNtZKbWYsmRQKxVMNUYANNaNez2sesNaxfGrovpbS6xIqNgmC/Luik
         U4wtHu6FkmQUbiaDDYaO26J7SR28CrX7g+4HppvrL0ipui5rKuiUsoviGdiDzIsRsWKJ
         9/df2OTHbK50xoWsZ56gXM9vvY1aGbmQZXbccdBC10MLEAb25Eh5NHNZQ7hB4ZjrdYBY
         veIw==
X-Gm-Message-State: AOAM531Tm1nwkXWswoXTwEfS5jYDU/wS6b/DXPbpcs5DwoOa3bEoakpy
        o34hFO1W/ivSa311EtwFXGS822k24a72og==
X-Google-Smtp-Source: ABdhPJyIjznRhlELXejOfJmtbWrOxCjby+40nqPhw/H8ETle4K8N2JMT73a3+HdK2GQurIim4T0j7Q==
X-Received: by 2002:aa7:9183:0:b029:24b:87e2:6281 with SMTP id x3-20020aa791830000b029024b87e26281mr12876956pfa.14.1618343125162;
        Tue, 13 Apr 2021 12:45:25 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f854:cc1c:b809:7daf])
        by smtp.gmail.com with ESMTPSA id ml9sm2858308pjb.2.2021.04.13.12.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 12:45:24 -0700 (PDT)
Date:   Tue, 13 Apr 2021 12:45:19 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] config: add 'config.superproject' file
Message-ID: <YHX0zwaES/9Nz97U@google.com>
References: <20210408233936.533342-1-emilyshaffer@google.com>
 <20210408233936.533342-3-emilyshaffer@google.com>
 <CAHd-oW4VoBbZHc7cLdn0LPM531qNDGOfwPZdKiKoG4BoRFaqdg@mail.gmail.com>
 <xmqqk0pbm6qt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0pbm6qt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 03:29:46PM -0700, Junio C Hamano wrote:
> 
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
> 
> > Hi, Emily
> >
> > I'm not familiar enough with this code to give a full review and I
> > imagine you probably want comments more focused on the design level,
> > while this is an RFC, but here are some small nitpicks I found while
> > reading the patch. I Hope it helps :)
> >
> > On Thu, Apr 8, 2021 at 8:39 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> >>
> >> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> >> index 4b4cc5c5e8..a33136fb08 100644
> >> --- a/Documentation/git-config.txt
> >> +++ b/Documentation/git-config.txt
> >> @@ -48,7 +48,7 @@ unset an existing `--type` specifier with `--no-type`.
> >>
> >>  When reading, the values are read from the system, global and
> >>  repository local configuration files by default, and options
> >> -`--system`, `--global`, `--local`, `--worktree` and
> >> +`--system`, `--global`, `--superproject`, `--local`, `--worktree` and
> >>  `--file <filename>` can be used to tell the command to read from only
> >>  that location (see <<FILES>>).
> >>
> >> @@ -127,6 +127,17 @@ rather than from all available files.
> >>  +
> >>  See also <<FILES>>.
> >>
> >> +--superproject::
> >> +       For writing options: write to the superproject's
> >> +       `.git/config.superproject` file, even if run from a submodule of that
> >> +       superproject.
> >
> > Hmm, I wonder what happens if a repo is both a submodule and a
> > superproject (i.e. in case of nested submodules).
> 
> Another thing I am not sure about the design is that a repository
> can be shared as a submodule by more than one superprojects.  The
> superprojects may want their submodule checkouts at different
> submodule commits, but that is something doable by having multiple
> worktrees connected to a single submodule repository.

I think the implementation as-written actually handles this
sharing-via-worktree case you describe gracefully, as it discovers the
gitdir belonging to the worktree above the worktree where it is being
run now:

superproject-a
-> sub-a <gitdir at superproject-a/.git/modules/sub-a/>
superproject-b
-> sub-b <gitdir at superproject-a/.git/modules/sub-a/worktrees/sub-b/>

In this case running `git config --list --superproject` in sub-a will
yield superproject-a/.git/config.superproject and running it in sub-b
will yield superproject-b/.git/config.superproject; that seems logical
to me. If I am adding libc as a submodule via worktree to Git as well
as, say, Wireshark, just to save me on disk space, I wouldn't want my
Wireshark hooks to run in Git project or vice versa.

> I think our design principle has been that it is perfectly OK for a
> superproject to be in total control if its submodules, but
> submodules should not even be aware of being used as a submodule by
> a superproject, and that allows a submodule repository to be shared
> by multiple superprojects.  As "write to the superproject's X file"
> requires a submodule to know who THE superproject of itself is, this
> feature itself (not the implementation) feels somewhat iffy.

As for this, I wonder what the reasoning is. I guess to simplify the
code, and to make the behavior more predictable (for example, 'git
commit' doesn't suddenly make a commit in some project that isn't this
one)?

One could imagine some really nice quality-of-life improvements if the
submodule is allowed to know it's a submodule (even by a config, for
example):

 - We could teach 'git status' to indicate the state when the submodule
   index is clean, but the superproject does not contain a commit
   pointing to the submodule's HEAD - which could still be considered a
   dirty state, since the change isn't associated with the larger project
   yet. I could imagine there might be other handy information related
   to submodule/superproject status we may want to display too.
 - We could teach 'git log' to decorate commits which are referred to by
   superproject commits, perhaps?
 - We could teach 'git push' to, by option or config, push the entire
   superproject-and-submodules package at once, to make it easier to
   coordinate changes across the whole superproject
 - One could envision some other niceties like 'git stash
   --whole-superproject' or similar, where a user could operate on the
   entire overall project (that is, the superproject and all its
   submodules) without needing to switch context away

I don't think lacking these things would stop a user from doing
something they want to do, but it does seem like they could make life
more comfortable for a user developing in a project made up of many
submodules.

 - Emily
