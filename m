Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FD7C433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412CA2065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BC5plPgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgGZTzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40776 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728049AbgGZTzO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:55:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2059760CF7;
        Sun, 26 Jul 2020 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793283;
        bh=YnqhRm5cXPRi/ZkOai5UFwRTufPby2S7+lcAS3bYyKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BC5plPgJYRK5lvN3QMvjmBNWLqO3lFRQAzTr6Ym6/oZ/zRdMp6PR0wK6HAkw/5rmV
         b784ZID/FU+sHpA/ugQkAu99F4ep3cOejNSpL209waEb9Nzre8LTbsVCuvEIC58Q28
         VOd6q97SKHMYVQd2iCGf5te6Ejc5Yaz3V3XA8iljnqz83Y6iLvX+9IPVAArVFnQ1/g
         sZIZUTuVp9la0Y9Qvr1fxB8+FLYSknffRUSLlsm6fF1oPgW32f6edyioFAnURRoa6W
         44zfTQKCAL1aTZEjsjD9FyH7frp6pLcVyzYEEwmL93by1FiC2quiYugZsl/vGLLhT+
         09wrqkx9027c2Lxjxsle9e9u1QdmmDX7VMJs4AoIHQUu9b8/9NRQKBjfQSgsC36hnr
         LBj9t6uIYc4IC452ZRxtBvTmdgq21hbs9iw7UgifiyMC3+Oym/DK9TZytGt6U8Mg8a
         ZFXFHTEiIcbp1vFqI1vabD++GEbsazJy0v9a5/TKNP3IRURFAY8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 06/39] t6101: make hash size independent
Date:   Sun, 26 Jul 2020 19:53:51 +0000
Message-Id: <20200726195424.626969-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $OID_REGEX instead of a hard-coded regular expression.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6101-rev-parse-parents.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 7683e4a114..7531262a5e 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -34,7 +34,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'start is valid' '
-	git rev-parse start | grep "^[0-9a-f]\{40\}$"
+	git rev-parse start | grep "^$OID_REGEX$"
 '
 
 test_expect_success 'start^0' '
