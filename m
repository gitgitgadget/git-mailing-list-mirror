Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB95C432C3
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 08:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC4121781
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 08:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oagpdfe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfK2IVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:21:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45268 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfK2IVw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 03:21:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id z4so14276280pfn.12
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 00:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=finjopdWbqv++6Dm5UFSMMnnuOLbJNvVcTo04R30qq8=;
        b=oagpdfe3P8wad3JKvScfBbZWK+oo49oCVM+Ox/rY/2+Dyctez02hVmnHW0r8VZXQvq
         O68LXcGkj4tEmp6pdRLfct/lWTxAPY0fB3s01ye3VkI8iqsZLK936FHdJwkdNcMkVb49
         1avF7xcEzJKNpi0eJ6m7LiTSiHZQIPep1XzytPoMsEkGCcz7i0qBjLW6w/D0E2qzXq69
         s6S60eUFei3LGeGf8Z5BhsQuvOUhsAsctTw6odMOWgfcyyVw3z7gJjHkDqKa9VkuypMm
         IoCIC09L9663otzEXQmW+dF3urlCmkAFurbLWRJg+J3PGHsYUpPlSp3RLGPVyCiWCZxT
         jxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=finjopdWbqv++6Dm5UFSMMnnuOLbJNvVcTo04R30qq8=;
        b=Imh6v2VmFW2a2mWnWF/4Pj07D9M2RzQm7XvWcQXHvd+FVuoDDrbASJVONMmcUYNsV/
         3Qm1vLQkKOiz6a7zm9hCjzJXU7zXWbZQMhVvQKWsNFpsUWTgQLqZ7d8NyWBb6UzxQE3D
         0WH6vPcrww/KCCa/aL82/rII5eA+iSPjJDIhOk/c8jVrvOHnkAv6U6PtmukFBcJxsnYO
         mLaXcfzpT4F3/aylHzgf6etYJPhRKLGr5tPUjuwgsSBdPcOBTC/FQbfM9DZlqz4XzIR6
         m+r+z7GEaLa1gTYtuDe3Uex9+UKANrHTbjWm6tm+eVbemhAz5HEho1ZzkeMhhvkCs4wm
         mLvw==
X-Gm-Message-State: APjAAAU5aTKaJy5UHA2GO7r5doZzLk7wMB7DyOg5PTPH5tJNMWzfVXMf
        XAoVoZqKYF7d4OwLa2lPUR4z5+4sTznadUJN2S+Ihc+9hUY=
X-Google-Smtp-Source: APXvYqys4+uw0bT4SJHFDvFHjzkoxTXcW435vriGf+VEYzPpO3ot5iHrzESj2rg5mMTuPWHhznbQuf9YAVqzcY+vPiQ=
X-Received: by 2002:a63:4a50:: with SMTP id j16mr15905233pgl.308.1575015711467;
 Fri, 29 Nov 2019 00:21:51 -0800 (PST)
MIME-Version: 1.0
From:   Pavel Roskin <plroskin@gmail.com>
Date:   Fri, 29 Nov 2019 00:21:40 -0800
Message-ID: <CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com>
Subject: git-rebase produces incorrect output
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I've discovered an issue with "git rebase" producing a subtly
incorrect file. In fact, that files even compiled but failed in unit
tests! That's so scary that I'm going to stop using "git rebase" for
now. Fortunately, "git rebase --merge" is working correctly, so I'll
use it. Too bad there is no option to use "--merge" by default.

The issue was observed in git 2.23 and reproduced in today's next
branch (2.24.0.449.g4c06f74957) on up-to-date Fedora 31 x86_64.

I've created a repository that demonstrates the issue:
https://github.com/proski/git-rebase-demo

The branch names should be self-explanatory. "master" is the base,
"branch1" and "branch2" contain one change each. If "branch1" is
rebased on top of "branch2", the result is incorrect, saved in the
"rebase-bad" branch. If "git rebase -m" is used, the result is
correct, saved in the "merge-good" branch.

The files in "rebase-bad" and "merge-good" have exactly the same lines
but in a different order. Yet the changes on branch1 and branch2
affect non-overlapping parts of the file. There should be no doubt how
the merged code should look like.

I believe the change on branch2 shifts the lines, so that the first
change from branch1 is applies to a place below the intended location,
and then git goes back to an earlier line to apply the next hunk. I
can imagine that it would do the right thing in case of swapped blocks
of code. Yet I have a real life example where it does a very wrong
thing.

Indeed, "git diff origin/branch2 origin/rebase-bad" and "git diff
origin/branch2 origin/merge-good" both produce diffs of 9957 bytes
long, different only in the order of the hunks.

Another interesting data point - "git rebase --interactive" is working
correctly.

-- 
Regards,
Pavel Roskin
