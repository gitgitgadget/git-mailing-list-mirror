Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A9F1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753003AbeCUQnB (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:43:01 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42901 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeCUQma (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:42:30 -0400
Received: by mail-qk0-f195.google.com with SMTP id b198so6107020qkg.9
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=61KniiEL5PG8kQjqrVcWOFRfQEMYhQXrJet5aoBSHWg=;
        b=NKQa239/4QK7Av0xai6SPncBUCYADNyzUxNgHtAyLZiQhMdE9LNOMvzZHt83fToq83
         HfhheEkbYhVezz5FYLvyURgi1AXNRwDiQp5glts9qtIMJ8j4O3LuJv2DTTPEF2fucV3V
         QeUBuC8FphHUxy+7sVc7Tz/dgO4DZAT9qw6D6tRpxriKoYnQaoJMLc6FfSLmKTbO9kDD
         6v63zKfo87o+OeNPxJirmCZ5buh/q8Tg/JhqghMRIw0ulRquxDudag/FlyK7OFwDQ0dq
         Iv6xfvWrkq5q5dBA0QtCFBwR45cOVKbp6i3g2pGw40CqEYtrElcDDPp+4bvvUWaO+1Da
         Y+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=61KniiEL5PG8kQjqrVcWOFRfQEMYhQXrJet5aoBSHWg=;
        b=i04IJrO/eE8ZK0GUa1ohlwGtaZOhn55c0BC+gZJwS+QVNqHtdh/uPQyF8S+4EynY3W
         wganWw6FwCS27DIHOJNmz6bZOD51NtXqttXMfYCYrHVd/kcTXUACx+YVT01Zkl6pV+qp
         vSOe76dJSrjB6nTvqNsWmA4jhkvBDEogBPPyEMAqxg583Kd6n3JAGhb+GyissTd9TINu
         e2Q3z2VSMnz7k4/bL05glZNsD9CKCoK595CbcFwcaSilgxXGRp7WIKM3DvlUQ3+c5bUa
         DKKSRTrRoboONJ1vznKS/7q2efxz9NIPJyDZQY2kI4gp5EigJMnj1R9H7CYR7aZucM+2
         u9DQ==
X-Gm-Message-State: AElRT7HLEQ+OdcZ7Mnr7zmrg5Qhvmf54XuIU68zZVS/7oNmTkXavsyL+
        /qEMh/6IDYFvojTFv2JPsBtxrg6p
X-Google-Smtp-Source: AG47ELsfID1dpj671lCdMVZbukh63g7BAMYxVoxyZZzchKcKjrd/riB0nAiEm8mDsu0HRG8qnpHU8g==
X-Received: by 10.55.6.140 with SMTP id 134mr28660385qkg.232.1521650549660;
        Wed, 21 Mar 2018 09:42:29 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010:1:1060:bd2c:4297:50e])
        by smtp.gmail.com with ESMTPSA id m24sm3235584qtc.81.2018.03.21.09.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 09:42:29 -0700 (PDT)
From:   jameson.miller81@gmail.com
X-Google-Original-From: jamill@microsoft.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH 3/3] fast-import: use built-in mem pool
Date:   Wed, 21 Mar 2018 12:41:52 -0400
Message-Id: <20180321164152.204869-4-jamill@microsoft.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 fast-import.c | 50 +++++++-------------------------------------------
 1 file changed, 7 insertions(+), 43 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 4e68acc156..126f2da118 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -168,6 +168,7 @@ Format of STDIN stream:
 #include "dir.h"
 #include "run-command.h"
 #include "packfile.h"
+#include "mem-pool.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -209,13 +210,6 @@ struct last_object {
 	unsigned no_swap : 1;
 };
 
-struct fi_mem_pool {
-	struct fi_mem_pool *next_pool;
-	char *next_free;
-	char *end;
-	uintmax_t space[FLEX_ARRAY]; /* more */
-};
-
 struct atom_str {
 	struct atom_str *next_atom;
 	unsigned short str_len;
@@ -304,9 +298,7 @@ static int global_argc;
 static const char **global_argv;
 
 /* Memory pools */
-static size_t fi_mem_pool_alloc = 2*1024*1024 - sizeof(struct fi_mem_pool);
-static size_t total_allocd;
-static struct fi_mem_pool *mem_pool;
+static struct mem_pool mem_pool =  {0, 2 * 1024 * 1024, 0 };
 
 /* Atom management */
 static unsigned int atom_table_sz = 4451;
@@ -324,6 +316,7 @@ static off_t pack_size;
 /* Table of objects we've written. */
 static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
+static size_t total_allocd = 0;
 static struct object_entry *object_table[1 << 16];
 static struct mark_set *marks;
 static const char *export_marks_file;
@@ -636,41 +629,12 @@ static unsigned int hc_str(const char *s, size_t len)
 
 static void *pool_alloc(size_t len)
 {
-	struct fi_mem_pool *p;
-	void *r;
-
-	/* round up to a 'uintmax_t' alignment */
-	if (len & (sizeof(uintmax_t) - 1))
-		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
-
-	for (p = mem_pool; p; p = p->next_pool)
-		if ((p->end - p->next_free >= len))
-			break;
-
-	if (!p) {
-		if (len >= (fi_mem_pool_alloc/2)) {
-			total_allocd += len;
-			return xmalloc(len);
-		}
-		total_allocd += sizeof(struct fi_mem_pool) + fi_mem_pool_alloc;
-		p = xmalloc(st_add(sizeof(struct fi_mem_pool), fi_mem_pool_alloc));
-		p->next_pool = mem_pool;
-		p->next_free = (char *) p->space;
-		p->end = p->next_free + fi_mem_pool_alloc;
-		mem_pool = p;
-	}
-
-	r = p->next_free;
-	p->next_free += len;
-	return r;
+	return mem_pool_alloc(&mem_pool, len);
 }
 
 static void *pool_calloc(size_t count, size_t size)
 {
-	size_t len = count * size;
-	void *r = pool_alloc(len);
-	memset(r, 0, len);
-	return r;
+	return mem_pool_calloc(&mem_pool, count, size);
 }
 
 static char *pool_strdup(const char *s)
@@ -3541,8 +3505,8 @@ int cmd_main(int argc, const char **argv)
 		fprintf(stderr, "Total branches:  %10lu (%10lu loads     )\n", branch_count, branch_load_count);
 		fprintf(stderr, "      marks:     %10" PRIuMAX " (%10" PRIuMAX " unique    )\n", (((uintmax_t)1) << marks->shift) * 1024, marks_set_count);
 		fprintf(stderr, "      atoms:     %10u\n", atom_cnt);
-		fprintf(stderr, "Memory total:    %10" PRIuMAX " KiB\n", (total_allocd + alloc_count*sizeof(struct object_entry))/1024);
-		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)(total_allocd/1024));
+		fprintf(stderr, "Memory total:    %10" PRIuMAX " KiB\n", (total_allocd + mem_pool.pool_alloc + alloc_count*sizeof(struct object_entry))/1024);
+		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)((total_allocd + mem_pool.pool_alloc) /1024));
 		fprintf(stderr, "     objects:    %10" PRIuMAX " KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
 		pack_report();
-- 
2.14.3

