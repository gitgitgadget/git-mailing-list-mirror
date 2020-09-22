Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A097DC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AD3206A5
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="SAjtBYHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIVWvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIVWvB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:51:01 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3E2C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:01 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 19so17091302qtp.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYT4R9ALwv2Rpt7TK8K0S9uE1PRUq0gDUVR/1tkQK5U=;
        b=SAjtBYHvdWRHACIYnBSV8Rh0loxH49AmHs4/3su42BAil9p3EoPHYcg8V/4jj38isN
         +bMD90h4PR5DG1fu2XPuLqxmjTsGfYNzLzbnNzwGNIc3YUZDQiQwgtx3tL0V0dl0eycj
         UqkvpuAsUh8c0ySGSRO/DaPZkbJWkH8aqCy+ox6JlYyzAeEDl8popDwHPuMwZbR2SBU0
         ybD3e39pY+REPxYe5tk2/OAl5UIWrTXWmpk3TsTHK3ssWb342ARCCszA2lqU0M/2GFQ6
         4RF0+zj1voo/GELR7G9RZOBPh6Brpl4LjGHZ6gs4b/D55IQXdN1GBNiev35fDI42I+Hi
         n+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYT4R9ALwv2Rpt7TK8K0S9uE1PRUq0gDUVR/1tkQK5U=;
        b=AgJI80868aq5wj3hPmurwh3/atl9+SKrDNDlHYUHBZD2PYzjf2ypqNfhMB5RF7KaCf
         ya5cpJ4GcO5U2G/Vtg+8z2MckFPBEt1LTBiK11HQnwaeDJ3Y8PXYhniYTY5pgBKSJR/i
         DnqHnPrrb8FA7ZJFOwnzv8FnOWcTx4MUHGytZE+yCxY/alz4ieadzEPbaPuMdFK3hv6j
         zynCP1/RUC6SFTF2tCm8lfKL3Du6pb2CxjMTtyguOSj6TKZS//W3Ype7J7s6oHYqPxl2
         scRhrP5bmGG4ZhIIElbpuiIkurD9HoiI9O6ehJF/F5jt/hs211ioPltCfFUwFsMXog2y
         g4yQ==
X-Gm-Message-State: AOAM531DbuQ5rEXZN3AEspBTlRg3HI7AdPZqUV60xBu1rFeYTYZdBU6m
        Uj6+wIV6VRL/pBJQpUEpQB38rjc02LKurA==
X-Google-Smtp-Source: ABdhPJw3/JfAhZXhvVa+j4ZmgTKhGkDzSMnb+Ut064xJoHoJ8R04pqJaHB0rZTmlLFPDzn3KNccebg==
X-Received: by 2002:ac8:1a08:: with SMTP id v8mr7256223qtj.353.1600815059853;
        Tue, 22 Sep 2020 15:50:59 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:50:59 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 09/19] entry: add checkout_entry_ca() which takes preloaded conv_attrs
Date:   Tue, 22 Sep 2020 19:49:23 -0300
Message-Id: <4ddb34209e9340f4e709234262a4a9ce81ad9b51.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
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

