Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F47207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753288AbdECKTD (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:19:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32898 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752841AbdECKTC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:19:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id b23so3685690pfc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OrnlYK1y7/CYeX5rh+UjI25xY9xTHwT7QxCLNALuNKU=;
        b=PVQo9DgEOh0kUS7ruQ0+E7g0VD8eqdf6yt32vX0FdINZoqN9d87qRStavy/5r0P2SB
         0VdPgmcL0MYg94cOQRFzTCmy7Wv1GONKWh1Z0CWfG4iIqMQFwP3EFNa8Cxb5/jLYNeOk
         Xspx0fahPBW60cu5W/amXSf/rCRaIhjUmwmVWSNfFB9bIXZvsclO4tW8JpGkQ91N2eeI
         S/AdjC3/SeIO5SpsSNiZikrg9uHxLCKLQJOqUoi/4y1/z7Nv+QaMV/1tJwTdYlqywO73
         z7lOkev76EJEChG6ZHeJcL0lSXmg6QHwXfl33uw1jx5b/sx3lxtlaWu0R8lB6twYzbXH
         RboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OrnlYK1y7/CYeX5rh+UjI25xY9xTHwT7QxCLNALuNKU=;
        b=bsFfQP0Lc7q2O1tGTlBZFdeut72pH1Eb2AaTDmUp/JnyqhQflj4VZBRxUZdI3J1IPc
         GI4qTnDdscKN+vfZEbcmLzGlbbBrGLqTow2bPgh+FthfCqsLrxV2/iOhdCpB9AbOrIks
         bvYP37M269FhkB1hhfol0p0d36zepovjwonqmCPmG/B5s71kEL7kOrgZu6JbP/PMJAuV
         vXTqjsLC6r04GFW7ePRuxedvPc9ueFMXASVded1uz9ZVaERvvXjBgcdBdf68w40wmUol
         FkNuyk/qIQmMnsnLVENFkzS9Yc2KKIi+gMOB3I+V/31vuhOxx4gcUNo3faquqHo0VejV
         4YzA==
X-Gm-Message-State: AN3rC/7LWBtETAXVCbQd/YJYaKJJhth6f3dMe5jz62cQXWBqgiQrR6vz
        DEAnpKRasBN1ZA==
X-Received: by 10.84.192.1 with SMTP id b1mr44772595pld.9.1493806741482;
        Wed, 03 May 2017 03:19:01 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id z22sm3701276pfg.117.2017.05.03.03.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:19:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:18:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 11/21] log: fix memory leak in open_next_file()
Date:   Wed,  3 May 2017 17:16:56 +0700
Message-Id: <20170503101706.9223-12-pclouds@gmail.com>
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

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/log.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 26d6a3cf14..f075838df9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -842,8 +842,10 @@ static int open_next_file(struct commit *commit, const char *subject,
 	if (output_directory) {
 		strbuf_addstr(&filename, output_directory);
 		if (filename.len >=
-		    PATH_MAX - FORMAT_PATCH_NAME_MAX - suffix_len)
+		    PATH_MAX - FORMAT_PATCH_NAME_MAX - suffix_len) {
+			strbuf_release(&filename);
 			return error(_("name of output directory is too long"));
+		}
 		strbuf_complete(&filename, '/');
 	}
 
@@ -857,9 +859,11 @@ static int open_next_file(struct commit *commit, const char *subject,
 	if (!quiet)
 		printf("%s\n", filename.buf + outdir_offset);
 
-	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL)
-		return error_errno(_("Cannot open patch file %s"),
-				   filename.buf);
+	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL) {
+		error_errno(_("Cannot open patch file %s"), filename.buf);
+		strbuf_release(&filename);
+		return -1;
+	}
 
 	strbuf_release(&filename);
 	return 0;
-- 
2.11.0.157.gd943d85

