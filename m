Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3159D1F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968471AbeE3Ato (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:49:44 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40394 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968567AbeE3AtI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:49:08 -0400
Received: by mail-pg0-f65.google.com with SMTP id l2-v6so7319325pgc.7
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ZMv0+dsCel1Xx27C2JKkKn8CDH1mN4ZVcrYSv/L2Dk=;
        b=OnjDDlMnbLzHJ5FGt8aJDx7Cct47txfK8hTqdxqEcvjKaKOCZTVYpws3uyNG5RWxDi
         ASot2rSIYtP99+EqMe6+1paGZxEua1IMYrQGI02Hu8Mg4BAprS3LRsOmhhJ2jIQIQjYe
         7HAijBP4suZCAVIylIW7uKcgePuOEDh6ItD0638M+LBx4/MtYslnlz9RUtjA5AEJQAJZ
         eCpgK1M/VMkNAvyNj7kn5TzYyK8nFS5x92j1BWQdCQ3eFwqA2yYHifkrGyVGG3ZbHT0R
         I19iKb1xHFjY2Y5Aqq/DTJummU8s/WDocWlqs5WTWEm61ln8UjaQB8DrGQCfAktI5rWt
         hbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ZMv0+dsCel1Xx27C2JKkKn8CDH1mN4ZVcrYSv/L2Dk=;
        b=cEjsKL8BpCGJouZOCKrgfk+HizH1xE9rJn6F+o8xFklKkta0V8Sekh6HlyyaYoQpgW
         kGc0ygPfaIu7g7xnW4Mr1YdchzNQEYXIJkQHAUhqzLFlqdAbeuywH6hzNawOg3tLpQOC
         SHKsQkfyUfzZmysTRWdUzoUSMXgibE7cIa+EVRJ+Wv8EZTgnScTd+00UqtwWGW9w+tCX
         bYAZp+BEn8Yh1B0IVNSq+vAj8ZFsGN4hOnLjyKdMc2mSzywG5/e7lBHRcGC+9+qJv2H2
         CFKAI51ggpOjqFipc8FVDvyBMmz51RiEMqP/02eSnSQS4dySQyIEGMu7+GV3e1soiyaC
         Q6PA==
X-Gm-Message-State: ALKqPwd9YRF96yvWEprR0pmLOd/yni/P+YMGg/n37+6bnD5Qy52rQgru
        a1r6zhK9edJsiO+i2WYQDad2ACI/IcI=
X-Google-Smtp-Source: ADUXVKJi77TIORhRPrwYzi7gVnOFqJ3UlruMzdKgvLz9Pb84ii0FKAj+5/Sly5EeyVd8JHQ9tpSJGw==
X-Received: by 2002:a63:69c4:: with SMTP id e187-v6mr455007pgc.415.1527641347424;
        Tue, 29 May 2018 17:49:07 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 76-v6sm78852261pfm.178.2018.05.29.17.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 17:49:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 32/35] object.c: allow parse_object to handle arbitrary repositories
Date:   Tue, 29 May 2018 17:48:07 -0700
Message-Id: <20180530004810.30076-33-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180530004810.30076-1-sbeller@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
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
index d3bdee6888f..c2246e21ee4 100644
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
index 0cd1307b61c..1a01cbf0ca3 100644
--- a/object.h
+++ b/object.h
@@ -123,8 +123,7 @@ void *object_as_type(struct repository *r, struct object *obj, enum object_type
  *
  * Returns NULL if the object is missing or corrupt.
  */
-#define parse_object(r, oid) parse_object_##r(oid)
-struct object *parse_object_the_repository(const struct object_id *oid);
+struct object *parse_object(struct repository *r, const struct object_id *oid);
 
 /*
  * Like parse_object, but will die() instead of returning NULL. If the
-- 
2.17.0.582.gccdcbd54c44.dirty

