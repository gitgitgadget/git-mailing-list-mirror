Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AE8C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 13:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiDUNG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiDUNGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 09:06:25 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A51933A0B
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:03:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w4so6573302wrg.12
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sBX8udLGB45x94zub6wIJd7vrLWaVOPNVPu+EK4kiGo=;
        b=Z1AQ7Qzs/EC4iYUX9xmzSkMAKWRik2RBGx955vm+MG+X6pxXfrGFzHXxDDdI/9a7lH
         upSQAj9hU+ev61RqatJ4q0Yqk1K7PpiEcobFzHPnEbqcHlEX83igB0xob79exGKwrqBf
         ANbR7AIzY7Vbxag/U6gCMVMB4Cn2/KdG7/iJhCMXabe51v82a3txwe7iMebSRMZ4XufC
         a41AMT0N5DjQWx7FKLQv8A1ADctQbpCMw6VNotczvFqoPTEjMPOIWhYnRaqVnA6XKRr5
         EGDLSXOH5kfRYEam0LU8B/in2NLW9tp7bwY1D+tRezfwuxWh8f/owu8rTY9m2Smn5f6t
         2pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sBX8udLGB45x94zub6wIJd7vrLWaVOPNVPu+EK4kiGo=;
        b=kj/iVXejuZBdXpJEtBTXxNxE3zmkG3elCDqgOn/4Hjp6OosqHB9kShfefL+GS5L5D2
         G7AKjDK+KBZeUkAWjBfA+53H+agbizOSBgqPX+F58suTXOQpM/rr8g4IumYnjIGUxBZt
         SyvUs8oz8uCQyRuwRzPp7BCbfd9ymC3JIFDi6bBUP6nwCCf0PYAix5W685u8XfUdWtbl
         6lLhzScGLUtQP98E8sOciK0C/ye3tzOgVjTaP9Em/8V+kE5MdCYC9Re1utbFX2Z0ev5l
         +4FW9lOYITiZGILofGQh31KG4d6akxSVRVZleJZN6x9xQccvygWOBSUrMAN66um3WFJd
         cSgw==
X-Gm-Message-State: AOAM530cho6imW+6VjQbaka+sh4mtswdSJSfBLFgXDQC1HEQBlnbAjwC
        k8yLHwyn9yv17UyIedtGur/zEobbSPdGTA==
X-Google-Smtp-Source: ABdhPJw7Pm6k3+rSYS6Gsf2/qGrGojjY9I3RKOoxOPIRgl3pdCfUX/x2UDLKsupG12rnAPDmf3n+hg==
X-Received: by 2002:a5d:424f:0:b0:20a:c08b:551a with SMTP id s15-20020a5d424f000000b0020ac08b551amr1929753wrr.521.1650546212413;
        Thu, 21 Apr 2022 06:03:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c3807000000b0038ffac6f752sm1979218wma.45.2022.04.21.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:03:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] CI: select CC based on CC_PACKAGE (again)
Date:   Thu, 21 Apr 2022 15:03:26 +0200
Message-Id: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.876.g4bfefc07680
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
"$jobname" to select packages & config, 2021-11-23).

In that commit I changed CC=gcc from CC=gcc-9, but on OSX the "gcc" in
$PATH points to clang, we need to use gcc-9 instead. Likewise for the
linux-gcc job CC=gcc-8 was changed to the implicit CC=gcc, which would
select GCC 9.4.0 instead of GCC 8.4.0.

Furthermore in 25715419bf4 (CI: don't run "make test" twice in one
job, 2021-11-23) when the "linux-TEST-vars" job was split off from
"linux-gcc" the "cc_package: gcc-8" line was copied along with
it.

That wasn't a bug per-se, as that "make test" would have run under GCC
8 before the split into two jobs, but the point of selecting different
compiler for these jobs is to get better coverage, and to narrow down
any issues with a given compiler to the job that runs it. Since the
"linux-TEST-vars" job is already special in other ways (in running
with various GIT_TEST_* variables), and we've got the "linux-gcc" job
covering gcc-8 let's have it used the default system compiler instead.

Reported-by: Carlo Arenas <carenas@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Range-diff:
1:  94abb826627 < -:  ----------- CI: have osx-gcc use gcc, not clang
-:  ----------- > 1:  d89ad4d5b7c CI: select CC based on CC_PACKAGE (again)

The range-diff is against a relevant patch in v4 of a larger CI series
of mine[1]. This fix is independent of that, and on top of master. See
[2] for the original fix and discussion.

As noted in the updated commit message not only the OSX jobs were
affected, but also the linux-gcc job. This fixes both, along with a
small fix to the related linux-TEST-vars recipe.

1. https://lore.kernel.org/git/cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com/
2. https://lore.kernel.org/git/patch-v4-30.31-94abb826627-20220418T132809Z-avarab@gmail.com/

 .github/workflows/main.yml | 1 -
 ci/lib.sh                  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c35200defb9..f12819a00d7 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -236,7 +236,6 @@ jobs:
           - jobname: linux-TEST-vars
             cc: gcc
             os: ubuntu
-            cc_package: gcc-8
             pool: ubuntu-latest
           - jobname: osx-clang
             cc: clang
diff --git a/ci/lib.sh b/ci/lib.sh
index cbc2f8f1caa..44007dcf93b 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -122,7 +122,7 @@ then
 	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx
 	CI_REPO_SLUG="$GITHUB_REPOSITORY"
 	CI_JOB_ID="$GITHUB_RUN_ID"
-	CC="${CC:-gcc}"
+	CC="${CC:-${CC_PACKAGE:-gcc}}"
 	DONT_SKIP_TAGS=t
 
 	cache_dir="$HOME/none"
-- 
2.36.0.876.g4bfefc07680

