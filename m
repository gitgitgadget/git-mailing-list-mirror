Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2C7207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944883AbdDTL1r (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:27:47 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34484 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031820AbdDTL1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:27:36 -0400
Received: by mail-io0-f196.google.com with SMTP id h41so15347436ioi.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+W03EP6xPvkJwteQJktMjTUtBILk+1q83AQzD3ZzdV8=;
        b=HJJ6SV3HfhOBDPjeWMle92L8IcAzUHPo62lQkkDc4BCUpMxs0xRM5YRgUCg+PRodfs
         7maGsE3qFqPG3bfLcvYHXiJrx9ZPNDhe0liviAUBUskFuV/LeCr0f1VW1MumOXijNIw4
         YgBcWLnylkJTDQRJ6dQJ7KEhogv8fe1CGac0R4qXeMkQAzGfGuAPsqY87+MgPP5Li4KM
         juWiPrMBBfinFbqo3RsUv6whMn+f6SERhsX3OuMc66LRTYL9SNCENk8PQWh+3nm6XwyZ
         DwIG0S/uBIyCPxIHpgkKIR7dhE2UVQTY8S+RcsF0dSHcSozRZfh79colJ4UKetZSqny5
         xo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+W03EP6xPvkJwteQJktMjTUtBILk+1q83AQzD3ZzdV8=;
        b=GFZ27/Egojbv0ZY05RiV0Fc9IwsbZvNmbP9zkPsMpqTosjzkCqdpH4CHPMkYaCfkzK
         j6Y6Mi0S/wB7t/kL5h+G2XvO4/qs5p8+I+IeHujn3FMiFnkP4fqvbB4MmO1nMLXEU/V6
         0856xH2YJUoNFz4Zes3mDlLKfnuHVJkMfRKgotA46YdBY5v/5I8lQitYa4VqkQGRbNc0
         sZHiduID50xQSl648C5J0MWHsioaB7doJ4pn8PbQxDAPmRpJN2cDh9yRB/LURvVdN8Wv
         I7AM7l4t3Vb4q41zs+g5culP0IuPM1WYTXo8LW2o8Nxot4peAKAF9GRTImyRYguWkYhP
         j1ww==
X-Gm-Message-State: AN3rC/7/vUERIbrDXWIoQxN0Y86jx5mgcGmGT+N9JJmOKauxF74U69Ke
        +rqPWOWpEqSgiz23
X-Received: by 10.98.74.85 with SMTP id x82mr7485767pfa.115.1492687649985;
        Thu, 20 Apr 2017 04:27:29 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id f62sm10050821pfb.84.2017.04.20.04.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:27:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:27:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/15] xdiff-interface.c: report errno on failure to stat() or fopen()
Date:   Thu, 20 Apr 2017 18:26:07 +0700
Message-Id: <20170420112609.26089-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420112609.26089-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 xdiff-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 060038c2d6..d3f78ca2a7 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -164,9 +164,9 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	size_t sz;
 
 	if (stat(filename, &st))
-		return error("Could not stat %s", filename);
+		return error_errno("Could not stat %s", filename);
 	if ((f = fopen(filename, "rb")) == NULL)
-		return error("Could not open %s", filename);
+		return error_errno("Could not open %s", filename);
 	sz = xsize_t(st.st_size);
 	ptr->ptr = xmalloc(sz ? sz : 1);
 	if (sz && fread(ptr->ptr, sz, 1, f) != 1) {
-- 
2.11.0.157.gd943d85

