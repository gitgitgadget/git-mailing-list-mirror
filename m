Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC26C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 23:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E8E20637
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 23:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paultarjan-com.20150623.gappssmtp.com header.i=@paultarjan-com.20150623.gappssmtp.com header.b="mYpa/tp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCMXwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:52:44 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46756 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgCMXwo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 19:52:44 -0400
Received: by mail-oi1-f180.google.com with SMTP id a22so11317387oid.13
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 16:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paultarjan-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=1GCmKb1ByYxO3IdnWb/NRyo4TpAwYOr6NS18AH2vHyM=;
        b=mYpa/tp+BwWxR1u9TTPd+8SbtFO9xmbq2XHsXmpn7ZKxbg5zRpigpYqcsE4SCGSg1q
         SBAU1m7T2OZoX1uMYh52YS2yWyXA687qSiUQp83Ojscuty9tDKWvtTjfzShvaHJDhZM6
         8xZM+z0zSgr/TXoUFWv6zWV9absgphflwn8eTprNHGlnQLLehhA/navuGPTqPh1RFl3l
         +DOVyNvgEETk+LB3pKeotfcjwGEa4ZdBAoxpqdU7fEQJgTOiWebJQZyyAXYzzcPad/r7
         X5/xlgu/6rrcQjF/JTTa2/35b41QhgOTnJw0/H79qiC78we1sjIDhr20S6IOsXGfc9R1
         oZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1GCmKb1ByYxO3IdnWb/NRyo4TpAwYOr6NS18AH2vHyM=;
        b=tQNzQR0IaTDELXGEXQYRRa5SOXKnlRFNXbXV9dgCFgva0yDRXq0bk61Oml/qozE+KY
         sS3uXZAAvdnFAfG+PCD2/DN9FJkKzaGXsiStgILUzYqe64ZJnqDYqRlsc2DFMBlg3RGv
         qAnJdhCOkv1Wzh8OMDBMbcBV5eBfL3Pwz6II3n9jet3W2iesPGL35cLd57SfYlBHO7mN
         DCs+5DMt9goxLef/2ZNX9QmPx5U2Ca0P5xkcKivjVhzQDMZGXE/YjWqxV7eNsRKjOkTR
         pkFriINDrG52L9Tu1QFzhhnyJpwdMeNTumHWeiIFqig6mpthANXqmyBx9MhukDyggCOq
         1hOw==
X-Gm-Message-State: ANhLgQ0uYjzEmNZmCGVLub+wrV4MskQXzgGYXIE1FYa8vFc5XeKaINIO
        30R8uSgbyMsykZVf6zHklDvXwhs4ygyrq3pjvJPovxorZYE=
X-Google-Smtp-Source: ADFU+vv0/uhE/2fJkr/TurEXQ8yv/iQ6btMPhFx4PwxNEuJ3VvhT6xzwQF797NKB9j/1tyKQNv/umQnBZBWiP+poa9w=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr9389701oiy.110.1584143562981;
 Fri, 13 Mar 2020 16:52:42 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Tarjan <paul@paultarjan.com>
Date:   Fri, 13 Mar 2020 16:52:32 -0700
Message-ID: <CALvWuB5RCe56qSNehaU0mWajtvQ9jMEa+5kTYF_VY+-3wMASEA@mail.gmail.com>
Subject: Git performance on large repository on OS X is slow without core.preloadindex=false
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git folks,

I'm working on a git repo for my company and noticed that `git status`
performance was an order of magnitude slower on OS X than on Linux.

tl;dr; Do you know why by default `git status` is trying to `lstat`
every file in the repo on OS X but not on Linux? And is that config
option I found of `core.preloadindex=false` the correct suggestion for
using git on OS X?

Some background:
```
$ git --version
git version 2.25.1
```
```
$ sw_vers
ProductName: Mac OS X
ProductVersion: 10.15.3
BuildVersion: 19D76
```
```
$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description: Ubuntu 18.04.4 LTS
Release: 18.04
Codename: bionic
```

Here is the initial problem:

On OS X:
```
$ GIT_TRACE_PERFORMANCE=true git status
14:07:25.251118 read-cache.c:2306       performance: 0.020316000 s:
read cache .git/index
14:07:29.149814 preload-index.c:147     performance: 3.897873000 s:
preload index
14:07:29.152372 read-cache.c:1621       performance: 3.900433000 s:
refresh index
14:07:29.163628 diff-lib.c:251          performance: 0.010868000 s:  diff-files
14:07:29.165150 unpack-trees.c:1592     performance: 0.000125000 s:
traverse_trees
14:07:29.165833 unpack-trees.c:447      performance: 0.000024000 s:
check_updates
14:07:29.165849 unpack-trees.c:1691     performance: 0.001543000 s:
unpack_trees
14:07:29.165854 diff-lib.c:537          performance: 0.001620000 s:  diff-index
14:07:29.178017 name-hash.c:600         performance: 0.011799000 s:
initialize name hash
14:07:29.778714 dir.c:2606              performance: 0.612725000 s:
read directory
On branch master
Your branch is up to date with 'origin/master'.
nothing to commit, working tree clean
14:07:29.779696 trace.c:475             performance: 4.549920000 s:
git command: git status
```

Linux:
```
$ GIT_TRACE_PERFORMANCE=true git status
17:07:22.665901 read-cache.c:1914       performance: 0.016203489 s:
read cache .git/index
17:07:22.736241 preload-index.c:112     performance: 0.070269440 s:
preload index
17:07:22.739459 read-cache.c:1472       performance: 0.003190579 s:
refresh index
17:07:22.742891 diff-lib.c:250          performance: 0.003279925 s: diff-files
17:07:22.744175 diff-lib.c:527          performance: 0.001076360 s: diff-index
17:07:22.755865 name-hash.c:605         performance: 0.011539610 s:
initialize name hash
17:07:22.996122 dir.c:2303              performance: 0.251910028 s:
read directory
On branch master
Your branch is up to date with 'origin/master'.
nothing to commit, working tree clean
17:07:22.997366 trace.c:420             performance: 0.347834763 s:
git command: git status
```

But after I run:
```
$ git config --bool core.preloadindex false
```

I now get this on OS X:
```
$ GIT_TRACE_PERFORMANCE=true git status
16:40:29.487593 read-cache.c:2306       performance: 0.022781000 s:
read cache .git/index
16:40:29.853585 read-cache.c:1621       performance: 0.365122000 s:
refresh index
16:40:29.857934 diff-lib.c:251          performance: 0.003896000 s:  diff-files
16:40:29.859338 unpack-trees.c:1592     performance: 0.000088000 s:
traverse_trees
16:40:29.859982 unpack-trees.c:447      performance: 0.000026000 s:
check_updates
16:40:29.859994 unpack-trees.c:1691     performance: 0.001466000 s:
unpack_trees
16:40:29.859999 diff-lib.c:537          performance: 0.001523000 s:  diff-index
16:40:29.870882 name-hash.c:600         performance: 0.010529000 s:
initialize name hash
16:40:30.525238 dir.c:2606              performance: 0.665120000 s:
read directory
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
16:40:30.526289 trace.c:475             performance: 1.062404000 s:
git command: git status
```

I traced it down to on Linux we are only making ~700 lstat syscals but
on OS X we're making 100k.

OS X (using lldb with a breakpoint on lstat64):
```
(lldb) break list
Current breakpoints:
1: name = 'lstat64', locations = 1, resolved = 1, hit count = 103859
Options: ignore: 953389 enabled
  1.1: where = libsystem_kernel.dylib`lstat$INODE64, address =
0x00007fff6a899be4, resolved, hit count = 103859```

Linux:
```
$ strace git status -uno 2>&1 | grep lstat | wc -l
726
```

The backtrace for these lstat calls seems to come from these two spots:
https://github.com/git/git/blob/30e9940356dc67959877f4b2417da33ebdefbb79/preload-index.c#L76
https://github.com/git/git/blob/30e9940356dc67959877f4b2417da33ebdefbb79/symlinks.c#L138

Thanks
Paul
