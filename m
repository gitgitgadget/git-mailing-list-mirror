Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C44FC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395E6206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="W2TdLRw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgHJVel (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJVek (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:34:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C96C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:39 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x69so9890904qkb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y6NlU9dy0xibxHUIy1uCtPfWuI8nLQDL/odVeJh7JZI=;
        b=W2TdLRw/a3Gj3GFDAYegG8b/cGjnVDhZkWad6JgpO4Uw1GYisYDVjerJrdVPvtAXf0
         MYQMaz0Wqpast7lhhHH/ZBH8PE/600gcpOV/vk772bLpWBfE6cZTzkuqsyRchmqEQtwm
         rp4DEf1jNoS2/o4EdngPVPigctv1jtgN0tGO/jOUkRugGGOKa48RDzraSovOM3c/GDOq
         /3Lp2Wgx24TytaUVCx03Opr+sAh6J16MQwZQZLNLpwb2ioiRUaXdi6chVY0trM9NL/pI
         tJJztz5Bjm5DdZOuzwrCZ6NGyszAuFkCgFz4nkOaW0VLjF17ngv8TtuqcqtYRwgT181z
         L4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y6NlU9dy0xibxHUIy1uCtPfWuI8nLQDL/odVeJh7JZI=;
        b=L+zWoISw9WYIqCtzt2ql1x8r7yLIXRvWJlbRVV7zTBMJwdNkDFwOnyalyCNRljFefn
         5j0In2Jpp8VHxeJtE1VK26zmOdP0gRnlXGy/zwY+IzCwRn069df6NdpBWnTRwOr3XzYN
         OTuel+zyLJEc6Iif1VyYD/nw0NqPdn80FSPBrLmbhlBJYk1YPi2CT9PnZHMAqy69Otso
         YqBQ3mqhmRSP/eMrG37MqE3409SGg+WtZ0n61YAWZU22w++DKKUx69KJe2jyhYCu9nm3
         narvK2eVK6A4bfVAmqhwO8hGQfx7yAyldHo2x8oB7vcgfzmsOIoG97X2jZ+zz2W6rB36
         bafQ==
X-Gm-Message-State: AOAM532uq74wWLyPdt8gsF7/DuEmvNxDFVmcODgN8ECqXXiNgM3D9cGh
        rl0PjnwaFdVrL8BHqvzf7D205dP3b60=
X-Google-Smtp-Source: ABdhPJxc2KMOHuUsC1kBVWWtQIFW8+RPIov1A5N8LBr4fLoJBVqRSwp/K1Zerv7et1tCDz3XfRmmXQ==
X-Received: by 2002:a37:a543:: with SMTP id o64mr28464894qke.177.1597095278054;
        Mon, 10 Aug 2020 14:34:38 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:34:37 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [RFC PATCH 03/21] convert: add get_stream_filter_ca() variant
Date:   Mon, 10 Aug 2020 18:33:11 -0300
Message-Id: <437d31f3b1d6c333b95096c999b9549cab25768e.1597093021.git.matheus.bernardino@usp.br>
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

Like the previous patch, we will also need to call get_stream_filter()
with a precomputed `struct conv_attrs`, when we add support for parallel
checkout workers. So add the _ca() variant which takes the conversion
attributes struct as a parameter.

[matheus.bernardino: move header comment to ca() variant and reword msg]
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 convert.c | 28 +++++++++++++++++-----------
 convert.h |  2 ++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/convert.c b/convert.c
index 757dc2585c..8e995b39c3 100644
--- a/convert.c
+++ b/convert.c
@@ -1963,34 +1963,31 @@ static struct stream_filter *ident_filter(const struct object_id *oid)
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
@@ -1998,6 +1995,15 @@ struct stream_filter *get_stream_filter(const struct index_state *istate,
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
2.27.0

