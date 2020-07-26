Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC80C433E3
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E9020715
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gVKGlGPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgGZTyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40656 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726832AbgGZTym (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 599E6609CF;
        Sun, 26 Jul 2020 19:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793281;
        bh=kzD44krolsMhdpvZfmNLjC7VTRRu/RTNvK14D0Rz7Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gVKGlGPmc15EOc8eseGsMHZvLrTrQ4jgf5iks6m4BYaUh4Cpbvh8Y52rLKXHuBeDQ
         8P+HVTHfRwnl2s4IVoOMtXKKcRIi2c5lEpwGWUJ6HfKM5lHpdMC19UzHpkwlSBsBK7
         g6oEBNRx4Bho4p+UfMPMpnQb/kb9XEKKwUfGgWrE39cBfsTry/gytUvKjmU3xzHwry
         HAL7RGeKARpwjxuzIqdUlOiI7DJg8DmDQfVj/2HFQR28B6mBO2M040EAP+X6zDdx0a
         q3AbfXpm0rADDYj7Ym0YkpaPhkgl1kU0E/Sa/Hm9Zf8wCIlmz6G9r2qoRE3SkVRcvK
         /TpZ4BNL8SnfncStQjx2fMnP9S4iQfhHucF/KesbMWMUpBZSCvp2LlgcRw/0oQI7D7
         QOPitZVnCY27R1pKSXRQrTRb5lK8rwfVSmOVJMVkqIwOVuydaBymlPZW/XZK7fMXs6
         S+BbIQ3VMKIwh/qK5LxKOvT8aTAth4KZX0/ZC4iCFlXQ0GIlH00
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 02/39] t1001: use $ZERO_OID
Date:   Sun, 26 Jul 2020 19:53:47 +0000
Message-Id: <20200726195424.626969-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
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
