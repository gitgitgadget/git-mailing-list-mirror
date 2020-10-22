Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D0CC4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 07:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0488022248
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 07:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2wX9cEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508379AbgJVHT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 03:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506116AbgJVHT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 03:19:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE73DC0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 00:19:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id p21so531596pju.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDMYDGtL9z8GD6okf4rweNFAQdtPwiH4ATiFWRnpQp4=;
        b=r2wX9cEkCfy0lY1/WFLwINTvpYVn/MyH/qPi95FkbU1vwi6MYBM5Sk0YngwMwVSpwn
         z41TlmPKdRjpCLzsZiBo53KqHNL1V3u07rpMlNYlRbDw98wZl3WmlhqFVNDuMl+fzUkO
         aK0kAq1OLeNX3aqAnl6W8LaXJgC2J5bkmsOYdGAphETSYDde76QBMwq0J/ERxnKUTHWE
         41p7T7mVgq9kKlmdWFMwuz+T4x1e5/wQnCeBuNWtvZpm/aM8LInkrmWaYsdKTQjP+U4w
         VkZoXQlNT/CvHxNOeVwan33qJe0INYDTgq79b2g+sqVj9y9wYO3poGmMimoh1RPrdhwM
         5dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDMYDGtL9z8GD6okf4rweNFAQdtPwiH4ATiFWRnpQp4=;
        b=o9OQzxaFZKFZLvRWlpWgF4kTa4nqPI7sQPJvLX/xWV5mKwgpkJlZjyzxxf57S9k3yc
         EMF6r8+n2MIPNaeAsUyryFyAXPpUGn6hY6+h6TsUXrythZCJtWEr+Bjtlp3tKvKtG6Vc
         KZTjUUoG+r7bpFNHw2T/CivMXrxeRimkDvjEMRhAaNE4j+QQcG6dbk8pmXGGo1822fa5
         cicB20PMnMY1owOlNoD+XZimVqVqfkZlPUa8pJ1ISjQ5EaAcHsBUEoxyBkoEpldgXoa0
         2WHKbZUqiCStqgB+r2dNCv7DpXlyar+nqEV+lPChexhCj0weyki9JnrKj+FxmfSDaXQ0
         I1XQ==
X-Gm-Message-State: AOAM531r0/7mtE9nLFKHFeUTf3fe45YcgSSBxDHJXyZRa8UAP7Y//d24
        FFj+XxquCsLMNjA1xOAObfJxy74/uNjh/Q==
X-Google-Smtp-Source: ABdhPJwLG0VNhcraxcGZce0zC1lwH9DkUMLhGZsS9VYN2iAuPWJd1n1ZshYxOPvbFQ1ygrluBdwN/g==
X-Received: by 2002:a17:90b:3114:: with SMTP id gc20mr1084000pjb.73.1603351198321;
        Thu, 22 Oct 2020 00:19:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:4050:2e84:4e7a:290b:4332:f03e:69aa])
        by smtp.googlemail.com with ESMTPSA id 78sm1030004pfz.211.2020.10.22.00.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 00:19:57 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
        phillip.wood123@gmail.com, sunshine@sunshineco.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v6 3/5][Outreachy] t7102,t7201: remove whitespace after redirect operator
Date:   Thu, 22 Oct 2020 12:46:48 +0530
Message-Id: <20201022071649.24284-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201021124823.2217-1-charvi077@gmail.com>
References: <20201021124823.2217-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to Documentation/CodingGuidelines, redirect
operator is written with space before, but no space
after them.

Let's remove these whitespaces after redirect operators.

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7102-reset.sh | 32 ++++++++++++++++----------------
 t/t7201-co.sh    | 10 +++++-----
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 2b4cfb2c83..3d190cad0e 100755
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
+cat >expect <<EOF
 Unstaged changes after reset:
 M	file2
 EOF
 
 test_expect_success '--mixed refreshes the index' '
-	echo 123 >> file2 &&
-	git reset --mixed HEAD > output &&
+	echo 123 >>file2 &&
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

