Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D351FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 15:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936640AbdAFPwX (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 10:52:23 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46688 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933794AbdAFPwV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 10:52:21 -0500
X-AuditID: 1207440c-e53ff700000009a1-7e-586fbd326c40
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.8E.02465.23DBF685; Fri,  6 Jan 2017 10:52:19 -0500 (EST)
Received: from [192.168.69.190] (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06FqGwL021661
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 6 Jan 2017 10:52:17 -0500
To:     git discussion list <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Subject: [ANNOUNCE] git-test: run automated tests against a range of Git
 commits
Message-ID: <1341c01a-aca7-699c-c53a-28d048614bfe@alum.mit.edu>
Date:   Fri, 6 Jan 2017 16:52:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqGu8Nz/C4NUnK4uuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGVs+trNWNAlXLFiYQtLA+N1vi5GTg4JAROJB9vnMnYxcnEICVxm
        lFjbuRPKecEksfvJDUaQKhEBXYldz66ygdhsQPainmYmEFtYIEiic9IPsDivgL3E+aZv7CA2
        i4CKxPkX7WA1ogIhEpfnHIWqEZQ4OfMJC4jNLKAu8WfeJWYIW16ieets5gmMPLOQlM1CUjYL
        SdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqGermZJXqpKaWbGCFBw7OD8ds6mUOMAhyM
        Sjy8EV55EUKsiWXFlbmHGCU5mJREecMc8yOE+JLyUyozEosz4otKc1KLDzFKcDArifBe3wGU
        401JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8P7cDdQoWJSanlqRlplT
        gpBm4uAEGc4DNFwApIa3uCAxtzgzHSJ/ilFRSpx3FkhCACSRUZoH1wuL6leM4kCvCPMy7AGq
        4gEmBLjuV0CDmYAGC3qCDS5JREhJNTAytfC8dV+v/ISnWOFXI0tO77J1aZy/Tkdw7du9bz+7
        6DK1s1LVsetcbJzfhM+68ytO+W6ewaZbbif//yj4u/j/ppXXRBZ36WZb71+gL8EeqM7BPjG9
        0KhxyszdAb1PEttTo26/0Jse7lzJn3uI4esLOT1V9n6jzqxzhh9nX/pzjKVNqeVqZaASS3FG
        oqEWc1FxIgAI0zbLxQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just released ﻿⁠⁠⁠⁠`git test﻿⁠⁠⁠⁠`, a script for running automated
tests across a range of Git commits and keeping track of the results in
git notes:

    https://github.com/mhagger/git-test

This is a script that I've been using in one form or another for years
and I find it really handy [1].

`git-test` is meant for people who want *all* of their commits (not just
the branch tip) to pass their automated tests.

Tl;dr: How to use `git test`

1.  Define the test you want to run. The string can be any shell
    command:

        git test add "make -j8 && make -j16 test"

2.  Create a separate linked worktree in which to run your tests:

        git worktree add --detach ../test HEAD

3.  Create a terminal window and `cd` to the directory containing
    the testing worktree, and run the test against all of the commits
    on your branch:

        cd ../test
        git test range master..mybranch

    If any of the commits are broken, `git tree` will display the
    error then stop with that commit checked out.

4.  As you work, whenever you want to test new commits, go to the
    testing terminal window and run the same command again:

        git test range master..mybranch

    `git test` is smart enough to remember which commits (actually,
    trees) have already been tested and only run the test against
    commits that have been changed or added. And since the tests are
    run in a different worktree, you can continue working in your
    main working directory while the tests run.

It is also possible to define more than one test suite in a given
repository, retry tests, etc. Type `git test help` or read the `README`
file [2] for more information.

`git test` stores the test results in git notes (under
`refs/notes/test/<name>`), linked to the commit's tree SHA-1. This means
that test results remain valid even across some kinds of commit
rewriting, like changes to commit metadata or squashing adjacent
commits, and a subset of results even remains valid if a commit is split
or if some commits earlier in a patch series are reordered.

I don't plan to turn this into a gigantic project or anything, but I
find this script really useful so I wanted to put it out in the world.
Feedback and/or pull requests welcome!

Michael

[1] The name sucks, I know :-/
[2] https://github.com/mhagger/git-test/blob/master/README.md

