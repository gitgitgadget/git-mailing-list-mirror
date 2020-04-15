Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C87C2BB1D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9992076B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="YHNBcoOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392261AbgDOAHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392254AbgDOAHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 20:07:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32300C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:07:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ng8so6016325pjb.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wN47YJNCBX9LswGTXN111W37MnS/FUH2jHo9Rc5XLEE=;
        b=YHNBcoOMPc1uzRjbG5QoopJm41/msezRe7xp49ixNfPX3FKa86xLeeWmuQc+9XVRdh
         X90oKL+xtnh7ek9N3ACsiSVtFUl/9RSZ7ULEHfLt7N730fLQtgua2PWbfZHMbOhAoUrX
         iQyWqP7E0HeehmT3MoY6lnH1RzSqROIpkwxxcpBFTv1SOfFdwTSZsCa8yO1fPpKEgluB
         vzDJRPHl7uAvSAo60n7I6mwMYcjVC6kqIJyd7mqonlwp2UEjzb19zQAyyLhGYVYChAFN
         XG+LAGaG9A8ohrlD14Q06FhLhoQcWS0TyRM0GUrV0NWaxQhl9NWEUCQTMhhIPd8GkAwl
         mx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wN47YJNCBX9LswGTXN111W37MnS/FUH2jHo9Rc5XLEE=;
        b=JsxKxJiPjV9U0pr9PXrgOsXe7Nvc9C0ciw9A8tzoPIDBxtKWSXoHhw0xHascDKDCJp
         YbkFfr1G1le4HqfHQguiN9DVfewnYpU8z9cPASzr4/qbaa+Ad6I8FOZ7D/A6MzhuVpfh
         Kvp4F/WEhbk43IH7/UBzPwdrnktp2Bg6hBZplqH3bWP/FPj7oXG5R+0sy/uFklhBwYf3
         3LiwYOImpozaa2c+OdeiVn/lH2EOVlRnioLzwM/MhpbY+0qD0IegRRSBKI7UyG0gu0bB
         xR2bPukjxyYWBdEhiC7MNtlh0ElSP1cRy4uZop+BuIes+WT6SWLAXC/mVDh0YBSTrxCi
         2/ow==
X-Gm-Message-State: AGi0PuZiabbeQGpfIei9207NX2v/3G3itAfFVK/XGuw2dZc98JrNTRhs
        7Gq39TH9ZXi+QOg0vN4Zl5iIGDYwr1p1qOyd
X-Google-Smtp-Source: APiQypKQwq+Z2d7jIBxPkn3QUQM1t3loqoYfelZm91dvYTaoN61/kb8AJwOQhRHwvIx03I7lq1Ddzw==
X-Received: by 2002:a17:90a:252b:: with SMTP id j40mr3165803pje.60.1586909250254;
        Tue, 14 Apr 2020 17:07:30 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q12sm11149473pgi.86.2020.04.14.17.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:07:29 -0700 (PDT)
Date:   Tue, 14 Apr 2020 18:07:28 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Is fetch.writeCommitGraph (and thus features.experimental) meant
 to work in the presence of shallow clones?
Message-ID: <20200415000728.GA7382@syl.local>
References: <CABPp-BHGubUX5o9KsQaoh_UFjFh2PaMkkJhCao+5LGnFc0dQNg@mail.gmail.com>
 <aca12331-f8e3-28a2-acb6-df9d7e2e70e1@gmail.com>
 <20200414235057.GA6863@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200414235057.GA6863@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 05:50:57PM -0600, Taylor Blau wrote:
> On Tue, Apr 14, 2020 at 04:31:19PM -0400, Derrick Stolee wrote:
> > On 4/14/2020 4:22 PM, Elijah Newren wrote:
> > > Hi,
> > >
> > > I was building a version of git for internal use, and thought I'd try
> > > turning on features.experimental to get more testing of it.  The
> > > following test error in the testsuite scared me, though:
> > >
> > > t5537.9 (fetch --update-shallow):
> > >
> > > ...
> > > + git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
> > > remote: Enumerating objects: 18, done.
> > > remote: Counting objects: 100% (18/18), done.
> > > remote: Compressing objects: 100% (6/6), done.
> > > remote: Total 16 (delta 0), reused 6 (delta 0), pack-reused 0
> > > Unpacking objects: 100% (16/16), 1.16 KiB | 1.17 MiB/s, done.
> > > From ../shallow/
> > >  * [new branch]      master     -> shallow/master
> > >  * [new tag]         heavy-tag  -> heavy-tag
> > >  * [new tag]         light-tag  -> light-tag
> > > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > > error: Could not read ac67d3021b4319951fb176469d7732e6914530c5
> > > fatal: unable to parse commit ac67d3021b4319951fb176469d7732e6914530c5
> > >
> > > Passing -c fetch.writeCommitGraph=false to the fetch command in that
> > > test makes it pass.
> > >
> > > There were also a couple other tests that failed with
> > > features.experimental=true (in t5500), but those weren't scary -- they
> > > were just checking exact want/have lines and features.experimental is
> > > intended to change those.  This test from t5537 was the only one that
> > > showed some unexpected fatal error.
> >
> > Well, commit-graphs are not supposed to do anything if we have
> > shallow clones. We definitely don't load a commit-graph in that
> > case. Seems like we need an extra check in write_commit_graph()
> > to stop writing in the presence of shallow commits.
>
> This rang a bell to me, too. There's a bug, but it's due to the mutative
> side-effects of 'is_repository_shallow' along with '--update-shallow' (a
> normal 'git fetch' works fine here, with or without
> fetch.writeCommitGraph).
>
> Here's a patch that I didn't sign-off on that fixes the problem for me.

Oh, apparently I did sign this one off ;). I'll blame that 'git commit
--amend -vs' is muscle memory for me. In either case, this probably
needs some work (if it's even the right approach) before queueing it.

> --- >8 ---
>
> ...

Thanks,
Taylor
