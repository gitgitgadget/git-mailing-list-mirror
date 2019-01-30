Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A750A1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 11:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfA3Lsf (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 06:48:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42653 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfA3Lsf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 06:48:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so10945018plp.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 03:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=clTtnisEtJp6hRAy0x/TLhfQUCf9WYBfVLJ0GExX3ws=;
        b=QHZ7+PZhP1s4DSj1QnZHDSHJ+m7gMbtjlWYlkqPJgyHZqZFWd7Np2E69vF+175lYua
         5FyNy3+Luljn0b5d6W9mdo2XUAxUP6DBTTr8AAwEsA+ASkhPhiQMYqVRobHOx0+/14ol
         gdLhB7FfLVyoCbPJejJYSA2AaTbhQyjngmREU+FXRlgMfP2eIlLoqTmv214E9RwjIu24
         RiZCsc4ySYNYCWnUy06C0ZJn+vGTdij2zN3jybD7YHEpzHTC0Yh0MfIPT8HRtmh2NjEx
         yZIYkt3b50RMoYZkkwB8GnzMF74bk6tKrzkfRFA8Vkp3p3EaVNMnwfgAWjNzV9292SfU
         Kz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clTtnisEtJp6hRAy0x/TLhfQUCf9WYBfVLJ0GExX3ws=;
        b=Dq++bC+HYNaltY/wGj/7GF3y4zBF8e2pLuo0J/CiqiJ86eAzhQthiC2KIyDVbAzl3c
         lPnJo/6mZoTUTALG+xncZQxdi+CmWgjBJ8rrO6QV8KrJPKxvGpwHiR3R23/uTSG9r/QR
         rDcn89IPgnmFx3clIogjKfILPOV//on6ZP7jReBkK88wUR29IbVZSC2oqfd5SccxfAo/
         1sGsONBmG8QptEBdIKrALYCuOm+CaLYFE3p1PJBgeQvKh55rZwT7j8jV1/p7C3sJ8yTL
         SDP+zZhWljeRgNxSvu4AAQjz8LsCe6tmiwsAt9qzWjv+h5jfkZXB/upS6tbycN6Eltqu
         VeVw==
X-Gm-Message-State: AJcUukfN5ikNYTY0rRp8G1pfMcCa+o+0n2NcV1P92PNUiqtVCJl2jgMR
        l0zHy115lTiLijihf2v6g/A=
X-Google-Smtp-Source: ALg8bN4bH5RanLp3wOikBxhs3KMto29ZiqUk1mGLp0DsgZsyd+2lfTdY9YCj9nDDhZiaTnkyHbs3Dg==
X-Received: by 2002:a17:902:830a:: with SMTP id bd10mr30199975plb.321.1548848914468;
        Wed, 30 Jan 2019 03:48:34 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:e2:afd3:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id v191sm2124473pgb.77.2019.01.30.03.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 03:48:33 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 2/6] pack-redundant: delay creation of unique_objects
Date:   Wed, 30 Jan 2019 19:47:32 +0800
Message-Id: <20190130114736.30357-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190112091754.30985-1-worldhello.net@gmail.com>
References: <20190112091754.30985-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Instead of initializing unique_objects in `add_pack()`, copy from
all_objects in `cmp_two_packs()`, when unwanted objects are removed from
all_objects.

This will save memory (no allocate memory for alt-odb packs), and run
`llist_sorted_difference_inplace()` only once when removing ignored
objects and removing objects in alt-odb in `scan_alt_odb_packs()`.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/pack-redundant.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index cf9a9aabd4..f7dab0ec60 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -254,6 +254,11 @@ static void cmp_two_packs(struct pack_list *p1, struct pack_list *p2)
 	struct llist_item *p1_hint = NULL, *p2_hint = NULL;
 	const unsigned int hashsz = the_hash_algo->rawsz;
 
+	if (!p1->unique_objects)
+		p1->unique_objects = llist_copy(p1->all_objects);
+	if (!p2->unique_objects)
+		p2->unique_objects = llist_copy(p2->all_objects);
+
 	p1_base = p1->pack->index_data;
 	p2_base = p2->pack->index_data;
 	p1_base += 256 * 4 + ((p1->pack->index_version < 2) ? 4 : 8);
@@ -536,7 +541,7 @@ static void scan_alt_odb_packs(void)
 	while (alt) {
 		local = local_packs;
 		while (local) {
-			llist_sorted_difference_inplace(local->unique_objects,
+			llist_sorted_difference_inplace(local->all_objects,
 							alt->all_objects);
 			local = local->next;
 		}
@@ -567,8 +572,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 		llist_insert_back(l.all_objects, (const struct object_id *)(base + off));
 		off += step;
 	}
-	/* this list will be pruned in cmp_two_packs later */
-	l.unique_objects = llist_copy(l.all_objects);
+	l.unique_objects = NULL;
 	if (p->pack_local)
 		return pack_list_insert(&local_packs, &l);
 	else
@@ -646,7 +650,6 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 
 	load_all_objects();
 
-	cmp_local_packs();
 	if (alt_odb)
 		scan_alt_odb_packs();
 
@@ -663,10 +666,12 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 	llist_sorted_difference_inplace(all_objects, ignore);
 	pl = local_packs;
 	while (pl) {
-		llist_sorted_difference_inplace(pl->unique_objects, ignore);
+		llist_sorted_difference_inplace(pl->all_objects, ignore);
 		pl = pl->next;
 	}
 
+	cmp_local_packs();
+
 	minimize(&min);
 
 	if (verbose) {
-- 
2.20.1.103.ged0fc2ca7b

