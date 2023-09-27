Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05299E82CCC
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjI0T4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjI0Tz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:55:58 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0614B10E
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:56 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77acb04309dso426148839f.2
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844555; x=1696449355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s14KnSR2o+bXyNQ4jzeNB/49zdtpSQdBJXmr08CaAVQ=;
        b=liRtTCPiisF8SWa9T/j4PvSYrOvVuyYGlC3G9NNEXpvQ7hHSH+S9X00XZutmK+A+H0
         7XH4YW9riPhL2ADSGFkC4MwZchnM54P2kVbh5bCG21Zk2JWCQOMirHTQkhghdhWyFzmW
         57tjQ/5x3Kl3YfFtF6KgVNEORMAO5NbhqCP2D8h7MD4SzK+VLO7F+2/amj4l+ZxDp1/8
         VQ9QbxO2yaSMYGUK+iyM7aABe8gBXcmLcBcKFkjILrdp6vT8N4oBX2nVYPbigrFBpDKT
         Q7NbWggC7rlwEnxcC1dj4p2tjLpCyXi9ZsKhygQ5lHWbfZ3qmYGKEc09JOsQ4fICIhQR
         4/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844555; x=1696449355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s14KnSR2o+bXyNQ4jzeNB/49zdtpSQdBJXmr08CaAVQ=;
        b=H/Kb3VbL9aBj294UPERovQTm0u8tt7wB+YHOmp6Sbu+yvs+h8ilqKSu1CDnBvDjikb
         zNKrWLST/DocoapGgwkjw9XJ7tBiXaOJCUI+p1+Ib5AUEQfnOcJZJsOUl6AAvB004aVE
         EAHpxhKzI5sU0uw0D1rjUSNWpGV5jS7FhZmQWwEyc/R9SGT/FWGeE8Y03RTcOJUYQgz9
         SBkNr4DwDLyextUijuoKeG2V9wXeWnhiIfCaXxatiG+gLPLN9ybY63Ia73IsE0qAuiJR
         QmERoiRd9FmYrgi7op3w0aEZbHcPgxhtvzXcZB+YwoXXTdUtbpI4vx9S1f0FgaULk47k
         QsVQ==
X-Gm-Message-State: AOJu0YyHd9PuPM+/pkfrbxXgJByVIaLHoPffK7xc1I6If/LZtSGg8ws0
        jM4Z2H20jy+JtVIaHtld/lw=
X-Google-Smtp-Source: AGHT+IEE3qsI/4f7ojj5wHmRSCN7HJfGhnu/YibOFpu3H/79THNpzF9QG/PMwYQvl4UJ7eRjF4qwVw==
X-Received: by 2002:a5d:9e13:0:b0:785:ff35:f340 with SMTP id h19-20020a5d9e13000000b00785ff35f340mr3457344ioh.14.1695844555381;
        Wed, 27 Sep 2023 12:55:55 -0700 (PDT)
Received: from localhost.localdomain (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id o23-20020a6b5a17000000b007836c7e8dccsm2935628iob.17.2023.09.27.12.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:55:54 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 06/30] loose: Compatibilty short name support
Date:   Wed, 27 Sep 2023 14:55:13 -0500
Message-Id: <20230927195537.1682-6-ebiederm@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
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
index 28d11593b2ea..bb50d43cd1d9 100644
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
@@ -75,8 +90,7 @@ static int load_one_loose_object_map(struct repository *repo, struct object_dire
 		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
 		    p != buf.buf + buf.len)
 			goto err;
-		insert_oid_pair(dir->loose_map->to_compat, &oid, &compat_oid);
-		insert_oid_pair(dir->loose_map->to_storage, &compat_oid, &oid);
+		insert_loose_map(dir, &oid, &compat_oid);
 	}
 
 	strbuf_release(&buf);
@@ -195,8 +209,7 @@ int repo_add_loose_object_map(struct repository *repo, const struct object_id *o
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

