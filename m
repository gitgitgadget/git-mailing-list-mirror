Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD59E1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeIRDFT (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:05:19 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:52651 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIRDFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:05:16 -0400
Received: by mail-pg1-f202.google.com with SMTP id m4-v6so6798504pgq.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1tJhZiYTYExsGZ+1the7R9+lAxiqWj13Klz5W2m723c=;
        b=BlslopDKfZUYfk3qIPSr+q/SCzn/9KE/in5u2pP1q7Tgy+qTZ1A/gmxLitsrak4MAv
         FVvKHqyp7SwT2GBLVAtgNQYcqPgvM6bVIHsj2teIZQR2kcv0op1dPC60S2cvmmGOcuOM
         hwINxxG1TSyx2aW00NoH//YkSSSpN2C91DY9Q1MzYY5q2yBWHfaFvPrXGB7asj1rLqZM
         1cRpUwl+zJj7MOmjxcrgAy3K4vGv3JHlU576WWFaFeW2Ra6D7z1u/322BvjkkQnVN66j
         D/3YpZE7a/4goO6fzPr+Kn/dSDuRJO8nEnv3O/R63FTJoGvV6G6U7gWPL2YvPdieqX+B
         qooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1tJhZiYTYExsGZ+1the7R9+lAxiqWj13Klz5W2m723c=;
        b=mMMzCxOZVtbSBlVe4OZ6zqX+AiKHoc5RXhrw5Xbt6V5cqPNRAWzLfc6YLEf735/3Ee
         ECY8C4kKjSfkiW6Py+TrpBGyQ9vmVyR0YVTNKUc2vaADELt2kdm9WennwiHeonwHM6a5
         ylNVxd/W7p2hIPk3tW8Bf8bh2TYDOa9HDeNVlgOPGIiIsX6vkyvSU9IiUcTI9NS42uV3
         CXCnURrFvs3eupY6lk25lFErDnvybYQiUlj5tNabkKjp7A2LnYs0BBiclMZCcjdru3rd
         cBKWqOV2ruZMOgU4QiWj5VO7LVfKBfOz7TpsYQStD6J9mEIIbbSJf7xuV5SnoI6IG4Oh
         YY8Q==
X-Gm-Message-State: APzg51Bn5terb4FcHJ9789CfeMKrxVJrBoZehXBZybQYCw2lunFu3QaP
        fyazc1XQQH+SWXA2eiK+rcTLbzkq9dpI
X-Google-Smtp-Source: ANB0VdbJiv/6+cUQJlVaeWT9HCwWRWPmr1QFsLQNp1JuJ0+PXkHO4GbLT/TORxCD/YBfo/zGZ6xaWmUU6OZR
X-Received: by 2002:a63:7218:: with SMTP id n24-v6mr1082547pgc.157.1537220167603;
 Mon, 17 Sep 2018 14:36:07 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:35:52 -0700
In-Reply-To: <20180917213559.126404-1-sbeller@google.com>
Message-Id: <20180917213559.126404-3-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180917213559.126404-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 2/9] sha1-array: provide oid_array_filter
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1-array.c | 17 +++++++++++++++++
 sha1-array.h |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/sha1-array.c b/sha1-array.c
index 265941fbf40..67db5eeec9a 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -77,3 +77,20 @@ int oid_array_for_each_unique(struct oid_array *array,
 	}
 	return 0;
 }
+
+void oid_array_filter(struct oid_array *array,
+		      for_each_oid_fn want,
+		      void *cb_data)
+{
+	unsigned nr = array->nr, src, dst;
+	struct object_id *oids = array->oids;
+
+	for (src = dst = 0; src < nr; src++) {
+		if (want(&oids[src], cb_data)) {
+			if (src != dst)
+				oidcpy(oids[dst], &oids[src]);
+			dst++;
+		}
+	}
+	array->nr = dst;
+}
diff --git a/sha1-array.h b/sha1-array.h
index 232bf950172..ae059ca0431 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -23,4 +23,13 @@ int oid_array_for_each_unique(struct oid_array *array,
 			      for_each_oid_fn fn,
 			      void *data);
 
+/*
+ * Apply want to each entry in array, retaining only the entries for
+ * which the function returns true.  Preserve the order of the entries
+ * that are retained.
+ */
+int oid_array_filter(struct oid_array *array,
+		     for_each_oid_fn want,
+		     void *cbdata);
+
 #endif /* SHA1_ARRAY_H */
-- 
2.19.0.397.gdd90340f6a-goog

