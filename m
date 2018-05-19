Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787211F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeESF3U (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:29:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32922 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbeESF2m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:42 -0400
Received: by mail-lf0-f68.google.com with SMTP id h9-v6so16908136lfi.0
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wLDEMiLtg33QbJ5mvaQMYVg3nzstwlMUJrGENxt/0uM=;
        b=Md4EmuCntg2GiabBlaO/uvLWJ4fISsd33xrGc4D5NisFOVvkNVsSeYwVhKYxD03dBB
         ttXKkC9pOt4J7BK0vYihKIETupjUbt2Jkbm1XAAsr0ddWFAY7NmX3EcGufE8txGwDLTQ
         SDKgQ8VZ94SWQX/SZmoNCMMp+AwqIqn+xVK8pwc8d94V8gL9tUvaE4qsqy8HsWn5TWdb
         Y5m7jHMJvNQAV819xXrnEKgZmqpd4JGQW53kU4tOfzwjmj0htxZd5jk3f+iJToK81ZQR
         U+8AdfObwvXeClmskP+fo98FIeck9PDBRYfAaLhFF8IOAkmaAhDanAkyp0NYeTxEWfYL
         jA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wLDEMiLtg33QbJ5mvaQMYVg3nzstwlMUJrGENxt/0uM=;
        b=jLKsqSI79GmMEa7hIGDCXTZtEL7+q7ADYJLYoXUihuk+yjY9CcaTaUE9xxdidZ0yHL
         xSUJk1u1R1TO0Wamkoy2+x0f/721NDh50zHCwE1ZwOwZYcN5AjeAzJf/m15mX8qux8ku
         e4w5lOLqXwDAaFiOeKk60hD/XCuuE+X8kDrkm88vnV8iQo6PFq0dtoWUrL0tRscDlzAc
         lMSs7XMUWA6BsY8ULQ8jPXT93AFGTzEEL1fixTZ879kF/DjfCyYSQ+SLJoBtyAiLLLbk
         6fjNQynZplTYrNHXonkAYe5FfqfVEa/RIC1YB2CB2EVTkURiCWjtgjSSEn22zquRq9JN
         mxFw==
X-Gm-Message-State: ALKqPwd2jtepVe852VZ15GTXjQsWuKhxnQbwvwrZmmMx0RfoXFPx4OCL
        aX4b+rlR/YK6cYSvmr+HgtU=
X-Google-Smtp-Source: AB8JxZpUC40/1WtgO/53jj+A7+FQRp2dhyVZE+5qVR63NXQWY4FEe6DY/QJBiZkNSwNJdDYydqCfqw==
X-Received: by 2002:a2e:5019:: with SMTP id e25-v6mr7683032ljb.122.1526707721207;
        Fri, 18 May 2018 22:28:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 05/15] shallow.c: use commit-slab for commit depth instead of commit->util
Date:   Sat, 19 May 2018 07:28:21 +0200
Message-Id: <20180519052831.12603-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180519052831.12603-1-pclouds@gmail.com>
References: <20180513055208.17952-1-pclouds@gmail.com>
 <20180519052831.12603-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

While at there, plug a leak for keeping track of depth in this code.
---
 shallow.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/shallow.c b/shallow.c
index df4d44ea7a..0301049781 100644
--- a/shallow.c
+++ b/shallow.c
@@ -12,6 +12,7 @@
 #include "commit-slab.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "commit-slab.h"
 
 static int is_shallow = -1;
 static struct stat_validity shallow_stat;
@@ -74,6 +75,11 @@ int is_repository_shallow(void)
 	return is_shallow;
 }
 
+/*
+ * TODO: use "int" elemtype instead of "int *" when/if commit-slab
+ * supports a "valid" flag.
+ */
+define_commit_slab(commit_depth, int *);
 struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		int shallow_flag, int not_shallow_flag)
 {
@@ -82,25 +88,29 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 	struct object_array stack = OBJECT_ARRAY_INIT;
 	struct commit *commit = NULL;
 	struct commit_graft *graft;
+	struct commit_depth depths;
 
+	init_commit_depth(&depths);
 	while (commit || i < heads->nr || stack.nr) {
 		struct commit_list *p;
 		if (!commit) {
 			if (i < heads->nr) {
+				int **depth_slot;
 				commit = (struct commit *)
 					deref_tag(heads->objects[i++].item, NULL, 0);
 				if (!commit || commit->object.type != OBJ_COMMIT) {
 					commit = NULL;
 					continue;
 				}
-				if (!commit->util)
-					commit->util = xmalloc(sizeof(int));
-				*(int *)commit->util = 0;
+				depth_slot = commit_depth_at(&depths, commit);
+				if (!*depth_slot)
+					*depth_slot = xmalloc(sizeof(int));
+				**depth_slot = 0;
 				cur_depth = 0;
 			} else {
 				commit = (struct commit *)
 					object_array_pop(&stack);
-				cur_depth = *(int *)commit->util;
+				cur_depth = **commit_depth_at(&depths, commit);
 			}
 		}
 		parse_commit_or_die(commit);
@@ -116,25 +126,31 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		}
 		commit->object.flags |= not_shallow_flag;
 		for (p = commit->parents, commit = NULL; p; p = p->next) {
-			if (!p->item->util) {
-				int *pointer = xmalloc(sizeof(int));
-				p->item->util = pointer;
-				*pointer =  cur_depth;
+			int **depth_slot = commit_depth_at(&depths, p->item);
+			if (!*depth_slot) {
+				*depth_slot = xmalloc(sizeof(int));
+				**depth_slot = cur_depth;
 			} else {
-				int *pointer = p->item->util;
-				if (cur_depth >= *pointer)
+				if (cur_depth >= **depth_slot)
 					continue;
-				*pointer = cur_depth;
+				**depth_slot = cur_depth;
 			}
 			if (p->next)
 				add_object_array(&p->item->object,
 						NULL, &stack);
 			else {
 				commit = p->item;
-				cur_depth = *(int *)commit->util;
+				cur_depth = **commit_depth_at(&depths, commit);
 			}
 		}
 	}
+	for (i = 0; i < depths.slab_count; i++) {
+		int j;
+
+		for (j = 0; j < depths.slab_size; j++)
+			free(depths.slab[i][j]);
+	}
+	clear_commit_depth(&depths);
 
 	return result;
 }
-- 
2.17.0.705.g3525833791

