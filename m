Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCECC4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E993720782
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="FEN32ODf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbgKDUeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732076AbgKDUeB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:34:01 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6766C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:34:00 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i7so13180750qti.6
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=638udSJyjOOtil7gEWPkk9RlMbg2FCnnrp5f63dL9h4=;
        b=FEN32ODfuhiPAk9FPfPs+maooP92FJ8LWrfeAXnILuaPTBRPxlyC46G1Ea+kHqrTFG
         I/d+Fzu3H/XK2PpnKRXufGCwndTjoRQeaHRTZbgZRaci9QhNYHFz9/Ac9rF45NDPJIGH
         Qs0XqH/y9WPoqyRUmjXsS/6qWqKOWMeoB41kn1h7fe0BnuR5W8luaOefSbeWzB0/lP5z
         hDzByGtTOo6J8Gc+msX6PHiig90WRvtPiyK8l4pjLAEwtBsXe0l0m4VHLVRZUu9Ei3go
         VYGgbs/S6gkV0uBiRoTpO/IN8/6VkFWExl9PMebGpt2wpi67z7WJt/BBZjzwWOOr0zt6
         FfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=638udSJyjOOtil7gEWPkk9RlMbg2FCnnrp5f63dL9h4=;
        b=lqIBrKu+Jv287qmKLCkfHOrju4RnrxxnThFqu+du5dgXeER5GMQUDVeTYHBnLpV/2K
         fqy1YbDGLh2bOP+bOmp0EaZ2DQuj8ZxP5MA8J8zFOLK+PrLJBp7t1kuXm88gSnAFOxzn
         0JAyQ3zfm0EEbDYz3vGv6YEtewQK6GjNs5sWYt7+1ogx4Qe2+ZVJZGvuHyL+Bz0+o4yV
         UkIqnpUeyCtSYsMWL8Gdq+wtDX1P4jZmatKumGih05Emco5/GCERTlz73lfvGDqyVxS4
         pB8dTX5vDbPoWM1eHyyVLGs2vOEgKblTMbWlLpMV03G3RDNrATwLb0fmnsQ5bNbxcYR1
         b4bA==
X-Gm-Message-State: AOAM532Oew0JKE9cnvuAXp/BW5nU2wQOsfyZWClW9ZNvDBp7ePWg4JGG
        +NXoskDTHCfOco9VEq/u9V9V5mdvl1c1Tg==
X-Google-Smtp-Source: ABdhPJx9XbI3zSjSMM0NLCI5j7+GTjm+mlFVLKt1f/1SB72JvO8cjXgh29SeuiQM9x6+zIXXa6DcsA==
X-Received: by 2002:ac8:c08:: with SMTP id k8mr21447106qti.370.1604522039441;
        Wed, 04 Nov 2020 12:33:59 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:33:58 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 08/19] entry: move conv_attrs lookup up to checkout_entry()
Date:   Wed,  4 Nov 2020 17:33:07 -0300
Message-Id: <5c993cc27f67109828390c7856d6c03d4a2cbb32.1604521275.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 entry.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/entry.c b/entry.c
index 1d2df188e5..486712c3a9 100644
--- a/entry.c
+++ b/entry.c
@@ -263,8 +263,9 @@ void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
 	}
 }
 
-static int write_entry(struct cache_entry *ce,
-		       char *path, const struct checkout *state, int to_tempfile)
+/* Note: ca is used (and required) iff the entry refers to a regular file. */
+static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca,
+		       const struct checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
 	struct delayed_checkout *dco = state->delayed_checkout;
@@ -281,8 +282,7 @@ static int write_entry(struct cache_entry *ce,
 	clone_checkout_metadata(&meta, &state->meta, &ce->oid);
 
 	if (ce_mode_s_ifmt == S_IFREG) {
-		struct stream_filter *filter = get_stream_filter(state->istate, ce->name,
-								 &ce->oid);
+		struct stream_filter *filter = get_stream_filter_ca(ca, &ce->oid);
 		if (filter &&
 		    !streaming_write_entry(ce, path, filter,
 					   state, to_tempfile,
@@ -329,14 +329,17 @@ static int write_entry(struct cache_entry *ce,
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
@@ -442,6 +445,7 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
+	struct conv_attrs ca_buf, *ca = NULL;
 
 	if (ce->ce_flags & CE_WT_REMOVE) {
 		if (topath)
@@ -454,8 +458,13 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 		return 0;
 	}
 
-	if (topath)
-		return write_entry(ce, topath, state, 1);
+	if (topath) {
+		if (S_ISREG(ce->ce_mode)) {
+			convert_attrs(state->istate, &ca_buf, ce->name);
+			ca = &ca_buf;
+		}
+		return write_entry(ce, topath, ca, state, 1);
+	}
 
 	strbuf_reset(&path);
 	strbuf_add(&path, state->base_dir, state->base_dir_len);
@@ -517,9 +526,16 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 		return 0;
 
 	create_directories(path.buf, path.len, state);
+
 	if (nr_checkouts)
 		(*nr_checkouts)++;
-	return write_entry(ce, path.buf, state, 0);
+
+	if (S_ISREG(ce->ce_mode)) {
+		convert_attrs(state->istate, &ca_buf, ce->name);
+		ca = &ca_buf;
+	}
+
+	return write_entry(ce, path.buf, NULL, state, 0);
 }
 
 void unlink_entry(const struct cache_entry *ce)
-- 
2.28.0

