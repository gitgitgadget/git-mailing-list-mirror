Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A55C388F7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED9320782
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="k/g2ZlE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgKDUeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDUeE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:34:04 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0021C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:34:03 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id m14so13151822qtc.12
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTcMznac2FNUvXkue419Nx7xciF1IkotZ9JBOYQ3o2g=;
        b=k/g2ZlE3svn4iJo0TBuY/Mp5S/lv5g6Y0t732b0NI9PclEkCAJXII9MdVj/s2c2KTU
         D2+ciYmxvsalv7O+129ibWDP8X0vNOmtE95xtVK3jy90vmfERUCmoJQKtwtH5V41+BpP
         YsZiXxxZStgLcnUkLhD8H4dXHDSAYeEEyY5DBnG/23iXr6BkELdbwYIbKBRzVu4VUGeN
         CiDITVVMcyBJ2HCq6I4Us54NqHaNz66aNag28ORwoaANRtbhr03z58ZaCclz5+hi7XWd
         iyA3Uqgs/Ln46gqBAnd2Nwern5ocsT2mygNCINECxOrMmrnj6Txs/FVx4mCBP3s0BoZa
         UzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTcMznac2FNUvXkue419Nx7xciF1IkotZ9JBOYQ3o2g=;
        b=ccHtCNzgWe2qd11T8PMSiLNPWAtVE/HRuTpKOtQkbCANGa5dUoiiIrnh9Fesnl+ymB
         es4yNR4sM9xTdVeDvBy8a/i+2udcPwKn8TPoymSGCPE3R5jAkX8ggx7oVSIGHAmbuxua
         G/hOspUjvL5GmPI1ERFbraXnkTqGydKX1sEnPnjVuuR8bAsi/6PCZoRZkeXwFVXHZJK3
         +YsC1zejywPY+dEJElB8TJ07JS6iBGOlYTUKsEqP/EF6DKncw1XOqmiUirhBXO+JDoev
         W9x0p/zss3PpAnkChh4H8eH98boX6kA7FUMjvBssJhJT31MBW5FnQD3yQOiEKiA89wQe
         KwyQ==
X-Gm-Message-State: AOAM530S1p+2N7DcwUYrno9nRkGK1A+gj5053VpiVyhVXMAAOjVfj4YH
        4VDM0KixUqJNd8NPMMZ3M5hT/87N3Q+Dvw==
X-Google-Smtp-Source: ABdhPJxBKISwxveYtadcYf0FnjPMEPr6mV6H8igx9z5VXrpyaP/Pv0cj45t/dMx5faDWAI//AuiB/Q==
X-Received: by 2002:ac8:4c8e:: with SMTP id j14mr22016490qtv.223.1604522042701;
        Wed, 04 Nov 2020 12:34:02 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:34:02 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 09/19] entry: add checkout_entry_ca() which takes preloaded conv_attrs
Date:   Wed,  4 Nov 2020 17:33:08 -0300
Message-Id: <aa635bda21c43e0d82ce21e791df280ee6231d43.1604521275.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parallel checkout machinery will call checkout_entry() for entries
that could not be written in parallel due to path collisions. At this
point, we will already be holding the conversion attributes for each
entry, and it would be wasteful to let checkout_entry() load these
again. Instead, let's add the checkout_entry_ca() variant, which
optionally takes a preloaded conv_attrs struct.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 13 +++++++------
 entry.h | 12 ++++++++++--
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/entry.c b/entry.c
index 486712c3a9..9d79a5671f 100644
--- a/entry.c
+++ b/entry.c
@@ -440,12 +440,13 @@ static void mark_colliding_entries(const struct checkout *state,
 	}
 }
 
-int checkout_entry(struct cache_entry *ce, const struct checkout *state,
-		   char *topath, int *nr_checkouts)
+int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
+		      const struct checkout *state, char *topath,
+		      int *nr_checkouts)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
-	struct conv_attrs ca_buf, *ca = NULL;
+	struct conv_attrs ca_buf;
 
 	if (ce->ce_flags & CE_WT_REMOVE) {
 		if (topath)
@@ -459,7 +460,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 	}
 
 	if (topath) {
-		if (S_ISREG(ce->ce_mode)) {
+		if (S_ISREG(ce->ce_mode) && !ca) {
 			convert_attrs(state->istate, &ca_buf, ce->name);
 			ca = &ca_buf;
 		}
@@ -530,12 +531,12 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 	if (nr_checkouts)
 		(*nr_checkouts)++;
 
-	if (S_ISREG(ce->ce_mode)) {
+	if (S_ISREG(ce->ce_mode) && !ca) {
 		convert_attrs(state->istate, &ca_buf, ce->name);
 		ca = &ca_buf;
 	}
 
-	return write_entry(ce, path.buf, NULL, state, 0);
+	return write_entry(ce, path.buf, ca, state, 0);
 }
 
 void unlink_entry(const struct cache_entry *ce)
diff --git a/entry.h b/entry.h
index ea7290bcd5..d8244c5db2 100644
--- a/entry.h
+++ b/entry.h
@@ -26,9 +26,17 @@ struct checkout {
  * file named by ce, a temporary file is created by this function and
  * its name is returned in topath[], which must be able to hold at
  * least TEMPORARY_FILENAME_LENGTH bytes long.
+ *
+ * With checkout_entry_ca(), callers can optionally pass a preloaded
+ * conv_attrs struct (to avoid reloading it), when ce refers to a
+ * regular file. If ca is NULL, the attributes will be loaded
+ * internally when (and if) needed.
  */
-int checkout_entry(struct cache_entry *ce, const struct checkout *state,
-		   char *topath, int *nr_checkouts);
+#define checkout_entry(ce, state, topath, nr_checkouts) \
+		checkout_entry_ca(ce, NULL, state, topath, nr_checkouts)
+int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
+		      const struct checkout *state, char *topath,
+		      int *nr_checkouts);
 
 void enable_delayed_checkout(struct checkout *state);
 int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
-- 
2.28.0

