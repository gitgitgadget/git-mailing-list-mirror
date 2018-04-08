Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F331F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeDHX6y (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:58:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34678 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752763AbeDHX6e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:58:34 -0400
Received: by mail-wr0-f193.google.com with SMTP id d19so3171033wre.1
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QKcry4kzV21/y/X71Ud+Q6qoV4iWVtcFVAyqWjIBh8M=;
        b=YrkTQ8qmKSs5f9zYkhPH5FljoiW6Q1SORQ0LfVJDHW77dnmqe42IosCNAJuqyijvKa
         EpE5G0OXxqwmEnY6BtBu8OR/DI5yca4U8o6qEOwUTQizO0796HWog2fIbvO8GiqXJjX1
         hmLqJlu44TszFhCopWTuQio8MkiWIXGUVyZC7paPlKVCihFGY4f/tOoHDOrrP78v/+72
         OfsidEIjGv8TIeqGH1omxkcIDR6c7jC8QS5wiyPxcD8xzQXuLBnBgRLgu2X6N73hyelB
         +CX2oGcAjOf4WobisHgSDP32YxbUWFKEdP0Z7XuC7f4TNhNdELVACovgsZEv3/owCK4k
         N4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QKcry4kzV21/y/X71Ud+Q6qoV4iWVtcFVAyqWjIBh8M=;
        b=LX6ZKR7tvEyFlqmnoeByt/2JabLPKTRXwLyTdieYlX3NHOZvqZNXtUwVNvWN0L0AI6
         SBehrrPplckZjg2MBEM3bUA8dMQt9a+sGwYwAdmOaXxQgz0GvNZVo44Nrm4oU8BhgxUs
         OeNGNQqFfXAyVm3hMJojeuMSBOBDDPPXFFWRE6MspTiASNmrtG2z2LLsJchx//s1kqAq
         RoNqSrhizOg3rYTgMBoMSm+roxUa9ooQhatLZQPq+AnmX3t4r2M0kBxHEDWe732kVMiY
         wpSpXOk8iR44WE4q4HA6DoEJLkIOUlw9i28e/WCF+2+BcqlF4mOpSe7CaQY8jGre8IqN
         AUbw==
X-Gm-Message-State: ALQs6tBExXl3S3kUGoUHei2QMsnaIw3PLUDdgqj55htnU1Q8GFxgvyo6
        AJUb4uEtJZbg2XumMTwywbdxyJKh8ks=
X-Google-Smtp-Source: AIpwx48qxyYYwhjjFyvT4tkwl9mBKGTFRb+LlFmhaNPIVKtB+ofnbZzVsuy13dBv6N7mVsnSEq6oSQ==
X-Received: by 2002:a19:4e5d:: with SMTP id c90-v6mr20206367lfb.98.1523231913344;
        Sun, 08 Apr 2018 16:58:33 -0700 (PDT)
Received: from localhost.localdomain ([94.234.37.145])
        by smtp.gmail.com with ESMTPSA id x4-v6sm3108742lfa.23.2018.04.08.16.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 16:58:32 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v13 3/4] ref-filter: factor ref_array pushing into its own function
Date:   Mon,  9 Apr 2018 01:58:14 +0200
Message-Id: <20180408235815.36582-3-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180408235815.36582-1-haraldnordgren@gmail.com>
References: <20180408235815.36582-1-haraldnordgren@gmail.com>
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

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
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

