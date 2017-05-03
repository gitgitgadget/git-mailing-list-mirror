Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB37B207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbdECKSQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:18:16 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36139 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752850AbdECKSN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:18:13 -0400
Received: by mail-pg0-f68.google.com with SMTP id v1so27630967pgv.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Kfmfd6B6+MG5xIrKLM1CcudX7VM+32OfpP1ZqlZWU8=;
        b=Ih3zvPu5dxYq/tudiXwI8fjsMaBQIvKffnTnxEyp/tQqKrbsBugp2zc2YUkVahhRTr
         I6zE5Q3poQdZUb/OD7D3pKBxUIJ57tp9MxoDSeiykI+4ENteciFFsH+NgHbKvQ7UsEcM
         JVYUIu0Wz0lro7mgK9Gw3hWKO71jjWIjTIfb0dvLZcHb1Fbspz4yOzASPcj2LIdhGrxU
         4Mo1gCTNopJ3Emhw4OWb1NBCPOZSMVHrJH/iOGB7AKOR3Su8+w8JEKb+Wj2pjkPwmUbh
         Ott8R/f7a6yNFarfyk2Lvu/4a4DHO8Fbjs/gvZ0CnDw1T4THF5Tsk/d4593FXSiWXK0d
         kqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Kfmfd6B6+MG5xIrKLM1CcudX7VM+32OfpP1ZqlZWU8=;
        b=LE+8HsQiIiadsqNey3nL/yQbxBHLJKBRLr+CR41IGs0z+M6NGA5JJ30Xw6WUJrF7Rr
         opMhEj7yltHr1ZzZvDgB/BdilvUoIWCUqLKacAE/O+iYXlGlpAIMKlE0wptHC3ILcjx8
         5+BLqmziL9Nu1vb1YqEgczNYhG+iurmKuvcB6e18+yqNNDr3CUi6plv6jhTqBRCBPQpw
         nf/3i5zIiCDHN3Q8kAB4iILpYevHQcvatjL+HAhmrIds9ul+hygcNPJcywNhSatNmaMV
         lKWJox38PbHnZe1/UNxZC4W+aW40OqGTVdbgA3KHf3QJwWrcPATW6C78FKGMYi4aR9Y/
         qrsQ==
X-Gm-Message-State: AN3rC/671qHWz4PisvDJUsMD3StsH3zXwMwAFfeKBspCqFvtnlu8b1zf
        f8FJDy914OFAbqf9
X-Received: by 10.98.37.135 with SMTP id l129mr4048606pfl.38.1493806692670;
        Wed, 03 May 2017 03:18:12 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 65sm34393426pgc.1.2017.05.03.03.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:18:12 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:18:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 02/21] clone: use xfopen() instead of fopen()
Date:   Wed,  3 May 2017 17:16:47 +0700
Message-Id: <20170503101706.9223-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
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

