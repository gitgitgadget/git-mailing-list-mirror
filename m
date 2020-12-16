Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2C4C2BBCD
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2BF233CF
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgLPOwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgLPOwU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:52:20 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B67C061257
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:27 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z3so17312286qtw.9
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9aFe1FIjV2nEk+qK1MY1nd3faF3m4ENjbzT4ASabjiQ=;
        b=cNUYD83zZwaffOdqzX2bDMkbHtLzXgy91jjIwcfSJTfuHuR6e5hvq55vcGkEFssUwR
         09XNdlYDDdg2QrVgdDNUvWGvTbJI8DFlQ+oRQV8kPFjk8Foqy6p+pUQATB7/sUQKevYQ
         Gcj8PNIwR+4QIU7ndPSKbGyBtO23WTKqYZy+vmx5Oy0nXZR+EDW4XoN86837m2CmnrsW
         jYn0M02uf0KCnGJ054KrKwHCLGqaGQp/wF5C+beQtQD6ouEhyFDKhvp320kXGl3RzamS
         sbeaPgO/9sP3WSfKAypJSinYiVX1VkKg5p7SiIduMfqe35EA49Mo3XOYDPRh79d5fAYq
         2mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aFe1FIjV2nEk+qK1MY1nd3faF3m4ENjbzT4ASabjiQ=;
        b=pYGKDHnZ1QWUhv9w2toY8+XSCVK58Vf1+tEmLMdEnJAgAgZRgwY/koxUGkQsRkKK5j
         r5a9ebpmEgVOAc7z8QKpOn3AuDGm2p1flN59I1bTZwjnuBocw0dSCSlgxDqfiIEob4Wt
         U84cpEhdSOJl7pd94v2X4DISloq+9Xz4kZWiFkZ7IR4ADDIJhBkQ2Ms5JOX3Vm8ssMfV
         FIXMW6d0umbk6TcsX3fK11dBAIhQXrvPioKHQNYDJ5X0Y21xMTwOhk6MkAzBEROt9fFL
         Rjs8XRBxz8kpkwBllRuvEEqN6D/MSDMF/vA2l+RrnNWhyVUSoIuKr2PYp1JJmF3lpC/V
         mGoQ==
X-Gm-Message-State: AOAM533qQL7ANa7UL0/O7zkbobH+6pVjcZFokYI/OLfZvvEwQCNG1Mfg
        0ogjwGl+g8k1T0o0w5VoM/m+8+Ttnb5OGA==
X-Google-Smtp-Source: ABdhPJzzPJFx4I4yK4FB8LPElyZOzhnrtXUkium5iHwF5+jTrcH07vGvaz4oq4OTgV0C7PejnSHdCg==
X-Received: by 2002:a05:622a:34d:: with SMTP id r13mr44433957qtw.93.1608130286074;
        Wed, 16 Dec 2020 06:51:26 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j142sm1211420qke.117.2020.12.16.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:51:25 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com
Subject: [PATCH v5 9/9] entry: add checkout_entry_ca() taking preloaded conv_attrs
Date:   Wed, 16 Dec 2020 11:50:38 -0300
Message-Id: <0556d32e8c9b3119fd343f719db4be41617d5365.1608128666.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608128666.git.matheus.bernardino@usp.br>
References: <cover.1608128666.git.matheus.bernardino@usp.br>
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
index 62ddd348bc..9d79a5671f 100644
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
2.29.2

