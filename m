Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28CAC433F5
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 21:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B0C60F4A
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 21:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhIZV6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 17:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhIZV6o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 17:58:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21757C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 14:57:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i23so46412037wrb.2
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 14:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fJ21YE/MJ5/gFArH8Vd7bzBlqhKjfQVPb62NfrlB0sE=;
        b=YM+q9bbzBiWDRwcVt9zyo3cGnZOZJ0If3ucE8Wca0qMzOb9TkbxTYB6+oXy2lVR3Uq
         8DKYiyCWp7tlPQioaJpfndWglgrvPcJLzmJ/DaODx8jKfDVJJUwuOy83nU+v3oBwm2hT
         zl8bFQnfSQP+ZNTSP4STL7EjiQlDAwnmdSyEtmyt2/GZSLBp3MxQDs3WACjM7z8OuY9e
         ctD6KvfEZFt4iINTHJ/QxbDBt5B4Oqt6If9weWcSB/8bcEg4bhzIMYcpxyBhp/Fgp2Ih
         4JCISCEyKNWseNt2EObDwzVvFEt07PZ33U1ivDQa06yan7k53SvNoydXqt14V4huB9uM
         CdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fJ21YE/MJ5/gFArH8Vd7bzBlqhKjfQVPb62NfrlB0sE=;
        b=GYzF+zNdpM/qXxF/ulTv/hO3pewD894OYrrVkTe+RAUtDwqla5NIDuhtx9TArmsuZm
         /9O2nPYCGxt4aUc7F7ixiNQS7QPRhGfbU52eDH03p86ea/CZozbUfO0tcJOVa9L4hWHe
         OSMfDcpZCjxBeUN1LF83RRilf56WjYBTfZ4WL8QvHkyvz2wx3g4wHIZY85Omtzyq1mpM
         QB+zLbD/vUpMpRP+WCUn7a20nZbgnkTWe6nQ2n48kz3G5cdDkP1WgStalQOm3CZUZvTI
         d50ubmUaV/ZaJbBPAVL+HWsb3Nzc4T5ipUKtcFYJE68C23CPS2nAK6MgPM5kkiF0VfkL
         vBcA==
X-Gm-Message-State: AOAM530SoIGPQ1z/ENHS203MtrNUYERuxbFDL2ozwDCESBvhc0g72diI
        G7+pexU5AMO6aGrpsxVIPNZqH4MNpGs=
X-Google-Smtp-Source: ABdhPJyxnpxg1k5Bq6PByhcQvHNKmRAlKgGXRcZEMsMExbigItRcEqL/ZIAKGqHpuKYy5pRaH32fgA==
X-Received: by 2002:a7b:c209:: with SMTP id x9mr6387244wmi.9.1632693425632;
        Sun, 26 Sep 2021 14:57:05 -0700 (PDT)
Received: from szeder.dev (94-21-23-109.pool.digikabel.hu. [94.21.23.109])
        by smtp.gmail.com with ESMTPSA id u2sm2111832wrr.35.2021.09.26.14.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 14:57:05 -0700 (PDT)
Date:   Sun, 26 Sep 2021 23:57:03 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Matt Roper <matthew.d.roper@intel.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG REPORT] split-index behavior during interactive rebase
Message-ID: <20210926215703.GB3311029@szeder.dev>
References: <20210916055057.GT3389343@mdroper-desk1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916055057.GT3389343@mdroper-desk1.amr.corp.intel.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 10:50:57PM -0700, Matt Roper wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
>   I activated split index mode on a repo ("git config core.splitIndex
>   true"), performed an interactive rebase, modified a commit earlier in
>   the history.
> 
>   The steps can be reproduced via a sequence of:
>       $ mkdir tmp && cd tmp && git init
>       $ git config core.splitIndex true
>       $ for x in `seq 20`; do echo $x >> count; git add count; git commit -m "Commit $x"; done

It's important to note that this test repository has only a single
tracked file in it.

>       $ git rebase -i HEAD~10
>       
>       ## Add "x git commit --amend --no-edit" as the first command of
>       ## the todo list.
> 
> What did you expect to happen? (Expected behavior)
> 
>   My expectation was that there would still only be a single shared index
>   file in the .git directory upon completion of the rebase.
> 
> What happened instead? (Actual behavior)
> 
>   A large number of distinct sharedindex.* files were generated in the .git
>   directory during the rebase.

I think this works as intended.

A new shared index is written when the number of index entries that
would be writen to '.git/index' is higher than a given percentage of
the total number of index entries.  This percentage can be specified
with the 'splitIndex.maxPercentChange' configuration variable and it
defaults to 20%.  In your test repository above there is only a single
file and it is modified in every commit, so when switching from one
commit to the other 100% of the index entries would be written to
'.git/index', resulting in a new shared index file written for each
rebase step.

> What's different between what you expected and what actually happened?
> 
>   Rather than a single shared index file, I wound up with a huge number of
>   large shared index files.  The real repository I was working with (a Linux
>   kernel source tree) had a shared index file size of about 7MB, and I was
>   modifying a commit several hundred back in history (in case it
>   matters, these were all linear commits, no merges), so the resulting
>   collection of shared index files consumed a surprising amount of disk
>   space.

The last commit in my somewhat outdated linux repo contains ~71k
files, the 20% of that is ~14k.  Does that linear string of "several
hundred" commits modify that many files?

> Anything else you want to add:
> 
>   As an experiment, I tried setting splitIndex.sharedIndexExpire=now

I would advise against that, it's potentially dangerous, because it
can remove shared index files that are still in use by other git
processes.

>   to see
>   if it would avoid the explosion of shared index files, but it appears the
>   stale index files are still not being removed during the rebase, and I
>   still wind up with a huge number at the end of the rebase.  If I manually
>   run "git update-index --split-index" after the rebase completes it will
>   properly delete all of the stale ones at that point.
> 
>   Rebases that do not actually modify the history do _not_ trigger the
>   explosion of shared index files (e.g., "git rebase -i HEAD~10 --exec 'echo
>   foo'").
> 
>   If I do not set the core.splitIndex setting on the repository, but only
>   activate split index manually via "git update-index --split-index" there
>   is only one shared index file at the end of the rebase, but based on the
>   file size it appears the repository is no longer operating in split index
>   mode.
> 
>   Before:
>   $ ll .git | grep index
>   -rw-rw-r--   1 mdroper mdroper   149165 Sep 15 22:21 index
>   -rw-rw-r--   1 mdroper mdroper  7296080 Sep 15 22:21 sharedindex.f916dd59ccc22ca34298f557a4659aca2767dae4
> 
>   After (just amending HEAD~1 in this case):
>   $ ls -l .git | grep index
>   -rw-rw-r--   1 mdroper mdroper  7445145 Sep 15 22:22 index
>   -rw-rw-r--   1 mdroper mdroper  7296080 Sep 15 22:22 sharedindex.f916dd59ccc22ca34298f557a4659aca2767dae4

> git version 2.33.0

I could reproduce all this with v2.33.0 (except that I saw the split
index being turned off even with core.splitIndex enabled), but was
unable to do so with current master.

I think that this is a bug in the interaction between the split index
feature and 'git rebase' when using the recursive merge strategy and
when a couple of other, more subtle conditions are met.  It seems that
with the right conditions rebase only writes regular index files, and
by not entering the split index code paths it doesn't look for old
shared index files to expire.

After v2.33.0 we switched the default merge strategy from recursive to
'ort', and with that these cases appear to work as intended, i.e. old
shared index files are expired and the split index feature doesn't get
turned off.  Since the 'ort' strategy is in many ways better (faster,
more correct, etc.) than the recursive, I don't think it's worth the
effort to try to fix this issue with split index, rebase and the
recursive strategy.

