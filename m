Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40683C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D3D206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="jUoBcOsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHJVfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJVfB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:01 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D413C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:01 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cs12so5018878qvb.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoEe5TuOwwZlwqBMI+ExawovhMZUiU10LGramkQL/CE=;
        b=jUoBcOsBiarO5hFXkUPcfAyTif4Kxin5w/bHAGnzz2EQGJ0jNCG1OSAgC6BAvueczE
         zleq7TIhafncogGZ3cK9pbSAmayESYhkMLIMfmDf709F7vLKb7MgbHuP2aR1DvDNIuBD
         9SZC15RQrU3JboxAeTfNoIL99KeH4llSuV3YF/Wg55RAjpmb/uo+YhgUFE5r1qX4gUet
         XRbHXAL6KNPCzTAvYTJsZDnPDCHLU2krpzLG1peB/xPQEy+qjXOwalBE6bXn1QEWKGuq
         1pr3OzJ+YmvMImKM8Yrva3vjKJ0w+mZ22AJe6iutXpacbcSfRMKH1hxsNvEEP02dRTUU
         LfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoEe5TuOwwZlwqBMI+ExawovhMZUiU10LGramkQL/CE=;
        b=LrK2PLjVudwfs3kdIWFSl2m60Oa9Nl5t8Wfx/zxBXwX7Wetm4TWTz2TgHUFhnw01sw
         XRqVVNwAxAY9Ybu0PJGXIdk+h8Eqp8nu/Nx5IlC2nvpEbOnbYQlLgLMcPAFYNzzT217O
         fuqH2EjmjcQ4EPMBkGdxqDrRJ2ap1aDrT1nTktr1crADnPBAIOTMKzn10RFB6+0L205Y
         lW95jDgS8GdpESIwIN2XJv7+AIqFbk+qiP0ccFfgaPYysjDbO9rRRM/BcFzul6jOC3Ac
         Jo4g5QiRjXpBSFcvFHmNXNXQnArWYBpNJ9PFyz03PjdFGmPsefxQK6XwLdhOV1HnopGu
         aqaA==
X-Gm-Message-State: AOAM533iyPhvANEgdB/i0qYxCgB8MFeGAOGfOGns9v8v4fZFhN9u6ZE+
        Swh/QvClPstVdnX1TqGDd8hXkU5tX7I=
X-Google-Smtp-Source: ABdhPJwHf7qsysdiHjNlLZOXIozFMydW+MmbWz8Kddb1OXdfqnSwCnS4lhRuBFse3dXjXHr1KaIoOg==
X-Received: by 2002:ad4:470f:: with SMTP id k15mr30389462qvz.216.1597095300156;
        Mon, 10 Aug 2020 14:35:00 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:34:58 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [RFC PATCH 08/21] entry: move conv_attrs lookup up to checkout_entry()
Date:   Mon, 10 Aug 2020 18:33:16 -0300
Message-Id: <934b025526d8ced39e7cb5b7a161bf80bc2ef99a.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a following patch, checkout_entry() will use conv_attrs to decide
whether an entry should be enqueued for parallel checkout or not. But
the attributes lookup only happens lower in this call stack. To avoid
the unnecessary work of loading the attributes twice, let's move it up
to checkout_entry(), and pass the loaded struct down to write_entry().

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/entry.c b/entry.c
index 837629a804..59d5335ff1 100644
--- a/entry.c
+++ b/entry.c
@@ -263,9 +263,9 @@ void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
 	}
 }
 
-
-static int write_entry(struct cache_entry *ce,
-		       char *path, const struct checkout *state, int to_tempfile)
+/* Note: ca is used (and required) iff the entry refers to a regular file. */
+static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca,
+		       const struct checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
 	struct delayed_checkout *dco = state->delayed_checkout;
@@ -282,8 +282,7 @@ static int write_entry(struct cache_entry *ce,
 	clone_checkout_metadata(&meta, &state->meta, &ce->oid);
 
 	if (ce_mode_s_ifmt == S_IFREG) {
-		struct stream_filter *filter = get_stream_filter(state->istate, ce->name,
-								 &ce->oid);
+		struct stream_filter *filter = get_stream_filter_ca(ca, &ce->oid);
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
 					   state, to_tempfile,
@@ -330,14 +329,17 @@ static int write_entry(struct cache_entry *ce,
 		 * Convert from git internal format to working tree format
 		 */
 		if (dco && dco->state != CE_NO_DELAY) {
-			ret = async_convert_to_working_tree(state->istate, ce->name, new_blob,
-							    size, &buf, &meta, dco);
+			ret = async_convert_to_working_tree_ca(ca, ce->name,
+							       new_blob, size,
+							       &buf, &meta, dco);
 			if (ret && string_list_has_string(&dco->paths, ce->name)) {
 				free(new_blob);
 				goto delayed;
 			}
-		} else
-			ret = convert_to_working_tree(state->istate, ce->name, new_blob, size, &buf, &meta);
+		} else {
+			ret = convert_to_working_tree_ca(ca, ce->name, new_blob,
+							 size, &buf, &meta);
+		}
 
 		if (ret) {
 			free(new_blob);
@@ -443,6 +445,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
+	struct conv_attrs ca;
 
 	if (ce->ce_flags & CE_WT_REMOVE) {
 		if (topath)
@@ -455,8 +458,13 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 		return 0;
 	}
 
-	if (topath)
-		return write_entry(ce, topath, state, 1);
+	if (topath) {
+		if (S_ISREG(ce->ce_mode)) {
+			convert_attrs(state->istate, &ca, ce->name);
+			return write_entry(ce, topath, &ca, state, 1);
+		}
+		return write_entry(ce, topath, NULL, state, 1);
+	}
 
 	strbuf_reset(&path);
 	strbuf_add(&path, state->base_dir, state->base_dir_len);
@@ -520,9 +528,16 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 		return 0;
 
 	create_directories(path.buf, path.len, state);
+
 	if (nr_checkouts)
 		(*nr_checkouts)++;
-	return write_entry(ce, path.buf, state, 0);
+
+	if (S_ISREG(ce->ce_mode)) {
+		convert_attrs(state->istate, &ca, ce->name);
+		return write_entry(ce, path.buf, &ca, state, 0);
+	}
+
+	return write_entry(ce, path.buf, NULL, state, 0);
 }
 
 void unlink_entry(const struct cache_entry *ce)
-- 
2.27.0

