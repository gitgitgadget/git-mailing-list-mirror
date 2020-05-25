Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302C3C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169C12075F
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Y1tghg9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390667AbgEYUAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38850 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390582AbgEYUA1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E696860D10;
        Mon, 25 May 2020 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436795;
        bh=GiBRjTyb6hSilLNak5pYDTZoH59+gji1GPh9ELc0b1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Y1tghg9L5cEu+QhNyqiUYq+cYUQ6dcvRXHlS3X4MGBGB2eKp68Y4kVK9d2MZp9wLQ
         PxPJA+Yca7hBvTdDkTYY5LquJI/Oo3fP8UnRA6Pb9Cuxf8+fOzG7qSEGyXEfID4HnR
         5JPgx9zc+Et1Ljc0IUDRtYMVhI9MrQ1p70osOX5fbC2QR/6LxkUNayj2jce8MDirNy
         59WeGZu2+adA8slXxaWchQhZfUDH1lkJSXQ9zzVdu3gEwsM0MQVcEFhpJnss8NZJzY
         tcyQjw6nNO1W/t/ilxcAWd7INwwdH+Dze+wF0ZvujQnxsBTnTqwODm0Ke/HAL2wFYk
         mKSDT5STeds/6mmuIb0jSID17MNze8CBxrD3LBVEAdowO0BvltpUphSLAC43dP9knh
         qtZxp/3cD9RTuXdkGcE4eaeiTiD87bYzfbsABKZMqEYMQZKgzyoIfTqxeMCPsdwZ5l
         OjyYOolGZ4zb5sMzQoehwtaUh8DsjA3aOOzDkBCruA/nVRISRGP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 28/44] Documentation/technical: document object-format for protocol v2
Date:   Mon, 25 May 2020 19:59:14 +0000
Message-Id: <20200525195930.309665-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the object-format extension for protocol v2.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/technical/protocol-v2.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 7e3766cafb..107e421fb7 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -453,3 +453,12 @@ included in a request.  This is done by sending each option as a
 a request.
 
 The provided options must not contain a NUL or LF character.
+
+ object-format
+~~~~~~~~~~~~~~~
+
+The server can advertise the `object-format` capability with a value `X` (in the
+form `object-format=X`) to notify the client that the server is able to deal
+with objects using hash algorithm X.  If not specified, the server is assumed to
+only handle SHA-1.  If the client would like to use a hash algorithm other than
+SHA-1, it should specify its object-format string.
