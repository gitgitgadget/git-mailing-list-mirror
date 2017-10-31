Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A101FAED
	for <e@80x24.org>; Tue, 31 Oct 2017 00:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753732AbdJaAeE (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 20:34:04 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:56703 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753721AbdJaAeC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 20:34:02 -0400
Received: by mail-io0-f196.google.com with SMTP id m81so31295992ioi.13
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 17:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X8u8ccSw+aolmvJV2n63ujzlvdygeTW6u3Ow9KEsJ4c=;
        b=J4lgh/4Zh0Ay8GPS9VHMhtIGEiiFvZaPdm9nQH60K/1FdUZId7ojyTOJDq906AjW/g
         kwrvPFitOKfXHtsPLcraMTcw4sUHVS6NuWOztR7Mube1mRNTQ9wnQe3nV95rsnNyLjnm
         VFXoNe87Br/xB7VlJ/0ad0PaHJKf8W2Ph3KqA187Lw6XYagzJAS75Kmcl49jPS/i7xwQ
         nLnLPGtjtpHqeAOPik2SnkUvEtJHR64sRkTVIlO0RopG2zwW3TWMFO0QRcUxZKMbY7Ja
         vm5HTcMli7F7sM1JSfnzcbU7Cob27Iujjs9y9mQ+hKet/Tzsi52eG2+KB/FDgTpBzyCr
         p7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X8u8ccSw+aolmvJV2n63ujzlvdygeTW6u3Ow9KEsJ4c=;
        b=DMgNyKbDO1tK+/9iLzl7Zx2NJ5+Tep7rd9CakmVN1hacbQD/LJ+67FGC1UowsW95LV
         /fWzlVXorrbR7SaTfNqZmZs4vpGMIcJg/D3bHNw8YSXwHFuuXaoopYavQ/Ur6TVs2cIr
         e52gS9Ix7PFnerEAgXRCGPUBqV40O3VwGvB1l9xB+Ld9NuHLPGvSox/e/h5BTxNNJ5DQ
         ta5vPjzwUv14+JtwCqLr2j+XYnKlod2jdj8DFJm6OFL+o0pOoERdFBaVGZ19K2XOTdxd
         iDUaxdXpdhZxoPHa24rUzrGPqry5RwhjGvxwL3B57ikQpTMKKDzTDFkHTSgOAZwe1U4m
         TLpQ==
X-Gm-Message-State: AMCzsaXfCIH/zLKp/EU/sjga6QMyko4Qfm5V5y5X1zBes7KcqRA4Udzu
        gNjUm4MIWltLD5sUjnLd54h7/w==
X-Google-Smtp-Source: ABhQp+TuHc5oOuutTaW8OYnI5vn3rnCfxf6UPQ9cWEqtQ17RujzEu8RU+68d5z6NscL6Kjm23Jt6kA==
X-Received: by 10.36.124.197 with SMTP id a188mr714920itd.53.1509410041457;
        Mon, 30 Oct 2017 17:34:01 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:58cb:1473:3cb:a95f])
        by smtp.gmail.com with ESMTPSA id l97sm87955iod.81.2017.10.30.17.34.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 17:34:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH 1/7] list-objects.c: factor out traverse_trees_and_blobs
Date:   Mon, 30 Oct 2017 17:33:45 -0700
Message-Id: <20171031003351.22341-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031003351.22341-1-sbeller@google.com>
References: <20171028004419.10139-1-sbeller@google.com>
 <20171031003351.22341-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With traverse_trees_and_blobs factored out of the main traverse function,
the next patch can introduce an in-order revision walking with ease.

The variable holding the base path is only used in the newly factored out
function `traverse_trees_and_blobs`, however we keep its scope to
`traverse_commit_list` to keep the number of invocations for memory
allocations and release to one per commit traversal.  Rename the variable
to `base_path` for clarity.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 list-objects.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index b3931fa434..bf46f80dff 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -183,25 +183,13 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
 
-void traverse_commit_list(struct rev_info *revs,
-			  show_commit_fn show_commit,
-			  show_object_fn show_object,
-			  void *data)
+static void traverse_trees_and_blobs(struct rev_info *revs,
+				     struct strbuf *base_path,
+				     show_object_fn show_object,
+				     void *data)
 {
 	int i;
-	struct commit *commit;
-	struct strbuf base;
 
-	strbuf_init(&base, PATH_MAX);
-	while ((commit = get_revision(revs)) != NULL) {
-		/*
-		 * an uninteresting boundary commit may not have its tree
-		 * parsed yet, but we are not going to show them anyway
-		 */
-		if (commit->tree)
-			add_pending_tree(revs, commit->tree);
-		show_commit(commit, data);
-	}
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
 		struct object *obj = pending->item;
@@ -218,17 +206,39 @@ void traverse_commit_list(struct rev_info *revs,
 			path = "";
 		if (obj->type == OBJ_TREE) {
 			process_tree(revs, (struct tree *)obj, show_object,
-				     &base, path, data);
+				     base_path, path, data);
 			continue;
 		}
 		if (obj->type == OBJ_BLOB) {
 			process_blob(revs, (struct blob *)obj, show_object,
-				     &base, path, data);
+				     base_path, path, data);
 			continue;
 		}
 		die("unknown pending object %s (%s)",
 		    oid_to_hex(&obj->oid), name);
 	}
 	object_array_clear(&revs->pending);
-	strbuf_release(&base);
+}
+
+void traverse_commit_list(struct rev_info *revs,
+			  show_commit_fn show_commit,
+			  show_object_fn show_object,
+			  void *data)
+{
+	struct commit *commit;
+	struct strbuf base_path;
+	strbuf_init(&base_path, PATH_MAX);
+
+	while ((commit = get_revision(revs)) != NULL) {
+		/*
+		 * an uninteresting boundary commit may not have its tree
+		 * parsed yet, but we are not going to show them anyway
+		 */
+		if (commit->tree)
+			add_pending_tree(revs, commit->tree);
+		show_commit(commit, data);
+	}
+	traverse_trees_and_blobs(revs, &base_path, show_object, data);
+
+	strbuf_release(&base_path);
 }
-- 
2.15.0.rc2.443.gfcc3b81c0a

