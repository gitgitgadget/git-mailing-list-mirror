Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E30E784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjJBCkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjJBCks (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:40:48 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89773A7
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:40:45 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7a26fd82847so105002139f.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214445; x=1696819245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg4RBplxhFRN7ZVX9/Aa8dakqT0wYQPCYrnaA581JuA=;
        b=cV+ZhgKZ1913/dkvVmrVt9aG49rexnRbk5M6xRhA4DqFOgKf40AweqhbTxUPmpeCrc
         zZDvqZy3WOLNagIo2iPN/YfZlFDpOEE7kVZak8Es5xf6sucbeifua7pE/yXUc1lXm+BQ
         /MnCRtpwY0UbadgYBUKsDx7iXnuyZXFaIg99Z5VLrkX5SQEf+ZN8F3tASml354lnnQN1
         WpZyW6aT12Z+JRf2gkUyzdvD3xTqA7LXcnlyiW+pdYzQon6Lpo+WnxwCNBuQ/B0fhQgi
         8gGxMlIgg/siCRIkT7H6/758GdGksUDp6wqOCfeIWtv+V8eKshdoIj9vmiGt6V91lSjD
         0+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214445; x=1696819245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rg4RBplxhFRN7ZVX9/Aa8dakqT0wYQPCYrnaA581JuA=;
        b=vdkFWsU+s+362kbnG6jw27PEg5sROr5tDRWS+S4FhBp3mrIiQWvavgY1U3iNgEG+sZ
         UX/ihvU0QHvG1XAZkOC6Kjh1H83O7mloWuz/x+6NNbZRn1/tM8qnZschunUep3CUI7Xz
         AE4B3WH//HOIq7Ua6Ub3cZ4HTDGwBYAxpPomWAwYWQD/gpDdZGk9WBbNp6ICPqiyjmIw
         hvQROQW6uSpMcBHzKzKpRkSOy0JHsGi81q/yWU2cQpdWpzx1KUUKedHAMws5gp7IagoQ
         aP0lzNfBEX9iXxZ4ZMTBEWF0TW7OLNc7fHgNwrw07g1mqe/fBN2x2Bfp+9/H8AvC2vs4
         /Eug==
X-Gm-Message-State: AOJu0YyMMMC/LPY4zUMF3dM2BnE4QiveywMUjNmVMa3+uL2uRlqhJ4J7
        bBKYXfWFNMpSi5+LSs4vRDI=
X-Google-Smtp-Source: AGHT+IEU2RDraFBJc6qDPjAtxyB8TM/J9th2188B/Ka+jtKiJoYdn5X2FiGxGAN0QESfZiH4GRsi6Q==
X-Received: by 2002:a05:6602:2288:b0:794:efb0:83d6 with SMTP id d8-20020a056602228800b00794efb083d6mr11600507iod.12.1696214444931;
        Sun, 01 Oct 2023 19:40:44 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id v6-20020a056602058600b0079f9f7a2565sm6346113iox.38.2023.10.01.19.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:40:44 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 06/30] loose: compatibilty short name support
Date:   Sun,  1 Oct 2023 21:40:10 -0500
Message-Id: <20231002024034.2611-6-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Update loose_objects_cache when udpating the loose objects map.  This
oidtree is used to discover which oids are possibilities when
resolving short names, and it can support a mixture of sha1
and sha256 oids.

With this any oid recorded objects/loose-objects-idx is usable
for resolving an oid to an object.

To make this maintainable a helper insert_loose_map is factored
out of load_one_loose_object_map and repo_add_loose_object_map,
and then modified to also update the loose_objects_cache.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 loose.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/loose.c b/loose.c
index 6ba73cc84dca..f6faa6216a08 100644
--- a/loose.c
+++ b/loose.c
@@ -7,6 +7,7 @@
 #include "gettext.h"
 #include "loose.h"
 #include "lockfile.h"
+#include "oidtree.h"
 
 static const char *loose_object_header = "# loose-object-idx\n";
 
@@ -42,6 +43,21 @@ static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const
 	return 1;
 }
 
+static int insert_loose_map(struct object_directory *odb,
+			    const struct object_id *oid,
+			    const struct object_id *compat_oid)
+{
+	struct loose_object_map *map = odb->loose_map;
+	int inserted = 0;
+
+	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
+	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
+	if (inserted)
+		oidtree_insert(odb->loose_objects_cache, compat_oid);
+
+	return inserted;
+}
+
 static int load_one_loose_object_map(struct repository *repo, struct object_directory *dir)
 {
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
@@ -49,15 +65,14 @@ static int load_one_loose_object_map(struct repository *repo, struct object_dire
 
 	if (!dir->loose_map)
 		loose_object_map_init(&dir->loose_map);
+	if (!dir->loose_objects_cache) {
+		ALLOC_ARRAY(dir->loose_objects_cache, 1);
+		oidtree_init(dir->loose_objects_cache);
+	}
 
-	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
-	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->empty_tree, repo->hash_algo->empty_tree);
-
-	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
-	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->empty_blob, repo->hash_algo->empty_blob);
-
-	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
-	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->null_oid, repo->hash_algo->null_oid);
+	insert_loose_map(dir, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
+	insert_loose_map(dir, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
+	insert_loose_map(dir, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
 
 	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
 	fp = fopen(path.buf, "rb");
@@ -77,8 +92,7 @@ static int load_one_loose_object_map(struct repository *repo, struct object_dire
 		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
 		    p != buf.buf + buf.len)
 			goto err;
-		insert_oid_pair(dir->loose_map->to_compat, &oid, &compat_oid);
-		insert_oid_pair(dir->loose_map->to_storage, &compat_oid, &oid);
+		insert_loose_map(dir, &oid, &compat_oid);
 	}
 
 	strbuf_release(&buf);
@@ -197,8 +211,7 @@ int repo_add_loose_object_map(struct repository *repo, const struct object_id *o
 	if (!should_use_loose_object_map(repo))
 		return 0;
 
-	inserted |= insert_oid_pair(repo->objects->odb->loose_map->to_compat, oid, compat_oid);
-	inserted |= insert_oid_pair(repo->objects->odb->loose_map->to_storage, compat_oid, oid);
+	inserted = insert_loose_map(repo->objects->odb, oid, compat_oid);
 	if (inserted)
 		return write_one_object(repo, oid, compat_oid);
 	return 0;
-- 
2.41.0

