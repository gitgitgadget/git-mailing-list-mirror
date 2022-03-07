Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825FBC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbiCGMuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242552AbiCGMuk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC794EA1C
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:32 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso6579121wms.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3gJNsKx8HfsqjYlPKxvw+uj2R6V3mnEGolNYwcNwNY=;
        b=RRLyqKg+4wNm8etQVwwdlyJGYR2ttwJWDPtADYOF5VwgN1U1TbZoY3iFY/73XN9XMQ
         Bfemjb12wrz6Kw/TGBhAkcV6Fd+0fPbCHQbtZr4TkMP9eKfuEBpmeejpsA8hOr5mg2JA
         a8BPCayXZjNY5QctM/bK/k+NnlbS/apXV4xaaZ4wvY3EYhLBscCvvtas0VngRWGOLBUr
         79g7pGAU3ptnkMVQm684TpEQcfXHgnDS65RK1JqAZAPD1Tp3PA2nCrxyZHt3OvrUib9F
         XIDCwfO5f3XjmG7CgVe7nb36f743wXWzuaTXyNwgH9DOycARRnV7SzqP/hKtPyvxlkTI
         EQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3gJNsKx8HfsqjYlPKxvw+uj2R6V3mnEGolNYwcNwNY=;
        b=fXebYfldLz4YC6KAmWDi475V0korB6rStRhtLqSPHYDoMLuMvdN97sQAfYCd8+rJL9
         4BK9XaKTsZdoo2IcfKVgzj3LblfLXnuJx4QVeV8TVsWubIaZ40tBHPgr1nRJ8KLtwCTI
         kgziq+gR2f5xZxyYPqUL5PqWag1KuLtyu6llM79PKVnr0bhZ8pjbHZ8OWyWHgHskqCMa
         bbG/61rfgQWALF/OD5AouxJzjEbhEkOPnfkx+cjklTP/wjVHvG/QnMHKcsMFsjdOAs01
         s3IC0BWqXZxTsP39+3oYeQODUXit7GvLOxlCG2MQ9ZMCulC6Log8ceM4zng76pWFjR/x
         0Phg==
X-Gm-Message-State: AOAM530nLWfo7ZLqmjkjsUowe7p+qey+nV9Yq1vrtbAUENztNz69BVVU
        6e4m2kd8YHgPS62byWR8CJdx8A2oNsG73Q==
X-Google-Smtp-Source: ABdhPJw2zqocdgjcaBeMuEpPRPA5NKa9xsr1suTVtYa58bBMCu0iuOEwUPg+PG1R5AD+5mn8wZFhyA==
X-Received: by 2002:a05:600c:2994:b0:387:3615:7b3a with SMTP id r20-20020a05600c299400b0038736157b3amr9127946wmd.142.1646657370915;
        Mon, 07 Mar 2022 04:49:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/15] merge tests: use "test_must_fail" instead of ad-hoc pattern
Date:   Mon,  7 Mar 2022 13:48:58 +0100
Message-Id: <patch-v2-07.15-276be19e35e-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
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
2.35.1.1242.gfeba0eae32b

