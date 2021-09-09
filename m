Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88CDC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14DB60F45
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 17:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242419AbhIIRxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 13:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhIIRxE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 13:53:04 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4BBC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 10:51:55 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id a16-20020a63d410000000b00268ebc7f4faso1583758pgh.17
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lvM8HMlJI5jcGrCXy8kNTrXUEM0UxXxzDbTy+RaryHc=;
        b=GIf2VU805VeqBwC6yHT+mjAejKIC8gGyqKxQAbPXGJEKwUWHDAUeZYffPuRfoSVK25
         z+w4bMP6JKcrX1no5/hKh3nryeVnpR25gfO5ByDzQ/NRNG82FBNBGg7WzGapL9DZaBD0
         Myp+ozj6ao0SvKX5ZM5lGGnlL3X77N6Tf7k08u4zhw2OTxr6/EUyPWJQaOKHZTdIltWq
         rF0SLn1umf05QPNZLqeII62gZ5GB+Ii7hISH52SvQBWCVv2mLmI1EVXCqW5Rro5/GFgk
         95jm2+Aq3fS5yePxSKSJn7igMwwPsu8x6efrCUpLeZ/xYhyre6lpaVCQnQt5oLwPbBYO
         SA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lvM8HMlJI5jcGrCXy8kNTrXUEM0UxXxzDbTy+RaryHc=;
        b=pjarZ70m3Up48jPCE4zsEGHdFR0k0afjhGgNi6rtUwu6ZT6PLw3k9G1NIdKOKQ5e4M
         eGTadxCJcr7z0BEOtbv0rc4G3hrgEmp0X8ei69PHBaoJkoeDyvptRILTuXmTserzuxxd
         oKu3eq0Qu8PaoD0wmSisB1VPP0P+zBzNedB98AOkTY+YrG4doj6k2pQxbxV4oPYO8m/Y
         1w8/N+mcVbX5IBDwQguk3/AUjbZYR9QK4JiW712x0C63sElOcdr1cBFD0h0aiQq4dfu7
         53ToX80XM+3tyi8EYHDawwIl8vxApzuUE62Ahd2CAc0aqPPvvqQoAO5ndVu1HM9G6X4k
         UQ+Q==
X-Gm-Message-State: AOAM530tAvoxVqAaPd8fBHk0B9PkbWvAfPotoXDCfNt5ewHw/ebqrQsI
        s+xmO2atNzImjCkVGgem6/wN01dJGMuNf8iPtV8e
X-Google-Smtp-Source: ABdhPJxOj/HjnIn4LQYkXvzW16b4sTnDdT2vAqo6UPVf+Bfjijok9N+WIWiD2jb1TDr52F8O0JnEKtTfzUZKbcmaXl05
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:fd7:: with SMTP id
 gd23mr70540pjb.1.1631209914613; Thu, 09 Sep 2021 10:51:54 -0700 (PDT)
Date:   Thu,  9 Sep 2021 10:51:52 -0700
In-Reply-To: <CABPp-BGKBMtue-T1ah-+RQHJ+ceYBVsqs54Vx0p-Hs+UkLXPtw@mail.gmail.com>
Message-Id: <20210909175152.2550626-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BGKBMtue-T1ah-+RQHJ+ceYBVsqs54Vx0p-Hs+UkLXPtw@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: Re: [PATCH 0/3] More add_submodule_odb() cleanup in merge code
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Sep 8, 2021 at 11:18 AM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > (CC-ing Elijah in case he has insight into the merge-ort part.)
> 
> All the submodule merging related functions were lifted from
> merge-recursive.c and minimally modified to fit the new structure.
> The only substantive change I made was to fix the merge result for
> virtual merge bases, but that's like one or two lines of code.  In
> particular, everything relating to submodule objects was totally
> untouched...and I think that's reflected in the fact that your PATCH 2
> basically is the same patch twice, once for merge-recursive and once
> for merge-ort.
> 
> I read over PATCH 2 and I didn't find anything that looked
> problematic, but I'm not up-to-speed on the add_submodule_odb and repo
> handling bits of the codebase so I'm not sure I would catch anything.
> But I am encouraged by the fact that it looks like you did the same
> stuff to merge-recursive and merge-ort; I'd be worried you missed
> something if that weren't the case.

Thanks for taking a look.

> As a sidenote, though...
> 
> This does remind me that I noticed that the following functions from
> object-store.h do not take an explicit repository:
> 
> write_object_file()
> hash_object_file()
> hash_object_file_literally()
> force_object_loose()
> 
> I have a patch sitting around somewhere (possibly only still
> referenced in my 'temp' branch) to make repo_*() variants of the above
> functions, and turn the above into simple wrappers of the repo_*()
> variants which just pass the_repository (much like someone else did
> with read_object_file() and repo_read_object_file()).  It also updates
> merge-ort to use the new repo_*() functions.  However, I ended up
> excluding it from my merge-ort submissions since it wasn't necessary.
> Would this be of interest in your submodule work, though?  I guess
> it'd only matter if we started doing real merges of submodules as part
> of a parent repo merge.  (As opposed to the fast-forward-only merges
> that merge-recursive/merge-ort do right now for submodules.)

I think that these functions would be useful if we were to write into
submodules (for example, in a real merge of submodules, as you said).
Right now my submodule work is just making it support partial clones, so
I'm not planning to introduce any new submodule writes. (Well, besides
the fact that a lazy-fetch in a submodule would end up with new objects,
but that's already handled because we do the fetch in a separate process
in the submodule's gitdir.)
