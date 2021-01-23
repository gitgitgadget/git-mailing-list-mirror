Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BFCC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B977522CB9
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 13:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbhAWNB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 08:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbhAWNBr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 08:01:47 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE04C0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m187so6578838wme.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 05:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7FoRZuMMIbetJTNalFcrGgbffGakIFy89xOqs/udAQ=;
        b=EOQs9GRGxqqRCH2y8+fPD8YPjYJTj1pNzU8h4JJ9lsssnG37xcwD/yL+dt6xdSFOEz
         bsc7kbaUEI3rDeq7qVfGzKLbZs2M61MOXrLHd9oKhCuFWaTA2QHEcTbmDXjVRF6npBml
         aTPFfM38KrM70Cqlsx9ZhY3j+hSc4p7bR2j1spKTIFN2WvkiKSrm9K5lBouLkETdr2zl
         D/5As3+Uz4X7/H9M6ruCoEpqlNVwPptvATArBCG2S6GVnKbd/spPHw4azOxk4YVlzFTE
         8eSBJcKFLn4AbLdRDOlGYLlOkf0cDECplt1oCjZidtKTBKwDKtyc3DQw60kk8OutbUAS
         PTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7FoRZuMMIbetJTNalFcrGgbffGakIFy89xOqs/udAQ=;
        b=bCTFdjXlx2z0InOL5v18c/UGurWkAnLllkhDVGTje9asLhAS0ZiojfuqTGYE3GLKae
         mFQnVIA45Jr2O7OX97BqAwWJZG5NQgaBHCptZz7Tr6rPrwO7pRxFthXkjVvX8rCyir5V
         Da+eRbwLZX+AzWlUjLt+0+1QIfXbeyO5mtnZQiEuR4WAGM3DkBNXgR7yIAl0+3f7F/vZ
         ym1aZ78436VLdoq+JhzVAswXPIgBEmXBLZ8yhxfPqaN8Jbp+jAnxM5dTDiVLdQ8cnLyg
         sPiFBPj0OFnlvPZpxS7FOZwIEOQGYAyAWkemmpffy/B4fB1IK//dWTLUhXn3W4msuGze
         iygQ==
X-Gm-Message-State: AOAM5307vupjG4QII69n5cmzZFCyl3wy9MkkMdpC6ZLgK7iWhTqAIwYN
        bMnqOGo400vebnEdeyzDonCXnRdE387rqA==
X-Google-Smtp-Source: ABdhPJwqDMJ4M77NX5fyRJJywSJji9pZXiJhrsmMB/1bKRJa8+uIlfkkMAbz/5WmYKL2Iu1EqXKKTw==
X-Received: by 2002:a1c:dc83:: with SMTP id t125mr8215487wmg.154.1611406864849;
        Sat, 23 Jan 2021 05:01:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm16750319wro.16.2021.01.23.05.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 05:01:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/10] cache-tree tests: refactor for modern test style
Date:   Sat, 23 Jan 2021 14:00:37 +0100
Message-Id: <20210123130046.21975-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87sg6s6lrs.fsf@evledraar.gmail.com>
References: <87sg6s6lrs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the cache-tree test file to use our current recommended
patterns. This makes a subsequent meaningful change easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0090-cache-tree.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 5a633690bf..45e1cc82ed 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -10,7 +10,8 @@ cache-tree extension.
 cmp_cache_tree () {
 	test-tool dump-cache-tree | sed -e '/#(ref)/d' >actual &&
 	sed "s/$OID_REGEX/SHA/" <actual >filtered &&
-	test_cmp "$1" filtered
+	test_cmp "$1" filtered &&
+	rm filtered
 }
 
 # We don't bother with actually checking the SHA1:
@@ -54,7 +55,7 @@ test_invalid_cache_tree () {
 }
 
 test_no_cache_tree () {
-	: >expect &&
+	>expect &&
 	cmp_cache_tree expect
 }
 
@@ -83,18 +84,6 @@ test_expect_success 'git-add in subdir invalidates cache-tree' '
 	test_invalid_cache_tree
 '
 
-cat >before <<\EOF
-SHA  (3 entries, 2 subtrees)
-SHA dir1/ (1 entries, 0 subtrees)
-SHA dir2/ (1 entries, 0 subtrees)
-EOF
-
-cat >expect <<\EOF
-invalid                                   (2 subtrees)
-invalid                                  dir1/ (0 subtrees)
-SHA dir2/ (1 entries, 0 subtrees)
-EOF
-
 test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
 	git tag no-children &&
 	test_when_finished "git reset --hard no-children; git read-tree HEAD" &&
@@ -102,9 +91,20 @@ test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
 	test_commit dir1/a &&
 	test_commit dir2/b &&
 	echo "I changed this file" >dir1/a &&
+	test_when_finished "rm before" &&
+	cat >before <<-\EOF &&
+	SHA  (3 entries, 2 subtrees)
+	SHA dir1/ (1 entries, 0 subtrees)
+	SHA dir2/ (1 entries, 0 subtrees)
+	EOF
 	cmp_cache_tree before &&
 	echo "I changed this file" >dir1/a &&
 	git add dir1/a &&
+	cat >expect <<-\EOF &&
+	invalid                                   (2 subtrees)
+	invalid                                  dir1/ (0 subtrees)
+	SHA dir2/ (1 entries, 0 subtrees)
+	EOF
 	cmp_cache_tree expect
 '
 
-- 
2.29.2.222.g5d2a92d10f8

