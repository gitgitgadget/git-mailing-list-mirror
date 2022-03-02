Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800A5C433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbiCBR25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243833AbiCBR2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:31 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CE012761
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:40 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so3799191wmj.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0Th5kAVkJQP7YK5fgH3aCw1QZ8pTYKhtwLTOunqiwg=;
        b=AzPHsLD/xrunB2WvRj0lkS3EThr0KFUbfG8Ots4haB3HVmWkwQUyz5wZwTBKm6T9mM
         zprjoaQpF7/VtfWJZdsfwjyfpbIhMOMvV6Cv8cShV9M8DMM1SJM4wj+bgvrqyOssrwR8
         U+8/Dxl1H0tzVvqWp+cS8SGOsCgGYncm3iBOwGhulxFSlVLaVrJWJorOLC257gLDLG23
         RQr/+WPDgUhpqGhs5iAHX+fKTaIJkGXOjwiPRjabhxkfsl+JMg/xCvEsxkPg/fyZGbnB
         QOPvvUZkqgzztQxj39bVBORTMHT9CYcMLdBk9TwqA+7xMWdRdBA+glVnU4+cw5uIiqL2
         qJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0Th5kAVkJQP7YK5fgH3aCw1QZ8pTYKhtwLTOunqiwg=;
        b=YS31Tkb2LHrW+deiycf02RU0LxL/0n/FYOEhqnQU+fRkV/OPuPf3IOkU3ijkRl9bix
         KU/eALm2oPmjnQxnN8rOyUlZXGDO4jKq4iy9BMGy67jBoKj63ujkfzBE+qoIapzLNfXv
         qaTBDgPyWMSjculbxz1F6RReSFPTVR3seb8sGn4Yb9k8gjjIdH08hDPkIRHaPc42P/te
         yhnoqMqCUDbA+LYqMZgVVI6BdzBiBgkqypHL3YL9Wax2fzseSyp/4kXfGmqu+tVdxEoi
         CxlLs3kDbg9vgtoloanQ8SmZh3W+viSXDhRGOALyhN6p4yEwoE8N5/bEVQb6C7aXBLgl
         4Ktw==
X-Gm-Message-State: AOAM531AR3NXW/FZbWR7WSB9Y3KLWPbYJx92vXjMipP/S0ZnhMnP5+XM
        5mYTw4aAWN7jQC/ZjzhEtMntG7WlG3rwUQ==
X-Google-Smtp-Source: ABdhPJw07uPvxdcQM3mU8hoZMB7Zkn9wiRV1SlUqswtdEd5jJEzrIolLDSuM7ucmsK9b1i7ckd2hOg==
X-Received: by 2002:a05:600c:4e94:b0:381:84cf:e9b0 with SMTP id f20-20020a05600c4e9400b0038184cfe9b0mr671601wmq.79.1646242058814;
        Wed, 02 Mar 2022 09:27:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/15] diff tests: don't ignore "git rev-list" exit code
Date:   Wed,  2 Mar 2022 18:27:19 +0100
Message-Id: <patch-10.15-946397033d4-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a fragile pattern introduced in 2b459b483cb (diff: make sure
work tree side is shown as 0{40} when different, 2008-03-02) to check
the exit code of "git rev-list", while we're at it let's get rid of
the needless sub-shell for invoking it in favor of the "-C" option.

Because of this I'd marked these tests as passing under SANITIZE=leak
in 16d4bd4f14e (leak tests: mark some diff tests as passing with
SANITIZE=leak, 2021-10-31), let's remove the
"TEST_PASSES_SANITIZE_LEAK=true" annotation as they no longer do.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4027-diff-submodule.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 6cef0da982f..295da987cce 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='difference in submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
@@ -28,10 +27,8 @@ test_expect_success setup '
 		git commit -m "submodule #2"
 	) &&
 
-	set x $(
-		cd sub &&
-		git rev-list HEAD
-	) &&
+	git -C sub rev-list HEAD >revs &&
+	set x $(cat revs) &&
 	echo ":160000 160000 $3 $ZERO_OID M	sub" >expect &&
 	subtip=$3 subprev=$2
 '
-- 
2.35.1.1226.g8b497615d32

