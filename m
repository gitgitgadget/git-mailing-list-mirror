Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345341F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 21:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfJEVMR (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 17:12:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36290 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbfJEVMR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Oct 2019 17:12:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE50B61C61;
        Sat,  5 Oct 2019 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570309936;
        bh=raAhS3PrnzvOKKvzy4YPRvhsXXlEiiTAXRPjU4RjW6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UItvoaeeNCkyw33EXaUvcTlLMb/aLkSK+OlXSdyOqLI+JMW0b+7DT4DSwsu8YviOy
         r9IRYTWVQfN+Nb1F9y7lfsrBpq/bzVIb3VikQOUBGRcVJJo440aM3VpQMaxehZErHn
         aRE7qPRcnWdLh5xb2jQBB62r1963yxSP0WwxNhsgab09lZ9/ErGuWFF0K0boq9SF83
         ct8KuCViv+vcKRoyVEW3t7ivv9UZWbQNFZT/P3cPFnRosHVrf7VSRPPCyhYrLGmTKa
         mWDZRzNAOHLWzceq/xgcgqEP6QND31s+IImLQeFElICPEYuvnKf9ihJzfRamiC2WVs
         JzBxkgKO+oUaCOrEna1fPGp3XPJLd76RhcE+sIPYhYIbF61YECheXpRcs0rblcr28Z
         3c+rwTyhcYdQwi5np6IgIRE81nRjMIy8N4UxD3ASbFt1yIZLwR2Oew3v/LECJCI8FV
         Lq6Zliy96fp6wrChaUHaWgBvx3Dnx6m284d3N/fN4W7crYXe2qJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 01/15] t/oid-info: allow looking up hash algorithm name
Date:   Sat,  5 Oct 2019 21:11:55 +0000
Message-Id: <20191005211209.18237-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb
In-Reply-To: <20191005211209.18237-1-sandals@crustytoothpaste.net>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_oid function provides a mechanism for looking up hash algorithm
information, but it doesn't specify a way to discover the hash algorithm
name.  Knowing this information is useful if one wants to invoke the
test-tool helper for the algorithm in use, such as in our pack
generation library.

While it's currently possible to inspect the global variable holding
this value, in the future we'll allow specifying an algorithm for
storage and an algorithm for display, so it's better to abstract this
value away.  To assist with this, provide a named entry in the
algorithm-specific lookup table that prints the algorithm in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/oid-info/hash-info | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/oid-info/hash-info b/t/oid-info/hash-info
index ccdbfdf974..6b5ded0b34 100644
--- a/t/oid-info/hash-info
+++ b/t/oid-info/hash-info
@@ -6,3 +6,6 @@ hexsz sha256:64
 
 zero sha1:0000000000000000000000000000000000000000
 zero sha256:0000000000000000000000000000000000000000000000000000000000000000
+
+algo sha1:sha1
+algo sha256:sha256
