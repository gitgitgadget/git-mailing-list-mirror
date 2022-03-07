Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3595C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbiCGMvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242564AbiCGMum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:42 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668704ECF1
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l10so5265776wmb.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JbjXSFREOYNLVEfiHd4vg2ZzCoKJTA/AtZ6C2rVoiLE=;
        b=jxvF1D3CIrAaGy2jv5wdLW219euM1GZ32nQ1v/eP2+kU/LnMo746NumdkaLSRaP+F3
         VdLlPZhMTooVFYDTPTqttIlEKo6a0j19v3h99TpPpFaG1m7rF2Fr8hmkL3trXiNWxHrH
         Zs7v3/l33cr4eFKVBLygypfVYWD+uhCdZKLhSsHappRaoEWAD1oBFwsg5QTJsy3do//D
         JCLC1CVjjoA37en5IZqOX7L8MZbSYxWIhyT8OwZvOejSL/gg1vorREhEHkv750EcwR9p
         8qTdA3rKlzj5VWY2lwn5Q5xhlwKtYwnQCC6TZ9ricjQpYKG+i4LXJ+CugBSp2KwkcNqW
         ZH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JbjXSFREOYNLVEfiHd4vg2ZzCoKJTA/AtZ6C2rVoiLE=;
        b=s5DdQdUv+TEYVn4n36G11A88NXP2msmOuHEX1WYW0tFdEIMQAgb9RPbhe44/FTSKSz
         J0w3r37kloxfQoFpRXDV73e/1Nxn4nG3K/DKkNLgSGqwKa0kqm6tTUXFVYomnUtRj7ZU
         n1sYhT2/NQYuGFfMwEaa3tausbnaYsjY+b8Q10isdxF5Oa8Ax7nr+qB42qKej0TC1I+r
         1HAS75pvZea14jANf2/kpU7yhMLM0ijWD1PTk2em8ne0RT+oX3+S8dnDOtEtVlLpRmwF
         +DmuT29c/UQBd7IdGtN9ZZJ1nUFPHVrFXo2GWsrG7731P5huhm7xSgvfWCx6oRmcDIil
         H7bA==
X-Gm-Message-State: AOAM532uEOjiim4gp0G68dvi6lYfwvezjmnBP91o/Nze1lvrrtxdBhoK
        F/RvG2F/qJQrIEvjb/dR/k0mxBlKTy6UkQ==
X-Google-Smtp-Source: ABdhPJzd4I4hmuB1DfDELJdT71S9+KwjRuZB9kMVWQ6obiWHfWd2QZNrkmDM0fDOKhUR06BcwcLfjQ==
X-Received: by 2002:a05:600c:4e94:b0:381:84cf:e9b0 with SMTP id f20-20020a05600c4e9400b0038184cfe9b0mr8956775wmq.79.1646657375970;
        Mon, 07 Mar 2022 04:49:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/15] rev-list tests: don't hide abort() in "test_expect_failure"
Date:   Mon,  7 Mar 2022 13:49:02 +0100
Message-Id: <patch-v2-11.15-52397b3575a-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a couple of uses of "test_expect_failure" to use a
"test_expect_success" to positively assert the current behavior, and
replace the intent of "test_expect_failure" with a "TODO" comment int
the description.

As noted in [1] the "test_expect_failure" feature is overly eager to
accept any failure as OK, and thus by design hides segfaults, abort()
etc. Because of that I didn't notice in dd9cede9136 (leak tests: mark
some rev-list tests as passing with SANITIZE=leak, 2021-10-31) that
this test leaks memory under SANITIZE=leak.

I have some larger local changes to add a better
"test_expect_failure", which would work just like
"test_expect_success", but would allow us say "test_todo" here (and
"success" would emit a "not ok [...] # TODO", not "ok [...]".

So even though using "test_expect_success" here comes with its own
problems[2], let's use it as a narrow change to fix the problem at
hand here and stop conflating the current "success" with actual
SANITIZE=leak failures.

1. https://lore.kernel.org/git/87tuhmk19c.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/xmqq4k9kj15p.fsf@gitster.g/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6102-rev-list-unexpected-objects.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 6f0902b8638..cf0195e8263 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -17,8 +17,13 @@ test_expect_success 'setup unexpected non-blob entry' '
 	broken_tree="$(git hash-object -w --literally -t tree broken-tree)"
 '
 
-test_expect_failure 'traverse unexpected non-blob entry (lone)' '
-	test_must_fail git rev-list --objects $broken_tree
+test_expect_success !SANITIZE_LEAK 'TODO (should fail!): traverse unexpected non-blob entry (lone)' '
+	sed "s/Z$//" >expect <<-EOF &&
+	$broken_tree Z
+	$tree foo
+	EOF
+	git rev-list --objects $broken_tree >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'traverse unexpected non-blob entry (seen)' '
@@ -116,8 +121,8 @@ test_expect_success 'setup unexpected non-blob tag' '
 	tag=$(git hash-object -w --literally -t tag broken-tag)
 '
 
-test_expect_failure 'traverse unexpected non-blob tag (lone)' '
-	test_must_fail git rev-list --objects $tag
+test_expect_success !SANITIZE_LEAK 'TODO (should fail!): traverse unexpected non-blob tag (lone)' '
+	git rev-list --objects $tag
 '
 
 test_expect_success 'traverse unexpected non-blob tag (seen)' '
-- 
2.35.1.1242.gfeba0eae32b

