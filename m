Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62278C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 13:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbjDZNPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbjDZNPm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 09:15:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3C2469D
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 06:15:17 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b8b19901fso8665713b3a.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682514916; x=1685106916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hU6ZOC5QBLRYhUWdL7Hf0VIEqdSYcWcbk3xtzEyWVl4=;
        b=Wp6p36ItB6f5HEbymeZoyg5z4rmygtVTyidF0XZZGYp0mXSL2zawaoLwPSoOTS6GYO
         +IOUJJT3m8zmlr3PwdUPWSLI0mHLOlyy5MlDXHk4r++Ob9BD/zG8Q8+ZKtI9tiYSYjlD
         oD+IVFFGsOAT75JngJb+xNpJgxIi5w8hR0IWOs1RiifVat35ufqbYiqYjttqiKfMGBPH
         lCXmUE3NTKvvLWkxO5RDM4a7oZV/wJ6K55TwvL2Ujp33bKDWrcSZBTJl5SFeVm3llQxl
         bOOGbucKfqcIIF/ITtB1EHr3JhEJCK0Wk9J3MThczLST6O9w5IoA5M7QPv5SO+8yNd/D
         Sr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682514916; x=1685106916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU6ZOC5QBLRYhUWdL7Hf0VIEqdSYcWcbk3xtzEyWVl4=;
        b=EJCmH8igJfrXDUx/UXP0OPphjxK69VDj3U1bY6duangTJhI8dbEp/hofNiDxqdyloM
         zTs5fROtBcUu0sUHRugYT8NfwjU2PJdc1B9oleoMzgTUTVAQagLuvEviI9ZtqsPiMB0i
         ky3hVlZDM1xUnRxCFLmejKZQzczXAyGtRDEbh7p1ZLDcSqrrRSo30Plm4rGiU4HNcbvW
         rc04QZdQdP5F2J97CLMfnnGlQ2Zrtn9a7vBZRQYBQ5/icV9bYNl7SZQZEwt9ADInSHfN
         ItbNGakqotq1xCbGPjzGdxsQKiLz+dtQ8lY4YxWwJnOiUPXrP2mihWRqjL7JvuaRICH/
         sR6g==
X-Gm-Message-State: AAQBX9fU1VCytl9S1HPth2NdBAYfCkSn3BPAW0c2d6FZLhiarMalmB79
        kp5iRUf0PnyPQPkKEBZpA8GTdHcKN6n/E2qFUc4=
X-Google-Smtp-Source: AKy350aAZkEluR9bXHjpLVmxyhYqf4bFdXpoDGMonOFXDijInYlpmUjBK4kB0M8HXR/gE5fXlxFBxw==
X-Received: by 2002:a05:6a00:9a4:b0:627:e577:4331 with SMTP id u36-20020a056a0009a400b00627e5774331mr29709327pfg.1.1682514916290;
        Wed, 26 Apr 2023 06:15:16 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id m9-20020a629409000000b00639eae8816asm11173693pfe.130.2023.04.26.06.15.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Apr 2023 06:15:16 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     git@vger.kernel.org
Cc:     Han Xin <hanxin.hx@bytedance.com>, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] negotiator/default: avoid stack overflow
Date:   Wed, 26 Apr 2023 21:15:03 +0800
Message-Id: <0e69d70805e6da684e6e17642a1cf0d59a03dfc0.1682513384.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682513384.git.hanxin.hx@bytedance.com>
References: <cover.1682473718.git.hanxin.hx@bytedance.com> <cover.1682513384.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mark_common() in negotiator/default.c may overflow the stack due to
recursive function calls. Avoid this by instead recursing using a
heap-allocated data structure.

This is the same case as 4654134976f (negotiator/skipping: avoid
stack overflow, 2022-10-25)

Reported-by: Xin Xing <xingxin.xx@bytedance.com>
Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 negotiator/default.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/negotiator/default.c b/negotiator/default.c
index f4b78eb47d..635cdd6483 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -55,30 +55,49 @@ static int clear_marks(const char *refname, const struct object_id *oid,
 static void mark_common(struct negotiation_state *ns, struct commit *commit,
 		int ancestors_only, int dont_parse)
 {
-	if (commit != NULL && !(commit->object.flags & COMMON)) {
-		struct object *o = (struct object *)commit;
+	struct prio_queue queue = { NULL };
+
+	if (!commit || (commit->object.flags & COMMON))
+		return;
+
+	prio_queue_put(&queue, commit);
+	if (!ancestors_only) {
+		commit->object.flags |= COMMON;
 
-		if (!ancestors_only)
-			o->flags |= COMMON;
+		if ((commit->object.flags & SEEN) && !(commit->object.flags & POPPED))
+			ns->non_common_revs--;
+	}
+	while ((commit = prio_queue_get(&queue))) {
+		struct object *o = (struct object *)commit;
 
 		if (!(o->flags & SEEN))
 			rev_list_push(ns, commit, SEEN);
 		else {
 			struct commit_list *parents;
 
-			if (!ancestors_only && !(o->flags & POPPED))
-				ns->non_common_revs--;
 			if (!o->parsed && !dont_parse)
 				if (repo_parse_commit(the_repository, commit))
-					return;
+					continue;
 
 			for (parents = commit->parents;
 					parents;
-					parents = parents->next)
-				mark_common(ns, parents->item, 0,
-					    dont_parse);
+					parents = parents->next) {
+				struct commit *p = parents->item;
+
+				if (p->object.flags & COMMON)
+					continue;
+
+				p->object.flags |= COMMON;
+
+				if ((p->object.flags & SEEN) && !(p->object.flags & POPPED))
+					ns->non_common_revs--;
+
+				prio_queue_put(&queue, parents->item);
+			}
 		}
 	}
+
+	clear_prio_queue(&queue);
 }
 
 /*
-- 
2.40.0

