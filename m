Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED0DC433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62747207E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Y/SBOCls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgG1Xe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:34:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40840 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729597AbgG1Xe4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jul 2020 19:34:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EA947609CF;
        Tue, 28 Jul 2020 23:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595979296;
        bh=kzD44krolsMhdpvZfmNLjC7VTRRu/RTNvK14D0Rz7Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Y/SBOClst3aFDMBYnP0gvBp9wiIHpTUKAMuUuk2h4Iap1a5u2BAcjhfVVR3ALlpkt
         kY1kA0YqAa0/uRA9h4IYpbb22DVu9MtjKlBj9DpEVdUBVbOdajjCKK9TTsJFLhQokd
         eSbvWHgS0lOMG9S4Ob+othjLPzz4AVgWTfk/QhUPWROq1BWghMetZaY9x8pu/fOxxg
         LZGdyFwAllU1Hk6bQPMUCQZtiTyApIZX7U0aCbdGhxVRnPEF8kq9HZGIjrHAoH/fDj
         490pcK1SJxGSuUIXY0SNmKLQfAnAgt0C7Dwv/2W/+8N5uY7ZyrquQYqutAztRqQEEF
         p02nhUZkSz/U1EkmSdyv/uV9K+PYz1LlL5dnIsF6x8/FwUkAk3tKJm8HqDfKUJ0/7t
         0m9DUVDol+5crj0Rebsg8I2+gXkmzNZsm57nNpuG6+DDRgwUZUuBvD6DNGerADR8xI
         vYELqSZRKIyD843ppjUB8tFdVwpRUjPlJwMVgGnk4i5HraJhAyc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 02/39] t1001: use $ZERO_OID
Date:   Tue, 28 Jul 2020 23:34:09 +0000
Message-Id: <20200728233446.3066485-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
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
