Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D2BC433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbiCGMu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242580AbiCGMuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922C4E3B9
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j26so12723714wrb.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2Cl3BBJAf8YnIoWiiWhJCiHLlwHaq7d/n8ODIPHreY=;
        b=GgxEz4gothueys3y/+SdqCG8oX7XjVpIm1TzgAuttkVG7hhHAxJzhTSIFWX1yiNa8q
         eOh9xrsqGn1RWXGsuS8k6kgordlonVKDRQz/1mbJwtQiQqVGP93l2mLB5y01EbDtkUnD
         ge0Owl30+Vvq16oovFHdDUprnNm0/06yAlQ1KNvLdNWl6UdYK5BEkXzKHsUVOwzdby4k
         E1awKZTsr+KtoQIUTRqLyQQAW10gsqXlKvUsnN4BKt9IVKj5jPJupe6z3TFCUjnt8+BQ
         IW6CoCr/GvGy7bKL1qF2xo3XpRGHR3gE9MyEKjzL/7A78emVF4gwtuEaPc+t7AQGXACI
         57bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2Cl3BBJAf8YnIoWiiWhJCiHLlwHaq7d/n8ODIPHreY=;
        b=PTkf1PrmoqsbdPDJG5DxheYPPGn0ZB3wJJyQZF0B+qnOx8FE+CQgDZvDhIj1z/6r67
         tboUUA70qw5yeD0iLZIDMEUFtkTsQcJS58TWQeGkKc0QBARasecdtXl6wdFdk8EmJfzc
         sEBXZ2W9d14rTnecG4Pb9CPngyaCiPo8+dc7Unkju7JBgBfTqH0XN/c0I1ETHxG3pMUp
         4AwyoL/HULDP288DzIqHGq/i6vpsyf/+rKiPYMmukjJjDSurTdc2JJi9jNw2H70s+nZb
         j4faexrPrsau9bPRAVuKTaOXAWyRkFe7fwkm2j0HIS/HG1iVkFZTcybf5b1zWEpRHQ+U
         HjFw==
X-Gm-Message-State: AOAM531B13YKyT/7MPrrnzsrU24KFtRKwHH+WLPtYmd3tx4LsouDFUDv
        kdHGPgtt5y+9LQc2Br/j9z/rTSPEHGnESw==
X-Google-Smtp-Source: ABdhPJzpUNlSaAU07CT7JfdFZRJjiDE26xu53+usVsVUNc78bsQ0bo8I1Ly4KKp8cptishLBWobOzg==
X-Received: by 2002:adf:8063:0:b0:1ef:78e3:330 with SMTP id 90-20020adf8063000000b001ef78e30330mr8225864wrk.424.1646657365553;
        Mon, 07 Mar 2022 04:49:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/15] read-tree tests: check "diff-files" exit code on failure
Date:   Mon,  7 Mar 2022 13:48:54 +0100
Message-Id: <patch-v2-03.15-5f02e30d1ab-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an issue with the exit code of "diff-files" being ignored, which
has been ignored ever since these tests were originally added in
c859600954d ([PATCH] read-tree: save more user hassles during
fast-forward., 2005-06-07).

Since the exit code was ignored we'd hide errors here under
SANITIZE=leak, which resulted in me mistakenly marking these tests as
passing under SANITIZE=leak in e5a917fcf42 (unpack-trees: don't leak
memory in verify_clean_subdirectory(), 2021-10-07) and
4ea08416b8e (leak tests: mark a read-tree test as passing
SANITIZE=leak, 2021-10-31).

As it would be non-trivial to fix these tests (the leak is in
revision.c) let's un-mark them as passing under SANITIZE=leak in
addition to fixing the issue of ignoring the exit code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1001-read-tree-m-2way.sh   | 6 +++---
 t/t1002-read-tree-m-u-2way.sh | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index d1115528cb9..0710b1fb1e9 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -21,7 +21,6 @@ In the test, these paths are used:
 	yomin   - not in H or M
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
@@ -38,11 +37,12 @@ compare_change () {
 }
 
 check_cache_at () {
-	clean_if_empty=$(git diff-files -- "$1")
+	git diff-files -- "$1" >out &&
+	clean_if_empty=$(cat out) &&
 	case "$clean_if_empty" in
 	'')  echo "$1: clean" ;;
 	?*)  echo "$1: dirty" ;;
-	esac
+	esac &&
 	case "$2,$clean_if_empty" in
 	clean,)		:     ;;
 	clean,?*)	false ;;
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index ca5c5510c73..46cbd5514a6 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -9,7 +9,6 @@ This is identical to t1001, but uses -u to update the work tree as well.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
@@ -23,11 +22,12 @@ compare_change () {
 }
 
 check_cache_at () {
-	clean_if_empty=$(git diff-files -- "$1")
+	git diff-files -- "$1" >out &&
+	clean_if_empty=$(cat out) &&
 	case "$clean_if_empty" in
 	'')  echo "$1: clean" ;;
 	?*)  echo "$1: dirty" ;;
-	esac
+	esac &&
 	case "$2,$clean_if_empty" in
 	clean,)		:     ;;
 	clean,?*)	false ;;
-- 
2.35.1.1242.gfeba0eae32b

