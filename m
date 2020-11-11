Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C1BC56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369A720729
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 09:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIQoiChB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgKKJyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 04:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgKKJyj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 04:54:39 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E59C0613D4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 01:54:37 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id s13so1725147wmh.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrzWrEWx/RjllY59x4FGiolMkU1vbSsaMQRhQh+EH4Y=;
        b=NIQoiChBO7vuuF5LTxSXMEsmcX4laaznEsE8ss8j8Iqz2H5mJmRGRXTHyyJONRhiBa
         jYx1vzHizWdjGvuZy13Hd/heaiKHK6Mldg83OeELrtLvx+3Osz7AijmOD6DM7mreW1Hg
         /EhRkrSRbMyWuyXAfd6Ub1OcznZ9zVDaq/RzjypsARwUNxLb6a0RYFFE2Ojfs4wlMPbA
         OOmJ6SGXD4SKndz/I9TYVWVssd64uEadATIP+FMkxZCXL6oO2OmWB6CfYGMK3amAFCGl
         rdhpyZvcdbpH1dINpGGHfcjwQK2RuXUQ9XiNMDGeGMBg6U45fbzgMdCzcihCwLRTbQ3b
         eKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrzWrEWx/RjllY59x4FGiolMkU1vbSsaMQRhQh+EH4Y=;
        b=EjwFH8Mm9S5k5zwMMKS5Iy3kzDOum2eKvh+AAlqNulQ/aW37tO6sohSP664V8a3+y0
         enUh6tfkKyy3Y1VI/PSd2Ivdi+QJVhdDifhw4slOaBivDpbpkx6TYZPhJU1rr/QBgbgK
         XppC6lJfjjqcARkMIG2TVx/n0OfNxcSIj0qjJVIjfEM1qTkFpj9TK0ZC/xslE0wmE110
         4eWNoybZ/0kah/SUY+RE7El7/DLjeyDAV0u0+CtAPV9mW6sLzEkukl5WVEwHhljLmFEm
         y9FGblso0eEBqU/NDggHxrCj79Z7Lmgovlia9FckjhMJ+KcXsTbQShMHyWa8Ey/1h5H0
         i4Dw==
X-Gm-Message-State: AOAM5324S5GlbWmzii0lQr1OjunDavuFsF6csM2eDLOLYLjkK37cRQdp
        Og8VrfsRgfqCCOW1YhEabJb8c4zyZCYBQA==
X-Google-Smtp-Source: ABdhPJy56m6CldN2vZr1cVX4lYEdk/n3SXSiAmKRS7CVzINl41+OdZyqwNzv9vbtKtjz7M2hDo+oWA==
X-Received: by 2002:a1c:b157:: with SMTP id a84mr3072767wmf.34.1605088475754;
        Wed, 11 Nov 2020 01:54:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g131sm1983374wma.35.2020.11.11.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:54:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Knight <james.d.knight@live.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] config.mak.uname: remove unused NEEDS_SSL_WITH_CURL flag
Date:   Wed, 11 Nov 2020 10:54:20 +0100
Message-Id: <20201111095420.1446-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201111095420.1446-1-avarab@gmail.com>
References: <20201111095420.1446-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The NEEDS_SSL_WITH_CURL flag was still being set in one case, but
hasn't existed since 23c4bbe28e6 ("build: link with curl-defined
linker flags", 2018-11-03). Remove it, and a comment which referred to
it. See 6c109904bc8 ("Port to HP NonStop", 2012-09-19) for the initial
addition of the comment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.mak.uname | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 8d7b96f8b9b..5b30a9154ac 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -541,11 +541,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# removing the directory at OS releases J06.21 and L17.02.
 	# Default to the older rm until those two releases are deprecated.
 	RM = /bin/rm -f
-	# As detected by './configure'.
-	# Missdetected, hence commented out, see below.
-	#NO_CURL = YesPlease
-	# Added manually, see above.
-	NEEDS_SSL_WITH_CURL = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	HAVE_DEV_TTY = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
-- 
2.29.2.222.g5d2a92d10f8

