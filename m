Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CEB61F516
	for <e@80x24.org>; Fri, 29 Jun 2018 01:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030425AbeF2BXo (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 21:23:44 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:47179 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030419AbeF2BXk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 21:23:40 -0400
Received: by mail-yb0-f201.google.com with SMTP id d6-v6so5768389ybn.14
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=iQ035MjIFNPj764rsMUtja9kir96e+s6VMa5Ofxt9G0=;
        b=hkCcQ63sWZ5nkiiEEssS4yq32X8727Zfb33/YtdHgPmkZqs+jxry+COduaz9xDuL+S
         1st0xx6fc+2MwJbbouaJO5fpqvJ/w/I2rieq5a6XTeuMGX/7fOZ/fCYbxLaEnnEbk8iq
         8Wq/twIEq1lLKs1qRSlKgtxcyNSZ0WOsRnosFj9Mc2nqMG2hDoi/kP38Gc+A0weCQB5Y
         6Ac6msVWGVgYMkmljvjPR5LlDgC8bwT/G3ZmHkEKS0VbOeKPR3/EBjeYBEyYOAygaU+W
         SsKQjhZx/UNK90E9Ijs5UG3YP6+Zls71TSNsp5HWWFEJufk4zvSJ/JFYGBsfwazrfzCt
         li/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=iQ035MjIFNPj764rsMUtja9kir96e+s6VMa5Ofxt9G0=;
        b=Uc7SAdJprkjzB4VOTD6mucwwBfZtgfULyK7doJIugFZw8JEg4IYTydyOLEE0yMSQUH
         I8yag3VZy7QEo8dI0BKCN5rp04TvoxEqSbEfqWIxfUVTU/iMd4noPNRTcks5sUJDdwXv
         EJyO5xYQCEhMFMUK7S0LFMl5JOVhfwuzIKxAzuLuCpMVJptQCXuJKtlAli4nrp/VLbQN
         GJPCCwgeT15Iu+i2qW9zYk/u389Mex/RbOttPs0FGStDJKIcgKmidBBEKzVhBeOQ6j6f
         Wfu+JN9Kob2v+/p3EMhGhb8aWJ33hQeXcG3fzEKLDMSSSxX1+Vhd0EKDAmarfV0/7agV
         JNuw==
X-Gm-Message-State: APt69E2lkdT7ja63a61xDqeDWPvamhPLpdPQhecXn+SAFKGUs4EabvC+
        4Udl02Mg/SWh7ng5K22GS2tWVyGTq8qsQ9MxwKCCarJykap2Js5KCu7zYpvn18+J0F5+Kz4Zy2I
        JLCh9yRON1YzQvo+1Yrubw+Gr7ImJdnWwwR9QGhvnG2b1fFSph+GmIStmE2mQ
X-Google-Smtp-Source: AAOMgpc8POfDkaOUWkq1taeLKweWQVjLVIP65T4iLmGsCvUppkfoDPlvRwdjmJ5ATlnd8pR7Ukx5Jf6c8S90
MIME-Version: 1.0
X-Received: by 2002:a81:b663:: with SMTP id h35-v6mr2452092ywk.77.1530235419344;
 Thu, 28 Jun 2018 18:23:39 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:22:19 -0700
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Message-Id: <20180629012222.167426-30-sbeller@google.com>
References: <20180629012222.167426-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v3 29/32] object.c: allow parse_object to handle arbitrary repositories
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
 object.c | 14 +++++++-------
 object.h |  3 +--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/object.c b/object.c
index cd870fee22b..b0faab85d40 100644
--- a/object.c
+++ b/object.c
@@ -245,28 +245,28 @@ struct object *parse_object_or_die(const struct object_id *oid,
 	die(_("unable to parse object: %s"), name ? name : oid_to_hex(oid));
 }
 
-struct object *parse_object_the_repository(const struct object_id *oid)
+struct object *parse_object(struct repository *r, const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
 	int eaten;
-	const struct object_id *repl = lookup_replace_object(the_repository, oid);
+	const struct object_id *repl = lookup_replace_object(r, oid);
 	void *buffer;
 	struct object *obj;
 
-	obj = lookup_object(the_repository, oid->hash);
+	obj = lookup_object(r, oid->hash);
 	if (obj && obj->parsed)
 		return obj;
 
 	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
 	    (!obj && has_object_file(oid) &&
-	     oid_object_info(the_repository, oid, NULL) == OBJ_BLOB)) {
+	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
 		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
 			error("sha1 mismatch %s", oid_to_hex(oid));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(the_repository, oid), NULL, 0);
-		return lookup_object(the_repository, oid->hash);
+		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
+		return lookup_object(r, oid->hash);
 	}
 
 	buffer = read_object_file(oid, &type, &size);
@@ -277,7 +277,7 @@ struct object *parse_object_the_repository(const struct object_id *oid)
 			return NULL;
 		}
 
-		obj = parse_object_buffer(the_repository, oid, type, size,
+		obj = parse_object_buffer(r, oid, type, size,
 					  buffer, &eaten);
 		if (!eaten)
 			free(buffer);
diff --git a/object.h b/object.h
index 38198bb73a1..fa5ca975678 100644
--- a/object.h
+++ b/object.h
@@ -124,8 +124,7 @@ void *object_as_type(struct repository *r, struct object *obj, enum object_type
  *
  * Returns NULL if the object is missing or corrupt.
  */
-#define parse_object(r, oid) parse_object_##r(oid)
-struct object *parse_object_the_repository(const struct object_id *oid);
+struct object *parse_object(struct repository *r, const struct object_id *oid);
 
 /*
  * Like parse_object, but will die() instead of returning NULL. If the
-- 
2.18.0.399.gad0ab374a1-goog

