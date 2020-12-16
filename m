Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DA0C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC769233EA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgLPOwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPOwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:52:09 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56FAC06138C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:09 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id z11so22693042qkj.7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jz1gM71LgA3esTPS5DvOT8QP5Ge1GbLezYefsnKHCCo=;
        b=ZqJ1nDzcxmHCuWPSFCCUKvOEK0hvN+54rlkQNV9Zx1r/jVKeSCglH7NewTR5fcy029
         mfQ1O4pwSZr38hDx5FNgtaO5XhO5VkBNKlZwYIYdQs18U1NzWVSbwD9d8o2qvjr9CMQ8
         Qw4qZcU7QzWVecz5L2f+aIM0V/xm9igv7N2Z3l++tXexpSjHGr8io8l46v/VWvtINrNa
         PwsMCNcw1jHajyuqgbM3sSaPxUvA6ZkIJSymtYNAuATYJ3/2XWlUyegvh9znUwL9Nbgp
         oiUG7jLOWib/Uv82GjKgC2SCkXBD7ClioeQzVrmnMTcj0SN8vI3MWZXJPRjwjJmfje9E
         Iafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jz1gM71LgA3esTPS5DvOT8QP5Ge1GbLezYefsnKHCCo=;
        b=soJtSE2YQZUKdJCogCNtzg/JHgpAV53pO8xRtCtoKNQSMzwc/iW1A024gGHsaRCo2z
         kvRuezOi/xrh22w72nX0fSRgxXlb2IVNnS6Znksip7hlahjyWikQvhbF1mCB0IH0c2rB
         LyP1oQyb/97QUPCSPZAzyXe65+YyJQsd4vAQZpQ1kFNNOoDF8Gehbz9HoFMGNOgmKMzB
         eLamccY6YLx8f66QRycFQNbIe1c3iiXsdi9yZgZOZGF86ovrFmlHnHuKHYyDTXqmDTO1
         hsNIBSpopqz6aok9bpIWQXYa676CcdtZz6H8g8gqT8pLyId6Np577X5w3ebIiffROoC+
         jUcw==
X-Gm-Message-State: AOAM532Bd2j/9Ssa0s6a5G20qqzSm0cmuPDneZ5CZySAuaiqtzfEQSMz
        hTOUihX0UijKJDaPayVw5zLaDR3q1mWMLQ==
X-Google-Smtp-Source: ABdhPJwtjOE9816RjI9vaKqi0gSDeOp1638dLFyBs7aBUVuGEcNrqhsmuaI+Zy/K273rcfoWUKZGug==
X-Received: by 2002:a37:9001:: with SMTP id s1mr39544683qkd.193.1608130268754;
        Wed, 16 Dec 2020 06:51:08 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j142sm1211420qke.117.2020.12.16.06.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:51:08 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, chriscool@tuxfamily.org, peff@peff.net,
        newren@gmail.com, jrnieder@gmail.com, martin.agren@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 4/9] convert: add classification for conv_attrs struct
Date:   Wed, 16 Dec 2020 11:50:33 -0300
Message-Id: <f829e2e08f4becd7c4341e26aab16b69ab71c38b.1608128666.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608128666.git.matheus.bernardino@usp.br>
References: <cover.1608128666.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create `enum conv_attrs_classification` to express the different ways
that attributes are handled for a blob during checkout.

This will be used in a later commit when deciding whether to add a file
to the parallel or delayed queue during checkout. For now, we can also
use it in get_stream_filter_ca() to simplify the function (as the
classifying logic is the same).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 26 +++++++++++++++++++-------
 convert.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index 9af6aafc5a..b9d25d9a47 100644
--- a/convert.c
+++ b/convert.c
@@ -1954,13 +1954,7 @@ struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
 {
 	struct stream_filter *filter = NULL;
 
-	if (ca->drv && (ca->drv->process || ca->drv->smudge || ca->drv->clean))
-		return NULL;
-
-	if (ca->working_tree_encoding)
-		return NULL;
-
-	if (ca->crlf_action == CRLF_AUTO || ca->crlf_action == CRLF_AUTO_CRLF)
+	if (classify_conv_attrs(ca) != CA_CLASS_STREAMABLE)
 		return NULL;
 
 	if (ca->ident)
@@ -2016,3 +2010,21 @@ void clone_checkout_metadata(struct checkout_metadata *dst,
 	if (blob)
 		oidcpy(&dst->blob, blob);
 }
+
+enum conv_attrs_classification classify_conv_attrs(const struct conv_attrs *ca)
+{
+	if (ca->drv) {
+		if (ca->drv->process)
+			return CA_CLASS_INCORE_PROCESS;
+		if (ca->drv->smudge || ca->drv->clean)
+			return CA_CLASS_INCORE_FILTER;
+	}
+
+	if (ca->working_tree_encoding)
+		return CA_CLASS_INCORE;
+
+	if (ca->crlf_action == CRLF_AUTO || ca->crlf_action == CRLF_AUTO_CRLF)
+		return CA_CLASS_INCORE;
+
+	return CA_CLASS_STREAMABLE;
+}
diff --git a/convert.h b/convert.h
index 484b50965d..43e567a59b 100644
--- a/convert.h
+++ b/convert.h
@@ -200,4 +200,37 @@ int stream_filter(struct stream_filter *,
 		  const char *input, size_t *isize_p,
 		  char *output, size_t *osize_p);
 
+enum conv_attrs_classification {
+	/*
+	 * The blob must be loaded into a buffer before it can be
+	 * smudged. All smudging is done in-proc.
+	 */
+	CA_CLASS_INCORE,
+
+	/*
+	 * The blob must be loaded into a buffer, but uses a
+	 * single-file driver filter, such as rot13.
+	 */
+	CA_CLASS_INCORE_FILTER,
+
+	/*
+	 * The blob must be loaded into a buffer, but uses a
+	 * long-running driver process, such as LFS. This might or
+	 * might not use delayed operations. (The important thing is
+	 * that there is a single subordinate long-running process
+	 * handling all associated blobs and in case of delayed
+	 * operations, may hold per-blob state.)
+	 */
+	CA_CLASS_INCORE_PROCESS,
+
+	/*
+	 * The blob can be streamed and smudged without needing to
+	 * completely read it into a buffer.
+	 */
+	CA_CLASS_STREAMABLE,
+};
+
+enum conv_attrs_classification classify_conv_attrs(
+	const struct conv_attrs *ca);
+
 #endif /* CONVERT_H */
-- 
2.29.2

