Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14BEC433FE
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 02:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbiAKCTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 21:19:08 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:33256 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiAKCTG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 21:19:06 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A759E5B277;
        Tue, 11 Jan 2022 02:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641867545;
        bh=9Ly/kNo95G4atMl+pqI6szrn3a/V6rnzron6z1G8cBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YZhpIlZbuKWFsXxY2Ig5mDIa+m0eQjtkqU85d5l1V2rU1pwEgZKT5F/l7i0MnW/iK
         Z2AsqPeYf43nDqiSD58Ol2761DqLz1UG57gGuYPmSfeqvrFygSzLRfNKktMKkr8b80
         l85aLnocebcJDFjwjk+VUAUkklwJdVBjLka+NNjzD1DTdNcvg0YDtxAlmOfQCHNMhc
         +z2qaUHfswt67uptYvtpJ1nT3dmCutnIHnWDkgZd/+WG6S2YHXNEJYEiDpbUDAE3uE
         UOYlU0YcHvsvoKuCpIKamfEwu1uZBjwaXCt7mlBIdtn3xlPVjUr2LGRYn12G35oVEa
         RpwsaQPf1jygx7eHaY8j5Du+9GeKZFaOVzFCIdqGZI9Y9J9d4Biaz2e6coZq8Qlah6
         8a9E3bl0P7eY67lTojWJxexmziRfimzBE4dgDAXPJttZbrd4jIcZIeX1j0kjgRKRQj
         TDNcAhQwsAWrUbKwYfIRuDECONKGnw7y35Uk77a0DmlXcJOehzm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 2/2] docs: correct documentation about eol attribute
Date:   Tue, 11 Jan 2022 02:15:07 +0000
Message-Id: <20220111021507.531736-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb
In-Reply-To: <20220111021507.531736-1-sandals@crustytoothpaste.net>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for the eol attribute states that it is "effectively
setting the text attribute".  However, this implies that it forces the
text attribute to always be set, which has not been the case since
6523728499 ("convert: unify the "auto" handling of CRLF", 2016-06-28).
Let's avoid confusing users (and the present author when trying to
describe Git's behavior to others) by clearly documenting in which
cases the "eol" attribute has effect.

Specifically, the attribute always has an effect unless the file is
explicitly set as -text, or the file is set as text=auto and the file is
detected as binary.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitattributes.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 83fd4e19a4..60984a4682 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -160,11 +160,12 @@ unspecified.
 ^^^^^
 
 This attribute sets a specific line-ending style to be used in the
-working directory.  It enables end-of-line conversion without any
-content checks, effectively setting the `text` attribute.  Note that
-setting this attribute on paths which are in the index with CRLF line
-endings may make the paths to be considered dirty.  Adding the path to
-the index again will normalize the line endings in the index.
+working directory.  This attribute has effect only if the `text`
+attribute is set or unspecified, or if it is set to `auto` and the file
+is detected as text.  Note that setting this attribute on paths which
+are in the index with CRLF line endings may make the paths to be
+considered dirty. Adding the path to the index again will normalize the
+line endings in the index.
 
 Set to string value "crlf"::
 
