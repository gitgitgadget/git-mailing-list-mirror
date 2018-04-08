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
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE501F404
	for <e@80x24.org>; Sun,  8 Apr 2018 12:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeDHM2v (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 08:28:51 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39010 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeDHM2u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 08:28:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id c24so5644007wrc.6
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=14dDpLUz/O8Jo87ZEY1u02btoPmxPBcw8Y4WaAc1l9E=;
        b=JmsESZZFfqoGIKcWfFBomXXeJ2KvuHpoWe17ycwVp/dk02dFzO2vASwftFa6uhW6eh
         ElDlJPvT06POTigGTmuCraK8OZk4OaBwPD7zR80lz8CMwXykhYQt9SyQTsnDLC1dHLTx
         X+o/qlCu5SvvDjzr7YoisFF6oUgE2BWHQ40cWr8kNb+W7SdlJTsxV7ryePdUI6lldmqF
         s8lnr4qsrIhjLNNSp1KjK3sPnxRrgTJnzajVDlyzLdm3Wy6HaZDfqrfpJPX8lsZKLTyi
         rhmn/r3l0B4RijfMjBTc1H0HAJKNecftx4E6Njt6DIvJw17RD6WDrvenJeMr3+YXNzPM
         a2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=14dDpLUz/O8Jo87ZEY1u02btoPmxPBcw8Y4WaAc1l9E=;
        b=e/20LJUBiThysVLBlND3VJrhjKeSFDuenCKWtfFc1XAM7fivr9rCkzd5R9HqIKQSFM
         Ibj/VeLxv6fL6l0TLEHudty8okqsQ96kP2bJardqBuklROQienF/Zh6Y43HkjmwiJzpQ
         c3mfSI+B504aC93e+Dkcr8uawXNX9l7DoACPxuhRucQUuZv36cYTaQUxqJ7Bg7ZX+aj5
         rhzjRIJ6Gu2dVpIUuZk7LVoBSM+FOJTpcRbGZbLvR6qndWOSyKK+9EAIzzsPbSFJs0y3
         lgWX6ps8neHflPD34JxWFgviz+4awgtLNo27y4hP9H4t6AWK5ckdANSSvzybgDUKLO2R
         KCeA==
X-Gm-Message-State: ALQs6tAColXSlaOamlFTaHMMaRVrzdtFh5Gv4/I3/pK5pQOpf5q66qed
        iGszBIzWdOqvzEWusWv5Fs26h5GXI34=
X-Google-Smtp-Source: AIpwx49K0qP8Ihqb9ZVTkmTMQk1JWAmd6kzoM3Ec2FRgo6w7EfpVGQ79F5d3VKNE1DjcobLHx2Et3g==
X-Received: by 2002:a19:c441:: with SMTP id u62-v6mr20641656lff.104.1523190528903;
        Sun, 08 Apr 2018 05:28:48 -0700 (PDT)
Received: from localhost.localdomain ([94.234.37.145])
        by smtp.gmail.com with ESMTPSA id p9-v6sm2965038lfh.93.2018.04.08.05.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 05:28:48 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        gitster@pobox.com, sunshine@sunshineco.com
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH v12 2/4] ref-filter: make ref_array_item allocation more consistent
Date:   Sun,  8 Apr 2018 14:28:30 +0200
Message-Id: <20180408122832.65414-2-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180408122832.65414-1-haraldnordgren@gmail.com>
References: <20180408122832.65414-1-haraldnordgren@gmail.com>
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

