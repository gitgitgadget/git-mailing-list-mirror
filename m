Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB3CC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8366220936
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIDoICHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgIYRDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYRDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CCCC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:31 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m34so3101023pgl.9
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5faDJt0YXNHD+EUFHtfwCQsOVX8iWPJ+MGU1yXpBnw=;
        b=JIDoICHn0V2wyn7gToSU9YyMmWId1cZ2/3HQwgUwgsyMW/I5cfX+KEksiWT070qL+a
         jvRPrWrtPUdGGy/7CQ6wVL7jCgmGzkM3dCvmm5tNYuecrjs+clBKl0r4/FKOtCVsBqk8
         grIvRmxOSLlv+CSK6JIdMbcWbcoq6N9i4GJoVStfuCebXx1FqvXd1piMVaH+BWIfmjyY
         jC2ep/DlTNFrjLnNI6HKl75UpBzrje+ij6O+b7qQNiCkN73XYTg8Skkok9cLeIUx+0ec
         0wyndiLjZrjCI16w+sacqiuTmoqNKzd8xmB74CCsWwGcbutT6eHwx1RVGyAfFF5paU4P
         nOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5faDJt0YXNHD+EUFHtfwCQsOVX8iWPJ+MGU1yXpBnw=;
        b=efH/efIPPJ9Jqweq9tbgipEE8p3XUmJlRVAuLPBJZmQZOtBlw/yTP7AEZTTNJ+DYDe
         Mbc4cn+ms+xK++R4/GOy9EPbOdir/Qdr4tAvJGt1LNGNrKhLpeSDtiM+wyzbgdpBxD4c
         uxQzGqZJ/6Z/DNRxOSb6rlQpz3gas5f5xrpRmeAD9ee7XpJnTtjNKVMbP3CjJ7wUqqll
         24W+mtQBDb93qIJWzRjzaM+LMkSxZkYcx5SWI3KDNWSSDMJg9U4BkWnDIUVhc7wQ3A7h
         KLj5PvGFH5OAXs1aC+Kn1D52e0uHCxewbD7SG8q9SCcKxiDNrAkR1Ma7uLsO8LlQnyrl
         q1nA==
X-Gm-Message-State: AOAM533Lon85qI0xFExRhv0xRXbxapyjm0oLc5gIEkg8KexQxj1R8tsx
        4AEFkHDtlMl/3Hz4kuUfNnbprQwqM3Xxrw==
X-Google-Smtp-Source: ABdhPJw9CQC2ER+Srj7rsAFFbzWxukvBDpIMfSAU1mQgq0cHJrbunERRPYSjAsQLTbNiVoBwRUSfBw==
X-Received: by 2002:a63:1665:: with SMTP id 37mr825475pgw.383.1601053410254;
        Fri, 25 Sep 2020 10:03:30 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:29 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Cc:     Shubham Verma <shubhunic@gmail.com>
Subject: [PATCH 07/11] t7001: use ': >' rather than 'touch'
Date:   Fri, 25 Sep 2020 22:32:52 +0530
Message-Id: <20200925170256.11490-8-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
References: <20200925170256.11490-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shubham Verma <shubhunic@gmail.com>

Use `>` rather than `touch` to create an empty file when the
timestamp isn't relevant to the test.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 3a3ace6d73..728a937eeb 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -47,14 +47,14 @@ test_expect_success 'checking -k on non-existing file' '
 '
 
 test_expect_success 'checking -k on untracked file' '
-	touch untracked1 &&
+	: > untracked1 &&
 	git mv -k untracked1 path0 &&
 	test -f untracked1 &&
 	test ! -f path0/untracked1
 '
 
 test_expect_success 'checking -k on multiple untracked files' '
-	touch untracked2 &&
+	: > untracked2 &&
 	git mv -k untracked1 untracked2 path0 &&
 	test -f untracked1 &&
 	test -f untracked2 &&
@@ -63,7 +63,7 @@ test_expect_success 'checking -k on multiple untracked files' '
 '
 
 test_expect_success 'checking -f on untracked file with existing target' '
-	touch path0/untracked1 &&
+	: > path0/untracked1 &&
 	test_must_fail git mv -f untracked1 path0 &&
 	test ! -f .git/index.lock &&
 	test -f untracked1 &&
@@ -482,7 +482,7 @@ test_expect_success 'moving nested submodules' '
 	mkdir sub_nested_nested &&
 	(
 		cd sub_nested_nested &&
-		touch nested_level2 &&
+		: > nested_level2 &&
 		git init &&
 		git add . &&
 		git commit -m "nested level 2"
@@ -490,7 +490,7 @@ test_expect_success 'moving nested submodules' '
 	mkdir sub_nested &&
 	(
 		cd sub_nested &&
-		touch nested_level1 &&
+		: > nested_level1 &&
 		git init &&
 		git add . &&
 		git commit -m "nested level 1" &&
-- 
2.25.1

