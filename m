Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E07FC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F188F2068E
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyjSMeIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKMVxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKMVxT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 16:53:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C508C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 13:53:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t11so12460555edj.13
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 13:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0rkQOqpANgvuPaID7pAeya2JqnNoA+9ypok+HZxw4E=;
        b=jyjSMeIls9fnYdsJrypsDwgh2zs+PB2bLxGy8WDxmQ1YD02a49zYT49UXersuQrnjy
         X6vfs4CnStAJglh+FrNP/7LOGzA1Ok88eukkW5XHHBkWhXHNPnfe30VPeMbnjc19KpAg
         ZMXLceo49bL6xmwmts7AR+2DvqrzvPSFDeZN4wG2aW36d/27dQ1hLrwrO6oNRZfERA1j
         T6XF3SfgOySIimPaZmIfy+xr2aa+T+zZNe4iXfIlIHleLvPdm7ORmAyb2WGz0DCdYnmb
         KUZvsgacnhtnICGAa4eSJaO8Fc+WzU8uJ0CumFXR7iTMX4XcCwu06mTY66Wx4PQU61XW
         +8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0rkQOqpANgvuPaID7pAeya2JqnNoA+9ypok+HZxw4E=;
        b=AEm8nWzXwftK0kVND1F1LyMXlNsFNxJ0usQM0C9OTq2+85/nVwIPjnM8kGGYSHzq64
         fQ+3i50Zqho1SmliCxjachmAwyF6m/w1Uobc6DhF4+XG4QK9wdaGNnwyWmQPTiAZz7PD
         M6zH0wfOxtsCLtZhYJ9dG2NaWjo3UxE0JnmZx0GAXzFvz0yEuG4/kDhxcO4joc2k7bp/
         ip34PnWyiWo0asWlb4X41ktSkGgTe/iQr7gAs+0hwb8h8gkDGHRR3Xrum2EBkK8lxoXb
         8L1NrJiHhy+PTlcKj/EsicNDhYdXsHYRvJ2AATCjEeNp41ib3GJVl0QZCAKCD1kWjppD
         MMKA==
X-Gm-Message-State: AOAM531bfMYscQa4v0MIDwmxGNmlygFZow+0b3t8EFcaSC6kq2UNEDhG
        1bTAC5lnUkDSvOWJu6Ys7OqN64PI7Gs=
X-Google-Smtp-Source: ABdhPJzvSNUz+BjYN96D56gSBVdKj5WmEsq3z4WDVZSsvyVATNNWyCTeyIKFkN2azoyVGeYOSxwY9w==
X-Received: by 2002:a50:f0d4:: with SMTP id a20mr4718197edm.303.1605304397552;
        Fri, 13 Nov 2020 13:53:17 -0800 (PST)
Received: from localhost.localdomain (94-21-58-64.pool.digikabel.hu. [94.21.58.64])
        by smtp.gmail.com with ESMTPSA id b15sm5070840edv.85.2020.11.13.13.53.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:53:17 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t5310-pack-bitmaps: skip JGit tests with SHA256
Date:   Fri, 13 Nov 2020 22:53:07 +0100
Message-Id: <20201113215307.20855-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.29.2.612.g41c40d3f73
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 't5310-pack-bitmaps.sh' two tests make sure that our pack bitmaps
are compatible with JGit's bitmaps.  Alas, not even the most recent
JGit version (5.9.0.202009080501-r) supports SHA256 yet, so when this
test script is run with GIT_TEST_DEFAULT_HASH=sha256 on a setup with
JGit installed in PATH, then these two tests fail.

Protect these two tests with the SHA1 prereq in order to skip them
when testing with SHA256.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5310-pack-bitmaps.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 8318781d2b..1d40fcad39 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -277,7 +277,7 @@ test_expect_success 'pack with missing parent' '
 	git pack-objects --stdout --revs <revs >/dev/null
 '
 
-test_expect_success JGIT 'we can read jgit bitmaps' '
+test_expect_success JGIT,SHA1 'we can read jgit bitmaps' '
 	git clone --bare . compat-jgit.git &&
 	(
 		cd compat-jgit.git &&
@@ -287,7 +287,7 @@ test_expect_success JGIT 'we can read jgit bitmaps' '
 	)
 '
 
-test_expect_success JGIT 'jgit can read our bitmaps' '
+test_expect_success JGIT,SHA1 'jgit can read our bitmaps' '
 	git clone --bare . compat-us.git &&
 	(
 		cd compat-us.git &&
-- 
2.29.2.612.g41c40d3f73

