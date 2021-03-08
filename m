Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B43C43381
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 02:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE0F65163
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 02:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhCHCWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 21:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhCHCWD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 21:22:03 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1241C06175F
        for <git@vger.kernel.org>; Sun,  7 Mar 2021 18:22:02 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mj10so17191705ejb.5
        for <git@vger.kernel.org>; Sun, 07 Mar 2021 18:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tCS47lur2raK8ik8JCtuISISy0fVXLOUqyt8EnItTHo=;
        b=hUoFmsJ1kFlCaEBATp+hCDsuHtGmz9cYl7VFk871MwBmoacvkIr+BxXZIrRrkKPQ1i
         r1FNpEm5Htq2Im2zefE1FS+3JNJ83/kAM44OnBoBx5oIo4lR9lVvQiKN2txyQJ5KV65i
         6qkJpFMpCF1iOnFnZZgZWu5dTHZFTqLtWVZX7kuon7cbZhCXQWSqK0z9kpaHdkNpDgw6
         krmV9ARcOLfa4rQr4J/ec8Y45sppeTAA/dkssRBHgnKGeU7JYofs9o4pQiPWywqqJyt+
         k6UIal5SAEJI5uNwStgCEbMrVa5RuHTov0EizjuUXMbabSafYiAS9FuMJO9sKtstSoQM
         wd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCS47lur2raK8ik8JCtuISISy0fVXLOUqyt8EnItTHo=;
        b=dzVre9g4NEDOV/mw2uXI6Y3lfVW7pinpb1TTLkZHEa8Dt4XvrmvZFJPtFIPaYIsZud
         oaL1SPZP6krLCBYye50/JwuUce2g+VHxqCsPEHUkU5wHp9FJW0Thg5bPF8NizJFhBJzW
         F/oTgChXcPdqNpHLCwXwx7y+mrBVSSXxMbxGPbSIT5BnxzsWWnKnwBeTIwZQG4NXrcWG
         KkYOgr43hm/r0oDfhEkn+QPuQj4jFkAUBfKKEVR/nXu+KXUJWRvP48TCqh8UWUcGyUFz
         wMCEC91eix8aVFlfjIIA/pkT0UBV64Az4dxB01kkV3PQ3wPKE5RklQm9Ii4KZFCRIorz
         l4kg==
X-Gm-Message-State: AOAM532Ef7cPFvfT62ie/M/X3iDwbIjoi4mJz0PivkLi1tdO/AsxLojt
        23AMhq8Jt7ic52mA4LhHa0ygzPm1clb2aQ==
X-Google-Smtp-Source: ABdhPJwcj/g3+n/jhHXLSm9kTJAHenXYRIQ3SE0Z728TTjwd2ddbVgVT2EMfUtMH28kIuf8ycg3CBA==
X-Received: by 2002:a17:906:405b:: with SMTP id y27mr4553163ejj.332.1615170120311;
        Sun, 07 Mar 2021 18:22:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dg26sm6264995edb.88.2021.03.07.18.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 18:21:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] Move the read_tree() function to its only user
Date:   Mon,  8 Mar 2021 03:21:32 +0100
Message-Id: <20210308022138.28166-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210306193458.20633-1-avarab@gmail.com>
References: <20210306193458.20633-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v1 of this series over-removed code supporting the "ls-files
--with-tree=*" parameter. In v2 there's no change to its behavior,
just refactoring away of read_tree() from the tree.c API and the
cleanup of read_tree_recursive(). Thanks to Elijah for spotting that.

I've added a test at the start of this series that would have caught
that regression in v1 (and more).

1. https://lore.kernel.org/git/CABPp-BF982muRS4GO=zYegvetQyrPMwaEM3uEBvcbPRP=krfmQ@mail.gmail.com/

Ævar Arnfjörð Bjarmason (6):
  ls-files tests: add meaningful --with-tree tests
  tree.c API: move read_tree() into builtin/ls-files.c
  ls-files: don't needlessly pass around stage variable
  ls-files: refactor away read_tree()
  tree.h API: remove support for starting at prefix != ""
  tree.h API: remove "stage" parameter from read_tree_recursive()

 archive.c                     |  13 +++--
 builtin/checkout.c            |   4 +-
 builtin/log.c                 |   6 +-
 builtin/ls-files.c            |  76 ++++++++++++++++++++++++-
 builtin/ls-tree.c             |   4 +-
 merge-recursive.c             |   4 +-
 t/t3060-ls-files-with-tree.sh |  41 ++++++++++++++
 tree.c                        | 101 ++--------------------------------
 tree.h                        |  10 +---
 9 files changed, 139 insertions(+), 120 deletions(-)

Range-diff:
-:  ----------- > 1:  6416da0dee2 ls-files tests: add meaningful --with-tree tests
1:  020534164d3 ! 2:  765001b44cd tree.c API: move read_tree() into builtin/ls-files.c
    @@ tree.c: int cmp_cache_name_compare(const void *a_, const void *b_)
     
      ## tree.h ##
     @@ tree.h: int read_tree_recursive(struct repository *r,
    + 			const char *base, int baselen,
      			int stage, const struct pathspec *pathspec,
      			read_tree_fn_t fn, void *context);
    - 
    +-
     -int read_tree(struct repository *r, struct tree *tree,
     -	      int stage, struct pathspec *pathspec,
     -	      struct index_state *istate);
2:  6aa6ba2fbb5 = 3:  a71ffba7d04 ls-files: don't needlessly pass around stage variable
3:  4f27e5d2970 ! 4:  e78d1810b89 ls-files: remove cache juggling + sorting
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    ls-files: remove cache juggling + sorting
    +    ls-files: refactor away read_tree()
     
    -    Remove the "ce_stage(ce) == 1" and "Sort the cache entry" code from
    -    read_tree(), which allows us to remove the function entirely and move
    -    over to read_tree_recursive().
    +    Refactor away the read_tree() function into its only user,
    +    overlay_tree_on_index().
     
    -    I don't think the "Sort the cached entry" code was needed here, see
    -    af3785dc5a7 (Optimize "diff --cached" performance., 2007-08-09) for
    -    the use-case it was intended for. The only user of this code is
    -    "ls-files --with-tree", which isn't the sort of use-case that needs to
    -    care about "ce_stage(ce) != 0" or sorting tree entries.
    +    First, change read_one_entry_opt() to use the strbuf parameter
    +    read_tree_recursive() passes down in place. This finishes up a partial
    +    refactoring started in 6a0b0b6de99 (tree.c: update read_tree_recursive
    +    callback to pass strbuf as base, 2014-11-30).
    +
    +    Moving the rest into overlay_tree_on_index() makes this index juggling
    +    we're doing easier to read.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/ls-files.c ##
    -@@
    - #include "dir.h"
    - #include "builtin.h"
    - #include "tree.h"
    --#include "cache-tree.h"
    - #include "parse-options.h"
    - #include "resolve-undo.h"
    - #include "string-list.h"
     @@ builtin/ls-files.c: static int get_common_prefix_len(const char *common_prefix)
    - 	return common_prefix_len;
    - }
      
    --static int read_one_entry_opt(struct index_state *istate,
    --			      const struct object_id *oid,
    + static int read_one_entry_opt(struct index_state *istate,
    + 			      const struct object_id *oid,
     -			      const char *base, int baselen,
    --			      const char *pathname,
    --			      unsigned mode, int stage, int opt)
    -+static int read_one_entry_quick(const struct object_id *oid,
    -+				struct strbuf *basebuf,
    -+				const char *pathname,
    -+				unsigned mode,
    -+				int stage, void *context)
    ++			      struct strbuf *base,
    + 			      const char *pathname,
    + 			      unsigned mode, int stage, int opt)
      {
    -+	struct index_state *istate = context;
    -+	const char *base = basebuf->buf;
    -+	const int baselen = basebuf->len;
    - 	int len;
    - 	struct cache_entry *ce;
    - 
     @@ builtin/ls-files.c: static int read_one_entry_opt(struct index_state *istate,
    - 	memcpy(ce->name, base, baselen);
    - 	memcpy(ce->name + baselen, pathname, len+1);
    + 		return READ_TREE_RECURSIVE;
    + 
    + 	len = strlen(pathname);
    +-	ce = make_empty_cache_entry(istate, baselen + len);
    ++	ce = make_empty_cache_entry(istate, base->len + len);
    + 
    + 	ce->ce_mode = create_ce_mode(mode);
    + 	ce->ce_flags = create_ce_flags(stage);
    +-	ce->ce_namelen = baselen + len;
    +-	memcpy(ce->name, base, baselen);
    +-	memcpy(ce->name + baselen, pathname, len+1);
    ++	ce->ce_namelen = base->len + len;
    ++	memcpy(ce->name, base->buf, base->len);
    ++	memcpy(ce->name + base->len, pathname, len+1);
      	oidcpy(&ce->oid, oid);
    --	return add_index_entry(istate, ce, opt);
    --}
    --
    --static int read_one_entry(const struct object_id *oid, struct strbuf *base,
    --			  const char *pathname, unsigned mode, int stage,
    --			  void *context)
    --{
    --	struct index_state *istate = context;
    + 	return add_index_entry(istate, ce, opt);
    + }
    +@@ builtin/ls-files.c: static int read_one_entry(const struct object_id *oid, struct strbuf *base,
    + 			  void *context)
    + {
    + 	struct index_state *istate = context;
     -	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
    --				  mode, stage,
    --				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
    --}
    --
    --/*
    -- * This is used when the caller knows there is no existing entries at
    -- * the stage that will conflict with the entry being added.
    -- */
    --static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
    --				const char *pathname, unsigned mode, int stage,
    --				void *context)
    --{
    --	struct index_state *istate = context;
    ++	return read_one_entry_opt(istate, oid, base, pathname,
    + 				  mode, stage,
    + 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
    + }
    +@@ builtin/ls-files.c: static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
    + 				void *context)
    + {
    + 	struct index_state *istate = context;
     -	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
    --				  mode, stage,
    --				  ADD_CACHE_JUST_APPEND);
    --}
    --
    ++	return read_one_entry_opt(istate, oid, base, pathname,
    + 				  mode, stage,
    + 				  ADD_CACHE_JUST_APPEND);
    + }
    + 
     -
     -static int read_tree(struct repository *r, struct tree *tree,
     -		     struct pathspec *match, struct index_state *istate)
    @@ builtin/ls-files.c: static int read_one_entry_opt(struct index_state *istate,
     -	cache_tree_free(&istate->cache_tree);
     -	QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
     -	return 0;
    -+	return add_index_entry(istate, ce, ADD_CACHE_JUST_APPEND);
    - }
    - 
    +-}
    +-
      /*
    +  * Read the tree specified with --with-tree option
    +  * (typically, HEAD) into stage #1 and then
    +@@ builtin/ls-files.c: void overlay_tree_on_index(struct index_state *istate,
    + 	struct pathspec pathspec;
    + 	struct cache_entry *last_stage0 = NULL;
    + 	int i;
    ++	read_tree_fn_t fn = NULL;
    ++	int err;
    + 
    + 	if (get_oid(tree_name, &oid))
    + 		die("tree-ish %s not found.", tree_name);
     @@ builtin/ls-files.c: void overlay_tree_on_index(struct index_state *istate,
      			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
      	} else
      		memset(&pathspec, 0, sizeof(pathspec));
     -	if (read_tree(the_repository, tree, &pathspec, istate))
    -+	if (read_tree_recursive(the_repository, tree, "", 0, 1,
    -+				&pathspec, read_one_entry_quick, istate))
    ++
    ++	/*
    ++	 * See if we have cache entry at the stage.  If so,
    ++	 * do it the original slow way, otherwise, append and then
    ++	 * sort at the end.
    ++	 */
    ++	for (i = 0; !fn && i < istate->cache_nr; i++) {
    ++		const struct cache_entry *ce = istate->cache[i];
    ++		if (ce_stage(ce) == 1)
    ++			fn = read_one_entry;
    ++	}
    ++
    ++	if (!fn)
    ++		fn = read_one_entry_quick;
    ++	err = read_tree_recursive(the_repository, tree, "", 0, 1, &pathspec, fn, istate);
    ++	if (err)
      		die("unable to read tree entries %s", tree_name);
      
    ++	/*
    ++	 * Sort the cache entry -- we need to nuke the cache tree, though.
    ++	 */
    ++	if (fn == read_one_entry_quick) {
    ++		cache_tree_free(&istate->cache_tree);
    ++		QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
    ++	}
    ++
      	for (i = 0; i < istate->cache_nr; i++) {
    + 		struct cache_entry *ce = istate->cache[i];
    + 		switch (ce_stage(ce)) {
4:  33810d3c10c < -:  ----------- merge-ort: move cmp_cache_name_compare() from tree.c
5:  fb10246b85b < -:  ----------- ls-files: refactor read_one_entry_quick() to use a strbuf
6:  0c065615aec ! 5:  05eecdd7519 tree.h API: remove support for starting at prefix != ""
    @@ Metadata
      ## Commit message ##
         tree.h API: remove support for starting at prefix != ""
     
    -    Every caller or the read_tree_recursive() function hardcoded a
    +    Every caller of the read_tree_recursive() function hardcoded a
         starting point of "" in the tree. So let's simply remove that
         parameter.
     
    -    It might be useful in the future to get this functionality back,
    -    there's no reason we won't have a read_tree_recursive() use-case that
    -    would want to start in a subdirectory.
    +    The last function to call read_tree_recursive() with a non-"" path was
    +    read_tree_recursive() itself, but that was changed in
    +    ffd31f661d5 (Reimplement read_tree_recursive() using
    +    tree_entry_interesting(), 2011-03-25).
     
    -    But if and when that happens we can just add something like a
    -    read_tree_recursive_subdir() and have both read_tree_recursive() and
    -    that function be a thin wrapper for read_tree_1().
    +    If in the future we need to support recursively reading trees without
    +    starting at the root we can easily add a read_tree_recursive_subdir(),
    +    and make that function a thin wrapper for read_tree_1().
     
         In the meantime there's no reason to keep around what amounts to dead
    -    code just in case we need it in the future.
    +    code, just in case we need it in the future.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
     
      ## builtin/ls-files.c ##
     @@ builtin/ls-files.c: void overlay_tree_on_index(struct index_state *istate,
    - 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
    - 	} else
    - 		memset(&pathspec, 0, sizeof(pathspec));
    --	if (read_tree_recursive(the_repository, tree, "", 0, 1,
    -+	if (read_tree_recursive(the_repository, tree, 1,
    - 				&pathspec, read_one_entry_quick, istate))
    + 
    + 	if (!fn)
    + 		fn = read_one_entry_quick;
    +-	err = read_tree_recursive(the_repository, tree, "", 0, 1, &pathspec, fn, istate);
    ++	err = read_tree_recursive(the_repository, tree, 1, &pathspec, fn, istate);
    + 	if (err)
      		die("unable to read tree entries %s", tree_name);
      
     
    @@ tree.h: typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *,
     -			const char *base, int baselen,
      			int stage, const struct pathspec *pathspec,
      			read_tree_fn_t fn, void *context);
    - 
    + #endif /* TREE_H */
7:  9685c7c5c50 ! 6:  fcecc82e1c8 tree.h API: remove "stage" parameter from read_tree_recursive()
    @@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
      			break;
     
      ## builtin/ls-files.c ##
    -@@ builtin/ls-files.c: static int read_one_entry_quick(const struct object_id *oid,
    - 				struct strbuf *base,
    - 				const char *pathname,
    - 				unsigned mode,
    --				int stage, void *context)
    -+				void *context)
    +@@ builtin/ls-files.c: static int read_one_entry_opt(struct index_state *istate,
    + 			      const struct object_id *oid,
    + 			      struct strbuf *base,
    + 			      const char *pathname,
    +-			      unsigned mode, int stage, int opt)
    ++			      unsigned mode, int opt)
      {
    - 	struct index_state *istate = context;
      	int len;
    -@@ builtin/ls-files.c: static int read_one_entry_quick(const struct object_id *oid,
    + 	struct cache_entry *ce;
    +@@ builtin/ls-files.c: static int read_one_entry_opt(struct index_state *istate,
      	ce = make_empty_cache_entry(istate, base->len + len);
      
      	ce->ce_mode = create_ce_mode(mode);
    @@ builtin/ls-files.c: static int read_one_entry_quick(const struct object_id *oid,
      	ce->ce_namelen = base->len + len;
      	memcpy(ce->name, base->buf, base->len);
      	memcpy(ce->name + base->len, pathname, len+1);
    +@@ builtin/ls-files.c: static int read_one_entry_opt(struct index_state *istate,
    + }
    + 
    + static int read_one_entry(const struct object_id *oid, struct strbuf *base,
    +-			  const char *pathname, unsigned mode, int stage,
    ++			  const char *pathname, unsigned mode,
    + 			  void *context)
    + {
    + 	struct index_state *istate = context;
    + 	return read_one_entry_opt(istate, oid, base, pathname,
    +-				  mode, stage,
    ++				  mode,
    + 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
    + }
    + 
    +@@ builtin/ls-files.c: static int read_one_entry(const struct object_id *oid, struct strbuf *base,
    +  * the stage that will conflict with the entry being added.
    +  */
    + static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
    +-				const char *pathname, unsigned mode, int stage,
    ++				const char *pathname, unsigned mode,
    + 				void *context)
    + {
    + 	struct index_state *istate = context;
    + 	return read_one_entry_opt(istate, oid, base, pathname,
    +-				  mode, stage,
    ++				  mode,
    + 				  ADD_CACHE_JUST_APPEND);
    + }
    + 
     @@ builtin/ls-files.c: void overlay_tree_on_index(struct index_state *istate,
    - 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
    - 	} else
    - 		memset(&pathspec, 0, sizeof(pathspec));
    --	if (read_tree_recursive(the_repository, tree, 1,
    -+	if (read_tree_recursive(the_repository, tree,
    - 				&pathspec, read_one_entry_quick, istate))
    + 
    + 	if (!fn)
    + 		fn = read_one_entry_quick;
    +-	err = read_tree_recursive(the_repository, tree, 1, &pathspec, fn, istate);
    ++	err = read_tree_recursive(the_repository, tree, &pathspec, fn, istate);
    + 	if (err)
      		die("unable to read tree entries %s", tree_name);
      
     
    @@ tree.c: static int read_tree_1(struct repository *r,
      }
     
      ## tree.h ##
    -@@ tree.h: void free_tree_buffer(struct tree *tree);
    - struct tree *parse_tree_indirect(const struct object_id *oid);
    +@@ tree.h: struct tree *parse_tree_indirect(const struct object_id *oid);
    + int cmp_cache_name_compare(const void *a_, const void *b_);
      
      #define READ_TREE_RECURSIVE 1
     -typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, int, void *);
    @@ tree.h: void free_tree_buffer(struct tree *tree);
     -			int stage, const struct pathspec *pathspec,
     +			const struct pathspec *pathspec,
      			read_tree_fn_t fn, void *context);
    - 
      #endif /* TREE_H */
-- 
2.31.0.rc0.126.g04f22c5b82

