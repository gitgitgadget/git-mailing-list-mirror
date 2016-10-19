Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D977D2098B
	for <e@80x24.org>; Wed, 19 Oct 2016 15:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944585AbcJSPSy (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 11:18:54 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35075 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944131AbcJSPSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 11:18:51 -0400
Received: by mail-qk0-f181.google.com with SMTP id z190so40954113qkc.2
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=9JfZ1w6hvbDrjjLTijhvmIG5NhQB94nQaocwF+OKUiA=;
        b=Wg7wbpHBWEJ6bml8p03QVGcuwm5XlaTsQdYNsz3Ho4PfVIy829JSYc7STKlDz/ydYe
         bpd+870DI2lBr3TBJq5YKRr6/9tWjyIN0EyieoAx+aRG2TWPaOkl3ImQm1rHTf+y3FWX
         7rOMEy1R63I6HgV7qizs6s35k57+b5QdPfROFCZx32pw9v4pvw6Gp2HWl9MUhKLTQinA
         UUxaeS9XedkxGv9hblIv9DW0W6zt2WfRcnBP+0mZRbhxAvvGEBQCACgJGQiXqWDOe4Q0
         5qr1bL8HJnIEx9FVP7hrnz3YeGwnycABifbMNrQ6D+BplYoVp53WX9QS49qtYtrxt9rc
         EWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=9JfZ1w6hvbDrjjLTijhvmIG5NhQB94nQaocwF+OKUiA=;
        b=Lgcm0zI2XweCM9S8zObAQyv8f4S6ifcImpBYgD+0YsZ3OG6AzYCjsvM1Yvr6I7A2Wt
         9frttREqL1YNXPngDejrOlZVPfGHQwkkLjVTtSTOjI72Z7AHDNP/jvsTSyNcU5LJjNkg
         qhUIFTihzfZ6PnfYp2j8Y4JimT7qMNwIkCR1bTXRBRlbvdGA62SSr+JoWKw3OqqcijtS
         UdiqPFRFH0j2VpDL+EQQ+6S9ky47Z+0MqJyKvVH6arDHypQF8Y3gfqufrEcbsdNcQrNm
         /dv98qMqmkXQtyX8UNsukquEIE7QS6oW8vJEI4ACElHzNB0/7/rZeemR8wR3ItQlqf8W
         mPMA==
X-Gm-Message-State: AA6/9Rld6qCBv5C9+PslBhfMTPXrgjXOexN+XSB9cbC7/jIDX8nWbxAV8RhqcZG+wyAgeEIWZL/+IMH12tYDbw==
X-Received: by 10.194.179.170 with SMTP id dh10mr4775413wjc.94.1476875757492;
 Wed, 19 Oct 2016 04:15:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.210.210 with HTTP; Wed, 19 Oct 2016 04:15:56 -0700 (PDT)
From:   Jan Keromnes <janx@linux.com>
Date:   Wed, 19 Oct 2016 13:15:56 +0200
X-Google-Sender-Auth: ANrEEdzUAN6GnQ4sp-yia8TMnQ0
Message-ID: <CAA6PgK5vtnZSqqZafMVGoy0Rv38=8e__uQvXaf2SyPePHuPjJA@mail.gmail.com>
Subject: [regression] `make profile-install` fails in 2.10.1
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

TL;DR - Probably a regression of a previously reported bug. [0]

I'm trying to `profile-install` Git from source on Ubuntu 16.04, to
have the latest stable Git optimized for my machine.

However, this often fails, because the profile build runs all Git
tests (to get an idea of how Git behaves on my hardware, and optimize
for it), but it bails out if there are any test failures (for me, this
has happened on most Git version upgrades this year, see also [0] and
[1]).

- Problem: Is there a way to `make profile-install` but ignore
occasional test failures, as these are not critical to get a useful
hardware profile? (Note: In a previous thread, Dennis Kaarsemaker
mentioned this is fixing a symptom, not the root cause, but it would
still be great to get a working profile in spite of occasional test
failures.)

- Related problem: `t3700-add.sh` fails again in 2.10.1 for me. More
details below, and I can provide further debug information if you
don't already know the problem.

Thanks,
Jan

[0] "`make profile-install` fails in 2.9.3" -
https://marc.info/?l=git&m=147274608823171&w=2

[1] "Fwd: Git 2.8.1 fails test 32 of t7300-clean.sh, breaks profile
build" - https://marc.info/?l=git&m=146193443529229&w=2

---

Steps to reproduce:

    curl https://www.kernel.org/pub/software/scm/git/git-2.10.1.tar.xz
| tar xJ \
     && cd git-2.10.1 \
     && make prefix=/usr profile-install install-man -j18

Expected result:

    - runs all tests to get a profile (ignoring occasional failures)
    - rebuilds Git with the profile
    - installs Git

Actual result:

    - runs all tests to get a profile
    - at least one test fails, interrupting the whole process
    - Git is not installed

Failure log:

    (snip)
    *** t3700-add.sh ***
    ok 1 - Test of git add
    ok 2 - Post-check that foo is in the index
    ok 3 - Test that "git add -- -q" works
    ok 4 - git add: Test that executable bit is not used if core.filemode=0
    ok 5 - git add: filemode=0 should not get confused by symlink
    (snip)
    ok 38 - git add --chmod=[+-]x stages correctly
    ok 39 - git add --chmod=+x with symlinks
    not ok 40 - git add --chmod=[+-]x changes index with already added file
    #
    #               echo foo >foo3 &&
    #               git add foo3 &&
    #               git add --chmod=+x foo3 &&
    #               test_mode_in_index 100755 foo3 &&
    #               echo foo >xfoo3 &&
    #               chmod 755 xfoo3 &&
    #               git add xfoo3 &&
    #               git add --chmod=-x xfoo3 &&
    #               test_mode_in_index 100644 xfoo3
    #
    ok 41 - git add --chmod=[+-]x does not change the working tree
    ok 42 - no file status change if no pathspec is given
    ok 43 - no file status change if no pathspec is given in subdir
    ok 44 - all statuses changed in folder if . is given
    # failed 1 among 44 test(s)
    1..44
    Makefile:43: recipe for target 't3700-add.sh' failed
    make[3]: Leaving directory '/tmp/git/git-2.10.1/t'
    make[3]: *** [t3700-add.sh] Error 1
    Makefile:36: recipe for target 'test' failed
    make[2]: Leaving directory '/tmp/git/git-2.10.1/t'
    make[2]: *** [test] Error 2
    Makefile:2273: recipe for target 'test' failed
    make[1]: *** [test] Error 2
    make[1]: Leaving directory '/tmp/git/git-2.10.1'
    Makefile:1679: recipe for target 'profile' failed
    make: *** [profile] Error 2
    The command '/bin/sh -c mkdir /tmp/git  && cd /tmp/git  && curl
https://www.kernel.org/pub/software/scm/git/git-2.10.1.tar.xz | tar xJ
 && cd git-2.10.1  && make prefix=/usr profile-install install-man
-j18  && rm -rf /tmp/git' returned a non-zero code: 2
