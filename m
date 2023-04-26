Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5923DC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 04:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbjDZEGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 00:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjDZEGK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 00:06:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BAB1737
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 21:05:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so8149557b3a.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 21:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682481944; x=1685073944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8fYTLPKC3w213stDqcDgdBeDo6aFhFhTvmdnE6BGuo=;
        b=MnEOR0aeNbZl+9TcksmGJE0OIgXzvrd1XWc9PG/sT75oFkd+PGSdTKk+V31cyfudhW
         EdEyqdVOoYGp7OWeE4jb8Xdxfv821PS+wbZfMEuLnBqdtRbWURlPFTeaUgiGoybOPSUj
         xdtZQAqXgxk0zQ4gAao3KMzU3Gd9v7/BYliCEa/Ey9v8vO0xTpSJ6yWZ6l+baV0X8bfP
         y0KcaEou+pfXWkyW3LDIkSiquNBFhiUv+iSMGjpcmiggChE/j5RZvCPx2kjDGDAgwR8t
         E7xOXyJOaZT0QHgV51G3O3PTq/h/GjgCRy14jaYul9RuP45XzX9tHMBmP/y5OZp+bXqq
         JI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682481944; x=1685073944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8fYTLPKC3w213stDqcDgdBeDo6aFhFhTvmdnE6BGuo=;
        b=K4kZifPUx2VLXUcfhyYqBIQCSZBej0zof0OYneeNu6aXoLWMGip9rio0l8+z0w+6Q9
         STcvfMnSFZp60+wF0poAuDn7PohBtMBXVdxX0KLnQGoIdx5lnZjkKS7cxUacYvkBUB3s
         7Lnnp2qxuBAV6oz0NQGE51Gfu3mhg5Iu8CNat4mFVUfhv/yWmop+gnzkMEyKwU8zBfh5
         s/E+KQ5ZpQaKGRjoPzcjNF1X/C1dxDZ5H/V+m9t+3/K3WyXIaqw+C1CS/jsWYjXVH2f4
         5QxNtmdfFEf6Dj4e++AWWvA/DX8eUklW8S/icqi4XnuCe9VdJxHl2eX6lPbtQaztV80g
         JiBw==
X-Gm-Message-State: AAQBX9f7jZ8Txdtwni/mt6MDA3WJs4m6Ia7r2mpKp1Lc7sk+BfA6Ga4s
        k/9klhlkNcn87EkzTu5grCCRhEHKMJIs0qH5AxU=
X-Google-Smtp-Source: AKy350Zzxo4P9RcorghOkPPfVBp2l10W7j14F7laweRhTuzok+RNVzDOJRlUf1zq2a4JBkKTDypj9w==
X-Received: by 2002:a05:6a00:1914:b0:63b:e4:554 with SMTP id y20-20020a056a00191400b0063b00e40554mr26889348pfi.4.1682481943959;
        Tue, 25 Apr 2023 21:05:43 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id t1-20020a056a0021c100b005d72e54a7e1sm10038156pfj.215.2023.04.25.21.05.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 21:05:43 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     git@vger.kernel.org
Cc:     Han Xin <hanxin.hx@bytedance.com>, xingxin.xx@bytedance.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] negotiator/default: avoid stack overflow
Date:   Wed, 26 Apr 2023 12:05:22 +0800
Message-Id: <935be72eb92cd2eda7aff43c8cc2306b78b2a146.1682473718.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682473718.git.hanxin.hx@bytedance.com>
References: <20230424022318.80469-1-hanxin.hx@bytedance.com> <cover.1682473718.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mark_common() in negotiator/default.c may overflow the stack due to
recursive function calls. Avoid this by instead recursing using a
heap-allocated data structure.

This is the same case as [1].

1. 4654134976f (negotiator/skipping: avoid stack overflow, 2022-10-25)

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

