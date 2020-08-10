Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676DFC433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0A2206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="CXwFQkwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgHJVeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJVeo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:34:44 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE364C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b79so9842706qkg.9
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSiTjWdNdCa0maLmKAqlM43JmQ5CAGoVsFPbN+iWh0U=;
        b=CXwFQkwL9Su5l0CT5f+KF0HA4/sYEqQxRpIV0U8H5rJxHk6paoJs3/hh3ST00qWc/B
         SrtGjuTTgRP82A8UZZOySwRVb3zUPUuzZnox/YQ35/eezVJ5sIIqqgemeA90SfpHODPa
         osP3aCef3WOQhColXZ0WNiSfqNzsl4KqB9XbtpWXRGBFnlBpFvpWozmI+B8R1Wvv0DuT
         GyKn4YGbu3lUnYSOlS18evlQY+Z7apUcQoUX3r5x08oSOLuJTVcG3Y572p49IFN16WMF
         CyDoitrOtujKSywCzaRQxbyqdUXLBjGtK7YaXiQhErhKLi+r1xDpaP4hk12fTeiRkp+2
         uCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSiTjWdNdCa0maLmKAqlM43JmQ5CAGoVsFPbN+iWh0U=;
        b=aRbJBejDwuXkDAIf2XomOrWOHJr9D9tuvFkk+wrAoWMkeg61FGkh7hr6yhSF94I1Xi
         W+WJIqxIDqS/zL37IRxsH7dR9Cs6Xxb9xT/kthAzId4WSg0xi96rskXEw2i6Ag5wVuBf
         UqdUa1XHQSRDMUxf9E7c6JP662xUkYpcggF/QjlnZ64Jt+PTBZjBa5p0NXlQiim95KDo
         v5phgb6z8YxLmRBfjAfz86Yt5DQiMMOXAqeVD8q7ORIUHMNIkmqAuOx84BctLv/Ld468
         K+rM9uM0yK+pHJIuQAGHem+tWfGSOgmE3MVS2Kfg1CUBmE9FNMSdKm07xSJrExT5DUEk
         Vcgg==
X-Gm-Message-State: AOAM5330J5CXwl+iPmac10cvlx25brMxXLc8Uy8SWXeTaqQMh99WTTEI
        VCzY/ferfXOilk00+upAa0+iItXvI0w=
X-Google-Smtp-Source: ABdhPJzK3UnFiXZ1gRCCUuw9PKFHajTLkiNECEsP/SB6YiyQbJp4NtzBe+tTZMbNlErVocH8gvF/ZA==
X-Received: by 2002:a37:4f07:: with SMTP id d7mr30030923qkb.144.1597095281930;
        Mon, 10 Aug 2020 14:34:41 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:34:41 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 04/21] convert: add conv_attrs classification
Date:   Mon, 10 Aug 2020 18:33:12 -0300
Message-Id: <a4a4456d7c464b3a6f6eb8fad8c5f9bcdf295709.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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

[matheus.bernardino: use classification in get_stream_filter_ca()]
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 26 +++++++++++++++++++-------
 convert.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index 8e995b39c3..c037bb99eb 100644
--- a/convert.c
+++ b/convert.c
@@ -1975,13 +1975,7 @@ struct stream_filter *get_stream_filter_ca(const struct conv_attrs *ca,
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
@@ -2037,3 +2031,21 @@ void clone_checkout_metadata(struct checkout_metadata *dst,
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
2.27.0

