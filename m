Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1104D1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeBFAad (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:30:33 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42986 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbeBFAab (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:30:31 -0500
Received: by mail-pl0-f66.google.com with SMTP id 11so132747plc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PbhUh39heOWsiUY4i4JHAo8XgW8VL3VamkPAyx6SDac=;
        b=DicS2sM8HJsAiBGyfzp2UOZYVDS0Kl9IoFJltL8TvIWLzqgw0zk1AndzGQJYLUhOow
         VI3DGAjhBkvBgoTaCH2MkATo+O8wLtE0GT4fny+P4ICF4tWsIC4zmU4/OuoHj8Vij6RC
         HN8KuMyZVTWjOI1WyvEN5m0EAJ3hNojoWjCk3rJzO4Guaq/uj0qF1ASSOkfkDmTAUXlD
         CZOA/44MeUo/Wzcb9YzwgLhZ9cQzimb47VGWq6X5rAEiwaS5zwaLVGgCmnvUj6Z1TbiN
         /x4BuEzUi6jD2lwccTlWvjgD5PoiJc9h0nhQ9Zmc8yGKCcDja5W+VrtBT9IFTH5jSi7b
         dKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PbhUh39heOWsiUY4i4JHAo8XgW8VL3VamkPAyx6SDac=;
        b=uoLd9h1vSJtssjXxm+CCc9QCyY3z/yoC5D+3rCMsbtcaXO0SsWxQzgKnGOe4s4oeIR
         /9rB9ZNHcZ/N0jXIJUVNIFXP054F4kycw9nIaa56HZRqF9IJ0HTIqa5rg2PhafENmCaT
         JClcwwtMlscy72HNK2XF86lv05jF61NPhwGO0wpCn2YyAnZosG/M2snUab1r+Bl8bna0
         QDa3bqhDB7oUISbdzyL6L37VQTyQX+m6PYE1c/ewsZ7kOKwaf1ZmLswjgE2LYMJjC3Ea
         1QqOcXiPBRImGOFwW4Shhnv/ykMHCJZiP2EIg6kDjGwxVmgLGsPpcVMcw8iD3tejuCul
         0QvQ==
X-Gm-Message-State: APf1xPDP22Rs4tAdUxBui0Xd6IKUGaCq4KQvj6uZQMIeKsORiUt8556o
        rEbcKUCyWCeoHVNa4g1uob6NLFFIl8I=
X-Google-Smtp-Source: AH8x2264OFHC9KrMNREywNQFAEQQPsp8wAQvq5LzfGbiJYvLkGGTscRgVj8/SbSCUcOyZ0VZ8Ig+uQ==
X-Received: by 2002:a17:902:8501:: with SMTP id bj1-v6mr570039plb.5.1517877030385;
        Mon, 05 Feb 2018 16:30:30 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id y5sm19684727pfd.163.2018.02.05.16.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:30:29 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 178/194] object: allow parse_object to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:33 -0800
Message-Id: <20180206001749.218943-80-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 object.c | 20 ++++++++++----------
 object.h |  3 +--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/object.c b/object.c
index 2a05613c64..2fe5fac3ce 100644
--- a/object.c
+++ b/object.c
@@ -244,39 +244,39 @@ struct object *parse_object_or_die(const struct object_id *oid,
 	die(_("unable to parse object: %s"), name ? name : oid_to_hex(oid));
 }
 
-struct object *parse_object_the_repository(const struct object_id *oid)
+struct object *parse_object(struct repository *r, const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
 	int eaten;
-	const unsigned char *repl = lookup_replace_object(the_repository, oid->hash);
+	const unsigned char *repl = lookup_replace_object(r, oid->hash);
 	void *buffer;
 	struct object *obj;
 
-	obj = lookup_object(the_repository, oid->hash);
+	obj = lookup_object(r, oid->hash);
 	if (obj && obj->parsed)
 		return obj;
 
 	if ((obj && obj->type == OBJ_BLOB) ||
 	    (!obj && has_object_file(oid) &&
-	     sha1_object_info(the_repository, oid->hash, NULL) == OBJ_BLOB)) {
-		if (check_sha1_signature(the_repository, repl, NULL, 0, NULL) < 0) {
+	     sha1_object_info(r, oid->hash, NULL) == OBJ_BLOB)) {
+		if (check_sha1_signature(r, repl, NULL, 0, NULL) < 0) {
 			error("sha1 mismatch %s", oid_to_hex(oid));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(the_repository, oid), NULL, 0);
-		return lookup_object(the_repository, oid->hash);
+		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
+		return lookup_object(r, oid->hash);
 	}
 
-	buffer = read_sha1_file(the_repository, oid->hash, &type, &size);
+	buffer = read_sha1_file(r, oid->hash, &type, &size);
 	if (buffer) {
-		if (check_sha1_signature(the_repository, repl, buffer, size, typename(type)) < 0) {
+		if (check_sha1_signature(r, repl, buffer, size, typename(type)) < 0) {
 			free(buffer);
 			error("sha1 mismatch %s", sha1_to_hex(repl));
 			return NULL;
 		}
 
-		obj = parse_object_buffer(the_repository, oid, type, size,
+		obj = parse_object_buffer(r, oid, type, size,
 					  buffer, &eaten);
 		if (!eaten)
 			free(buffer);
diff --git a/object.h b/object.h
index a5456fc2d7..900f1b6611 100644
--- a/object.h
+++ b/object.h
@@ -160,8 +160,7 @@ extern void *read_object_with_reference(const unsigned char *sha1,
  *
  * Returns NULL if the object is missing or corrupt.
  */
-#define parse_object(r, oid) parse_object_##r(oid)
-struct object *parse_object_the_repository(const struct object_id *oid);
+struct object *parse_object(struct repository *r, const struct object_id *oid);
 
 /*
  * Like parse_object, but will die() instead of returning NULL. If the
-- 
2.15.1.433.g936d1b9894.dirty

