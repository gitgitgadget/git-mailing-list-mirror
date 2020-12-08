Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D4AC2BB40
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0701E22582
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgLHUjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgLHUjl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:39:41 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2AFC0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 12:39:01 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id y21so6056235uag.2
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8RaVqwHhHkxWaMB+N1f3fvy6K+pUD+t2TfPSq9YYZbg=;
        b=nL1ZWFSHar/a8WucfmYAdMSAlJcWUi3mLoYFr+3X3NX+aTznQDR88REXfJOgPlgUgE
         egg8QQaZN5BWlKYe9F+u9c4nT+OZ5a3ZEXYBm9hVDEjjTzmvgKxrZlpOhM7NxwVigY+g
         c405/dIDX5FDUzVklPB0V6GpobJJ+A2oK5i5LlMPm6P/xlMa40hw6ArJoxZfu7eKICyg
         fYXQGR5cKNmNXwU9pYgXtnf8EeWAcXzgfQNPpyD9uTI6XGhotttOV1NbbZx5zS4qsFru
         5dzRpc7HlwOTfvz3cb18u96U+KDgOinscHxLWavOBWn1n9KEl/WNx0t/hivDdOl3cA49
         orug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8RaVqwHhHkxWaMB+N1f3fvy6K+pUD+t2TfPSq9YYZbg=;
        b=Q+xQq0Sl17H9ZOFVkZhKYm2BIUGkTm3DlRaIGD2SI7guVkfBhbefvSKgC9nDiPY+Vm
         45c5Bs7YlKxccWS4uNyx4ICUgcn/RADm3zCXZUIPtpy3hcbwKWmiT3wwp+aoNkFdSa2v
         iCkDlPiMwDlxLx5G7/Azn2j230G95OZieafH0MAgz+Tyr81xxWjvjbqrII5RAvELUHhE
         47pxu2J88Vq6KrLsu+lXozDzB/kbcpuzwo65qKlJ0Ug0V4a2WD8LaNMPBVqOY33gU886
         xiCLNwkXk2eMKn3jWhNu2L/uWzM3ncgYEVqWonKxGC/jhwEhoMH1eCOI3BCbf4kPqM1X
         rbnw==
X-Gm-Message-State: AOAM532pnYtqVC71jb57NemaBmvk4Mj4q5GJwcvCS6OOLC1zYnAztqpD
        FneA7pDBzHVMCvjVLVwOdbJ+sj6zoIbaIIkl
X-Google-Smtp-Source: ABdhPJwwSW3GWMSUkwrRu5FF+P91ATp3qGulM8Kof+4BT/8GFPjqBBJP/82Arhd34z2v+pQ42m1/Ug==
X-Received: by 2002:a05:6830:1650:: with SMTP id h16mr1878737otr.266.1607453400585;
        Tue, 08 Dec 2020 10:50:00 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z9sm2247129otj.67.2020.12.08.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:49:59 -0800 (PST)
Date:   Tue, 8 Dec 2020 13:49:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/15] Refactor chunk-format into an API
Message-ID: <X8/K1dUgUmwp8ZOv@nand.local>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <ee0b73f7-8f59-a1dc-0a21-bf796bf9f2e2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee0b73f7-8f59-a1dc-0a21-bf796bf9f2e2@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 01:48:31PM +0100, René Scharfe wrote:
> Am 03.12.20 um 17:16 schrieb Derrick Stolee via GitGitGadget:
> > I was thinking about file formats recently and realized that the "chunks"
> > that are common to the commit-graph and multi-pack-index could inform future
> > file formats. To make that process easier, let's combine the process of
> > writing and reading chunks into a common API that both of these existing
> > formats use.
> >
> > There is some extra benefit immediately: the writing and reading code for
> > each gets a bit cleaner. Also, there were different checks in each that made
> > the process more robust. Now, these share a common set of checks.
>
> >  Documentation/technical/chunk-format.txt      |  54 ++
> >  .../technical/commit-graph-format.txt         |   3 +
> >  Documentation/technical/pack-format.txt       |   3 +
> >  Makefile                                      |   1 +
> >  chunk-format.c                                | 105 ++++
> >  chunk-format.h                                |  69 +++
> >  commit-graph.c                                | 298 ++++++-----
> >  midx.c                                        | 466 ++++++++----------
> >  t/t5318-commit-graph.sh                       |   2 +-
> >  t/t5319-multi-pack-index.sh                   |   6 +-
> >  10 files changed, 623 insertions(+), 384 deletions(-)
>
> 623-384-54-3-3-1-69-2-6 = 101
>
> So if we ignore changes to documentation, headers, tests and build
> script this spends ca. 100 more lines of code than the current version.
> That's roughly the size of the new file chunk-format.c -- from this
> bird's-eye-view the new API seems to be pure overhead.
>
> In the new code I see several magic numbers, use of void pointers and
> casting as well as repetition -- is this really going in the right
> direction?  I get the feeling that YAGNI.

I think that Stolee is going in the right direction. I suggested earlier
in the thread making a new "chunkfile" type which can handle allocating
new chunks, writing their tables of contents, and so on.

So, I think that we should pursues that direction a little further
before deciding whether or not this is worth continuing. My early
experiments showed that it does add a little more code to the
chunk-format.{c,h} files, but you get negative diffs in midx.c and
commit-graph.c, which is more in line with what I would expect from this
series.

I do think that the "overhead" here is more tolerable than we might
think; I'd rather have a well-documented "chunkfile" implementation
written once and called twice, than two near-identical implementations
of _writing_ the chunks / table of contents at each of the call sites.
So, even if this does end up being a net-lines-added kind of diff, I'd
still say that it's worth it.

With regards to the "YAGNI" comment... I do have thoughts about
extending the reachability bitmap format to use chunks (of course, this
would break compatibility with JGit, and it isn't something that I plan
to do in the short-term, or even necessarily in the future).

In any event, I'm sure that this won't be these two won't be the last
chunk-based formats that we have in Git.

> René

Thanks,
Taylor
