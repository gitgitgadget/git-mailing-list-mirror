Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB3AC433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D7564FEA
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbhCPP7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhCPP6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8564CC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b18so10735878wrn.6
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIUWKJ2X2P58l1I957IwufBPidohLX0NPrhaowfDTJg=;
        b=hKrUzQFlG4+EhB6PvG75WJBxo7BtC3UE0DTsnjy32zyO2EmRdBt93xHPm/hWREmDZg
         V9IPnRY6yDaqrrDsiVfHPPmS2iZCwhKznbsiTbOrGNmHmjJ/Rv/LxKLk1Ts1t+7TRZPY
         EeZ4wzBBFkmZDC6K/7/312nks6VPURNGSupmvTvyaQCC4AX05mo/kH8Xbpcd8TOAa8X4
         D7KlCQSVm9YJPdUDc4YxIUcT6kZZDwH9xtbz9y25ECQssu0EzyDQQtjrDl4p652obIQh
         8GlIIjA5xT6L4/NxhC2k1dvuwJxiKtkBmZBcQGoYFwYcd0sFnXF1YlVQBWsPmzD3+fmF
         PvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIUWKJ2X2P58l1I957IwufBPidohLX0NPrhaowfDTJg=;
        b=sqAj+JtTPNuvxs7knqTbCyN08y1WhMAefrUvNZQyG1B2nZezv8iid6/0zjWyih5GAp
         lkbDZxLRu0ULW+TIGa/XcyLQF/WqpM//ENWyDQfrHpk6toVGGI6yt8vJfnTfTy4+20Od
         8Y98SvvMzElveyYksILb/sToUABNZ2HbHrkfro+dp5Oe3FOI7im4/WRspwJr5ksRDnYz
         M/0J5n0h2iDFaVU5y41QEVQezfCGVN/WB2O6+2mfBKw8y2x4JwWxd5JarYJohXduVm5w
         guufaSiukBFnGiJz44gutwSFvCHxCbGMy2+Bp6Ke3uFdwDie65lCsvo5oV+1kC1T9Xoe
         uZOg==
X-Gm-Message-State: AOAM533dc1f3JCy+UotvtpwLJtrChHNBCQwPV68HNQFNOx5e/nlp5qYe
        aclZ5MM1H4X0NokyvT1yNEuv/uHilIl+og==
X-Google-Smtp-Source: ABdhPJxFCLm2AdUkegB14oEJsgPodXbyCFGwg0X02ZmVg9mIxpwvC/jK9tlnOv85Mpe4GNvbwbkwww==
X-Received: by 2002:adf:90c2:: with SMTP id i60mr5682695wri.75.1615910317715;
        Tue, 16 Mar 2021 08:58:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:37 -0700 (PDT)
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
Subject: [PATCH v3 00/32] tree-walk: mostly replace "mode" with "enum object_type" 
Date:   Tue, 16 Mar 2021 16:57:57 +0100
Message-Id: <20210316155829.31242-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The v2 of this series was broken as noted in
https://lore.kernel.org/git/87blbjfqkh.fsf@evledraar.gmail.com/

Here's a fixed version. This should actually address all of Elijah's
comments on v1 + v2.

It's up to 32 patches because I added some tests for the
mostly-never-been-tested code being changed in 09/32.

Ævar Arnfjörð Bjarmason (32):
  diff.c: remove redundant canon_mode() call
  notes & match-trees: use name_entry's "pathlen" member
  cache.h: add a comment to object_type()
  tree-walk.h: add object_type member to name_entry
  tree-walk.c: migrate to using new "object_type" field when possible
  fast-import tests: test for sorting dir/file foo v.s. foo.txt
  mktree tests: test that "mode" is passed when sorting
  diff tests: test that "mode" is passed when sorting
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
  match-trees: use "tmp" for mode in shift_tree_by()
  tree-walk.h API: add get_tree_entry_type()
  tree-walk.h API: document and format tree_entry_extract()
  tree-entry.h API: rename tree_entry_extract() to
    tree_entry_extract_mode()
  tree-walk.h API: add a tree_entry_extract_all() function
  tree-walk.h API: add get_tree_entry_all()
  tree-walk.h API: add a get_tree_entry_path() function
  blame: emit a better error on 'git blame directory'
  tree-walk.h API: add a tree_entry_extract_type() function

 archive.c                       | 50 +++++++++---------
 blame.c                         |  9 ++--
 builtin/checkout.c              |  6 ++-
 builtin/fast-import.c           | 12 +++--
 builtin/grep.c                  |  6 +--
 builtin/log.c                   |  7 +--
 builtin/ls-files.c              |  6 ++-
 builtin/ls-tree.c               | 14 +++---
 builtin/merge-tree.c            | 30 +++++++----
 builtin/mktree.c                |  4 +-
 builtin/pack-objects.c          |  6 +--
 builtin/reflog.c                |  3 +-
 builtin/rm.c                    |  2 +-
 builtin/update-index.c          |  6 ++-
 cache-tree.c                    |  2 +-
 cache.h                         | 11 ++--
 combine-diff.c                  |  8 +--
 delta-islands.c                 |  2 +-
 diff.c                          |  2 +-
 fsck.c                          | 23 ++++-----
 http-push.c                     |  6 ++-
 line-log.c                      |  2 +-
 list-objects.c                  | 20 +++++---
 match-trees.c                   | 52 +++++++++----------
 merge-ort.c                     | 13 ++---
 merge-recursive.c               | 33 ++++++------
 notes.c                         | 14 +++---
 object-name.c                   |  7 ++-
 pack-bitmap-write.c             |  8 +--
 read-cache.c                    | 16 +++---
 revision.c                      | 12 +++--
 t/t1450-fsck.sh                 | 66 ++++++++++++++++++++++++
 t/t4300-merge-tree.sh           | 44 ++++++++++++++++
 t/t8004-blame-with-conflicts.sh | 21 ++++++++
 t/t9300-fast-import.sh          | 87 ++++++++++++++++++++++++++++++++
 tree-diff.c                     | 30 +++++++----
 tree-walk.c                     | 89 ++++++++++++++++++++++++---------
 tree-walk.h                     | 63 ++++++++++++++++++++---
 tree.c                          | 19 ++++---
 tree.h                          |  5 +-
 unpack-trees.c                  | 24 +++++----
 walker.c                        | 22 ++++----
 42 files changed, 618 insertions(+), 244 deletions(-)

Range-diff:
 1:  f9bbc30f69 =  1:  26bc38fbdd diff.c: remove redundant canon_mode() call
 2:  187fc2c3e6 =  2:  8502cf8134 notes & match-trees: use name_entry's "pathlen" member
 3:  311637c558 =  3:  68133fa6aa cache.h: add a comment to object_type()
 4:  fecfe3d462 =  4:  9f714d6c01 tree-walk.h: add object_type member to name_entry
 5:  db961ab5e8 =  5:  6dbf2b0a6a tree-walk.c: migrate to using new "object_type" field when possible
 -:  ---------- >  6:  354a8e9a2a fast-import tests: test for sorting dir/file foo v.s. foo.txt
 -:  ---------- >  7:  e2331df28e mktree tests: test that "mode" is passed when sorting
 -:  ---------- >  8:  9e9486c2ea diff tests: test that "mode" is passed when sorting
 6:  df2fc76161 !  9:  be5c713336 cache.h: have base_name_compare() take "is tree?", not "mode"
    @@ Commit message
         958ba6c96eb (Introduce "base_name_compare()" helper function,
         2005-05-20).
     
    +    None of these comparison functions used to have tests, but with
    +    preceding commits some of them now do. I thought the remainder was
    +    trivial enough to review without tests, and didn't want to spend more
    +    time on them.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/fast-import.c ##
     @@ builtin/fast-import.c: static int tecmp0 (const void *_a, const void *_b)
    + {
      	struct tree_entry *a = *((struct tree_entry**)_a);
      	struct tree_entry *b = *((struct tree_entry**)_b);
    ++	int istree_a = S_ISDIR(a->versions[0].mode);
    ++	int istree_b = S_ISDIR(b->versions[0].mode);
      	return base_name_compare(
     -		a->name->str_dat, a->name->str_len, a->versions[0].mode,
     -		b->name->str_dat, b->name->str_len, b->versions[0].mode);
    -+		a->name->str_dat, a->name->str_len, 1,
    -+		b->name->str_dat, b->name->str_len, 1);
    ++		a->name->str_dat, a->name->str_len, istree_a,
    ++		b->name->str_dat, b->name->str_len, istree_b);
      }
      
      static int tecmp1 (const void *_a, const void *_b)
    -@@ builtin/fast-import.c: static int tecmp1 (const void *_a, const void *_b)
    + {
      	struct tree_entry *a = *((struct tree_entry**)_a);
      	struct tree_entry *b = *((struct tree_entry**)_b);
    ++	int istree_a = S_ISDIR(a->versions[1].mode);
    ++	int istree_b = S_ISDIR(b->versions[1].mode);
      	return base_name_compare(
     -		a->name->str_dat, a->name->str_len, a->versions[1].mode,
     -		b->name->str_dat, b->name->str_len, b->versions[1].mode);
    -+		a->name->str_dat, a->name->str_len, 1,
    -+		b->name->str_dat, b->name->str_len, 1);
    ++		a->name->str_dat, a->name->str_len, istree_a,
    ++		b->name->str_dat, b->name->str_len, istree_b);
      }
      
      static void mktree(struct tree_content *t, int v, struct strbuf *b)
 7:  49d5da8c08 = 10:  43623edddf tree-walk.h users: switch object_type(...) to new .object_type
 8:  c9d209d496 = 11:  030898f884 tree.h: format argument lists of read_tree_recursive() users
 9:  a6d2660fe1 = 12:  0ce197950b tree.h users: format argument lists in archive.c
10:  15f7f89acc = 13:  051c9f32ac archive: get rid of 'stage' parameter
11:  7a71404ea3 = 14:  bc73994b4c tree.h API: make read_tree_fn_t take an "enum object_type"
12:  64dc9364ba = 15:  e2b0964228 tree-walk.h users: migrate "p->mode &&" pattern
13:  93ed3edbbd = 16:  29dbc4292e tree-walk.h users: refactor chained "mode" if/else into switch
14:  7aa48aa34c = 17:  ada6d05176 tree-walk.h users: migrate miscellaneous "mode" to "object_type"
15:  3ae81621dc = 18:  01860daa55 merge-tree tests: test for the mode comparison in same_entry()
16:  4249ad5c4d = 19:  e4be48fb50 merge-ort: correct reference to test in 62fdec17a11
17:  e5e17505dd = 20:  189d2550fb fsck.c: switch on "object_type" in fsck_walk_tree()
18:  3f0b884f1f = 21:  3b7b12e6f7 tree-walk.h users: use temporary variable(s) for "mode"
19:  174167613b = 22:  6c3a07a327 tree-walk.h API: formatting changes for subsequent commit
20:  ec76db613f = 23:  879eb3da2a tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
21:  11e3494172 ! 24:  d2fa360ab9 tree-walk.h API users: use "tmp" for mode in shift_tree_by()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    tree-walk.h API users: use "tmp" for mode in shift_tree_by()
    +    match-trees: use "tmp" for mode in shift_tree_by()
     
         Refactor code added in 85e51b783c3 (Make "subtree" part more
         orthogonal to the rest of merge-recursive., 2008-06-30) to make it
22:  b31c106557 = 25:  cc50cfcf51 tree-walk.h API: add get_tree_entry_type()
23:  304d5d4d1a = 26:  f642a35482 tree-walk.h API: document and format tree_entry_extract()
24:  346453df35 = 27:  a0bcb59fa5 tree-entry.h API: rename tree_entry_extract() to tree_entry_extract_mode()
25:  dd012b661e = 28:  c7d4ba7734 tree-walk.h API: add a tree_entry_extract_all() function
26:  b6ee8410e3 = 29:  1d5421d67a tree-walk.h API: add get_tree_entry_all()
27:  5c98afd9e7 ! 30:  a3e1063ac4 tree-walk.h API: add a get_tree_entry_path() function
    @@ Commit message
         need neither the mode nor "enum object_type" parameters filled for
         them.
     
    -    There's callers here which doesn't need the "struct object_id" filled
    -    either, and provides a throwaway variable for us.
    +    There are callers here which don't need the "struct object_id" filled;
    +    forcing callers to pass one just requires they create a throwaway
    +    variable.
     
         See the following commits for the introduction of such code that's
         being modified here:
     
    -     - shift_tree(): 68faf68938e (A new merge stragety 'subtree'.,
    +     - shift_tree(): 68faf68938e (A new merge stragety[sic] 'subtree'.,
             2007-02-15) for the shift_tree()
     
          - tree_has_path(): 96e7ffbdc31 (merge-recursive: check for directory
28:  3e7e0f7eb8 ! 31:  da3dd6dd53 blame: emit a better error on 'git blame directory'
    @@ Commit message
     
             fatal: no such path 't' in HEAD
     
    +    The main point of this test is to assert that we're not doing
    +    something uniquely bad when in a conflicted merge. See
    +    cd8ae20195 (git-blame shouldn't crash if run in an unmerged tree,
    +    2007-10-18) and 9aeaab6811 (blame: allow "blame file" in the middle of
    +    a conflicted merge, 2012-09-11) for the bug the t8004 test was
    +    originally meant to address.
    +
    +    But when extending it let's grep out the specific error message for
    +    good measure. Having to change it in the future (e.g. as part of my
    +    parallel series to improve such 'OID does not match type' messages) is
    +    a small price for ensuring it doesn't regress.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## blame.c ##
    @@ t/t8004-blame-with-conflicts.sh: test_expect_success 'blame does not crash with
     +	test_commit second &&
     +	test_commit d/file &&
     +	test_must_fail git blame d 2>expected &&
    ++	grep "unsupported file type d" expected &&
     +
     +	git reset --hard second &&
     +	>d &&
29:  ac1ccf1357 = 32:  80e5cb0b30 tree-walk.h API: add a tree_entry_extract_type() function
-- 
2.31.0.256.gf0ddda3145

