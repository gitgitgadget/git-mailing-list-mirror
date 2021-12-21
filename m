Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B0EC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 06:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhLUGKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 01:10:51 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:40507 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhLUGKv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 01:10:51 -0500
Received: by mail-pj1-f45.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so1493406pjo.5
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 22:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYFaaH/firIQDxveoZmcN9l4tsRYb+5IUhsG4sk+6r0=;
        b=xp2UkAEGv4Fit9u4I+J0vEiDJ5VbQB2bnmm3si5dGcdxQCb24TeEtwtTVBei6rxrPt
         gwnBrE5k/pc5Rj30WawmBgZQBM4uZtJq+qxpNc+8kkUBk+iwagRPPJ1C7DoOguQ48hNN
         KUN68RbwzFMELEjT9HO5V+qZ9rxsE/JPsNXHiUzp9juKjrlhPJMXi3nU95nS9AZlTI/p
         wIUZHWCv3kFG1TKTBLniYbbEtYE5BMOR9PVXr98mllr8sWIHtvMEXCmOqjFrISKEyzTL
         qfdRNWS9wdgohIzToHImw+OTxxoyyf6wZIh9R5MKGUbvoNFpxTyYqOfiwNHZDvaNNoDL
         gmjg==
X-Gm-Message-State: AOAM531QyMexncNGLFpkRK/8zRH3aIlu+AbkW2MBUfHcL7JwFiaEO0O0
        8JQX/fA4qX0A1AnnBnPf/Uf5srxazupTvn0CuRM=
X-Google-Smtp-Source: ABdhPJwQW2kiPUiRjB5KI16yDqIRUCnJ6xrpf7SFjRL3Xrogn+IxbZk6x/TPQo9DGH4SHPr27kdjwpGmKPL4eiuR+Xo=
X-Received: by 2002:a17:903:1247:b0:143:b9b9:52a2 with SMTP id
 u7-20020a170903124700b00143b9b952a2mr1596991plh.35.1640067050598; Mon, 20 Dec
 2021 22:10:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <CAPig+cTVzMtiHzkJq7VRg4Xa3xhrq7KKCdK5OSDY6bvwKu_ynA@mail.gmail.com> <cedea0bf-5def-86a4-5d3b-5377949c1f12@gmail.com>
In-Reply-To: <cedea0bf-5def-86a4-5d3b-5377949c1f12@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Dec 2021 01:10:39 -0500
Message-ID: <CAPig+cSW5wmKS1+KG2SWFO86uX24usP4dv3qX4fhKpgeZ8+Cww@mail.gmail.com>
Subject: Re: [PATCH 0/4] Sparse checkout: fix bug with worktree of bare repo
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 12:34 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 12/20/2021 11:21 AM, Eric Sunshine wrote:
> > Thanks for jumping on this so quickly. Unfortunately, however, as
> > mentioned in [1] and [2], I think the approach implemented here of
> > setting `core.bare=false` in the worktree-specific config is
> > fundamentally flawed since it only addresses the problem for worktrees
> > in which `git sparse-checkout init` has been run, but leaves all other
> > worktrees potentially broken (both existing and new worktrees). As far
> > as I can see, the _only_ correct solution is for the new helper
> > function to enable `extensions.worktreeConfig` _and_ relocate
> > `core.bare` and `core.worktree` from .git/config to
> > .git/worktree.config, thus implementing the requirements documented in
> > git-worktree.txt.
>
> Thanks for clarifying what I had misread. I commented on Patch 3 at the
> place that should be changed to relocate the setting. The test in patch 4
> could have multiple worktrees to verify that it works.

I sent several pages worth of response to patch [3/4] because
(apparently) I don't know how to be laconic.

> I'll plan on providing a v2 with that change tomorrow, leaving time to
> find any other glaring errors.

Let's make sure we agree on the proper approach and solution before
firing off v2.

> > I also raised a separate question in [2] about whether `git
> > sparse-checkout init` or the new helper function should be warning the
> > user that upgrading the repository format and setting
> > `extensions.worktreeConfig` might break third-party tools. However,
> > that question is tangential to the fix being addressed here and
> > doesn't need to be addressed by this series.
>
> Let's continue to simmer on this one. If there is a clear direction for
> doing this (should it just be an advice message?) then we can do that
> whenever.

Indeed, no hurry on this one. It's entirely tangential to the present
patch series, and requires discussion and thought; it can be tackled
later (if at all).
