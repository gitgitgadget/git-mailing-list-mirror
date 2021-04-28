Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22F3C433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 12:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79FEF61185
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 12:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhD1MVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhD1MVC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 08:21:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092B3C061574
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 05:20:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d14so10115303edc.12
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 05:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sp4m.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g18Kp/cd1i10X6fJGfQuwG/ey+FZs0eRLk3+DSCHbKU=;
        b=fExtMyS9xocmZYpRjFlqpe8kSardv6uC5J8XqiEh29HBrjlXmR5qON+dGCH/wxrxtR
         b9dDknXdu4hZ+HAjWrj2mptNESQDPv0TAF43omHY/lsahEGnhPLi60+ly+LwnYN2ju2y
         X2yv3yZxb0Zxguk8H/Lxp9DRWVME361pe6MAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g18Kp/cd1i10X6fJGfQuwG/ey+FZs0eRLk3+DSCHbKU=;
        b=r+lVCMF3Ay77uORWU+J29oPXWMtAWRAeChHD6a2W7H5BmJLF+gYy6EvglX/aHlt/U0
         /IN7LgbCudIZ4t+pUhF9GjOMM/MPty0ARyxtSsNqNo9XxYVOy73bNI6rnakcojfiz960
         X9WCAeJSLEEmAsEeDLJ4yrfXPWLCDPGG6mM5AWQW2FLDjMvexETX+3RvbqkNBvLvzjjZ
         vRc9S1G7Hxq2RoT65WQKDx/YSDKAG49IK+yPVcGLBxK4cxJHRO/4akGJ67+ei6Rd3mxv
         sTAZLvcOLr5Cl9lFNyOV3AFSQ2WGuAOPm3PbRAkQDlothE7R1d05CyAsCb8GNvbJF1pm
         B/Vg==
X-Gm-Message-State: AOAM531E4GJYKJ9ewBS7oWufr779sdW0tqhnA9FrCzOv6S9SIw+8KrkM
        0t+ShmxjzfoD/ucL8nXyIY1yfqqSoazx1ltXJOa67AtMWurIcGda
X-Google-Smtp-Source: ABdhPJy93i8mfN9Pk9zeA2wnQh7u6I4O7PY0xQJqlTvHJcMjO6Ev6XRuH+6hIAdo/vs9zsFOMQIGd7hcOOfezOW7Zbs=
X-Received: by 2002:aa7:c952:: with SMTP id h18mr10988020edt.269.1619612414614;
 Wed, 28 Apr 2021 05:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-dYSOVx0egnyxJb6ZjgWvEDR=19QPgc70JQ7cXUjUPZ1XDiQ@mail.gmail.com>
 <YIgxPtDmr9sYj0ft@coredump.intra.peff.net>
In-Reply-To: <YIgxPtDmr9sYj0ft@coredump.intra.peff.net>
From:   David Emett <dave@sp4m.net>
Date:   Wed, 28 Apr 2021 13:20:03 +0100
Message-ID: <CAJ-dYSOHEfRq3p_MQMJoHf5PjwQtbJOzJ9Dzxrfe+BDkov7Q8w@mail.gmail.com>
Subject: Re: [PATCH] prune: save reachable-from-recent objects with bitmaps
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Here's a fix. Thanks very much for reporting.

Thanks for the quick response! I tried the fix out on the repo I was having
trouble with. It's hitting a segfault in traverse_commit_list in the
mark_recent block. It looks like the issue is that the bitmap code leaves
revs->include_check set, with revs->include_check_data pointing at the stack.
Setting revs->include_check to NULL after the traverse_commit_list call in
find_objects in pack-bitmap.c fixes the segfault for me. And the original issue
appears to be resolved as well, so thanks!

> I was a little surprised you saw this with "git gc", as when I tried
> testing with that, I found that the "git repack" run before "git prune"
> works around the bug (see the discussion of t6501 below). But I think
> perhaps it is just that "gc --auto" is more willing to do a "repack -d"
> sometimes, rather than a full "repack -A". At any rate, I was able to
> easily reproduce it for the tests with just git-prune.

I can't say for sure that this bug is what I was seeing originally, however it
does seem quite likely -- the commits that hit issues were minor updates of
commits that had been fetched a month or so earlier, and so would certainly fit
the bill. Like you though I've just been reproducing with git prune.
