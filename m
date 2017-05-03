Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D320207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbdECKTZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:19:25 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33071 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbdECKTX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:19:23 -0400
Received: by mail-pf0-f194.google.com with SMTP id b23so3686827pfc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3bpuK7YVNL13DArjZ9+nCDuxl5H3hvIVqFGcTs+HMs=;
        b=GTItEUMfyarCWmQtNLqDoefHQv7wwx/kX4Q9yLlWSQnySW4JubRVcN2N5X7fldVBgS
         AmZ6QWW1dzsf44v+0oa5SUhxQKtE25UmK36WpHoe1PfWQqrIDJksjsBBmC0Rj/9dlffD
         PvoVrVak/k7iw6rPJDUwpWEzcYjsW+9L/8hxQ075uiWqZzI2shghMgftDLMKQtwoare+
         vwPC7Qoz0/mgOZL0xVCcX2SwnqEuDpKPFuGYVM2LHZ5KgbFsbiKV0YCqCee2VZiJ77md
         tzRcjlnXjWmoN3koOoBXbd1kiDA62DLtfmBFYpqjBt04qzUYzpZuRX3hjnAC312aAcsS
         QDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3bpuK7YVNL13DArjZ9+nCDuxl5H3hvIVqFGcTs+HMs=;
        b=lrchHTndxegO54pkFkNDURMZTvN1phGpSjBig2NCNJJ1nRJRf6dxDolDNnlhPADOBJ
         veN632SZ2dew2rOVflO8achKxMhFmIjko6osfJ+DCHJKCzCtaZ6RtqEdp0H1kOlb5C7S
         hRF2UgXYvTTRV5MtYtNF/5qeZz+/M9Vjp+Z/C8cPJmTr3zR0nrZlveoLO1XpueBYGR++
         97PFV2IKssLIxZWGW+kyihHgh2jx7bo65bpgDyLRFen2yDQQb1JnXRGlyA7BG+4T2NyX
         DpghMpOtmJdBWa4lZRsF6/+Xza285qEdjB4eKK6YYSEhT8wwx0/SLr20HvhZW4046IkW
         wIiQ==
X-Gm-Message-State: AN3rC/7OE3vmd0saj33AdF9G/EayhsClRUH6yxwYwqAWM0rTwGtAxF0w
        fY59IPpmTmsoOA==
X-Received: by 10.98.220.201 with SMTP id c70mr4025934pfl.77.1493806758282;
        Wed, 03 May 2017 03:19:18 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id w85sm4162723pfk.62.2017.05.03.03.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:19:17 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:19:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 14/21] rerere.c: report error on failure to fopen()
Date:   Wed,  3 May 2017 17:16:59 +0700
Message-Id: <20170503101706.9223-15-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 rerere.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index 3bd55caf3b..971bfedfb2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -200,7 +200,7 @@ static struct rerere_id *new_rerere_id(unsigned char *sha1)
 static void read_rr(struct string_list *rr)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *in = fopen(git_path_merge_rr(), "r");
+	FILE *in = fopen_or_warn(git_path_merge_rr(), "r");
 
 	if (!in)
 		return;
-- 
2.11.0.157.gd943d85

