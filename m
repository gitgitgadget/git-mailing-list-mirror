Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74BDC433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB8A613C3
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbhDEWFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 18:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbhDEWFy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 18:05:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E50C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 15:05:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mh7so8813073ejb.12
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 15:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grlWl1jFPmPtDaemMmMcOJrYyggdhnKNvCRlXEK4Oek=;
        b=GVNWJEItITOOaWiBbwyomV8S8guH1uxmYu/HDvdok6W6ZxK5CYAA+AX1ZX4I3IvmBl
         /vQ9ykdKvcOVurTNBO/JqaMlSkkOCpzFuH2VJwk7NwNJq/dytEIHPfThqw6MGlgCmzbI
         3AeSG2wAKJBmWaxq3Y6aUmhuAnQ+ZxpjjfKTBF+Kndhlya6dOn6utPuxmollCCRKbKfY
         cn3igmkTEGn8lE72TBWUSuPOdy+kK/OETRZLukH0xOJ1zunozBqZPhmni5MW1nqz5b6/
         j5GMHbNO3FmjS26KL0+xqtuAaTOX38PhrcXJkO24AUcF44oZ2SJ07AGmr4vm11W8rjQj
         pKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grlWl1jFPmPtDaemMmMcOJrYyggdhnKNvCRlXEK4Oek=;
        b=Z3EIAZN3R4JrqwjXnhI+h2ZTNnNN8r/I1VVnC+cJvYIqlUi74IcYFgoPN0SFmpCjej
         LVm9hu9qWgphaMGSDvp0vFredeeN7NPwtiO+Q8mYUXaA+XI3RpoYYSYdlRuE7saDGt3X
         uTlvttyyeX3kHWSzxuhLTSYpMlVCq1nxoGlSQYn6s8eEx5J5Qwru7mXJ6g8gF+L6zcGX
         r5/9tEbsk1E7MKdvS4FhQgJGUylEqWhG2PZuupsyKtN95ZKEu5fluWK7ZPRVi/RpuUI6
         2v88bxbRTnC1U+TXJmnA6OuBf2FhWog+MJQcVB6ig2kuzPIbsd5mpI6JoLo+syZm3zrq
         H5Gg==
X-Gm-Message-State: AOAM531l+KzwzR9iA/1ktko0tll6h6IFygwKHazqSdWecnseeYiSNQRr
        xOUfWjLgmGvCXY6J4+L1Pa1HcE0POdQEwQxiiQVQkQ==
X-Google-Smtp-Source: ABdhPJwWamSohd9z+kZkmiafunpIO8sv71BmBiV4LOglEktj02kcFKRPEEBPu9Mh6C2kD//qmawePeAHuHTpIvWPZC8=
X-Received: by 2002:a17:907:3e9e:: with SMTP id hs30mr31195339ejc.66.1617660344976;
 Mon, 05 Apr 2021 15:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210403013410.32064-1-jerry@skydio.com> <CABPp-BGSgyAH0w21Vrv_bdPaLg+rCPViktbUmM6fMbmxaK70qA@mail.gmail.com>
In-Reply-To: <CABPp-BGSgyAH0w21Vrv_bdPaLg+rCPViktbUmM6fMbmxaK70qA@mail.gmail.com>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Mon, 5 Apr 2021 15:05:34 -0700
Message-ID: <CAMKO5CsN+J_30vhJTo5PYj_9SNJVh_y33APUviG2P4bir29RjQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] git-apply: Allow simultaneous --cached and --3way options
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>, brian.kubisiask@skydio.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 2, 2021 at 8:04 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Apr 2, 2021 at 6:36 PM Jerry Zhang <jerry@skydio.com> wrote:
> >
> > I'm creating a script/tool that will be able to cherry-pick
> > multiple commits from a single branch, rebase them onto a
> > base commit, and push those references to a remote.
> >
> > Ex. with a branch like "origin/master -> A -> B -> C"
> > The tool will create "master -> A", "master -> B",
> > "master -> C" and either make local branches or
> > push them to a remote. This can be useful since code
> > review tools like github use branches as the basis
> > for pull requests.
>
> Not sure I understand the "master -> A", "master -> B" syntax.  What
> do you mean here?
Ah yeah my syntax wasn't super clear here.
I mean a branch "dev" pointing to commit "C", which is on top of "B",
which is on top of "A", which is on top of "master".
My tool would fake "cherry-pick" each of A, B, and C on top of master.
>
> > A key feature here is that the above happens without
> > any changes to the user's working directory or cache.
> > This is important since those operations will add
> > time and generate build churn. We use these steps
> > for synthesizing a "cherry-pick" of B to master.
> >
> > 1. cp .git/index index.temp
> > 2. set GIT_INDEX_FILE=index.temp
> > 3. git reset master -- . (git read-tree also works here, but is a bit slower)
> > 4. git format-patch --full-index B~..B
> > 5. git apply --cached B.patch
> > 6. git write-tree
> > 7. git commit-tree {output of 6} -p master -m "message"
> > 8. either `git symbolic-ref` to make a branch or `git push` to remote
>
> Yeah, folks have resorted to various variants of this kind of thing in
> the past.  It is a clever way to handle some basic cases, but it does
> often fall short.  It's unfortunate that cherry-pick and rebase cannot
> yet just provide this functionality (more on that below).
>
> It may also interest you that rebase has two different backends, one
> built on am (which in turn is built on format-patch + apply), and one
> built on the merge machinery (which the am --3way also uses when it
> needs to).  We deprecated the format-patch + apply backend in part
> because it sometimes results in misapplied patches; see the "Context"
> subsection of the "BEHAVIORAL DIFFERENCES" section of the git-rebase
> manpage.  However, the am version would at least handle basic renames,
> which I believe might cause problems for a direct format-patch + apply
> invocation like yours (I'll also discuss this more below).
Thanks -- I was able to repro a case where am machinery applied a patch
incorrectly but 3way applied it correctly. This actually brings up
another point,
because am doesn't report errors when applying a patch incorrectly in this
case, we don't end up falling back to 3way. There also is no user flag
to force 3way, so the user can't do anything to ensure the correct
application here. Maybe it would be better for --3way to directly invoke
the 3way merge rather than causing it to fallback? (Junio might also
have some input here).
>
> > I'm looking to improve the git apply step in #5.
> > Currently we can't use --cached in combination with
> > --3way, which limits some of the usefulness of this method.
> > There are many diffs that will block applying a patch
> > that a 3 way merge can resolve without conflicts. Even
> > in the case where there are real conflicts, performing
> > a 3 way merge will allow us to show the user the lines
> > where the conflict occurred.
> >
> > With the above in mind, I've created a small patch that
> > implements the behavior I'd like. Rather than disallow
> > the cached and 3way flags to be combined, we allow them,
> > but write any conflicts directly to the cached file. Since
> > we're unable to modify the working directory, it seems
> > reasonable in this case to not actually present the user
> > with any options to resolve conflicts. Instead, a script
> > or tool using this command can diff the temporary cache
> > to get the source of the conflict.
>
> Looks like you're focusing on content conflicts.  What about path
> conflicts?  For example, apply's --3way just uses a per-file
> ll_merge() call, meaning it won't handle renames, so your method would
> also often get spurious modify/delete conflicts when renames occur.
> How does your plan to just "cache" conflicts work with these
> modify/delete files?  Will users just look for conflict markers and
> ignore the fact that both modified newfile and modified oldfile are
> present?  I'm also curious how e.g. directory/file conflicts would be
> handled by your scheme; these seem somewhat problematic to me from
> your description.
>
> > Happy to address any feedback. After I address any major
> > changes I will add new tests for this path.
>
> Don't know the timeframe you're looking at, but I'm looking to modify
> cherry-pick and rebase to be able to operate on branches that are not
> checked out, or in bare repositories.  The blocker to that
That functionality would be great. I initially did look at what it would
take to modify sequencer to get what I wanted, but I quickly realized
it would be a big refactor.
> traditionally has been that the merge machinery required a working
> directory.  The good news is that I wrote a new merge backend that
> doesn't require a working directory.  The bad news is I'm still trying
> to get that new merge backend through the review process, and no
> current release of git has a complete version of that new backend yet.
> Further, the changes to cherry-pick and rebase have not yet been
> started.  There were some decisions to make too, such as how to handle
> the case with conflicts -- just report them and tell the user to retry
> with a checkout?  Provide some kind of basic information about the
> conflicts?  What'd be useful to you?
After thinking some more I'd generally agree with comments to leave
the conflicts at higher stages rather than check in the conflict markers.
This should result in less issues with path conflicts as well (or at least
be similar to 3way by itself). This is probably ok, because the conflict
markers can always be generated from the higher stage files (git diff or
git checkout -m -- .), but the reverse isn't true.
Overall 90% of the functionality comes from being able to do the 3-way
at all, since it's able to handle more cases correctly. Having *any* output
to tell the user why their operation failed would just be a bonus.

I'd envision flags similar to these, for cherry-pick

--cached : Do not touch the working tree to apply conflict markers.
Instead conflicts are left at a higher order in the cache.
--cached-parent : Checkout the index to the given commit, then
apply the cherry-pick with the given commit as a parent. Print out
the new commit. Warning: index will be left unsynchronized with
HEAD after this operation. Intended to be used with a temporary index
rather than the main one.

In the end I'm not sure how to still accomplish the desired functionality
without using a temporary index -- this would always result in
desyncing the user's index / working dir afterwards. Maybe error or
warn if the user isn't using a temporary index?
