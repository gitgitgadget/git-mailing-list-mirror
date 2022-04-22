Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06837C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiDVJXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiDVJXt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:23:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37BE245A1
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:20:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e2so3877826wrh.7
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6yNwxCy835y+Su70Cn6fSyUV5BZHBekZkwYqAkCRzNo=;
        b=AHOimLUprxcRLkdlYIs3adeVvA8mIh6duhn5XWl5fHzbzSCjy20gMFogi5NP1bDXWf
         eDLHIxTvjVi9OMk1Co0SiBDSiZOvRoq6nuAAh6trrl+V/PlF0necd9vlYH6XcVRiv1tA
         7NbvXfbaOUXwlE1FdObmlju3gbHjl2jopG9cjVyzo+ptiF4Ay866SN6WchrJhT/ftXhF
         8aijJQ5j3q6YKATXXkoKsT59N7ReOVvLbBNc9DxpYJ/m3TDUuBaskFkzcNosxcSV+IF9
         HZw9JjjVcHsxex7TbIiMATfUL6sKFkwtcMjxpfE9WnEKxczA4KZCJzMZUdeTApU8B3kO
         U7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6yNwxCy835y+Su70Cn6fSyUV5BZHBekZkwYqAkCRzNo=;
        b=f98WMl0vF7OyDAKjAWgE+dA26qRn+AAPpCHb1FD1m8Zx9wFHlkeX3DN1CrbZC7UYAN
         j9YFQv6qy+edd9PYO7LpjYJIhHNpHSF/77MAPnMXg11y61hNiYRFyabTsG8WZ6wxY5lE
         yPJMoalsNgJPndvVzqtY6AJCBZeXfUlgpjqB2U7Zm+GJ16R7wg+zcB2b+T++13MvKX5L
         z1bvebUr3k1LdEgVrrDIzJaOyXXJgkDj+aJdZCr+sIlORg2HhRcz53Iq31L1HP0bczzd
         Qyw2ze7r4qArf3oo+jqmsvNDSnvMLdRab0PdoUsDRvsQjIvrdJkwBoeoLE82X1tCpVZ5
         ixXQ==
X-Gm-Message-State: AOAM533dcRlEhAjCg/QRvweE54EzJX9+DqwiNlHEYyjIHHXPrXtnaXEG
        bf9huQfn3Nx0ZND7ijP3r4Qm4TDwD7PPMw==
X-Google-Smtp-Source: ABdhPJw10YpQQTCsnZDb7cVSwtbJce16+9uqOhz5fYU0nhfNRKGO9QxXQ6MBreaGYQ9W4mnEVPA+gg==
X-Received: by 2002:adf:eed2:0:b0:20a:9c46:9dfb with SMTP id a18-20020adfeed2000000b0020a9c469dfbmr3050339wrp.656.1650619255239;
        Fri, 22 Apr 2022 02:20:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d4ecd000000b00207b4c92594sm1210149wrv.59.2022.04.22.02.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:20:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] CI: select CC based on CC_PACKAGE (again)
Date:   Fri, 22 Apr 2022 11:20:53 +0200
Message-Id: <patch-v3-1.1-8b3444ecc87-20220422T092015Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g56a83971f3f
In-Reply-To: <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
References: <patch-v2-1.1-92acf9420a9-20220421T174733Z-avarab@gmail.com>
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
it, so its "cc_package" line wasn't working as intended either.

As a table, this is what's changed by this commit, i.e. it only
affects the linux-gcc, linux-TEST-vars and osx-gcc jobs:

	|-------------------+-----------+-------------------+-------+-------|
	| jobname           | vector.cc | vector.cc_package | old   | new   |
	|-------------------+-----------+-------------------+-------+-------|
	| linux-clang       | clang     | -                 | clang | clang |
	| linux-sha256      | clang     | -                 | clang | clang |
	| linux-gcc         | gcc       | gcc-8             | gcc   | gcc-8 |
	| osx-clang         | clang     | -                 | clang | clang |
	| osx-gcc           | gcc       | gcc-9             | clang | gcc-9 |
	| linux-gcc-default | gcc       | -                 | gcc   | gcc   |
	| linux-TEST-vars   | gcc       | gcc-8             | gcc   | gcc-8 |
	|-------------------+-----------+-------------------+-------+-------|

Reported-by: Carlo Arenas <carenas@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I just dropped the linux-TEST-vars change from the v2 in lieu of
trying to get the wording in the commit message right.

Range-diff against v2:
1:  92acf9420a9 ! 1:  8b3444ecc87 CI: select CC based on CC_PACKAGE (again)
    @@ Commit message
         Furthermore in 25715419bf4 (CI: don't run "make test" twice in one
         job, 2021-11-23) when the "linux-TEST-vars" job was split off from
         "linux-gcc" the "cc_package: gcc-8" line was copied along with
    -    it.
    -
    -    That wasn't a bug per-se, as that "make test" would have run under GCC
    -    8 before the split into two jobs, but the point of selecting different
    -    compiler for these jobs is to get better coverage, and to narrow down
    -    any issues with a given compiler to the job that runs it. Since the
    -    "linux-TEST-vars" job is already special in other ways (in running
    -    with various GIT_TEST_* variables), and we've got the "linux-gcc" job
    -    covering gcc-8 let's have it used the default system compiler instead.
    +    it, so its "cc_package" line wasn't working as intended either.
    +
    +    As a table, this is what's changed by this commit, i.e. it only
    +    affects the linux-gcc, linux-TEST-vars and osx-gcc jobs:
    +
    +            |-------------------+-----------+-------------------+-------+-------|
    +            | jobname           | vector.cc | vector.cc_package | old   | new   |
    +            |-------------------+-----------+-------------------+-------+-------|
    +            | linux-clang       | clang     | -                 | clang | clang |
    +            | linux-sha256      | clang     | -                 | clang | clang |
    +            | linux-gcc         | gcc       | gcc-8             | gcc   | gcc-8 |
    +            | osx-clang         | clang     | -                 | clang | clang |
    +            | osx-gcc           | gcc       | gcc-9             | clang | gcc-9 |
    +            | linux-gcc-default | gcc       | -                 | gcc   | gcc   |
    +            | linux-TEST-vars   | gcc       | gcc-8             | gcc   | gcc-8 |
    +            |-------------------+-----------+-------------------+-------+-------|
     
         Reported-by: Carlo Arenas <carenas@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## .github/workflows/main.yml ##
    -@@ .github/workflows/main.yml: jobs:
    -           - jobname: linux-TEST-vars
    -             cc: gcc
    -             os: ubuntu
    --            cc_package: gcc-8
    -             pool: ubuntu-latest
    -           - jobname: osx-clang
    -             cc: clang
    -
      ## ci/lib.sh ##
     @@ ci/lib.sh: then
      	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx

 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.36.0.879.g56a83971f3f

