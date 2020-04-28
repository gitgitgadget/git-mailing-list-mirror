Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E615C83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF7520737
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 10:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiIII3AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgD1KxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD1KxT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 06:53:19 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06693C03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 03:53:19 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f8so8230357plt.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfTLxPUjVx3SGdliiAClev868/pywPFGiDsywRIhhbs=;
        b=RiIII3AU71DzvktiskBzH7oj9uMjgCSdXkxwaXky0jPxK/92XITgbcEljgw+Fy+HrB
         wqXwHMooD/EKnuPijtUiVNLPaozckEEB5rtZQmRFxrrwPtxsxMm9Zx24I2CwDRRfOtF8
         z4s+/7eut8PcJcgA+diOko9jgvRJh+mE2p/f6QzALpLaQRffVeHErKCmYMxEnWhFYqxB
         g3RL3q0nLCEbpZQhHkqXP4jPgVHUatgDYqjc07hzor6KNSW+Pz5EmzvG3QXVSzPJRXuq
         27LNEXrAWkE4IeB8viA519+VGQOs/VgLgsUqGKDE8pLcIoJ9Hjbdfl7dBpMPBrJ9LV7j
         VxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfTLxPUjVx3SGdliiAClev868/pywPFGiDsywRIhhbs=;
        b=DsGkSieL6v/WzEpr3HUNeuhZ17nOR3W9lAKm4KXxFID6XAERUx7DTqcYCv5cYjIdEU
         tp55lHtiXaiOX7TGmurQuQgR5Q9g20zxZGn/VqHAgBk449BNdExY8gQzW9hwcDYo2glX
         e/nGfMo0qNFSXONuaPjqQW/EBkPcJNO/nUus8+QNVQn8MvBIuCUaiM2/UQjjIoPVqVcY
         zNqaKuh0ClfVssMl2Ijzj93PuUxve4LdqQ6NuI/Wrfa0EMgHjmbSToEPuyZ9Wjr9oLE+
         E1o1eZmHabOA9OjJapRyJQEC+EjyqslHtE64100je76tbOC8BYCa0YCw3qyYpm/UXvuQ
         sPhA==
X-Gm-Message-State: AGi0PuYzl72ZHBY24gwEP+OHxz155pHIFEEKQJsTO7WjlAPpanh1cacs
        elnMMud9KjxEWwEKPZIgxOJlce3tsHo=
X-Google-Smtp-Source: APiQypKX2XOfABL+KuvgpsnG1Ys2GEKD5R6XqrbpVYBECVY+B102Dhqfea/wQw/EVsxEu1V4aLqfMg==
X-Received: by 2002:a17:902:9697:: with SMTP id n23mr1193743plp.150.1588071198318;
        Tue, 28 Apr 2020 03:53:18 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e11sm12513436pfl.85.2020.04.28.03.53.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 03:53:17 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v4 4/4] credential-store: make sure there is no regression with missing scheme
Date:   Tue, 28 Apr 2020 03:52:54 -0700
Message-Id: <20200428105254.28658-4-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
In-Reply-To: <20200428105254.28658-1-carenas@gmail.com>
References: <20200428104858.28573-1-carenas@gmail.com>
 <20200428105254.28658-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c44088ecc4 (credential: treat URL without scheme as invalid, 2020-04-18)
made scheme (AKA protocol) mandatory so make sure that still fails.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0302-credential-store.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 4e5a73cb99..7c7a48303f 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -135,4 +135,21 @@ test_expect_success 'get: store file can contain empty/bogus lines' '
 	EOF
 '
 
+test_expect_success 'get: ignore credentials without scheme' '
+	echo "://user:pass@example.com" >"$HOME/.git-credentials" &&
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=askpass-username
+	password=askpass-password
+	--
+	askpass: Username for '\''https://example.com'\'':
+	askpass: Password for '\''https://askpass-username@example.com'\'':
+	--
+	EOF
+'
+
 test_done
-- 
2.26.2.569.g1d74ac4d14

