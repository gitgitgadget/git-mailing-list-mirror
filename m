Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D86141F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeELIBL (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:01:11 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44940 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeELIAg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:36 -0400
Received: by mail-lf0-f66.google.com with SMTP id h197-v6so11032562lfg.11
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTUSlvU06U3gLJdKvfGV5bXnBCMcWW5OyCfSGjwTIx8=;
        b=tDA80Wfns/9/+fnLLk0oR/wUZck7I71x5k88DfGSDTH3AJfUDSsgSVu7hLa0g8U8WL
         5JV4RmyAfTmk8TxIWlPdNTW17Js1HYvmCeyg0RsLkuQ/e1PKDWbwvi1h/tupAtehu+Q0
         hP4VAEEzmEC1wGNbenMr/Hi8Kx7Cq23H98eV263KbPS1A4SpSQVTf9YbVIFV0549sMZ8
         GaC+1RYNeURcQDETBj6wlfIYE9ewyPOPJQB36FCik5qfIm9aOC/l0gF50OhCDiVM8pkq
         DTWcSsqo4YNF8yBFadVqXNwUd0qUBEv8tXOcmcvWKf3zD+xd7Kele0i4Xi6mKm5loG3m
         MpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTUSlvU06U3gLJdKvfGV5bXnBCMcWW5OyCfSGjwTIx8=;
        b=cJO64PbH3DVNCAH5v6LjzvTVD//276NvGvSRqH5WNX4FDpWtTOfGCimHA+z2iv3UIl
         Qto/BA15IVRlzuUpZruwhwb72Vh+wy2OWT+emFHGO2mLm7j7xHCp4EFbIa3A88RDcJsK
         LzllurPY43Lz0pCOV8rtjf1Xei+KFlwQ2nvLwzvniYHlXtveulpnbVjqykBk8w+Shty2
         jQwuKE1AfL5UhFZfso1dCxl/7Av13vcrRkvnJQ2Qvk47BBmpmBmi1uCKgIgaVvdINI4z
         s1f6Y1oB8l24OSCUZJ0b4VJlHtcQjnRrbz8ZyLWAmv9a9Yvv+qedh5CYbGkwFk6DM0ZV
         LmRA==
X-Gm-Message-State: ALKqPwfSSwuSgvyRWMCZ82P5BJw04y5DoOlqKiF6FSyj3xUZRX3pAtZK
        skVAZmpvTdLIE6KdlZWeuFM8Hg==
X-Google-Smtp-Source: AB8JxZqMh+30Ap9NP31/vtejAMrmsMvVWiAMaW/BpnJuuHp16JRwY/OnPOyhw5ocoU2kZuZIejnpXg==
X-Received: by 2002:a2e:6808:: with SMTP id c8-v6mr489313lja.109.1526112035005;
        Sat, 12 May 2018 01:00:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/12] shallow.c: use commit-slab for commit depth instead of commit->util
Date:   Sat, 12 May 2018 10:00:19 +0200
Message-Id: <20180512080028.29611-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

While at there, plug a leak for keeping track of depth in this code.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 shallow.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/shallow.c b/shallow.c
index df4d44ea7a..6ea411b0d2 100644
--- a/shallow.c
+++ b/shallow.c
@@ -12,6 +12,7 @@
 #include "commit-slab.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "commit-slab.h"
 
 static int is_shallow = -1;
 static struct stat_validity shallow_stat;
@@ -74,6 +75,7 @@ int is_repository_shallow(void)
 	return is_shallow;
 }
 
+define_commit_slab(commit_depth, int *);
 struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		int shallow_flag, int not_shallow_flag)
 {
@@ -82,25 +84,29 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
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
+				cur_depth = **commit_depth_peek(&depths, commit);
 			}
 		}
 		parse_commit_or_die(commit);
@@ -116,25 +122,32 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
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
+				depth_slot = commit_depth_peek(&depths, commit);
+				cur_depth = **depth_slot;
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

