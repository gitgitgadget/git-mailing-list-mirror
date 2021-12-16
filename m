Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDD0C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbhLPNpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbhLPNp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:45:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E6CC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so18157399wmc.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nV6vhByzp5wXBI5P+BbhOIGU99FWYjceOyt0qehcwn4=;
        b=fB7MrRdkMC1NDoiLQcU+gyX8CuitotfLyptBlH6GMBoo0SaPNdYtnz2Zxa1UZV1MdW
         ci0P6xua7ab+RQlB/FHPDXid+aPNfYoxJ0M+T5B4PRD4Mjw8vog1kdlbm1Ca/v4hYlpN
         uqNFjunqX51JwMMmBY/5XoTyXbO+nOle5NXLVU7ULJgK9VgqXpAZ3+u7r3o+OwUijHRq
         qLxpZhN9KuDqnOJbc6qWHaw9TzUpZtE33AjWnVqGb588WfeMB3jv9SW6IOUVkRnJ2gnN
         RXbJQLfvOVY4wADXYvmbAFjm/1EgIduPKkL/x8DRbIHC7iNOlhY/NO4Es/Wj6yhaWGUt
         uU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nV6vhByzp5wXBI5P+BbhOIGU99FWYjceOyt0qehcwn4=;
        b=cuKYqFeLA0/3iP6O7CajtjgEPa5ia8NzN7MVXDy0Qixb+PGjrKXNwzsMc8vqVkN9xV
         BO7bYgq9Z1JaeR4L5x8l9tpWyH0afzbaJZJYnAjaLRRBGuKePIe4YBUHlP7+MvjXNWN2
         QY4e4AIWBGVz2VkAGUBpNSF40GhzEUN/0HZ8C+QJHDzYnsss9L+cW1ZGt7laot04hFRz
         uhjXW3TfE2KbEt6rUV7hfx14MdkmXwUas9sdgenHsiYndd054DeL1Uogy3krE5TE5PqJ
         w0a3L7ipAjfV4jTniNYVJYAL//tLHLJublz19rpfm3lOS5RPKfcNG5LUzJ/cD64i6YBZ
         F8KQ==
X-Gm-Message-State: AOAM532M+Nux7yZbPzFHwOC1B9qYkAi050CZOmxg31tt9P3o/KWosUyh
        NDmLDedt++pNPTQytgMX+cTheNsH9rocQQ==
X-Google-Smtp-Source: ABdhPJyaig/fVBnfRhw1n2ilPZPamY0+TeQtF8BxpKjYTpqOM+ic+ECTP62wpzIm7hnsx8q8lJK/2A==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr5112256wma.42.1639662324656;
        Thu, 16 Dec 2021 05:45:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y12sm4866821wrn.73.2021.12.16.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:45:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/9] reflog expire: don't do negative comparison on enum values
Date:   Thu, 16 Dec 2021 14:45:13 +0100
Message-Id: <patch-v2-4.9-e42fac1b518-20211216T134028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gc80c40b6642
In-Reply-To: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20211130T213319Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
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
2.34.1.1020.gc80c40b6642

