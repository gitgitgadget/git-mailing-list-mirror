Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7919C43331
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A530A64F33
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhCQU5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhCQU4q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93528C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x16so3243822wrn.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8E0zk2iPmCQQ/aZZBxGH3DS75zZnTm6vEW52Nf5zpk=;
        b=NUgVCr123EeDkRZnvMqw8Eo5hhIxYYiHjZOYaV2uwCzzeqmDAnpRq/ZapwpMZYD9NS
         cjRxDzIpaIOnRv/YwGMgqF32ztw5/28Q1pIj6O5K2amkOBJCxPO0tsQ65jlp2YsFifxH
         iQ2HpPDHw/4u8OZO7SFhlvDgC42rXv6ImSuJjQ9nC9iT8NOl/pVbuSotslxaAq0Pt21w
         Fb2cDCvGMIrVyTP5ZWaEpTF3Ra70W+RqIGP5hls+41GIYtgj6VaIJcwLMDuz2jL8V5qR
         QTG88qoAQQkzPFQ9Hh48gozcpKVB2F8jCFm8PxFoGSAsYdHq8tVnB4MIdme/Nj++ieys
         AQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8E0zk2iPmCQQ/aZZBxGH3DS75zZnTm6vEW52Nf5zpk=;
        b=N3j+14/+Mo1J9q8c54UVMnd1ND+312GfhwNNp/mhV94Fr6Opq0TvLEo4lzdhSDvwhE
         TvVCD190YivUe8ZrjUFEpiE36bDMeNBBiZ2Fz59fcwkHasGcMaXNmxPemSXKFsZF4lsb
         K1Ns4EvRJ0WNArz2Hnj5Z6ANcJ1PTUQfv2gb9jQi5R4VEMfVowcUR5nF32pe/mF4Q+tF
         qT1nO11KidtYzmr2KOZSa0E7bPpZxLrMCrFRJuFZbFrZzVkcnCFr+Or92tYwFR7UI0BE
         ORDnifjlsZGKFKRbJDdOwkc6dr7s4vue5ueHzkKhNGfy5VjR3q/SaIVXMyGkEMjk6yec
         0z0A==
X-Gm-Message-State: AOAM533xuB9JuT9X9VGXSzf06Y/AWMQKh6E0VMd+Pr4DvAuWsygLsIVH
        ti1baCjovxzS+tu8vRGnK/6agarqdVo=
X-Google-Smtp-Source: ABdhPJzA10D5JercSYhw3QQna5OJ9OwmZD+dBErUJYEhC/xKbSL0vskBTmeDSc2nF/D5SKMwzuEaKg==
X-Received: by 2002:adf:c101:: with SMTP id r1mr6320870wre.38.1616014604431;
        Wed, 17 Mar 2021 13:56:44 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:43 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 07/15] update-index: move add_cacheinfo() to read-cache.c
Date:   Wed, 17 Mar 2021 21:49:31 +0100
Message-Id: <20210317204939.17890-8-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the function add_cacheinfo() that already exists in
update-index.c to update-index.c, renames it add_to_index_cacheinfo(),
and adds an `istate' parameter.  The new cache entry is returned through
a pointer passed in the parameters.  The return value is either 0
(success), -1 (invalid path), or -2 (failed to add the file in the
index).

This will become useful in the next commit, when the three-way merge
will need to call this function.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/update-index.c | 25 +++++++------------------
 cache.h                |  8 ++++++++
 read-cache.c           | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 79087bccea..6b86e89840 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -404,27 +404,16 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
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
index 6fda8091f1..41e30c0da2 100644
--- a/cache.h
+++ b/cache.h
@@ -832,6 +832,14 @@ int remove_file_from_index(struct index_state *, const char *path);
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
index 1e9a50c6c7..b514523ca1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1350,6 +1350,41 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
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
2.31.0

