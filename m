Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D99C433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 17:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390915AbiDURv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390907AbiDURvY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 13:51:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEB54A3DE
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:48:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v12so929790wrv.10
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DNP+WgroDw7VygcU8KXqGH1xsYfxw6qFA26joYUU14g=;
        b=ogB9Occ3i5x4pO+OQ8ODVccPmupVSRUc/v+5vIdUeFJ8HIt4WUgH4jgfh4JcTStT7I
         EPTo7WZlioB3v1IRgJaX8HoFhbWyEYsHbsQoJFnCI+6jkJIh4UQz+IJDqlVANPXT7BRh
         APcOyIxdBPgBKSTgqgkWa6MT/zQrUc3zlHegBv5Sc7HY1+kOcVz8gO17APdiAfbvGW0I
         KRiOnstqhLh8apTLruwiuIWsJO/I/vkDC3FsDkJnhTMobRI45kyAQbznVWizb1E71Mhq
         O4qnASeKJPxURtJ7CTIhIlKa1LB8NETZJwH2wPaC6JCN6pRy5/hbPFKmx310spFh7rRj
         Ed+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DNP+WgroDw7VygcU8KXqGH1xsYfxw6qFA26joYUU14g=;
        b=rm1So9dCwnUntwIXirkENX4AiX3RDxaPPjpJ+gv+pWI7X0yK74xp/E6/mCus7aB1/y
         XO2FbD3xt22+7rOXTxxMCSvWYOhR7prszWWVzvtcmgXBrUQf87mR1Ksz8gEhXmKhFdO6
         up7TKH12kHrtfuXHQPitKF2HmElJdy4bzwj9oUNVGk7XPIlLDo/UTUm5Gi09CcIXUIj6
         h8IxvI5Cd5q/NvqMiyq5UQaYAKGl+Uz2gJk4kq2MPckQlLRLqWvIbZz995k1diNyGRJd
         Xupy2DKo22H1YkE28LnlcSJsOTJ38u3Vuk7PNl+JVHHQuczbGwiYKOHbnsF53qfl1R4Z
         o0rw==
X-Gm-Message-State: AOAM5308WLaEQ3GOs/l/PBnHJPRrYpSe7Sk51G4l7uGO2zIeHlpsWvR8
        qlA7D2ovTytUp4uckYve9G5pCcOW3kBsBw==
X-Google-Smtp-Source: ABdhPJyQyyB2mLgHS2Avv559a4j0DVrebD7iKBNE4zlm1AXam9byaZWOi22/eRcQPNC+bdmVr+07Vg==
X-Received: by 2002:a5d:58d3:0:b0:20a:c3f3:b71f with SMTP id o19-20020a5d58d3000000b0020ac3f3b71fmr637644wrf.431.1650563310727;
        Thu, 21 Apr 2022 10:48:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b00207a49fa6a1sm3203712wrq.81.2022.04.21.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:48:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] CI: select CC based on CC_PACKAGE (again)
Date:   Thu, 21 Apr 2022 19:48:28 +0200
Message-Id: <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
References: <patch-1.1-d89ad4d5b7c-20220421T130310Z-avarab@gmail.com>
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

On Thu, Apr 21 2022, Phillip Wood wrote:

> CC is set in .github/workflows/main.yaml for the ubuntu and macos jobs
> so I think they will not fallback to using CC_PACKAGE and therefore
> not pick up the correct compiler.

Urgh, sorry. I don't know how I got that turned around, but this
version works, and the (currently ongoing) CI run shows that the
linux-gcc job selects gcc-8 correctly, instead of gcc:

    https://github.com/avar/git/runs/6116735686?check_suite_focus=true#step:3:22

The osx-gcc job will be likewise fixed, but it's failing in that run
due to the unrelated perforce installation issue affecting all OSX
jobs (fix here:
https://lore.kernel.org/git/cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com/).

Range-diff against v1:
1:  d89ad4d5b7c ! 1:  92acf9420a9 CI: select CC based on CC_PACKAGE (again)
    @@ ci/lib.sh: then
      	CI_REPO_SLUG="$GITHUB_REPOSITORY"
      	CI_JOB_ID="$GITHUB_RUN_ID"
     -	CC="${CC:-gcc}"
    -+	CC="${CC:-${CC_PACKAGE:-gcc}}"
    ++	CC="${CC_PACKAGE:-${CC:-gcc}}"
      	DONT_SKIP_TAGS=t
      
      	cache_dir="$HOME/none"

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
index cbc2f8f1caa..86e37da9bc5 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -122,7 +122,7 @@ then
 	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx
 	CI_REPO_SLUG="$GITHUB_REPOSITORY"
 	CI_JOB_ID="$GITHUB_RUN_ID"
-	CC="${CC:-gcc}"
+	CC="${CC_PACKAGE:-${CC:-gcc}}"
 	DONT_SKIP_TAGS=t
 
 	cache_dir="$HOME/none"
-- 
2.36.0.879.g3659959fcca

