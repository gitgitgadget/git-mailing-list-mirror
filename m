Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C4FC433E4
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474F16193B
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCUAB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCUAB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96884C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b9so12847413wrt.8
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2zRp5Ui4Yf/cJkP1AaSp7h6CVzZ3Ry9PfG8xVSejDo=;
        b=ei3wT/Pl0fNxFlqQH2jVkdYjyC2WAxdJQ28R5cVebBoeraeQYIbZnAmK8ZvsX0lPVt
         NRYJ6ikCIF3ceuVFMpC971vR+FeB/Bfpc6vCnf4rADYyhy2crPOV4U1vpVXnXizgsSny
         vDSmN+Q5v2DiMy5SUjIzp7xd8q1qBsAKnnlJwjA+mmZ4wp75MXVDvPAgHqpkfXFkOeWJ
         GX4OOLXZd5DmD9ff8rDz5HYyEz6LebzAeJn6b3EvoJwqoZ6VVGcnBIEVi/cDdOL3sbnm
         YEEaesZppNrnOSKg0bENkgVMG5KJvBAlLNBvcz2tpCKyG5cq83kMNoef+BPpOQq7jpDz
         Kv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2zRp5Ui4Yf/cJkP1AaSp7h6CVzZ3Ry9PfG8xVSejDo=;
        b=eRwalXGxCsqkbflLwASoY9yYqy0t0oonAjJFrFnBO4dY9ygejmal6Tks2Waysh/UQW
         uqTEoPdhvhwkCloWrKWDPjZRODqC5g4KOc7YAqF6bljchOg/PahFjA0s8+caobRPT1W8
         9Tr8CQ/88AT8OstONPgYQf3/lMgi8s8V6Rw/5zg8c4SswYOlhC+zpCHtaucJlxx6Am/P
         mmUooLcRCBMtia4qBuFYPcJESQwILEAChwYXzQ+J0e2a9adntttxZbN07u0tRmxF/QUK
         SdXzw6+X+Fp7iQ+IK8kDYV4aySofe9jETn/dbSWY/Udv5sbh2++dbUr1CbayeZfFvpvM
         6A4g==
X-Gm-Message-State: AOAM5333GojMMWOwt9F8mcmcfbtg3wdookjyKVRPzfFGl3TObjuwtX7m
        Xc0egrUmtBUDyyPRk90aYNNGCmqzAUMbGg==
X-Google-Smtp-Source: ABdhPJw5Mu0NQWj3l6NbeREqTkoHLK3VAqceZM3fKas1oZXhJMl4AVW5Ihl66S2h1rm3d25RnhU4ew==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr11240441wrw.328.1616284886493;
        Sat, 20 Mar 2021 17:01:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:25 -0700 (PDT)
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
Subject: [PATCH v4 00/29] tree-walk: mostly replace "mode" with "enum object_type"
Date:   Sun, 21 Mar 2021 01:00:33 +0100
Message-Id: <cover.1616282533.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <20210316155829.31242-1-avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of v3 of this series[1] and on top of (and requires) my
just-submitted v5 re-roll of the read_tree() refactoring series[2].

There was a regression in 1/32 of the old series. Removing the
canon_mode() call in diff.c didn't account for us needing to
canonicalize "diff --no-index" modes. There were no tests for this,
and it failed or not depending on the FS modes in the git.git checkout
being tested. This fixes the CI smoke coming from this series.

I plan to submit another set of patches to fix git diff --no-index's
test coverage, but for this series it was best to just eject it.

I'm confident that this is in a good shape now. There is now no
canon_mode() change in this series, just refactoring of
s/mode/object_type/g.

As discussed in earlier rounds the point of this prep series is to get
to a point where we can expose an API to fix long-standin blindspots
in fsck checks.

This is a long journey to get to that point, and isn't strictly
necessary to fix tht issue. But I think it's worth it since it leaves
the API use in a much better state where it's clear which things
actually require the mode bits, and which are just asking about the
object type of tree entries.

I dropped a couple of more patches to do with archive.c, in my
re-rolled [2] I'm now dealing with the "stage" parameter there, so
there's no need to do that here anymore.

1. https://lore.kernel.org/git/20210316155829.31242-1-avarab@gmail.com/
2. https://lore.kernel.org/git/xmqqy2ehctjo.fsf@gitster.g

Ævar Arnfjörð Bjarmason (29):
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

 archive.c                       | 29 ++++++-----
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
 41 files changed, 606 insertions(+), 233 deletions(-)

Range-diff:
 1:  26bc38fbdd0 <  -:  ----------- diff.c: remove redundant canon_mode() call
 2:  8502cf8134b =  1:  0390b1e9ded notes & match-trees: use name_entry's "pathlen" member
 3:  68133fa6aaa =  2:  186f7a7a44b cache.h: add a comment to object_type()
 4:  9f714d6c01f =  3:  4fed508f3cb tree-walk.h: add object_type member to name_entry
 5:  6dbf2b0a6aa =  4:  c557b67231b tree-walk.c: migrate to using new "object_type" field when possible
 6:  354a8e9a2a1 =  5:  7016008554a fast-import tests: test for sorting dir/file foo v.s. foo.txt
 7:  e2331df28e1 =  6:  b0546197b1b mktree tests: test that "mode" is passed when sorting
 8:  9e9486c2ea0 =  7:  73e92ac187d diff tests: test that "mode" is passed when sorting
 9:  be5c713336a =  8:  1b6a10f814c cache.h: have base_name_compare() take "is tree?", not "mode"
10:  43623edddfb =  9:  f8912a409b5 tree-walk.h users: switch object_type(...) to new .object_type
11:  030898f884c ! 10:  df43f1a76ac tree.h: format argument lists of read_tree_recursive() users
    @@ archive.c: static int check_attr_export_subst(const struct attr_check *check)
      }
      
      static int write_archive_entry(const struct object_id *oid, const char *base,
    --		int baselen, const char *filename, unsigned mode, int stage,
    +-		int baselen, const char *filename, unsigned mode,
     -		void *context)
     +			       int baselen, const char *filename,
     +			       unsigned mode,
    -+			       int stage,
     +			       void *context)
      {
      	static struct strbuf path = STRBUF_INIT;
    @@ archive.c: static int write_directory(struct archiver_context *c)
     +					void *context)
      {
      	struct archiver_context *c = context;
    - 	int stage = 0;
    + 
     @@ archive.c: struct path_exists_context {
      };
      
    @@ tree.h: struct tree *parse_tree_indirect(const struct object_id *oid);
     +			      void *);
      
      int read_tree_at(struct repository *r,
    - 		 struct tree *tree,
    + 		 struct tree *tree, struct strbuf *base,
12:  0ce197950b0 <  -:  ----------- tree.h users: format argument lists in archive.c
13:  051c9f32ac6 <  -:  ----------- archive: get rid of 'stage' parameter
14:  bc73994b4c7 = 11:  152c6d88542 tree.h API: make read_tree_fn_t take an "enum object_type"
15:  e2b0964228f = 12:  1c2f65cb674 tree-walk.h users: migrate "p->mode &&" pattern
16:  29dbc4292e0 = 13:  163922d427c tree-walk.h users: refactor chained "mode" if/else into switch
17:  ada6d051769 = 14:  21df7c668be tree-walk.h users: migrate miscellaneous "mode" to "object_type"
18:  01860daa556 = 15:  592fecb7abc merge-tree tests: test for the mode comparison in same_entry()
19:  e4be48fb50f = 16:  092472f3c8d merge-ort: correct reference to test in 62fdec17a11
20:  189d2550fb8 = 17:  685da1abbdc fsck.c: switch on "object_type" in fsck_walk_tree()
21:  3b7b12e6f79 = 18:  4babecb7855 tree-walk.h users: use temporary variable(s) for "mode"
22:  6c3a07a3279 = 19:  7251654dd52 tree-walk.h API: formatting changes for subsequent commit
23:  879eb3da2a4 = 20:  9e521a3cbf2 tree-walk.h API: rename get_tree_entry() to get_tree_entry_mode()
24:  d2fa360ab9e = 21:  40f37e99cd9 match-trees: use "tmp" for mode in shift_tree_by()
25:  cc50cfcf517 = 22:  7f699bf2d5c tree-walk.h API: add get_tree_entry_type()
26:  f642a35482b = 23:  7ab7576cb16 tree-walk.h API: document and format tree_entry_extract()
27:  a0bcb59fa57 = 24:  a1bd81d64aa tree-entry.h API: rename tree_entry_extract() to tree_entry_extract_mode()
28:  c7d4ba77340 = 25:  ce7c19ad39c tree-walk.h API: add a tree_entry_extract_all() function
29:  1d5421d67af = 26:  95eec961be8 tree-walk.h API: add get_tree_entry_all()
30:  a3e1063ac45 = 27:  a2a34fd3e2d tree-walk.h API: add a get_tree_entry_path() function
31:  da3dd6dd532 = 28:  81da5490221 blame: emit a better error on 'git blame directory'
32:  80e5cb0b30c = 29:  4d51da4ea39 tree-walk.h API: add a tree_entry_extract_type() function
-- 
2.31.0.286.gc175f2cb894

