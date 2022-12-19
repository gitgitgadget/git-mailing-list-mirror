Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDFFC10F1B
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiLSKT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiLSKTn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:19:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1AEB7E0
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:42 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a17so6950060wrt.11
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJL88Z8Q7O4QzXpIzIQqoBMNqym1QqTt3+EvwztPwOI=;
        b=ieNoGUaJohO9yd+HqNXZVEI3ihdxCaE2VmI47DKWBqx4RwspoCAd0g4X5L6+RxPj+T
         bkJ6SKq5/vspAYgDAvWdIyRBcjnDnmayrWBUITpaNWQyACefSECtaaWyv698va8JvYrO
         ZbheUdrJLut5f3bnA0YRzXohULek/aoMbByQchvLAp31k0nXrQr/3JCMgR3zR1YTHQVp
         xpFIX/vkvARVmrOdVTMG58zt/RBiEEVIRas8m2v+Hi7nnLh01MXEl3/bj+CpLpN9pSGc
         f0HAQYckIKppMTtI79mpGrZzQujI2IIAsfFJ8Oa39FAD++io3FJi4xltxpJ91VOgsg2Y
         QcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJL88Z8Q7O4QzXpIzIQqoBMNqym1QqTt3+EvwztPwOI=;
        b=QgS0N8NAdDVo5StNKT/vKNkFC+Qd4Sg6RM/ua99RqPMMRJFN7HXFKxpyroQrjaktyb
         UUXPqeDDv9n5PnRoiIP8CMZn1RZcMtetRcGnIoezE5juPg8hDkpvSUIPwMiLzkiv+lhV
         o203cXrcnDpWfJZxuMaqMuJvx+UG6OmtRjd7jWpX7szR4Wry47gQJjJ24NQCkHxDo74N
         M1zOE7uxZiosyoLX6z2R8aO/vZN7M8ia+Qq9EP1qTAMvIEXDBgRZjRuf3r1bdvXSjQ2C
         hYD9YLACZ8ayDCGv/lRnokgW2U7QOy4RuzfPiyaWGDUAJrsjZw1OAcfuXkB3En+Wl29K
         OzrA==
X-Gm-Message-State: ANoB5pkSbw9pREkp9FKjmp/LH4Vpu69u7fO9FjJb5xLwOrz6g+iFZKzz
        Oo9ic8w8JiRCR6D0R9TLelSXIaAf9DDl0A==
X-Google-Smtp-Source: AA0mqf7DxuZLcllLhzRzBPJJjCyBLn+/xMgrbcHU+p61oIfPoBSSw8Sq2PlGYndGpr8lV1r4Im6iNg==
X-Received: by 2002:adf:e84e:0:b0:242:15b4:35d9 with SMTP id d14-20020adfe84e000000b0024215b435d9mr26550602wrn.42.1671445180445;
        Mon, 19 Dec 2022 02:19:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bx25-20020a5d5b19000000b00225307f43fbsm9632672wrb.44.2022.12.19.02.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:19:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/6] tests: don't lose misc "git" exit codes
Date:   Mon, 19 Dec 2022 11:19:29 +0100
Message-Id: <patch-v4-6.6-94df7a1764e-20221219T101240Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a few miscellaneous cases where:

- We lost the "git" exit code via "git ... | grep"
- Likewise by having a $(git) argument to git itself
- Used "test -z" to check that a command emitted no output, we can use
  "test_must_be_empty" and &&-chaining instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1401-symbolic-ref.sh    | 3 ++-
 t/t3701-add-interactive.sh | 8 +++++---
 t/t7516-commit-races.sh    | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index d708acdb819..5e36899d207 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -33,7 +33,8 @@ test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
 reset_to_sane
 
 test_expect_success 'symbolic-ref refuses bare sha1' '
-	test_must_fail git symbolic-ref HEAD $(git rev-parse HEAD)
+	rev=$(git rev-parse HEAD) &&
+	test_must_fail git symbolic-ref HEAD "$rev"
 '
 
 reset_to_sane
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5841f280fb2..f1fe5d60677 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -296,9 +296,11 @@ test_expect_success FILEMODE 'stage mode and hunk' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "y\\ny\\n" | git add -p &&
-	git diff --cached file | grep "new mode" &&
-	git diff --cached file | grep "+content" &&
-	test -z "$(git diff file)"
+	git diff --cached file >out &&
+	grep "new mode" out &&
+	grep "+content" out &&
+	git diff file >out &&
+	test_must_be_empty out
 '
 
 # end of tests disabled when filemode is not usable
diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
index f2ce14e9071..2d38a16480e 100755
--- a/t/t7516-commit-races.sh
+++ b/t/t7516-commit-races.sh
@@ -10,7 +10,8 @@ test_expect_success 'race to create orphan commit' '
 	test_must_fail env EDITOR=./hare-editor git commit --allow-empty -m tortoise -e &&
 	git show -s --pretty=format:%s >subject &&
 	grep hare subject &&
-	test -z "$(git show -s --pretty=format:%P)"
+	git show -s --pretty=format:%P >out &&
+	test_must_be_empty out
 '
 
 test_expect_success 'race to create non-orphan commit' '
-- 
2.39.0.1071.g97ce8966538

