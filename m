Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC6081F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbdL1EOB (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:01 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:36416 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbdL1EOA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:00 -0500
Received: by mail-it0-f48.google.com with SMTP id d16so27469624itj.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c90ieZVdc0VRGBdVbCZKVyzcVH0bPANMjk6IyAEC0QY=;
        b=RsaGAn38/HEdIFaWLl8hBznwTzs0udBnJuEsREyRSMPoPk1kT/DlJ8ahkNgd9N1UgM
         FcLC7r1JN9a6bPxjcn/YqpgtOXxhETr3oqs2U+q7Dxi7qKPR9mnw0l5qt13EwxPHFb2X
         9BPLrv9B0rY6CPoygEtLy71Gs1tefdqcXj59zi1tYaJn1t8xoM9yYMfb3VM9e15g6q+f
         cjFJ57B6zrdqcc793KV1gGRYrFo46W0YcCOh+i+YFsn54Jlwl9vo0esgTF1c/1GFAo23
         +o1LY6CjaNxnIpTp59DZ0XZOjo7M+Ht9TqPlu55AM9cT+ucB/XRGPlB+zGeoI71onegp
         tV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c90ieZVdc0VRGBdVbCZKVyzcVH0bPANMjk6IyAEC0QY=;
        b=LgEvFvVTW3Df9990H3meLnCJjGbhWpWo6iwCVge2Xf5VUgtPVpuK9XGjN9pBaltgwd
         Bl2gALPTc9QR7BfJcaie7kDppZiO3iaZQepe6ghFsi67vvWr6FzsPn4/jcj63l4BTJu0
         7s7L6PSnD0xETOJ2Kzdyz8PYXIUqJkU3yVpGxIibYCpiiyDsAX2GZTIvp33GFWH/POOZ
         0FvNCCHAZyqEx8laPNDLJNW19c+YPEGBkDweK/KkbDuZ7wL7HEMkoYir9qDZ82EfWOQ6
         Aweagt1AC/v+X/Q9CKiH5cJQDqPlIt0chEYXjYtMZ+wqpSTjrWUwfpG1y0y+hbGcURIJ
         4bhg==
X-Gm-Message-State: AKGB3mIKEgfPo7pZPQZz8FUGmpL5I9ZrFbOMeb/8eImWTtZdynOI4obs
        B5iLBOucYUfNKVape2hu6R0rvQ==
X-Google-Smtp-Source: ACJfBoshG2rFzcwWRBmWkF/BPP1oOnhZFwoj2DNk4bV/oywEUMwpnWGZspfbiJrYqHHoxnX3VPXCBg==
X-Received: by 10.36.125.129 with SMTP id b123mr40541563itc.142.1514434439496;
        Wed, 27 Dec 2017 20:13:59 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:13:58 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 00/34] Add directory rename detection to git
Date:   Wed, 27 Dec 2017 20:13:18 -0800
Message-Id: <20171228041352.27880-1-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset introduces directory rename detection to merge-recursive.  See
  https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
for the first series (including design considerations, etc.), and follow-up
series can be found at
  https://public-inbox.org/git/20171120220209.15111-1-newren@gmail.com/
  https://public-inbox.org/git/20171121080059.32304-1-newren@gmail.com/
  https://public-inbox.org/git/20171129014237.32570-1-newren@gmail.com/

Changes since v4:
  * Squashed Junio's GETTEXT_POISON fixes into the appropriate commits

Elijah Newren (34):
  Tighten and correct a few testcases for merging and cherry-picking
  merge-recursive: fix logic ordering issue
  merge-recursive: add explanation for src_entry and dst_entry
  directory rename detection: basic testcases
  directory rename detection: directory splitting testcases
  directory rename detection: testcases to avoid taking detection too
    far
  directory rename detection: partially renamed directory
    testcase/discussion
  directory rename detection: files/directories in the way of some
    renames
  directory rename detection: testcases checking which side did the
    rename
  directory rename detection: more involved edge/corner testcases
  directory rename detection: testcases exploring possibly suboptimal
    merges
  directory rename detection: miscellaneous testcases to complete
    coverage
  directory rename detection: tests for handling overwriting untracked
    files
  directory rename detection: tests for handling overwriting dirty files
  merge-recursive: move the get_renames() function
  merge-recursive: introduce new functions to handle rename logic
  merge-recursive: fix leaks of allocated renames and diff_filepairs
  merge-recursive: make !o->detect_rename codepath more obvious
  merge-recursive: split out code for determining diff_filepairs
  merge-recursive: add a new hashmap for storing directory renames
  merge-recursive: make a helper function for cleanup for handle_renames
  merge-recursive: add get_directory_renames()
  merge-recursive: check for directory level conflicts
  merge-recursive: add a new hashmap for storing file collisions
  merge-recursive: add computation of collisions due to dir rename &
    merging
  merge-recursive: check for file level conflicts then get new name
  merge-recursive: when comparing files, don't include trees
  merge-recursive: apply necessary modifications for directory renames
  merge-recursive: avoid clobbering untracked files with directory
    renames
  merge-recursive: fix overwriting dirty files involved in renames
  merge-recursive: fix remaining directory rename + dirty overwrite
    cases
  directory rename detection: new testcases showcasing a pair of bugs
  merge-recursive: avoid spurious rename/rename conflict from dir
    renames
  merge-recursive: ensure we write updates for directory-renamed file

 merge-recursive.c                   | 1231 ++++++++++-
 merge-recursive.h                   |   17 +
 strbuf.c                            |   16 +
 strbuf.h                            |   16 +
 t/t3501-revert-cherry-pick.sh       |    5 +-
 t/t6043-merge-rename-directories.sh | 3823 +++++++++++++++++++++++++++++++++++
 t/t7607-merge-overwrite.sh          |    7 +-
 unpack-trees.c                      |    4 +-
 unpack-trees.h                      |    4 +
 9 files changed, 5007 insertions(+), 116 deletions(-)
 create mode 100755 t/t6043-merge-rename-directories.sh

-- 
2.15.0.408.g8e199d483

