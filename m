Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CBDC55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6E520738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="t3tR/rt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbgJ2CRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgJ2CPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:15:31 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D893FC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:30 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h19so994613qtq.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w4RWxOAoNb5b+kMQ3sr8xlU7Nfkn7EHNNqWmSKfTHCw=;
        b=t3tR/rt7wk1eCXgudYUcahM5Z+wdTBPTm8+hliqCvVwac1USNq1zY8Xqs1Mx9DvES3
         NucAqKvqanZDVJ60XJUSO9vvahnfwbAp4jEr73jfEnhUlJGq91d2ZVePJkp8oqL01sfd
         j4xXBrXFi3ID7V7+6Abso50R6H3FNnFJQ1ewiJ5/zSvCUfFSSJvp7mZQxW0u5cKncZMm
         d+27Ad+/It0ksh93Xn25z18nfhutFisaprLbPTfKr/HsoRZUpe5zUkmxNA549X+xl78q
         oNddj2y1aJY/LS133Ph2OP26xaZA9Z/3SPKcZhL7o2TV4v/zl38Kq1ZS2UsHX3zR3h96
         CryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w4RWxOAoNb5b+kMQ3sr8xlU7Nfkn7EHNNqWmSKfTHCw=;
        b=Kvfa0qPCuStRuzxdBmErRzsjBEQyTi3JmS7WzBmdp4OTFP9xx8LY+ABsP78DwCBqKi
         Qlwry3TNeLv2dcVKpD87qlgM7c4rMAI0ujHO2a3nGyn1aYsIDJy8VOYi5JQ/nOgWRlR+
         mqhN6nANsIhoMJThc65p2cVJYjIL2058CE2ifFAnsubCMweVzcHPhoN8ljwnIAJxhwwD
         SE/hJpyG0H5JhWh3Fx3L6kPRgZG7+jHCJdLpkkgdtj0Wc5tOrGWuNbncyhJdkrIp45vh
         81U9WZha1vEdKhsaVc8Stc3LVAtmvG1xnts81ISvXEh1HZLULUJkAN3JjuP+s0Gw4WR7
         GpSw==
X-Gm-Message-State: AOAM5328YgQU4Hq+6mFUCKakC0+bQR7FhZ3/4SaHQwedj6m2NXy+HAxw
        qCKim3ZifWf23iyURnP/gABFJDH+bMY47Q==
X-Google-Smtp-Source: ABdhPJxJYFumPNK3lTTxfDWOvzJpwStTKFs4MmKmFGxzCcBGEEGljQO/eGClhZk6NznQEcpXnZmv+A==
X-Received: by 2002:ac8:3984:: with SMTP id v4mr1808484qte.240.1603937729668;
        Wed, 28 Oct 2020 19:15:29 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:15:28 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 03/19] convert: add get_stream_filter_ca() variant
Date:   Wed, 28 Oct 2020 23:14:40 -0300
Message-Id: <c77b16f694cfe8076e66f604c0bbe053f58a2e9e.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Like the previous patch, we will also need to call get_stream_filter()
with a precomputed `struct conv_attrs`, when we add support for parallel
checkout workers. So add the _ca() variant which takes the conversion
attributes struct as a parameter.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
[matheus.bernardino: move header comment to ca() variant and reword msg]
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 28 +++++++++++++++++-----------
 convert.h |  2 ++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/convert.c b/convert.c
index 191a42a0ae..bd4d3f01cd 100644
--- a/convert.c
+++ b/convert.c
@@ -1960,34 +1960,31 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
 }
 
 /*
- * Return an appropriately constructed filter for the path, or NULL if
+ * Return an appropriately constructed filter for the given ca, or NULL if
  * the contents cannot be filtered without reading the whole thing
  * in-core.
  *
  * Note that you would be crazy to set CRLF, smudge/clean or ident to a
  * large binary blob you would want us not to slurp into the memory!
  */
-struct stream_filter *get_stream_filter(const struct index_state *istate,
-					const char *path,
-					const struct object_id *oid)
+struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
+					   const struct object_id *oid)
 {
-	struct conv_attrs ca;
 	struct stream_filter *filter = NULL;
 
-	convert_attrs(istate, &ca, path);
-	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
+	if (ca->drv && (ca->drv->process || ca->drv->smudge || ca->drv->clean))
 		return NULL;
 
-	if (ca.working_tree_encoding)
+	if (ca->working_tree_encoding)
 		return NULL;
 
-	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
+	if (ca->crlf_action == CRLF_AUTO || ca->crlf_action == CRLF_AUTO_CRLF)
 		return NULL;
 
-	if (ca.ident)
+	if (ca->ident)
 		filter = ident_filter(oid);
 
-	if (output_eol(ca.crlf_action) == EOL_CRLF)
+	if (output_eol(ca->crlf_action) == EOL_CRLF)
 		filter = cascade_filter(filter, lf_to_crlf_filter());
 	else
 		filter = cascade_filter(filter, &null_filter_singleton);
@@ -1995,6 +1992,15 @@ struct stream_filter *get_stream_filter(const struct index_state *istate,
 	return filter;
 }
 
+struct stream_filter *get_stream_filter(const struct index_state *istate,
+					const char *path,
+					const struct object_id *oid)
+{
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+	return get_stream_filter_ca(&ca, oid);
+}
+
 void free_stream_filter(struct stream_filter *filter)
 {
 	filter->vtbl->free(filter);
diff --git a/convert.h b/convert.h
index 46d537d1ae..262c1a1d46 100644
--- a/convert.h
+++ b/convert.h
@@ -169,6 +169,8 @@ struct stream_filter; /* opaque */
 struct stream_filter *get_stream_filter(const struct index_state *istate,
 					const char *path,
 					const struct object_id *);
+struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
+					   const struct object_id *oid);
 void free_stream_filter(struct stream_filter *);
 int is_null_stream_filter(struct stream_filter *);
 
-- 
2.28.0

