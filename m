Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F89C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345826AbiHITJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345041AbiHITJH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D166B22281
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so4493050wmc.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=P+p6RXcqgOi2+v2p/94vXgQ8gI+U3h0btCeV1eEBlzw=;
        b=kWhk3eY6KhVQKWbxnXE4qiz2XIp6XND+Lz8RLGUbnmPzRHhQRNbYDTV5/DjL9q37xz
         AxoadL3sTA8cxFzh8ZHD7lo9XF/kL4PWpNZ4gUyX5LKQbY0wPezqB2W2pQj3mlxRgGaa
         a5f0g9F912Ns50e6UxE/j0CQVQV/SmJh7CEmeOmsxaMOs+Eb6eh1Jqc7ngTyDw33bv+u
         qCY6yyBTvMJ1F3tPLY3PoTim1YaUDPuzhh77xXBvjza3UNHDSZfWdvU6TJ0TK7UAc9Dz
         D9gkfGpQZEbHgdQ2vtk+/gLHp37MMSJUSh8uBgqIDMcURSd5o5hoTLtRsJJb+5YFsrTp
         64zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=P+p6RXcqgOi2+v2p/94vXgQ8gI+U3h0btCeV1eEBlzw=;
        b=hZr2LnqiJ6cCRjdbuYfAfGvTbOFawk93G8W//wKoPedqy+HCf7RgtkVuBLwjYC/vIR
         MuyGg1jx5zDJ1gs5Wpf9CLDCNzOodKUTgp1MIGjXGmKd6hm/5ZdXjYk7eb+lqPwmEaHB
         WAHm+vR4tgc6+XyIHzqkmMtffV2o7pTNTqZRSzqCINZ9pkqHHoZp+sV4wIXX/IdTsiGX
         MqNro5sOeDZX/lJSym12vXwF00eGlQ0Gs7b2Xou7xByb/94NTZEN8JHuKjqODWCzbvD5
         kGsOMWnvA1Ah9DinWw16m5X7z1sylrwO6CSQktCm7E2ncVRVYx8+paq/t4bx396F09WL
         WZyQ==
X-Gm-Message-State: ACgBeo3Qx+I7WBm760VjmIER3qI/vIAJYlblYpcRLxmYJrb9HdWORRPW
        qxsGArduYZ5q3PB0sgs9O+sYkkwEQzw=
X-Google-Smtp-Source: AA6agR5QrW2jzunkfQy0j4Ha40blVgOW16bURnB73TKt2kVtzguTr4YZasyG5QgEmAloJ9/Ai8KPPg==
X-Received: by 2002:a05:600c:4f06:b0:3a3:2158:c5ed with SMTP id l6-20020a05600c4f0600b003a32158c5edmr17014314wmq.103.1660071329457;
        Tue, 09 Aug 2022 11:55:29 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:29 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 06/14] update-index: move add_cacheinfo() to read-cache.c
Date:   Tue,  9 Aug 2022 20:54:21 +0200
Message-Id: <20220809185429.20098-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the function add_cacheinfo() that already exists in
update-index.c to update-index.c, renames it add_to_index_cacheinfo(),
and adds an `istate' parameter.  The new cache entry is returned through
a pointer passed in the parameters.  This function can return three
values:

 - 0, when the file has been successfully added to the index;
 - ADD_TO_INDEX_CACHEINFO_INVALID_PATH, when the file does not exists;
 - ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD, when the file could not be
   added to the index.

This will become useful in the next commit, when the three-way merge
will need to call this function.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/update-index.c | 25 +++++++------------------
 cache.h                |  8 ++++++++
 read-cache.c           | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index b62249905f..2e322a58f2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -411,27 +411,16 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
 static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 			 const char *path, int stage)
 {
-	int len, option;
-	struct cache_entry *ce;
+	int res;
 
-	if (!verify_path(path, mode))
-		return error("Invalid path '%s'", path);
-
-	len = strlen(path);
-	ce = make_empty_cache_entry(&the_index, len);
-
-	oidcpy(&ce->oid, oid);
-	memcpy(ce->name, path, len);
-	ce->ce_flags = create_ce_flags(stage);
-	ce->ce_namelen = len;
-	ce->ce_mode = create_ce_mode(mode);
-	if (assume_unchanged)
-		ce->ce_flags |= CE_VALID;
-	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
-	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
-	if (add_cache_entry(ce, option))
+	res = add_to_index_cacheinfo(&the_index, mode, oid, path, stage,
+				     allow_add, allow_replace, NULL);
+	if (res == ADD_TO_INDEX_CACHEINFO_INVALID_PATH)
+		return error(_("Invalid path '%s'"), path);
+	if (res == ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD)
 		return error("%s: cannot add to the index - missing --add option?",
 			     path);
+
 	report("add '%s'", path);
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 4aa1bd079d..6b5d0a2ba3 100644
--- a/cache.h
+++ b/cache.h
@@ -885,6 +885,14 @@ int remove_file_from_index(struct index_state *, const char *path);
 int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 int add_file_to_index(struct index_state *, const char *path, int flags);
 
+#define ADD_TO_INDEX_CACHEINFO_INVALID_PATH (-1)
+#define ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD (-2)
+
+int add_to_index_cacheinfo(struct index_state *, unsigned int mode,
+			   const struct object_id *oid, const char *path,
+			   int stage, int allow_add, int allow_replace,
+			   struct cache_entry **ce_ret);
+
 int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
 void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
diff --git a/read-cache.c b/read-cache.c
index 4de207752d..e895bf5c6a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1436,6 +1436,41 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 	return 0;
 }
 
+int add_to_index_cacheinfo(struct index_state *istate, unsigned int mode,
+			   const struct object_id *oid, const char *path,
+			   int stage, int allow_add, int allow_replace,
+			   struct cache_entry **ce_ret)
+{
+	int len, option;
+	struct cache_entry *ce;
+
+	if (!verify_path(path, mode))
+		return ADD_TO_INDEX_CACHEINFO_INVALID_PATH;
+
+	len = strlen(path);
+	ce = make_empty_cache_entry(istate, len);
+
+	oidcpy(&ce->oid, oid);
+	memcpy(ce->name, path, len);
+	ce->ce_flags = create_ce_flags(stage);
+	ce->ce_namelen = len;
+	ce->ce_mode = create_ce_mode(mode);
+	if (assume_unchanged)
+		ce->ce_flags |= CE_VALID;
+	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
+	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
+
+	if (add_index_entry(istate, ce, option)) {
+		discard_cache_entry(ce);
+		return ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD;
+	}
+
+	if (ce_ret)
+		*ce_ret = ce;
+
+	return 0;
+}
+
 /*
  * "refresh" does not calculate a new sha1 file or bring the
  * cache up-to-date for mode/content changes. But what it
-- 
2.37.1.412.gcfdce49ffd

