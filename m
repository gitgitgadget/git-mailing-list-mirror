Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF7B1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeDHX6f (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:58:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55180 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752793AbeDHX6d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:58:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id r191so14580790wmg.4
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=14dDpLUz/O8Jo87ZEY1u02btoPmxPBcw8Y4WaAc1l9E=;
        b=Y1x6L016JtgUM/1qbMi6uMxz9Kv2FRiqlHMG9oBkNwJIABIYdmEwHGeGLgzQLeJpnN
         FtgIIc8QOQW2kuXKA36HI1cNu9hdpBXgv5Io8n32P3rGJYmtkA8eE2iFXEQLVtpuYGVZ
         G3OF89KGsDoQFZXZ6oYa0JMYSjhTwZ4q4uE6tv7bJAiJrhq5x6As8RQf6neo5wznbZC6
         GAcDXd6VOo+P6RaaCNOltJLv5yDk6GFtLewC6N0HHpF30B9adrrVAlMNDvYFWwGy2oPP
         Hg1K7kaqfTmGsKE988FAzzH99zWs5T5mNdLnBxTjf8lQhpPckF5rKm5ppU3sD1anCVls
         OX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=14dDpLUz/O8Jo87ZEY1u02btoPmxPBcw8Y4WaAc1l9E=;
        b=cpIq7W3rMjYKvUKnU7/m5y0MThfMLDOIpQGSM4T9WkVjcSvBexS02uhJvCvD1zoRaf
         BoFA8wurREJJ7oyacekC8pCF1yt8W2070MqBqk5TAfXfOjXwFvhNpDT2oOtkJXegRGxb
         +hxKidRKtQ/YcL3VvREELpmMfVudObu7lYOH/0Kp1rST1WLa6BKfgHcUZI5i0ALt/Vy2
         9ESyH7V5gwPp0GWEkwmh94mdeogzzF1VSefhL+xCjDCOjnTj6oKmnZ4HiMViVkmQHvuf
         f5VImfrM2DGut/gGn2UKIJvSxsi1nXVsp/4+SZxEe1heuDKFgL6H/oerNnGQAgvPC6hi
         5tlw==
X-Gm-Message-State: ALQs6tAPetw97oQMm8rPt0jJ48mBmA3E/7SllYALb/8dY46T9i46YFdh
        PMwBuDDGgYIzVW8Nmk8l6GmAS8ymWUk=
X-Google-Smtp-Source: AIpwx49z/kHQm7GG1LQejOebBLObi297mG1LMFTYdt0QLhcZwFEdE8AmPL3XiS6BYKV/QZd+8/8CJw==
X-Received: by 10.46.151.195 with SMTP id m3mr5040845ljj.100.1523231912116;
        Sun, 08 Apr 2018 16:58:32 -0700 (PDT)
Received: from localhost.localdomain ([94.234.37.145])
        by smtp.gmail.com with ESMTPSA id x4-v6sm3108742lfa.23.2018.04.08.16.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 16:58:31 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v13 2/4] ref-filter: make ref_array_item allocation more consistent
Date:   Mon,  9 Apr 2018 01:58:13 +0200
Message-Id: <20180408235815.36582-2-haraldnordgren@gmail.com>
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

We have a helper function to allocate ref_array_item
structs, but it only takes a subset of the possible fields
in the struct as initializers. We could have it accept an
argument for _every_ field, but that becomes a pain for the
fields which some callers don't want to set initially.

Instead, let's be explicit that it takes only the minimum
required to create the ref, and that callers should then
fill in the rest themselves.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 ref-filter.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ade97a848..c1c3cc948 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1824,15 +1824,18 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 	return NULL;
 }
 
-/* Allocate space for a new ref_array_item and copy the objectname and flag to it */
+/*
+ * Allocate space for a new ref_array_item and copy the name and oid to it.
+ *
+ * Callers can then fill in other struct members at their leisure.
+ */
 static struct ref_array_item *new_ref_array_item(const char *refname,
-						 const struct object_id *oid,
-						 int flag)
+						 const struct object_id *oid)
 {
 	struct ref_array_item *ref;
+
 	FLEX_ALLOC_STR(ref, refname, refname);
 	oidcpy(&ref->objectname, oid);
-	ref->flag = flag;
 
 	return ref;
 }
@@ -1927,12 +1930,13 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_ref_array_item(refname, oid, flag);
+	ref = new_ref_array_item(refname, oid);
 	ref->commit = commit;
+	ref->flag = flag;
+	ref->kind = kind;
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
 	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
-	ref->kind = kind;
 	return 0;
 }
 
@@ -2169,7 +2173,7 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
-	ref_item = new_ref_array_item(name, oid, 0);
+	ref_item = new_ref_array_item(name, oid);
 	ref_item->kind = ref_kind_from_refname(name);
 	show_ref_array_item(ref_item, format);
 	free_array_item(ref_item);
-- 
2.14.3 (Apple Git-98)

