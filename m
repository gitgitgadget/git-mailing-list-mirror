Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41235207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944902AbdDTL1u (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:27:50 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35980 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031688AbdDTL1f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:27:35 -0400
Received: by mail-io0-f195.google.com with SMTP id x86so15328992ioe.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tucU0kZbW78+igt6Z4b5IYwa92WKnh7ztp4pgbZ6lSI=;
        b=nM0lwvBlsFEM9bOUWFp8yLbrIjOtB5VQVqab7FzpQ6XidZKK/tFnnM+cADDcD9W5WY
         IUx8us1WdYlhx5uKVPGY4S1bwBDnx75uvZxmtnzN4BmHKFUgA7hFM/RKBor5kA+7wsFZ
         /MpjLD05W6u3GDLCQTL8ZALfwxkcV4qXGt2Nm9Ax9uXAIU9OMpwQIeDZqx4r5DU+FgMW
         hVLCcXsaoE3xrHWqcs1h35By3gj0dbCGcrVCYZeB6niiux88chCSiMagxkfQwSjHJUYp
         kLEsRflIUfNuvORLpXhZPgqWECzhpUIRr8/OcONWea5K3X7E5FMAXINpfCuEmKnYlG9M
         rvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tucU0kZbW78+igt6Z4b5IYwa92WKnh7ztp4pgbZ6lSI=;
        b=gkNODNWkfokCEHabmP4xD/OL3VLVZFn/y7MIFQ9G2JBCnnGLmoBJ3rjzp8zixNwpq6
         nIAw53kEF+yCeQkGr/HY+Z64SAIMZHBO0H4VC8jSoaRdVgzeXXL9UhTOvTO96tc1Ue2F
         ELmy0RLQqf2x6h9AxKMB5qsF8lV/WIJe102nFX3amJZSxJ/fCa8O46dX/uMg6kDFUV/1
         TTsQvGMVZFcehAdnN6YjI/SA19tWkY6zh3XiDoCog8eMSwwQUfYlGKDJV0SyKbbIu1pL
         v217m7Bj33V94GlubnzsDDuSOcqzHSYuAQ+zcTog2elO8wfMByz3jDQWitvGXams8fiG
         eI3A==
X-Gm-Message-State: AN3rC/5ThybkZfIBtWnIS7yNhTcuPOnT2zjmQbBLNWtu3GZIOYiT4uMz
        UtyGqF7F15hvsg==
X-Received: by 10.98.101.5 with SMTP id z5mr6087847pfb.96.1492687644640;
        Thu, 20 Apr 2017 04:27:24 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id z22sm10035966pfg.117.2017.04.20.04.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:27:24 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:27:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/15] wt-status.c: report error on failure to fopen()
Date:   Thu, 20 Apr 2017 18:26:06 +0700
Message-Id: <20170420112609.26089-13-pclouds@gmail.com>
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
 wt-status.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index 0375484962..5c12bb6ae3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1067,6 +1067,8 @@ static char *read_line_from_git_path(const char *filename)
 	struct strbuf buf = STRBUF_INIT;
 	FILE *fp = fopen(git_path("%s", filename), "r");
 	if (!fp) {
+		if (errno != ENOENT)
+			warn_on_inaccessible(git_path("%s", filename));
 		strbuf_release(&buf);
 		return NULL;
 	}
-- 
2.11.0.157.gd943d85

