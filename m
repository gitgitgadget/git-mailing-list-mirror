Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C661F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbeIVE1O (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:27:14 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:44891 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVE1N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:27:13 -0400
Received: by mail-yw1-f73.google.com with SMTP id w23-v6so6555846ywg.11
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cE3W+XwBM7hWw/AFGsDXDmScj4IvN7B5gFDXK16U1g8=;
        b=O5qqJC4vF39UAyoAEK/2ssdpXh0ZKbAwTy7BG7jixq9bcRj7L38qjpG4vM80vWwa7W
         h+m5/771LMDko5wIU9HSfEuez7d1nR4oqEPXx63RdOQLOlE6rBulAFqAMo4t1N1xXVTV
         Qmua85B0smhlw9pmzVr9dr+ZdHqlYfFjq797r50Dy26v/CzmPz0+PGZhj5gc2dOSHNTP
         uo0woA7Bqsl0o7gNPQZj7ig3fXLKErDQHL9TVPQarNENWDUa5N3jM5H/wJ34o5RBuBGU
         G1tlxySbDo4VSJFBOhOxrc1DItFBKJoYmcD5ClIpLGTB8tvNsX6dPmbNKcRp46ICrpK5
         1+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cE3W+XwBM7hWw/AFGsDXDmScj4IvN7B5gFDXK16U1g8=;
        b=S7Zx4UsMFHqZ7qopq0ZdtiW24whz3cTXbKFk+KRTav7rSJSopbubkiR0xAkbBWB+jP
         Ox3u4vKFtJDXkjYP0b+zBs5FBgCS0pNzVSINxG/ygsC/OitRnwKPZ9AvbWxPDsH6SRUd
         085bqn8c39SCrzcnf6AEBSLKuu4MDvoqWWSQFI6joMu+6St0bBcwNa9blPF31RNZaRv2
         sX7bnQs+8quGNZaQK7k1C6RE+P0IHwAH2oI9F03wvYW6mDp34HQSuONdNT+u2IdxR6Rx
         /qwZ0pKcYbzz265ah2mDGrorCcPpXR6zUzSxemYgDTucnZORI3j9LT28q5DXToz/pGEs
         7KGQ==
X-Gm-Message-State: APzg51Bnm+IGdbnS6KnrMYlOe953zyZ5ykkxxjNa4oOuaxT0RCGMDi1U
        srJ6Y0kc2PPPVocStRsikQ+k1uSR3E/9DV3wW1p4b49vY+gwOThhfjowXxJUGo9gqnXMGM11L8U
        MaMsntk3fNat+r5RICEaDK7Jfb0ZTEgCPXWwZnTy60kRPD7Pijs3yyEQUYXOe
X-Google-Smtp-Source: ANB0VdbBbc/FxwkwBXNfAfrrfj86Qcb4Zu/MNZHlVSU9gi2UtgJ7QQ0Zifi0n2xQ6nriVBf8EfVXtH0eHwzj
X-Received: by 2002:a81:8185:: with SMTP id r127-v6mr5543502ywf.147.1537569377580;
 Fri, 21 Sep 2018 15:36:17 -0700 (PDT)
Date:   Fri, 21 Sep 2018 15:35:51 -0700
In-Reply-To: <20180921223558.65055-1-sbeller@google.com>
Message-Id: <20180921223558.65055-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 1/8] sha1-array: provide oid_array_filter
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
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
index b94e0ec0f5e..d922e94e3fc 100644
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
+	struct object_id *oids = array->oid;
+
+	for (src = dst = 0; src < nr; src++) {
+		if (want(&oids[src], cb_data)) {
+			if (src != dst)
+				oidcpy(&oids[dst], &oids[src]);
+			dst++;
+		}
+	}
+	array->nr = dst;
+}
diff --git a/sha1-array.h b/sha1-array.h
index 232bf950172..275e5b02f5e 100644
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
+void oid_array_filter(struct oid_array *array,
+		      for_each_oid_fn want,
+		      void *cbdata);
+
 #endif /* SHA1_ARRAY_H */
-- 
2.19.0.444.g18242da7ef-goog

