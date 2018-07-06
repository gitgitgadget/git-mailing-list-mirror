Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AEA61F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753986AbeGFAy3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:54:29 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38037 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753921AbeGFAyA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:54:00 -0400
Received: by mail-qk0-f196.google.com with SMTP id y4-v6so5503946qka.5
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yuS/sYza6iDM2Pw9TN4UCK/sBmWi6PRRGx+AVQn9C1k=;
        b=uCwVJzzDiHPArxpsB03wFlucNmR7U6XF6mUFCR8YGhwJlW4n54hE7C2H5U4SFjV4J/
         Cw4ctI7J6GvR5fKMXO7gOXlVmpq3tSQkE7lPyQ79rxYgKR1Yw4vgDuvZQbAM6zwm6bBB
         rw38bfTVGa95bqaPioVoH3Qns10L0MuzqaYTWJ6wYyUH00kc0hWSXDvL8nYjH/BF4Aif
         7IKleBEzslRr0I8I490K62DOAY+o724j4kB45SHKfV2eTlgGGGpuinZMHvq075iadTwh
         X8DlAFcZfveaZyQy4gjO3/g4NHnuXJGUtfHMUVwa7AVnJ3QVFHZD/GcvJSxO8fqc3F3i
         fOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yuS/sYza6iDM2Pw9TN4UCK/sBmWi6PRRGx+AVQn9C1k=;
        b=hyfGJMEnG230bjzmGsaKKWOqmSmQJCbk+b+ij7r80YF/slkgG6xLo+KZkNPMramltU
         fiNiY5Dwlhs0OpUP4/veUGMTbLsRux8gDnMt84bE8eWoY2fz1P0KFC9DH5AwdMeUdkZB
         JYPRjFHU1RGtAdNuLsBirxb5ymJaBF7V3oYYKWdLr0q9XwlnRMcUww+DRQtIrfqpJimZ
         g0x+5xx+C17HrIcnj8Qfc6l/TqG2L8OxEp+sfMY3AVH3q8Q8y6PI2kM174fQxHreKxRA
         KMuH/UxTPQCmqqHS+/yUpbQH4wFOz2Ksi9KAyzOGd73g6UteZsqwkK0nDrpmZThVI38W
         q+Ag==
X-Gm-Message-State: APt69E0GZhWS7kMA9KoYfga6GWtfYS8P1Z8BMwAqSZTWeIytTqlH3yEP
        ZHAlRG44qkLp9WPYCMus9lzhuuzb
X-Google-Smtp-Source: AAOMgpdQUYr/Jec0saEFm+XmfddUVrQ5pgZcZMtePb6y3zrYlVjQC+h9t+Wbl66kauiNZzTP1xQ+8g==
X-Received: by 2002:ae9:dfc2:: with SMTP id t185-v6mr7088598qkf.274.1530838439996;
        Thu, 05 Jul 2018 17:53:59 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:53:59 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 17/24] midx: prepare midxed_git struct
Date:   Thu,  5 Jul 2018 20:53:14 -0400
Message-Id: <20180706005321.124643-18-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c         | 22 ++++++++++++++++++++++
 midx.h         |  3 +++
 object-store.h |  9 +++++++++
 packfile.c     |  6 +++++-
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index cc35abe7a2..d5a61c0c53 100644
--- a/midx.c
+++ b/midx.c
@@ -180,6 +180,28 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir)
 	return NULL;
 }
 
+int prepare_multi_pack_index_one(struct repository *r, const char *object_dir)
+{
+	struct multi_pack_index *m = r->objects->multi_pack_index;
+	struct multi_pack_index *m_search;
+
+	if (!core_multi_pack_index)
+		return 0;
+
+	for (m_search = m; m_search; m_search = m_search->next)
+		if (!strcmp(object_dir, m_search->object_dir))
+			return 1;
+
+	r->objects->multi_pack_index = load_multi_pack_index(object_dir);
+
+	if (r->objects->multi_pack_index) {
+		r->objects->multi_pack_index->next = m;
+		return 1;
+	}
+
+	return 0;
+}
+
 static size_t write_midx_header(struct hashfile *f,
 				unsigned char num_chunks,
 				uint32_t num_packs)
diff --git a/midx.h b/midx.h
index 2d83dd9ec1..731ad6f094 100644
--- a/midx.h
+++ b/midx.h
@@ -1,9 +1,12 @@
 #ifndef __MIDX_H__
 #define __MIDX_H__
 
+#include "repository.h"
+
 struct multi_pack_index;
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir);
+int prepare_multi_pack_index_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
 
diff --git a/object-store.h b/object-store.h
index 07bcc80e02..7d67ad7aa9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -85,6 +85,8 @@ struct packed_git {
 };
 
 struct multi_pack_index {
+	struct multi_pack_index *next;
+
 	int fd;
 
 	const unsigned char *data;
@@ -126,6 +128,13 @@ struct raw_object_store {
 	 */
 	struct oidmap *replace_map;
 
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c and midx.c
+	 */
+	struct multi_pack_index *multi_pack_index;
+
 	/*
 	 * private data
 	 *
diff --git a/packfile.c b/packfile.c
index 3d652212c6..5d4493dbf4 100644
--- a/packfile.c
+++ b/packfile.c
@@ -15,6 +15,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "object-store.h"
+#include "midx.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -935,10 +936,13 @@ static void prepare_packed_git(struct repository *r)
 
 	if (r->objects->packed_git_initialized)
 		return;
+	prepare_multi_pack_index_one(r, r->objects->objectdir);
 	prepare_packed_git_one(r, r->objects->objectdir, 1);
 	prepare_alt_odb(r);
-	for (alt = r->objects->alt_odb_list; alt; alt = alt->next)
+	for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
+		prepare_multi_pack_index_one(r, alt->path);
 		prepare_packed_git_one(r, alt->path, 0);
+	}
 	rearrange_packed_git(r);
 	prepare_packed_git_mru(r);
 	r->objects->packed_git_initialized = 1;
-- 
2.18.0.118.gd4f65b8d14

