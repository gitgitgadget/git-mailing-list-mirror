Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D47C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F380020738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="k8PnvXwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391078AbgJ2CQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgJ2CPz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:15:55 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1B3C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:55 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id d1so160668qvl.6
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYT4R9ALwv2Rpt7TK8K0S9uE1PRUq0gDUVR/1tkQK5U=;
        b=k8PnvXwd/0el+S1HBmgesjfpP2V1aY6sGZLDAQli/+k1lhUqMiqTMWwInMmRKQZpBI
         OyxtxQMQDqSpGTNvmWqxf3cJrF2OWxxVo6xzuTyaxk9FEw9sMnYsT6o6n0PKR5d//hfx
         z/9YK7zavuDxRUQRfHI/UxVJuFL5W+7nQ5GX8cuBCBayQixEZKCCQb6z19zEiSyMY0+N
         9XeeUTrIWNH0UG++zO+8WQiMoKuQLQFWtj/rCsFR/htiip0Zef6/y2aNSyN9YMTGbDvN
         IKL2M4ykRT1z0xfXS1tzHHIZH5AB/5hrTAfajdDKtFhgtfbKsEXnN35Ch0EJXOFr4W6D
         Ly1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYT4R9ALwv2Rpt7TK8K0S9uE1PRUq0gDUVR/1tkQK5U=;
        b=GQ2XSTtMWxDuXmEtS6efrtG9T9Hrlj2ywjTfEp66Ji2jhZVglPJSYSQMHow9UbuBcp
         Lgqv860qExhGXF5Lz6aejycwFt0xEeaCx2Xi8Zc++oJHQtDzJOprs3dLpFejUt2P9Rwz
         qF8jyUjE1DX2EGZGgIdW92tn/3pHQart+/XFSkpI5kAlGXz74tmuBplB0zw235E3/abt
         Sgp1+b2tmY4ipv/ZUtTytaGxHDNh5CGszHtb19bfzErkD+5kVIgU2Fh1N5GEdSzcfvmr
         MsBkbtFzXngdPGe+64lA37rb+r7qAxIji36h13BbQ1hFzUAwlT9cbWc1PS2L3svaYmI5
         SNMA==
X-Gm-Message-State: AOAM532uaGlfDDTFEWMltfZGTp6IyH5FxJdXMCgL9sSEzEG7785stfyf
        cxiP7lAIoOgy8bRTMUhjKeIAC4q5CX+Gcg==
X-Google-Smtp-Source: ABdhPJxxqNCtGNN1xBFDZsX0vYCa7LV/UbDNGkc+HSAErkevlozmaIpErYo+G4CeW6dHxGrAC4SMug==
X-Received: by 2002:ad4:58eb:: with SMTP id di11mr2012329qvb.56.1603937753996;
        Wed, 28 Oct 2020 19:15:53 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:15:53 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 09/19] entry: add checkout_entry_ca() which takes preloaded conv_attrs
Date:   Wed, 28 Oct 2020 23:14:46 -0300
Message-Id: <e1b886f82320db6fd1b389eb4d63ac45bd5af7b1.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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
 entry.c | 23 ++++++++++++-----------
 entry.h | 13 +++++++++++--
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/entry.c b/entry.c
index 8237859b12..9d79a5671f 100644
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
-	struct conv_attrs ca;
+	struct conv_attrs ca_buf;
 
 	if (ce->ce_flags & CE_WT_REMOVE) {
 		if (topath)
@@ -459,11 +460,11 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 	}
 
 	if (topath) {
-		if (S_ISREG(ce->ce_mode)) {
-			convert_attrs(state->istate, &ca, ce->name);
-			return write_entry(ce, topath, &ca, state, 1);
+		if (S_ISREG(ce->ce_mode) && !ca) {
+			convert_attrs(state->istate, &ca_buf, ce->name);
+			ca = &ca_buf;
 		}
-		return write_entry(ce, topath, NULL, state, 1);
+		return write_entry(ce, topath, ca, state, 1);
 	}
 
 	strbuf_reset(&path);
@@ -530,12 +531,12 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 	if (nr_checkouts)
 		(*nr_checkouts)++;
 
-	if (S_ISREG(ce->ce_mode)) {
-		convert_attrs(state->istate, &ca, ce->name);
-		return write_entry(ce, path.buf, &ca, state, 0);
+	if (S_ISREG(ce->ce_mode) && !ca) {
+		convert_attrs(state->istate, &ca_buf, ce->name);
+		ca = &ca_buf;
 	}
 
-	return write_entry(ce, path.buf, NULL, state, 0);
+	return write_entry(ce, path.buf, ca, state, 0);
 }
 
 void unlink_entry(const struct cache_entry *ce)
diff --git a/entry.h b/entry.h
index 664aed1576..2081fbbbab 100644
--- a/entry.h
+++ b/entry.h
@@ -27,9 +27,18 @@ struct checkout {
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
+
 void enable_delayed_checkout(struct checkout *state);
 int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
 /*
-- 
2.28.0

