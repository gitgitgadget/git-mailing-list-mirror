Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C2FC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD9920759
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="E/7aN3dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbgKDUds (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731948AbgKDUds (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:33:48 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0421AC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:33:48 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id s14so20597047qkg.11
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DeYL+kXVaDpDQMHQVzZD6jBE4bkYICG9z0NyefgB38A=;
        b=E/7aN3dk4rBk3WKwTIjF9cQteVlpNnI2wJ/mFLkp+bF79d5PL0WE3Nohm8u668oQY8
         nbrVdBiq3KM9lA45m6ZdoDmGe7MpMPs7LJ6Y7pOxm5W+dDXJ4LMYqNNZ7gfdiFk0bhPy
         jlqvCEde3Zov9fC0hRd3m6k0b6TxKSMpu63GN/nu2JEuMYF7r+K1JGrSCWIaoC5n21Xc
         DQUGZ3o5Sxep0jhxpRDsz7C6GVwUPn4mO2MpP7YZexKq2PDr/CauO78o5xgXPDNVwKoQ
         q5R/rF5QkiugtedB0/nr4vvJuNOeazVzZ8e93p+JP4FAN2ruFN856vEa41CLqbwyLIl/
         j15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DeYL+kXVaDpDQMHQVzZD6jBE4bkYICG9z0NyefgB38A=;
        b=IRyvqA6K4+lUWSA2QoFNZmWHHWKdrWvjF2EvHXUOL26wbPz5YNWB82zBJNSssp91Kg
         VcsdlYteWt0q+fU79rm8yhc5Zhir3d1esnJ0gp3unHk771LOeftCNyzQqIGccfO6e70W
         sMxsPHfoaZSstf8cI03LlPu+hT0LzuINV/YGzhbBqbT//4yjhQERkBb1VrPSxMZWwz45
         xO16BYv6ewdbaDhke/o1iCvqlUIWPrOizbks3O//ZpNpnPeETjMmreYjrLqCsJZ3RsiX
         NWgyKMdQ13WznSrn0+uhsTuWtJyOGzHZFiZTV18p1fVxyepkJsrU5loPKZgNs/N0ZwXr
         MZ+A==
X-Gm-Message-State: AOAM532IfdcVOgAtnmzY54EjuG+tBouOU2qd8Ak7e3UTyXxUQkTMwQ5/
        bMAA7ZnNSVCcimWUt0oFm9jj/yKCJbD59g==
X-Google-Smtp-Source: ABdhPJw3Eu0riFel6QVKcfmG4+sPDYR54exjPilaZ1Yk3s9MNm8ou+P0lje1qDcwS7VUM3YviuCi0g==
X-Received: by 2002:a05:620a:131c:: with SMTP id o28mr18661781qkj.388.1604522026743;
        Wed, 04 Nov 2020 12:33:46 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:33:45 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 04/19] convert: add conv_attrs classification
Date:   Wed,  4 Nov 2020 17:33:03 -0300
Message-Id: <aa1eb461f46d200f36b33c07ebc0a350829ab1f5.1604521275.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
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
index 0a61e4e9bf..3b2d626268 100644
--- a/convert.c
+++ b/convert.c
@@ -1951,13 +1951,7 @@ struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
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
@@ -2013,3 +2007,21 @@ void clone_checkout_metadata(struct checkout_metadata *dst,
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
2.28.0

