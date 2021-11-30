Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB94FC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344241AbhK3Vlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbhK3Vlm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:41:42 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE03C061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso20618942wmr.4
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=57qQgO3vw9s1fLch47WZcmwZCRS9CJvVouiO2JuvXDg=;
        b=oFCF8Q5/PbvuF9cE8clZ4yVabx1YeBjiaTID4ofgwQwLSXUE4RJhBUbamLOIhRTdzA
         cPxnfCc8Lcm1qZAXUe1/BMtnHnlHx9xfpnjMwWL/tFRasHHB7O9CEJnCViWGNz/8Plwi
         yGKn06R7j3p5ClVhHZBXHQglG+oSF6ijKcjhXYk3Zvbpv0uGZG1UqcpXnnD2DvENH5mt
         62KIPiSFua8sPyPIMKw6aMYk7dunSJFK2WjKG3y6/bM6Cg3/Yta2CeNGD+sTeIG3hq8a
         l9Za/0hxWJdtZHxynL9PI7SORwm8ubl4Ms+YJ0pcy7PoZAf25fGKHLGh1RIZImk1NDfq
         u67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=57qQgO3vw9s1fLch47WZcmwZCRS9CJvVouiO2JuvXDg=;
        b=BGGe4suXZx6ihxJZppNHKcHsPvMiWgRC63Dfl/Ck3czFYx7B9jBDG7olI/wfMOTFWn
         kuhCjwCsg223T4cpDjAz5CZHexyGC5OTSyudi8caNrTIf79jflJLm5Sn5Y8zN1FoExZf
         bsge9YWibO9gvyGWdbCAn1RlKaRaX8cqTUQrm0FDG59Za3Yk3cmlp+VVZhderwovYTra
         HxK6Jg4V0O+4vaHF0AJlpnn5Lnm0T2UV6pRhx9VrInnE39LKPv2iOj+RT7dVEwRJuBNU
         DlJFhQNb7Ho0CLSI3sHEIXYSbSYLoxnqrlC4QOnv2hNbkJs6VXB7lB5i5rv62dAfpr9+
         6zwQ==
X-Gm-Message-State: AOAM533SzIoj1xLfbQpjxPMa9cUTOnCgGO1sbxlPzUNbbc7bZ/+9x2gG
        E/xVS9jR/psZNSr2MlFzRl2ncp2PNb2DiQ==
X-Google-Smtp-Source: ABdhPJySOeGBA+dJNThXf5GRlPLruQ9ZiUXyeOY2bNhMHTGp4/s3QtAa8uDDeugoUEpYXLHlei/y8w==
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr1644584wmb.114.1638308300509;
        Tue, 30 Nov 2021 13:38:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:38:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/12] reflog: change one->many worktree->refnames to use a string_list
Date:   Tue, 30 Nov 2021 22:38:05 +0100
Message-Id: <patch-03.12-5a54b04a13e-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6989492bf5c..0fb46ade19f 100644
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
+	string_list_append(&cb->reflogs, strbuf_detach(&newref, NULL));
 
-	oidcpy(&e->oid, oid);
-	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
-	cb->e[cb->nr++] = e;
 	return 0;
 }
 
@@ -609,33 +598,34 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	}
 
 	if (do_all) {
-		struct collect_reflog_cb collected;
+		struct worktree_reflogs collected = {
+			.reflogs = STRING_LIST_INIT_NODUP,
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
+		collected.reflogs.strdup_strings = 1;
+		string_list_clear(&collected.reflogs, 0);
 	}
 
 	for (; i < argc; i++) {
-- 
2.34.1.877.g7d5b0a3b8a6

