Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17201C55185
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90A92074F
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="cs2T24yP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDWAZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDWAZp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 20:25:45 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338B4C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 17:25:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mq3so1665178pjb.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 17:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BsMesksq+kws7iugpFA7R2WbwjpfZXnMxzBZ6pol8ig=;
        b=cs2T24yPxx7K97yl6BQDwDUuTl8iWAxaSj/mRYFwAH3VPI14ycCB0/qUHhuCKldhIS
         syThZ/wLwuo2FlHbmEcy+qgqNPF+nNULVshsu6yGATjI0/0+NSUrvFtVjnBOiVAxGd8n
         l3o1siGqRZ+2Pi1HAq3DlL10n9XZGmcQLYrj/J5KY0z6GNCtPtIC/CsNxc0jv7XWHNH1
         e9EJZ49z15/71L4IOuT3IeqXRXFsPIPOr+l/n0UBabAXe7JVSOGpiGocEqGquNUco5GE
         HN9WklgJLKfo9406mgf8K1Kd2sI4QLBFB1oVmCuzM1t9MODlxruHDj53DqbUfp8jw4n/
         wn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BsMesksq+kws7iugpFA7R2WbwjpfZXnMxzBZ6pol8ig=;
        b=hKXZwW6pVEIclPl68ycnfFlExBO/kjPXDS8+6QWI+sCJwUtDmYzX+xAD++E6uxnnWb
         y80QNFJps758OCAN8ARUzH8TM5EiigiMrz/WfplKvMN2Kfs9O0W0ANg/7p1VEE0RLlOZ
         lAoozg092rlfAkLA4fPVMwJcyCYoU/q/0EVtQsKnfzNAxtM1gEDvIuY7isXOvJnYR4eS
         FdwYG7w7KzBKln4uF0SukaTem1qMxNz8/7U396Pp4g0kunVJ+jLIteucd0y23/vYIFT8
         SXjiPsmZTiWXYAmuMxYP3VNeCt20c6Lctq+Fa9vrJn5QSZNMURU8ITkwvmDnD4hBUi9G
         E88g==
X-Gm-Message-State: AGi0PubrR8GzwAlXyJ+hE2Bk9zl+b55YF+qsx0B8SF97dRtD4c9WsdEl
        AnptK9O7TJB/2H4m0iQG4glCwP5V1H6uvQ==
X-Google-Smtp-Source: APiQypJ3rOZ7t/kZnHKZpownAQ3fkQ+SZpB282DkI6SuLQu2QK2/m9WsiEtDEp3ZCbTs1Yf/WaecFA==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr1263038plq.173.1587601543308;
        Wed, 22 Apr 2020 17:25:43 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id i135sm391307pgc.8.2020.04.22.17.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 17:25:42 -0700 (PDT)
Date:   Wed, 22 Apr 2020 18:25:41 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, newren@gmail.com
Subject: [PATCH v2 1/2] t5537: use test_write_lines, indented heredocs for
 readability
Message-ID: <5c9217ad8fc594fbff46507c4be7961eb5a478e2.1587601501.git.me@ttaylorr.com>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587601501.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A number of spots in t5537 use the non-indented heredoc '<<EOF' when
they would benefit from instead using '<<-EOF' or simply
test_write_lines.

In preparation for adding new tests in a good style and being consistent
with the surrounding code, update the existing tests to improve their
readability.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5537-fetch-shallow.sh | 70 +++++++++++-----------------------------
 1 file changed, 18 insertions(+), 52 deletions(-)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 4f681dbbe1..d66b3656c0 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -25,10 +25,7 @@ test_expect_success 'setup' '
 test_expect_success 'setup shallow clone' '
 	git clone --no-local --depth=2 .git shallow &&
 	git --git-dir=shallow/.git log --format=%s >actual &&
-	cat <<EOF >expect &&
-4
-3
-EOF
+	test_write_lines 4 3 >expect &&
 	test_cmp expect actual
 '
 
@@ -38,10 +35,7 @@ test_expect_success 'clone from shallow clone' '
 	cd shallow2 &&
 	git fsck &&
 	git log --format=%s >actual &&
-	cat <<EOF >expect &&
-4
-3
-EOF
+	test_write_lines 4 3 >expect &&
 	test_cmp expect actual
 	)
 '
@@ -56,11 +50,7 @@ test_expect_success 'fetch from shallow clone' '
 	git fetch &&
 	git fsck &&
 	git log --format=%s origin/master >actual &&
-	cat <<EOF >expect &&
-5
-4
-3
-EOF
+	test_write_lines 5 4 3 >expect &&
 	test_cmp expect actual
 	)
 '
@@ -75,10 +65,7 @@ test_expect_success 'fetch --depth from shallow clone' '
 	git fetch --depth=2 &&
 	git fsck &&
 	git log --format=%s origin/master >actual &&
-	cat <<EOF >expect &&
-6
-5
-EOF
+	test_write_lines 6 5 >expect &&
 	test_cmp expect actual
 	)
 '
@@ -89,12 +76,7 @@ test_expect_success 'fetch --unshallow from shallow clone' '
 	git fetch --unshallow &&
 	git fsck &&
 	git log --format=%s origin/master >actual &&
-	cat <<EOF >expect &&
-6
-5
-4
-3
-EOF
+	test_write_lines 6 5 4 3 >expect &&
 	test_cmp expect actual
 	)
 '
@@ -111,15 +93,10 @@ test_expect_success 'fetch something upstream has but hidden by clients shallow
 	git fetch ../.git +refs/heads/master:refs/remotes/top/master &&
 	git fsck &&
 	git log --format=%s top/master >actual &&
-	cat <<EOF >expect &&
-add-1-back
-4
-3
-EOF
+	test_write_lines add-1-back 4 3 >expect &&
 	test_cmp expect actual
 	) &&
 	git --git-dir=shallow2/.git cat-file blob $(echo 1|git hash-object --stdin) >/dev/null
-
 '
 
 test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
@@ -133,14 +110,12 @@ test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
 	cd notshallow &&
 	git fetch ../shallow/.git refs/heads/*:refs/remotes/shallow/*&&
 	git for-each-ref --format="%(refname)" >actual.refs &&
-	cat <<EOF >expect.refs &&
-refs/remotes/shallow/no-shallow
-EOF
+	echo refs/remotes/shallow/no-shallow >expect.refs &&
 	test_cmp expect.refs actual.refs &&
 	git log --format=%s shallow/no-shallow >actual &&
-	cat <<EOF >expect &&
-no-shallow
-EOF
+	cat <<-EOF >expect &&
+	no-shallow
+	EOF
 	test_cmp expect actual
 	)
 '
@@ -158,21 +133,15 @@ test_expect_success 'fetch --update-shallow' '
 	git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/* &&
 	git fsck &&
 	git for-each-ref --sort=refname --format="%(refname)" >actual.refs &&
-	cat <<EOF >expect.refs &&
-refs/remotes/shallow/master
-refs/remotes/shallow/no-shallow
-refs/tags/heavy-tag
-refs/tags/light-tag
-EOF
+	cat <<-EOF >expect.refs &&
+	refs/remotes/shallow/master
+	refs/remotes/shallow/no-shallow
+	refs/tags/heavy-tag
+	refs/tags/light-tag
+	EOF
 	test_cmp expect.refs actual.refs &&
 	git log --format=%s shallow/master >actual &&
-	cat <<EOF >expect &&
-7
-6
-5
-4
-3
-EOF
+	test_write_lines 7 6 5 4 3 >expect &&
 	test_cmp expect actual
 	)
 '
@@ -183,10 +152,7 @@ test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only repo' '
 	find read-only.git -print | xargs chmod -w &&
 	git clone --no-local --depth=2 read-only.git from-read-only &&
 	git --git-dir=from-read-only/.git log --format=%s >actual &&
-	cat >expect <<EOF &&
-add-1-back
-4
-EOF
+	test_write_lines add-1-back 4 >expect &&
 	test_cmp expect actual
 '
 
-- 
2.26.0.113.ge9739cdccc

