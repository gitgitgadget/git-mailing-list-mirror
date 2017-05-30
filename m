Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8755C20D11
	for <e@80x24.org>; Tue, 30 May 2017 17:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750912AbdE3RbQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:16 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:32803 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdE3RbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:16 -0400
Received: by mail-pf0-f179.google.com with SMTP id e193so78456075pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5YBT6hs1fXObFdr46mPixPnbm6znmK4T7mupyqNwVM4=;
        b=afcaCnVACYc5EeO6c6PfHdZ3dPy2/AhI5MIvfV6ftaHbqBgnerDlNosS8S3gPS2wBA
         AUWFJ9xufF4FWpzSoCXGty+P1J1qP/TEyXefQGO9c7fcUJ6+aAd0KXjvBH5sokJN1iIj
         w0unHdU2FOMRPn8b9s5PfBxM/cCAc+MxpeWCDsjXymcv5UgvoESgQIoh+VDsrb6dEvth
         jab6LZZWZoed56so2plf5J8ifh7HMGmTi4KrA9x9N6Gpc68TOsoot2M+PV3YFIkqVkCx
         lw/2IJcrmnDFH0Eyx+qtXluZMCNspYjiR7q1Nds6T4UCjmNt15cWhUZLxzH/0vszpYQf
         9Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5YBT6hs1fXObFdr46mPixPnbm6znmK4T7mupyqNwVM4=;
        b=Wg90Ju9t/tJVhZwN5i26BdRSj4rdkVrysAM0jh/T7dxVTnXR4C5DlcfYy52Cai0hng
         8F32RpYKaBNfgQJAy+of62Twu6IUdfQ59FyKMD6hSZR+wF9WhyQCu5LVkMfI6pFZ42io
         TbBn02PElEPUAnZXud6yG55LPyHgb86uaxAbatgz95Oi4FKDe/oROKwiliY2zrSweohi
         08F+OSx2Lu2dC882wP0kV82VLG0AK/Ro7kWjzdhjQFdWMJYYxsJxROnbuwRyDbakDu0M
         InXYig0klBo8fmYn010noQvY5P4s61Y5WrgWvWRbqCtjgnqcV+9/W5B1ENDfJONCLb40
         pdQQ==
X-Gm-Message-State: AODbwcCUTcHhnr9CFIr6aeZ1nVjWuBkABimF9H1Gt4e3s2keV/gGxUNd
        8yR9Lxli7tKPZX6bC05JfA==
X-Received: by 10.99.123.77 with SMTP id k13mr27644637pgn.32.1496165474800;
        Tue, 30 May 2017 10:31:14 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 00/33] object id conversion (grep and diff)
Date:   Tue, 30 May 2017 10:30:36 -0700
Message-Id: <20170530173109.54904-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A month or so ago I thought I would lend a hand to Brian and do a round of
conversions from sha1 -> struct object_id.  Now that Brian's latest series has
hit master I can finally send these patches out.

The first couple patches are from Brian which convert some of the notes logic
to using 'struct object_id'.  The remaining patches are to convert the grep and
diff machinery to using 'struct object_id'.

Brandon Williams (26):
  grep: convert to struct object_id
  diff: convert get_stat_data to struct object_id
  diff: convert diff_index_show_file to struct object_id
  diff: convert diff_addremove to struct object_id
  diff: convert run_diff_files to struct object_id
  diff: convert diff_change to struct object_id
  diff: convert fill_filespec to struct object_id
  diff: convert reuse_worktree_file to struct object_id
  diff: finish conversion for prepare_temp_file to struct object_id
  patch-ids: convert to struct object_id
  diff: convert diff_flush_patch_id to struct object_id
  combine-diff: convert diff_tree_combined to struct object_id
  combine-diff: convert find_paths_* to struct object_id
  tree-diff: convert diff_root_tree_sha1 to struct object_id
  notes-merge: convert notes_merge* to struct object_id
  notes-merge: convert merge_from_diffs to struct object_id
  notes-merge: convert find_notes_merge_pair_ps to struct object_id
  notes-merge: convert verify_notes_filepair to struct object_id
  notes-merge: convert write_note_to_worktree to struct object_id
  diff-tree: convert diff_tree_sha1 to struct object_id
  builtin/diff-tree: cleanup references to sha1
  tree-diff: convert try_to_follow_renames to struct object_id
  tree-diff: convert diff_tree_paths to struct object_id
  tree-diff: convert path_appendnew to object_id
  diffcore-rename: use is_empty_blob_oid
  diff: rename diff_fill_sha1_info to diff_fill_oid_info

brian m. carlson (7):
  notes: convert internal structures to struct object_id
  notes: convert internal parts to struct object_id
  notes: convert for_each_note to struct object_id
  notes: make get_note return pointer to struct object_id
  notes: convert format_display_notes to struct object_id
  builtin/notes: convert to struct object_id
  notes: convert some accessor functions to struct object_id

 builtin/am.c          |   2 +-
 builtin/blame.c       |  22 +++---
 builtin/commit.c      |   2 +-
 builtin/diff-tree.c   |  16 ++--
 builtin/diff.c        |   8 +-
 builtin/fast-export.c |   8 +-
 builtin/grep.c        |  22 +++---
 builtin/log.c         |   8 +-
 builtin/merge.c       |   2 +-
 builtin/notes.c       | 136 ++++++++++++++++-----------------
 cache.h               |   7 ++
 combine-diff.c        |  30 ++++----
 diff-lib.c            |  52 ++++++-------
 diff-no-index.c       |   2 +-
 diff.c                |  74 +++++++++---------
 diff.h                |  38 +++++-----
 diffcore-rename.c     |   6 +-
 diffcore.h            |   2 +-
 grep.c                |  19 +++--
 grep.h                |   2 +-
 line-log.c            |  10 +--
 log-tree.c            |  12 +--
 merge-recursive.c     |   2 +-
 notes-cache.c         |  10 +--
 notes-merge.c         | 165 +++++++++++++++++++++--------------------
 notes-merge.h         |  12 +--
 notes-utils.c         |   2 +-
 notes-utils.h         |   2 +-
 notes.c               | 202 ++++++++++++++++++++++++++------------------------
 notes.h               |  16 ++--
 patch-ids.c           |  26 +++----
 patch-ids.h           |   4 +-
 remote-testsvn.c      |  22 +++---
 revision.c            |  16 ++--
 sequencer.c           |   4 +-
 tree-diff.c           |  93 ++++++++++++-----------
 36 files changed, 535 insertions(+), 521 deletions(-)

-- 
2.13.0.219.gdb65acc882-goog

