Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278A1211B9
	for <e@80x24.org>; Thu, 27 Dec 2018 02:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbeL0Cfx (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 21:35:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46024 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbeL0Cfx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 21:35:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so8165417plm.12
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 18:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tIdmX1tsAp9NBFyiBhVW/D0P+yK14Ye5XfKQ8n7vJyY=;
        b=CITwT7mspGai+jd2Yf1sXBH+DHr3ywBxxmcynF4CXygBmKUpGomavw9k8DNvrcttiM
         aSKshnpUN0l/dJjI5BqhDiSf8LZuBnH9PcAt8/aCoIEJJZ4raequf5vEOByNf6Pu4Y4T
         FohfWx5NOdo4+Kwx7Lm/dUGY879P40W9fnCmQW8NGGbhgzb2rqrhxGkKfVQbUBBwt7rm
         5jUKlBYBybXHOaEmVmtf4gEmFmeYTJ8I1RNSCk6U5pm8ikp3IwCuxN6WawDmFhB/bDy6
         TZwoG7tbD1wiq00n6GcbJLw387UT6YnOl3WY1ibbzt7A13+J+ntAC1up5OmnDrK13zKr
         1eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tIdmX1tsAp9NBFyiBhVW/D0P+yK14Ye5XfKQ8n7vJyY=;
        b=LqEQXL0AtpOx7UIHqBW6hqc6K6qAqXflUwhTlUyh5X6rHRH8KSoxwK3r5KRVdF36qn
         mUQ9wL2EuaiPwq9XmYq3EVTXtJk1VOYAfkUQ3Qzfc7UDqq+gxesJ0lKmdh3ZqnLgQ7Ui
         5wU4xJ01ESoawh/B0AG14JhNIkhzj6bB1ssjCOHSRrjS10iaFMeRjq95Xu4hrmSy74Cf
         jhI3IaoYf4tHYuFEtW+EqC0zlaTzP/+LiSXoT2/ICb+RXyWMGq/GlJs/ne6kLrOdsExl
         FPOFmvJFOdBqM/xaCKWQnNic1mgiKMcB94qHS3Ch9evc2kAUQNAHkHfU32PBiVL57kXC
         HusQ==
X-Gm-Message-State: AJcUukccjP/XWMT5axpQOeTOVKm9oCJ4aUbtfL1BMMM2SOSJdokiiuhB
        8ha0COp5ZXt17XMDoKhEPiqZ77o7
X-Google-Smtp-Source: ALg8bN4M4bDKHX5xm0rL9txlSV9hHW/151FyNhLN1tQ5JZWqghLVWwGG12wnBfTJbqE5Rowy90ItMw==
X-Received: by 2002:a17:902:48:: with SMTP id 66mr21438260pla.68.1545878150993;
        Wed, 26 Dec 2018 18:35:50 -0800 (PST)
Received: from desktop.lan (astound-69-42-16-32.ca.astound.net. [69.42.16.32])
        by smtp.gmail.com with ESMTPSA id d129sm54634864pfc.31.2018.12.26.18.35.49
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 18:35:50 -0800 (PST)
From:   Rosen Penev <rosenp@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] imap-send: Fix compilation without deprecated OpenSSL APIs
Date:   Wed, 26 Dec 2018 18:35:48 -0800
Message-Id: <20181227023548.396-1-rosenp@gmail.com>
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
index b4eb886e2..21f741c8c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -284,8 +284,10 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 	int ret;
 	X509 *cert;
 
+#if (OPENSSL_VERSION_NUMBER < 0x10000000L)
 	SSL_library_init();
 	SSL_load_error_strings();
+#endif
 
 	meth = SSLv23_method();
 	if (!meth) {
-- 
2.20.1

