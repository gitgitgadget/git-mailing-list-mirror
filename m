Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24AF1207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944874AbdDTL11 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:27:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35375 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944525AbdDTL1F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:27:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id v129so1393838oif.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJiMZpBJbddgZ21SneVCnsM//qTmZb3CuODFDG+SiGY=;
        b=lorw5swtD1l98oekE1KWeX2IhZLjzpKQH3fuBL/9RW9TSy84un3CUiHx7Oay33S12K
         Pgv+/5hX8xYb69PlfEGAwy4Ls6VIEz4REpg79QxlDFxVi0eQ4TPX7mYDZPs41IALtga/
         o+805CBGeGjTmT8EimtFTeNRt1YJdc07q1NL+ya5VkCzrTqyV7wkC3T2c/p+EXbjYfLG
         uZo9MNzmTcHKN2QD+8LcrRfjdcLY6smOjXr43iI+qGzJMy/PER5qL7kpH17E6opgXCJo
         ufRzvGpnIstEFIB3+qxjIXNgy6KTfrsUzA0WvPwcCYMNzCd4WQmATr9f16Z9oNsEj7md
         +N2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJiMZpBJbddgZ21SneVCnsM//qTmZb3CuODFDG+SiGY=;
        b=eJncdKEYHQnjf+H/H0z/HVngIH8+JS77UvzJEv2NAQ5VJ0tzqb/W5ynCDG6YgUXeN/
         iTku/RLDe2LUYi4vqm/vV/v/trzZOsse5Mt/Bv/6JBiYBSuOxxVc2U2FiQHMb20ZAbLp
         NLtzrWDy51lYi7VVfYScPBVpqXBA9IcPIZ9ZCYUFsj7wzrr9MdcGZOFN61RktBuTreKk
         GePT8KCsLHg130r+UW9HIRJdfg2rcieE0aZa3heo58q8zchDbDnCzSD09acbUGoujfHh
         8iI8bPlJOYpxlT5kKFLc00gTUJ3wNFQmUvriLdZKqIq5y5NLCeV1QuVifAFedUG8Sa3r
         ARFA==
X-Gm-Message-State: AN3rC/7LLlieYConXqpZTnW2ynzsi/IyD27Bj971drRgtog/kgIFJuKf
        L5Gvc98MZaFrCg==
X-Received: by 10.84.222.129 with SMTP id x1mr9880841pls.44.1492687624243;
        Thu, 20 Apr 2017 04:27:04 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id m29sm10068112pfj.32.2017.04.20.04.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:27:03 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:26:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/15] rerere.c: report error on failure to fopen()
Date:   Thu, 20 Apr 2017 18:26:02 +0700
Message-Id: <20170420112609.26089-9-pclouds@gmail.com>
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
 rerere.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index 3bd55caf3b..ef9b11578f 100644
--- a/rerere.c
+++ b/rerere.c
@@ -202,8 +202,11 @@ static void read_rr(struct string_list *rr)
 	struct strbuf buf = STRBUF_INIT;
 	FILE *in = fopen(git_path_merge_rr(), "r");
 
-	if (!in)
+	if (!in) {
+		if (errno != ENOENT)
+			warn_on_inaccessible(git_path_merge_rr());
 		return;
+	}
 	while (!strbuf_getwholeline(&buf, in, '\0')) {
 		char *path;
 		unsigned char sha1[20];
-- 
2.11.0.157.gd943d85

