Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID,URI_HEX shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD0C1F600
	for <e@80x24.org>; Wed, 19 Jul 2017 10:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754445AbdGSKQG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 06:16:06 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33207 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbdGSKQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 06:16:04 -0400
Received: by mail-wr0-f181.google.com with SMTP id v105so26568700wrb.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=53X/IHBsahy8YoGxL+5FDnkj6SPN58ir2vj1myAi4w0=;
        b=K6j/xCgL4KDnhcfrxHwppISbjZF8buG+tF9716r8AqA9XlzOTYM8hfr2YdXPOzmUeU
         iqz6VsyrQE0yyOIHkUtuxWij1e9kViRsnnErKDdUyGa3TwnppAXlIdL59BxjPFzgdrmA
         3/0GpbqhrT4Tl7LepZCkFxLGnRj71Y3Q+aOBfV4KxPYR+nD9TJ2UcDEx4rmXMqHmt/OZ
         18T2pA9nFb7bJ/PDIAaYGbtmCLL1l3LtS5n6Tx7RdlZyyAFKcpy7p8wcfOJDpcsRqM4d
         ReJtE5M585JCquy0Nq3LLlbh5G9uP6jBPW1xc8HvvFlcYve1RlMkvUDqRW1pjmFk1TEs
         xSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=53X/IHBsahy8YoGxL+5FDnkj6SPN58ir2vj1myAi4w0=;
        b=qjOLhkouVMSjx/3Mh56yNZy+KnAi/40G1sNEc30vda2L66QgO5MK+eV0eKq1DSMi4e
         JeuvmGkBvzVSKZeWRI5BweS/9h33sCM29yNy2VOxKjMY0rjrqFCrs+HDP8CAIiKddI33
         P8+NDjdZxyIHryOeV9jXvfWf9XmFe5gN1n606lhXGtQO0S6PdFeeUnFcfzCx3IzMkdx4
         sb+Ft9KRjqLmswbHBMmlmO2CSfR4To0/JKTl17vcEqObhkVCNRFTA2WxHPlapNs+Xe8E
         MNlR1CGPkXts9U2IbyEcYdxDJy9adB/5F4LYK57kgALoM7iLxe9m3Zn/ZLEHcGK+EugW
         uG/A==
X-Gm-Message-State: AIVw112pJa1LqOpIEtVZ9oP13F2eMrL5AtY5Y2//xzecaqL0J4bpDLew
        3j892fZWUprZV+0z6ySC+BfWKXAULjVWWPg=
X-Received: by 10.223.151.155 with SMTP id s27mr3734178wrb.159.1500459362771;
 Wed, 19 Jul 2017 03:16:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.174.83 with HTTP; Wed, 19 Jul 2017 03:16:02 -0700 (PDT)
From:   Jan Keromnes <janx@linux.com>
Date:   Wed, 19 Jul 2017 12:16:02 +0200
X-Google-Sender-Auth: p_lEEYUuUo7rV5hB5ajj6dXZR3k
Message-ID: <CAA6PgK74CTT09RZiQWGoih3x6B5G4tLa_Vz7e9BDNW4+TGdLXw@mail.gmail.com>
Subject: `make profile-fast` fails with "error: No $GIT_PERF_REPO defined, and
 your build directory is not a repo"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm trying to build a profile-optimized Git. I used to do this with
the following commands:

    mkdir /tmp/git
    cd /tmp/git
    curl https://www.kernel.org/pub/software/scm/git/git-2.13.3.tar.xz | tar xJ
    cd git-2.13.3
    make prefix=/usr profile man -j18
    sudo make prefix=/usr PROFILE=BUILD install install-man -j18

This worked fine. However, on some machines, the build takes more than
8 hours, so I'd like to use "profile-fast" instead of "profile":

    [...]
    make prefix=/usr profile-fast man -j18
    [...]

But this fails with the following error:

    ./run
    === Running 20 tests in this tree ===
    error: No $GIT_PERF_REPO defined, and your build directory is not a repo
    error: No $GIT_PERF_REPO defined, and your build directory is not a repo
    [...]
    error: No $GIT_PERF_REPO defined, and your build directory is not a repo
    cannot open test-results/p0000-perf-lib-sanity.subtests: No such
file or directory at ./aggregate.perl line 78.
    make[2]: *** [perf] Error 2
    Makefile:7: recipe for target 'perf' failed
    make[2]: Leaving directory '/tmp/git/git-2.13.3/t/perf'
    Makefile:2325: recipe for target 'perf' failed
    make[1]: *** [perf] Error 2
    make[1]: Leaving directory '/tmp/git/git-2.13.3'
    Makefile:1719: recipe for target 'profile-fast' failed
    make: *** [profile-fast] Error 2

The following thread gives me the impression that a similar problem
was already fixed for `make profile`:

http://git.661346.n2.nabble.com/make-profile-issue-on-Git-2-1-0-td7616964.html

Is it possible that the above commit fixed `make profile`, but not
`make profile-fast`?

Or, is there a good way for me to work around this issue?

Many thanks,
Jan Keromnes
