Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0AAC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbhLVEHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbhLVEHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:07:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA241C06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso256371wmk.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKUdt07FDd/4RwwNu+OUw9fDB251t/wPJmWo/Mb4il8=;
        b=JBO4zLxECtt1sdVnLJrflUMnjWw1tlbyAvkuiVbMNvTqYhfgTJcfupYd181Sgxsnoc
         Kzz3Xh4wgEjJhVv33D1q6UPTlh9XuP5bw6OkHeIQAcA44USfWsjrA0aw5jeq/heLi3FH
         se9NYlCJEItj3RvoFY741CR+BCKssPPrBV2SSGGq9mLzvgHuPJmpB2EAGgBY52SCWyuz
         IryGKY1KRbT2rvZcYkcLwj0nQ8S9XavVe7xMX/8XlwOfwR8DpX48JjINFT8j5oRwn/8V
         RyuJ/co+Dnmtxim+r+bkwk5Nx8Fl8yOFFwj98S1I6wLgofTicRGuKnhi6rAqS4c/0CoD
         MmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKUdt07FDd/4RwwNu+OUw9fDB251t/wPJmWo/Mb4il8=;
        b=QRVuj6QlcihPAv5n0Z2k/7dj2V86TQcHvSa+jEC33M5NDqJBxKt/KhAFbVFVXdf+03
         SJwBOVjAXc+1dYRKLuz/xYEMLgokQmZM4bH8DsDQMSaQkYxf41Kl4Vb+EJvCqS5DiWXv
         I8zty5yZZwobpK0gJBViLF93hnBgDvjcI9UPsFPj3GUEYhMxyk0qnQ1DW9DsNsTHe5Cf
         rY30gSAvWclcVtbE1KFrQkzZzf2AXpol9E/bLdyqmsjUwd477mBbjBwdBquikfu3tHhc
         lIWQeWyZlW/fnf+PQ4wvEHfGZRwM4RIqDEeyvC5KwlFkIVw/t/3zuD+hVS87ceRHDy7n
         nJiA==
X-Gm-Message-State: AOAM533ylkIMcyXXLqzuFEzJFvTlJ7c/Ra5zNcjdqCxwivpa00uL2Ix8
        nX81DlBg1/Y7rhyCcyuu/IE7U9U38qpQPA==
X-Google-Smtp-Source: ABdhPJxTvlBle3fv//rK00e4JIu3bTDjMfIJJ6BxQgIz/Cz5Fwx6TW7YDH2MzSXTYijRhw2rw6+H0A==
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr785209wmj.3.1640146027135;
        Tue, 21 Dec 2021 20:07:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm710484wru.87.2021.12.21.20.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:07:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/9] reflog: change one->many worktree->refnames to use a string_list
Date:   Wed, 22 Dec 2021 05:06:42 +0100
Message-Id: <patch-v3-3.9-ba7679e6fc0-20211222T040557Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the FLEX_ARRAY pattern added in bda3a31cc79 (reflog-expire:
Avoid creating new files in a directory inside readdir(3) loop,
2008-01-25) the string-list API instead.

This does not change any behavior, allows us to delete much of this
code as it's replaced by things we get from the string-list API for
free, as a result we need just one struct to keep track of this data,
instead of two.

The "DUP" -> "string_list_append_nodup(..., strbuf_detach(...))"
pattern here is the same as that used in a recent memory leak fix in
b202e51b154 (grep: fix a "path_list" memory leak, 2021-10-22).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 47 ++++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6989492bf5c..27851c6efb7 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -48,16 +48,9 @@ struct expire_reflog_policy_cb {
 	struct commit_list *tips;
 };
 
-struct collected_reflog {
-	struct object_id oid;
-	char reflog[FLEX_ARRAY];
-};
-
-struct collect_reflog_cb {
-	struct collected_reflog **e;
-	int alloc;
-	int nr;
-	struct worktree *wt;
+struct worktree_reflogs {
+	struct worktree *worktree;
+	struct string_list reflogs;
 };
 
 /* Remember to update object flag allocation in object.h */
@@ -403,24 +396,20 @@ static void reflog_expiry_cleanup(void *cb_data)
 
 static int collect_reflog(const char *ref, const struct object_id *oid, int unused, void *cb_data)
 {
-	struct collected_reflog *e;
-	struct collect_reflog_cb *cb = cb_data;
+	struct worktree_reflogs *cb = cb_data;
+	struct worktree *worktree = cb->worktree;
 	struct strbuf newref = STRBUF_INIT;
 
 	/*
 	 * Avoid collecting the same shared ref multiple times because
 	 * they are available via all worktrees.
 	 */
-	if (!cb->wt->is_current && ref_type(ref) == REF_TYPE_NORMAL)
+	if (!worktree->is_current && ref_type(ref) == REF_TYPE_NORMAL)
 		return 0;
 
-	strbuf_worktree_ref(cb->wt, &newref, ref);
-	FLEX_ALLOC_STR(e, reflog, newref.buf);
-	strbuf_release(&newref);
+	strbuf_worktree_ref(worktree, &newref, ref);
+	string_list_append_nodup(&cb->reflogs, strbuf_detach(&newref, NULL));
 
-	oidcpy(&e->oid, oid);
-	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
-	cb->e[cb->nr++] = e;
 	return 0;
 }
 
@@ -609,33 +598,33 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	}
 
 	if (do_all) {
-		struct collect_reflog_cb collected;
+		struct worktree_reflogs collected = {
+			.reflogs = STRING_LIST_INIT_DUP,
+		};
+		struct string_list_item *item;
 		struct worktree **worktrees, **p;
-		int i;
 
-		memset(&collected, 0, sizeof(collected));
 		worktrees = get_worktrees();
 		for (p = worktrees; *p; p++) {
 			if (!all_worktrees && !(*p)->is_current)
 				continue;
-			collected.wt = *p;
+			collected.worktree = *p;
 			refs_for_each_reflog(get_worktree_ref_store(*p),
 					     collect_reflog, &collected);
 		}
 		free_worktrees(worktrees);
-		for (i = 0; i < collected.nr; i++) {
-			struct collected_reflog *e = collected.e[i];
+
+		for_each_string_list_item(item, &collected.reflogs) {
 			struct expire_reflog_policy_cb cb = { .cmd = cmd };
 
-			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
-			status |= reflog_expire(e->reflog, flags,
+			set_reflog_expiry_param(&cb.cmd, explicit_expiry, item->string);
+			status |= reflog_expire(item->string, flags,
 						reflog_expiry_prepare,
 						should_expire_reflog_ent,
 						reflog_expiry_cleanup,
 						&cb);
-			free(e);
 		}
-		free(collected.e);
+		string_list_clear(&collected.reflogs, 0);
 	}
 
 	for (; i < argc; i++) {
-- 
2.34.1.1146.gb52885e7c44

