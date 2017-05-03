Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0160A207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbdECKTj (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:19:39 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34158 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbdECKTh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:19:37 -0400
Received: by mail-pg0-f66.google.com with SMTP id t7so27650672pgt.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HxKh2N0qAvuYxmzEepJ7ceJ52zEzqaGfziXFM++N4xs=;
        b=kMXopamYpq3XWouETIAoM3IMmpndFKU2i+g3P7H1pnYEeMaUPV7VXY0rff0ldWhLWE
         7emI9v3MdtK+GNeHzKHORimq3Iut5uAzwh6FpMy7YzdutbdNqV7Jmnhf9/ly1qIxvtc3
         b5CKbUqVu+OonZ4e0SyQ44TUihKoVPqOka4V61V5nubC4ByRoHzfxJwLnLIEythvQrfS
         Ib6KJed1azZps9Nrte0LWUTZuAc6CCLw8VR9saXZxDmFVyRvcr4HCbuILw3RTXodlrej
         eAhXE31lieib4BmYO6aZidUeNhpcUiCRC/xSLhKFk5nLaQpcYftGMefLrFl3ueuDk72W
         oJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxKh2N0qAvuYxmzEepJ7ceJ52zEzqaGfziXFM++N4xs=;
        b=tzlLfTS3txUuKI/W2flSviEIOImYQvGzTI55CCZqcBDKDEoxnnhpzzWGuVSSAZK3Yl
         YA3JvfuIL+AReNk9sd8O5DWzsg1TTMRvkU7PbuRp07cErCuNww4IuTBhHwQ8Gz0X0m98
         rHl2rds1LuR1zWFXN+YHfRbd6av2pLpt8w9rvWtO1YeTFhP8AWDA0DliiazUeKp4VkD6
         DINGUHg72CT54KtBytlRBHfMeaSFYmuWnJIo1PxE9zgaxuYMq1++OvG0vKYp8RhYi4Q6
         6RNOuU6M0vsjT8Su3hzfd41lIAhw8Rbi2BKc66ofkbhoG6qGgzw9OHBc7tKZQvB15jnX
         Zx3w==
X-Gm-Message-State: AN3rC/7p6JNvB61egoIYV3I77C9obqStMPn/zjZ0PSQnRf0wv2hgJdVE
        dFUib6ILCXnLtw==
X-Received: by 10.98.166.21 with SMTP id t21mr4010523pfe.120.1493806776469;
        Wed, 03 May 2017 03:19:36 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id b8sm42170341pgn.51.2017.05.03.03.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:19:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:19:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 17/21] server-info: report error on failure to fopen()
Date:   Wed,  3 May 2017 17:17:02 +0700
Message-Id: <20170503101706.9223-18-pclouds@gmail.com>
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
 server-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/server-info.c b/server-info.c
index f6c1a3dfb0..e01ac154a8 100644
--- a/server-info.c
+++ b/server-info.c
@@ -133,7 +133,7 @@ static int read_pack_info_file(const char *infofile)
 	char line[1000];
 	int old_cnt = 0;
 
-	fp = fopen(infofile, "r");
+	fp = fopen_or_warn(infofile, "r");
 	if (!fp)
 		return 1; /* nonexistent is not an error. */
 
-- 
2.11.0.157.gd943d85

