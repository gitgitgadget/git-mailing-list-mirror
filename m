Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AF231FDEA
	for <e@80x24.org>; Tue,  9 May 2017 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbdEITS1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 15:18:27 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34853 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdEITSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 15:18:25 -0400
Received: by mail-pg0-f48.google.com with SMTP id o3so4408472pgn.2
        for <git@vger.kernel.org>; Tue, 09 May 2017 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g2ls3oBV4hmEbnje7xT7IjfZ7PbaAHydNni+0jmpBoU=;
        b=bM7uXu+VuXaGI2p7d0jUFPK0KTIQcvWAWHWA7J1HdEOZnwjWqCJw65ZuSsbBc/TqRa
         aDZWHpH2a68l0DmYPEmSmWg21s1GJIRKwdBuG9DH5qNezxOkWtrwVExr4iSi+MlJPqNy
         9z0T9JuEIUGpEScfVK+cDwxfVD0ECQ0pebCJBo1aJkzqBnem0MG1yRmIE7HuwUdre2JC
         9wdS4S7q6B9qwkWkZO2bo6NKkgjZExOoUszOd4i/k8nsWGOZvQuAijMzXGAaj994PxWi
         mqUdaRQl+/xGQMskbR/VfH0SVxDpsAGUjNXjvKkL7rPnI4z3j9UNQ+ouFQG9WAF+lEBg
         UrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g2ls3oBV4hmEbnje7xT7IjfZ7PbaAHydNni+0jmpBoU=;
        b=UTE48k+BNtrSFrjpRk5Y1t9uMAeR+mlW1RONDpTUWPyPjwd4lNxl9VpDHugBCsbSEe
         l72mdIFzW1lFM4hc5VuTesjnv1jKp02tuXAKNckqKOwbk3AouLzxtKjiJwh8q9nSkOt6
         eIgtk0tSN72XwR6ys4tG/2NvwQODkzXJK/NPLMvNac5JUiNIzejmPkZG96ymwO4waPZc
         cIbqJeMX4LIS+F1+0BmGoLmf7bN9Tudh162LJJMWQbOhiO6GrHmH/VRXZobVltEvV+FW
         tQUfcIWzNDj88NK4PCTYXZI6NcrS+c/jCmZnboVU/P7STy6Lzlmb1yngNMZenK/NJnLB
         UB7Q==
X-Gm-Message-State: AODbwcBw/o0kGYPL0WWppgzVvx0NkvXQhiB9BkLzD6T6eHDBL+xlRCgv
        7Aj4JJliFGxAXWA2GRUp7Q==
X-Received: by 10.84.232.76 with SMTP id f12mr2379431pln.101.1494357503946;
        Tue, 09 May 2017 12:18:23 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id w23sm1124427pfl.133.2017.05.09.12.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 12:18:22 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/8] convert pathspec.c to take an index parameter
Date:   Tue,  9 May 2017 12:17:57 -0700
Message-Id: <20170509191805.176266-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another conversion series to convert the pathspec library code to take
in an index parameter instead of relying on cache macros or on the global
variable 'the_index'.

While I was working in the pathspec code I thought it would be good to do a
little more cleanup and make the API cleaner.  More specifically consolidating
the 'strip submodule slash' flags into a single flag while splitting out the
'submodule leading path' check performed in the expensive case into its own
flag.

Brandon Williams (8):
  pathspec: provide a more descriptive die message
  submodule: add die_in_unpopulated_submodule function
  pathspec: change PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
  pathspec: rename PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP
  pathspec: convert strip_submodule_slash to take an index
  pathspec: convert find_pathspecs_matching_against_index to take an
    index
  pathspec: convert init_pathspec_item to take an index
  pathspec: convert parse_pathspec to take an index

 archive.c                        |  4 +-
 builtin/add.c                    | 14 +++---
 builtin/blame.c                  |  2 +-
 builtin/check-ignore.c           |  7 +--
 builtin/checkout.c               |  2 +-
 builtin/clean.c                  |  2 +-
 builtin/commit.c                 |  4 +-
 builtin/grep.c                   |  2 +-
 builtin/ls-files.c               |  6 +--
 builtin/ls-tree.c                |  5 ++-
 builtin/rerere.c                 |  2 +-
 builtin/reset.c                  |  4 +-
 builtin/rm.c                     |  4 +-
 builtin/submodule--helper.c      |  4 +-
 builtin/update-index.c           |  2 +-
 line-log.c                       |  2 +-
 pathspec.c                       | 92 +++++++++++++++++-----------------------
 pathspec.h                       | 19 +++++----
 revision.c                       |  5 ++-
 submodule.c                      | 32 +++++++++++++-
 submodule.h                      |  2 +
 t/t6134-pathspec-in-submodule.sh |  6 +--
 tree-diff.c                      |  2 +-
 23 files changed, 122 insertions(+), 102 deletions(-)

-- 
2.13.0.rc2.291.g57267f2277-goog

