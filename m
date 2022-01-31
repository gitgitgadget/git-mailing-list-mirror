Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69605C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 23:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiAaXwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiAaXwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 18:52:24 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA287C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 15:52:23 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id m25so12731875qka.9
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 15:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zjTT9niCvwqiBZexovkhFRTtH005HJZTASGI3+mum4=;
        b=0eOtE3NcnIJeJzypmkE3HG8yjgzohFpvMZp1ZHz+o+ZDtBjS1dhFliYSC/ni9gbr6t
         J7d5DVm0lZ5roeARFDW0MPzOP72r+Fs7ew6frZ5gM1gZ9la15/p3ibIQl/X2X5ePcpMp
         NWNnIIXiowipywAVBRAzQiF+VAP/XswQU7j9uZww7ahZxDZNvUZ564jM55IKCgksPoGl
         7NjXho2ousiFgSOYWQ7K5j0p9KtLESg966TeGYZDPpZKMEie7zYjh84TOTodUKtEQ7tK
         Ian3qJ4uN7oR2ZRSjHGxIKMRmcBrZ/pT3peRb+PXJ6SGvKCeeQnLJTNPbDr53A57mr7N
         ZV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zjTT9niCvwqiBZexovkhFRTtH005HJZTASGI3+mum4=;
        b=FwdQaAQ33HsPFkOjB2R9vhl4Ve+Xo7Q8cYSE4pRs1CpwddBudWi0EDLX3I8rgZdW3L
         XdR3mXHBXT6vAoRXxZ8UnrMb3nHyD5u9q1S+ME45tTgyutdXuk9jAgryj8fS8L4udx4t
         Nch3HJGnJvWwfsdubb9SlwcWFRPpVAVX55CNSONOVdsFR2ULFfIuyPcovhffqOO9/nZo
         lmKlCn5APclgvwTFJhAKWoE7m+lE6OadwPATYIKQsH1FQZWujtzB/paUgGoiI/p+WbvL
         JijUoYMfsHN21rXIO2k4VJ/rDwDy/PJWk1YGP8KmLvULrTWCv8BoN/DOVAvzXI5V0U78
         GjiA==
X-Gm-Message-State: AOAM531T4f9kK+NKYg4qs8XIAjv1lmd+8opOber0OWnl7CR3UUkb/OgU
        Ls+kOHl4Sw1uKSXkgUaeS+d1DvhNyTeDng==
X-Google-Smtp-Source: ABdhPJxRiQJuxwEt/PBBo1ebWmMqL6Pu1aQfsit0uWd6thguor/yt4/Pi5HSO3yxf/KNqnZfPvS6rQ==
X-Received: by 2002:a05:620a:cc5:: with SMTP id b5mr14895657qkj.624.1643673142690;
        Mon, 31 Jan 2022 15:52:22 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id c14sm7993338qtc.31.2022.01.31.15.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 15:52:22 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V3 1/2] patch-id: Fix antipatterns in tests
Date:   Mon, 31 Jan 2022 15:52:18 -0800
Message-Id: <20220131235218.27392-1-jerry@skydio.com>
X-Mailer: git-send-email 2.35.1.6.g61799e0acb
In-Reply-To: <20220131232529.8484-1-jerry@skydio.com>
References: <20220131232529.8484-1-jerry@skydio.com>
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
V2->V3:
- Quote the EOF marker

 t/t4204-patch-id.sh | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 80f4a65b28..a4b8f2b9ca 100755
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
+	cat >nonl <<-'EOF' &&
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
+	'EOF'
+	cat >withnl <<-'EOF' &&
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
+	'EOF'
+	calc_patch_id nonl <nonl &&
+	calc_patch_id withnl <withnl &&
 	test_cmp patch-id_nonl patch-id_withnl
 '
 test_done
-- 
2.32.0.1314.g6ed4fcc4cc

