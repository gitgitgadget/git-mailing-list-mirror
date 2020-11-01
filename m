Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACFBC2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E42208B6
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPb6/Zge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgKATel (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbgKATeS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:18 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E704AC0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:17 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id x6so12679022ljd.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iPZBgNe/CnnTJLkmODqda//1HtZVycy3DAT/Qha+4cE=;
        b=UPb6/ZgecXldo7P2rChHr+0rsChqy7e/sl++TlUhzbDf9TTF9VWxkKXmm5yYPJErRr
         Gbo5ClAK7N57v5psPj4NvYQuuDIKO7IwNIPxLqKzqYZEyhqoTYMchZliihE0xaLDW4M6
         H5gk83wuOnGdF85mhBJmIOEa7ycR/bXo4Qr+vZsjpoRNs5pJWR8pqIeAqIwb7V7GxtDg
         RxpsZW6BDos33UYn3auGCfdZaAz5I4vgcHFgOUyEuAhHkxZeRLD6YOwz6fgTjS50sh3T
         C0SmnvoU2qKXwv353hSr3LN6e8qvpnmL8wE07TH0rh5/hVSLfMroAYxEaeGUqzKf7xEB
         Tkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iPZBgNe/CnnTJLkmODqda//1HtZVycy3DAT/Qha+4cE=;
        b=IvAibhVoqHLOwIeVuKyAULUhYgMgMh82NTBAFbHSzp4UbM6VB7FFhGTb+hJXp20nyH
         HkHwNf4LewFY/olWh0MCkhNtmvbKzMXRvP/MYiUxcsj/ZgXq/N//Pd7gdXuSpnGkSvtA
         h75fwDeyKNQefWw3s10XwhjEj3+82HGLnXsfwqmrc++RTkQqe8rhC/sE3wgfeZJcOisF
         0iUuBA8O1CPITVYf08kdI9tSphNhY14fXM2/+ZGZWz/MlPWKrWVoh9hq60hGWc/6/AQA
         HOZOpqThqbw3GJP31YMVwn4aCWKE4rOMRdFqoBZGIH6k9PvfGR3hLPlik6UPMvl2xKoE
         kNGQ==
X-Gm-Message-State: AOAM530HjaNm0KJpWfR22JEB9C+CsoRkQ72CPCjJgSkHSsqTy8v/eWE3
        kv2+Z79/rW1YMnh3XM+lGF0=
X-Google-Smtp-Source: ABdhPJyXKBiqNBz6AZf7JlXIjVRzYehuHYH+xAe2mSdTy4lV8xhcNV2YUlFgETiNhpK8Jl7Mf9VOfA==
X-Received: by 2002:a2e:8750:: with SMTP id q16mr4824940ljj.53.1604259256504;
        Sun, 01 Nov 2020 11:34:16 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:16 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 14/26] t4013: support test_expect_failure through ':failure' magic
Date:   Sun,  1 Nov 2020 22:33:18 +0300
Message-Id: <20201101193330.24775-15-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support to be able to specify expected failure, through :failure
magic, like this:

:failure cmd args

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 t/t4013-diff-various.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5c7b0122b4f1..935d10ac0572 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -174,6 +174,7 @@ process_diffs () {
 V=$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
 while read magic cmd
 do
+	status=success
 	case "$magic" in
 	'' | '#'*)
 		continue ;;
@@ -182,6 +183,10 @@ do
 		label="$magic-$cmd"
 		case "$magic" in
 		noellipses) ;;
+		failure)
+			status=failure
+			magic=
+			label="$cmd" ;;
 		*)
 			BUG "unknown magic $magic" ;;
 		esac ;;
@@ -194,7 +199,7 @@ do
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
 
-	test_expect_success "git $cmd # magic is ${magic:-(not used)}" '
+	test_expect_$status "git $cmd # magic is ${magic:-(not used)}" '
 		{
 			echo "$ git $cmd"
 			case "$magic" in
-- 
2.25.1

