Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878661F51C
	for <e@80x24.org>; Sat, 19 May 2018 05:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeESF25 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 01:28:57 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41980 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbeESF2v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 01:28:51 -0400
Received: by mail-lf0-f67.google.com with SMTP id m17-v6so16869878lfj.8
        for <git@vger.kernel.org>; Fri, 18 May 2018 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PiMzE0q/9S4fWPVFdWqOq5uI4S0mI+InvlRMxu+HU6w=;
        b=gJMYwADg/IDKfDm8RdvBMwo5nYqDnSpUeJny5T+n+zK3QR7R+TLgMmayXq0LI5Lfgl
         QFfbRPZge0n5FunHPcXVucGE3LKD1+f1p+KbLR1gDH9QF4agqkDOHvK9CgXKc0j6Pcfc
         drYO7M1Ld2ECJ7/j53fL1Avxr4gjVmFE4wVIwnjLFL+ZQd6bdfNsxG7SgCdAiu/0iP0U
         0uvwvnksn8sVTj6KigydSmXypR6OwvAuIWNvsTebbGP1sOd34+NNdKQiafvvDuOgTTYS
         LG6Hw58sDH/Hg7FUTQfPkhNll48W7aOOI53EOa7U7YH+gM6tHBZmX+/HXGi1QEKtpoxh
         fbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PiMzE0q/9S4fWPVFdWqOq5uI4S0mI+InvlRMxu+HU6w=;
        b=DEgJt6Fx3wMItOesX2lLH1J5jHne32gyf9Cfo1fNrwZ8BL3n8Wn1lcEq514+LHrxNK
         H8GEzIVVnFO1QWAAZcTi6dp+8GAZdv3nrOAh/Mfve1YLgydz0Jtg/oFeCsSjHo9rElDf
         VyAbhEnssiXWHBkWo4kprQQ+7t184zKmVYiahWcmdbrSRMg2MO46lcUxjiypqJU/En1t
         qOMYH9m7ZamrK76eiKvyFvDJBzS6aUlf1LipfWasHB7UEEp6ydsX87WmkAYDBn8NyD0+
         SMVS1Wl1Dx3CF1k5JHHa0wVQZvKW/frw38VODS7+M5OqAXFNzfujLiPGHNNXt1COSP89
         HGjw==
X-Gm-Message-State: ALKqPweGN4j1MOlSz5/Y04ex43YtikgBqDUdXgYewLK+w/EX/6/ZpSzR
        Wud7VzLCNye533kMMH7mU6w=
X-Google-Smtp-Source: AB8JxZqy7Ee60vlklwQyRkOpT8tnlLwAIindurLAkvc3hQndwVpLppzRvMprIJqzLbhtDeZdjhCkhA==
X-Received: by 2002:a19:59c5:: with SMTP id n188-v6mr3073014lfb.79.1526707729841;
        Fri, 18 May 2018 22:28:49 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n5-v6sm1490874ljh.84.2018.05.18.22.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 22:28:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: [PATCH v3 13/15] log: use commit-slab in prepare_bases() instead of commit->util
Date:   Sat, 19 May 2018 07:28:29 +0200
Message-Id: <20180519052831.12603-14-pclouds@gmail.com>
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
---
 builtin/log.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d017e57475..967fbc5caa 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -28,6 +28,7 @@
 #include "mailmap.h"
 #include "gpg-interface.h"
 #include "progress.h"
+#include "commit-slab.h"
 
 #define MAIL_DEFAULT_WRAP 72
 
@@ -1340,6 +1341,8 @@ static struct commit *get_base_commit(const char *base_commit,
 	return base;
 }
 
+define_commit_slab(commit_base, int);
+
 static void prepare_bases(struct base_tree_info *bases,
 			  struct commit *base,
 			  struct commit **list,
@@ -1348,11 +1351,13 @@ static void prepare_bases(struct base_tree_info *bases,
 	struct commit *commit;
 	struct rev_info revs;
 	struct diff_options diffopt;
+	struct commit_base commit_base;
 	int i;
 
 	if (!base)
 		return;
 
+	init_commit_base(&commit_base);
 	diff_setup(&diffopt);
 	diffopt.flags.recursive = 1;
 	diff_setup_done(&diffopt);
@@ -1365,7 +1370,7 @@ static void prepare_bases(struct base_tree_info *bases,
 	for (i = 0; i < total; i++) {
 		list[i]->object.flags &= ~UNINTERESTING;
 		add_pending_object(&revs, &list[i]->object, "rev_list");
-		list[i]->util = (void *)1;
+		*commit_base_at(&commit_base, list[i]) = 1;
 	}
 	base->object.flags |= UNINTERESTING;
 	add_pending_object(&revs, &base->object, "base");
@@ -1379,7 +1384,7 @@ static void prepare_bases(struct base_tree_info *bases,
 	while ((commit = get_revision(&revs)) != NULL) {
 		struct object_id oid;
 		struct object_id *patch_id;
-		if (commit->util)
+		if (*commit_base_at(&commit_base, commit))
 			continue;
 		if (commit_patch_id(commit, &diffopt, &oid, 0))
 			die(_("cannot get patch id"));
@@ -1388,6 +1393,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		oidcpy(patch_id, &oid);
 		bases->nr_patch_id++;
 	}
+	clear_commit_base(&commit_base);
 }
 
 static void print_bases(struct base_tree_info *bases, FILE *file)
-- 
2.17.0.705.g3525833791

