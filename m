Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353A9C55179
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D339B2225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZnCbySF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKBSzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgKBSz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:26 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588B3C061A49
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:25 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 23so1640615wmg.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AkbmOxlqD+5g+uBtBbf9cb6JjA2jR78TMumBFI/Q+i8=;
        b=TZnCbySFS6+c5zI9hX+B218h0YeKM7bhRqTNj5uI+oM5dhgsBmzgdym5Yhfl78vJ9Y
         jRL+WtsQkDjpjeIXheKZXMlLNY7YGdMLDo8RE5B1OfZ4SAMU8pEHP7EPQkZycM5Ufeqj
         l8B8GLCV7ffIRCRmT5ZZccT46VpOjEzeLZvRGv3nVKbFTXzYUTRP7PcxOlQVENHZ6azK
         DGEMEjHhr13+lppnKf4BMXBUgx3en4Ua07Pu8Lq/UIef9RFRJGQ8hy6eKGTTBdunbl86
         Q634IjQYIuQZ0oS3FqJZvtq6vuqZD8DCU3GwLKgH2bIQjdBBSnqP9U/i2BbIRRHv1cgj
         oENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AkbmOxlqD+5g+uBtBbf9cb6JjA2jR78TMumBFI/Q+i8=;
        b=FX9mLKbasoxeWT9aqF32uUIiwnp28HevLO6uO5dAR8BPbirT03Dr7VryPEfmDeLTv/
         K7GmYYOaoDjB96gzKlFChVwOIwpV1FHFMte8RQX2LAMmiL8mKWU/p94mstc+zOgdKyIm
         zk2YdGOVlYpJZ0YYNpIC4fNFoVoKNSaD/eBtkVAGbLNOxLBKOiM0+J6pWKM4dBnfsMub
         gMnnXpkplri548caN4GT6AygM6ZyE2gauzVZ6tQfo18r5MM9c75Towu8kt4Sn7TFidZa
         bpl8IzSWHjLAs9zDxcuZLjZs5c+YE/PoEXerCimSTnZP+hWKybDTPhSzA7TSY63KIMjZ
         PeiQ==
X-Gm-Message-State: AOAM532p0qNWwuyTYhWmznSBmJs9ehH3wYUra6+QzAtsQV+LJvCHTUyw
        HSzhuxF/cIkPQoLgW56a0PpU9zi4O7E=
X-Google-Smtp-Source: ABdhPJyOlS57o4XlQpLa4oUk7wN4tBm36O5YjaQ5aYQYLDMOmqg3pzX/PPGsUipxTTbWjPNjxsWaJg==
X-Received: by 2002:a1c:6843:: with SMTP id d64mr19907220wmc.131.1604343323915;
        Mon, 02 Nov 2020 10:55:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x7sm20622317wrt.78.2020.11.02.10.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:23 -0800 (PST)
Message-Id: <0f57735f5e30ad61a2e6fdb118067afbcea69660.1604343314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
        <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:10 +0000
Subject: [PATCH v3 10/13] strmap: add a strset sub-type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
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

Finally, shortlog already had a more minimal strset API; so this adds a
strset_check_and_add() function for its benefit to allow it to switch
over to this strset implementation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c |  8 +++++++
 strmap.h | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/strmap.c b/strmap.c
index 0d10a884b5..2aff985f40 100644
--- a/strmap.c
+++ b/strmap.c
@@ -134,3 +134,11 @@ void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
 	else
 		strintmap_set(map, str, map->default_value + amt);
 }
+
+int strset_check_and_add(struct strset *set, const char *str)
+{
+	if (strset_contains(set, str))
+		return 1;
+	strset_add(set, str);
+	return 0;
+}
diff --git a/strmap.h b/strmap.h
index 31474f781e..fca1e9f639 100644
--- a/strmap.h
+++ b/strmap.h
@@ -28,6 +28,10 @@ int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
 			.map.strdup_strings = 1,                          \
 			.default_value = 0,                               \
 		    }
+#define STRSET_INIT { \
+			.map.map = HASHMAP_INIT(cmp_strmap_entry, NULL),  \
+			.map.strdup_strings = 1,                          \
+		    }
 
 /*
  * Initialize the members of the strmap.  Any keys added to the strmap will
@@ -200,4 +204,71 @@ static inline void strintmap_set(struct strintmap *map, const char *str,
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
+static inline void strset_add(struct strset *set, const char *str)
+{
+	strmap_put(&set->map, str, NULL);
+}
+
+/* Returns 1 if str already in set.  Otherwise adds str to set and returns 0 */
+int strset_check_and_add(struct strset *set, const char *str);
+
 #endif /* STRMAP_H */
-- 
gitgitgadget

