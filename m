Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A60E1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeDIUma (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:42:30 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43551 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754129AbeDIUmW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:42:22 -0400
Received: by mail-io0-f196.google.com with SMTP id q84so11217372iod.10
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 13:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r/81QSUS5Q3FbfxAS/+0UzU8P49RFZZ6r4yCQeaFvBM=;
        b=P3VOPRB2pdXuMDduGz7cLZCGrBKLIUW0CUfnHbiPUSmIz4QO5Zr3o3ngUvFfwJgXRb
         f5h0FtQ/gINV3QO//XFVkF22CW7c/vAhge/p6RJrpMD1F3qhzp6EKYCI3UMIMu4pVmWN
         6BoXmRtZx90Nih9u4lsIpcxwLn7YQE3NC5yrE9cjt1nVx0p9vZVMux7dCqvzjsulLIWm
         uzfOe8G1LfzXKX41iJLUSS4rYanOe9pVcWEayOFoDe28k+q2i7MDgQsZRNm+XBeu3p/S
         wvRTNfuLFRy8gwZk08vDSWq649EOQxAw4arsr3a/t1p8NhqbKIiVvj36FZ1VAkktrYna
         UpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r/81QSUS5Q3FbfxAS/+0UzU8P49RFZZ6r4yCQeaFvBM=;
        b=jYZ9qIiYye0DlEzrFDNFU7SPzW7OzKet9aBHycX/pHkY3kM5tagda7RjvaT0JWYhmy
         jP0arC93jRkpei1nHXkkPBNfa58yrLxsrx6CJf4J2CqXk6eC4Ds9Sthq/6O13NT+FNTY
         jndy/D2hAM+pbEAKNHlR3tt9m82zFBGix4l2P2wVgyOpTl2/nUaA/VzEsNgSetfbYOq4
         PUeIIgv7Nn2UnhK4eWm9jJKp7L6q04h3UeF0GvkRxtWiPOQJyteDIqyrYXbteyUgGSwN
         VD7SOM9qfzyaPd1B9KvworfW5yDwnlQKck6L4IC5vlEG76YQFkoELWMI5Lu4VtUIwq3W
         8wdA==
X-Gm-Message-State: ALQs6tCW144Uss4X+oONCldImxggSRSOtODX9ZagCzTYul7b+3xf8qkf
        gjiHOlfamQRvgyulY9JS2z4UV5Ee
X-Google-Smtp-Source: AIpwx4/UpBU591cA8kB+PVuFfNsKNld9kLpYrx2jsp4Em3LFYIeJpUALDUFoPhKAb2kTJLMFsTy8zg==
X-Received: by 10.107.138.141 with SMTP id c13mr582208ioj.0.1523306541541;
        Mon, 09 Apr 2018 13:42:21 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id 134-v6sm98775itl.34.2018.04.09.13.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 13:42:20 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, mastahyeti@gmail.com
Subject: [PATCH 7/8] gpg-interface: prepare for parsing arbitrary PEM blocks
Date:   Mon,  9 Apr 2018 14:41:28 -0600
Message-Id: <20180409204129.43537-8-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180409204129.43537-1-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In preparation for handling more PEM blocks besides "PGP
SIGNATURE" and "PGP MESSAGE', let's break up the parsing to
parameterize the actual block type.
---
 gpg-interface.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 0647bd6348..0ba4a8ac3b 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -9,9 +9,6 @@
 static char *configured_signing_key;
 static const char *gpg_program = "gpg";
 
-#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
-#define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
-
 void signature_check_clear(struct signature_check *sigc)
 {
 	FREE_AND_NULL(sigc->payload);
@@ -101,10 +98,17 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 		fputs(output, stderr);
 }
 
-static int is_gpg_start(const char *line)
+static int is_pem_start(const char *line)
 {
-	return starts_with(line, PGP_SIGNATURE) ||
-		starts_with(line, PGP_MESSAGE);
+	if (!skip_prefix(line, "-----BEGIN ", &line))
+		return 0;
+	if (!skip_prefix(line, "PGP SIGNATURE", &line) &&
+	    !skip_prefix(line, "PGP MESSAGE", &line))
+		return 0;
+	if (!starts_with(line, "-----"))
+		return 0;
+
+	return 1;
 }
 
 size_t parse_signature(const char *buf, size_t size)
@@ -114,7 +118,7 @@ size_t parse_signature(const char *buf, size_t size)
 	while (len < size) {
 		const char *eol;
 
-		if (is_gpg_start(buf + len))
+		if (is_pem_start(buf + len))
 			match = len;
 
 		eol = memchr(buf + len, '\n', size - len);
-- 
2.15.1 (Apple Git-101)

