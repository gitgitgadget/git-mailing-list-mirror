Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ED2C55178
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAAC2083B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erNvoEI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbgKFAZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbgKFAZL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:11 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE908C0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:10 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so3270849wmd.4
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SRd5zzuJ5YWrv3J1rtWTYj322wIQAFH2zDfaZkFQEEQ=;
        b=erNvoEI+sf1rUxUogd82wDyzsxBfBI443l4C4P2K2T0Ma1uAQwvdICCF1J0bIj9uOi
         KuoVlunzMlwMu9Wpt8o5AZhEqGzRGDD3d389/eC57FjPtX4kEx+qwtf6lMng94O/uYW3
         lN2cMR/qvC8Yx5nSr7XwyUdyr5nfJ335WzSBQh5I4y9EhvpJ41hqpWPfGYws2FhQOHsz
         G6Mv5XJK04uMMIkLoeG/KOwS1Uohjl3Vqccj1Axgfc0luj18wxn2yf+foGP4/eXZQRhS
         P4rEfak20DESpxkDLxU8pvl8qxwpG48bpgcl7D0kaGkuK6k+WO0mbk4H/Aihq9l4q3+b
         qD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SRd5zzuJ5YWrv3J1rtWTYj322wIQAFH2zDfaZkFQEEQ=;
        b=Tz5orXYf4mW7z6FwYUyP35CooiuswM/C2N/FFlej/Jo7kI9Dc18Me6aAB5kx8WZSzq
         xh+JUoUpRNHLZhrygtX12u0CIqhjaf/VScx77kTfpWA2RKW8rC2o9ucSjD2I+qkrkRM0
         AfOoregBXeLlV6R5SpDwqxiHdTkQrCAgAICvx4finYdHOczr5rxW2tYA/S0M/fZ3wz1C
         S0LD7V428wbNcZWUnPRh+RvRJDVCOHYFy01dO85cvHXZQTG5kQRRW1UeNBhChr87dK4C
         AJ1R0i12tDPNlbJz240U5l16YIJaF9VXfpCv1HgYRwkVWBaAh9OnRm5f6dIm6rDUR1+L
         +zew==
X-Gm-Message-State: AOAM5321iykVHwXaHE8reKHNAsANH+p2Hym++uT+DtiehuB0KWBhhA72
        5SMmWYStuveMq13HMuS65WiXd/HLLSI=
X-Google-Smtp-Source: ABdhPJza6iRBa4B42Ib+OpjzByPN1x7eS4amCwXZRVjUmeI0v72vutbg6cBDDIsXAJDr0BsDSJOEjA==
X-Received: by 2002:a7b:ce99:: with SMTP id q25mr1538922wmj.35.1604622309350;
        Thu, 05 Nov 2020 16:25:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm4552831wmf.45.2020.11.05.16.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:08 -0800 (PST)
Message-Id: <e128a71fec415e92cfcb9c63987ee8264235bb6f.1604622299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:54 +0000
Subject: [PATCH v5 11/15] strmap: add a strset sub-type
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

