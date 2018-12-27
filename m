Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C300211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 18:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbeL0SA2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 13:00:28 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:38075 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeL0SA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 13:00:28 -0500
Received: by mail-pf1-f180.google.com with SMTP id q1so9411351pfi.5
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 10:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eFZ9l93ix4o3ijdunVn/nyorBsEaVFJSJLkBt3suBV8=;
        b=EzijWZyX1PDeo4hihV2c9XOj0k+AkXSP7rwpXINtQJe2CAbIzRWfc4lfYNfMi91DGu
         YtWm0Aqk9TwesZgiijvLt26vKphWH4tbudhntnSs02qcuVJSvobZ4XFIVjygMB5o8QdK
         Axzp3NjqcDYOUD2gRQz5VBcGjSd+sVSY0LsCmeZ49uIBeEDNpGsMUZ8STaB/rrLXKO72
         guss7UDVlf80yztgnD21CTshlCQQV9m8OL1dPjMouRWf2Yg5jvsljru1IrqYjn7ddwpI
         aM5c9cBLKjEebzm92uUXIibrskJVz+Z0xPkcRQO9VbYnh6zCLfvSIs7/2r3RflINL5S7
         ELyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eFZ9l93ix4o3ijdunVn/nyorBsEaVFJSJLkBt3suBV8=;
        b=J6JFQZwGtAtkjOgrYNSrTLVPqVkdsN0oRhITIMqiPj7feH8IWmGUICO87e5c2qJVeI
         h+80J54QP2ueEWQhfBZQFBdE7S+ZxlFVcTLv+LaXRkl3oZK2PTeLaswXex2htSaYr/zN
         jTBld8gsulIASmXxt0HFMYkb9agN58e5MM9k6AuiqM3I/Qqlwclo0HMgMu0LcmJ2cYG+
         o3S3SktdWcYEjy1c5Shwnbt7t1OiPsBecDhpCxw0f2xoc1PX3cDhFy6EebaSu5LxuovP
         H+sVgKMYcBALPMtfQGqwxzJp6PywB1DA/JKao5j+zDk0XuaKYXow6SrAmn03sS1PrcvN
         WJ9Q==
X-Gm-Message-State: AJcUukcp+uvuYSPAlIQ2NFf83GAWnAVOoWzU1mWialIZIHGMF5tWrNGn
        bKMbTYpU+LxhUrXRCIvt9BnqZAtg
X-Google-Smtp-Source: ALg8bN4cBzhse+FvNxKDjSdffs027ZUc5+5uFWId877gAuK0uW4ackeRKH+2m8wTIoDGimF93tsS/g==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr23593505pgf.240.1545933626985;
        Thu, 27 Dec 2018 10:00:26 -0800 (PST)
Received: from desktop.lan (astound-69-42-16-32.ca.astound.net. [69.42.16.32])
        by smtp.gmail.com with ESMTPSA id o8sm76793310pfa.42.2018.12.27.10.00.25
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 10:00:26 -0800 (PST)
From:   Rosen Penev <rosenp@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCHv2] imap-send: Fix compilation without deprecated OpenSSL APIs
Date:   Thu, 27 Dec 2018 10:00:24 -0800
Message-Id: <20181227180024.2684-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Initialization in OpenSSL has been deprecated in version 1.1. This makes
compilation fail when deprecated APIs for OpenSSL are compile-time
disabled.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 imap-send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index b4eb886e2..877a4e368 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -284,8 +284,10 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 	int ret;
 	X509 *cert;
 
+#if (OPENSSL_VERSION_NUMBER < 0x10100000L)
 	SSL_library_init();
 	SSL_load_error_strings();
+#endif
 
 	meth = SSLv23_method();
 	if (!meth) {
-- 
2.20.1

