Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D0BC2D0FA
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E8C20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dYCTq259"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgEMAyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38096 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729215AbgEMAyj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7243F60892;
        Wed, 13 May 2020 00:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331278;
        bh=XnY1hBbXCVrgcS1UHcgKuO6fcYFCkpQ6glUvbqDZkr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=dYCTq259dXN4jkLpSbv/4Mwnp2CQt/Vre8QGYoA5+77xAmSlKVJtWfIYQ2w91l+7G
         i+MW9GbwaFe24d+KITVkE/jBCT/IZIeukpISWRDbJvAo3Amg6wtVoZbvBGG0cRlFTO
         qMHwBX0mFacs3KzLGmWpz3LHL2XQPS80W80IQ/rXawgdBdy4V+1/dR2RXfnxH0hs15
         1FcLj2m69Ghq8NUm71/aKyDMuFfdKpbSQ85/ntoL6cgF2/yx0OTTfIRS9tWcrTYAKX
         +GHI9gFG/YaT8MhYeKn7HuKg6dgAdpKab8d917qyRw7zQrPZJ8uxkm1b1mQZDoJSFV
         vufQdes7xssQSc5qmkUJwiaA0/Mv80n4yjhpUBd6ZaZud4XxvS1disbIRiMuAr3NxR
         DLVFmSFD8LBhwoLXmtuuASbLWllXIqU5fteeesOMKUwa6JC6P8o74Zn9GIkWQfNwd+
         6UlR3J31znXByiBsn4fNfypn6IOwYZOqJCVerS6/wehmIytVg7k
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 02/44] Documentation: document v1 protocol object-format capability
Date:   Wed, 13 May 2020 00:53:42 +0000
Message-Id: <20200513005424.81369-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document a capability that indicates which hash algorithms are in use by
both sides of a remote connection.  Use the term "object-format", since
this is the term used for the repository extension as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .../technical/protocol-capabilities.txt          | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 2b267c0da6..026c42f86a 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -176,6 +176,21 @@ agent strings are purely informative for statistics and debugging
 purposes, and MUST NOT be used to programmatically assume the presence
 or absence of particular features.
 
+object-format
+-------------
+
+This capability, which takes a hash algorithm as an argument, indicates
+that the server supports the given hash algorithms.  It may be sent
+multiple times; if so, the first one given is the one used in the ref
+advertisement.
+
+When provided by the client, this indicates that it intends to use the
+given hash algorithm to communicate.  The algorithm provided must be one
+that the server supports.
+
+If this capability is not provided, it is assumed that the only
+supported algorithm is SHA-1.
+
 symref
 ------
 
@@ -189,7 +204,6 @@ refs being sent.
 
 Clients MAY use the parameters from this capability to select the proper initial
 branch when cloning a repository.
-
 shallow
 -------
 
