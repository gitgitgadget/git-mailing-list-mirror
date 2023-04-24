Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D26C6FD18
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 02:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDXCX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 22:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDXCX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 22:23:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E809D1BE5
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 19:23:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b52ad6311so4955750b3a.2
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 19:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682303035; x=1684895035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2pGGz209kKal0W6JChDAm6CSRM1yLwbRbs45pnuZOQ8=;
        b=POl4sbLYspwdmdQetYs9m5xN6Xjp70/kPQcBaajvrpmcbCGNbx68AS/Wy40wst7cTq
         rvcN0eFjBIxWtrkmkDfVfLiSp7C/ZH6H7+ZdD6TKqQaO7KP3PqjJXqqDVxX2kM8ZKpfk
         Ri9VUW7nwdKJFTu74duclLY63xv7dBNbb9Nh0jZl0j8LrXWsAEl9A5GX2kMa5pN9u4k3
         q4HCfg8vzo1H8ckEpTl6A9qqMMTtid0ofdPCNriM/Rq/ie9N+54U2MSW33RcgANsJeQ4
         fjCkYoHPf5UkSJ32/r/bi05ChRBWdTB7pTgjPjQSW5e5hGW1zZfpcdY5avE4dnDnsUHs
         O4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682303035; x=1684895035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pGGz209kKal0W6JChDAm6CSRM1yLwbRbs45pnuZOQ8=;
        b=MYkMJkKN82JOqKIfC+SV3uWVZrc1z6gic2/Wt3DcZzXFRJdoJi15HJFagsMFeR4M2S
         gCEgIQ0hY+081c1wHlfP/0WjnmFM75W/m2/OxuSiv4a92HFwQxY5WZovoLjCdJbzmSqT
         b97MG4iYgLvvstboD+GfREph7hkxLpNSkfesAvPLoGE+BeF0yhWm+zATLnt5DhiU7Duu
         jsjomVxzCRenPQw4KDD4xsG3G4CJ3V7iNnyv+zIvuOlrzhFk3w24gq07EkJ8OushJpGX
         Uvuwtd2P3cZtv34kGInvLOkcyagu/y/JyA2Nii7pYhnZ7QIuSRijvqnO4Q4IxD8c8CCI
         JMWA==
X-Gm-Message-State: AAQBX9fZme7Ob7QuIqeC52wfvX2/hUQcKuwjoleGSGJLN5EYOmmR1suW
        whP4ob0OacwUZdTZ4fQ5vDyMqE2MjyGS70QRXCA=
X-Google-Smtp-Source: AKy350ZBcoOHXGvvR01RIdU/6ebKPrQbv5m+HUZGEdftZte6mIfT1JdJMByXGce2hK5Bt/4P5YSvMQ==
X-Received: by 2002:a05:6a20:429c:b0:f3:a3b7:ae37 with SMTP id o28-20020a056a20429c00b000f3a3b7ae37mr4437536pzj.29.1682303035246;
        Sun, 23 Apr 2023 19:23:55 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id a22-20020a62d416000000b0063f9de332f8sm1061065pfh.167.2023.04.23.19.23.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Apr 2023 19:23:54 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     git@vger.kernel.org
Cc:     Han Xin <hanxin.hx@bytedance.com>, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1] negotiator/default.c: avoid stack overflow
Date:   Mon, 24 Apr 2023 10:23:18 +0800
Message-Id: <20230424022318.80469-1-hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mark_common() in negotiator/default.c may overflow the stack due to
recursive function calls. Avoid this by instead recursing using a
heap-allocated data structure.

This is the same case as [1].

1. https://lore.kernel.org/git/20221025232934.1504445-1-jonathantanmy@google.com/

Reported-by: Xin Xing <xingxin.xx@bytedance.com>
Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 negotiator/default.c  | 16 ++++++++++++----
 negotiator/skipping.c |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/negotiator/default.c b/negotiator/default.c
index f4b78eb47d..6ab7f11409 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -55,9 +55,15 @@ static int clear_marks(const char *refname, const struct object_id *oid,
 static void mark_common(struct negotiation_state *ns, struct commit *commit,
 		int ancestors_only, int dont_parse)
 {
-	if (commit != NULL && !(commit->object.flags & COMMON)) {
+	struct prio_queue queue = { NULL };
+
+	prio_queue_put(&queue, commit);
+	while ((commit = prio_queue_get(&queue))) {
 		struct object *o = (struct object *)commit;
 
+		if (commit == NULL || (commit->object.flags & COMMON))
+			continue;
+
 		if (!ancestors_only)
 			o->flags |= COMMON;
 
@@ -70,15 +76,17 @@ static void mark_common(struct negotiation_state *ns, struct commit *commit,
 				ns->non_common_revs--;
 			if (!o->parsed && !dont_parse)
 				if (repo_parse_commit(the_repository, commit))
-					return;
+					continue;
 
+			ancestors_only = 0;
 			for (parents = commit->parents;
 					parents;
 					parents = parents->next)
-				mark_common(ns, parents->item, 0,
-					    dont_parse);
+				prio_queue_put(&queue, parents->item);
 		}
 	}
+
+	clear_prio_queue(&queue);
 }
 
 /*
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index c7d6ab39bc..3d262b3533 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -108,6 +108,8 @@ static void mark_common(struct data *data, struct commit *seen_commit)
 				prio_queue_put(&queue, p->item);
 		}
 	}
+
+	clear_prio_queue(&queue);
 }
 
 /*
-- 
2.40.0

