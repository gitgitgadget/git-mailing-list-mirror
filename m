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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3E9C1550F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A666521F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhCHPH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhCHPHg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A601C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso3998954wma.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJLudztODFKzoIhgtxZ28nICKp+MPrebrA5U6dRSsmw=;
        b=dz9gLElDp8IUO9WJ7M5huyK6Rp7m7PCdTRW90x17OkBabju7yFoFSl31ffY/3ton0V
         eEhFWSJbSSkNzerGDyak7sk4PVmAorbvv2MKJzHpuuAY1iy1yIxnCG+dvctN/wrF5N/u
         TRlZQ/0qBrT4LJt3Emo5IKd6TwsWNOBWRl2dJmV6H7DXxxiJp2Jt3WbLIGVqUiys+kJP
         VBE24OdfUMTkBJLs7oZgevymwyaPg3GhYD2NUCKnHDnQ+VgYD3jlTzG6KSw+Pb8dp4z6
         0Zb/TO/sViOLMRTZAZZMYyVMkIoqNp1MKPkXYp0T0UalIiN2nwvD1IrUTVMziShANZBJ
         Xozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJLudztODFKzoIhgtxZ28nICKp+MPrebrA5U6dRSsmw=;
        b=LY+Itlp4Pq3GokhslOlqlQL4tetu+I4UR3sF+/JPvw1WJKvP5OCh1/BuCUgFQAqJoF
         bL5ANNEujkaiivfKWraTP/Qwv5LzSRizWxnB4bcsyM+s+N1ogzDY7aXL3ggdVplzj9jM
         NlKIFGMSGCmUixSWca4VupLJTFFON5HyIcgy9z0SIJDI6QuKaFqH78eYI02ajAdpcb5e
         hDD9A/iCQjusDCgl6KRJRjQSmM86fPcHUln7QdUARIEZ6CU1UIcsWyfcABQ+wpC0pdQq
         DiYKz1Tiko1WsT00u+CKmgoL5CCwlijBFUvSpnHjpIRYDTzrYNgGoYW4xC1s6AFtqwop
         f8xA==
X-Gm-Message-State: AOAM532zaVW6JD6g+dt+SBh/OoJBcoUuhPNMzuhzxG0ytIdPK+Kvzsnp
        g35BOuBpOtl5zzrjqSL/QpwaOqVT7XQDNg==
X-Google-Smtp-Source: ABdhPJz4u2pT54X7xcPcN+WLRI0U//PYah5hNHIBHteI8tGThrmigVgzDJd0aYp2CmcwYZUNUD3RpQ==
X-Received: by 2002:a1c:4802:: with SMTP id v2mr23077311wma.139.1615216054548;
        Mon, 08 Mar 2021 07:07:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:34 -0800 (PST)
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
Subject: [PATCH 30/30] tree-walk.h API: move canon_mode() back out of decode_tree_entry()
Date:   Mon,  8 Mar 2021 16:06:50 +0100
Message-Id: <20210308150650.18626-31-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the canon_mode() call back out of decode_tree_entry(), and
instead make it the responsibility of its callers to canonicalize the
tree modes we get.

This effectively reverts 7146e66f086 (tree-walk: finally switch over
tree descriptors to contain a pre-parsed entry, 2014-02-06), with the
recent of most callers away from "mode" (now "raw_mode") towards "enum
object_id" in recent commit the motivation for that commit effectively
doesn't exist anymore.

I.e. I'm not adding the canon_mode() call back to
tree_entry_extract(), instead it's now become sane to move this
responsibility to those callers that still care about the "raw_mode".

That change was meant as a pure optimization change, but it actually
introduced a subtle bug. We were left without any low-level API to get
non-standard mode bits out of trees. Having non-standard modes isn't
the norm, and fsck should warn about it.

Except after 7146e66f086 it couldn't anymore, since the modes
fsck_tree() got would be pre-sanitized for it. I believe that fsck
issue is per-se a serious bug, the "bad mode" was a default warning,
not an error.

This change makes that fsck check work again, why aren't there any
test changes for fsck here? Because we didn't have a test for that
fsck feature in the first place, which is why the regression in
7146e66f086 snuck by us. A follow-up commit will add such a test.

It is possible that this commit is introducing some subtle regression
that I've missed.

We are now propagating the "raw_mode" outside of everything downstream
of decode_tree_entry(), which is everything we have that decodes
trees. It's our most low-level tree decoding API.

As shown here we rely parsing out a "raw" (and possibly something fsck
would complain about) mode as-is, but when we run merge, add something
new to the index, create an archive etc. we don't want to propagate
that bad mode when we create new data. We want to canon_mode() it.

I'm also pretty sure that we don't have good enough test coverage for
those scenarios. We barely have tests for these bad mode bits at
all (not even one for fsck). We definitely are not testing all
merge/index/archive etc. interactions.

Still, I think this change is worth it overall, because:

 1. We must have a way to get at these raw modes in some way, even if
    just for fsck. There's also other things that care, see e.g. the
    FIXME comment in 62fdec17a11 (merge-ort: flesh out implementation of
    handle_content_merge(), 2021-01-01)

 2. #1 is not a justification for this change, I could have e.g. just
    added the ability to pass some "want_raw" flag into
    decode_tree_entry() for use in fsck. But I think with the migration
    of most tree iteration towards "enum object_type" it's become worth
    it.

 3. Yes our test coverage sucks, but before 7146e66f086 we were also
    spreading what's now the "raw_mode" all over the place. That commit
    was first released with Git v2.0.0 in mid-2014. A while ago for sure,
    but most of this code existed in something approximating its current
    form then. This isn't new territory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c              |  2 +-
 builtin/checkout.c     |  1 +
 builtin/ls-files.c     |  2 +-
 builtin/merge-tree.c   |  6 +++---
 builtin/update-index.c |  1 +
 merge-ort.c            | 13 ++++++++++++-
 notes.c                |  1 +
 tree-walk.c            |  1 -
 unpack-trees.c         |  4 +++-
 9 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/archive.c b/archive.c
index 5b85aae8106..8083f15f3ba 100644
--- a/archive.c
+++ b/archive.c
@@ -236,7 +236,7 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 					void *context)
 {
 	struct archiver_context *c = context;
-	unsigned mode = raw_mode;
+	unsigned mode = canon_mode(raw_mode);
 
 	while (c->bottom &&
 	       !(base->len >= c->bottom->len &&
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d4adfdb5046..7f25b955616 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -132,6 +132,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 	memcpy(ce->name + base->len, pathname, len - base->len);
 	ce->ce_flags = create_ce_flags(0) | CE_UPDATE;
 	ce->ce_namelen = len;
+	mode = canon_mode(mode);
 	ce->ce_mode = create_ce_mode(mode);
 
 	/*
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 391e6a9f141..926523d77a7 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -429,7 +429,7 @@ static int read_one_entry_opt(struct index_state *istate,
 {
 	int len;
 	struct cache_entry *ce;
-	unsigned mode = raw_mode;
+	unsigned mode = canon_mode(raw_mode);
 
 	if (S_ISDIR(mode))
 		return READ_TREE_RECURSIVE;
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index b4e736e4b72..f8733a86eb7 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -197,9 +197,9 @@ static void resolve(const struct traverse_info *info, struct name_entry *ours, s
 		return;
 
 	path = traverse_path(info, result);
-	orig_mode = ours->raw_mode;
+	orig_mode = canon_mode(ours->raw_mode);
 	orig = create_entry(2, orig_mode, &ours->oid, path);
-	final_mode = result->raw_mode;
+	final_mode = canon_mode(result->raw_mode);
 	final = create_entry(0, final_mode, &result->oid, path);
 
 	final->link = orig;
@@ -252,7 +252,7 @@ static struct merge_list *link_entry(unsigned stage, const struct traverse_info
 		path = entry->path;
 	else
 		path = traverse_path(info, n);
-	link_mode = n->raw_mode;
+	link_mode = canon_mode(n->raw_mode);
 	link = create_entry(stage, link_mode, &n->oid, path);
 
 	link->link = entry;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b489a876392..1996fdd97af 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -621,6 +621,7 @@ static struct cache_entry *read_one_ent(const char *which,
 	memcpy(ce->name, path, namelen);
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = namelen;
+	mode = canon_mode(mode);
 	ce->ce_mode = create_ce_mode(mode);
 	return ce;
 }
diff --git a/merge-ort.c b/merge-ort.c
index ea20bbe2af3..d1e8a2823e0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -502,7 +502,7 @@ static void setup_path_info(struct merge_options *opt,
 	mi->basename_offset = current_dir_name_len;
 	mi->clean = !!resolved;
 	if (resolved) {
-		mi->result.mode = merged_version->raw_mode;
+		mi->result.mode = canon_mode(merged_version->raw_mode);
 		oidcpy(&mi->result.oid, &merged_version->oid);
 		mi->is_null = !!is_null;
 	} else {
@@ -512,6 +512,16 @@ static void setup_path_info(struct merge_options *opt,
 		ASSIGN_AND_VERIFY_CI(ci, mi);
 		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
 			ci->pathnames[i] = fullpath;
+			/*
+			 * We must not use canon_mode() here. Will
+			 * fail on an the is_null assertion in
+			 * 6a02dd90c99 (merge-ort: add a preliminary
+			 * simple process_entries() implementation,
+			 * 2020-12-13) when combined with the tests in
+			 * "[PATCH 00/11] Complete merge-ort
+			 * implementation...almost" (see
+			 * https://lore.kernel.org/git/pull.973.git.git.1614905738.gitgitgadget@gmail.com/)
+			 */
 			ci->stages[i].mode = names[i].raw_mode;
 			oidcpy(&ci->stages[i].oid, &names[i].oid);
 		}
@@ -546,6 +556,7 @@ static void add_pair(struct merge_options *opt,
 	int names_idx = is_add ? side : 0;
 	const struct object_id *oid = &names[names_idx].oid;
 	unsigned int mode = names[names_idx].raw_mode;
+	mode = canon_mode(mode);
 
 	one = alloc_filespec(pathname);
 	two = alloc_filespec(pathname);
diff --git a/notes.c b/notes.c
index 2817325651a..78b1b38d36b 100644
--- a/notes.c
+++ b/notes.c
@@ -479,6 +479,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 			const char *q = oid_to_hex(&subtree->key_oid);
 			size_t i;
 			unsigned int mode = entry.raw_mode;
+			mode = canon_mode(mode);
 			for (i = 0; i < prefix_len; i++) {
 				strbuf_addch(&non_note_path, *q++);
 				strbuf_addch(&non_note_path, *q++);
diff --git a/tree-walk.c b/tree-walk.c
index 099a9b3bd77..3175430d049 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -47,7 +47,6 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 
 	/* Initialize the descriptor entry */
 	desc->entry.path = path;
-	mode = canon_mode(mode);
 	desc->entry.raw_mode = mode;
 	desc->entry.object_type = object_type(mode);
 	desc->entry.pathlen = len - 1;
diff --git a/unpack-trees.c b/unpack-trees.c
index dcdf8130745..2fb346714b3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -868,6 +868,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	newinfo.name = p->path;
 	newinfo.namelen = p->pathlen;
 	newinfo.mode = p->raw_mode;
+	newinfo.mode = canon_mode(newinfo.mode);
 	newinfo.pathlen = st_add3(newinfo.pathlen, tree_entry_len(p), 1);
 	newinfo.df_conflicts |= df_conflicts;
 
@@ -1020,7 +1021,8 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 		is_transient ?
 		make_empty_transient_cache_entry(len) :
 		make_empty_cache_entry(istate, len);
-	unsigned int mode = n->raw_mode;
+	unsigned int mode = canon_mode(n->raw_mode);
+	mode = canon_mode(mode);
 
 	ce->ce_mode = create_ce_mode(mode);
 	ce->ce_flags = create_ce_flags(stage);
-- 
2.31.0.rc0.126.g04f22c5b82

