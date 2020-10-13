Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CEEC8300A
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953AF221FC
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vz4k2Osd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgJMAlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 20:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgJMAlB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 20:41:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA0CC0613D1
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:41:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d3so19770759wma.4
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iWvAwS9aXbUqDr3/4BBwlTWRv2d1rnfnw12nVrdpWDc=;
        b=Vz4k2Osdng01RKivC067jphnQ4KKzvWqPDPLsOBKwIrw8tRhRTZO9f6Z/TaamcyXQ+
         rTgocB6RXER5FzeLl5NxrgVUeyqL8pW2hwuOAJ6S0pN/dM8rxsNEjmEZMQXG8UoptxI1
         Ha3CqdZQMxdnqpxsqarziXup98fMKdMFfP7QWjpdJQt5rYukeGOlYJ++1scn4H9FU5Dc
         pnHv2nTbp5jdJQdY8W/NIHaCA4ciQ7KK4AWDHRQ2C9AjBjaxj6BpSMxklvboIb5YlrI2
         /7baJwsrHSE6Yutf9pZN4CTIPmuYlE6y6bizT2NjdRTjP3MleJCTmLbiNGOv0UhQ6n3s
         Y4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iWvAwS9aXbUqDr3/4BBwlTWRv2d1rnfnw12nVrdpWDc=;
        b=Z5vpyWO1isbKttMTISBH9m7CcxtuWiNpXC87B6PCyWQxWUgfI4K1K1FwH3l5A5k7cc
         +R8pwmnoRgq5dFJBIskMyPfEJx3G9Q08xvvVExKqHFYgDey+oVQyj+yEEWwpUO+ZG7Qk
         Hv/SyfGbx7n5TivkhOHOSABjf1yjd8/v9HHOi8QQlUFbyWflKwwcli3rAdemR9nDBXZ+
         XvSlUN9DVXlV0VtBFr7zcTJMohppjQoPAZJYGnlcLHuh/OAafVgfJGPIYy99XBVcfNr9
         B+nVyLEVnlHRqhqfjXJHFlfSxgO7XKbiVB6jUlp+cskF6TBYR10OEoMR0UDwIlZyMNwG
         0GQg==
X-Gm-Message-State: AOAM5314bAvpTAf9ZqbNaN2lD4OHmDFXpODUAzS6st8PBx2qBhF/ct3c
        5eNuApFFKrtqVxJ6aAP7DiUpzNxkneQ=
X-Google-Smtp-Source: ABdhPJyu+Y4k5Wz+QmlbFViDY0hijdFvPrf3PQN19Kk7MBly6faG+mWwR7VyveWOkDtrfY27jGii0Q==
X-Received: by 2002:a7b:c01a:: with SMTP id c26mr12945743wmb.35.1602549660080;
        Mon, 12 Oct 2020 17:41:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6sm26860258wrm.69.2020.10.12.17.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 17:40:59 -0700 (PDT)
Message-Id: <490d3a42add2cc5f0d30db8f2351614294e00121.1602549650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
        <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 00:40:49 +0000
Subject: [PATCH v2 09/10] strmap: add a strset sub-type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
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
free_util argument to *_clear(), and the *_get() function), and
strset_add() is chosen as the API instead of strset_put().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.h | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/strmap.h b/strmap.h
index fe15e74b78..2ad6696950 100644
--- a/strmap.h
+++ b/strmap.h
@@ -178,4 +178,68 @@ static inline void strintmap_set(struct strintmap *map, const char *str,
 
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
+static inline void strset_ocd_init(struct strset *set,
+				   int strdup_strings)
+{
+	strmap_ocd_init(&set->map, strdup_strings);
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

