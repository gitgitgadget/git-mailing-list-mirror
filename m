Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C0BC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC6520776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="znvSeBHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392564AbgFSR4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39410 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390892AbgFSR4P (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AF23D60A5C;
        Fri, 19 Jun 2020 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589374;
        bh=vM7pid11nQsZOGNYd0VAPXG+qD4DXfjxnlg7+N9j2CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=znvSeBHKHNmgclWrBuSKaIfsgR7Cps42IlgE267LcFVma/GkOQz1QmgKlUXQshgD7
         Nznjrob4TwdpsuwyBILGPk2/1x0KUq2WV2zdaaEP1/TNpTP7QKx5fsQt1lr7V+c4eI
         XLApLtqDw+1HxmFjnqqGdN0jDGwnYQLljPBTkh4sR9QJ5KTgvbzLUKkdCvSP+N0eKV
         NcMaMpRFVHFkNP2HFQk1/OejzdqViyKqANp5Rgu222w/dfGW7iScZq3I30vTscsR88
         0JUq3dMTXKnKGRPxjMmKkQmVIxHdE3QqpDcGRVEGt68DXmXUliYfL6wa7iVOpwRj4j
         GzTPAsrz9SeLmNuVnFC5AtLfqtHFDn8jzg/fjy3hcws2lSUVr6qGo+ObkWgwetH1Fh
         ZM3Ipi+aA20SwaSbfdTEtRudtbe1JWuyk9+gr5cZ+tapP7QY9TyXNKd+rxta93v5Ei
         NpqRwglhfh7j7o9wPCJZVl/HZj7hColGqGU8riHm4t1H63Kl1sg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 02/44] Documentation: document v1 protocol object-format capability
Date:   Fri, 19 Jun 2020 17:55:19 +0000
Message-Id: <20200619175601.569856-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
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
 Documentation/technical/protocol-capabilities.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 2b267c0da6..36ccd14f97 100644
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
 
