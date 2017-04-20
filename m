Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB313207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031189AbdDTL1b (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:27:31 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33915 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944603AbdDTL1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:27:25 -0400
Received: by mail-oi0-f67.google.com with SMTP id y11so6311183oie.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsaV4ek3M//5xQ7JmrWb7V3LXfzl03k/iiS+HDVkS6Y=;
        b=ETbh/Gg5smbcj/haYeacumnd6XQ1XVIeKhVnpFM7A17E5C9O94H3+YP0JVz8jqJiUd
         oCWJbiD5tJj7ZV+QefGLL3Y13lmMhn2SkK0XSouSfzVQRwAqytGWdDf8xO2H/ty1ADPC
         f3rEZx63VDKGpfeTvaQ8prJxHe/DutvKV3x9s7dxvsp/2YpThBPtlPUKWfc2p5REiGOf
         cfjmFqmmOepMJU3ygdhOuXJsb4NmAj2Vw5BSG+rUTjV1WFL8jnd+kAnb1C7Tvxf2HqG/
         BOPFCla3k+3svhz+F3QmCP/wchl+bU7vfgFjqUxtgLjJCNR297I2dGLItwD7EwdAlidp
         KbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsaV4ek3M//5xQ7JmrWb7V3LXfzl03k/iiS+HDVkS6Y=;
        b=pNM7sJAzpjUNGAMEg0fMyarCxv1mqX3eG42FBrTGH4NGpekcYB9JfoueSWduK13nKG
         fCu3LROvqM8UaGMLfvTKhT/L9FOiKczHaUnXs4X9UBWJvDW1CugB0kqyIgWSC8MTjJoJ
         HZ6RtqY8f/8l3O4JQZBHkuY82fU9NHeO2ZE7b/O1Uo6PlhSG27R3zoDdUyFFXsZp3YTq
         Ehc5dFYnXC8UbIp9S5j8Hdm2SoGcK2yKB8yCGRBS9lhJkEa8AR9iksPUANvE15OwWGRl
         Cj7bU9sh80STxXJolFfsO/nmcT5pf3NUJiRWi08gZVZIfJrl2Zmgln4I+wlowux02iBu
         AubA==
X-Gm-Message-State: AN3rC/49SzS4rdRw6elUsoANUnzZqDNVFoore5nL82OWT254Gx6Z111X
        vyKVO9RdZ/VQ5tJs
X-Received: by 10.84.218.2 with SMTP id q2mr9948289pli.141.1492687639882;
        Thu, 20 Apr 2017 04:27:19 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id y187sm10032456pfy.67.2017.04.20.04.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:27:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:27:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/15] server-info: report error on failure to fopen()
Date:   Thu, 20 Apr 2017 18:26:05 +0700
Message-Id: <20170420112609.26089-12-pclouds@gmail.com>
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
 server-info.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/server-info.c b/server-info.c
index 7bc4e75d22..7fc2a76966 100644
--- a/server-info.c
+++ b/server-info.c
@@ -132,8 +132,11 @@ static int read_pack_info_file(const char *infofile)
 	int old_cnt = 0;
 
 	fp = fopen(infofile, "r");
-	if (!fp)
+	if (!fp) {
+		if (errno != ENOENT)
+			warn_on_inaccessible(infofile);
 		return 1; /* nonexistent is not an error. */
+	}
 
 	while (fgets(line, sizeof(line), fp)) {
 		int len = strlen(line);
-- 
2.11.0.157.gd943d85

