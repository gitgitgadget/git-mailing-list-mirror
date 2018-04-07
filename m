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
	by dcvr.yhbt.net (Postfix) with ESMTP id 571821F404
	for <e@80x24.org>; Sat,  7 Apr 2018 16:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeDGQn0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 12:43:26 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42663 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeDGQnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 12:43:25 -0400
Received: by mail-lf0-f65.google.com with SMTP id q9-v6so4515430lfk.9
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 09:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=HpZQADpynqYaw7XFsBJgE70DoGT4/KipbmRJkKrOhuw=;
        b=d2lRktjCv2Gd6jJ7Fh8JkLio0v7vS8xhvtyfNlhJM0NCIALOX+k/Nwb6U3qPAapAe0
         wEv61a16xZHfwa6eK2EZJ4JKxzzx6QkJZzdbca7XxKuoMJBXIc/wNvEjNakkEe8ADzFW
         ZhFDmtVZ7QJWvYp0ZcvDEsJvNaTGSVHrp6TxjIq0yPynW+/1D225oWQXq0sj9hLrF/CC
         x2Q5yFjD+0Y0/sygYVh+2hreYcP0QEgHU2Kr5sXwua2ccyeER7/WLHRo1tkS98ynuybM
         fI97H+C6A6uqVTp5TysjdTGc9PILI77Qcr3/uQU71kqlu95ja9d09MMwsRyd6mL2Xt+3
         UCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HpZQADpynqYaw7XFsBJgE70DoGT4/KipbmRJkKrOhuw=;
        b=qlpkncW+7o42FmwfQSVWyhNaUUmsMPC8VSGkEXfoPh8LkzgM4BhJy07+p75oowrfzn
         OVP35jUTmTAXF/crBsYTj2N3W2BnE3ewKrrw7n8sUJIV3dgoauvfWkwmbes7LDAlr+Sb
         /oObIXUeP/MkB42TqxDb3/w27lm+/1umqDb4MI5FJI2voDsxIdg+D+ivZiPoFqijf/Z1
         xjpZ4AR0Y5PE5mmYTtunhToB0y7rn+FPSfBYgmuWgtovmbM4tnQkhUw+sx4A22IFiapX
         sQUFDwXWuGgkhxpWdmoMw3qXyP8IFmtaeowkHSvCzN+Wa2PEyNSMAZV6/CmxcpuOlFuU
         1waQ==
X-Gm-Message-State: ALQs6tBpRbxqeWJxIV59W3O2rV+vbvD454748hlnWBw6vmWImu+o8npl
        Uej4KKtNKo3wQ6Cadp0adYP8V8P52yY=
X-Google-Smtp-Source: AIpwx4+dlOK2rA+gp1NcM9aAHyM+3nXLoEMemozx0OtNDAaVtsBszT1codrsgGDm2vQTaS11Cs8ZAQ==
X-Received: by 2002:a19:9855:: with SMTP id a82-v6mr18585005lfe.49.1523119403813;
        Sat, 07 Apr 2018 09:43:23 -0700 (PDT)
Received: from localhost.localdomain (c-5eea2591-74736162.cust.telenor.se. [94.234.37.145])
        by smtp.gmail.com with ESMTPSA id f200-v6sm2613958lff.35.2018.04.07.09.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Apr 2018 09:43:23 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Subject: [PATCH v11 2/4] ref-filter: make ref_array_item allocation more consistent
Date:   Sat,  7 Apr 2018 18:42:48 +0200
Message-Id: <20180407164250.54303-2-haraldnordgren@gmail.com>
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

We have a helper function to allocate ref_array_item
structs, but it only takes a subset of the possible fields
in the struct as initializers. We could have it accept an
argument for _every_ field, but that becomes a pain for the
fields which some callers don't want to set initially.

Instead, let's be explicit that it takes only the minimum
required to create the ref, and that callers should then
fill in the rest themselves.
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

