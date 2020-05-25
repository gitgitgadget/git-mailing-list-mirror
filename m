Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51BEC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27312073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xX0E7cnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390391AbgEYT7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 15:59:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38682 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390379AbgEYT7p (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AB5566081C;
        Mon, 25 May 2020 19:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436783;
        bh=vM7pid11nQsZOGNYd0VAPXG+qD4DXfjxnlg7+N9j2CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xX0E7cnZlerX8WEOTNMscRVJhpul6+tMcRjabuSralG6TIHBdHigIiybaPVyLwnij
         sYpo9H5hWNjMYAg/kKHjWDga52K26SW/qTT+BeFt/X/tSvnVDSSZPkg9NEhZO8bDZ2
         FJ0Msi09CLv3fZ8pWqNjFWYcmylJlNUu5XFHLAWZA/ZaoyD3M/0+yue6SyqNfQeI1h
         Umt5ktxByMPndexVwIYzhxGab3PrxdIRPuVkpsZ/Yt4Ir6E1HjttnmXqyilfEYNpkf
         g4X8D9OyqbtFx2M5jQm/EovZ1Lq8HuPO/eEfYSuiaD36PS/Vd0e2Fb/djv+VHozYlE
         It+YTT422iLzZ2bECdb1zFNC9VNSvnb2KucIxSkywm6ZX93+4flUDJjGuG3utGi+h+
         /pWVaSB9p++mfb1krZPaHbcrBNBn6E7/ffQj7+X2rJrrYERvtPzWS/rTuc/oV4FZCi
         +CnAWITq8qU4Tv8wqSFMcEHpVTGhyPA5heur+HEtaJbO4iJ15s4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 02/44] Documentation: document v1 protocol object-format capability
Date:   Mon, 25 May 2020 19:58:48 +0000
Message-Id: <20200525195930.309665-3-sandals@crustytoothpaste.net>
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
 
