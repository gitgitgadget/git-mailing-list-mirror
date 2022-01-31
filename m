Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36080C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 23:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiAaXZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiAaXZe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 18:25:34 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6E4C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 15:25:34 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id g11so14422848qvu.3
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 15:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DvLTtx+h3I71MZeU5JxwErqfaP/UAXjZzw2Dzf6Mbds=;
        b=tRuF6P0WVyhAjLDTsDN56AEs77y+th110231uwf1PMs0fDyegtgnrtUJL5yyC1COQG
         RDPAvl6ZZLNcR0rppQzNUn9WoAwoF+iwLQEV+CPyP7guj88zdoWGzS9aGHZ7JtIJSjl5
         AHHVChoeap+jVQhMioxHN47z7ugNpXLmhOc4cnh0Gj5WvjS0x4yfCvwXgh/hWsbaLA+X
         dd34PTNp6V6JS5om0tPtgpCa+TdZGSJP/2TvlA9pRgSTpYRNK5tI3pxdUwurDqIqoPeS
         RxjYoAOwVqrHbLWt2QQuOAn1s6tp4eF5SaWC9aJPaEpMxbMsrPeZPoXrlJcOtZb9ORvB
         VMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DvLTtx+h3I71MZeU5JxwErqfaP/UAXjZzw2Dzf6Mbds=;
        b=4mC1mN+9cBKJEUSMDruN8s3J16tZD4YwDGz3qt1rz5OxYGQ5//KcJxxvhJg/m9EskY
         kizjlkbx8lTwrB/lyM/+91gmjUP4dh0sryMBoTAegnDsIiUIwJodQc5mRQa7yreZJZGA
         Y5W96BOAEQAQ3fVJC32GPSVgzjFcaM1XN9UtU3maXg2W3VfI5+Rhl8l6CcIhiWMQMHPJ
         Vsl6cL0q2HN8wi+YSdK9FCbuMYZDTpm4glbHcdWo4z38HjSITmeTm8aEazbV0SVAZhZs
         dYywez4T/VVSAESHRBMZsJcM+DdY8UplWiuEm+ciPL0LX57opdv+0iSl9tf7xpt1HAhv
         bz0Q==
X-Gm-Message-State: AOAM533RyP3Ds06HHSLCMHz9VfjKxvTGY88zZrMaCxkChm0Hdthi7lZg
        VGMdMriWCwGiabM+qUOxBPowA/Gm431CNg==
X-Google-Smtp-Source: ABdhPJyWLYTl2DNhyrLgizNpsmlyDkQ8W40L8O+PHTnx1VtbEMa5nNlHUrxbboKe4E6/D6khn/SZVA==
X-Received: by 2002:a05:6214:623:: with SMTP id a3mr20618099qvx.122.1643671532913;
        Mon, 31 Jan 2022 15:25:32 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id br30sm7890495qkb.67.2022.01.31.15.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 15:25:32 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V2 1/2] patch-id: Fix antipatterns in tests
Date:   Mon, 31 Jan 2022 15:25:29 -0800
Message-Id: <20220131232529.8484-1-jerry@skydio.com>
X-Mailer: git-send-email 2.35.1.6.g61799e0acb
In-Reply-To: <20220131232318.8248-1-jerry@skydio.com>
References: <20220131232318.8248-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up the tests for patch-id by moving file preparation
tasks inside the test body and redirecting files directly into
stdin instead of using 'cat'.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
V1->V2:
- For some reason I put format-patch in the commit text when this
change is actually to patch-id.

 t/t4204-patch-id.sh | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 80f4a65b28..da60f5b472 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -164,42 +164,40 @@ test_expect_success 'patch-id respects config from subdir' '
 		cd subdir &&
 		test_patch_id irrelevant patchid.stable=true
 	)
 '
 
-cat >nonl <<\EOF
-diff --git i/a w/a
-index e69de29..2e65efe 100644
---- i/a
-+++ w/a
-@@ -0,0 +1 @@
-+a
-\ No newline at end of file
-diff --git i/b w/b
-index e69de29..6178079 100644
---- i/b
-+++ w/b
-@@ -0,0 +1 @@
-+b
-EOF
-
-cat >withnl <<\EOF
-diff --git i/a w/a
-index e69de29..7898192 100644
---- i/a
-+++ w/a
-@@ -0,0 +1 @@
-+a
-diff --git i/b w/b
-index e69de29..6178079 100644
---- i/b
-+++ w/b
-@@ -0,0 +1 @@
-+b
-EOF
-
 test_expect_success 'patch-id handles no-nl-at-eof markers' '
-	cat nonl | calc_patch_id nonl &&
-	cat withnl | calc_patch_id withnl &&
+	cat >nonl <<-EOF &&
+	diff --git i/a w/a
+	index e69de29..2e65efe 100644
+	--- i/a
+	+++ w/a
+	@@ -0,0 +1 @@
+	+a
+	\ No newline at end of file
+	diff --git i/b w/b
+	index e69de29..6178079 100644
+	--- i/b
+	+++ w/b
+	@@ -0,0 +1 @@
+	+b
+	EOF
+	cat >withnl <<-EOF &&
+	diff --git i/a w/a
+	index e69de29..7898192 100644
+	--- i/a
+	+++ w/a
+	@@ -0,0 +1 @@
+	+a
+	diff --git i/b w/b
+	index e69de29..6178079 100644
+	--- i/b
+	+++ w/b
+	@@ -0,0 +1 @@
+	+b
+	EOF
+	calc_patch_id nonl <nonl &&
+	calc_patch_id withnl <withnl &&
 	test_cmp patch-id_nonl patch-id_withnl
 '
 test_done
-- 
2.32.0.1314.g6ed4fcc4cc

