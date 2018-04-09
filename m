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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC0E1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 01:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932932AbeDIBms (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 21:42:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34703 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932909AbeDIBmo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 21:42:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id w2so15434669wmw.1
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 18:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=14dDpLUz/O8Jo87ZEY1u02btoPmxPBcw8Y4WaAc1l9E=;
        b=ccNFibnaehsLrr7pYvSv3fflVD5LoIaqQmZrH57EXMfjPBT6K3aSANCLChhrN+5gme
         2o/dcpkVezZfF8zX4CPPE7aA25awVRGdYwjTKq4lGqnSLxMSdm8+Xn/5SacOmXouPk1J
         iPelipgt/q79bXC7dRcKGpJRnewEdgcbfpjtxYlUbXwreBqVpdy1MN8r5OaY/rjmJc4Q
         /ZY0PpBwBTIvA7FcGRlCw87H5SjYFpAzKVvdI7BLc/q26g5YC17kcr3T7Za3ENFwQ8n1
         /Zv7DzKYppF7vV16ZJ+XoLBTqpbXOLgUJfjsi2dMYBgcaRSLNBxJacFwDx1l4tNKH+aV
         B88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=14dDpLUz/O8Jo87ZEY1u02btoPmxPBcw8Y4WaAc1l9E=;
        b=gASz6yMuEHST/scCnaBibYgZ+o731XEqMmLYbYTCPdc9SMx19B3Eo0DJuTqO1r7jlE
         bqKsHpUZ7LDTb30mFTG/6TeLhNgxQ5ckA1ImgrBID3wXR+NlaPVtJfYuO7rgPMeVWYvV
         KXxaA0nBsZs895GPVO5rv2yAQYL4b/XejRRl9rYRM71S63Yf2q9B+3N0sScbYJtQCtt8
         hV1yHFYqhmLFR+J2YiR2WkYwn2WhphBdhWqKuyNLJ8Eoq11tofhsnq54FQKHeDQY2P77
         eB1gJAC7JAxfVeJSoJnopLEKN2wD5GRDTA90GKyFlQDv1OWbAlXkYVSoOZy3ma3Kfelk
         9quw==
X-Gm-Message-State: AElRT7HCyvOVHcRwUcu668cI016+u39MR8rKF/hB7TvXFd+ZDHZrfeP9
        6/gNk3ABHpyUjymqiIW2dzlTMrVH+VA=
X-Google-Smtp-Source: AIpwx4/uv/6I6aTlJppsk7Hub9vnCs5PgzvHWg9MNxW5a/ALg1B7vPQh7i3LcAd+A31kORUlZT7etA==
X-Received: by 10.46.154.71 with SMTP id k7mr21044354ljj.42.1523238162934;
        Sun, 08 Apr 2018 18:42:42 -0700 (PDT)
Received: from localhost.localdomain ([94.234.37.145])
        by smtp.gmail.com with ESMTPSA id n62-v6sm3197231lfi.4.2018.04.08.18.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 18:42:42 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v14 2/4] ref-filter: make ref_array_item allocation more consistent
Date:   Mon,  9 Apr 2018 03:42:24 +0200
Message-Id: <20180409014226.2647-2-haraldnordgren@gmail.com>
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

