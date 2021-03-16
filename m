Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA44FC43332
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9777F65109
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbhCPPx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhCPPwx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:52:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E4C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so1754194wmj.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ug2zKxYEtldeotnzyh1Ut66jcpx/c0OJQkZYVtkBABE=;
        b=RNbCVRCNB+N2rCcwmv1UTiCAVtqV3E5+FQwlNTr/rHYcmwvvq4ukXvEB57JGCu3k0n
         3yjmFbb4dOvEapcb4Mg5SBf/iUROsIWYG0jsepGkHu9LVnlV9kjFin60xbPKMg915har
         8Ilfla/BXZk/7MfK8F6suljzDhvWgJMGrsR5JkA5LQXYukIPtbzoWzmuFY5gHQ6hRj8J
         Zc73A7b6EGfBOKHGTBTMs6wvB1FS2RNzAIRWRtXAljQS1kzeWH2b3lrp3jm6XE9NzFLI
         MH+pZeoaJrY3RvCVcCxU3NWiQt2iK8HAZ0n+p9m48+EZW723MGVKyGvug0/INaDqOCLX
         DVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ug2zKxYEtldeotnzyh1Ut66jcpx/c0OJQkZYVtkBABE=;
        b=HSN4nWUGrxlVofCQmP36YhXeIeLCwFIcDdavzFYIj2zLjtVpvRITitGnVZiwrME1xW
         BjLbR/a079HyRLqTOdGU7YD7FiIelNN6qAeToPK+LgG+sTnAqlKvaRzoWuQOOzQTAyDL
         npp5c5OmGxgvsUH1X+K2KMIjEygb+uJZUioj18qSRmh1LoihPM5M6q4MUcAlFPfSFlLm
         dw6O3t8Dd4u0dQ1rzza+aOymrqr6/tkZKc3doOjbnXMlVuyL4BYOpY2/v0hyztn95OlI
         qrSTNQUU+pa+e/dcRMG2MYpDdzOpuQetwbnpRJ3w4nbFIVxdwW6vs26o602cSTG79+kp
         4ucA==
X-Gm-Message-State: AOAM533HXNHDOPl6A0e2njfOiSSYkCUDUvdpX+YR+eYl8zRKeckZP4yL
        p5xcGM74tG8R+s7cn5iEw0vZ0CIUgAtQdw==
X-Google-Smtp-Source: ABdhPJxWNEGdnq9sFIoRoZpPTA/524mz09F+MwU7smOabdAXX1L4F+2PM+4A5SrzEzbl6hZJyPjnCA==
X-Received: by 2002:a7b:c214:: with SMTP id x20mr290680wmi.186.1615909971034;
        Tue, 16 Mar 2021 08:52:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm22224228wro.53.2021.03.16.08.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:52:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/9] ls-files: refactor away read_tree()
Date:   Tue, 16 Mar 2021 16:52:39 +0100
Message-Id: <20210316155244.28328-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210315234344.28427-1-avarab@gmail.com>
References: <20210315234344.28427-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor away the read_tree() function into its only user,
overlay_tree_on_index().

First, change read_one_entry_opt() to use the strbuf parameter
read_tree_recursive() passes down in place. This finishes up a partial
refactoring started in 6a0b0b6de99 (tree.c: update read_tree_recursive
callback to pass strbuf as base, 2014-11-30).

Moving the rest into overlay_tree_on_index() makes this index juggling
we're doing easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c | 74 +++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 74d572a3e4..db53e2c8e6 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -423,7 +423,7 @@ static int get_common_prefix_len(const char *common_prefix)
 
 static int read_one_entry_opt(struct index_state *istate,
 			      const struct object_id *oid,
-			      const char *base, int baselen,
+			      struct strbuf *base,
 			      const char *pathname,
 			      unsigned mode, int stage, int opt)
 {
@@ -434,13 +434,13 @@ static int read_one_entry_opt(struct index_state *istate,
 		return READ_TREE_RECURSIVE;
 
 	len = strlen(pathname);
-	ce = make_empty_cache_entry(istate, baselen + len);
+	ce = make_empty_cache_entry(istate, base->len + len);
 
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(stage);
-	ce->ce_namelen = baselen + len;
-	memcpy(ce->name, base, baselen);
-	memcpy(ce->name + baselen, pathname, len+1);
+	ce->ce_namelen = base->len + len;
+	memcpy(ce->name, base->buf, base->len);
+	memcpy(ce->name + base->len, pathname, len+1);
 	oidcpy(&ce->oid, oid);
 	return add_index_entry(istate, ce, opt);
 }
@@ -450,7 +450,7 @@ static int read_one_entry(const struct object_id *oid, struct strbuf *base,
 			  void *context)
 {
 	struct index_state *istate = context;
-	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
+	return read_one_entry_opt(istate, oid, base, pathname,
 				  mode, stage,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
@@ -464,44 +464,11 @@ static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
 				void *context)
 {
 	struct index_state *istate = context;
-	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
+	return read_one_entry_opt(istate, oid, base, pathname,
 				  mode, stage,
 				  ADD_CACHE_JUST_APPEND);
 }
 
-
-static int read_tree(struct repository *r, struct tree *tree,
-		     struct pathspec *match, struct index_state *istate)
-{
-	read_tree_fn_t fn = NULL;
-	int i, err;
-
-
-	/*
-	 * See if we have cache entry at the stage.  If so,
-	 * do it the original slow way, otherwise, append and then
-	 * sort at the end.
-	 */
-	for (i = 0; !fn && i < istate->cache_nr; i++) {
-		const struct cache_entry *ce = istate->cache[i];
-		if (ce_stage(ce) == 1)
-			fn = read_one_entry;
-	}
-
-	if (!fn)
-		fn = read_one_entry_quick;
-	err = read_tree_recursive(r, tree, "", 0, 1, match, fn, istate);
-	if (fn == read_one_entry || err)
-		return err;
-
-	/*
-	 * Sort the cache entry -- we need to nuke the cache tree, though.
-	 */
-	cache_tree_free(&istate->cache_tree);
-	QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
-	return 0;
-}
-
 /*
  * Read the tree specified with --with-tree option
  * (typically, HEAD) into stage #1 and then
@@ -518,6 +485,8 @@ void overlay_tree_on_index(struct index_state *istate,
 	struct pathspec pathspec;
 	struct cache_entry *last_stage0 = NULL;
 	int i;
+	read_tree_fn_t fn = NULL;
+	int err;
 
 	if (get_oid(tree_name, &oid))
 		die("tree-ish %s not found.", tree_name);
@@ -540,9 +509,32 @@ void overlay_tree_on_index(struct index_state *istate,
 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
 		memset(&pathspec, 0, sizeof(pathspec));
-	if (read_tree(the_repository, tree, &pathspec, istate))
+
+	/*
+	 * See if we have cache entry at the stage.  If so,
+	 * do it the original slow way, otherwise, append and then
+	 * sort at the end.
+	 */
+	for (i = 0; !fn && i < istate->cache_nr; i++) {
+		const struct cache_entry *ce = istate->cache[i];
+		if (ce_stage(ce) == 1)
+			fn = read_one_entry;
+	}
+
+	if (!fn)
+		fn = read_one_entry_quick;
+	err = read_tree_recursive(the_repository, tree, "", 0, 1, &pathspec, fn, istate);
+	if (err)
 		die("unable to read tree entries %s", tree_name);
 
+	/*
+	 * Sort the cache entry -- we need to nuke the cache tree, though.
+	 */
+	if (fn == read_one_entry_quick) {
+		cache_tree_free(&istate->cache_tree);
+		QSORT(istate->cache, istate->cache_nr, cmp_cache_name_compare);
+	}
+
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		switch (ce_stage(ce)) {
-- 
2.31.0.256.gf0ddda3145

