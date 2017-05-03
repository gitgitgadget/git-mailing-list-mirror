Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFE1207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbdECKTO (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:19:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34050 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752841AbdECKTM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:19:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id d1so619168pfe.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYUZf6QsvLc/0s4puy41FHA7fZ+t66fRALvSzp0csCo=;
        b=LWqwTxiyBP9GBvVrRmi4CtjuaAWj65RM1A7b4SmpUAIHK6UwzzbddXaEA91yJEvIVY
         4jJo4wW6Tj6KAXL3f2xES8esdRo5gYepZXJx+Z3lZ/XfdOVmEuL+xN2akTIBzFZy8zbL
         EFzlGiywLQzNizAA2GR7IL+NThaG4H/fan+la//Lk6kEvFkAW9re1yFexbXENuUcBUK2
         mrA7EkFO+mLH8EbL+MjGqTAmBXz4DQqbidETmr7hlfQKLJAksgg6TC6qwjLYm1ayqFht
         YaE62BpSRZ+xJ1g0mjN9MLY6kgJXG8KHvmZ4X2Amt6Xc/xtdmh/0JXWC/H2hFckNnNei
         F19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYUZf6QsvLc/0s4puy41FHA7fZ+t66fRALvSzp0csCo=;
        b=Lfb4O0E96sCHNzRiUcJUxCKT7MG5VcNI4Xd59v0BiF3KPZ0KUfAbTeJ9Yf3GqxLRwC
         9UqhQRDD4WxnGdokagYXRvGA1Av27hqHNsHAFMrWklBrw57GSwai1Q46z5IScuIsteXA
         qd4QEwjkaD10jHuSndt1/Y3fHRXFrZYos/hQUfj+ZIEoj66KOP4EjHaoyZcpjr1bT8SW
         4Ol45ReB0Nh+Pi3TT/dN8ni/w1358pQvvOkN6Y4qpIbl6aMoWCFKzkiHu1DnGJLmApO8
         pBnlXCwwJWf/DozCM7qQdUqFVyHupIIP2BcVCKvtNCkOsZVELfsVGZGxAAeWMS21vlSD
         l42g==
X-Gm-Message-State: AN3rC/6C8KyDrUsdjvBes+GbMULH4HT4zWqwNogZiX+2NqXX+USv0wP5
        iU7muqOjqPeAEQ==
X-Received: by 10.84.231.136 with SMTP id g8mr47677961plk.12.1493806747067;
        Wed, 03 May 2017 03:19:07 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id q64sm4892530pfi.69.2017.05.03.03.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:19:06 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:19:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 12/21] commit.c: report error on failure to fopen() the graft file
Date:   Wed,  3 May 2017 17:16:57 +0700
Message-Id: <20170503101706.9223-13-pclouds@gmail.com>
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

Suppressing the error (because the command requires --quiet) is not a
concern because we already call error() just a couple lines down.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 73c78c2b80..075607a6da 100644
--- a/commit.c
+++ b/commit.c
@@ -167,10 +167,12 @@ struct commit_graft *read_graft_line(char *buf, int len)
 
 static int read_graft_file(const char *graft_file)
 {
-	FILE *fp = fopen(graft_file, "r");
+	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT;
+
 	if (!fp)
 		return -1;
+
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
 		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
-- 
2.11.0.157.gd943d85

