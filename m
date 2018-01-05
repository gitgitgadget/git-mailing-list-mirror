Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C124F1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeAEU32 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:29:28 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:35689 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752793AbeAEU2r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:47 -0500
Received: by mail-it0-f67.google.com with SMTP id f143so2992396itb.0
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DaPy0YJjXBEeB/2+aNyd3181W/wRRCD4MbshOqSw48g=;
        b=NGMt5/rRlsJrT4A0bZcg+7wI8DXflRCuBcMHGcpI7wUUaqSWh3ChsOiI2xSOGjwM7i
         kE6daqgzu7zHwWCEUlaxaSyHKBM0luaad2ab1/GxDRTMtSafs0oN4Qukf43t5UdNgFPJ
         5ewXB93rDwHKI5OnKGmdVUzjeA5Ad06sdVhikpq/GxS05NoxgOTEt7kumnHxtlM/GRv7
         vNQXUmfhN2KVOuxxYY6SLhhlRI8YUyid5I2QzuUN0VT3JSrhQ60R8xlZ/3LbV9GQ/GDI
         X04jRV/4ZQBZa8xsdTn7D0bL0hecUJ5rIdtjDyxWd1jc6ke/u+6cccJOuKz3/p6CfuG/
         DCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DaPy0YJjXBEeB/2+aNyd3181W/wRRCD4MbshOqSw48g=;
        b=AFTmqZl5QqvPwPj2WZthXsikPCczXY1whIX/zq3IMEOhDrXsG4qzGqaqtGOCTsIrMH
         RlEl3rYqA9HIxJQhVQgbl92W54bKBFXKK9UQWu6Xp3eQJqwCkCEWhwhDQ5a7e5An2mlK
         exbSZC6fj3VK6uvjvHBb2faVnuLeGyEJjWVNpBq3M7uEGScfwf344ZrSbWWYCUqIiztt
         OpWpmi9Fd0HAGeUPDC7Oazk/7qkbF3TWpPwNiDHxgw28XhnIBr5RqSAn1+FZTw4NNi6D
         pL+3kEE05ee2ZLP5V6nU5r7jFxSFu0PW9ExXloDPyhQhydtHypyxminNo8AQkIgQ6vM1
         IOcw==
X-Gm-Message-State: AKGB3mK2HAG0TXJhKm0U2oZvJ4tJmMOPvL6TPAjArPo5oCY9tfj9U5lI
        mHCqpiT8TtR8SID4eP+A/YFhsPrA
X-Google-Smtp-Source: ACJfBoseWUlxflBCyC7IiT7qQMVJQwR2Fniuzaxi9SUyRN11irzlYpnib1xpVFLrv4dtRx6Gh3+xQQ==
X-Received: by 10.36.116.20 with SMTP id o20mr4430206itc.135.1515184126876;
        Fri, 05 Jan 2018 12:28:46 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:46 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 21/31] merge-recursive: add a new hashmap for storing file collisions
Date:   Fri,  5 Jan 2018 12:27:01 -0800
Message-Id: <20180105202711.24311-22-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Directory renames with the ability to merge directories opens up the
possibility of add/add/add/.../add conflicts, if each of the N
directories being merged into one target directory all had a file with
the same name.  We need a way to check for and report on such
collisions; this hashmap will be used for this purpose.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 23 +++++++++++++++++++++++
 merge-recursive.h |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index d92fba277..6bd4f34d5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -84,6 +84,29 @@ static void dir_rename_entry_init(struct dir_rename_entry *entry,
 	string_list_init(&entry->possible_new_dirs, 0);
 }
 
+static struct collision_entry *collision_find_entry(struct hashmap *hashmap,
+						    char *target_file)
+{
+	struct collision_entry key;
+
+	hashmap_entry_init(&key, strhash(target_file));
+	key.target_file = target_file;
+	return hashmap_get(hashmap, &key, NULL);
+}
+
+static int collision_cmp(void *unused_cmp_data,
+			 const struct collision_entry *e1,
+			 const struct collision_entry *e2,
+			 const void *unused_keydata)
+{
+	return strcmp(e1->target_file, e2->target_file);
+}
+
+static void collision_init(struct hashmap *map)
+{
+	hashmap_init(map, (hashmap_cmp_fn) collision_cmp, NULL, 0);
+}
+
 static void flush_output(struct merge_options *o)
 {
 	if (o->buffer_output < 2 && o->obuf.len) {
diff --git a/merge-recursive.h b/merge-recursive.h
index d7f4cc80c..e1be27f57 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -37,6 +37,13 @@ struct dir_rename_entry {
 	struct string_list possible_new_dirs;
 };
 
+struct collision_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	char *target_file;
+	struct string_list source_files;
+	unsigned reported_already:1;
+};
+
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
-- 
2.14.2

