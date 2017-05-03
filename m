Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26BC207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbdECKSo (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:18:44 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34809 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbdECKSk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:18:40 -0400
Received: by mail-pf0-f193.google.com with SMTP id d1so617471pfe.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MSHtDxEKL7BWT88AHLJA93hDRs1XZ9w6Y+bJMVRc7DQ=;
        b=qGTjVSSWGgKvyFzxyFO/TXkHdNDU0zDViZZHm+eAlfgC5Phd5qV7MRe1SZShh4EZWt
         G629QtKmE62lD4yp2rFM5SgWPkRA3kSPnIuJ55XOPOakvDJa6rVpIIzHB2K9J9QqhZzc
         554bSE063PMMalz8peL86aOlx3mE7G+rZnGntAlWdOZ7PKBO661ScfAJLhjx+NewxJDw
         Mji2jU2/YvarHzydzw4WcgBgUFv8zanacxgY6T1BWXT7UpYtVzhfP99k9ORCWTrcQmuN
         eaXFgrSbLtTV2hdfGRRWHgxE6gZGZgrL9uG1/vfQTyUvuEZO1Xpey2lJ+1ZrNs+RE/65
         hUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MSHtDxEKL7BWT88AHLJA93hDRs1XZ9w6Y+bJMVRc7DQ=;
        b=czOU2Y9hifBbWCBOwvXg8NMmkLNiz6z8EpXgmY2QqgxWx6c3Cgoqkh8NFS7SZFjWns
         M/N0q//iBSzuyk7oqNGf7/B5yZMze7yHtJVCbr87RMmYxPf9WIFvxx+7YbSbz1qaZAeo
         pflDbnwXjEoHbypU2GABoEV/ZgYU5Du58QGQsozLdF4WB5muXxsKQq2UyiaVr52ACjKQ
         nTuwoxoFfooqju2zH4qIJKn05C+RRpazYj/lt7vmYZPSKclTms/TSr44KK44sDv2dmqg
         1gdMNuGuOlIGg7x2OD+IYKEwL8A6iDx3vamioZKMzfms50uHE156wHmxaDFb0OFl/h69
         fljg==
X-Gm-Message-State: AN3rC/5uN5+OoHMVvl6WUKtWdsbAD8GIleJzQA8mEp0qt//4cP4xXQK7
        pDadJgpW8Pa18w==
X-Received: by 10.99.1.22 with SMTP id 22mr27772529pgb.228.1493806719835;
        Wed, 03 May 2017 03:18:39 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 70sm3458738pfk.49.2017.05.03.03.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:18:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:18:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 07/21] ident.c: use fopen_or_warn()
Date:   Wed,  3 May 2017 17:16:52 +0700
Message-Id: <20170503101706.9223-8-pclouds@gmail.com>
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
 ident.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/ident.c b/ident.c
index bea871c8e0..91c7609055 100644
--- a/ident.c
+++ b/ident.c
@@ -72,12 +72,10 @@ static int add_mailname_host(struct strbuf *buf)
 	FILE *mailname;
 	struct strbuf mailnamebuf = STRBUF_INIT;
 
-	mailname = fopen("/etc/mailname", "r");
-	if (!mailname) {
-		if (errno != ENOENT)
-			warning_errno("cannot open /etc/mailname");
+	mailname = fopen_or_warn("/etc/mailname", "r");
+	if (!mailname)
 		return -1;
-	}
+
 	if (strbuf_getline(&mailnamebuf, mailname) == EOF) {
 		if (ferror(mailname))
 			warning_errno("cannot read /etc/mailname");
-- 
2.11.0.157.gd943d85

