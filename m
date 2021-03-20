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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19175C433E2
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA13861936
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhCTWij (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 18:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCTWiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 18:38:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5496C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x13so12749109wrs.9
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyxaje9ys6MkoQA9Rd/2Rk3Kaj6Cp/0VCbzPfuZSTj0=;
        b=cxa0TXBKcA4Uh627LEUEARtQsh8CaokYhWIJWYnlGVQ7hn1b6GI3/d6L9XUP8EAbzk
         yb3o9HKP2tewR/P7RmHTLX/cums2GH0ynG8j90VW/gueTZdu66kd3Q1ekgJdPePVGJPH
         Eu5itIKi595E1bL2T2BVA/Oi1dQHxOSjOZu8jPpytSX4cIotzvcMkZwXqZ36ydJ3qhML
         I5WFzmNeQnoyrvR2zsttcmPXpsKS1a5zmQUCVvgMWLBD9my1Y8dJV5QoxrShngesyPwH
         lOw7/L1qcZnXf7bRimdqAO+izsmwoxP9ykt2zXln+q/feNUaEeu0N7BqG+IBL/mwFHEx
         pkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyxaje9ys6MkoQA9Rd/2Rk3Kaj6Cp/0VCbzPfuZSTj0=;
        b=ATm73HnHcf39yc8zmwfzw17/b/bWGAgInyxEwo42Sb4Tl5AfG9JlFXLOMopjJnf+dW
         TFjxdNklS995WPa1XkdDs9ArgW/syNVY4z1OKxundsdU0hIE2aYCCwuuw0JeuLg8TbbL
         r2Y4TWvAbGkigbB8zeVe/tp0IgMdblLM03w8DaBx/r7ei0Z1g0Xpd/btvk3cLWvebpBd
         TD8wTVH+1Z477lVg0cpPdXwEOKeVSpdDzMiNOEOcFyR9scR8uGYW9zpWlE7rQ2IiKL3z
         pmc26s23hCUJ2Qky3GvJoit9Aq1YUf5BXLtjZ5CXf26kKPbfom1COiQL0hXb/N0C3Mgg
         U0LQ==
X-Gm-Message-State: AOAM533tii6B4wDFd6t3aNxE2iQcbrm4sfTzFaBy9eTAISzv1asyzte3
        bB374I2Dh/OXxBCn7SZxdjpflDlLDiVdcQ==
X-Google-Smtp-Source: ABdhPJwV8F1OqOrQAv1uj8juljuk4LmcV63J6Pdm9yMGWY4EIXRuKKwcml6fc8aGZLJQAL/Erwc1Vg==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr11308354wrm.413.1616279894259;
        Sat, 20 Mar 2021 15:38:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v2sm21472697wmj.1.2021.03.20.15.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:38:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 4/8] ls-files: don't needlessly pass around stage variable
Date:   Sat, 20 Mar 2021 23:37:47 +0100
Message-Id: <466b518e915c6cf5bc1f61610a0a4ee41e875adb.1616279653.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.286.gc175f2cb894
In-Reply-To: <cover.1616279653.git.avarab@gmail.com>
References: <xmqqpmzxy939.fsf@gitster.g> <cover.1616279653.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that read_tree() has been moved to ls-files.c we can get rid of
the stage != 1 case that'll never happen.

Let's not use read_tree_recursive() as a pass-through to pass "stage =
1" either. For now we'll pass an unused "stage = 0" for consistency
with other read_tree_recursive() callers, that argument will be
removed in a follow-up commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a4458622813..3149a2769a3 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -425,7 +425,7 @@ static int read_one_entry_opt(struct index_state *istate,
 			      const struct object_id *oid,
 			      const char *base, int baselen,
 			      const char *pathname,
-			      unsigned mode, int stage, int opt)
+			      unsigned mode, int opt)
 {
 	int len;
 	struct cache_entry *ce;
@@ -437,7 +437,7 @@ static int read_one_entry_opt(struct index_state *istate,
 	ce = make_empty_cache_entry(istate, baselen + len);
 
 	ce->ce_mode = create_ce_mode(mode);
-	ce->ce_flags = create_ce_flags(stage);
+	ce->ce_flags = create_ce_flags(1);
 	ce->ce_namelen = baselen + len;
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
@@ -451,7 +451,7 @@ static int read_one_entry(const struct object_id *oid, struct strbuf *base,
 {
 	struct index_state *istate = context;
 	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
-				  mode, stage,
+				  mode,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
 
@@ -465,26 +465,17 @@ static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
 {
 	struct index_state *istate = context;
 	return read_one_entry_opt(istate, oid, base->buf, base->len, pathname,
-				  mode, stage,
+				  mode,
 				  ADD_CACHE_JUST_APPEND);
 }
 
 
-static int read_tree(struct repository *r, struct tree *tree, int stage,
+static int read_tree(struct repository *r, struct tree *tree,
 		     struct pathspec *match, struct index_state *istate)
 {
 	read_tree_fn_t fn = NULL;
 	int i, err;
 
-	/*
-	 * Currently the only existing callers of this function all
-	 * call it with stage=1 and after making sure there is nothing
-	 * at that stage; we could always use read_one_entry_quick().
-	 *
-	 * But when we decide to straighten out git-read-tree not to
-	 * use unpack_trees() in some cases, this will probably start
-	 * to matter.
-	 */
 
 	/*
 	 * See if we have cache entry at the stage.  If so,
@@ -493,13 +484,13 @@ static int read_tree(struct repository *r, struct tree *tree, int stage,
 	 */
 	for (i = 0; !fn && i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		if (ce_stage(ce) == stage)
+		if (ce_stage(ce) == 1)
 			fn = read_one_entry;
 	}
 
 	if (!fn)
 		fn = read_one_entry_quick;
-	err = read_tree_recursive(r, tree, "", 0, stage, match, fn, istate);
+	err = read_tree_recursive(r, tree, "", 0, 0, match, fn, istate);
 	if (fn == read_one_entry || err)
 		return err;
 
@@ -549,7 +540,7 @@ void overlay_tree_on_index(struct index_state *istate,
 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
 		memset(&pathspec, 0, sizeof(pathspec));
-	if (read_tree(the_repository, tree, 1, &pathspec, istate))
+	if (read_tree(the_repository, tree, &pathspec, istate))
 		die("unable to read tree entries %s", tree_name);
 
 	for (i = 0; i < istate->cache_nr; i++) {
-- 
2.31.0.286.gc175f2cb894

