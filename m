Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE4BC282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688602081E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 19:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzSSMgZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAGTEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:04:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44979 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgAGTEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 14:04:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id bx28so461395edb.11
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 11:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FMcVC2aGNO6xYglNkZacBwfxPrXJvwvusseU0yakzBg=;
        b=MzSSMgZj/PTosCNOkpcI6JHtq/O2dkm1jqDvYILq6r69km038l724tMNgc3rGfikU1
         AfJCIoi83+Mb0hfCYDu5OGBjv3vDwfqF09YH/1dnSm5loKU4jJEmZ/pwZ1p/ryOJyYET
         y9y1dhyA1WftS/wlK66N4jNOgwBnQyc1mSCHQ1n2VGjBSAJKfn01S0OhK8+JmxvcYYmi
         sLDtl/nbGgWPdV5m0kb0t2dpbpiKkpEtx7WZfVdImMsFK4Folsb+rlbj0SB5zJ+mrn/9
         OFkaO0yOw6n2akl1OottpkZF5fnXTNzN5v82CJFk06x41WSIHp+bZZXEDc0K9EjpezJ8
         A2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FMcVC2aGNO6xYglNkZacBwfxPrXJvwvusseU0yakzBg=;
        b=Es63y0hXJ+VcwOMKKBIHUKJhhUkesvm91vDX3JvbqTXiXSdscV5IjwLpY9FnXrc97v
         BcaN0tvWpJhYMGEkr5eeX0Lky/a/bq7PI8pO1RULH3Lu5JogzzMvnyaoUl3dPQc0hNBK
         7I8B79/ZjkxkmZb6DwOH/Jrz8HWaDQtWsDNmYFea2PvcrM/tbNa1xFt/GCxVv0mK/DrU
         GTAiGQW4Uv/+LtFWMMXkl5nCIv7DqFdMuFF7tXFUdcIg9Vqv2E0TS4Oly7lbG9P5qeBU
         2XKRPgqV8BtrdRQ+2HxrYdbMx1sS8WH0YUxgAVOvEb4Zoo7d/v0pWTZpKjwAEdc6osvK
         I2ow==
X-Gm-Message-State: APjAAAWDO8/IXdn5j2puqIoOLHdc8OLNB6fFFSkGYa1LGwm+B6AcqvuE
        6PBd/2cYugrlmJDtOmzt5Bg8F4P0
X-Google-Smtp-Source: APXvYqwWQIcVadkWj0HbCtQRDpbDIjwKdH3yHKwv3PqCpvXUPlxoKAxlf30pUmvcAnw0aMrly5kabQ==
X-Received: by 2002:a17:906:b841:: with SMTP id ga1mr954753ejb.184.1578423873327;
        Tue, 07 Jan 2020 11:04:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm19445edv.71.2020.01.07.11.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:04:32 -0800 (PST)
Message-Id: <679bf4e0dd16f7d6f4ba1f05af50cca24b5abee4.1578423871.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.510.git.1578423871.gitgitgadget@gmail.com>
References: <pull.510.git.1578423871.gitgitgadget@gmail.com>
From:   "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 19:04:28 +0000
Subject: [PATCH 1/4] fsmonitor: change last update timestamp on the
 index_state to opaque token
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kevin Willford <Kevin.Willford@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kevin Willford <Kevin.Willford@microsoft.com>

Some file system monitors might not use or take a timestamp for processing
and in the case of watchman could have race conditions with using a
timestamp. Watchman uses something called a clockid that is used for race
free queries to it. The clockid for watchman is simply a string.

Change the fsmonitor_last_update from being a uint64_t to a char pointer
so that any arbitrary data can be stored in it and passed back to the
fsmonitor.

Signed-off-by: Kevin Willford <Kevin.Willford@microsoft.com>
---
 cache.h                        |  2 +-
 fsmonitor.c                    | 49 ++++++++++++++++++++++------------
 t/helper/test-dump-fsmonitor.c |  2 +-
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/cache.h b/cache.h
index 1554488d66..170c125db3 100644
--- a/cache.h
+++ b/cache.h
@@ -324,7 +324,7 @@ struct index_state {
 	struct hashmap dir_hash;
 	struct object_id oid;
 	struct untracked_cache *untracked;
-	uint64_t fsmonitor_last_update;
+	char *fsmonitor_last_update;
 	struct ewah_bitmap *fsmonitor_dirty;
 	struct mem_pool *ce_mem_pool;
 	struct progress *progress;
diff --git a/fsmonitor.c b/fsmonitor.c
index 868cca01e2..9860587225 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -6,8 +6,9 @@
 #include "run-command.h"
 #include "strbuf.h"
 
-#define INDEX_EXTENSION_VERSION	(1)
-#define HOOK_INTERFACE_VERSION	(1)
+#define INDEX_EXTENSION_VERSION1	(1)
+#define INDEX_EXTENSION_VERSION2	(2)
+#define HOOK_INTERFACE_VERSION		(1)
 
 struct trace_key trace_fsmonitor = TRACE_KEY_INIT(FSMONITOR);
 
@@ -32,17 +33,26 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	uint32_t ewah_size;
 	struct ewah_bitmap *fsmonitor_dirty;
 	int ret;
+	uint64_t timestamp;
+	struct strbuf last_update = STRBUF_INIT;
 
-	if (sz < sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint32_t))
+	if (sz < sizeof(uint32_t) + 1 + sizeof(uint32_t))
 		return error("corrupt fsmonitor extension (too short)");
 
 	hdr_version = get_be32(index);
 	index += sizeof(uint32_t);
-	if (hdr_version != INDEX_EXTENSION_VERSION)
+	if (hdr_version == INDEX_EXTENSION_VERSION1) {
+		timestamp = get_be64(index);
+		strbuf_addf(&last_update, "%"PRIu64"", timestamp);
+		index += sizeof(uint64_t);
+	} else if (hdr_version == INDEX_EXTENSION_VERSION2) {
+		strbuf_addstr(&last_update, index);
+		index += last_update.len + 1;
+	} else {
 		return error("bad fsmonitor version %d", hdr_version);
+	}
 
-	istate->fsmonitor_last_update = get_be64(index);
-	index += sizeof(uint64_t);
+	istate->fsmonitor_last_update = strbuf_detach(&last_update, NULL);
 
 	ewah_size = get_be32(index);
 	index += sizeof(uint32_t);
@@ -79,7 +89,6 @@ void fill_fsmonitor_bitmap(struct index_state *istate)
 void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 {
 	uint32_t hdr_version;
-	uint64_t tm;
 	uint32_t ewah_start;
 	uint32_t ewah_size = 0;
 	int fixup = 0;
@@ -89,11 +98,12 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
 		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 
-	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
+	put_be32(&hdr_version, INDEX_EXTENSION_VERSION2);
 	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
 
-	put_be64(&tm, istate->fsmonitor_last_update);
-	strbuf_add(sb, &tm, sizeof(uint64_t));
+	strbuf_addstr(sb, istate->fsmonitor_last_update);
+	strbuf_addch(sb, 0); /* Want to keep a NUL */
+
 	fixup = sb->len;
 	strbuf_add(sb, &ewah_size, sizeof(uint32_t)); /* we'll fix this up later */
 
@@ -110,9 +120,9 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 }
 
 /*
- * Call the query-fsmonitor hook passing the time of the last saved results.
+ * Call the query-fsmonitor hook passing the last update token of the saved results.
  */
-static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *query_result)
+static int query_fsmonitor(int version, const char *last_update, struct strbuf *query_result)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
@@ -121,7 +131,7 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que
 
 	argv_array_push(&cp.args, core_fsmonitor);
 	argv_array_pushf(&cp.args, "%d", version);
-	argv_array_pushf(&cp.args, "%" PRIuMAX, (uintmax_t)last_update);
+	argv_array_pushf(&cp.args, "%s", last_update);
 	cp.use_shell = 1;
 	cp.dir = get_git_work_tree();
 
@@ -151,6 +161,7 @@ void refresh_fsmonitor(struct index_state *istate)
 	int query_success = 0;
 	size_t bol; /* beginning of line */
 	uint64_t last_update;
+	struct strbuf last_update_token = STRBUF_INIT;
 	char *buf;
 	unsigned int i;
 
@@ -164,6 +175,7 @@ void refresh_fsmonitor(struct index_state *istate)
 	 * should be inclusive to ensure we don't miss potential changes.
 	 */
 	last_update = getnanotime();
+	strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
 
 	/*
 	 * If we have a last update time, call query_fsmonitor for the set of
@@ -217,18 +229,21 @@ void refresh_fsmonitor(struct index_state *istate)
 	}
 	strbuf_release(&query_result);
 
-	/* Now that we've updated istate, save the last_update time */
-	istate->fsmonitor_last_update = last_update;
+	/* Now that we've updated istate, save the last_update_token */
+	FREE_AND_NULL(istate->fsmonitor_last_update);
+	istate->fsmonitor_last_update = strbuf_detach(&last_update_token, NULL);
 }
 
 void add_fsmonitor(struct index_state *istate)
 {
 	unsigned int i;
+	struct strbuf last_update = STRBUF_INIT;
 
 	if (!istate->fsmonitor_last_update) {
 		trace_printf_key(&trace_fsmonitor, "add fsmonitor");
 		istate->cache_changed |= FSMONITOR_CHANGED;
-		istate->fsmonitor_last_update = getnanotime();
+		strbuf_addf(&last_update, "%"PRIu64"", getnanotime());
+		istate->fsmonitor_last_update = strbuf_detach(&last_update, NULL);
 
 		/* reset the fsmonitor state */
 		for (i = 0; i < istate->cache_nr; i++)
@@ -250,7 +265,7 @@ void remove_fsmonitor(struct index_state *istate)
 	if (istate->fsmonitor_last_update) {
 		trace_printf_key(&trace_fsmonitor, "remove fsmonitor");
 		istate->cache_changed |= FSMONITOR_CHANGED;
-		istate->fsmonitor_last_update = 0;
+		FREE_AND_NULL(istate->fsmonitor_last_update);
 	}
 }
 
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 2786f47088..975f0ac890 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -13,7 +13,7 @@ int cmd__dump_fsmonitor(int ac, const char **av)
 		printf("no fsmonitor\n");
 		return 0;
 	}
-	printf("fsmonitor last update %"PRIuMAX"\n", (uintmax_t)istate->fsmonitor_last_update);
+	printf("fsmonitor last update %s\n", istate->fsmonitor_last_update);
 
 	for (i = 0; i < istate->cache_nr; i++)
 		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
-- 
gitgitgadget

