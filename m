Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A3D20951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbdCQRXG (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:23:06 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35629 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdCQRXD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:23:03 -0400
Received: by mail-pg0-f41.google.com with SMTP id b129so46206237pgc.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c1DFBDGM/zz2YoYm7cVk8dpeHRznjfSKSIv56AE7Fns=;
        b=cZlHIOzLWeYxRYfCKOsxGzd3NDuLPJ+8ZYlPr8v/XoCWIAhwgSqSpyDXxjmFTKpKHE
         FtBGB5FMlkN/vwideauGBY7U0mrWpGTo9JspJeIiqES2ZRE0lwSUwyxsT61BS78D+AzN
         FxB7qnFTrTkyxriNjwhnstzB1t2LnyM5HpYnIvzxhs5dI1y81GWEu6vgZfve71OCEdPd
         y71R7AXP+J2yQHOqkGPgaJJSLI0CveXmPTYsTWwdRvY+IDjXsJ7Gb9ca/UtcDMc+nV2q
         GUu2rt++bMkhOeJs8wZ3rXV2gc7lmoZPTMtsmzVCAzrq+Bt6Or44LXqssF4MlXGSb64y
         TJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c1DFBDGM/zz2YoYm7cVk8dpeHRznjfSKSIv56AE7Fns=;
        b=JSj0YYCA4mt9o5dnq7wzDsQDq4TlvrO1jNbX0bnQKHaMabPEPQIMRHBZidt4HNkNza
         SqtfWZzHAZHWNHaYZT5uN61KrKlaBVtJOysyendbomiaBPdpMBAERUebSLZ1o2TK9sg4
         qmmVWS4mTuhOvrjS6wYVAh8kltDPQavjF426/EYPaVbacM9Elhgngt8dn5/h6aQmJ5+t
         sxN0gu/+mYgxOsq7cK4cDkucqId+lS59AieC2tpXoQ849YLs3/4/QiVz7Xp+C+kgaTDQ
         kQ+pfgkKlYv6uQa410wVn1gKcaC4pNveu3eSxD5+1bc/MlCtKUyYk7AL2ZnQSMedUl0S
         cAIg==
X-Gm-Message-State: AFeK/H3yKQVSJv+fGsONGGUFZNSMboXYR26fvI9obsJL40nWJ4XE1mvPMiAWFvkFrmi1Ve11
X-Received: by 10.99.101.131 with SMTP id z125mr17075499pgb.218.1489771382344;
        Fri, 17 Mar 2017 10:23:02 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 197sm17978861pfv.19.2017.03.17.10.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 10:23:01 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de,
        pclouds@gmail.com
Subject: [PATCH v3 0/5] recursing submodules with relative pathspec (grep and ls-files)
Date:   Fri, 17 Mar 2017 10:22:52 -0700
Message-Id: <20170317172257.4690-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170314221100.24856-1-bmwill@google.com>
References: <20170314221100.24856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v3:
* Added sign-off to the patches where it was missing.
* slight tweak to the style and commit msgs of a few patches.
* broke up the last patch (for ls-files) into a typo fix followed by fixing the
  bug itself.  This was to make the diff easier to review.

Brandon Williams (5):
  grep: fix help text typo
  setup: allow for prefix to be passed to git commands
  grep: fix bug when recursing with relative pathspec
  ls-files: fix typo in variable name
  ls-files: fix bug when recursing with relative pathspec

 builtin/grep.c                         | 41 +++++++++++--------
 builtin/ls-files.c                     | 41 ++++++++++---------
 cache.h                                |  1 +
 git.c                                  |  2 -
 setup.c                                |  7 +++-
 t/t3007-ls-files-recurse-submodules.sh | 39 ++++++++++++++++++
 t/t7814-grep-recurse-submodules.sh     | 75 ++++++++++++++++++++++++++++++++++
 7 files changed, 167 insertions(+), 39 deletions(-)

-- 
2.12.0.367.g23dc2f6d3c-goog

