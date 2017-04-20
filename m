Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23700207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942856AbdDTL0w (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:26:52 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34559 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031189AbdDTL0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:26:49 -0400
Received: by mail-io0-f196.google.com with SMTP id h41so15340434ioi.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtL57SZf9CrnU/07M7sb64Iby+TgArCFciHNgS6FW+I=;
        b=AviJswrVZh5bJ+YI97d/MPF+rQ3yDRlZ7slS7hhj53ubESliwLr5+oeCeU0jWBzt+h
         S59nPjj8Nvp3c+FIMplN/FscXOm2fnNbqQf+Yww7AlPsrpjSjTJM4vO1bIzM4NWEfSgZ
         ShHTDRubZZQfM7RGRMZQNAMjuTZVEErV4lbFtvSBc5L/QwkNiIoql4VquY2Gnof2cmhV
         IjwaLRazKZSM5pbiONNdRmppKRx2KtUCcR1ejI2BHyjFrPY6MwQjIvPpHC2sslFx2JKJ
         KelQpmXugi2LF3ZPccmAx05dFBWjyK7+Av6czyexA/SfdsK9ISHw8/3th1CfnQQxhI6I
         YTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtL57SZf9CrnU/07M7sb64Iby+TgArCFciHNgS6FW+I=;
        b=mMMZPQcL+NXI6Kau7IEscOprVclkI90c2ayk6N5X/SQqK/zMVAn+W3GHT3yNJBGcEC
         jFB97zV58kPpBf1xGS7mOLcHQsi1Hl0B/B0/ZcPpKs82QpIzWwbol73OYe1ewYFNDhfk
         dIlvcfg4vwrjVDUdT9/dXlYm08Df5ycybkCrHrrW0JptTNUCbikRMwyC1Kw9RWqUmhop
         IDG2QdlhOWsJ4BsO55n1PbwZbsHMLx8gynXDyHQblib5r8j+j/83cG8MKJotpmLTg84Q
         J6cbPdshGUJPNb2Hwv2Ou+ppS4KVI7d3zeR7QbIyFkzbQOW1mXEomMwGWhLDrmkxK7nB
         Qqew==
X-Gm-Message-State: AN3rC/7rzEtfErsfQMUKROQ/65v4nVzNG4stFyfB1JM5FSrSzVPuEAIn
        fJRYIotDE9/oKg==
X-Received: by 10.99.138.73 with SMTP id y70mr7637102pgd.151.1492687608147;
        Thu, 20 Apr 2017 04:26:48 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id r18sm10035770pfk.109.2017.04.20.04.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:26:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:26:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/15] log: report errno on failure to fopen() a file
Date:   Thu, 20 Apr 2017 18:25:59 +0700
Message-Id: <20170420112609.26089-6-pclouds@gmail.com>
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
 builtin/log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index b3b10cc1ed..26d6a3cf14 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -858,7 +858,8 @@ static int open_next_file(struct commit *commit, const char *subject,
 		printf("%s\n", filename.buf + outdir_offset);
 
 	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL)
-		return error(_("Cannot open patch file %s"), filename.buf);
+		return error_errno(_("Cannot open patch file %s"),
+				   filename.buf);
 
 	strbuf_release(&filename);
 	return 0;
-- 
2.11.0.157.gd943d85

