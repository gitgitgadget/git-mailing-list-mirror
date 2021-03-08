Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46371C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0952465215
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhCHPHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhCHPHN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F3EC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:10 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 7so11845292wrz.0
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQl2fXlpcpXFDEBdqoNbBnznCiPorTMGn/1btzsR6TA=;
        b=hcbx2oUvYMGjdtJ4/u8vujU0iClLtPEsqYbhp7I0DpN79poBgocpSr4rOPo75W4vOA
         MW/JtI6+zRPa9zxzwFopGvfO4IBffNvMkEOoY9FEkEgytAo7cxW7OkpfZ41rJ/T6+3GA
         B4fuRuk+xH0IB6ta8BNZSdokyl2DSmdE27Qycv1wly/4h5RNS0hvvYhBR88ndA0aOolj
         Db2djrXFMU9XHkL2rTdwTUPjJvixa6MLfrMPbNXNeipdpmUCfzcc2atnxygcIkE2BqAf
         LT+W/z0xPbvbCgpjxmtawCGMdQYxjs5H/wQwiRGVXCvqCWSDKgb4+JlWoRcacHB5idZx
         Ybqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQl2fXlpcpXFDEBdqoNbBnznCiPorTMGn/1btzsR6TA=;
        b=CJ84qnJ4xa4NNoQnf6RTgRMx/vb4Oe6pAZiVnmy5C2sMnmZFaZLs3yk2cHaFpEoaXO
         Lwqpc43Oeo4xP0B/iskECx9a90QYAK4UP6Uv12k636LCrTPQCmiLRjm4m1Fns/A7ss8r
         x/ZvlnhG2hOmxbW/WzPfvyEpPNS0wGyQDNjYNUeuzWL8GyfPOi320nWNz/wOEd0IVx/7
         lly10Y6c/frKwJve0vrmy96iekAbh7ify4i0CHh9SFqrqx86H9V000qI8/IToxx8qsaZ
         NqusRgqIBGzf3QrLRrNpSYk8mh6e7qxFZgJ0+dOmlZJ9Ei7m2IMLMw4iSXuzIi79gr0P
         /hAQ==
X-Gm-Message-State: AOAM532TZ6ZfwM5jLGcQ2qo6zebWD3OqRO5rwU6YgJ6NVJA1SQqSgVfV
        IZ04RtVupMhA7OBPa4Qc5nQTVTdDAw6JLg==
X-Google-Smtp-Source: ABdhPJztO7fZqEQJGBDtvidxPTpxLUk5X82uMOHb4xKV1b68vOD5OuIP9vFhaOIwLItEdhzsdo+Z2Q==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr23417603wro.199.1615216029062;
        Mon, 08 Mar 2021 07:07:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/30] tree-walk: mostly "mode" to "enum object_type"
Date:   Mon,  8 Mar 2021 16:06:20 +0100
Message-Id: <20210308150650.18626-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This large series goes on top of my 6 patch series for
read_tree_recursive() as this one further refactors that function. See
https://lore.kernel.org/git/20210308022138.28166-1-avarab@gmail.com/
for that series.

I noticed that since 2014 or so we haven't been doing the fsck checks
for bad file modes in trees. This series fixes that. I plan to add
tests etc. for that in another follow-up series.

I wanted to get this out for review sooner than later, particularly
since the fsck testing will probably get me down another refactoring
path (fsck testing in general in this area is pretty bad...).

As noted in 30/30 it would have been way easier to simply do an
isolated fix for that bug by introducing some fsck-specific API for
raw tree reading.

But I thought the bug was symptomatic of a wider problem in our
codebase. Namely that we pass around the tree's mode *a lot*.

But almost everything that then deals with the mode doesn't per-se
care about the mode bits in the tree, but using them to map that mode
to a tree entry for one of of OBJ_{BLOB,TREE,COMMIT}.

So this is a large refactoring of all users of the widely used
tree-walk.h API to "enum obj2ect_type", finally in 29/30 I rename the
field to a scary "raw_mode".

At that point we have just ~30-50 grep hits left for "raw_mode" in the
codebase (depending on whether we count names in function parameters).

Hopefully being in that state alleviates e.g. Elijah's concerns
expressed in
https://lore.kernel.org/git/CABPp-BEdu1PqV5W=FuL0f08iFhGzvzV8oSUybNj4eF0aAwTnAw@mail.gmail.com/
I agree that doing the equivalent of 30/30 on top of master would be
way too scary, but once we're at 29/30 I think it's sane.

I tested this in combination with his on-list series to add more
merge-ort testing:
https://lore.kernel.org/git/pull.973.git.git.1614905738.gitgitgadget@gmail.com/

I found a regression I'd caused in the merge-ort.c code with those
tests, fixed here. See the comment in merge-ort.c in 30/30.

Ævar Arnfjörð Bjarmason (30):
  diff.c: remove redundant canon_mode() call
  notes & match-trees: use name_entry's "pathlen" member
  cache.h: add a comment to object_type()
  tree-walk.h: add object_type member to name_entry
  tree-walk.c: migrate to using new "object_type" field when possible
  cache.h: have base_name_compare() take "is tree?", not "mode"
  tree-walk.h users: switch object_type(...) to new .object_type
  tree.h: format argument lists of read_tree_recursive() users
  tree.h users: format argument lists in archive.c
  archive: get rid of 'stage' parameter
  tree.h API: make read_tree_fn_t take an "enum object_type"
  tree-walk.h users: migrate "p->mode &&" pattern
  tree-walk.h users: refactor chained "mode" if/else into switch
  tree-walk.h users: migrate miscellaneous "mode" to "object_type"
  merge-tree tests: test for the mode comparison in same_entry()
  merge-ort: correct reference to test in 62fdec17a11
  fsck.c: switch on "object_type" in fsck_walk_tree()
  tree-walk.h users: use temporary variable(s) for "mode"
  tree-walk.h API: formatting changes for subsequent commit
  tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
  tree-walk.h API users: use "tmp" for mode in shift_tree_by()
  tree-walk.h API: Add get_tree_entry_type()
  tree-walk.h API: add a get_tree_entry_path() function
  tree-walk.h API: document and format tree_entry_extract()
  tree-entry.h API: rename tree_entry_extract() to
    tree_entry_extract_mode()
  tree-walk.h API: add a tree_entry_extract_all() function
  tree-walk.h API: add a tree_entry_extract_type() function
  tree-walk.h API users: rename "struct name_entry"'s "mode" to
    "raw_mode"
  tree.h API users: rename read_tree_fn_t's "mode" to "raw_mode"
  tree-walk.h API: move canon_mode() back out of decode_tree_entry()

 archive.c              | 51 +++++++++++++-----------
 blame.c                |  9 +++--
 builtin/checkout.c     |  7 +++-
 builtin/fast-import.c  |  8 ++--
 builtin/grep.c         |  6 +--
 builtin/log.c          |  7 ++--
 builtin/ls-files.c     | 13 +++---
 builtin/ls-tree.c      | 18 ++++-----
 builtin/merge-tree.c   | 32 +++++++++------
 builtin/mktree.c       |  4 +-
 builtin/pack-objects.c |  6 +--
 builtin/reflog.c       |  3 +-
 builtin/rm.c           |  2 +-
 builtin/update-index.c |  7 +++-
 cache-tree.c           |  2 +-
 cache.h                | 11 ++++--
 combine-diff.c         |  8 ++--
 delta-islands.c        |  2 +-
 diff.c                 |  2 +-
 fsck.c                 | 23 +++++------
 http-push.c            |  6 ++-
 line-log.c             |  2 +-
 list-objects.c         | 20 +++++++---
 match-trees.c          | 52 ++++++++++++------------
 merge-ort.c            | 34 ++++++++++------
 merge-recursive.c      | 33 ++++++++--------
 notes.c                | 15 +++----
 object-name.c          |  7 ++--
 pack-bitmap-write.c    |  8 ++--
 read-cache.c           | 16 ++++----
 revision.c             | 12 ++++--
 t/t4300-merge-tree.sh  | 44 +++++++++++++++++++++
 tree-diff.c            | 44 ++++++++++++---------
 tree-walk.c            | 89 +++++++++++++++++++++++++++++++-----------
 tree-walk.h            | 67 ++++++++++++++++++++++++++-----
 tree.c                 | 19 +++++----
 tree.h                 |  5 ++-
 unpack-trees.c         | 30 ++++++++------
 walker.c               | 22 ++++++-----
 39 files changed, 482 insertions(+), 264 deletions(-)

-- 
2.31.0.rc0.126.g04f22c5b82

