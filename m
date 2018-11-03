Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BC591F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeKCR7y (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39677 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbeKCR7w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id n18so2856994lfh.6
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=euybIvld3AGWecuIQdcP0z0DGFyQP1DeyK47FQT4Byc=;
        b=ufctExuE0FEH2oebDcWRr5/mPlxZ+JwerZmfpPKiH044jS9NLvHeP0AXoB57Qb3qGE
         BUJbkctOtVC+Yv+AMZnqYZKGIr1Enc+zH/JXTwOruglgJOspVk3Bt/HxiDMrzhtXvdTd
         qcBuDYTiDUalutFpe1s09KhNtbcLCrag3lc3HwUDdcLqCuaZI7cyAK/8+x61Vio/Jjx/
         PASKnhJeu+PzHlmBeWVrwBktEUpHe0HZmtJnyd0JOeZydv5EzrCutKWJd/Q+1NW8qJSO
         hs1i11qaOjTR/oxm0pGqE0VwGAocDo1oDinZwFotdPoQC2Hd0T4ir5CkOZk88oJq5K0t
         URuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=euybIvld3AGWecuIQdcP0z0DGFyQP1DeyK47FQT4Byc=;
        b=iAuU6fzeiJTjrlzUFhxRuOOnu26xXat7lBpl5tYVlWC4tVZwAgNZYEM9n51T0kAzFt
         kULCroI+fXkt5DcxQoNzfcqEPRIq69JGuE8znGqquHS0cGIM3kG470T3T0ZWIee8gc/0
         OaLvOWViHbu26gTC44lZjUQCN8cBkruHCavkFv1RmgFAVTnlVhkmrdTKLBfqHou2wobt
         dwDEkqsh7boDIkjhM91lIo/iw/DjKok+mrs09iGKrQ3P+I7wHkxtodae+b43EsVy5kZJ
         GQKyh+VLZS9YVJL19QdM2sKLMCsjMlsq2kTmDZjCWvNEvOc+1RJDiARNfjxuE8Ad8Ve9
         3sZQ==
X-Gm-Message-State: AGRZ1gKz4+ANXOqeyP1JrKS9DYPRWTuQVvYJ5s6c1FOdFsTchWGGpCum
        sH07UIF+6YdhzjtLlsbwPXU=
X-Google-Smtp-Source: AJdET5fDs6AWWpT4rICbhBQ+szWrichmG0HhaIq7kJGAN0grPUEgi5kTX1tSVz6lDM07qwjNhuenGw==
X-Received: by 2002:a19:3b12:: with SMTP id i18mr8936340lfa.28.1541234955665;
        Sat, 03 Nov 2018 01:49:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 12/14] read-cache.c: reduce branching based on HAVE_THREADS
Date:   Sat,  3 Nov 2018 09:48:48 +0100
Message-Id: <20181103084850.9584-13-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 40fc0cb65f..00cd416816 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2172,7 +2172,6 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 	src_offset = sizeof(*hdr);
 
-	if (HAVE_THREADS) {
 	nr_threads = git_config_get_index_threads();
 
 	/* TODO: does creating more threads than cores help? */
@@ -2183,6 +2182,9 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 			nr_threads = cpus;
 	}
 
+	if (!HAVE_THREADS)
+		nr_threads = 1;
+
 	if (nr_threads > 1) {
 		extension_offset = read_eoie_extension(mmap, mmap_size);
 		if (extension_offset) {
@@ -2210,20 +2212,16 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	} else {
 		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
 	}
-	} else {
-		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
-	}
 
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	/* if we created a thread, join it otherwise load the extensions on the primary thread */
-	if (HAVE_THREADS && extension_offset) {
+	if (extension_offset) {
 		int ret = pthread_join(p.pthread, NULL);
 		if (ret)
 			die(_("unable to join load_index_extensions thread: %s"), strerror(ret));
-	}
-	if (!extension_offset) {
+	} else {
 		p.src_offset = src_offset;
 		load_index_extensions(&p);
 	}
@@ -2745,8 +2743,10 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
-	if (HAVE_THREADS) {
+	if (HAVE_THREADS)
 		nr_threads = git_config_get_index_threads();
+	else
+		nr_threads = 1;
 
 	if (nr_threads != 1) {
 		int ieot_blocks, cpus;
@@ -2777,7 +2777,6 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			ieot_entries = DIV_ROUND_UP(entries, ieot_blocks);
 		}
 	}
-	}
 
 	offset = lseek(newfd, 0, SEEK_CUR);
 	if (offset < 0) {
@@ -2861,7 +2860,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 * strip_extensions parameter as we need it when loading the shared
 	 * index.
 	 */
-	if (HAVE_THREADS && ieot) {
+	if (ieot) {
 		struct strbuf sb = STRBUF_INIT;
 
 		write_ieot_extension(&sb, ieot);
-- 
2.19.1.1005.gac84295441

