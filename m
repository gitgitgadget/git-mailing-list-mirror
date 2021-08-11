Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6D4C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 14:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13E560FC3
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 14:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhHKO7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhHKO7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 10:59:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A3C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 07:59:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e15so3043639plh.8
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4nCwLgMT3HvlmsYjw4EpW3hgPVJlUXwE92HgDfJbE8U=;
        b=ULRBImkR9PHyBQKc5a7fIt5gLPCco3qURLW1pPo4tXWvPAkPyXo9tqj1M/DNf2nTrk
         xOXGDRPbCTU7R/qCVnxXuGfT7xDP5VYirKCVp61bAFCpZkI2rbUXc8di24iSs6hdCxec
         QXzmGvIarkN995nm9WJehwmxeCc3K+CPMIZ4A4e+l2Si022cBld6Q+MzSa9Aimg8o3aN
         XsmS2lu9IQ3bAHpCPieeAZQ7neH7r0XyCjbZYHVHASEJXgHvWaiRQX1pF/3lQaUnvcSB
         uDR2d4CxGtY0kJMS2QemNhnlKjqIbXwRV+kbhS2dGyowcBnaJV7x88v3T5I3B8ZofC1C
         fTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4nCwLgMT3HvlmsYjw4EpW3hgPVJlUXwE92HgDfJbE8U=;
        b=sRiO7TBqKGpk0LjBX1lrR0Uiqi2rkyIehKmRKjSRr7BFqFRuUxwK1OXHBh/YsKbcsj
         8txcQPCYyjSeLoMk1/R6VPHG2K7kyGwv0ZRrBwEilzaLCSn2Fi1NBL02bhXt9I4hNmm3
         rxuC3+75uwtDhWTEp9t6T8BgvSNJ6aiRB+FDA1WSSdh84CWaGgC+nEyuIebiwt1fKhr5
         w0Qc0D99f3GrULWgh2p3kJd8k42ErdvxetqOi+TxXLS9dUl+XYiJWCaYmJBeW8VnBByP
         pOgOpDBaCcWjIjY/8RyJNrrHWQBQ/GibDOn9nidyupVOKTfzxFtEDto+bU5aL9DTrzG3
         3UyQ==
X-Gm-Message-State: AOAM531u0FGvmJL62ehwmuJ6AbXgwzn4mH3qx25uyCrIg97bvkSx/10S
        oTj23gFepkApxPNYq1reLQAXCi/5M3aglnHKus9rUAokxwH3YA==
X-Google-Smtp-Source: ABdhPJy4cys8V36Rja5OL8XH7ORovyl0yDJyn5AfK1YLDACfKHTXgXj+qayVPmtNmqppLzFoo3hgucSn/L65jnacVjU=
X-Received: by 2002:a63:cc0e:: with SMTP id x14mr104512pgf.352.1628693953350;
 Wed, 11 Aug 2021 07:59:13 -0700 (PDT)
MIME-Version: 1.0
From:   Kevin Phillips <thefriendlycoder@gmail.com>
Date:   Wed, 11 Aug 2021 11:59:02 -0300
Message-ID: <CANNNLMC_XEqjYPOig+pbqrS30dPCTmcDSev6yg+5EEBkJCaaig@mail.gmail.com>
Subject: Bug with Git shallow clones and submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We recently came across a bug in one of our Git projects which make
use of submodules. The basic problem is we have a Git repo that has 1
submodule within it which is set up to check out a specific branch,
and when we attempt to perform a shallow clone on the parent repo the
checkout fails with a "Server does not allow request for unadvertised
object" error. After doing a lot of testing and reading online I found
this StackOverflow thread (https://stackoverflow.com/a/61492323) that
explains our problem in great detail, which indicates to me that this
is likely not a problem specific to us, so I thought I'd report it to
see if it could be fixed.

In our specific use case, we found the problem specifically when
running a build of our project using Gitlab CI. This tool
automatically performs a shallow checkout of projects being built by
using a "--depth=50" parameter. This caused odd Git checkout errors to
appear on our CI builds which weren't directly reproducible by our
developers local builds. Upon closer examination we were able to
reproduce outside of the CI environment by performing a checkout as
follows:

    git clone --recurse-submodules --depth=50  git@<path_to_repo>.git .

Based on my initial research, which was helped greatly by the
StackOverflow thread I linked to above, I was able to deduce the
following contributing factors:

The submodule that was causing us grief was the dpdk library located
here: http://git.dpdk.org/dpdk-stable/

This repository has a default branch named "default" which has only 2
commits on it: one for initializing the repo and one additional commit
All releases of this library are created from branches named by the
release version, and they all seem disjoint from one another, and they
are all disjoint from the default branch (ie: changes from the release
branches are never merged into the default branch)

our parent repo, which is an internal / non-public repository that can
not be shared, has a single submodule defined in it with the following
.gitmodule definition:


[submodule "dpdk-stable"]
path = dpdk-stable
url = https://git@dpdk.org/git/dpdk-stable
branch = 19.11

the specific revision we are checking out has the OID
78bc27846101e481438a98c68cac47e4476085c0 which corresponds to the
19.11.8 tag
the following git clone operation succeeds:

git clone --recurse-submodules git@<path_to_repo>.git .

the following git clone operation fails:

git clone --recurse-submodules --depth=50  git@<path_to_repo>.git .

we can work around the problem by doing a shallow clone with the
no-single-branch parameter, as in:

git clone --recurse-submodules --depth=50 --no-single-branch
git@<path_to_repo>.git .

Based on my current level of understanding, Git is automatically
setting the --single-branch flag when cloning submodules but only when
doing a shallow clone of the parent. This seems wrong to me. In
addition, even if Git was going to enforce the single branch option on
submodules it stands to reason that it should be respecting the branch
defined in the .gitmodules file (ie: 19.11 in our case) instead of
using the default branch (ie: "default" in this case). My guess is, if
it were respecting the branch name then we wouldn't be getting the
"unadvertised object" error because the referenced OID would exist in
the submodule checkout because it would have the correct branch
checked out.

For reference, this problem appears to be reproducible on several
different platforms (ie: several different Linux distros and Mac OSX
at least) and several different Git versions up to v2.32.0 which is
the latest version at the moment. Hopefully this problem can be fixed
in a future release of the command line tools. In the meantime we've
had to hack around the problem in our Gitlab CI builds by disabling
the shallow checkout features, which is less than ideal, so again I am
hopeful that this can be fixed directly in Git itself.

Kevin Phillips
Lead Developer, Configuration Management Team, IBM
