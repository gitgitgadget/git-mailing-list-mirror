Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94601F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeAEU2p (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:28:45 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:33527 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeAEU2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:42 -0500
Received: by mail-io0-f195.google.com with SMTP id t63so6992018iod.0
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5+UohUDrYXBmSs1c8P+MSQrNck8C5nddqietmNdKthk=;
        b=kXBy0BFMF8CL+JhNg5dOrzlMXrPaPVAI4xddL0p/frJ3+fB/iQMzNTQQssbPixEFai
         ulEiJAtdDOa4z3T8evv624pbLh/yayfbsJe1eI7Up4CgogxvHS2ps8IqPhGUBzsscCgZ
         syNuSydtJdGo8AfdmLsASCcrUpT4sTmX7jaLI0V7itSWXoiNlAXfoT9Dm3Tvf2wm/PtF
         GXZLCtQaSRc6ZzYcFEthmuG4DoYg+In7VTfVRcy/QKbRws8mqQwSeitKIhzpnHd1hKUB
         ISJIOVvsZ6rk3++ZyIqaTh6roNAtnuvLNNMf1kbQSEgfKysBPAoEfs4WE4dY3d+YrZ8T
         k6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5+UohUDrYXBmSs1c8P+MSQrNck8C5nddqietmNdKthk=;
        b=dyuP7hi/9OH6G/XwVl6+MCxylIQz0/AKMoD+dnSSQ0gW3T+GU3Mz4RoohSzPQ4dVKl
         rZFjzUdTBjN+71PL2nQW/8OjlBxyZ4T5QSKWL+NqsW89e772vJMWD/UEabM6w9O23nDu
         Pawac7tdLRystbAajk0D760GtfcwRWLHPLk8xx0YgapCkUw5nHWxI7BEqL79tOXvEGta
         U8FaRPpTAK75iVSM7h+I4YbunH6VY3ZN5m2UP73zif43E6HnWXn4Skt5sZMVGScIFYIQ
         pjt56YGsa8HnVXPZCGEUD2X3iJ+ov2wkkRKtORchgRv4OHgwSzbrIdtiyhs8RLejvSzq
         fwTg==
X-Gm-Message-State: AKwxytfrRWsdElbaqlOYvxAhXNBJ7JwtskhxPaqog8lHwb17H++MPEJ8
        H9z9KxcQ0kFKifFF6KqvZzTQ3bvG
X-Google-Smtp-Source: ACJfBose/HMpqzOX27RvhEnFS2f+h1y1MfOwLCLmIrtols+n3iLMzNS5joRn+HoFRO2Itz81iB5ORQ==
X-Received: by 10.107.9.100 with SMTP id j97mr4329429ioi.91.1515184121803;
        Fri, 05 Jan 2018 12:28:41 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:41 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 17/31] merge-recursive: add a new hashmap for storing directory renames
Date:   Fri,  5 Jan 2018 12:26:57 -0800
Message-Id: <20180105202711.24311-18-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This just adds dir_rename_entry and the associated functions; code using
these will be added in subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 35 +++++++++++++++++++++++++++++++++++
 merge-recursive.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4adff2d53..0cb27c66e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -49,6 +49,41 @@ static unsigned int path_hash(const char *path)
 	return ignore_case ? strihash(path) : strhash(path);
 }
 
+static struct dir_rename_entry *dir_rename_find_entry(struct hashmap *hashmap,
+						      char *dir)
+{
+	struct dir_rename_entry key;
+
+	if (dir == NULL)
+		return NULL;
+	hashmap_entry_init(&key, strhash(dir));
+	key.dir = dir;
+	return hashmap_get(hashmap, &key, NULL);
+}
+
+static int dir_rename_cmp(void *unused_cmp_data,
+			  const struct dir_rename_entry *e1,
+			  const struct dir_rename_entry *e2,
+			  const void *unused_keydata)
+{
+	return strcmp(e1->dir, e2->dir);
+}
+
+static void dir_rename_init(struct hashmap *map)
+{
+	hashmap_init(map, (hashmap_cmp_fn) dir_rename_cmp, NULL, 0);
+}
+
+static void dir_rename_entry_init(struct dir_rename_entry *entry,
+				  char *directory)
+{
+	hashmap_entry_init(entry, strhash(directory));
+	entry->dir = directory;
+	entry->non_unique_new_dir = 0;
+	strbuf_init(&entry->new_dir, 0);
+	string_list_init(&entry->possible_new_dirs, 0);
+}
+
 static void flush_output(struct merge_options *o)
 {
 	if (o->buffer_output < 2 && o->obuf.len) {
diff --git a/merge-recursive.h b/merge-recursive.h
index 80d69d140..d7f4cc80c 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -29,6 +29,14 @@ struct merge_options {
 	struct string_list df_conflict_file_set;
 };
 
+struct dir_rename_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	char *dir;
+	unsigned non_unique_new_dir:1;
+	struct strbuf new_dir;
+	struct string_list possible_new_dirs;
+};
+
 /* merge_trees() but with recursive ancestor consolidation */
 int merge_recursive(struct merge_options *o,
 		    struct commit *h1,
-- 
2.14.2

