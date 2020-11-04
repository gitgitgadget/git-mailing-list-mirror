Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF24C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909CD2087C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ZYovrZlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgKDUdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDUdo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:33:44 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6EAC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:33:44 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 12so16729204qkl.8
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Yao6dUTYAjE7sP3LtMPcu67hp/nCkbqffV5EhyP3fY=;
        b=ZYovrZlPNLoWHnDSDHY24UwvyxLa6nxh4Gj8xjOW74FaME1ES/jWIKvwp5veTBQ87g
         thsUKROiuYLzoEUKaeNFLoEqwDIMGlfvdGLUVY2rFJIjW80SjfU6x/OGPp0FsbewBOIZ
         QOm08rN1DvofjQK/UdXSKbx1FrjHHux/3t/rBCJa2BW5TBa9ymnKSI3UKyRg7lozlZHV
         kA8iuapjpRbnElwnrFNgyS2gVfETPxAiuoyKFl6Gp2TKGje/Y5+f93iYqAlspQ0yVKvp
         6MSRQji3TZEfDqIfusMm9QBLQADPYfida4F6ShreV3Jvqsin2ixKdieqO6Va+vvYzgl6
         e+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Yao6dUTYAjE7sP3LtMPcu67hp/nCkbqffV5EhyP3fY=;
        b=ViagZlyZ8K9sSvMezRd/QOTGT3A+cx7/oBqrUY1hrMT4NkTl4BVqcpyOMYg7LAfCx3
         ZNuG1ktzmKQSaXfmofeb2rMRIOZisOL9ppxkMJvJsYg0PrXshFMXUnRo1Ad/aN2kpI+U
         EpbAF+EI5og3pj10SNH4qek6JSLZs+x5cOuGv/cbI210OPCl/yDzK2SdYm190/QJxvPr
         8Dpt+XkctYNleZpGCCOYLTGHnu42NRAGmCQMCVfKjSCXpLrX8ErE/5qz5v46efMNKJHH
         dkshOVIKo5FIQrPKU62/uHA+rrwCTYaMmPHMkQWtPiPEJUVBepo6BZFr05gC7qmghI5K
         w/vw==
X-Gm-Message-State: AOAM531lipQRKG/5ZQYhnb2rOHQFLbTvu2n/PTweLDqpouw1L5b7h5RU
        QmuxhDfm1tJx0fyOJyKv6E8p7kxFxG5+Ww==
X-Google-Smtp-Source: ABdhPJz04jeCc7s+ibKtet2Sw44fX/SjTdqnFbdEL3y5U+qWM/U3MI1t3q6qpa09d7vOKH0TAoomIQ==
X-Received: by 2002:a37:a54d:: with SMTP id o74mr6566244qke.296.1604522023072;
        Wed, 04 Nov 2020 12:33:43 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:33:42 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 03/19] convert: add get_stream_filter_ca() variant
Date:   Wed,  4 Nov 2020 17:33:02 -0300
Message-Id: <8ce20f1031172bd6821392a562a3ecac65c6bc84.1604521275.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
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
index ab3d517233..0a61e4e9bf 100644
--- a/convert.c
+++ b/convert.c
@@ -1939,34 +1939,31 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
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
@@ -1974,6 +1971,15 @@ struct stream_filter *get_stream_filter(const struct index_state *istate,
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
index a4838b5e5c..484b50965d 100644
--- a/convert.h
+++ b/convert.h
@@ -179,6 +179,8 @@ struct stream_filter; /* opaque */
 struct stream_filter *get_stream_filter(const struct index_state *istate,
 					const char *path,
 					const struct object_id *);
+struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
+					   const struct object_id *oid);
 void free_stream_filter(struct stream_filter *);
 int is_null_stream_filter(struct stream_filter *);
 
-- 
2.28.0

