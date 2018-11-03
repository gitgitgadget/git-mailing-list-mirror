Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DFF01F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeKCR7x (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40530 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeKCR7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id n3-v6so2853414lfe.7
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9Zjbemurtm/J4rPnSra2wxipnG86UpHMBL/OMHW9IY=;
        b=AUYjt/zZIUQoB9thL9J01+T2HpEsU4LO7ISZzmYEhSAp//CkLWNPoLQLZhpcv2mxZX
         c0xpKp+F4B67+EhxaBhkPz6iAB1F6wd1hSu15mijKxBvzN9E1rqRVNn4fZXFFv97AoAc
         I8HB8eHd0nrTES9bvyPePLP5MzV8Pm5SD8jDVfYh7DK5H9VJwshFsolUsn0n2u5qpfgg
         UV+alLGH8S8f0hHaH+ZzQce0OrpwjQscRP3/Hw8pz9kTbb6WUIeTSjbdS0VObqGOjlHa
         u/8Nv+Jss1YG5KDqbolRnQAw7I1EQDyz7XM/OmOTD9+ZyBvqoVs7NyjuS32HQBBqjjfu
         q4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9Zjbemurtm/J4rPnSra2wxipnG86UpHMBL/OMHW9IY=;
        b=QvC5GDD8Rqs1tIw98d6+O30/KxlIODLbbQNWpnGsfTqnPpQipaPnQxSpcTQeM+iCu3
         mQOkNBxrbSYRgnAEX6KXcp7gdvUOylwbcDN3FjrIXWUeeK+fUxHcV0EUKip40kVlZtsy
         fcu52/KDeb9Q+csKLnX+AyybAbW5yEweNnFt3X9UMjrWb4YULDqjWyjDv9AhnAZlF0MX
         7SlJfJNO2hSg58trZAo1V28BKY81yPusbPnk/nwGjBr30RP6GL4wxh84D/mLi4VNK0Kn
         Cpql0zY5nMjYKXRf3Y/ksQoaqQxjKM7fZ7A+dD4GoQZzmI9GRKmFCPnWBQbV3/jjA8CH
         ng0w==
X-Gm-Message-State: AGRZ1gKdz7vibolwHIlpfzOoNTFOOWOUaIbDZoa44d2U0Lavsmkqfcmt
        FoPCvZ/tB5QbSClCGLY+YWs=
X-Google-Smtp-Source: AJdET5dFHnqu4rNNE0VKd7AEZRl4+dGCx8N4yty+rLLV0AqsB+hfAvdfy9TfzweUlRF1PvcusfuTdg==
X-Received: by 2002:a19:c7c2:: with SMTP id x185mr8949775lff.123.1541234954573;
        Sat, 03 Nov 2018 01:49:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 11/14] read-cache.c: remove #ifdef NO_PTHREADS
Date:   Sat,  3 Nov 2018 09:48:47 +0100
Message-Id: <20181103084850.9584-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181103084850.9584-1-pclouds@gmail.com>
References: <20181027173008.18852-1-pclouds@gmail.com>
 <20181103084850.9584-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a faithful conversion with no attempt to clean up whatsoever.
Code indentation is left broken. There will be another commit to clean
it up and un-indent if we just indent now. It's just more code noise.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index d57958233e..40fc0cb65f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1920,19 +1920,15 @@ struct index_entry_offset_table
 	struct index_entry_offset entries[FLEX_ARRAY];
 };
 
-#ifndef NO_PTHREADS
 static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset);
 static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot);
-#endif
 
 static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
 static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
 
 struct load_index_extensions
 {
-#ifndef NO_PTHREADS
 	pthread_t pthread;
-#endif
 	struct index_state *istate;
 	const char *mmap;
 	size_t mmap_size;
@@ -2010,8 +2006,6 @@ static unsigned long load_all_cache_entries(struct index_state *istate,
 	return consumed;
 }
 
-#ifndef NO_PTHREADS
-
 /*
  * Mostly randomly chosen maximum thread counts: we
  * cap the parallelism to online_cpus() threads, and we want
@@ -2122,7 +2116,6 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
 
 	return consumed;
 }
-#endif
 
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
@@ -2135,10 +2128,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	size_t mmap_size;
 	struct load_index_extensions p;
 	size_t extension_offset = 0;
-#ifndef NO_PTHREADS
 	int nr_threads, cpus;
 	struct index_entry_offset_table *ieot = NULL;
-#endif
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -2181,7 +2172,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 	src_offset = sizeof(*hdr);
 
-#ifndef NO_PTHREADS
+	if (HAVE_THREADS) {
 	nr_threads = git_config_get_index_threads();
 
 	/* TODO: does creating more threads than cores help? */
@@ -2219,21 +2210,19 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	} else {
 		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
 	}
-#else
-	src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
-#endif
+	} else {
+		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
+	}
 
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	/* if we created a thread, join it otherwise load the extensions on the primary thread */
-#ifndef NO_PTHREADS
-	if (extension_offset) {
+	if (HAVE_THREADS && extension_offset) {
 		int ret = pthread_join(p.pthread, NULL);
 		if (ret)
 			die(_("unable to join load_index_extensions thread: %s"), strerror(ret));
 	}
-#endif
 	if (!extension_offset) {
 		p.src_offset = src_offset;
 		load_index_extensions(&p);
@@ -2756,8 +2745,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
-#ifndef NO_PTHREADS
-	nr_threads = git_config_get_index_threads();
+	if (HAVE_THREADS) {
+		nr_threads = git_config_get_index_threads();
+
 	if (nr_threads != 1) {
 		int ieot_blocks, cpus;
 
@@ -2787,7 +2777,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			ieot_entries = DIV_ROUND_UP(entries, ieot_blocks);
 		}
 	}
-#endif
+	}
 
 	offset = lseek(newfd, 0, SEEK_CUR);
 	if (offset < 0) {
@@ -2871,8 +2861,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 * strip_extensions parameter as we need it when loading the shared
 	 * index.
 	 */
-#ifndef NO_PTHREADS
-	if (ieot) {
+	if (HAVE_THREADS && ieot) {
 		struct strbuf sb = STRBUF_INIT;
 
 		write_ieot_extension(&sb, ieot);
@@ -2883,7 +2872,6 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		if (err)
 			return -1;
 	}
-#endif
 
 	if (!strip_extensions && istate->split_index) {
 		struct strbuf sb = STRBUF_INIT;
@@ -3469,7 +3457,6 @@ static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context,
 	strbuf_add(sb, hash, the_hash_algo->rawsz);
 }
 
-#ifndef NO_PTHREADS
 #define IEOT_VERSION	(1)
 
 static struct index_entry_offset_table *read_ieot_extension(const char *mmap, size_t mmap_size, size_t offset)
@@ -3542,4 +3529,3 @@ static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_ta
 	       strbuf_add(sb, &buffer, sizeof(uint32_t));
        }
 }
-#endif
-- 
2.19.1.1005.gac84295441

