Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCABC47089
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiLBLyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiLBLxp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:53:45 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7084EDB0D4
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:53:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z92so6207094ede.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u26/GgRncCCQAQgiu+8EgkFKc4okja08HT3aHmInaZ4=;
        b=YMn+NcXRWuaNoiwWDwxNIZjolZjiwrRsDveKgUq1y95polWYd+EI4p2cmzYcXQ/nvF
         Wfby3r3T1zEEsM5gGHVQ8HVVHlYRNuHQdpbQdDvIwq9k6f1+pME3nip8KohkiE2kd/Qe
         AlK97EDjrD15vdYhOqO4QTTy++nOw1BHahhQWSKzzh45rUk4kCFC9p89he9LBaCTvh04
         VQoAMURGhKTKC7JtzFGTlzdPDagRuWJyt1UnTojDDECGM4H1kEnlT+/zIzBsbSJXRsMU
         j3vuly4Z91vJ7fD05miAOqOXf9FASeiecxi9jIC2fI0rBVofW/O2MEWdripyw5G5ZIsy
         YURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u26/GgRncCCQAQgiu+8EgkFKc4okja08HT3aHmInaZ4=;
        b=1s32Mm9eJwivII0uANOSwnCDc8exmldpa/8zGDuwrg/QyrpSm09NQr4aK45bTdfTJo
         NLZoxgZ+yEkx90A4/mcbfyHaJFSX/tS14axZeckQtsE5NIAfnMSLXU9ini7oPdu2mxi6
         s89F/3SJrz6Df62WJ2GNMaEcLWarbnr3ONpr3ezZb+pFAkiqJYJD88Eaa6aCEfW+lu4R
         7FugPxdW7ER6zQvcfYwZYjnxhXw64IVZBYhMs2nUHzy2m52TsvrxrT+EHthMHuQD8r6G
         ptwVbq748GazB1iL3XeYqubtD95vpCZLMkLSaOXHdLqe5G3ZU5ty9Ao9S0KvF+Ar5dUx
         SDJQ==
X-Gm-Message-State: ANoB5pmp+wQj/OlXhZQtCmCinGju8tk5en+cHea7kcnqZpkgq7OhVinq
        pZEFbc60KoUAdCiiFOMLWVVY/OmvjxxmyQ==
X-Google-Smtp-Source: AA0mqf5eH2WN5Mn/+nCV2BiAffGS3SfuEmMOOF7WaCMpE9b1G3pPAxDQ0OmPSuJqZVbBI7QNihqXww==
X-Received: by 2002:aa7:ca54:0:b0:46b:5f6f:a303 with SMTP id j20-20020aa7ca54000000b0046b5f6fa303mr17811283edt.110.1669981993667;
        Fri, 02 Dec 2022 03:53:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7da94000000b00458947539desm2833754eds.78.2022.12.02.03.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:53:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 8/8] tests: don't lose mist "git" exit codes
Date:   Fri,  2 Dec 2022 12:52:41 +0100
Message-Id: <patch-v3-8.8-37c75f4a097-20221202T114733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
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
2.39.0.rc1.981.gf846af54b4b

