Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5A6C433E8
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF92A619BB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhCWOVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhCWOUk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 10:20:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4539C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y5so12905226qkl.9
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ElDwQ3bqz1JzL9xCCcMy5fFosYhACGySz8GGdbUeG68=;
        b=DfeuhWss7c9hACJJfx9XEg+lsCSa+avniCkv3MnDfnVBLgZfCWS+qbpHADpqI9UHzv
         4GGEf+Vh1S7JO0dF4U4KlgWsDgGrOj4lcwTNQGx/IocfWMjEfYg4rQVL3XSouV90OJA4
         2cv3Ufo2pEPPVj0wEQM7e+CjYNv2P33z0+MdMFENlWF6Q2uMti+3Ojg0y4uXERppObZa
         N/4gSiEFoof/kCeeoMVZwjfA2wqL2CIL/8QAS2uXtbD7FMZOou0l3JaolTq6pZDlNAIO
         Fg4c4qJdzddcd/itSvIBuB3D5FsGBW4gMpORAnVd1GlasA46rfbWEXu50zYEpa+7oIwL
         qHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ElDwQ3bqz1JzL9xCCcMy5fFosYhACGySz8GGdbUeG68=;
        b=srxKURADV2h3v43P7KmpoYjkGrc56G1qddKhE/karrxMEswaAWG11PBG32DR9JN4nB
         QP/hChri9pg1kS1ZfVo3R/qgcu+RCG87CCR2lPVdUAPB56s5RhC4+eCMtcsCysRsbs7i
         TaXBtcGNjy2QgeKmkxjfEo6chOM0XW3al+9uMV/DbSAacny49RKalUljzlcYRXzgE1ps
         3Jzm06KVWaMaTGmbhmFyugttohU+OfOkZnj4gst2qhLLqVmF/2VS4X3TGrWGcM/E6cI0
         NEj7IX32f0OtjVc/y9fGYKZlXMOUmJKg7emDNNt6SOcSUOPodCjYMrtXtMlKwHpcom0C
         pu1w==
X-Gm-Message-State: AOAM532SnxBXNfb235bFAVf53S+F0t+3txRDdI8Le7l5J8tfIulbvPBw
        5c3FWilWrlTaRZ8+F/iasMi4Zqq/j6yKmQ==
X-Google-Smtp-Source: ABdhPJw7sZpF68arM+5VEhKRue0bkiGJFwU70mTekFKi6upTMaHnsOUVpZJXLt3v3TSJsFRHz4DGHg==
X-Received: by 2002:a05:620a:12da:: with SMTP id e26mr5273998qkl.92.1616509239907;
        Tue, 23 Mar 2021 07:20:39 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j12sm11011690qtn.36.2021.03.23.07.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:20:39 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH v6 9/9] entry: add checkout_entry_ca() taking preloaded conv_attrs
Date:   Tue, 23 Mar 2021 11:19:36 -0300
Message-Id: <aa36bfee87d4a00707090336a9d159d23d7aed11.1616508954.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616508954.git.matheus.bernardino@usp.br>
References: <cover.1616508954.git.matheus.bernardino@usp.br>
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
 entry.c | 11 ++++++-----
 entry.h | 16 ++++++++++++++--
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/entry.c b/entry.c
index 6339d54843..2ce16414a7 100644
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
@@ -530,7 +531,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 	if (nr_checkouts)
 		(*nr_checkouts)++;
 
-	if (S_ISREG(ce->ce_mode)) {
+	if (S_ISREG(ce->ce_mode) && !ca) {
 		convert_attrs(state->istate, &ca_buf, ce->name);
 		ca = &ca_buf;
 	}
diff --git a/entry.h b/entry.h
index ea7290bcd5..b8c0e170dc 100644
--- a/entry.h
+++ b/entry.h
@@ -26,9 +26,21 @@ struct checkout {
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
+int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
+		      const struct checkout *state, char *topath,
+		      int *nr_checkouts);
+static inline int checkout_entry(struct cache_entry *ce,
+				 const struct checkout *state, char *topath,
+				 int *nr_checkouts)
+{
+	return checkout_entry_ca(ce, NULL, state, topath, nr_checkouts);
+}
 
 void enable_delayed_checkout(struct checkout *state);
 int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
-- 
2.30.1

