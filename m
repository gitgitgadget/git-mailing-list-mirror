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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD021F404
	for <e@80x24.org>; Mon,  9 Apr 2018 01:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeDIBmr (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 21:42:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39865 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932921AbeDIBmp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 21:42:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id f125so12951525wme.4
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QKcry4kzV21/y/X71Ud+Q6qoV4iWVtcFVAyqWjIBh8M=;
        b=NWM1ao2b8XJJdpZhT8EQxHP6YsexVtQQROF0nrk7agVXeP5Z0JFJ8FbdJoJjPz+8mN
         nrt7sRoplebk+lAv/QKvCw5FJ6LKdyAgMz8DqxD7s1CshhvLkjFaYAOCUF7f1Z8fpxm8
         kCcyjZYuSsqYL54Gy0T0JkKyrL+2wFFbQ0q7FJDhY1//tzXHk5XtkawRE0po5mUbPNXe
         ovJwLRuJrpuUoUmx40cFBbls0+YnPAIF31VfWcsEYXWT3KsoqYL+2kf+f8DpUeCV8Qz+
         yssbhv2nQjlyyl9a1MSlGP7T4vxtPk2P/Kgsdi/7ja+7XyNwIm0uurP5MHebyq3ojLEE
         tJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QKcry4kzV21/y/X71Ud+Q6qoV4iWVtcFVAyqWjIBh8M=;
        b=s5tfEakglDPqeQcUSOWqCRa1kc/Q6kQpVfIzUltyXBkifw3u/Zy8VjdTxeCPL1RRQY
         SuKNSaF5sFgRVHz9VqjoU/G78PO2Bn/swdM3cyGKBAGzTWrt4Ty76NYXxkm4xA1u++k9
         nEE90zBJmmqwiIlRZoRn29gHnvuONAZR/4OwF+s5FbbhheQXZjeaSw6zwnHRd6dUfcL+
         kXUpDo4j6gK8FrJa/llheEIsxROWVNRN7T14lOMt8cdr62+TO4iTtQVTYPfmD9ZCu6gg
         NAKib9qeTUbhkwU7xLkluZyOgGv/vfIQuUqMAc9uYk0c4yMTqx66agJBTIqGmmd1s8J4
         CrfA==
X-Gm-Message-State: ALQs6tCk6B5NWASX9iTpwB5loULCtR1APcTK9yQoqrNogYSdcE3zOtls
        p8futC1KtgZdhD8K6BIcBDue7pNgwjg=
X-Google-Smtp-Source: AIpwx49sa6Tf73gRNf1NGj2MukeEf26t/VpVggg4269Jg/eT+oEP+Ve2Ts/HpusJ4qkXLhzzOZC63Q==
X-Received: by 10.46.84.93 with SMTP id y29mr20554078ljd.11.1523238164142;
        Sun, 08 Apr 2018 18:42:44 -0700 (PDT)
Received: from localhost.localdomain ([94.234.37.145])
        by smtp.gmail.com with ESMTPSA id n62-v6sm3197231lfi.4.2018.04.08.18.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 18:42:43 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v14 3/4] ref-filter: factor ref_array pushing into its own function
Date:   Mon,  9 Apr 2018 03:42:25 +0200
Message-Id: <20180409014226.2647-3-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180409014226.2647-1-haraldnordgren@gmail.com>
References: <20180409014226.2647-1-haraldnordgren@gmail.com>
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

