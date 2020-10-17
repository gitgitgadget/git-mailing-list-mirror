Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FFAC433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9100A2073A
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juh1PVEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437532AbgJQH4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 03:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437522AbgJQH4H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 03:56:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEDEC061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:56:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f5so2827260pgb.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F9M+sC/fUMUcK8OC/Q0UqFPEUFeZngOB95nFh6yS8UA=;
        b=juh1PVEKJLVpLQgpoQoNkDh3AlWJqmEkVTblPDvu6uiwTPSwKf3ZO+GFiPqOxwrrjz
         dVQqq4tqYew9vvA1RiJBAKXf4cg0T5mpb9xewILDW0BItk48wKFw+LYsd1QoMixfDR//
         yqfci3ajYAVa2OTTGW2SjCbHi+N804s99Wjyec6i+W+A7diWUt6JJ+An1p33M52/LJdQ
         qoZ9YduE8yYMCtExaP0Z3KIaAZU7jjaVfQaznpDQPDjLtm58YvDtpNc76o/ZGUlO2ScY
         0nEL7zm1+Bt7IRZZMlAi9FqDE2Sgc6N0wqj2dG2hVOpuL1mBeTaO9xLX5jPNtPI+1OIM
         CG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F9M+sC/fUMUcK8OC/Q0UqFPEUFeZngOB95nFh6yS8UA=;
        b=Xo7JYQsSI9FpiAcRRuAShs7MhldK/jsKshsNV4Q0pIqhEaepbhNLltH8Tjxv62Xe4W
         USc3XrckPSGnRLKv1N8UybNyZDlhRRgmnIABnEyIqYd4+K0bHvEhiE4Gpkn3VKFTTWxg
         NWD6a2+zzOWapoezEwniS5P8fgax9KfYx/29Kya3kVKEeDz/Dy3Q88A6qIiaPXOGEFaN
         dpIYa2RGeiXfUXbJCqPgjNBfyfynt6h3Hi5SbjMNSHxAFpZrRvnKAxLHNLnuofi+HJjL
         8tfa0YjZDnsSQMrROFO6UenZ66o724juIAXAXan9w3sKmvYgJr7kEm9s+KUCUMUyek9y
         Yt0A==
X-Gm-Message-State: AOAM533IWRcflhiOIsTv7bbIwlAk9VKlqyHVicY9mYdL4Ugc4/NvJWtZ
        bQP+31OTfD8Rz0svdVF5/Jx87N0oNyDr0Q==
X-Google-Smtp-Source: ABdhPJx64q/Oo8NUWxH9n1GjqNxMBIF4cJE3/xPQ/O3ctU068YBwoK3S5awIWrFGjM2JlM7zy/sOvA==
X-Received: by 2002:a62:8389:0:b029:152:416d:f026 with SMTP id h131-20020a6283890000b0290152416df026mr7857105pfe.64.1602921366687;
        Sat, 17 Oct 2020 00:56:06 -0700 (PDT)
Received: from localhost.localdomain ([106.201.2.128])
        by smtp.gmail.com with ESMTPSA id t2sm4994162pji.12.2020.10.17.00.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 00:56:06 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        sunshine@sunshineco.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 3/5][Outreachy] t7102,t7201: remove whitespace after redirect operator
Date:   Sat, 17 Oct 2020 13:24:53 +0530
Message-Id: <20201017075455.9660-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201017075455.9660-1-charvi077@gmail.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
 <20201017075455.9660-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to Documentation/CodingGuidelines, there should be no whitespace after redirect operators. So, we should remove these whitespaces after redirect operators.

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7102-reset.sh | 30 +++++++++++++++---------------
 t/t7201-co.sh    | 10 +++++-----
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 2b4cfb2c83..a8c96bf162 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -70,15 +70,15 @@ check_changes () {
 
 test_expect_success 'reset --hard message' '
 	hex=$(git log -1 --format="%h") &&
-	git reset --hard > .actual &&
-	echo HEAD is now at $hex $(commit_msg) > .expected &&
+	git reset --hard >.actual &&
+	echo HEAD is now at $hex $(commit_msg) >.expected &&
 	test_i18ncmp .expected .actual
 '
 
 test_expect_success 'reset --hard message (ISO8859-1 logoutputencoding)' '
 	hex=$(git log -1 --format="%h") &&
-	git -c "i18n.logOutputEncoding=$test_encoding" reset --hard > .actual &&
-	echo HEAD is now at $hex $(commit_msg $test_encoding) > .expected &&
+	git -c "i18n.logOutputEncoding=$test_encoding" reset --hard >.actual &&
+	echo HEAD is now at $hex $(commit_msg $test_encoding) >.expected &&
 	test_i18ncmp .expected .actual
 '
 
@@ -387,25 +387,25 @@ test_expect_success '--hard reset to ORIG_HEAD should clear a fast-forward merge
 '
 
 test_expect_success 'test --mixed <paths>' '
-	echo 1 > file1 &&
-	echo 2 > file2 &&
+	echo 1 >file1 &&
+	echo 2 >file2 &&
 	git add file1 file2 &&
 	test_tick &&
 	git commit -m files &&
 	before1=$(git rev-parse --short HEAD:file1) &&
 	before2=$(git rev-parse --short HEAD:file2) &&
 	git rm file2 &&
-	echo 3 > file3 &&
-	echo 4 > file4 &&
-	echo 5 > file1 &&
+	echo 3 >file3 &&
+	echo 4 >file4 &&
+	echo 5 >file1 &&
 	after1=$(git rev-parse --short $(git hash-object file1)) &&
 	after4=$(git rev-parse --short $(git hash-object file4)) &&
 	git add file1 file3 file4 &&
 	git reset HEAD -- file1 file2 file3 &&
 	test_must_fail git diff --quiet &&
-	git diff > output &&
+	git diff >output &&
 
-	cat > expect <<-EOF &&
+	cat >expect <<-EOF &&
 	diff --git a/file1 b/file1
 	index $before1..$after1 100644
 	--- a/file1
@@ -423,9 +423,9 @@ test_expect_success 'test --mixed <paths>' '
 	EOF
 
 	test_cmp expect output &&
-	git diff --cached > output &&
+	git diff --cached >output &&
 
-	cat > cached_expect <<-EOF &&
+	cat >cached_expect <<-EOF &&
 	diff --git a/file4 b/file4
 	new file mode 100644
 	index 0000000..$after4
@@ -460,14 +460,14 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 	git diff-index --cached --exit-code HEAD
 '
 
-cat > expect << EOF
+cat >expect << EOF
 Unstaged changes after reset:
 M	file2
 EOF
 
 test_expect_success '--mixed refreshes the index' '
 	echo 123 >> file2 &&
-	git reset --mixed HEAD > output &&
+	git reset --mixed HEAD >output &&
 	test_i18ncmp expect output
 '
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b527f8009c..74553f991b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -33,7 +33,7 @@ fill () {
 
 
 test_expect_success setup '
-	fill x y z > same &&
+	fill x y z >same &&
 	fill 1 2 3 4 5 6 7 8 >one &&
 	fill a b c d e >two &&
 	git add same one two &&
@@ -55,7 +55,7 @@ test_expect_success setup '
 
 	git checkout -b simple master &&
 	rm -f one &&
-	fill a c e > two &&
+	fill a c e >two &&
 	git commit -a -m "Simple D one, M two" &&
 
 	git checkout master
@@ -95,7 +95,7 @@ test_expect_success 'checkout -m with dirty tree' '
 	git clean -f &&
 
 	fill 0 1 2 3 4 5 6 7 8 >one &&
-	git checkout -m side > messages &&
+	git checkout -m side >messages &&
 
 	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
 
@@ -159,7 +159,7 @@ test_expect_success 'checkout -m with merge conflict' '
 test_expect_success 'format of merge conflict from checkout -m' '
 	git checkout -f master && git clean -f &&
 
-	fill b d > two &&
+	fill b d >two &&
 	git checkout -m simple &&
 
 	git ls-files >current &&
@@ -182,7 +182,7 @@ test_expect_success 'format of merge conflict from checkout -m' '
 test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 	git checkout -f master && git reset --hard && git clean -f &&
 
-	fill b d > two &&
+	fill b d >two &&
 	git checkout --merge --conflict=diff3 simple &&
 
 	cat <<-EOF >expect &&
-- 
2.29.0.rc1

