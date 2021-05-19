Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F7DC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64071611AE
	for <git@archiver.kernel.org>; Wed, 19 May 2021 22:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhESWif (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 18:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhESWif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 18:38:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48507C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:37:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x188so10919326pfd.7
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5VZyujCMnl20rHz0rWHDfa/BebVrHuhRX0+UdWA3bwc=;
        b=liS4dYrHOYC1pZ8cgJzUSDBzPUQSgbQWvJ/ntYw7wOTPSz8xOQd2dn8E7Km5mwyDZR
         9w/H0SDbgPoOnGxZ1siiiU6oGO4PBnctwP/fzzHCBmNWPPmJdZYXouL7qTUrR29sXGI7
         lvHaHAX6wIOU6BnwASfcrnvqmnNv3qXBQOD3MC36WMd78/SMeL8vpJaDcV6n62PY6sPf
         1AhTlCZFgmsUP4q7xCBbTUCIzSy4v2VlGrGihUZANCS4ydUNfzpwmDjcLdRrwO5TNVyM
         wTvLa61NAl+iHnircXBhtPH8R0gZ583zmLiG3q8h+OAfJ5bp7WqRotMVDTiXbYHrah4e
         PzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5VZyujCMnl20rHz0rWHDfa/BebVrHuhRX0+UdWA3bwc=;
        b=G10roybpsxRzexWSQ4Uh5GBgRDQhQ/xHEWW+f8a8UeH/22egDzYfb43h1xVz2pJYGA
         VYhnOS8cUR7E5moNakC390osal2scIvUNB4sdxLm9KneQGBcXQ5eTVMtsZUaoH5pL48I
         sVnxYU551zeiF6Y0gbkRJKkbFLFIeOf5bahI8QqO3ONrk97hCEsMw7fZ1J1XcpZJA6tM
         bHORy1BxK8biRH0nK22M3c2uydRPdRvlMy4aKLlxs0LNeX4ZO5ypt1CJJZf4MQMPG8SY
         ZtT6WYptfEjZcJBSiZ61AyDXySOVlSqEJ/y+Flh0YgomwQZQhE6fRSvQpiBt+YQi+NXe
         7Gbg==
X-Gm-Message-State: AOAM530LCJXqjmtz2R9FRrO1Ogw9Lw1c7ruU9uQedAVNPTz5URUkKsBM
        F9qwLfXHd8J80Z62aIU0UjY=
X-Google-Smtp-Source: ABdhPJzxdjvto4hHesuaH240XClwTwSjRIHyOSMbR5GFvpfzrZHN88fss5ZKzOHIz+EbVKa9h419yw==
X-Received: by 2002:a63:d80f:: with SMTP id b15mr1390294pgh.388.1621463834832;
        Wed, 19 May 2021 15:37:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4edd:d685:2ff9:b567])
        by smtp.gmail.com with ESMTPSA id y66sm315017pgb.14.2021.05.19.15.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 15:37:14 -0700 (PDT)
Date:   Wed, 19 May 2021 15:37:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org
Subject: Re: Standardized escaping to store a .git in git?
Message-ID: <YKWTGMw3nShH9VKt@google.com>
References: <YKV8hEAxIzolnROX@localhost>
 <YKWDlF59jWoyE+xJ@google.com>
 <YKWMbh/j1ZiMZiGs@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKWMbh/j1ZiMZiGs@localhost>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Josh Triplett wrote:

> Part of my motivation, here, is that I'm looking to implement one such
> escaping mechanism (in a tool built atop libgit2 that needs to handle
> and version arbitrary files), and rather than inventing something
> bespoke I'd love to interoperate. And since I've seen various approaches
> used in the wild, I didn't want to add Yet Another distinct approach
> before starting a design conversation about it.

*nod* To be clear, I'm glad you brought it up, among other reasons
because it means this discussion becomes available in the list archive
for when people are wondering about the same thing in the future.

> On Wed, May 19, 2021 at 02:31:00PM -0700, Jonathan Nieder wrote:

>> Instead, I recommend doing one of the following, in order from most to
>> least preferred:
[...]
> For the test-case approach, these are potentially workable, though they
> only work if you just need a git repo with a given set of semantics,
> rather than a binary-identical test case.

For cases wanting something binary-indentical, it still seems
preferable to check in the individual relevant binary file (e.g., an
index file or a packfile) instead of a full repository.  In addition
to the safety improvement involved, this makes the test case easier to
understand.

> For the storing-arbitrary-files case, these wouldn't apply.

Can you say a little more about the storing-arbitrary-files case?

For example, 'bup' is a tool built on top of Git formats that stores
arbitrary files without using Git tree objects for it.  'etckeeper' is
another tool that stores additional information that Git does not (such
as detailed filesystem permissions).

If you have a use case in common with other tools, then finding a way
to interoperate sounds great. :)  The best way to do that is likely to
depend on the details of what the family of tools want to do.

There are some other filenames that "git fsck" also forbids, so this
comes down to more than figuring out how to handle ".git".

Thanks,
Jonathan
