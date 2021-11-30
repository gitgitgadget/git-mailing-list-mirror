Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E746DC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbhK3Vlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344230AbhK3Vln (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:41:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136AEC061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:23 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so20618038wmj.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TjcXc9IsIBoOw9sh7JvfMcBEVLUqTqYPac9RGxrc04w=;
        b=SeIOlkzP9xpLdX/3Ribe5eyQwbA3+RZ2gfCUHUQB9UQcjyW4gDA22sBqanfa3bCQE7
         PxEK/MDaLQBq+1uhkoaWGkL/MfG5qFQuN1+dpAZqvyOl1S7QPaIZ77nbQRaU+j0S7k40
         /D6XXWK1PXmjv5tRH2nCU8l07C5/aTonSvA3fqFJPFdhw31fVYUZof2heiqNhrt77nBj
         qJuGN0Dn76znlICYk6hlxEVq+aMKqrQuhG90/I4pYYnIFVjK7mnTjSBqksvGrUEpZV6g
         kY20Fb6Kp7NhXlxYRbxofZ0HvGlfQy/0UwtQ592E6k1QoLPipw25C611GTND8gsanAx7
         IxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TjcXc9IsIBoOw9sh7JvfMcBEVLUqTqYPac9RGxrc04w=;
        b=Ht+2gd7/xko9XaFNAzjQrqLOhjfieyomjT76kQ56od830puLsePZyLVSeL7K+iKc4x
         rHQtenGwTLnq2SaobefKWXyUT2rP4OXd7LFLWJsdhIqLx5BAY5cAlZZZ3lUM/VdhMUi0
         ES4R6KaThlom9y1bOI+lWXDJQmoRmYDwu2KKy3pYsqmmDZqQihjE3ReG5sN97blStE9e
         YkRnlsokcB4YecY+hUPqHxmq2ivNN/J6s3VPFfJy9qDNtNcyuy5LeJlTjWvU08fkgObh
         icmrlAE9G+VrOPbe9fR0SxVcuHT9Pd4LIXZpZs7GluTPZK6t969sYNuhc3UcXFq5Gzmd
         DwMg==
X-Gm-Message-State: AOAM5308XwAlt9VOGdbT4B2P31UOUd1UIKplcUZlDlYba31Vze2zo+9Z
        CK8K49oYw38rK5/iFxTkOYucldxnDmMVIg==
X-Google-Smtp-Source: ABdhPJwtgYRSnZyRD29vWufUJwt1BxyV51o109k5hUufnYXWIQD3ZmfUB43QpOSGXwYlFdHMq1Zh9w==
X-Received: by 2002:a1c:540c:: with SMTP id i12mr1615172wmb.33.1638308301435;
        Tue, 30 Nov 2021 13:38:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v8sm17006914wrd.84.2021.11.30.13.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:38:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/12] reflog expire: don't do negative comparison on enum values
Date:   Tue, 30 Nov 2021 22:38:06 +0100
Message-Id: <patch-04.12-a7a2dfd1406-20211130T213319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.877.g7d5b0a3b8a6
In-Reply-To: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 03cb91b18cc (reflog --expire-unreachable: special
case entries in "HEAD" reflog, 2010-04-09) to not do positive instead
of negative comparisons on enum values, i.e. not to assume that "x !=
UE_ALWAYS" means "(x == UE_HEAD || x || UE_NORMAL)".

That assumption is true now, but we'd introduce subtle bugs here if
that were to change, now the compiler will notice and error out on
such errors.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 57 ++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 0fb46ade19f..f8a24f1aa26 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -303,10 +303,15 @@ static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *no
 		return 1;
 
 	if (timestamp < cb->cmd.expire_unreachable) {
-		if (cb->unreachable_expire_kind == UE_ALWAYS)
-			return 1;
-		if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
+		switch (cb->unreachable_expire_kind) {
+		case UE_ALWAYS:
 			return 1;
+		case UE_NORMAL:
+		case UE_HEAD:
+			if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
+				return 1;
+			break;
+		}
 	}
 
 	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
@@ -348,6 +353,7 @@ static void reflog_expiry_prepare(const char *refname,
 				  void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
+	struct commit_list *elem;
 
 	if (!cb->cmd.expire_unreachable || is_head(refname)) {
 		cb->unreachable_expire_kind = UE_HEAD;
@@ -363,34 +369,37 @@ static void reflog_expiry_prepare(const char *refname,
 	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
 		cb->unreachable_expire_kind = UE_ALWAYS;
 
-	if (cb->unreachable_expire_kind != UE_ALWAYS) {
-		if (cb->unreachable_expire_kind == UE_HEAD) {
-			struct commit_list *elem;
-
-			for_each_ref(push_tip_to_list, &cb->tips);
-			for (elem = cb->tips; elem; elem = elem->next)
-				commit_list_insert(elem->item, &cb->mark_list);
-		} else {
-			commit_list_insert(cb->tip_commit, &cb->mark_list);
-		}
-		cb->mark_limit = cb->cmd.expire_total;
-		mark_reachable(cb);
+	switch (cb->unreachable_expire_kind) {
+	case UE_ALWAYS:
+		return;
+	case UE_HEAD:
+		for_each_ref(push_tip_to_list, &cb->tips);
+		for (elem = cb->tips; elem; elem = elem->next)
+			commit_list_insert(elem->item, &cb->mark_list);
+		break;
+	case UE_NORMAL:
+		commit_list_insert(cb->tip_commit, &cb->mark_list);
 	}
+	cb->mark_limit = cb->cmd.expire_total;
+	mark_reachable(cb);
 }
 
 static void reflog_expiry_cleanup(void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
+	struct commit_list *elem;
 
-	if (cb->unreachable_expire_kind != UE_ALWAYS) {
-		if (cb->unreachable_expire_kind == UE_HEAD) {
-			struct commit_list *elem;
-			for (elem = cb->tips; elem; elem = elem->next)
-				clear_commit_marks(elem->item, REACHABLE);
-			free_commit_list(cb->tips);
-		} else {
-			clear_commit_marks(cb->tip_commit, REACHABLE);
-		}
+	switch (cb->unreachable_expire_kind) {
+	case UE_ALWAYS:
+		return;
+	case UE_HEAD:
+		for (elem = cb->tips; elem; elem = elem->next)
+			clear_commit_marks(elem->item, REACHABLE);
+		free_commit_list(cb->tips);
+		break;
+	case UE_NORMAL:
+		clear_commit_marks(cb->tip_commit, REACHABLE);
+		break;
 	}
 }
 
-- 
2.34.1.877.g7d5b0a3b8a6

