Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B53C55178
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DF520825
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghCC2vkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbgKEAYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731526AbgKEAW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 19:22:57 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D5C0613CF
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 16:22:57 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id y12so385800wrp.6
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 16:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2gcop2RIjSqtF4D5GONDrn3Pf6fDwI4nosJXJatTx5c=;
        b=ghCC2vkHgDlm7f4WAVR+ceFHXgWpST22G4Bx9/7AQhKFqs28mhe1zjX6KIlB1L63Rj
         XQMuQywnzIkYEaPDGspp+Do80QYiD0/q0C752ulZtaejlwJcJmAkqHqOsSGzHwcWpnbp
         4cMJ4vm2omqF8MmivMRpwKM8KLED203xAG5IwQ8+DeYJnmdI36lH/jzDJHV0YZL+XYFx
         RNUk2TjwE3JLWIWd4nmrhZYdaSmEPgXbFk/XRxFteWt/zEBTbkPGaUTXCW/hNZuO5OY5
         esxw11CceU2P1vB87V3e40tc54wfP+YsMzvHIyB2+DbXey0sLrOHtX8o7WHjDYUQWFvE
         SInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2gcop2RIjSqtF4D5GONDrn3Pf6fDwI4nosJXJatTx5c=;
        b=rA64JH0il9lWZKvhjJgtkDc9kSgnAfH4HKsk24T2pjXLblw+dJeDFGzUqg/pRRit84
         /ejAg+Vb9lVUfcst92AaOf5YgYwIh+AoATkE23QZW3OmW4pD60FI23CyZa7tuYJ8Swcx
         A5WgSU+cyrNnWVpHoLw3/3yiYqcV3S/ROWBLkQIswSPMWDm9ygS24ypU9Lmg+nQLkZ2+
         4wmoUBlt+nbbLr8jX1dz0nnGRAYTsbFEnMRVE1XowSO6bXI/LYjkYPQiLEmX6sl/BI2f
         zHhlXkxqaN+PpBFlsjnjI8iXaKN4r3xIAfzfXLhXydbnWCN1quVJFETICe7QIwgh9DEW
         X/Yw==
X-Gm-Message-State: AOAM531EHeo41wQPRIq9VH4TDZYtZ+dwfG8s0aFGNKeU8NqzyFR4aZcg
        iheDzBP30ACTDrORtua3Vj6D+Lq9Wpo=
X-Google-Smtp-Source: ABdhPJwl2qORmTujz2djYmoTr8r0u3sqZIcLzWec5rg9LJjaY410wcNH6xNSXvsRClDUGAOeR08wkQ==
X-Received: by 2002:adf:9043:: with SMTP id h61mr580510wrh.237.1604535776111;
        Wed, 04 Nov 2020 16:22:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm7407wmf.0.2020.11.04.16.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:22:55 -0800 (PST)
Message-Id: <ee1ec55f1b44156c119fd03381af1d308284ca72.1604535766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
        <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 00:22:42 +0000
Subject: [PATCH v4 10/13] strmap: add a strset sub-type
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
 strmap.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/strmap.h b/strmap.h
index 56a5cdb864..22df987644 100644
--- a/strmap.h
+++ b/strmap.h
@@ -27,6 +27,7 @@ int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
 			.map = STRMAP_INIT,   \
 			.default_value = 0,   \
 		       }
+#define STRSET_INIT { .map = STRMAP_INIT }
 
 /*
  * Initialize the members of the strmap.  Any keys added to the strmap will
@@ -196,4 +197,68 @@ static inline void strintmap_set(struct strintmap *map, const char *str,
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
 #endif /* STRMAP_H */
-- 
gitgitgadget

