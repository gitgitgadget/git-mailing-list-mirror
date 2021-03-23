Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A484FC433E5
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745FF619C8
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhCWOVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhCWOUj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 10:20:39 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA9BC061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:38 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id g8so10532292qvx.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5AYz7ut44wcIEufw6pWX/rHGikuU1vsfANE/W4QSw+k=;
        b=cTEnza6PQo4zFUfvVbebVe6JEG8Yv8emIsp+T7F6/OdBBTEHnS37QQ8sW458P4R6k0
         JGtCrzOgIl6onxtr1zSpiIM/qF1g2fy+9cW2DMzJP/X5nEGqfX2rbNwWIDZ7XyBxd5ZQ
         lzKS7RsVy7GdsgmJ0g9Ae3uTDXJDAVqYcXjIA/yYAPq7KeyXPWe1Zg54r2vAtF3FLSvp
         R1PU4ChM/i5o9h0WbFg9z1AbzCsXYNah6k/o1gb47l8znJWwaLl0Y2ejF91LRfkbEARN
         W9ScVuHaA5/U67p5YBVKheLf8JulcnaDfp9K0LoJYxy7DpD5LaTn7K2erX03HOwROaww
         ZTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5AYz7ut44wcIEufw6pWX/rHGikuU1vsfANE/W4QSw+k=;
        b=Qe8g53G0Uv/qrh1tipWmlblBcBDDluiH1UXskipz5CoS4R9vKtBPhw0hDKBEAZ3cHs
         vCVFei9eqw8js+ZzNtUG0tVl+kkxnEJwRU1RpGU4rALEZg5PbTBW+tr0lCxOzPrfj4ns
         Dm3i6mt6U9C01dugdf4zJ4qgkpebtGaB8M0JMoOpINNsGMogVIDvpQbkoDGA6DdD1x9Q
         K3w3OMJ0ygIOE3TPqaYobHECVBfI8JAq5hNGQKD3zuUPCz1vD52ibwHmg2JsKqDtLMRM
         Exc4jS+8zMkabwjG6vvjF0Kl24+Avoa30If5jSYgVD+iqPRzBBQy6OvDrMPi5H5HBoha
         JFZw==
X-Gm-Message-State: AOAM5335VTNuxAnv8DbsXOPohGwTosNNhIsAbhrs5A9Da5f6+ogUoeaw
        FME0Z8Yf7npcFYWHHq9IvMJi1w==
X-Google-Smtp-Source: ABdhPJyx4yNaq58aOGdj2IVlqRk8oZ38T/X6b6njRM+/O5NWnZnD1hEYgMlDjhfxaQqCDNRi9NZIVg==
X-Received: by 2002:a0c:c248:: with SMTP id w8mr5380782qvh.58.1616509238143;
        Tue, 23 Mar 2021 07:20:38 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j12sm11011690qtn.36.2021.03.23.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:20:37 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH v6 8/9] entry: move conv_attrs lookup up to checkout_entry()
Date:   Tue, 23 Mar 2021 11:19:35 -0300
Message-Id: <87b9d4590aa182d4c4467ea9ee3a87bb53940a66.1616508954.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616508954.git.matheus.bernardino@usp.br>
References: <cover.1616508954.git.matheus.bernardino@usp.br>
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
index 4cf0db352f..6339d54843 100644
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
2.30.1

