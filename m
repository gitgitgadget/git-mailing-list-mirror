Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD5AE207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbdECKSy (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:18:54 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32813 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbdECKSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:18:51 -0400
Received: by mail-pg0-f65.google.com with SMTP id s62so16004043pgc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QYT+nJNY/sf3ChDGJfAP7onu7bekpHtfj5eq5YT0vI=;
        b=IbmXlNZ2E7Q0DRwRoaSHXm4bu0wacheJbWxT0DU6iKovuppARvB2K/DtZD19VKBapX
         ne+gDx37VC9o+qAxkWC2qPr6qWrP82BLrEA/dshz7p+vwy7aI5F5AcbSMkxHBhfugMJJ
         ZNnutay3ITKzG+RI++VlOpBNG0L3SaSidnD+0WWlVDPSXyn9to0dT6grjbFx0fZUqeNX
         WLFzM5m99d7Gv9jSSexT80tb5uk/u4dGHiVCKt41r1m7O2iiMtuz+Ba3f22VklhwCe+q
         gJpKsvwe0GQxzATmiGIrX8Zywxi3EOcG4Lz9Pb+RT2pXoEO1i0u3gvgXUXIrDLYSRYAs
         t5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QYT+nJNY/sf3ChDGJfAP7onu7bekpHtfj5eq5YT0vI=;
        b=CJfkSKxy51gsCR6kWky7DxDxnl/CIrru/0NaPeD3BoqmFxjx2fKyhH6VxvpU7uS3X+
         OAl3ilwO7Eu6vH8N1uwrmzt+jGsO0DkKdrz9qoMD5gv44asepPANGTMmZ4zOh71bkA68
         y6Gru1DIXugccuzEMTELqBAmkl3aNVHbfanN2p9PxUSJLCl65w6CNbZEIb0KWHa4vI+s
         EDe+4nrIycAdyRP8tBPBKfbv6NNARExlBBCKrACbdV3QKau0De0hId89ULqK57ycT6RH
         ytpxvZfNM6dUrRRl3eeS0CAV97PRdT4oJuKVktRGgWqk9bzxTR4Ic4G88Jg/colR5qUb
         GqNQ==
X-Gm-Message-State: AN3rC/6A1ZqXhcH5DsTzeJQyOEOvpcjA2zxMzpKxAN5gnupjnwVHqfB2
        NJ/LXtna5s8azcom
X-Received: by 10.99.126.92 with SMTP id o28mr7919820pgn.63.1493806730890;
        Wed, 03 May 2017 03:18:50 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id r90sm4224685pfl.120.2017.05.03.03.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:18:50 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:18:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 09/21] blame: report error on open if graft_file is a directory
Date:   Wed,  3 May 2017 17:16:54 +0700
Message-Id: <20170503101706.9223-10-pclouds@gmail.com>
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
 builtin/blame.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 07506a3e45..1648b396dc 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2071,10 +2071,12 @@ static int prepare_lines(struct scoreboard *sb)
  */
 static int read_ancestry(const char *graft_file)
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

