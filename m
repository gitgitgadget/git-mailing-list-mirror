Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C42FC433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B1E64F5F
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 01:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhBCBI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 20:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBCBI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 20:08:59 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0903C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 17:08:18 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t29so15556498pfg.11
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 17:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wjplf8qmfCP0PBCllb+X7ch/rKITFbdyj/VEmm7QyqY=;
        b=LmCWmfaccGBqUFkmBSxFtkl9gyF2xJjKmIVQ/sVa/+Lb1afSKRb8LQ7VtAdVvxV7+V
         LpLKK/5iHTq8EMVQJ0cy5e3O/3kcC5+xyCHC6LrNkQHTtF3k6EjSxL5V28kaUq1IMXV5
         ka/x4bUg059jfc2GvXN6Sd1RZ4f5mHPGvn5u5y4qnMfa3wdGMYiFai782PIk6qhj0wtJ
         PJMcL33Jip4cB+BN5STiBeCLkAU3yVGR1Ge9IrvfbvdA5ZJkBGKHRBSHVLzeukIABKHU
         lBLe+h+M/da61KXyLYMSjkr7mLQwIXKXgXQyNkd8m2N4+hBqXJKT7OpTN+HYQ34jRTGU
         3Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wjplf8qmfCP0PBCllb+X7ch/rKITFbdyj/VEmm7QyqY=;
        b=ELDj+RlHl5onFwrkil/y3l7i3E7XQezgLnRhka/toaKVHABVb4+7PR7rK2wONLryG3
         AHx+4DsHIeYL5PBTKDlymSytBqJ89vJdm//8unY1zzlnAq3YLzdAJdrEjNgVlUXHeJhH
         uXxsa9ThJ73FzJTM9r+KZQ7io/jMFq6w1Egfg3oPZc/YWiZ2Tnj9IP0cMr3shF43JH4J
         gzEzXIlNdckTKL2mdEZydG8utvwLoh0G3uhQy9GuK4s0QshZV1Tk28z6iDnTxMUyqij6
         ZB2N69GXKrjCbIlXipYv0fVtyg8oModkpIc7Usy6t1D3nWdxkC7QJUTqIi11zay0tdVi
         mOMg==
X-Gm-Message-State: AOAM530obda+8QVLXEDpLT6xBbzdU4KlP/xgpbPS4JwpZkq0OCR6eA56
        ovlc9sZ8ZCRAhlTbc7Fw5hl+pKql0sg=
X-Google-Smtp-Source: ABdhPJzgZJxJuFzMvdRQGlLQzx4G6L907M1/cMXfKNA3paXsnhcgFP7kUxKrwDmh/9gU3Z6vWV7bbQ==
X-Received: by 2002:a05:6a00:168d:b029:1ba:d500:1209 with SMTP id k13-20020a056a00168db02901bad5001209mr687227pfc.4.1612314498374;
        Tue, 02 Feb 2021 17:08:18 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1c0e:cb1e:4abc:4be8])
        by smtp.gmail.com with ESMTPSA id i36sm173504pgi.81.2021.02.02.17.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 17:08:17 -0800 (PST)
Date:   Tue, 2 Feb 2021 17:08:15 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
Message-ID: <YBn3fxFe978Up5Ly@google.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
 <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:

> There is a subtle failure happening when computing corrected commit
> dates with --split enabled. It requires a base layer needing the
> generation_data_overflow chunk. Then, the next layer on top
> erroneously thinks it needs an overflow chunk due to a bug leading
> to recalculating all reachable generation numbers. The output of
> the failure is
>
>   BUG: commit-graph.c:1912: expected to write 8 bytes to
>   chunk 47444f56, but wrote 0 instead

At Google, we're running into a commit-graph issue that appears to
have also arrived as part of this last week's rollout.  This one is a
bit worse --- it is reproducible for affected users and stops them
from being able to do day-to-day development:

  $ git pull
  remote: Finding sources: 100% (33/33)
  remote: Total 33 (delta 18), reused 33 (delta 18)
  Unpacking objects: 100% (33/33), 27.44 KiB | 460.00 KiB/s, done.
  From https://example.com/path/to/repo
     05ba0d775..279e4e6d0  master     -> origin/master
  BUG: commit-reach.c:64: bad generation skip     29e3 >      628 at 62abdabd1be00ebadbf73061ecf72b35042338e3
  error: merge died of signal 6

"git commit-graph verify" agrees that the generation numbers are wrong:

  $ git commit-graph verify
  commit-graph generation for commit 4290b2214cdf50263118322735347d151715a272 is 3 != 1586
  Verifying commits in commit graph: 100% (1/1), done.
  commit-graph generation for commit b6c73a8472c7cb503cce0668849150a4b4329230 is 1576 != 10724
  Verifying commits in commit graph: 100% (10/10), done.
  Verifying commits in commit graph: 100% (88/88), done.
  Verifying commits in commit graph: 100% (208/208), done.
  Verifying commits in commit graph: 100% (592/592), done.
  Verifying commits in commit graph: 100% (1567/1567), done.
  Verifying commits in commit graph: 100% (8358/8358), done.

We have some examples of repositories that were corrupted this way,
but we didn't catch them in the act of corruption --- it started
happening to several users with this release so we immediately rolled
back.

Questions:

- is this likely to be due to the same cause, or is it orthogonal?

- what is the recommended way to recover from this state?  "git fsck"
  shows the repositories to have no problems.  "git help commit-graph"
  doesn't show a command for users to use; is
  `rm -fr .git/objects/info/commit-graphs/` the recommended recovery
  command?

- is there configuration or a patch we can roll out to help affected
  users recover from this state?

Thanks,
Jonathan
