Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F04120756
	for <e@80x24.org>; Thu, 19 Jan 2017 11:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbdASLls (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 06:41:48 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36717 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbdASLlq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 06:41:46 -0500
Received: by mail-pf0-f194.google.com with SMTP id 19so3214722pfo.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 03:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bo5KKJ2/rn/SjQC661oD0KQI0hjaYrJq7owN/VBk8ME=;
        b=OuWpp9UocLFmzMbhR8ZI2vuhwIXUG3T7x/g3SnSvciW4j38ULlE3J+K7WzyPmKEIvk
         j6T8EwZhRboq6Mh2Ba4MHiXcSIt+rXFzt+0raWtle/X/XnkNzQcY/Q+jmpyNSg8tAxZE
         5/CPXpUyJTq12Swji6Zwq12nNZmsMY9LGpWwwt2eKhJ+5aQtaFB8luipFNA+tduefY0D
         gxZ/iyqZCxmU/A0f0KPa+4ReIHMS02GtiKA2lTvb0U7jgwUXtHefhUB07yaG8782VKT2
         8+DAvY2AhCjWrXjIXa5rjzM61kL8kcViwvkWwcuG+4YPL2gM+a4BO7Zs7UwMRN/y+MtS
         18dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bo5KKJ2/rn/SjQC661oD0KQI0hjaYrJq7owN/VBk8ME=;
        b=N7kts8m814HYuidsp8BQejV6oXzmEzOO6N4siEXq8cHeySQQ1Y9axBjtokbqo28qzO
         ezqm9TKsWyOL8b7TD1soUnCCN2Z+H5ch5Ucu5+nLV2IsbrGSkpnC2FensFAvnT5gS0zF
         sGluApaC+Q7DijRW5/jiMpPg6XKXiB1Tw+xwDd43gkPlYt18bz5f3fntqLoA0v2GeuLY
         Lyug4TLNp4NK4GCMkrwMnz2qA4zFy0Emz5ebA7uECchcz153tzx+3dklWQqXjCzNVvKI
         Ak7zNsAgzrwssyRcnByN5h8Kk3ceGQ2C6qU4gv80o0T7qV3F9PTA8X5Kz852CWQn+yrT
         eV4Q==
X-Gm-Message-State: AIkVDXJ2X3HnwhPhRE9va4Tf6UjxkY8Vr2kUWJ2mH3pYuWUa+yz53AMtxMQU4DlviaRk2w==
X-Received: by 10.99.121.69 with SMTP id u66mr9535748pgc.96.1484826100788;
        Thu, 19 Jan 2017 03:41:40 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id c204sm8166692pfb.51.2017.01.19.03.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2017 03:41:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 19 Jan 2017 18:41:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 1/3] color.c: fix color_parse_mem() with value_len == 0
Date:   Thu, 19 Jan 2017 18:41:21 +0700
Message-Id: <20170119114123.23784-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170119114123.23784-1-pclouds@gmail.com>
References: <20170109103258.25341-1-pclouds@gmail.com>
 <20170119114123.23784-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this code we want to match the word "reset". If len is zero,
strncasecmp() will return zero and we incorrectly assume it's "reset" as
a result.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 color.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/color.c b/color.c
index 81c2676..a9eadd1 100644
--- a/color.c
+++ b/color.c
@@ -207,6 +207,9 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	struct color fg = { COLOR_UNSPECIFIED };
 	struct color bg = { COLOR_UNSPECIFIED };
 
+	if (!len)
+		return -1;
+
 	if (!strncasecmp(value, "reset", len)) {
 		xsnprintf(dst, end - dst, GIT_COLOR_RESET);
 		return 0;
-- 
2.8.2.524.g6ff3d78

