Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BADB1F453
	for <e@80x24.org>; Sat,  2 Feb 2019 13:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfBBNbC (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 08:31:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33547 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfBBNbB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 08:31:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so4310488pgu.0
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 05:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=clTtnisEtJp6hRAy0x/TLhfQUCf9WYBfVLJ0GExX3ws=;
        b=JFS4iL5oCuo5GwkXPO9Z5qaPXPBrsws5bOOQ5kRwlXjbsqGS16V5wf78YueSqIkv2N
         FwuzVv86a36XV6AAWjOWI0jCJWsKsJg2uRyG9Z8OdvFfIvtIBxQzsWqDyTack/I2k4gs
         FjBgySdxLsCArW0mwZ64XFIaSn0ynqBZcxuy2OrmS7lIgwDL9+yxMVbjQyOwQlmAUJ+b
         z46X/dEzQy2ciwrLJrousU5PlmLPCXTsS8lh6PVhf22ofBCfv4JTK8c4x7CbvXeZP8sn
         sOM+eBKCuqhxncpnvo+XPgUQZPAi6vc/44zz1GU0HGMvEI93tBzpRPtizGloYi/83izD
         aFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clTtnisEtJp6hRAy0x/TLhfQUCf9WYBfVLJ0GExX3ws=;
        b=VA4sRieoDfVzCiA1c4d68pA1Sppn3HwppiKA+7g++iqqteEpn8pNfvLCpyVd24wzmG
         JhNJ0Z3EYAYsN1+ZnDExS0sOQa/iNeqtcwW+n8Re42XrL+pb+wsgUlTnjZfheLPf+oXx
         QpiQ1Yra0gMsctSM8xnocps44+ZxAWC2leDsQEL9lfpuP+s0EpoDu3xfTcZ7bFD/kZ3T
         mKZBTxjjcZylsjDr0EuwU6wVoHcCh3VnG/iznGj9xdOxb7Kf/GZb4ue7qtoGQ3lpAIh8
         Ri2+VzrWOtKYw1kW+gjhK2OTRptzhWMlv6aOaPqYFs2j9+pOrdV3t0/NvQrR5DjWCIYd
         cYcg==
X-Gm-Message-State: AJcUukfoWDssLXSsFm929fYgJWdi67nXhzcmLdzguHnxY59LB/p+v32S
        zCHx3zTr0j11RZAnt5iMFkg=
X-Google-Smtp-Source: ALg8bN6LeeVAiXReuh95VEe9a6ZKISleyZ4UlK5yEi5IoCM2AHhpaaedcH070SrnYmHJoHe35GzgRQ==
X-Received: by 2002:a62:345:: with SMTP id 66mr43357060pfd.189.1549114260856;
        Sat, 02 Feb 2019 05:31:00 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:c5:f1ee:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id t21sm12580010pgg.24.2019.02.02.05.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 05:31:00 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Sun Chao <16657101987@163.com>
Subject: [PATCH v10 2/6] pack-redundant: delay creation of unique_objects
Date:   Sat,  2 Feb 2019 21:30:13 +0800
Message-Id: <20190202133017.1039-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <CAPig+cQh5TDKVaDi0gg9LZTo1Og_Qw6S2sH9cPABR9q05gEUfg@mail.gmail.com>
References: <CAPig+cQh5TDKVaDi0gg9LZTo1Og_Qw6S2sH9cPABR9q05gEUfg@mail.gmail.com>
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

