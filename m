Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9346DC55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C13420738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ZYIYTc/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391084AbgJ2CQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbgJ2CPx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:15:53 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C788BC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:51 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id m14so949263qtc.12
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0o9M053aS4Fpu58NIsI3IZY8vBtu9bdnRbtLyCPxzA=;
        b=ZYIYTc/6hKIMKMxm7fGfGzl9ZIz3tP6+rQ3AxbabEqSAQX4qWcyEkLilul58xrUq0R
         IIHm5a/NPD9GoEJh0nGY5d53kRkDHz0FkfSh+r5bvnXMTWehGGN10IjEG/Sr2y2hdu3o
         WTJmxPhaE6ObXTN2aEZBeRNU9rCBxxxfUD0nCMNBlFjjxIhP3JbALtmc6jLiaY0zvcGP
         eS6IKiJrcv6zk+1bWwFo8Z7E/D5rdtu5/sI8UvnEtdy9BbtDwJqyyiiRZM7I0aBnaZQs
         6Kn432WmDia7bqJtj1Uk55FECVx8BYipZTwYjEVt7aWlQ3YrR3sCy29XELwwL9+Zi5Th
         FxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0o9M053aS4Fpu58NIsI3IZY8vBtu9bdnRbtLyCPxzA=;
        b=C3xKzM5JhyZzjWoKRj5n0GsJjr0wdUhrhQnF3rDyWTYcs8wCTc+UCeBfPx11HoeSS8
         p73e/BXcdwaU8plvpNqdT6Uck/UbWZyavMj2usC/gsgSi9CQZZy2YePZgeVb1RmESJ2o
         9DK3ERu5CaxjgYMgnHABgvOwEyhTF6zVLFY7UXYaohgAHel8ZHB8o9upAPyNncf/0uHw
         N1Phmbb+oaPXHly9zUvAcgSgZxMW0JRGzGaQK88ii2VAWzK0xUbGI+Duvgu4qrS2mgdD
         cDScqV7xfYSo0T3owY9xtP5YivUUY4v+On4T24xldmTwyCwoWDiWkvZdF4hFF3hsg3Mg
         fdKA==
X-Gm-Message-State: AOAM533stPQhh7lNPo81Q5pCXg1WTNp7Ar4PjANTIA3tLR6SHyLDDfq9
        +C5lI55+3MHCkKJ0TAbhFuUYlq0eJ8t4Cg==
X-Google-Smtp-Source: ABdhPJyFDzKgqHt9AYgKrs9MOo+UcK/zgx+pdXWcTdSzGNxXa/YZyakXDPWv/E9dgi6BFI83rMASJw==
X-Received: by 2002:ac8:7207:: with SMTP id a7mr1824575qtp.40.1603937750613;
        Wed, 28 Oct 2020 19:15:50 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:15:49 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 08/19] entry: move conv_attrs lookup up to checkout_entry()
Date:   Wed, 28 Oct 2020 23:14:45 -0300
Message-Id: <81e03baab1dd7e28262e1d721eac1646c5908b5a.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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
index 1d2df188e5..8237859b12 100644
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
+	struct conv_attrs ca;
 
 	if (ce->ce_flags & CE_WT_REMOVE) {
 		if (topath)
@@ -454,8 +458,13 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
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
@@ -517,9 +526,16 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
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
2.28.0

