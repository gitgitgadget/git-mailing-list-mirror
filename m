Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91750C433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B5D20888
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FD8XRwDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbgGWBJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:09:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40482 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728607AbgGWBJw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:09:52 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DF1E960758
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466592;
        bh=kzD44krolsMhdpvZfmNLjC7VTRRu/RTNvK14D0Rz7Vo=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=FD8XRwDz4xyLvupTlSX0DwL+SsA6BVzo3hlhrS/2XkxQYhE1mGfsrzzmmsw8S4z1K
         RMyWU6zoFOG2fHg7d19iecHiP23xLXYSXC7fENLsOJnyuGFOxlTJ7KA2UzzBK8wf4m
         c0H2B2C9Ne0EMUsOiRndXQsSEj75+mSlZ/nq7G0sgNK7ZwDHFJWwobUMec8nQjUfYR
         IyHpHnnaaWIi/rmeKvtRKsQlIV62ibDeBUqDBXKX9XvBkzFXUVgMmnKe6QtrceAejI
         SI6o1cPvit9Fp0Y3w9RFsdqQGwnll0GPms2/dlEVAlQvmqkIChNSSvh9iVZKFGSlQS
         ojrRqqHx4/jRA0TtVhQjkNeYRD27RHbd5mnMFtIGL5KhjuZz0Arcjm0P62rxz252AF
         kwc78QOIM9XRHHnDNYp3je1iJM2jdKfw+3VxkX/0VtmpNf+y7J2vi8gpED2UIf9QUs
         A8kyWQK1sS++usvgx7NgOxaFRfcQDsp1/mUXD/gkkXmu5EEOlnB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 02/39] t1001: use $ZERO_OID
Date:   Thu, 23 Jul 2020 01:09:06 +0000
Message-Id: <20200723010943.2329634-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $ZERO_OID to make the test hash independent.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1091-sparse-checkout-builtin.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 7cd45fc139..84acfc48b6 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -369,7 +369,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	git clone repo unmerged &&
 
 	cat >input <<-EOF &&
-	0 0000000000000000000000000000000000000000	folder1/a
+	0 $ZERO_OID	folder1/a
 	100644 $(git -C unmerged rev-parse HEAD:folder1/a) 1	folder1/a
 	EOF
 	git -C unmerged update-index --index-info <input &&
@@ -396,7 +396,7 @@ test_expect_success 'sparse-checkout reapply' '
 	echo dirty >tweak/deep/deeper2/a &&
 
 	cat >input <<-EOF &&
-	0 0000000000000000000000000000000000000000	folder1/a
+	0 $ZERO_OID	folder1/a
 	100644 $(git -C tweak rev-parse HEAD:folder1/a) 1	folder1/a
 	EOF
 	git -C tweak update-index --index-info <input &&
