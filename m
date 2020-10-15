Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0CEC43457
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09EEA22261
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+GmkN9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbgJOR6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730574AbgJOR6T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:58:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC68FC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:58:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y1so2024707plp.6
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77IOcX7TntEQz1EZOENIL5Guj44tdQ8HVMocOOKQpCA=;
        b=I+GmkN9j+PdNDTRRKjIzTC8VuPzQYluR4ef/XYGOt7uoC2nQnfwf7ub0d0foMnGaoZ
         v1XcCUp15Z70StQHo59hKCrsbQBegoJ3yI2QKpduROw5b1U2gUomiz7K7dgBSuw60VO2
         QQfNtzS8ZQa7xgj09kyioIsHz2hfjoxrfGoFb4/ivsXGzzlDAaZYsqhvySL99dtxVFr/
         DP1jzc5BY/+2pigC/GtemsI2isX118LlOXQzIfHD2Gd2C/OTv5n70Q0mqPVKbRfIytrN
         +TG1qaarHFnCZYoXOQ1evTUvOU/BuJTyfVz6+4m+Xr3IbWBsf9HRch5DNOztcqULKQAL
         RcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77IOcX7TntEQz1EZOENIL5Guj44tdQ8HVMocOOKQpCA=;
        b=ZfqWL+rWDa9WGLYdEQlyWXCCLWDJ8hjCf18WIkQBuRoKbG3/VkxY3JBlxul9TWYHq1
         Y0sjshf9fCTxugoYoTG36I79+5ODlr1kM0ww7O+iappV18Qa2x8ppT+8aeKpG3R4XsNF
         3DyFzOPp0tofZo/n4V1ai+ukEJA7jgIhF5m2CeOHfYbNaXMMARv6wSQ/Z9u9r9mOsOnl
         nTjQAX3H8P67qNap34YikG8+UZG9mhtN8UHlL1MmWnSgZYCPNlo6uBM7KXbO6V090aYZ
         n6qeibtkyZf9kUvr7zCv7eJ5INlkvquer7L95P/rVZK1MGr283A1bM7Q7J9Am0unMN3f
         0R/Q==
X-Gm-Message-State: AOAM532NqAl9tONoAGnpUrqX0ApUbNcS+J0BCP7HEnqXWxePp7zLhPrl
        0i0b0uz1/dssUz/cPlIJqkis9uhKVyou0Dbq
X-Google-Smtp-Source: ABdhPJxHJAAf+Mi7RurcFxk5P1wSEFwhuq3FM1yB2ajRzDhPMjRnc6rZ1Cl0Z70xqjFLKrZ+got7Rw==
X-Received: by 2002:a17:90a:ec13:: with SMTP id l19mr40485pjy.51.1602784698124;
        Thu, 15 Oct 2020 10:58:18 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:1309:c8:79e1:6677:5d35:9a95])
        by smtp.gmail.com with ESMTPSA id n139sm3945930pfd.167.2020.10.15.10.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:58:17 -0700 (PDT)
From:   charvi-077 <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        sunshine@sunshineco.com, charvi-077 <charvi077@gmail.com>
Subject: [PATCH 3/5][Outreachy] t7102,t7201: remove whitespace after redirect operator
Date:   Thu, 15 Oct 2020 23:27:07 +0530
Message-Id: <20201015175709.20121-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201015175709.20121-1-charvi077@gmail.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to Documentation/CodingGuidelines, there should be no whitespace after redirect operators. So, we should remove these whitespaces after redirect operators.

Signed-off-by: charvi-077 <charvi077@gmail.com>
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

