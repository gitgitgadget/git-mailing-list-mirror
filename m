Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A16F1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfJ1A7X (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54232 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728837AbfJ1A7W (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7266561C4E;
        Mon, 28 Oct 2019 00:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224361;
        bh=raAhS3PrnzvOKKvzy4YPRvhsXXlEiiTAXRPjU4RjW6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=IRLMXKTUuzV7W6KZsoxE1qd0rFP7M4LZ+mq4p8Rgwak4TbSdZ8AMBM6qvpMARTWDF
         CbeHqv4xz2i82YUfKiC4Kjv+LS0X68lxhPv/7W0S2J7LlfLyMj7qRqtvSUmofIroDH
         yqoWeq/HbBmNWEv5t/fR81MvEeahTh9VcIRaS9GNa2hB8WVzWSH+ajCM8ng0cAgjD+
         7Pu3TAuLBtaD3mspHxNONXiDtbAp5XV1Ty8noQuwdL052Djm+mx2jFg4T7sLngaPro
         HRAZqe3BAWpa+9Keh7dIrclIgqf38sU7AS8oEuKG0KLOrZPQ/vC9LhXjXE8/oFWqdF
         9T9jChMSrAavL7LaMfNH1oRCTrhxrxYdG6EE6EodLOUjfrVSwB7JU6DPKbwW0ikwDV
         FPa8+cEhW6msTxZXnJltqC10B8tJrio2VrO05w8IkL0a/YQeXbb+Oq8tQ1B7wknVh1
         m98jCpHt7oQPXpJf8FBD6ZxsWec8pPflfm2vLFENTUmzjVtgK2G
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 01/15] t/oid-info: allow looking up hash algorithm name
Date:   Mon, 28 Oct 2019 00:58:53 +0000
Message-Id: <20191028005907.24985-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
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
