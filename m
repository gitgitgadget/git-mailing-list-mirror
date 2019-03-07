Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B9120248
	for <e@80x24.org>; Thu,  7 Mar 2019 12:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCGM3b (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 07:29:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36839 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfCGM3b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 07:29:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so11319022pfa.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 04:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mL/3Fx6ydc2qS8F95vyt+hSuHV+1qkY8kzXeZkFvyj0=;
        b=B3JyeyMpSQ+BOgaLrf9uU6lQZjqu67UJfpP5lLJWdoeUqS0xqO1b59euAbZubLDMFW
         PzceohBNSBL33O41ssJQp/EUwMtYw/N+WRoto06czDaG5IpgbOkZANi7boZ9PNyd8AAD
         g49eCbEZQAKXoaeAFS79947k5DE/BInKkttcl0O/9FWAgE+e18fwzq0wRqhFRkUU+jow
         /5EAc2LLLuyzv270rnPC9eSaTP47KD9HivQtt1Sua+hmHvoRy7y7MP33eLsgPsR/f4bj
         67e3J3fBINQZ4b+KkvkMLfaPpT9uT0qLCSkXqaVRyOsUM7Wvmt1uRynpvSCT9UyNNH/D
         QBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mL/3Fx6ydc2qS8F95vyt+hSuHV+1qkY8kzXeZkFvyj0=;
        b=p0H4T+KlujXGTZ21DNW2dOwlx1x5+6VcopIlu/R/3xjCq3U3+RQmgzxj/Orrh13fcS
         vOBB7DRzFCt/PxRWRZnkNxRsoHxedqbrbzV2d2Uh/wjUM1phidK+CeP7e3sYPDVbnc6O
         8YTtJr5Kytnd+T35UZF5bzeRv2qIZW4d+sNaXdyQZ3eOMlXQ5CacxR9GoBlxQU6p4BiF
         hiE/ChcXBy0Q8+CVEdVYWWr0g3nLRF6IUPaGwomuyYBsZwr+XKLB/YvmVAm1MrbhCVjG
         TQiGvogAOHwDnHCIZ6gS0onqiipEMZ6APU9v0pltJjp1j3Q5bzYlPkeBDxHjisM8Fi1w
         K1uA==
X-Gm-Message-State: APjAAAUxVlbmOWIndH4tupNOutAh7xguEoVn3snZ/q7oM1o0PDkZgpGs
        zzCI/OyxDDv6jwMiZzW87xE=
X-Google-Smtp-Source: APXvYqzCWb4STxph+19ajBZDyZkQEiuKQHGnRyFeT9ejaq1U46ZuKiQm5uXCGR/Zf5nmkYlfEPkGQg==
X-Received: by 2002:a62:4ec5:: with SMTP id c188mr12672704pfb.230.1551961770361;
        Thu, 07 Mar 2019 04:29:30 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id n10sm6367271pfa.139.2019.03.07.04.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 04:29:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Mar 2019 19:29:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] files-backend.c: factor out per-worktree code in loose_fill_ref_dir()
Date:   Thu,  7 Mar 2019 19:29:15 +0700
Message-Id: <20190307122917.12811-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190307122917.12811-1-pclouds@gmail.com>
References: <ec707cbb-96e8-f26f-3d69-b69d29b31737@gmail.com>
 <20190307122917.12811-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first step for further cleaning up and extending this
function.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 50 +++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ef053f716c..26417893c8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -214,6 +214,33 @@ static void files_ref_path(struct files_ref_store *refs,
 	}
 }
 
+/*
+ * Manually add refs/bisect and refs/worktree, which, being
+ * per-worktree, might not appear in the directory listing for
+ * refs/ in the main repo.
+ */
+static void add_per_worktree_entries_to_dir(struct ref_dir *dir, const char *dirname)
+{
+	int pos;
+
+	if (strcmp(dirname, "refs/"))
+		return;
+
+	pos = search_ref_dir(dir, "refs/bisect/", 12);
+	if (pos < 0) {
+		struct ref_entry *child_entry =
+			create_dir_entry(dir->cache, "refs/bisect/", 12, 1);
+		add_entry_to_dir(dir, child_entry);
+	}
+
+	pos = search_ref_dir(dir, "refs/worktree/", 11);
+	if (pos < 0) {
+		struct ref_entry *child_entry =
+			create_dir_entry(dir->cache, "refs/worktree/", 11, 1);
+		add_entry_to_dir(dir, child_entry);
+	}
+}
+
 /*
  * Read the loose references from the namespace dirname into dir
  * (without recursing).  dirname must end with '/'.  dir must be the
@@ -297,28 +324,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	strbuf_release(&path);
 	closedir(d);
 
-	/*
-	 * Manually add refs/bisect and refs/worktree, which, being
-	 * per-worktree, might not appear in the directory listing for
-	 * refs/ in the main repo.
-	 */
-	if (!strcmp(dirname, "refs/")) {
-		int pos = search_ref_dir(dir, "refs/bisect/", 12);
-
-		if (pos < 0) {
-			struct ref_entry *child_entry = create_dir_entry(
-					dir->cache, "refs/bisect/", 12, 1);
-			add_entry_to_dir(dir, child_entry);
-		}
-
-		pos = search_ref_dir(dir, "refs/worktree/", 11);
-
-		if (pos < 0) {
-			struct ref_entry *child_entry = create_dir_entry(
-					dir->cache, "refs/worktree/", 11, 1);
-			add_entry_to_dir(dir, child_entry);
-		}
-	}
+	add_per_worktree_entries_to_dir(dir, dirname);
 }
 
 static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
-- 
2.21.0.rc1.337.gdf7f8d0522

