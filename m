Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2484A1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbdAYWD3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:29 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33884 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdAYWDW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:22 -0500
Received: by mail-pf0-f174.google.com with SMTP id e4so60771398pfg.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XwINXru7hVXiRlkcDIk5KGrya/N8/zVALZqNSVKtTpk=;
        b=C+jsgXYsq9bG1wwc3zJ8WQ7sUMYURPJkOCV3MMEw6QnVc6s9eKIBd4hVkdi1KFemze
         kgOcYSG6cjXZHOlvePXLrz9Wooc44ito7ZT6VG6yOe7XsG6c2m40hivh/oL5ywowab8+
         JeaNlb1uZoznjYID5wbghjGQ/ju/VIMCDiUx+8d/SwI7Qq4IVNqS8HhJtInXSGHucRYf
         KwT/w0ULYqchr1MjPajXtFVjn79SEgyMAe749cE4aFLxGSWuU14iLxqpiwTN+cJfr1vI
         VL8fe+f1MntWgGpwIqu7sQE7w49uf9yEswwrfo1no4CXWaXVoX2LBc19Q+W1zsOv2SyD
         KdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=XwINXru7hVXiRlkcDIk5KGrya/N8/zVALZqNSVKtTpk=;
        b=pKwIRRpXygXyOFV18NRHLqr1lxrX6nL8CKZEkTRxpePRqYUT4mOpEWtZmjTWgFKS0t
         HneuA5e9myJ9OYWs8AY6VRa6rQhB46204QOYFP0raM37HZ0TVWalu4LuK7vPVMRbHJKe
         xusJbwfvGIabBe3Wk/q1VekRPwlYflmtUxI3bmF9DFNh1v2az4KUEQdCi4J+GiV9TWh4
         MiGy4NiU+cPBDG0zlMkquoWExegXdID/Sq0glQo+Vd2YnK9pDOwjZXPugPrIokDw3EYR
         bY5QMSNiic7a3PCR7hMYYVbzwX73Q2TJdx6ZxbKm9K2FFsfbGoHfRAKGRcxGKQcYyH9E
         5njA==
X-Gm-Message-State: AIkVDXJVSIjMDYF1w7irZFRvugSyGxfQHJFk4sL6KlOR0RDOC8If9Tk+lMh9v07wj48cdJVK
X-Received: by 10.98.192.216 with SMTP id g85mr48756101pfk.117.1485381801570;
        Wed, 25 Jan 2017 14:03:21 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:20 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 04/14] fetch: refactor the population of hashes
Date:   Wed, 25 Jan 2017 14:02:57 -0800
Message-Id: <057e40c56d7bbaf581c9552b45315087cb0f5ed3.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Populate SHA-1 ref hashes in get_ref_map instead of do_fetch. Besides
tightening scopes of variables in the code, this also prepares for a
future patch where get_ref_map is called multiple times within do_fetch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f1570e346..c71d5eb9b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -316,6 +316,8 @@ static struct ref *get_ref_map(struct transport *transport,
 
 	const struct ref *remote_refs = transport_get_remote_refs(transport);
 
+	struct string_list existing_refs = STRING_LIST_INIT_DUP;
+
 	if (refspec_count) {
 		struct refspec *fetch_refspec;
 		int fetch_refspec_nr;
@@ -411,7 +413,23 @@ static struct ref *get_ref_map(struct transport *transport,
 		tail = &rm->next;
 	}
 
-	return ref_remove_duplicates(ref_map);
+	ref_map = ref_remove_duplicates(ref_map);
+
+	for_each_ref(add_existing, &existing_refs);
+	for (rm = ref_map; rm; rm = rm->next) {
+		if (rm->peer_ref) {
+			struct string_list_item *peer_item =
+				string_list_lookup(&existing_refs,
+						   rm->peer_ref->name);
+			if (peer_item) {
+				struct object_id *old_oid = peer_item->util;
+				oidcpy(&rm->peer_ref->old_oid, old_oid);
+			}
+		}
+	}
+	string_list_clear(&existing_refs, 1);
+
+	return ref_map;
 }
 
 #define STORE_REF_ERROR_OTHER 1
@@ -1055,14 +1073,10 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
-	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct ref *ref_map;
-	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
 
-	for_each_ref(add_existing, &existing_refs);
-
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
 			tags = TAGS_SET;
@@ -1084,18 +1098,6 @@ static int do_fetch(struct transport *transport,
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
-	for (rm = ref_map; rm; rm = rm->next) {
-		if (rm->peer_ref) {
-			struct string_list_item *peer_item =
-				string_list_lookup(&existing_refs,
-						   rm->peer_ref->name);
-			if (peer_item) {
-				struct object_id *old_oid = peer_item->util;
-				oidcpy(&rm->peer_ref->old_oid, old_oid);
-			}
-		}
-	}
-
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (prune) {
@@ -1132,7 +1134,6 @@ static int do_fetch(struct transport *transport,
 	}
 
  cleanup:
-	string_list_clear(&existing_refs, 1);
 	return retcode;
 }
 
-- 
2.11.0.483.g087da7b7c-goog

