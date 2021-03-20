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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1469C433C1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BA461935
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCTWij (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 18:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCTWiN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 18:38:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E3C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t4so2324991wrn.11
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhIc0EhyJAsFDM1nPB9+sB9jpI0XA+2R2xHdquJlLgw=;
        b=r6A7rguQ5qcrIdnTO4dSGPgHQ4HvV1m4vjIR4iRgfIZ4ckDb3PUpMurqU+D82wOXeY
         K9sHQzfTqRZGjEPumhR/QNzeB++Hysg2K9JXemJuRAhMcbcg0G4QGcBKuvQF9VDS3IcK
         F849hpA5tuA1wBrq16aRa1mVLjhv8blJgFQOGSOBKZJ2NRzyjwPv87sWcaA4HefIlejW
         Yjmfixu8Q3dMkJUgCUcpvxI1VFHbxKe3pMSGwItpu8Zx8+jTyh1t9q/9vpMnRcNHPDMG
         KwJExQ5NZn6z+LWu49Ro3OfvPDBwVLWpHXfwLcXxzAD8eqMpwJ2xfpxSyHKs2O4WgDXC
         l27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhIc0EhyJAsFDM1nPB9+sB9jpI0XA+2R2xHdquJlLgw=;
        b=k7RrCAT+uNNkSbm6kkqm0jhXTIYZAP6gcHPknG5Vrn67CT8wwvmCBQxZUJ9csYlvm2
         zkDF3i975PIdaGp6AwGp6xRWffx5bBJssEm5hu185B/MBhxPob+lsD57SzesnBYG8pHi
         w0F+zkfNwVeRy/2qppmjiFGMFs1l7lVeSXH7iMI77SH9ONbB+lLx08zpQG3aCSVcX2xi
         Zgv70Cb2UdlJvk8xgrf5xkHxnXG9JmKrnfGB5+HcgDpwK6U2KNXYrqgKTxn/UttiBa1q
         IsfT3FEh1CwvNuK4/Jr2/IIFZ+nSCTCpI95t53RN4umWFph0IgSnZSpjQoY/0uXt3h2U
         dwUg==
X-Gm-Message-State: AOAM531B5gErkXMjDvg/mreicyBZeMeDz/rc40sNiTTg+BtowKQ7GSwC
        qT9z0nRz/aS6E7CwOdm91yowZNAk5BE=
X-Google-Smtp-Source: ABdhPJywa1HzCmg3zHlrazky8OYOJ3CXS3m80pU7J8w+tHyE4RCkg0LcLWrCTHbhxIDlU3U2o8RV7A==
X-Received: by 2002:adf:a302:: with SMTP id c2mr11080311wrb.212.1616279891386;
        Sat, 20 Mar 2021 15:38:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v2sm21472697wmj.1.2021.03.20.15.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:38:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/8] read_tree() and read_tree_recursive() refactoring
Date:   Sat, 20 Mar 2021 23:37:43 +0100
Message-Id: <cover.1616279653.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.286.gc175f2cb894
In-Reply-To: <xmqqpmzxy939.fsf@gitster.g>
References: <xmqqpmzxy939.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A refactoring of v4[1], not quite as as suggested by Junio in[2], but
which I think makes this whole thing less confusing and more
straightforward.

I now start by entirely getting rid of the meaningful passing of the
"stage" variable before removing it and the path variable entirely in
8/8, but before that in 7/8 I've introduced the read_tree_at()
function Derrick Stolee needs for his in-flight series.

1. http://lore.kernel.org/git/20210316155244.28328-1-avarab@gmail.com
2. https://lore.kernel.org/git/xmqqpmzxy939.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (8):
  show tests: add test for "git show <tree>"
  ls-files tests: add meaningful --with-tree tests
  tree.c API: move read_tree() into builtin/ls-files.c
  ls-files: don't needlessly pass around stage variable
  ls-files: refactor away read_tree()
  archive: stop passing "stage" through read_tree_recursive()
  tree.h API: expose read_tree_1() as read_tree_at()
  tree.h API: simplify read_tree_recursive() signature

 archive.c                     |  30 ++++-----
 builtin/checkout.c            |   8 +--
 builtin/log.c                 |   8 +--
 builtin/ls-files.c            |  75 ++++++++++++++++++++-
 builtin/ls-tree.c             |   6 +-
 cache.h                       |   2 +-
 merge-recursive.c             |   6 +-
 t/t3060-ls-files-with-tree.sh |  41 ++++++++++++
 t/t7007-show.sh               |  39 +++++++++++
 tree.c                        | 119 ++++------------------------------
 tree.h                        |  18 ++---
 11 files changed, 205 insertions(+), 147 deletions(-)

Range-diff:
 8:  8a6bebde234 !  1:  c307eb53331 show tests: add test for "git show <tree>"
    @@ Commit message
     
         Let's add this common mode of operation to the "show" tests
         themselves. It's more obvious, and the tests in
    -    t7701-repack-unpack-unreachable.sh happily parse if we start buggily
    +    t7701-repack-unpack-unreachable.sh happily pass if we start buggily
         emitting trees recursively.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
 1:  b338f2c01a4 =  2:  f37d7705cf0 ls-files tests: add meaningful --with-tree tests
 2:  4578b83944c =  3:  6291d8a1b5e tree.c API: move read_tree() into builtin/ls-files.c
 3:  33656ff63b8 !  4:  466b518e915 ls-files: don't needlessly pass around stage variable
    @@ Commit message
         Now that read_tree() has been moved to ls-files.c we can get rid of
         the stage != 1 case that'll never happen.
     
    +    Let's not use read_tree_recursive() as a pass-through to pass "stage =
    +    1" either. For now we'll pass an unused "stage = 0" for consistency
    +    with other read_tree_recursive() callers, that argument will be
    +    removed in a follow-up commit.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/ls-files.c ##
    +@@ builtin/ls-files.c: static int read_one_entry_opt(struct index_state *istate,
    + 			      const struct object_id *oid,
    + 			      const char *base, int baselen,
    + 			      const char *pathname,
    +-			      unsigned mode, int stage, int opt)
    ++			      unsigned mode, int opt)
    + {
    + 	int len;
    + 	struct cache_entry *ce;
    +@@ builtin/ls-files.c: static int read_one_entry_opt(struct index_state *istate,
    + 	ce = make_empty_cache_entry(istate, baselen + len);
    + 
    + 	ce->ce_mode = create_ce_mode(mode);
    +-	ce->ce_flags = create_ce_flags(stage);
    ++	ce->ce_flags = create_ce_flags(1);
    + 	ce->ce_namelen = baselen + len;
    + 	memcpy(ce->name, base, baselen);
    + 	memcpy(ce->name + baselen, pathname, len+1);
    +@@ builtin/ls-files.c: static int read_one_entry(const struct object_id *oid, struct strbuf *base,
    + {
    + 	struct index_state *istate = context;
    + 	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
    +-				  mode, stage,
    ++				  mode,
    + 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
    + }
    + 
     @@ builtin/ls-files.c: static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
    + {
    + 	struct index_state *istate = context;
    + 	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
    +-				  mode, stage,
    ++				  mode,
    + 				  ADD_CACHE_JUST_APPEND);
      }
      
      
    @@ builtin/ls-files.c: static int read_tree(struct repository *r, struct tree *tree
      	if (!fn)
      		fn = read_one_entry_quick;
     -	err = read_tree_recursive(r, tree, "", 0, stage, match, fn, istate);
    -+	err = read_tree_recursive(r, tree, "", 0, 1, match, fn, istate);
    ++	err = read_tree_recursive(r, tree, "", 0, 0, match, fn, istate);
      	if (fn == read_one_entry || err)
      		return err;
      
 4:  1c96d5d3611 !  5:  30c3abfe9b9 ls-files: refactor away read_tree()
    @@ builtin/ls-files.c: static int get_common_prefix_len(const char *common_prefix)
     -			      const char *base, int baselen,
     +			      struct strbuf *base,
      			      const char *pathname,
    - 			      unsigned mode, int stage, int opt)
    + 			      unsigned mode, int opt)
      {
     @@ builtin/ls-files.c: static int read_one_entry_opt(struct index_state *istate,
      		return READ_TREE_RECURSIVE;
    @@ builtin/ls-files.c: static int read_one_entry_opt(struct index_state *istate,
     +	ce = make_empty_cache_entry(istate, base->len + len);
      
      	ce->ce_mode = create_ce_mode(mode);
    - 	ce->ce_flags = create_ce_flags(stage);
    + 	ce->ce_flags = create_ce_flags(1);
     -	ce->ce_namelen = baselen + len;
     -	memcpy(ce->name, base, baselen);
     -	memcpy(ce->name + baselen, pathname, len+1);
    @@ builtin/ls-files.c: static int read_one_entry(const struct object_id *oid, struc
      	struct index_state *istate = context;
     -	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
     +	return read_one_entry_opt(istate, oid, base, pathname,
    - 				  mode, stage,
    + 				  mode,
      				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
      }
     @@ builtin/ls-files.c: static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
    @@ builtin/ls-files.c: static int read_one_entry_quick(const struct object_id *oid,
      {
      	struct index_state *istate = context;
     -	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
    -+	return read_one_entry_opt(istate, oid, base, pathname,
    - 				  mode, stage,
    - 				  ADD_CACHE_JUST_APPEND);
    - }
    - 
    +-				  mode,
    +-				  ADD_CACHE_JUST_APPEND);
    +-}
    +-
     -
     -static int read_tree(struct repository *r, struct tree *tree,
     -		     struct pathspec *match, struct index_state *istate)
    @@ builtin/ls-files.c: static int read_one_entry_quick(const struct object_id *oid,
     -
     -	if (!fn)
     -		fn = read_one_entry_quick;
    --	err = read_tree_recursive(r, tree, "", 0, 1, match, fn, istate);
    +-	err = read_tree_recursive(r, tree, "", 0, 0, match, fn, istate);
     -	if (fn == read_one_entry || err)
     -		return err;
     -
    @@ builtin/ls-files.c: static int read_one_entry_quick(const struct object_id *oid,
     -	cache_tree_free(&istate->cache_tree);
     -	QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
     -	return 0;
    --}
    --
    ++	return read_one_entry_opt(istate, oid, base, pathname,
    ++				  mode, ADD_CACHE_JUST_APPEND);
    + }
    + 
      /*
    -  * Read the tree specified with --with-tree option
    -  * (typically, HEAD) into stage #1 and then
     @@ builtin/ls-files.c: void overlay_tree_on_index(struct index_state *istate,
      	struct pathspec pathspec;
      	struct cache_entry *last_stage0 = NULL;
 5:  367cb99224b <  -:  ----------- tree.h API: remove support for starting at prefix != ""
 6:  38e36780e22 <  -:  ----------- tree.h API: remove "stage" parameter from read_tree_recursive()
 7:  859902ffd83 <  -:  ----------- tree.h API: rename read_tree_recursive() to read_tree()
 -:  ----------- >  6:  02c42be9249 archive: stop passing "stage" through read_tree_recursive()
 9:  29996dd82bc !  7:  d55e8d4042b tree.h API: expose read_tree_1() as read_tree_at()
    @@ Metadata
      ## Commit message ##
         tree.h API: expose read_tree_1() as read_tree_at()
     
    -    Rename the static read_tree_1() function to read_tree_at(). This will
    -    allow for the old read_tree_recursive() mode of operation where we
    -    start at a given path instead of "".
    +    Rename the static read_tree_1() function to read_tree_at(). This
    +    function works just like read_tree_recursive(), except you provide
    +    your own strbuf.
     
    -    See [1] for the discussion of one such future in-tree user, unlike the
    -    old read_tree_recursive() this function takes a strbuf. Since that's
    -    what read_tree_1() used internally this should allow us to avoid
    -    casting and/or reallocations in the future.
    +    This step doesn't make much sense now, but in follow-up commits I'll
    +    remove the base/baselen/stage arguments to read_tree_recursive(). At
    +    that point an anticipated in-tree user[1] for the old
    +    read_tree_recursive() couldn't provide a path to start the
    +    traversal.
     
    -    1. https://lore.kernel.org/git/xmqqft106sok.fsf@gitster.g/#t
    +    Let's give them a function to do so with an API that makes more sense
    +    for them, by taking a strbuf we should be able to avoid more casting
    +    and/or reallocations in the future.
    +
    +    1. https://lore.kernel.org/git/xmqqft106sok.fsf@gitster.g
     
      ## tree.c ##
     @@
    @@ tree.c
      
     -static int read_tree_1(struct repository *r,
     -		       struct tree *tree, struct strbuf *base,
    --		       const struct pathspec *pathspec,
    +-		       int stage, const struct pathspec *pathspec,
     -		       read_tree_fn_t fn, void *context)
     +int read_tree_at(struct repository *r,
     +		 struct tree *tree, struct strbuf *base,
    ++		 int stage,
     +		 const struct pathspec *pathspec,
     +		 read_tree_fn_t fn, void *context)
      {
    @@ tree.c: static int read_tree_1(struct repository *r,
      		strbuf_add(base, entry.path, len);
      		strbuf_addch(base, '/');
     -		retval = read_tree_1(r, lookup_tree(r, &oid),
    --				     base, pathspec,
    +-				     base, stage, pathspec,
     -				     fn, context);
     +		retval = read_tree_at(r, lookup_tree(r, &oid),
    -+				      base, pathspec,
    ++				      base, stage, pathspec,
     +				      fn, context);
      		strbuf_setlen(base, oldlen);
      		if (retval)
      			return -1;
    -@@ tree.c: int read_tree(struct repository *r,
    - 	struct strbuf sb = STRBUF_INIT;
    +@@ tree.c: int read_tree_recursive(struct repository *r,
      	int ret;
      
    --	ret = read_tree_1(r, tree, &sb, pathspec, fn, context);
    -+	ret = read_tree_at(r, tree, &sb, pathspec, fn, context);
    + 	strbuf_add(&sb, base, baselen);
    +-	ret = read_tree_1(r, tree, &sb, stage, pathspec, fn, context);
    ++	ret = read_tree_at(r, tree, &sb, stage, pathspec, fn, context);
      	strbuf_release(&sb);
      	return ret;
      }
    @@ tree.c: int read_tree(struct repository *r,
      ## tree.h ##
     @@ tree.h: int cmp_cache_name_compare(const void *a_, const void *b_);
      #define READ_TREE_RECURSIVE 1
    - typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
    + typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, int, void *);
      
     +int read_tree_at(struct repository *r,
    -+		 struct tree *tree,
    -+		 struct strbuf *at,
    ++		 struct tree *tree, struct strbuf *base,
    ++		 int stage,
     +		 const struct pathspec *pathspec,
     +		 read_tree_fn_t fn, void *context);
     +
    - int read_tree(struct repository *r,
    - 	      struct tree *tree,
    - 	      const struct pathspec *pathspec,
    + int read_tree_recursive(struct repository *r,
    + 			struct tree *tree,
    + 			const char *base, int baselen,
 -:  ----------- >  8:  fa157d8baee tree.h API: simplify read_tree_recursive() signature
-- 
2.31.0.286.gc175f2cb894

