Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EE01F403
	for <e@80x24.org>; Wed, 13 Jun 2018 23:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936042AbeFMXGq (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 19:06:46 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:57116 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935843AbeFMXGl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 19:06:41 -0400
Received: by mail-qt0-f202.google.com with SMTP id f8-v6so3105962qtb.23
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/cOovjPCNgdsesbdEpZp7kQhUqqlS1wZ2AKw2u93bfw=;
        b=ZwxpU/02MSI08SCvWZ+CecWTqTGA10jO77+td4eBsNYvhQg7jU+uyEKMQxxiu9NyrT
         i1r0ev/+/JlYbEFKWU8ONGmwSjGuKhGKz414bXNdIYXiz8rMOHcl5Gic6x9lg2f1KYVE
         U+fBruHLpaNvlQpH9QNuxcTCeYWKn5AONp+88tjTejwN8S94huYWEyBUVI1GmEU9W3fK
         rmjLULwe3YFwvmtWuov3ny7puLBO4oWjCTEVXULXjuAbHISQkCklvr4MBo6k3cB5Zw5s
         gx64sjvYyogee9htKGT0OVVscB5HPCuPjyEF+QnLiVWA3YtNwC3R0yLwo62cnTEG199O
         t9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/cOovjPCNgdsesbdEpZp7kQhUqqlS1wZ2AKw2u93bfw=;
        b=E9RZcOl0Xgh5lVautEOemU1EEhWNUwNoOxks19y4jdOElrrflp9PfEeK24eJegm2Hi
         PDMZEwt1GCL83RZC652pcBzd4uNubxFEJB531ftcK2rGWaeeT5BKL5d5NcSp16DswGkc
         bjw0Ctq25eWdpalT7PGhDZkz3FP6fzxy8SJpt+01Gf66dL6+FBEG8P+vW4kT2wAsu6cD
         i2kxbedIy3OO3jddSf54VpJU2xE8b1S8zjbUJHGhLOo+Grf39hb1ubccJsbELZL8Gauf
         /Bw6jpfa6Ca55Pwqzp3ZKVDX5w3NO+JpHFRwKlGMvGyUHnqxdm8jU6L3ftQ2McXPZ6lF
         l5BQ==
X-Gm-Message-State: APt69E3byLAimWAnoKEpIW+zwLqdwb5nLrMaDOK4h4k/KWunUFiEqR4g
        R+2S6yAmS11Oh64Oy5EiOOActSPiIx2D3IJDSouAq7dID5Prp0NxNdqJ6du+Abbyj+YEdd879E2
        zPGAwcimfTL8Mb5GMkvNqDYX7FdCgweZYSf6LaE9usRMDXN7pfIalfw2xI8iP
X-Google-Smtp-Source: ADUXVKKWGPjwll79wNUpnx3KJvjxLGDC94lmfx+HA5JQw5yPog3WrRIyPbGkGdOiigltK8gg6YEu7okSSbF5
MIME-Version: 1.0
X-Received: by 2002:a0c:81e2:: with SMTP id 31-v6mr86519qve.19.1528931200492;
 Wed, 13 Jun 2018 16:06:40 -0700 (PDT)
Date:   Wed, 13 Jun 2018 16:05:19 -0700
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
Message-Id: <20180613230522.55335-29-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2 28/31] object.c: allow parse_object to handle arbitrary repositories
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
index b63a51febd4..62df8e11b63 100644
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
index 9a667fbe795..a7892b04455 100644
--- a/object.h
+++ b/object.h
@@ -125,8 +125,7 @@ void *object_as_type(struct repository *r, struct object *obj, enum object_type
  *
  * Returns NULL if the object is missing or corrupt.
  */
-#define parse_object(r, oid) parse_object_##r(oid)
-struct object *parse_object_the_repository(const struct object_id *oid);
+struct object *parse_object(struct repository *r, const struct object_id *oid);
 
 /*
  * Like parse_object, but will die() instead of returning NULL. If the
-- 
2.18.0.rc1.244.gcf134e6275-goog

