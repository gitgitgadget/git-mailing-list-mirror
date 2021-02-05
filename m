Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ADDC433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 07:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8A264F70
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 07:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhBEHbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 02:31:13 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:46645 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhBEHa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 02:30:59 -0500
Received: by mail-ed1-f49.google.com with SMTP id y18so7570362edw.13
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 23:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrxYKcVZem7HCdoi61nim1m3/DIhThWejUe1taapE1A=;
        b=lo8OXuMph8EjVYsKJK4msksIrCoPQmmXbz/s2DQs0mCL/2zRi9yZGQNTeMALz/ixJB
         HQNrqSMSnaXPThTO+zDbo644Vxsqo+DptUFlgJwBuXgp76WsCGFTIzr9IGwSZ6HqcJaT
         CR+HZ+GaVZUr1TyyeGJXw2vkgTx5CDgApk14+ZBuEOSoBZfcUNrmZizbwh5lg2/LeMyY
         3zfdQUQR86ArOdE3UO3KIltUc1ZpX+xDqWEp+0t1p+Lo7IAOKc6OqXg7gCjhzWQ6bCzL
         KdleOKoz7+36EmEZRX6I/yn4CdGyYEOevRhbMD7Wp2mXCMnJADDs6IHdjrzJD7SMyUwv
         EStA==
X-Gm-Message-State: AOAM530RjzMTt2ZT5ihorziz3gxAQ3YYGLrp5PA+LUKHnHKLx6PSkWz5
        Rp/fP082TBYnzxsgaPoTuP+MBCsWWgqGFx/mnEfn3bCGZr4=
X-Google-Smtp-Source: ABdhPJw8sKDNiWaqUacMhhcTPtClOyTuBoPQan56zqVoepfAhYY8lS2tK7fpEqv4++8PPS9YyRJ/P8GnemztZ5QO5X0=
X-Received: by 2002:aa7:cb0d:: with SMTP id s13mr2255351edt.221.1612510217024;
 Thu, 04 Feb 2021 23:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20210129182050.26143-1-charvi077@gmail.com> <20210204190507.26487-1-charvi077@gmail.com>
In-Reply-To: <20210204190507.26487-1-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 5 Feb 2021 02:30:06 -0500
Message-ID: <CAPig+cTj5erQ6GoikwU7aeJTH0+QCC2SqkSuZ_T=n0LVxf1pBQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8][Outreachy] rebase -i: add options to fixup command
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 4, 2021 at 2:05 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> Changes from v4 :
> (Thanks to Eric Sunshine, Christian Couder and Phillip Wood for suggestions
>  and reviews)

Thanks for working on this and re-rolling. Unfortunately, it seems
that v4 already landed in Junio's `next` branch which means that he
won't be replacing v4 wholesale as would have been the case if it was
still in the `seen` branch. Once patches are in `next`, improvements
are made by building changes atop them (incrementally) rather than
replacing them. Whether or not it makes sense for you to spend time
re-doing these patches as incremental changes is not clear. In fact...

> The major change in this version is to remove the working of `fixup -C`
> with amend! commit and will include in the another patch series, in order
> to avoid the confusion. So there are following changes :
> * removed the patch (rebase -i : teach --autosquash to work with amend!)
> * updated the test script (t3437-*.sh), changed the test setup and removed
>   two tests.
>
>   Earlier every test includes the commit message having subject starting
>   with amend! So, now it includes a setup of different branch for testing
>   fixup with options and also updated all the tests.
>   Removed the test - "skip fixup -C removes amend! from message" and also
>   "sequence of fixup, fixup -C & squash --signoff works" as I think it would
>   be better to test this also in the branch with amend! commit with different
>   author. (Will add these tests with amend! commit implementation)

Despite these being nice cleanups to the standalone series, I'm not
sure it's worth spending your time creating new patches to undo these
from `next`. Removing them only to add them back later is not
necessarily going to help "unconfuse" someone reading the commits in
the permanent project history.

> * changed the flag type from enum todo_item_flags to unsigned
> * Replaced fixup_-* with fixup-* in lib-rebase.sh
> * fixup a small nit in Documentation

These changes are still worthwhile and can easily be done
incrementally atop what is already in next, I would think.

Anyhow, use your best judgment to decide how much work to devote to this.
