Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6BC1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030418AbeF2BXj (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:39 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:53716 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030394AbeF2BXh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:37 -0400
Received: by mail-it0-f73.google.com with SMTP id h195-v6so474123itb.3
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hdWoGetGweVAFkeYI2s2faUYfB0ES/5sEXUkVi7dH4s=;
        b=DE4e5AvYE91GYjNsDunzu2zkb3blnS08muOH2s+5mHl1v3vTYl9D+RvZ3o6njSjm5E
         IMh5DrB+NEjGnhLn9t2VUMC2hERvNBoG5IgsC5w6alzKOMT5bQCxXSX9trbTfaFaAvIl
         O+4MGAAlDUiI2MbrBj8nRn2eKaMI75ahB5Sf0/Vl2cbsOBi5yCVTHbJK9J8BKTstWSvQ
         gSlIP1+JAX87rCOFPqMG46VW2sbomMYeNr3QORQOWW0lsy8KasNeOgFl6h1Z5EeLmNH/
         BRLoTgF4y9hflqbjYeYPs6W8VEq9/9oN7TQZDlQGo1fLxgcWGTpNrXJ4nrPhbImLOeMm
         j1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hdWoGetGweVAFkeYI2s2faUYfB0ES/5sEXUkVi7dH4s=;
        b=aUqQpISS5FRqv5Lj/QqLlqGpR1/dOzQOyNoLQvxmRle3YRSXobVOOPrSAKb61eXFtG
         grMMVeYbSZSSimJcyrq+EHJtyGTb2GVEe+PP980dajQ/+iUgs8CNh5eqxIRuLUXT9N22
         5T9P+o3oLfJuwBuVtgAGWlbR43hAauL6O574u5ALmvLRo/xm2nhjDGy5z1O8cpk8cJZ8
         EaQFfhTt+cV9A1Z9hoUVMRFGt6oNR66m0sxSobgOz4Wu+icOl+Yz+H00nkb2d3p6MQoQ
         jF3aDd6wFXlA4iScMjWzRiMN65y8sESl5EuvZrp1y7A2q9WKn03w0XAkBRZf4P2l550o
         vulg==
X-Gm-Message-State: APt69E1QIpc+3BAtfAtozff66jx47jh07rpDRiHmISeU5H/EobVPQ7D3
        ivWMwkemFXI+ZF1mZLqEZ4aCRPMi74liAe4ZZzMxbLCKhK1dzJ/CXk9HLIIdbdZvED3UsH1+Y+1
        LQ2BO1Ap4ItZ10TTZd8M+7ET9kYVpgMLO/Zj3G3dUR2rrprUk+4Qo6Mp+ZgWH
X-Google-Smtp-Source: AAOMgpcaT3ZsvkDSsZ+QpZgdEGgfnM/4LI4ZFJY7F5PgRFJgS2aiH5zUxcS8ONqDJBMLGF0dHB01fqelwAfa
MIME-Version: 1.0
X-Received: by 2002:a24:2c43:: with SMTP id i64-v6mr77479iti.25.1530235416979;
 Thu, 28 Jun 2018 18:23:36 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:18 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-29-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 28/32] object.c: allow parse_object_buffer to handle
 arbitrary repositories
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 18 +++++++++---------
 object.h |  3 +--
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/object.c b/object.c
index 9d588448192..cd870fee22b 100644
--- a/object.c
+++ b/object.c
@@ -185,21 +185,21 @@ struct object *lookup_unknown_object(const unsigned char *sha1)
 	return obj;
 }
 
-struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
+struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
 {
 	struct object *obj;
 	*eaten_p = 0;
 
 	obj = NULL;
 	if (type == OBJ_BLOB) {
-		struct blob *blob = lookup_blob(the_repository, oid);
+		struct blob *blob = lookup_blob(r, oid);
 		if (blob) {
 			if (parse_blob_buffer(blob, buffer, size))
 				return NULL;
 			obj = &blob->object;
 		}
 	} else if (type == OBJ_TREE) {
-		struct tree *tree = lookup_tree(the_repository, oid);
+		struct tree *tree = lookup_tree(r, oid);
 		if (tree) {
 			obj = &tree->object;
 			if (!tree->buffer)
@@ -211,20 +211,20 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
 			}
 		}
 	} else if (type == OBJ_COMMIT) {
-		struct commit *commit = lookup_commit(the_repository, oid);
+		struct commit *commit = lookup_commit(r, oid);
 		if (commit) {
-			if (parse_commit_buffer(the_repository, commit, buffer, size, 1))
+			if (parse_commit_buffer(r, commit, buffer, size, 1))
 				return NULL;
-			if (!get_cached_commit_buffer(the_repository, commit, NULL)) {
-				set_commit_buffer(the_repository, commit, buffer, size);
+			if (!get_cached_commit_buffer(r, commit, NULL)) {
+				set_commit_buffer(r, commit, buffer, size);
 				*eaten_p = 1;
 			}
 			obj = &commit->object;
 		}
 	} else if (type == OBJ_TAG) {
-		struct tag *tag = lookup_tag(the_repository, oid);
+		struct tag *tag = lookup_tag(r, oid);
 		if (tag) {
-			if (parse_tag_buffer(the_repository, tag, buffer, size))
+			if (parse_tag_buffer(r, tag, buffer, size))
 			       return NULL;
 			obj = &tag->object;
 		}
diff --git a/object.h b/object.h
index f54a892bd10..38198bb73a1 100644
--- a/object.h
+++ b/object.h
@@ -138,8 +138,7 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
  * parsing it.  eaten_p indicates if the object has a borrowed copy
  * of buffer and the caller should not free() it.
  */
-#define parse_object_buffer(r, o, t, s, b, e) parse_object_buffer_##r(o, t, s, b, e)
-struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
+struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
 
 /** Returns the object, with potentially excess memory allocated. **/
 struct object *lookup_unknown_object(const unsigned  char *sha1);
-- 
2.18.0.399.gad0ab374a1-goog

