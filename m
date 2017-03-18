Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9E020323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdCRKMd (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:12:33 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35109 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdCRKM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:12:29 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so13141202pge.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NeQNfei5FVa7r88w6FPHjO6bJGE+cRv9NXn+mP8nnyE=;
        b=Oi1L68jxYhEUgWVBD20ZNkZW+cFNVY0cOY0ir8V04lgo+wMg/wnA/zs6xuWAq0ms16
         C4c4zfUEhrX3ukSz6H5Kk7gDepc3Lj11aan45WcPb5OHUsSV3ihorlC8xMiju7KHy6ke
         psRlERf9oMiKEGPWt05uikNAdAK7KTJ0VkBQiXwL4nPSvgbaorLLNMtPSklonK6dXQ1T
         r3lZjulgeq+bEbPQn5+Npydk/vYXyl0RNLJMkCKNy9BxZ9bvbVAKVWN67RORKWJHwBwP
         4py09m2jNlEM5zPiByMpey+uugzX98Fn5XKbSP3qfIjxvQ67W6WrjtBpfJM07kYMWpZu
         2z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NeQNfei5FVa7r88w6FPHjO6bJGE+cRv9NXn+mP8nnyE=;
        b=sRPPqIa4ErY71zeOkoa6/XgKAh8xw9P8PrF7Jn4fa1ZgP3AyIuwCJy2NBg2JLi9oeM
         7J/Ak4i/RqCOTDfWEkbE5RD8MKDnnAEjyulESV61lTx8450lNY94uRf9W12VpGrrLfPS
         cW01x7AhsyRFOlPL3eFiP58UbJ27wOtalRU1Jbrpfg6xrEZVv0IQuVajwiVz2ApfLibd
         SlSO1DGffjqduA6WGO7s1uKz9JtYYMH1Nh1zlHwvUI1mR7/JBOtEFw3JNcpJmJybcpEv
         /mq64OkzE3SSTihUe48GxEl2V6bilYWWpriG/kfk1M4hQx7HaP6wneDVyGQk4hshFLsv
         I2ow==
X-Gm-Message-State: AFeK/H2/LDJ/iaAs00ckS6DHzZuk89SJXc37bcIRRCZBShWt5UT71NfERrebA5bJfikOhA==
X-Received: by 10.84.238.207 with SMTP id l15mr146186pln.90.1489831932318;
        Sat, 18 Mar 2017 03:12:12 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id 23sm21820665pfw.94.2017.03.18.03.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:12:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:12:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 02/12] revision.c: refactor add_index_objects_to_pending()
Date:   Sat, 18 Mar 2017 17:11:43 +0700
Message-Id: <20170318101153.6901-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core code is factored out and take 'struct index_state *' instead so
that we can reuse it to add objects from index files other than .git/index
in the next patch.
---
 revision.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 7ff61ff5f7..98146f179f 100644
--- a/revision.c
+++ b/revision.c
@@ -1263,13 +1263,13 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 
 }
 
-void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
+static void do_add_index_objects_to_pending(struct rev_info *revs,
+					    struct index_state *istate)
 {
 	int i;
 
-	read_cache();
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 		struct blob *blob;
 
 		if (S_ISGITLINK(ce->ce_mode))
@@ -1282,13 +1282,19 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
 					     ce->ce_mode, ce->name);
 	}
 
-	if (active_cache_tree) {
+	if (istate->cache_tree) {
 		struct strbuf path = STRBUF_INIT;
-		add_cache_tree(active_cache_tree, revs, &path);
+		add_cache_tree(istate->cache_tree, revs, &path);
 		strbuf_release(&path);
 	}
 }
 
+void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
+{
+	read_cache();
+	do_add_index_objects_to_pending(revs, &the_index);
+}
+
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 			    int exclude_parent)
 {
-- 
2.11.0.157.gd943d85

