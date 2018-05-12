Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5C81F42D
	for <e@80x24.org>; Sat, 12 May 2018 08:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750812AbeELIAi (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 04:00:38 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38975 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeELIAf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 04:00:35 -0400
Received: by mail-lf0-f67.google.com with SMTP id j193-v6so11055775lfg.6
        for <git@vger.kernel.org>; Sat, 12 May 2018 01:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aiSGRsz7NqNkbrM2uicsYl/yITIdcJlwsBWN+hKXmlA=;
        b=apQmpArRs3OUEuIKdnFPE5oLaTqWEXoO7wpogiF1MzcYHOZ3fRvRD5EUIJW7yrHyul
         gPCGN+E/l/0jYwHlX2NwaZMOlYK/6Ec48Y/Tbvguyt0QesHm3xuAExvIC0psHVmsHDlc
         Tm/c4IXWfM2QKmc1WaLJzhzWAQqv55OcSISuJt8ugOUukdXPB3pFVIFsbzMKmmi4jtFb
         4ksYnOaC6ggojg+MdV+f6DBQ/LUR/ucX1McxRz6KjkWNVeIC1KsA17ACFLpThRftK5Y5
         eVl4z07I/ZVoxJVqMnvXNnRYIOUHiFbfh8rNsZbLMyfVS/He+QJlmlBlV+6/5V1rt6o1
         2mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiSGRsz7NqNkbrM2uicsYl/yITIdcJlwsBWN+hKXmlA=;
        b=c+oA12IbHH60n/feFKQibZ3M4qKPXdgXVjPwZTF/xxN19GLLRx7LSoS29QiIK/FpzQ
         Wzr2yDvDe4VXDDuqV/gnH/4LP/mz23nxgcit1UuEf3+ygvPOKIyELO3dFrwxEIqV/W5J
         Q/yXis0yv6GALefKx6qyGt2nRglzava/jion99sjBMVnnELYNYcYIJNmBAn55P/9iGLy
         twCVHfc+CuDrj4TECTZucRt8NBfUAgRjvoDKX3Ysk9I3lf68JhRAABFELUSjVlEx2PtC
         j4ToWhlahitC/s5UaIjRodrc6gdv0vDWkmVvhaijZ8QWaPYUqxPeixmeAEf01Fu35kCl
         W3tQ==
X-Gm-Message-State: ALKqPweDB4/Sc2pMWMLsxvI8uJ5GXxdIubeMtnpAnm5sYuashM35YJWL
        yH1t9VTuS/2K42eVuv162pi6zA==
X-Google-Smtp-Source: AB8JxZroT9jrQLbhsHmvCemfweRwHV7fxvNKVJeSvbNyEisVXA9wf2zBU20TCkSE3KvxzC4Z/tf8Yw==
X-Received: by 2002:a2e:4949:: with SMTP id b9-v6mr541064ljd.116.1526112034057;
        Sat, 12 May 2018 01:00:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i20-v6sm1055369lfe.69.2018.05.12.01.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 01:00:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/12] describe: use commit-slab for commit names instead of commit->util
Date:   Sat, 12 May 2018 10:00:18 +0200
Message-Id: <20180512080028.29611-3-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/describe.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index b5afc45846..1b6ca42553 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -15,9 +15,12 @@
 #include "run-command.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "commit-slab.h"
 
 #define MAX_TAGS	(FLAG_BITS - 1)
 
+define_commit_slab(commit_names, struct commit_name *);
+
 static const char * const describe_usage[] = {
 	N_("git describe [<options>] [<commit-ish>...]"),
 	N_("git describe [<options>] --dirty"),
@@ -37,6 +40,7 @@ static struct string_list patterns = STRING_LIST_INIT_NODUP;
 static struct string_list exclude_patterns = STRING_LIST_INIT_NODUP;
 static int always;
 static const char *suffix, *dirty, *broken;
+static struct commit_names commit_names;
 
 /* diff-index command arguments to check if working tree is dirty. */
 static const char *diff_index_args[] = {
@@ -321,11 +325,14 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	if (!have_util) {
 		struct hashmap_iter iter;
 		struct commit *c;
-		struct commit_name *n = hashmap_iter_first(&names, &iter);
+		struct commit_name *n;
+
+		init_commit_names(&commit_names);
+		n = hashmap_iter_first(&names, &iter);
 		for (; n; n = hashmap_iter_next(&iter)) {
 			c = lookup_commit_reference_gently(&n->peeled, 1);
 			if (c)
-				c->util = n;
+				*commit_names_at(&commit_names, c) = n;
 		}
 		have_util = 1;
 	}
@@ -336,8 +343,11 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 	while (list) {
 		struct commit *c = pop_commit(&list);
 		struct commit_list *parents = c->parents;
+		struct commit_name **slot;
+
 		seen_commits++;
-		n = c->util;
+		slot = commit_names_peek(&commit_names, c);
+		n = slot ? *slot : NULL;
 		if (n) {
 			if (!tags && !all && n->prio < 2) {
 				unannotated_cnt++;
-- 
2.17.0.705.g3525833791

