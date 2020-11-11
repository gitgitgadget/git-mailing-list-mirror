Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D060FC56202
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C39F2087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqBFd1EY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgKKUCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgKKUCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:35 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F7C0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:34 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id j7so3753225wrp.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SRd5zzuJ5YWrv3J1rtWTYj322wIQAFH2zDfaZkFQEEQ=;
        b=AqBFd1EYmtCSrp5o3jZtl9XVO8TBExhqy4QbTmmBV02yk3d21i6WfmUUiBuxvxSp1N
         w+68tJvtoNxQwZLNpeZONXoh4qD4oCibz//G1+yGYncaEioefCAJ7uj82xVEfjVKWKjF
         2bzWV1RJJTIQZq0N/MvlG3+aIpjLV2BLvshhmNeFPQryUfxaUGn6vxANeJCbeD8wk4lx
         BKOgIG2PxpxEqrOMdCerfKpIY5MtvWojkh9ie2bh8GQTv/umI/b3AikBHGZpSC1norx1
         kgFUJI2pZ70inFpCG8HeyX8gxcY8x086oHmJ40wIf0AFgHAslh0Um3VnEEznWzPuR1Gx
         P7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SRd5zzuJ5YWrv3J1rtWTYj322wIQAFH2zDfaZkFQEEQ=;
        b=qhZM3jhdGqrqVzxflYNl0cR2Usd1/8bxHaqHzo1nL0jqmxL5f1yBht/dtAkqSSVEsw
         VgVQ+5/njf9668NLPVMVdkjMMPc8vENfyrulHDvj060F/s/VIqhM1DF4Px2xU6cJlJsl
         X6J80CrCQhZTKBozc4gOvy5O0+LKzdRx+PCi++EFkwWjR9Ru0niBfZLFu/AtfExR7ryY
         EmkrGeOb6Cj1OnI0+Bnjn1x416vY81c/FnVcdpXLk22LHQHB7YYUYFXyI5YBUTCPHXIn
         fnVM7/zaDvPvpfh9Ew2m/HiBWLaxOJxXlh3ZLDD1nFKYwNPsDt+/bffE9Nkc7tromu8Z
         cydQ==
X-Gm-Message-State: AOAM532yliK592rQuRq+SmZIJAqdmbhs3gf2XVieFAXKz2OQPAcUCD3h
        HZneFIqwYdiLK05AV84ok5LIHUw/+Mk=
X-Google-Smtp-Source: ABdhPJz8S8+PJfEMlpHyaHPCF6KEZDbV3hvS6y/sA5xUnNiyXt6JkHvZPMONJ4lM9++8UOBteKBexA==
X-Received: by 2002:adf:9461:: with SMTP id 88mr30656682wrq.171.1605124952787;
        Wed, 11 Nov 2020 12:02:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm3780976wmc.6.2020.11.11.12.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:32 -0800 (PST)
Message-Id: <e128a71fec415e92cfcb9c63987ee8264235bb6f.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:17 +0000
Subject: [PATCH v6 11/15] strmap: add a strset sub-type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Similar to adding strintmap for special-casing a string -> int mapping,
add a strset type for cases where we really are only interested in using
strmap for storing a set rather than a mapping.  In this case, we'll
always just store NULL for the value but the different struct type makes
it clearer than code comments how a variable is intended to be used.

The difference in usage also results in some differences in API: a few
things that aren't necessary or meaningful are dropped (namely, the
free_values argument to *_clear(), and the *_get() function), and
strset_add() is chosen as the API instead of strset_put().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 17 +++++++++++++++
 strmap.h | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/strmap.c b/strmap.c
index dc84c57c07..3784865745 100644
--- a/strmap.c
+++ b/strmap.c
@@ -143,3 +143,20 @@ void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
 	else
 		strintmap_set(map, str, map->default_value + amt);
 }
+
+int strset_add(struct strset *set, const char *str)
+{
+	/*
+	 * Cannot use strmap_put() because it'll return NULL in both cases:
+	 *   - cannot find str: NULL means "not found"
+	 *   - does find str: NULL is the value associated with str
+	 */
+	struct strmap_entry *entry = find_strmap_entry(&set->map, str);
+
+	if (entry)
+		return 0;
+
+	entry = create_entry(&set->map, str, NULL);
+	hashmap_add(&set->map.map, &entry->ent);
+	return 1;
+}
diff --git a/strmap.h b/strmap.h
index 56a5cdb864..c8c4d7c932 100644
--- a/strmap.h
+++ b/strmap.h
@@ -27,6 +27,7 @@ int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
 			.map = STRMAP_INIT,   \
 			.default_value = 0,   \
 		       }
+#define STRSET_INIT { .map = STRMAP_INIT }
 
 /*
  * Initialize the members of the strmap.  Any keys added to the strmap will
@@ -196,4 +197,66 @@ static inline void strintmap_set(struct strintmap *map, const char *str,
  */
 void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt);
 
+/*
+ * strset:
+ *    A set of strings.
+ *
+ * Primary differences with strmap:
+ *    1) The value is always NULL, and ignored.  As there is no value to free,
+ *       there is one fewer argument to strset_clear
+ *    2) No strset_get() because there is no value.
+ *    3) No strset_put(); use strset_add() instead.
+ */
+
+struct strset {
+	struct strmap map;
+};
+
+#define strset_for_each_entry(mystrset, iter, var)	\
+	strmap_for_each_entry(&(mystrset)->map, iter, var)
+
+static inline void strset_init(struct strset *set)
+{
+	strmap_init(&set->map);
+}
+
+static inline void strset_init_with_options(struct strset *set,
+					    int strdup_strings)
+{
+	strmap_init_with_options(&set->map, strdup_strings);
+}
+
+static inline void strset_clear(struct strset *set)
+{
+	strmap_clear(&set->map, 0);
+}
+
+static inline void strset_partial_clear(struct strset *set)
+{
+	strmap_partial_clear(&set->map, 0);
+}
+
+static inline int strset_contains(struct strset *set, const char *str)
+{
+	return strmap_contains(&set->map, str);
+}
+
+static inline void strset_remove(struct strset *set, const char *str)
+{
+	return strmap_remove(&set->map, str, 0);
+}
+
+static inline int strset_empty(struct strset *set)
+{
+	return strmap_empty(&set->map);
+}
+
+static inline unsigned int strset_get_size(struct strset *set)
+{
+	return strmap_get_size(&set->map);
+}
+
+/* Returns 1 if str is added to the set; returns 0 if str was already in set */
+int strset_add(struct strset *set, const char *str);
+
 #endif /* STRMAP_H */
-- 
gitgitgadget

