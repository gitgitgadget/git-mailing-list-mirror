Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BCE5207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944613AbdDTL1S (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:27:18 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34422 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944867AbdDTL1N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:27:13 -0400
Received: by mail-io0-f194.google.com with SMTP id h41so15339525ioi.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Kfmfd6B6+MG5xIrKLM1CcudX7VM+32OfpP1ZqlZWU8=;
        b=aUoIlhjtTLvW4J+QU7J0m1M3thLNLSqFqFrXFsEvCIQByzdi93s+53wJK2GPXE6m4X
         cQJxaHmAEtL9+K2YA+oN0qUasGyoJMPc3c7LdTo9RDHt5H2l6KYvjaRq/m0ig52bj3Kc
         PfwxySPKLvE/fzVIdkF9CXeD7qGwjY2+9c59oCfOXKEw58DzmXZOQUjiIXuatmBH4sja
         4mDUtTpzKBYJl0ypAJ7Byz6tIlIxDYOV/u+fZ7F+NqxpPNjuDR6u/GJN4ZxCmRVJ+9Du
         pnqDvgeRiLNY7JZ2Pl6MtM9KLNAGcKQToLTubWlJ/b6iyHdwdHe0ubBTCi7KHtr/A0Q9
         +nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Kfmfd6B6+MG5xIrKLM1CcudX7VM+32OfpP1ZqlZWU8=;
        b=p2/GHk+5VNFZGdAUquGzyb4QUsd5pR+oliUEEn4azbb6pyRyh5LZkezFz3YniGd2SQ
         Qja90MSyEfKRxKlVADWmwMB8jiwjVTmRXdWPALbkfs3lZTUd49MtftrTn6/7k0ZD/eQu
         R83bo/3GqAsMZl36yLIaUFuPNUX0uaWdh/Z0siuh2BCaJaAQZq5rPd/YQGMyazM3sBoU
         a0HXdF+Kf8s+Dxre4P54gN+MXrGFbwxjcoVYppLNA3Omd0FiRHTo8kFkcCEoUUY+6Pdl
         FfD4ykxPawdgeZmk9sL6nt7FYFy42JBlf2+n7nH6WwIpvdYg/Y1f3laYrcrT9CpPE5BF
         fE+Q==
X-Gm-Message-State: AN3rC/7+MKGoiQkDTucYoGUn8Lw12Rhsof8CRzysAd/ghpXhiDApWxEc
        88F0yoX2q8H85A==
X-Received: by 10.98.75.25 with SMTP id y25mr7549265pfa.157.1492687602641;
        Thu, 20 Apr 2017 04:26:42 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id m187sm10026589pfm.122.2017.04.20.04.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:26:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:26:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/15] clone: use xfopen() instead of fopen()
Date:   Thu, 20 Apr 2017 18:25:58 +0700
Message-Id: <20170420112609.26089-5-pclouds@gmail.com>
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

This code uses the result FILE pointer right away without the NULL
check. Let's use xfopen() and die if we could not open the file. That's
still better than crashing,

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index de85b85254..dde4fe73af 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -357,7 +357,7 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	 * to turn entries with paths relative to the original
 	 * absolute, so that they can be used in the new repository.
 	 */
-	FILE *in = fopen(src->buf, "r");
+	FILE *in = xfopen(src->buf, "r");
 	struct strbuf line = STRBUF_INIT;
 
 	while (strbuf_getline(&line, in) != EOF) {
-- 
2.11.0.157.gd943d85

