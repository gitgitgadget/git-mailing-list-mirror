Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F26AC2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB43120675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uLbSdOBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbgEMA4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:56:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38104 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731897AbgEMAyv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 31B9860D0E;
        Wed, 13 May 2020 00:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331290;
        bh=GiBRjTyb6hSilLNak5pYDTZoH59+gji1GPh9ELc0b1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uLbSdOBrecSer81so2pdw8lLQELARAfEvf07W9z2tmqQ0IQjIqskXOlWahwj57dUu
         hx7mUhMWuVmWQY8hlw6i6cahJaKLGLxTQS4UGOTVUEMbjk9SMqEF0m1U7arPbzJJMK
         hJ5JlZ1dk4ZKxhfMJGnm5vcM4g+LSWEeIYvYT1bux3Y/sbkb8s9cdDGlA9X207j3oR
         XzL64gJvd3d4lgixcjQyI8/xpnPaj1lBmWG01Mow8AiXN2g6hPmZ+BnXzPPIKvP7Tp
         qPyF8IrrJZC6PNUYteDU2ptO6CyErKeBGvNfm6Zgn0pFQBQZqkWTY2Jpnzmw3RSJJz
         IWw0g1mNhWZPydyNiEqz7Zm7E/RXNTJ7VrxpuwpozoBMgIQXBxNBXEZ2Cf1vlLQZEO
         utgYIaTUYk7np8FNnl4bMHLTTiXE2+93NFJJ0EXHa5h9voVJfa5aJen/X9rE120yKk
         kANeDoK5feYjLZLxqv9KtJNb944nj9WsoJKaaxABnDjmqSDJnH2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 29/44] Documentation/technical: document object-format for protocol v2
Date:   Wed, 13 May 2020 00:54:09 +0000
Message-Id: <20200513005424.81369-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
