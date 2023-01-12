Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D74CC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjALP1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbjALP0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:26:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5573DBDE
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:21 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u19so45509919ejm.8
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU4jBHEtq4H9yhR9G2IqRBDDwpi/YLVLgEkvmAz0yUE=;
        b=kN2GJG0Y0bY5v9Zf8pxFCHIxYejxAgGzmHHTy+AQGzyH0TibfzHG9HJJoPwLgBnybS
         CpE8uBie4Yfy3YpiayJOGYwv/Oh1h3X5QDypfaUX+PKsLGRNnsJZTnkv65+tnqr3UR+u
         W7KRKMn+aBGzRiyNX5dSs37ZXZGoqj3ym0yXj48LulM9nlXdfkeBUlM87BFpjqoMMK47
         m8amrlPESAYjW23jSUQHHnlEjvQbg1okU6DiTQhEfxrYZ4o9EElRN8/BhzdgO7JBVn8g
         jdXuSVTVfjhcZLoMbzkYzwprjNFIOL/uyNDnvNshGe8wRVxqtyGNNm5goVx7QK1O4Dz2
         3ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HU4jBHEtq4H9yhR9G2IqRBDDwpi/YLVLgEkvmAz0yUE=;
        b=K3gw8dGGvBr7mVFzyaDszIgPZnJhnpnfqEtUecteevECVIbbHm35EtX9beUi/JcsQT
         j7XltdzpthMEX92ppVESUSG4+HAhCLRshasuf5NKhyi7Hem+IRmJZEvH2L4qH5dG2wBQ
         03CVfDrBed/O8puFEHZ9a4cLn6P1HUT1+4UfA2RwA5JFE0EvCmEyvKjhKAh7NVogwtaO
         /KOoAna4YPT6r4Zf44C7+L7avil3tdS5q9vjKJTNL5y3P7tvMb5/ZKs1wX8kYvJRZSXi
         j1MbDS3ovKSZV/IwWYq1awgVAEed+f2Slm8cdvuVu3sou6C4+3Ja6eWetjtgQWKjrg4w
         Dckg==
X-Gm-Message-State: AFqh2kp3Y2gffcrQ17aIQ3JDbMkQKLiBBAznxxzuAJbhfo8v+lH0EIjO
        88EI9NXfmMHEe6CwUDvhphWFu2O7lIacUw==
X-Google-Smtp-Source: AMrXdXvyy4S9zldmD/lX6c6VN9Vsx5KxNkZg06ePWmAySpETdszQYV8R1Z9nniZ+smtRbieSustzfw==
X-Received: by 2002:a17:906:144a:b0:7c0:f908:79f1 with SMTP id q10-20020a170906144a00b007c0f90879f1mr75805648ejc.60.1673536759467;
        Thu, 12 Jan 2023 07:19:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id kr12-20020a1709079a0c00b0084d44553af9sm5493291ejc.215.2023.01.12.07.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:19:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] bisect: verify that a bogus option won't try to start a bisection
Date:   Thu, 12 Jan 2023 16:19:11 +0100
Message-Id: <patch-v2-3.6-0cfb7dc572c-20230112T151651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1215.g1ba3f685d4f
In-Reply-To: <cover-v2-0.6-00000000000-20230112T151651Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230112T151651Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We do not want `git bisect --bogus-option` to start a bisection. To
verify that, we look for the tell-tale error message `You need to start
by "git bisect start"` and fail if it was found.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 98a72ff78a7..9e56b42b5da 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1058,6 +1058,16 @@ test_expect_success 'bisect start with one term1 and term2' '
 	git bisect reset
 '
 
+test_expect_success 'bogus command does not start bisect' '
+	git bisect reset &&
+	test_must_fail git bisect --bisect-terms 1 2 2>out &&
+	! grep "You need to start" out &&
+	test_must_fail git bisect --bisect-terms 2>out &&
+	! grep "You need to start" out &&
+	grep "git bisect.*visualize" out &&
+	git bisect reset
+'
+
 test_expect_success 'bisect replay with term1 and term2' '
 	git bisect replay log_to_replay.txt >bisect_result &&
 	grep "$HASH2 is the first term1 commit" bisect_result &&
-- 
2.39.0.1215.g1ba3f685d4f

