Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4BBC433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 03:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B11A61350
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 03:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbhKHDYa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 22:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhKHDY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 22:24:29 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394D9C061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 19:21:46 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id l8so15526623ilv.3
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 19:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+nBMRub79VEPXBx7p2Z418u4zlhzBYGtA4ck881nEiw=;
        b=Y47Y4Pp8Mpgv0QWAMEzjag/tDnx1BpPn+vQTR+gla4FR+mxdsmt1X0ENDhToyTf6vT
         zpXkdWBtD4G+yi8zPWYRKGQZ8QMezCjIdg4zL6D4/X09K/dUECsD85SnpQt9nzjXlr6j
         Kn3c4XbmgmI4t5TKM8geDKOcIb1VS4XPpSwglpZopss1cTVyhvi5SlaZ/PiJcG0Xo7mQ
         d28ynFT53UsOI82J+Q6kjJAoQ3Texi35qbIa2i+f6icQagaAeGHwn8xmXFLX14M/HWBK
         3KhULIUTdDcdwM0MPZgf2YWTGNJR6NVaT1yM4Zge1Ia0XBQ23+ltEtQmBSSS0I1wGb5P
         GA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+nBMRub79VEPXBx7p2Z418u4zlhzBYGtA4ck881nEiw=;
        b=3jgkr5oN0nYW9CoJhh5PhSLArfxjke8ZGo3cscwG3qgCqf6yF11t6hyQWRoQcQwVT/
         picq7kltO9U7DDXqQV4V2p98sfdIzzll1AgzE27vMg7Cs1WxwSe/w2p9cR+qG6gIZKnK
         S9sbj8cfWaXsHvC/VfZcCL0E7z4B+fuEIEDh/g9izVm6u/1IvsdKCPhm5Dyxc1eUliPx
         n/QNhownw9u045zBiJE0tOIHwOaq6HEWBvRaT1PD+BkwO+SYycHRJY5owP9KkqpT85fi
         R6CskEFplGsLH6HH9V4Gj3BL0Z0EagYyFCIwimnu8xjZtgvPqAZV7EtiuDvTXooDk/7a
         PObw==
X-Gm-Message-State: AOAM530JrJEyQmPJ+Q/Q2rG4q4m71FfjSpvdWxOxkLg2uzRQ0jV2mjs/
        OYnOIRGeTAZEl2H+S3aYsKXgT+EYx61aIO+q
X-Google-Smtp-Source: ABdhPJxxbyaFm1h8ArqVu44yOPd03h0REJGXH3UzfkpXTdvJfxONyVuj+eJORGKQeL5cd7dvpwGbbg==
X-Received: by 2002:a05:6e02:1b08:: with SMTP id i8mr42479551ilv.130.1636341705436;
        Sun, 07 Nov 2021 19:21:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p14sm7368366ilo.39.2021.11.07.19.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 19:21:44 -0800 (PST)
Date:   Sun, 7 Nov 2021 22:21:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Birk Tjelmeland <git@birktj.no>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] stash: show error message when lockfile is present
Message-ID: <YYiXw41upJfPS7l0@nand.local>
References: <20211107213012.6978-1-git@birktj.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211107213012.6978-1-git@birktj.no>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 07, 2021 at 10:30:12PM +0100, Birk Tjelmeland wrote:
> Multiple git-stash commands silently fail when index.lock is present,
> including git stash push and git stash apply. This is somewhat confusing
> and a better behaviour would probably be to exit with a meaningful error
> message like most other git commands do.

We do terminate with non-zero exit code when trying to, for e.g., 'git
stash push' when $GIT_DIR/index.lock already exists. That is reflected
in your patch by not adding any new paths which we return, which makes
sense.

> This patch updates repo_refresh_and_write_index to accept another
> parameter lock_flags and updates some callsites of this function to call
> it with LOCK_REPORT_ON_ERROR resulting a suitable error message when the
> relevant git-stash commands used on a repo with an index.lock file.
>
> This patch only adds the described error message to git-stash commands,
> however the diff highlights other uses of repo_refresh_and_write_index
> which could also benefit from the changes. On the other hand these
> callsites already have some limited error messages.

I wonder if there are callers of repo_refresh_and_write_index() that
don't want any errors reported. Not having thought about it too hard
(much less looked through any of these callers), I would expect that
having the choice to either error() or die() is something worth keeping.
But I do not know if there are callers which want neither.

> Signed-off-by: Birk Tjelmeland <git@birktj.no>
> ---
>  add-interactive.c | 4 ++--
>  add-patch.c       | 4 ++--
>  builtin/am.c      | 2 +-
>  builtin/merge.c   | 4 ++--
>  builtin/stash.c   | 6 +++---
>  cache.h           | 4 ++--
>  read-cache.c      | 3 ++-
>  7 files changed, 14 insertions(+), 13 deletions(-)

It looks like the sum-total of this patch are a few things:

  - repo_refresh_and_write_index() gets a new lock_flags parameter which
    is passed down to repo_hold_locked_index()

  - refresh_and_write_cache() which is a thin wrapper around
    repo_refresh_and_write_index() also learned the new parameter

  - do_apply_stash(), do_create_stash(), do_push_stash() all pass
    LOCK_REPORT_ON_ERROR via the new lock_flags parameter

That all makes sense to me. It results in us printing a helpful error
message when we couldn't acquire an exclusive lock on
$GIT_DIR/index.lock where before we would have silently failed and
exited non-zero (which is not exactly a *silent* failure, but it is
close).

This patch does not include any tests, which I think that you should add
in another revision before we consider queuing this.

Thanks,
Taylor
