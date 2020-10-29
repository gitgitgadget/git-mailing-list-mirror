Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ADBC5517A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9B42076B
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="xy5yM/2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403954AbgJ2CQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgJ2CPf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:15:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0979C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:35 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i7so985763qti.6
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GslneMXDEueXo3ahHKownahgckpV0kWvLsydXiYzxCk=;
        b=xy5yM/2MHMRa7Zx5GQT86Fqibk9xzXiC5JFeSk480Qv5U60ndA77RrZwuGhki1vCg4
         lIwkUCfl5a+AEAiw7u6Yn3lHhDwKDcRGuGkRqCti+gheDp6fl34asUDqa0i3Rp5dsNiR
         LkcbxRXqhzwsoxWc4xMH+RxDiTo0hfy53UmbS9bLFtScE7WwEXlsMs3CkSgRjeA31q9d
         cwRQakSJUXHqDKCvG7MmTntk97lQJYJjwahDDi/qPwy7zNks/xZy7A6x10gLBHQI/Kym
         qkEhuE5tswiE75jssylpQ548mqFUksqyT6ZD/Pir0pHV9XNc5im0XKFxN4BbSZoY7sHJ
         1QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GslneMXDEueXo3ahHKownahgckpV0kWvLsydXiYzxCk=;
        b=cqbCNbdYe6uu90DJpySFshwJECYJOuAYSeO95pxobywcC/zrBmZ6IBp29vKzzq5jCt
         Z52/ZQXQrOsuKaKEPsUYXh2/crPojd/purvZ3O8Gqu1sNGY52G4j9cuXj4Yuj/Vaekf/
         XTwobWQVWF3hrJLgZqTDeVsfZZSlj6IESjnlkZEASx51B4BcgxrVbsccwNoGoZtWgAQ6
         DqMVYLD/5ygtT3w+edUwlAGFpNLGfVVKCDvB1x1LB/gRak+M5CxAWjUKsajkhJj7mwK7
         8jxBF8iPOLQR0oxA8kmhAo0Oc1zp6U+dnbUdsJmlerG1vvzFBa2ite2ErQeEH7KNRAhB
         8cNQ==
X-Gm-Message-State: AOAM531+L17lgCPwh+OC7+ktdhU0bYicQs9UbQQ9KF9efliHqEk193Gs
        0svrXPqPZdSAX+PXhSGOBP8KJjza34R4LA==
X-Google-Smtp-Source: ABdhPJwZ1DJH3CtujZaJcV4wnSNUC4ssf+OgHo96DNxuCDoA8/kPzg5OYeOBZ7MIJ+dTuEFfMG3njA==
X-Received: by 2002:a05:622a:242:: with SMTP id c2mr1811131qtx.230.1603937734472;
        Wed, 28 Oct 2020 19:15:34 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:15:33 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 04/19] convert: add conv_attrs classification
Date:   Wed, 28 Oct 2020 23:14:41 -0300
Message-Id: <18c3f4247e717a7766f13b4b33a0bbe31aee6b69.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
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
[matheus.bernardino: use classification in get_stream_filter_ca()]
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 26 +++++++++++++++++++-------
 convert.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index bd4d3f01cd..c0b45149b5 100644
--- a/convert.c
+++ b/convert.c
@@ -1972,13 +1972,7 @@ struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
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
@@ -2034,3 +2028,21 @@ void clone_checkout_metadata(struct checkout_metadata *dst,
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
index 262c1a1d46..523ba9b140 100644
--- a/convert.h
+++ b/convert.h
@@ -190,4 +190,37 @@ int stream_filter(struct stream_filter *,
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
2.28.0

