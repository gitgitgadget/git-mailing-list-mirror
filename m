Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8BFC433DF
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 10:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7B82087D
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 10:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU2KHJyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbgJKKEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 06:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgJKKEM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 06:04:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F5BC0613CE
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 03:04:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l15so11895278wmh.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CIIei7el7aby5PgvWdnsiy7M3d+40HrCNz0PfShuCjU=;
        b=lU2KHJywu8qf902CYNMOATKVV6BRlgvvmWAWkpfIyOamcVb87tm9U20HgcK6apaiPH
         at8/rv4VjdYdOQqlKQh0G45w4pzOw1d9y1+IwJ/FH9/+g5J8GD1XzvudGSambQ9mjLcj
         LuUcO1STWa5tbYgoSdmgRsA/2yofJo7UPbIWnt8lSVITdFuKva1wtMG18HiSBsC7yOWx
         oHZfg+8kpATOPiKM5ynV7552XEWieKRgmo+fzeCEGJi74DOobe4xVKN+w7+LmIU/1bu1
         fqQ31PeKuIUUFewzJdehH0YUXB66PzT9k7uuysql/itjXVKTadJjhxdZyO/Sj4yCu+lp
         9ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CIIei7el7aby5PgvWdnsiy7M3d+40HrCNz0PfShuCjU=;
        b=A8W/sKkwkiYNdW+FolpF++MLACvq8lwgFhSnkIC73c39D6PXzd5vfNTOc7XKi9Yglf
         0oElsxiqffbV/YIg8IXjLl1iJgIF2coIS6rl4M0LWq76TjHHz4ioRruPq8be4xpWpWeb
         La756osx/zjR79HGrLso2OpX4EXY5/47639QhQfwftyhuVT+NMCg39cN7Ch3IQDUlGWX
         nEjRPWyPBlDjcihPdN1t7xQx3Cvm5PdJOoPeVG/dM/u5RIOOVPVDwRbunt5FTxwUcD5A
         1XmfABMXQUvKx26l37PWOD4EIAbnBTG7BYYG+iIBOHHjNlOR93OR0E2w+S0ULFj0+svR
         OAlg==
X-Gm-Message-State: AOAM530Kx7omL89XjWRkj2ZGuBbiRRkMMeSroZD3NCctzhMEbW6PdgSM
        857BZpGuExNsMkVIgWkyHps=
X-Google-Smtp-Source: ABdhPJzXZYxZTOQ7lI5kPjwOpSeCG4F5mGN5ySe3frXhBbK6F5bsmc063jl7h6/ZExGdYLYOBzH5yg==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr6146998wmk.73.1602410649373;
        Sun, 11 Oct 2020 03:04:09 -0700 (PDT)
Received: from contrib-buster.localdomain ([79.140.120.253])
        by smtp.gmail.com with ESMTPSA id t16sm19864659wmi.18.2020.10.11.03.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 03:04:08 -0700 (PDT)
Date:   Sun, 11 Oct 2020 10:04:06 +0000
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] worktree: teach `list` to annotate locked worktree
Message-ID: <20201011100406.GA5151@contrib-buster.localdomain>
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
 <20201010185521.23032-1-rafaeloliveira.cs@gmail.com>
 <20201010185521.23032-2-rafaeloliveira.cs@gmail.com>
 <CAPig+cTq5tz8m0bCJ3GtCa9yzOMNvd7j4fSJNwO9xjqkfK+YOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTq5tz8m0bCJ3GtCa9yzOMNvd7j4fSJNwO9xjqkfK+YOg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 11, 2020 at 02:26:31AM -0400, Eric Sunshine wrote:
> On Sat, Oct 10, 2020 at 2:56 PM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
> > The "git worktree list" shows the absolute path to the working tree,
> > the commit that is checked out and the name of the branch. It is not
> > immediately obvious which of the worktrees, if any, are locked.
> >
> > "git worktree remove" refuses to remove a locked worktree with
> > an error message. If "git worktree list" told which worktrees
> > are locked in its output, the user would not even attempt to
> > remove such a worktree or would know how to use
> > `git worktree remove -f -f <path>`
> 
> I would drop "how" from "would know how to" so it instead reads "would
> know to" since seeing the `locked` annotation only lets the user know
> that removal must be forced; the `locked` annotation doesn't teach the
> user _how_ to remove the worktree using force. But, perhaps, my
> original suggestion[1], which did not use "how", was confusing. Maybe
> it could be worded instead:
> 
>     ... not even attempt to remove such a worktree, or would
>     realize that `git worktree remove -f -f <path>` is required.
> 
> Anyhow, this is a very minor nit about the commit message; not
> necessarily worth a re-roll. More comments below...
> 
> [1]: https://lore.kernel.org/git/CAPig+cQHDuWy1vc_ngXbMQZQ=a9fd6S5_cCU-2sb_+Te5aEOhw@mail.gmail.com/

The "would realise ..." seems clear to me, will change on the
patch as I will address the test changes aforementioned.

> 
> > diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> > @@ -97,7 +97,8 @@ list::
> >  List details of each working tree.  The main working tree is listed first,
> >  followed by each of the linked working trees.  The output details include
> >  whether the working tree is bare, the revision currently checked out, and the
> > -branch currently checked out (or "detached HEAD" if none).
> > +branch currently checked out (or "detached HEAD" if none). For a locked
> > +worktree the `locked` annotation is also shown.
> 
> I might have dropped the "and" in the final context line and instead
> written this as:
> 
>     ... branch currently checked out (or "detached HEAD" if none),
>     and "locked" if the worktree is locked.
> 
> But not worth a re-roll.

Agreed. I believe it makes the documentation more concise.

> > diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> > @@ -61,6 +61,16 @@ test_expect_success '"list" all worktrees --porcelain' '
> > +test_expect_success '"list" all worktress with locked annotation' '
> > +       test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
> > +       git worktree add --detach locked master &&
> > +       git worktree add --detach unlocked master &&
> > +       git worktree lock locked &&
> > +       git worktree list >out &&
> > +       grep "/locked *[0-9a-f].* locked" out &&
> > +       ! grep "/unlocked *[0-9a-f].* locked" out
> > +'
> 
> These grep invocations are a bit loose, thus concern me a little bit.
> 
> First, in Junio's original example of using grep[2], he had two spaces
> after the path component, not one as you have here. The two spaces in
> the regex ensure that there is at least one space separating `/locked`
> and `/unlocked` from the OID hex string, whereas with just one space
> in the regex, as is done here, the space following the path component
> is entirely optional (thus is a less desirable regex).

That is interesting, I didn't know that will be the case - Nice to know :).
Thank you for the explanation.

> 
> Second, because these regexes are not anchored, they could match with
> a false-positive if the person's TRASH_DIRECTORY path is something
> like `/home/proj/unlocked dead locked/git/t/...`. If you anchor the
> pattern with `$`, then this problem goes away:
> 
>     grep "/locked  *[0-9a-f].* locked$" out &&
>     ! grep "/unlocked  *[0-9a-f].* locked$" out
> 

That is very good point and I will re-roll the patch with these two points
addressing the test cases. Thanks. 

