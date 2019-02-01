Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD4C1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 16:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfBAQW3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 11:22:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45652 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbfBAQW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 11:22:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so3422352pfd.12
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=clTtnisEtJp6hRAy0x/TLhfQUCf9WYBfVLJ0GExX3ws=;
        b=I6kOUmDxMMh0AdfHrn6C+3ta9V4FXdxEw42D9/yd8uBgSK2vKLAJZ/bqhURjeAU3Mj
         XiQmhvkNDBZXoixsOrXXMx0Uatm2yV9MC1PkALOPEJV2ifa3+b1Y3pILtVi0lHagGFj7
         VZQZ3p97wGJRxuxQR7i4Sg+IrgJmHdqJFTgFF/RqkShGRl4KpM01r7n8zo6U2bDOiLVd
         nN72v4iFeULn+vflMFJHY8YDsUEGZPLfvzqdasvQtXzv/eGLzuFramemeGaKpg50LDuE
         8iIBJodyV0P5Ed30PdzSKZBerBm7jPxvOqxaBJYuha67vvCpQ0rFeWHJgop/2l4FKOnE
         7j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clTtnisEtJp6hRAy0x/TLhfQUCf9WYBfVLJ0GExX3ws=;
        b=LMkZ22itv+A21m1y4a6KMhr6p3vxjhXyRC5Yy/fJEMCnFfF/63knRDFqiUdXhlv3jg
         akvjTie8q0w0IxziaFyXLCUoab46Td99so8sNCs3ELrzvqKeyW7PVcjc8S5xIiQvb18k
         8gPXQSpBagatDvP9+r7vR/w5l/6x68eriBVAxcIfid1zgGhwSJeKq7LupF83+LpJlXvN
         fZLlXUWRahDfCuQ1c6c2L4xk47P8S+PfNrOY2dpR2y6bqt8vW9RUG18KKC9QmwCR8ynn
         mVtuh49jq28Nmaq0vOZlFYqQ8qC4QvFNPwxkBYa2G1pUwORmmqrK/2jTO1YC2U/RApLb
         y8ng==
X-Gm-Message-State: AJcUukcv39sy/Z9ptleJd/RDcZPYfv7M3UTpgm1ZM8KrpukjVqFqFzBz
        A+mQNBp0yh7nhgq/5sv3/nc=
X-Google-Smtp-Source: ALg8bN5vAkyMTSi/El9sZKWC47C3M0qmcu+aArZwPyiQkzMSWXFiWPcZHckVrcy/DhlZ1BDIlkfb/Q==
X-Received: by 2002:aa7:8045:: with SMTP id y5mr39634853pfm.62.1549038148707;
        Fri, 01 Feb 2019 08:22:28 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:1:ce70:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id x2sm11872694pfx.78.2019.02.01.08.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 08:22:27 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v9 2/6] pack-redundant: delay creation of unique_objects
Date:   Sat,  2 Feb 2019 00:21:48 +0800
Message-Id: <20190201162152.31136-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <20190130114736.30357-1-worldhello.net@gmail.com>
References: <20190130114736.30357-1-worldhello.net@gmail.com>
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

