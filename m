Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395421F461
	for <e@80x24.org>; Thu,  5 Sep 2019 15:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfIEPrm (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 11:47:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38562 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbfIEPrm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 11:47:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id w11so1497412plp.5
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rXuXc0aPQUkTYRwwPTL7J7KRk41J9ySRDKYOapXyoLI=;
        b=QNb2mRH9CX3LFREnm0Im6M9ZMpdXuuvV8+/wGz9uXanzQ8ahfBGTqo1QGIIg/Fsh4e
         AZa3PbSZWXAh7V4OKSbOqutwrBTWRIVNRNDhci+uFwKoTIxp+9TqKjh1KZpwBSd3usmX
         NMP/KfiLT9wcMKvOKLg8LhlOefCMS+4Y/ax8Bp6I8SS6k1/a27bM7Qo2lipeoVzPRTjc
         AZ8QTykmp5KMQOZGMZ+M0ZFzOS9rLX1dwUEsW0130DrFpBLIQGA2pPEs0SXxtNEVBqs4
         XZInmNSrLAZods7dlksKQbtot/rc//0ju1jK2uOmxM4K7EGfYzDWYBajm8YNM4mdPDls
         rvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rXuXc0aPQUkTYRwwPTL7J7KRk41J9ySRDKYOapXyoLI=;
        b=S05vc9oMEXFQEVJzWBoSYb2v5djiPqZefPb9Migx/8Xqg/LzvmqdmRdC5n6vQawgzI
         oAvdZUiIafOhMYTJLeaMUl0iQbmT7QQop5V0TO/eEQ9yURqFN8l353AzeAgzlkt2xJDb
         ShNaLdlebwXD3wKI7q8n0v+b9zhCAnyPhAGI90owdajoH5QtPcM7StuL3y/woA4wAZ8B
         M3jrmUOs18bEMBBuE88uTmB7ESChqlIl6UerOlW5DXW1cv5W/xTdHz4Y9PVKzcFmg1ob
         pAx/zZ3eLWw0sOcLBwq/fVmSiAOXBXj3u4CWXnslC4TPHwr3UXdm1aDa9U4ixvfqzj3Q
         PLLA==
X-Gm-Message-State: APjAAAUM/DG6FaQc2Ef2Mok+OxgSK8wPzmTJ1uiCqDbVDv9yGULSig+k
        I389c04zUnFPhDDiR7aYpB+tRSeW
X-Google-Smtp-Source: APXvYqzrpMQ2rY5e9y4VGX5uq34X7WXVtsX2zobIBJYqQDpkvQsUfo6mKeU9LMD8Qw/4c4TNp3LGrg==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr4277651pld.266.1567698460855;
        Thu, 05 Sep 2019 08:47:40 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id x16sm2339867pjn.12.2019.09.05.08.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 08:47:40 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 00/12] Fix some git clean issues
Date:   Thu,  5 Sep 2019 08:47:23 -0700
Message-Id: <20190905154735.29784-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.11.g45a39ee867
In-Reply-To: <20190825185918.3909-1-szeder.dev@gmail.com>
References: <20190825185918.3909-1-szeder.dev@gmail.com>
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

I still never got answers to some questions in v1 of my RFC, so after
considerable thought I eventually decided to:

  * Declare the existing documentation to be ambiguous and hard to
    interpret correctly; modified the documentation to clearly
    document 'correct behavior' with how different pieces interact.
    
  * Overrule four regression tests as having the wrong *expectation*,
    and modify them to have a correct one.  That sounds like a
    backward compatibility issue BUT: The tests were written to check
    for issues that were orthogonal to the pieces that mattered in this
    series and thus couldn't be viewed as actually having an opinion
    on correct behavior on my issues; rather, they were simply
    reinforcing existing (buggy) implementation results.

  * Add a few tests which actually check relevant interactions of
    parameters and setup, to make this area less ambiguous.  (Though
    one of them was added by SZEDER before my patches, and I should
    probably add a couple more tests...)

Help from reviewers:

The biggest area I need help from reviewers is to look at the commit
messages for patches 9 and 10, to see if folks agree with my
declaration of 'correct behavior' and my changes to the regression
tests.  If those are good, this series can proceed.  If they aren't,
and someone else can't provide an alternate easy-to-explain 'correct
behavior' that we should implement and which is devoid of ugly edge
cases for users, then this patch series may languish for another few
years.

Other notes:
  * Patches 1-6 were included in v1 and have almost no changes (just one
    fix pointed out by Peff).
  * Patch 6's commit message has some additional RFC-related comments
    and questions, one of which ties in with Patch 9.
  * Patch 7 was added as per (old) conversation with Peff.
  * Patch 9 & 10 are in most need of review (see above); each has
    lengthy commit messages.
  * It would be nice if someone knows whether the codepath edited in
    Patch 12 is dead code.  If so, we could change that patch to just
    drop that if-check block.  If it's not dead code, that patch fixes
    what is probably a rare but ugly bug.

Elijah Newren (12):
  t7300: Add some testcases showing failure to clean specified pathspecs
  dir: fix typo in comment
  dir: fix off-by-one error in match_pathspec_item
  dir: Directories should be checked for matching pathspecs too
  dir: Make the DO_MATCH_SUBMODULE code reusable for a non-submodule
    case
  dir: If our pathspec might match files under a dir, recurse into it
  dir: add commentary explaining match_pathspec_item's return value
  git-clean.txt: do not claim we will delete files with -n/--dry-run
  clean: disambiguate the definition of -d
  clean: avoid removing untracked files in a nested git repository
  clean: rewrap overly long line
  clean: fix theoretical path corruption

 Documentation/git-clean.txt | 16 +++++-----
 builtin/clean.c             | 17 ++++++++--
 dir.c                       | 63 +++++++++++++++++++++++++++----------
 dir.h                       |  8 +++--
 t/t7300-clean.sh            | 44 +++++++++++++++++++++++---
 5 files changed, 114 insertions(+), 34 deletions(-)

-- 
2.22.1.11.g45a39ee867

