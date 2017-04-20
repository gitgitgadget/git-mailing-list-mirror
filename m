Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42EC0207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970260AbdDTL0q (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:26:46 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34109 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031570AbdDTL0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:26:43 -0400
Received: by mail-oi0-f65.google.com with SMTP id y11so6305685oie.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/5l+g8CNRlKQe5VQloP9zJ7x3ZghBhfDg/GSY6irrY=;
        b=vbK+6v0WI+2xxXoIFm2huDtmIiDLOHcbVHifSVrwRWet9fFfVk0jnwqWI0Yy4SME5O
         h5uAv1tbxqfqttEpF9SPjVd5FYvFZWIWBfjQ4+ygO9sMwM6GYd4GLaf5mtSqdCMtFsVd
         FeG8B71lfILMSX11RDijVdByJ2P/TKoeNSHWUJJHBb+SBW1cne7QR4C2DgQNgEmy95nE
         +dQkVIAScJYSKX+pc1L9EqKFnpAwKQ9NtDICFEjwVlYhtsI0XT7+anvkVvGX9pQ0eAke
         /ZbDtyK22PGXB9jyaa1Brn18xejnQM2IpzL563qxT9GaByDPCvsjAdBypKudHIrDvdgu
         Rw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/5l+g8CNRlKQe5VQloP9zJ7x3ZghBhfDg/GSY6irrY=;
        b=Phsdfi4wgH3wTOHw9mlObofB+eUxm7J0Afp0GkwRBH29gZbOO24IYAobLiCU63DJBF
         c1eKKBKwhKSXJW4iFFD7ImqlCVzTMEChksXOslJiqvbDwz/AtWUm+T7aN9NxPAovagCK
         bxYQfXxtE2z3WNA4ZikDWQhRCB7U/VYTT8xVaKSbQcpf7OxwDf/ErhhQPDK/b2Vj3BjX
         ctHoboqIS3wAvI79mc9iZiL4+BzJZiM/ynAqo18zm2tPs7TgKjGgirgMCYkMwr+bio4T
         glY2sx/xmG+b9QZXglsmsQs1oc0K3d/XXXX0oM0/FYhbVvlgf3xSyhdLEN/fRFzyNI0u
         51qg==
X-Gm-Message-State: AN3rC/6SVUk6ZySVvEi7YU0xAr88zgBvGDusd2GSe8UCaXK1491a7Ovg
        pzvVBVQtzhkbcQ==
X-Received: by 10.84.148.203 with SMTP id y11mr9958429plg.10.1492687597421;
        Thu, 20 Apr 2017 04:26:37 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id r131sm10026128pgr.67.2017.04.20.04.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:26:36 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:26:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/15] blame: report error on open if graft_file is a directory
Date:   Thu, 20 Apr 2017 18:25:57 +0700
Message-Id: <20170420112609.26089-4-pclouds@gmail.com>
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
 builtin/blame.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 07506a3e45..70afa1b05c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2073,8 +2073,11 @@ static int read_ancestry(const char *graft_file)
 {
 	FILE *fp = fopen(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT;
-	if (!fp)
+	if (!fp) {
+		if (errno != ENOENT)
+			warn_on_inaccessible(graft_file);
 		return -1;
+	}
 	while (!strbuf_getwholeline(&buf, fp, '\n')) {
 		/* The format is just "Commit Parent1 Parent2 ...\n" */
 		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
-- 
2.11.0.157.gd943d85

