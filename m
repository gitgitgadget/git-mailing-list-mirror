Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07BD0211B9
	for <e@80x24.org>; Thu, 27 Dec 2018 02:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeL0CRr (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 21:17:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58000 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727363AbeL0CRr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Dec 2018 21:17:47 -0500
Received: from genre.crustytoothpaste.net (S0106ac1f6b61f856.vc.shawcable.net [50.64.113.123])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C081D60FDF;
        Thu, 27 Dec 2018 02:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545877066;
        bh=ExDek1nAh1RVBWI6EadrO/0A8YFpN9gHzcnxdNwSS7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BTksOdGijEcEbYLWzrNOiNhYrv5DkQu9G0WtxzCzu8Zi1SHRIMGQcPPFE2behEbMe
         vVwB7gfroVEy+yT8tNKmz6iTcskohJxlQbe77Ts835yD/BYvlh13rZdTweK+46PDov
         mQctHbhzom61cYGvAEp6VD1aSmD7czpE+3Ptpe2THGNZgjAzhUh8MEI6APJtVMVfoN
         LPV2WnwpcQhb+4uSy70cy/SXjxDRn+xZJM4693QTQEBjWKb2KdXWwODq7bBibWWnzy
         BElUNS6nxJFx1mXijhUVrRmtqeW1jS3SCM8jcskRkqDP2KKX+0lzj63ugQ19QbsE7L
         uSU0ZeByjo4xrQr/b8+m+7zvoZlA3BEzEP8qW/lyRpfunOryqCfFc2Y1T/U5LM5b3J
         TYGX2o/7Jj7J2FVm0Mil9PUY9WCsVhmgku5fOS13DqCE+sRVe2vSkPW/5MLdMcYBhN
         BhIqAAjoUbOiFCGLEI3EmBjqLI5+MXDdKUsszYJEt9kNCWrafjM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/2] Documentation: document UTF-16-related behavior
Date:   Thu, 27 Dec 2018 02:17:33 +0000
Message-Id: <20181227021734.528629-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <20181227021734.528629-1-sandals@crustytoothpaste.net>
References: <20181227021734.528629-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a number of broken Windows programs which want to process
files in a UTF-16 variant that is always little endian and always
contains a BOM. Git cannot produce or accept such an encoding for the
working-tree-encoding because no such encoding has been defined with
IANA or implemented in iconv(3).

Document this behavior since it is a frequent source of confusion for
users. Additionally, document that specifying "UTF-16" may produce bytes
of either endianness, but will be sure to provide a BOM to distinguish.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitattributes.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b8392fc330..2b2c93afd1 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -330,6 +330,11 @@ That operation will fail and cause an error.
 - Reencoding content requires resources that might slow down certain
   Git operations (e.g 'git checkout' or 'git add').
 
+- It is not possible to specify a variant of UTF-16 with a BOM and a
+  specified endianness, because no such variants have been standardized.
+  Using "UTF-16" will produce a BOM with an unspecified endianness, and
+  using "UTF-16LE" or "UTF-16BE" will prohibit a BOM from being used.
+
 Use the `working-tree-encoding` attribute only if you cannot store a file
 in UTF-8 encoding and if you want Git to be able to process the content
 as text.
