Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C35E1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfILWMs (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:12:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38863 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfILWMs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id d10so14189461pgo.5
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKy1QzKqn7UTmSEXU/Hl8e0ypzcYAsd19+wLdOw4f7E=;
        b=JXft9eZrKZpjmW12wLiuQC88dwbdYBAr/60zXxC8SRvCZJoEQveD/b4KewepuM7PSn
         s9P+xs+8kFWf6aGc1QWVYwfPF16eRXjtFco+t4lX56pIa6BjavyhDkJZ2nc/kJ4xtHbl
         t8NFffO/OBRqVRTUHT9ga05u1ggBjk+oBMth+6uTutuLKkYVJBmA4kgLOMG9Fl9rk9w+
         wYWeA2p+X1PSesTlZ0ib1pdd+sYJRyY2k+KWSZHw70vzDdqRyTNWJtKoLC01SmWl0h1w
         FSdq3bXdnz81vTLZ0crY62abLQxLmtpEwkWIlf8ufLgo/Y2j/7s4mgajT7WsH+4ELvcL
         tzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKy1QzKqn7UTmSEXU/Hl8e0ypzcYAsd19+wLdOw4f7E=;
        b=cP9UflFHDUbDR4UK9nrgbfCkicitF0kqv3sCS3xbt719jwXbxKyy8H//Ok9qOasoGx
         eGdypq7PWrzMZZkhKVTOb952cmoJCVmf6fRgH8XH0pr1M6TwMhxu/UewqgoRZMHYsJD5
         fwc1dp66a3NtPs3EWJLn1vw3XIecCrts7sL/75xv5CyJx1t45i8YybtRgjSCTa05XW0q
         EOqCwfgZS/ng2qjHxrYQZ3fnkdmXzk6TZccVyuKKn7oHCR/RmO33z3755FGUUbN76zD7
         181tN1m0xWm+XpHOForgMhu34wLHb/Qc9v+I5Wc7a6nNVt8BDl7f0t/hY99J2pzOxzYn
         ls+Q==
X-Gm-Message-State: APjAAAUhhfZoUNYKXIMiJAhHlYuhmFyzBaNyro0TFkxkP7wlyEzH5L4m
        hIMg7+PcKE9hmMIHXIXqDrQnw5Zxluc=
X-Google-Smtp-Source: APXvYqxIyJJY0AW2akMUxVPOoIHs9MJb40R+9y1wsfoitTOqi8V1vpxOltZT7RoP4jtM+hjV2IOOYA==
X-Received: by 2002:a65:51c5:: with SMTP id i5mr40074020pgq.312.1568326366506;
        Thu, 12 Sep 2019 15:12:46 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:45 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 00/12] Fix some git clean issues
Date:   Thu, 12 Sep 2019 15:12:28 -0700
Message-Id: <20190912221240.18057-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190905154735.29784-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: This series builds on sg/clean-nested-repo-with-ignored, as it
      (among other things) modifies his testcase from expect_failure
      to expect_success.  Also, Peff is probably the only one who
      remembers v1 (and even he may have forgotten it): v1 was posted
      a year and a half ago.

This patch series fixes a few issues with git-clean:
  * Failure to clean when multiple pathspecs are specified, reported both
    in April 2018[1] and again in May 2019[2].
  * Failure to preserve both tracked and untracked files within a nested
    Git repository reported a few weeks ago by SZEDER[3].

[1] https://public-inbox.org/git/20180405173446.32372-4-newren@gmail.com/
[2] https://public-inbox.org/git/20190531183651.10067-1-rafa.almas@gmail.com/
[3] https://public-inbox.org/git/20190825185918.3909-1-szeder.dev@gmail.com/

Changes since v2:
  * Removed the RFC label
  * Fixed up a few things SZEDER pointed out in v2 -- some commit
    message improvements, and an extra safety precaution for the
    final patch.

Stuff I'd like reviewer to focus on:
  * Read the (long) commit messages for patches 9 & 10; do folks agree
    with my declaration of "correct" behavior and my changes to the
    few regression tests in those patches?

Elijah Newren (12):
  t7300: add testcases showing failure to clean specified pathspecs
  dir: fix typo in comment
  dir: fix off-by-one error in match_pathspec_item
  dir: also check directories for matching pathspecs
  dir: make the DO_MATCH_SUBMODULE code reusable for a non-submodule
    case
  dir: if our pathspec might match files under a dir, recurse into it
  dir: add commentary explaining match_pathspec_item's return value
  git-clean.txt: do not claim we will delete files with -n/--dry-run
  clean: disambiguate the definition of -d
  clean: avoid removing untracked files in a nested git repository
  clean: rewrap overly long line
  clean: fix theoretical path corruption

 Documentation/git-clean.txt | 16 +++++-----
 builtin/clean.c             | 15 +++++++--
 dir.c                       | 63 +++++++++++++++++++++++++++----------
 dir.h                       |  8 +++--
 t/t7300-clean.sh            | 44 +++++++++++++++++++++++---
 5 files changed, 112 insertions(+), 34 deletions(-)

Range-diff:
 1:  82328e2033 !  1:  fe35ab8cc3 t7300: Add some testcases showing failure to clean specified pathspecs
    @@ Metadata
     Author: Elijah Newren <newren@gmail.com>
     
      ## Commit message ##
    -    t7300: Add some testcases showing failure to clean specified pathspecs
    +    t7300: add testcases showing failure to clean specified pathspecs
     
         Someone brought me a testcase where multiple git-clean invocations were
         required to clean out unwanted files:
 2:  5c1f58fd9d =  2:  707d287d79 dir: fix typo in comment
 3:  0e8b415af3 =  3:  bb316e82b2 dir: fix off-by-one error in match_pathspec_item
 4:  30b3ede443 !  4:  56319f934a dir: Directories should be checked for matching pathspecs too
    @@ Metadata
     Author: Elijah Newren <newren@gmail.com>
     
      ## Commit message ##
    -    dir: Directories should be checked for matching pathspecs too
    +    dir: also check directories for matching pathspecs
     
         Even if a directory doesn't match a pathspec, it is possible, depending
         on the precise pathspecs, that some file underneath it might.  So we
 5:  bab01f4cda !  5:  81593a565c dir: Make the DO_MATCH_SUBMODULE code reusable for a non-submodule case
    @@ Metadata
     Author: Elijah Newren <newren@gmail.com>
     
      ## Commit message ##
    -    dir: Make the DO_MATCH_SUBMODULE code reusable for a non-submodule case
    +    dir: make the DO_MATCH_SUBMODULE code reusable for a non-submodule case
     
         The specific checks done in match_pathspec_item for the DO_MATCH_SUBMODULE
         case are useful for other cases which have nothing to do with submodules.
 6:  c619ab4b3e !  6:  9566823a0f dir: If our pathspec might match files under a dir, recurse into it
    @@ Metadata
     Author: Elijah Newren <newren@gmail.com>
     
      ## Commit message ##
    -    dir: If our pathspec might match files under a dir, recurse into it
    +    dir: if our pathspec might match files under a dir, recurse into it
     
         For git clean, if a directory is entirely untracked and the user did not
         specify -d (corresponding to DIR_SHOW_IGNORED_TOO), then we usually do
    @@ Commit message
         the given directory which match one of the pathspecs being added to the
         entries list.
     
    -    Two particular considerations for this patch:
    +    Two notes of potential interest to future readers:
     
    -      * If we want to only recurse into a directory when it is specifically
    +      * If we wanted to only recurse into a directory when it is specifically
             matched rather than matched-via-glob (e.g. '*.c'), then we could do
             so via making the final non-zero return in match_pathspec_item be
             MATCHED_RECURSIVELY instead of MATCHED_RECURSIVELY_LEADING_PATHSPEC.
    -        (See final patch of this RFC series for details; note that the
    -        relative order of MATCHED_RECURSIVELY_LEADING_PATHSPEC and
    -        MATCHED_RECURSIVELY are important for such a change.))
    +        (Note that the relative order of MATCHED_RECURSIVELY_LEADING_PATHSPEC
    +        and MATCHED_RECURSIVELY are important for such a change.)  I was
    +        leaving open that possibility while writing an RFC asking for the
    +        behavior we want, but even though we don't want it, that knowledge
    +        might help you understand the code flow better.
     
           * There is a growing amount of logic in read_directory_recursive() for
    -        deciding whether to recurse into a subdirectory.  However, there is
    -        a comment immediately preceding this logic that says to recurse if
    +        deciding whether to recurse into a subdirectory.  However, there is a
    +        comment immediately preceding this logic that says to recurse if
             instructed by treat_path().   It may be better for the logic in
    -        read_directory_recursive() to be moved to treat_path() (or another
    -        function it calls, such as treat_directory()), but I did not feel
    -        strongly about this and just left the logic where it was while
    -        adding to it.  Do others have strong opinions on this?
    +        read_directory_recursive() to ultimately be moved to treat_path() (or
    +        another function it calls, such as treat_directory()), but I have
    +        left that for someone else to tackle in the future.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
 7:  5e1686a30e =  7:  7821898ba7 dir: add commentary explaining match_pathspec_item's return value
 8:  d92637f961 =  8:  13def5df57 git-clean.txt: do not claim we will delete files with -n/--dry-run
 9:  4550a30df8 =  9:  e6b274abf7 clean: disambiguate the definition of -d
10:  0985be2793 ! 10:  5f4ef14765 clean: avoid removing untracked files in a nested git repository
    @@ Commit message
         Also, clean up some grammar errors describing this functionality in the
         git-clean manpage.
     
    -    Finally, there is one somewhat related bug which this patch does not
    -    fix, coming from the opposite angle.  If the user runs
    -       git clean -ffd
    -    to force deletion of untracked nested repositories, and within an
    -    untracked nested repo the user has ignored files (according to the inner
    -    OR outer repositories' .gitignore), then not only will those ignored
    -    files be left alone but the .git/ subdirectory of the nested repo will
    -    be left alone too.  I am not completely sure if this should be
    -    considered a bug (though it seems like it since the lack of the
    -    untracked file would result in the .git/ subdirectory being deleted),
    -    but in any event it is very minor compared to accidentally deleting user
    -    data and I did not dive into it.
    +    Finally, there are still a couple bugs with -ffd not cleaning out enough
    +    (e.g.  missing the nested .git) and with -ffdX possibly cleaning out the
    +    wrong files (paying attention to outer .gitignore instead of inner).
    +    This patch does not address these cases at all (and does not change the
    +    behavior relative to those flags), it only fixes the handling when given
    +    a single -f.  See
    +    https://public-inbox.org/git/20190905212043.GC32087@szeder.dev/ for more
    +    discussion of the -ffd[X?] bugs.
     
         Signed-off-by: Elijah Newren <newren@gmail.com>
     
11:  2d36e3f7cb = 11:  4e30e62eb1 clean: rewrap overly long line
12:  3c5d1ff16a <  -:  ---------- clean: fix theoretical path corruption
 -:  ---------- > 12:  de2444f7cb clean: fix theoretical path corruption
-- 
2.23.0.173.gad11b3a635.dirty

