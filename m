Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DEDC35246
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE1F2071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ky9oXx1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAYXAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:53 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46846 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbgAYXAu (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:50 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6A0DB61472;
        Sat, 25 Jan 2020 23:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993249;
        bh=8FU4zHKprYpeY3ERg5TngHjUqssaMsZOwf9nyGbqoW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ky9oXx1Q8S5awgrMxUMbttYKcMI3930vxr90vAEUUwySj8CAtviRdYSj0vwYovu8G
         4vFT/w9dshBo4QEks0CFcRwRny7FtWEOkkjBNuNRxCSedH8jDNRnje6B8qBKAdhy06
         AZCGsvsMcaUjLEAatsLlYFGJRVmyzsNYHJ1fVIcBgsJoz5Bh4pyscwOH2rXC88bUeT
         Ww5m81c6oOP9KEPz1C9UDigvCvKYyTMRmOY+rutKpY5IbQ2l4J1f1lg2C+fiKVVHyn
         rio9a7b5Ejmzv4ZRRNuYxURss3NaW62F+ADl3VnB0nW3KYSc4gxoaNpNnsDl3ZTVco
         +B2zguZQzhs9Q5jowaaI6GVJs8UuwipolXgRoJqVHq1oDfVtmHuUAGbSbgsVaU2kx0
         AA2+gani3m3VlY/EzDC3tdptkq07KD73Smc13Ol2uM6P2zbBAxWMh+8OIUOU88zlmo
         n0bRoV/OoS40lTi0YV8+ehuQmsEMUyuHwa01CiS/eTmsYZOC4Lo
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 18/23] t5607: make hash size independent
Date:   Sat, 25 Jan 2020 23:00:25 +0000
Message-Id: <20200125230035.136348-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $OID_REGEX instead of a hard-coded regular expression.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5607-clone-bundle.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index b7a3fdf02d..9108ff6fbd 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -64,7 +64,7 @@ test_expect_success 'ridiculously long subject in boundary' '
 	test -s heads &&
 	git fetch long-subject-bundle.bdl &&
 	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&
-	grep "^-[0-9a-f]\\{40\\} " boundary
+	grep "^-$OID_REGEX " boundary
 '
 
 test_expect_success 'prerequisites with an empty commit message' '
