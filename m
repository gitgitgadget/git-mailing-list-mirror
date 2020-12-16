Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2641C2BBD4
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA051233EA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgLPOwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgLPOwU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:52:20 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68619C0611C5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:29 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id n142so22683470qkn.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hEKUfc3w4QeW5paoWwRFndRjlbczEzltyDXwQNYz5VM=;
        b=PWfxd8MWJxyD2g7VeLskH+mjZHOvvd/NceXdblE0l62R09Q+RQEtBIcp9ylWQZUEwi
         m2iDe5EzuN8gegLcDae/K8A5yVJMo4PNd0T0A2UF9MNd5Y2sGDdzCMvA8DHbRbVkeFYv
         JhGh4EhgX5pC2/uvYirPqqPCM2/zErb2XWiBYm3K7sHtsf45OJMF9ppbdS+aDO+ayjeC
         sQRFxx4+s9H1Wc+27DlFCgQ5kpng/QILvPEr9XdlWRe/D3C/EJGRrcuxXD8zWYBz2ijA
         Ukw3u2FDvRAiDvLZ8/tAE1aC+FHeQ5Ai1/qbDpy2TPW3UijYQ3R8xmUdjQODoxr9388l
         HyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEKUfc3w4QeW5paoWwRFndRjlbczEzltyDXwQNYz5VM=;
        b=WYXOaG70wUAXKjM1Xm7ysFqlWPRFMsmtWAzMf/tgv6tSwtMaPE3XORjRJpUYWjFOhB
         QAu1ceVQy9JAECtAm6Z3CPmev1Ve0okvN4v+/Z9z+iyYaDieQ2ve1G24scadfoBtvaOE
         J5siKciWVgKFD5IQXW9PNeu3diJhF5AD+oThmd44Zo69GHBBvpN03zUtRSX+uvlTH+Vl
         +vA5iMiB/uFAiyzkUd3R+RGB+zR2f9FlzcLacknaZ72EqtomKCp8xWpXRqADCnctgSGt
         LmEM3Q/FKAnHAaNSHURbYLYS0c78fspYtPd8NMD0LdlpJu4qWWngACIGWZtaOD/7Um14
         ieoQ==
X-Gm-Message-State: AOAM530lNxOtHP6Wf7BxHjCqMoylxwPIQsu6LVozffPdM1dNhiDyjw4H
        ZLRoxaTRO2w29NKSWvvLtFG1Co3N15vjQA==
X-Google-Smtp-Source: ABdhPJzkIjUKVJgjoqO6ztajZbN26TUbPjwCGfneBiyjQt0vyrg2f7xcrJlaPBCQ2AZoSmzo5gFumQ==
X-Received: by 2002:a37:9c8:: with SMTP id 191mr42655558qkj.434.1608130281870;
        Wed, 16 Dec 2020 06:51:21 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j142sm1211420qke.117.2020.12.16.06.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:51:21 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com
Subject: [PATCH v5 8/9] entry: move conv_attrs lookup up to checkout_entry()
Date:   Wed, 16 Dec 2020 11:50:37 -0300
Message-Id: <fbde9015185c1a0ed3e74ebd9eb00bd4f99ba89e.1608128666.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608128666.git.matheus.bernardino@usp.br>
References: <cover.1608128666.git.matheus.bernardino@usp.br>
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
index 1d2df188e5..62ddd348bc 100644
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
+	return write_entry(ce, path.buf, ca, state, 0);
 }
 
 void unlink_entry(const struct cache_entry *ce)
-- 
2.29.2

