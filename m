Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BF771F404
	for <e@80x24.org>; Sat,  7 Apr 2018 16:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeDGQnf (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 12:43:35 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36760 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeDGQne (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 12:43:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id z143-v6so4522694lff.3
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=BeVf9HaCq8LUpwGeCmR3SvfnftSUxTFcl+r6WL7KwiI=;
        b=QpYFqlde+NVcHsocPXB/q7mSYqoLoYDCSVH4UBvgLOepg2l75KabixJgLTGaGLKtPW
         VxzBc5YIoIgwW3ezeNN2NvSo8Q4aOsZh/Z5lO+hqqip+3P+K8gnADesG8Wg0105Zkrpd
         WHgpVg536wCCWAlagMEQkrDgrWoJ++5BUnoaZWrChc/KAVm+tB/BOgvON5A7bKqLcjrD
         YTO7Q3D4+TcviaodNSqNb5dq8OcRCBGzDpainKEJARCeRem2YugWXCQQfWI4/oW2NZtl
         Gnzq21VytnDWZILf8OyvGThRAP2OpeTL/VNBh3MqJBHLrFsN9sP5ZyxJSzx95muRpjTV
         QZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BeVf9HaCq8LUpwGeCmR3SvfnftSUxTFcl+r6WL7KwiI=;
        b=jX8kl0nzYn0y7vU+iz7OYydKQ3v8TYQULrblf5IRCuXqbjmi5Qrd4ihY3EGUQDApv+
         XasbFMlT11SYvbjrJZzwCCXYiXalyXaiF/NKOB9lHQaBPb70aTiJjMkgw3d+nHvnDpBE
         TH62Jfbhv72b6hPxKNJ6c7ZTF9EqcKWixbUk07BC/JlnUnoFK4TpRy2Mewe/lf23tQWX
         gqGKDMJdvCQCqUzIVib4mx4LfXGTLf2Tb81DJkvWGLXl0da3R0LYCTTL13KJpqbKOzGD
         B7eJ3OUG1I3L+e5G/kxWvEBWlrfgIcxqG4DT+HNV0UkisUnuAKbiSgImXa39L917PEve
         hNOw==
X-Gm-Message-State: ALQs6tBAtbPq0Ac5gQtUS3v7mboBjbK8zXT3UtQmveQidWsnaU57Wj6R
        Iz/Jd90EB1H0cbk1Jsm2yjef7jAgg3I=
X-Google-Smtp-Source: AIpwx49Jy4XPX4mZTpgYsNzP45PAYiG4AzsDfqFBaeDxKbhY4xjIqnOnXhsc1W5CQT7PR2Bl51KrtA==
X-Received: by 10.46.153.142 with SMTP id w14mr19573930lji.116.1523119412643;
        Sat, 07 Apr 2018 09:43:32 -0700 (PDT)
Received: from localhost.localdomain (c-5eea2591-74736162.cust.telenor.se. [94.234.37.145])
        by smtp.gmail.com with ESMTPSA id f200-v6sm2613958lff.35.2018.04.07.09.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Apr 2018 09:43:32 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Subject: [PATCH v11 3/4] ref-filter: factor ref_array pushing into its own function
Date:   Sat,  7 Apr 2018 18:42:49 +0200
Message-Id: <20180407164250.54303-3-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180407164250.54303-1-haraldnordgren@gmail.com>
References: <20180407164250.54303-1-haraldnordgren@gmail.com>
In-Reply-To: <20180402005248.52418-1-haraldnordgren@gmail.com>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In preparation for callers constructing their own ref_array
structs, let's move our own internal push operation into its
own function.

While we're at it, we can replace REALLOC_ARRAY() with
ALLOC_GROW(), which should give the growth operation
amortized linear complexity (as opposed to growing by one,
which is potentially quadratic, though in-place realloc
growth often makes this faster in practice).
---
 ref-filter.c | 16 +++++++++++++---
 ref-filter.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index c1c3cc948..6e9328b27 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1840,6 +1840,18 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 	return ref;
 }
 
+struct ref_array_item *ref_array_push(struct ref_array *array,
+				      const char *refname,
+				      const struct object_id *oid)
+{
+	struct ref_array_item *ref = new_ref_array_item(refname, oid);
+
+	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
+	array->items[array->nr++] = ref;
+
+	return ref;
+}
+
 static int ref_kind_from_refname(const char *refname)
 {
 	unsigned int i;
@@ -1930,13 +1942,11 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_ref_array_item(refname, oid);
+	ref = ref_array_push(ref_cbdata->array, refname, oid);
 	ref->commit = commit;
 	ref->flag = flag;
 	ref->kind = kind;
 
-	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
-	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
 	return 0;
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 68268f9eb..76cf87cb6 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -135,4 +135,12 @@ void setup_ref_filter_porcelain_msg(void);
 void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format);
 
+/*
+ * Push a single ref onto the array; this can be used to construct your own
+ * ref_array without using filter_refs().
+ */
+struct ref_array_item *ref_array_push(struct ref_array *array,
+				      const char *refname,
+				      const struct object_id *oid);
+
 #endif /*  REF_FILTER_H  */
-- 
2.14.3 (Apple Git-98)

