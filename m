Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36101C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbiCBR2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243855AbiCBR23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:29 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A29BDFD1
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bk29so3913346wrb.4
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bE6yg5we+dT02JER2NCqX+0HDyVKP3s4uZWCawKiZIU=;
        b=FqJ9jdHiKJsA40sF3hnExQrgvl0r9mZxtH4HNqOD535QmujtHtci2l8ZP3JQv5kxlY
         4jnCLWbzxSLQxm4kHhk1UYOyP0zBovTGnp//kDJ+YKld+h4tondVBLvslANynjLDCjyQ
         qAKOmv0fIBTpaRorzSxld87fbI2Vnw+XdAvMvqjqLAqP8QYjQJqmaajhVdFFo2FwlDnv
         EHgPTz8od5peR1guLDX23QedTnCQ7IlBPag7YEWTdQj+rrKK2+C/TIbz99BxH3y5AZ+2
         cosVZYKXq3gfRY8HI7qu4ZLGQmCAzPhyE5dfgPrmlfbYXXuUEF8/ohqQrsv0YcyA0bEq
         XeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bE6yg5we+dT02JER2NCqX+0HDyVKP3s4uZWCawKiZIU=;
        b=PKsHg6fdQbxf+A4dnPsO06OK8jT/yG+iOoyKNDRNsu/BVysB8K3AfLBXaQsIde5g10
         Mx2KzcWgv6GN00lS3KdEJP24KCwioo09eBSftqmei7YZCgljAxKPN+6OesuBBF+1YYls
         a6OtWkvCi8uJKSiV0AyM18p7MOcneXnmCsVDTQyFBm9O9XUeZyxR+6/HmI8qJHV7qvd/
         +K1F8LKf1M7yCRTd4gq16yVsKg0XULlfstwr2T3vrIVwfwzrubHkBXQA1hoftMWrBD5C
         HFKco4EDjzGBHmlE/0uORpKs9GmNS8l1E5lTnQoQpy3IUsDpRtS2cTyh38jzkiIKMYuw
         puwA==
X-Gm-Message-State: AOAM530WBScA7A28bD6d4qx3Cfnf0ganSuOG7I8qxUwW0AswJeFhX84O
        vxvvstF+hNW2ctuud+aeA5W7IWutxxYD7Q==
X-Google-Smtp-Source: ABdhPJx4+NomLk6TxQU5Jh5KS75PA+4XDo2PrH+PEg3F1Yi0ywHKCU9j+yNpSx2hQzq1FiRTeBT51g==
X-Received: by 2002:a5d:4310:0:b0:1ef:fb60:e1d8 with SMTP id h16-20020a5d4310000000b001effb60e1d8mr8466785wrq.92.1646242056047;
        Wed, 02 Mar 2022 09:27:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/15] merge tests: use "test_must_fail" instead of ad-hoc pattern
Date:   Wed,  2 Mar 2022 18:27:16 +0100
Message-Id: <patch-07.15-276be19e35e-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in the preceding commit change a similar fragile test pattern
introduced in b798671fa93 (merge-recursive: do not rudely die on
binary merge, 2007-08-14) to use a "test_must_fail" instead.

Before this we wouldn't distinguish normal "git merge" failures from
segfaults or abort(). Unlike the preceding commit we didn't end up
hiding any SANITIZE=leak failures in this case, but let's
correspondingly change these anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6407-merge-binary.sh | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index 8e6241f92e6..0753fc95f45 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -43,14 +43,9 @@ test_expect_success resolve '
 	rm -f a* m* &&
 	git reset --hard anchor &&
 
-	if git merge -s resolve main
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current &&
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s resolve main &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_expect_success recursive '
@@ -58,14 +53,9 @@ test_expect_success recursive '
 	rm -f a* m* &&
 	git reset --hard anchor &&
 
-	if git merge -s recursive main
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current &&
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s recursive main &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_done
-- 
2.35.1.1226.g8b497615d32

