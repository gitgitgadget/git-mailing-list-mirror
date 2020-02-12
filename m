Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC3AC352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 20:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4C924677
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 20:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="aFl86vsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgBLUSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:18:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46197 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLUSO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 15:18:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so1361464pll.13
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 12:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U3ZRXIlRWwvWoLDZdmQ56RZ0gFezjkpjYPha+wm5K3U=;
        b=aFl86vsEGM5l5Yk1dKCkZV+7ot57rmkdhsEUDxBJsHvyMF5fjgmraLEnwxNMGhJQXe
         fGAYJgEDjBq8UmSsLoBh30R9RcfwvGjVz8pDDv/Fbz63xOj8VCY33GHLDe2EoU9244hA
         X81XuTUBJpk9Byi+VKgJ9CvbEtGEUKjkRBohXD9/a+GNvKESI8sY+AEZ3xC4I1uWzC7s
         N7vxl7FR8wZW/0TW+o9io2Uh/d507QN9GqZi+LNiW1fe1IxBfxpoJFtpyWdxXfM1G044
         7rWsWK+qfVtI9z/wM3mMUsitbDZw4ZGze71vDYLzELe/HRkIAVJ5DrPNSuBgvu0bVYEJ
         Sybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3ZRXIlRWwvWoLDZdmQ56RZ0gFezjkpjYPha+wm5K3U=;
        b=kxW7wJH9VCAZa4uPTyu32bs/o4qRUEqhbyJwlYmqLp5u0zmKI8eCcnSCHephQnnhTd
         YLpGQBtKpfDaHer8+R7Ewnt6G6J39tJXEUyh75WTH0hREfWjvtjWSWL1OC7WGNGwHyd7
         Ds2RcXUuh/54N37OUMIs3WmxQ3wImOvIMyrdyamSy0cBtbvS3NFrbWHrG/NNusRri1zC
         Yogs5aW354+H7C6du3+kKuf547Gi2oYkwScEDcf6ETLpxaSpAU8UJlmAHAlR2g21RxSY
         yCGGJzidvFoiYe4eQV4ssBNJikgzsfOpWsuK/qawV52yiaEIQjob6I87ZV7Ra1NJqx/s
         +Pkg==
X-Gm-Message-State: APjAAAWs+oouhWAVvZxgOQ0yS1oaBgoV9a7n5tfIzvf7QTv7zcd4oBTN
        qrjx+PretW/TDMI6GL9/paA0OA==
X-Google-Smtp-Source: APXvYqwTtb70ZLa4XG3CVFherIkqwl8SnXDec72cYdEZEwp+wSp84DKi2sWcfMgVbgQzvzTCCIN7CQ==
X-Received: by 2002:a17:90b:8d1:: with SMTP id ds17mr879231pjb.33.1581538692564;
        Wed, 12 Feb 2020 12:18:12 -0800 (PST)
Received: from localhost ([205.175.106.8])
        by smtp.gmail.com with ESMTPSA id k8sm1424008pgg.18.2020.02.12.12.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 12:18:11 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:18:10 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Parth Gala via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Parth Gala <parthpgala@gmail.com>
Subject: Re: [PATCH 0/5] object.c: localize global the_repository variable
 into r
Message-ID: <20200212201810.GB4364@syl.local>
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.545.git.1581535151.gitgitgadget@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Parth,

On Wed, Feb 12, 2020 at 07:19:06PM +0000, Parth Gala via GitGitGadget wrote:
> I have created this commit in response to
> https://github.com/gitgitgadget/git/issues/379#issue-503866117.

Fantastic! Thank you for working on this.

> All the functions in object.c which relied on 'the_repository' have
> been modified.  The functions calling these functions in object.c
> consisted calls to other functions using 'the_repository' as well, and
> although I intended to use 'r' at all those instances, I thought it
> would make more sense when we would deal with their callee functions
> in another similar patch. What do you think ?

That makes sense, and follows the conventions that other similar
refactorings have done in the past.

Any reason why you decided to start with 'object.c'? Not that any such
reason is necessary, I'm just curious about how you came to this
decision.

> Signed-off-by: Parth Gala parthpgala@gmail.com [parthpgala@gmail.com]

Even though you *do* need a 'Signed-off-by' in each of your patches,
adding it in the cover letter is not necessary.

> Parth Gala (5):
>   object.c: get_max_object_index and get_indexed_object accept 'r'
>     parameter
>   object.c: lookup_unknown_object() accept 'r' as parameter
>   object.c: parse_object_or_die() accept 'r' as parameter
>   object.c: clear_object_flags() accept 'r' as parameter
>   object.c: clear_commit_marks_all() accept 'r' as parameter
>
>  builtin/checkout.c               |  3 ++-
>  builtin/fsck.c                   |  8 +++++---
>  builtin/grep.c                   |  6 ++++--
>  builtin/index-pack.c             |  5 +++--
>  builtin/log.c                    |  3 ++-
>  builtin/name-rev.c               |  5 +++--
>  builtin/pack-objects.c           |  3 ++-
>  builtin/prune.c                  |  3 ++-
>  bundle.c                         |  8 +++++---
>  http-push.c                      |  3 ++-
>  object.c                         | 32 ++++++++++++++++----------------
>  object.h                         | 12 ++++++------
>  pack-bitmap.c                    |  5 +++--
>  reachable.c                      |  6 ++++--
>  refs.c                           |  3 ++-
>  revision.c                       |  3 ++-
>  shallow.c                        | 13 ++++++++-----
>  t/helper/test-example-decorate.c |  7 ++++---
>  upload-pack.c                    | 19 ++++++++++++-------
>  walker.c                         |  3 ++-
>  20 files changed, 89 insertions(+), 61 deletions(-)
>
>
> base-commit: 0ad714499976290d9a0229230cbe4efae930b8dc
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-545%2FParthGala2k%2Flocalize-the_repository-variable-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-545/ParthGala2k/localize-the_repository-variable-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/545
> --
> gitgitgadget

Thanks,
Taylor
