Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140ED1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBGKeK (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33768 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBGKeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so4589879pfb.0
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNF0FMP7ugRSeLxVq2GCSBaGpFsZYuRaAOZIJB1SebQ=;
        b=O2yzuPhxLL4XTRplflVFzd24tUVSw3I9NocnUorahaidxA+Bh05FMyGc69RP+nXchf
         KjF/Oh3rpozXrk7p/8u3Uf6zS5fvXaXnPlJicUB1knuKv8+0tKVBRP37YEfmtt60kcYG
         w2Wy2M2MGYLr06Ubbb0O2rcXWqcNSDdp0oSy4wCWLd5zqmlxarahROHOE9HVMYUfJGBY
         APXiruVD7OcTwUHyGjc/ZBavP532RGT1t3an0E8qqUTKkaLsbNQ6uBeluvaHof8RpQAA
         NkbLtDpgUyT2Kycj2W/lVQ330ehj0yKX36xieAC84xnhJ2OnnhDsbuUT0gfZZ/gfU1cX
         ljAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNF0FMP7ugRSeLxVq2GCSBaGpFsZYuRaAOZIJB1SebQ=;
        b=HDALdnBrgXdlTDUqz728cv1k7v3TWmwohPvVeC1RPvM73S1mg+QjlsY8yzZYKWp1zk
         vwD3p0Mdo5EP+SF9oFSahMX1W7UegyMyxsrt5h0lshHsOJINt4IBzGJmtUdubRZVjMja
         cOUA4bOJ0GtJ17Ok4Lq79Y0NsLy36DenWyi08dPj2lxCXVZZSWL0WvdmKj9xGesjH8Cb
         fLPmkYY2uOnMJ54eSCbntde5JnAso2RSE0/nUoYCr6RPgwuUGbZ/m5uid7AiUXVEBjs6
         yvZKzJvMQpOlv01ET+VTJ1Y4SvZrlRIYBEhLV7GbgVa7mVoJ51WLn8CFiCBBiw42DhHr
         GLPg==
X-Gm-Message-State: AHQUAuYqG7ocRErMpmcjKeES/bQQBAwxDYMnGNiBm+cQuqLwPyHX2Ngq
        QWBmxvphg8lwS2m17HYOVLG//0ir
X-Google-Smtp-Source: AHgI3IaWYK2j4G1xfcNCK867oxP2zt1oGt7jNZOJ/cT0QB0ZOaSdY1z9n1/jeKTssblXZ+DsZFqTew==
X-Received: by 2002:a62:c711:: with SMTP id w17mr15552404pfg.50.1549535648993;
        Thu, 07 Feb 2019 02:34:08 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h80sm11178219pfd.63.2019.02.07.02.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/21] diff.c: convert --summary
Date:   Thu,  7 Feb 2019 17:33:10 +0700
Message-Id: <20190207103326.10693-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 5e16082091..0276f25200 100644
--- a/diff.c
+++ b/diff.c
@@ -4942,6 +4942,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "check", &options->output_format,
 			  N_("warn if changes introduce conflict markers or whitespace errors"),
 			  DIFF_FORMAT_CHECKDIFF, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "summary", &options->output_format,
+			  N_("condensed summary such as creations, renames and mode changes"),
+			  DIFF_FORMAT_SUMMARY, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4970,9 +4973,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--summary"))
-		options->output_format |= DIFF_FORMAT_SUMMARY;
-	else if (!strcmp(arg, "--patch-with-stat")) {
+	if (!strcmp(arg, "--patch-with-stat")) {
 		enable_patch_output(&options->output_format);
 		options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	} else if (!strcmp(arg, "--name-only"))
-- 
2.20.1.682.gd5861c6d90

