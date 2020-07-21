Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9380CC433E3
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 16:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735F7207CD
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 16:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8I1lEjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgGUQMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgGUQMm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 12:12:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E80BC061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 09:12:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bm28so15723411edb.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ju9NpWjLAT6f+8ix84TbxLb0p0hNce9QsA2V5cnrjdU=;
        b=S8I1lEjYozK644I+spdDoWXcO44me3Jkiv0TnHTLXoE0eIOF85RQkoCs9QAcr8sRwG
         8OjtGv9igaHgT4M5Ab7xWw0RTiyTMzEQ955B8vJFXxfNd55aauTJq/o4gCbJX1ScJUFw
         lA60PqcRuEcVECTaCrsyccNufTkACYHmRqtuyZqyQt8LTA7xDAyswHxaklFCWLTvIRx3
         SvGq4gpmIJqkWTxdMAFV7YkhzwRS1moi3tJcf5X9ca+jg1diCdRNTs78ItaN0+w/Aaco
         JsToHH/tqUYKunk44PmRpYMCORPYPPMeuPT/WA2QOqTuSF6Hddn1kFRV3uAEXNaFP9pv
         Waig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ju9NpWjLAT6f+8ix84TbxLb0p0hNce9QsA2V5cnrjdU=;
        b=fzKt8RS0jCWmNXXqR7P9aiLM7Nd1bVwPynCZ5/PvfLxiPCKyt6yifR0FQxDQsTWtxL
         FW8Qp5fK73O0CrkIaleZP8Uu4rYnn4rip/MmFdosaS4hJoa2wXJl1vwT/jgmm1rG9WhJ
         bKyvc8YhOd8Rn0/SDM3UhLIbSTg50C8ygzm/zaudkK/GU3kltUZfva3ye7NvpOlt3oQp
         T7s206TeI/206yAAHtqR0WRVGQNwWYFw33gznFuKSz+C0moI9Uj3vqpOniy1i8d1aL87
         /gYUfniWUkXmd6QWuDxQQz/nHZWPTNSQ6sxl5e8kugEmcAGnRVAMLa+akcRPdpNE7ViP
         qSIA==
X-Gm-Message-State: AOAM531gdsJ76dkd6Na/803OwRKrbPy7VuyJV8LemJ7fY3laBRtKAryS
        02i3Fos4qLPOOQ2lh9xVUfwpqCpC
X-Google-Smtp-Source: ABdhPJyLDvGCPSu7oljtL8B0+vUbW+pez+b9acQBc246qtlbU/5MWSlbKE5ziwFeX/jo9WbUgJgY5A==
X-Received: by 2002:a05:6402:319b:: with SMTP id di27mr1248884edb.133.1595347960540;
        Tue, 21 Jul 2020 09:12:40 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-71.pool.digikabel.hu. [78.131.17.71])
        by smtp.gmail.com with ESMTPSA id v3sm623512ejx.91.2020.07.21.09.12.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 09:12:39 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] [RFC] travis-ci: remove bogus 'pyenv' in the Linux jobs
Date:   Tue, 21 Jul 2020 18:12:25 +0200
Message-Id: <20200721161225.6769-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.28.0.rc1.319.g12ef029c8a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our test suite, when 'git p4' invokes a Git command as a
subprocesses, then it should run the 'git' binary we are testing.
Unfortunately, this is not the case in the 'linux-clang' and
'linux-gcc' jobs on Travis CI, where 'git p4' runs the system
'/usr/bin/git' instead.

Travis CI's default Linux image includes 'pyenv', and all Python
invocations that involve PATH lookup go through 'pyenv', e.g. our
'PYTHON_PATH=$(which python3)' sets '/opt/pyenv/shims/python3' as
PYTHON_PATH, which in turn will invoke '/usr/bin/python3'.  Alas, the
'pyenv' version included in this image is buggy, and prepends the
directory containing the Python binary to PATH even if that is a
system directory already in PATH near the end.  Consequently, 'git p4'
in those jobs ends up with its PATH starting with '/usr/bin', and then
runs '/usr/bin/git'.

So remove 'pyenv' in Travis CI's Linux jobs to prevet it from
interfering with our 'git p4' tests.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Notes:
    This issue triggered test failures in all 'git p4' test scripts in the
    recent GIT_TEST_DEFAULT_HASH=sha256 test runs, because the system Git
    doesn't understand the 'objectformat' extension, e.g.:
    
      https://travis-ci.org/github/git/git/jobs/710159470#L3267
    
    This is not an issue in Travis CI's macOS jobs or on Azure Pipelines,
    because they don't use 'pyenv'.
    
    However, perhaps removing 'pyenv' is not the best solution here.
    
    We set PYTHON_PATH in 'ci/lib.sh', which is sourced at the beginning
    of (almost) all of our CI scripts.  Consequently, in these jobs we
    first run 'ci/install-dependencies.sh', which sources 'ci/lib.sh',
    assigns PYTHON_PATH=/opt/pyenv/shims/python3 (which is never used),
    and removes 'pyenv', and then run 'ci/run-build-and-test.sh', which
    sources 'ci/lib.sh' and assigns PYTHON_PATH=/usr/bin/python3 (which is
    then used in the build process to set 'pit p4's shebang line).  Not
    really nice, is it.
    
    Alternatively, we could avoid the PATH lookup and thus the bogus
    'pyenv' by explicitly using '/usr/bin/python{2,3}'.  The Linux images
    in both Travis CI and Azure Pipelines are standard Ubuntu images, so I
    think we can safely rely on these Python paths.

 ci/install-dependencies.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 0229a77f7d..b4bdcbcba2 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -36,6 +36,14 @@ linux-clang|linux-gcc)
 		tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
 	popd
+
+	if test true = "$TRAVIS" &&
+	   pyenv_root=$(pyenv root)
+	then
+		# pyenv in Travis CI's current default (xenial) Linux
+		# image messes up PATH for 'git p4'.
+		sudo rm -rf "$pyenv_root"
+	fi
 	;;
 osx-clang|osx-gcc)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
-- 
2.28.0.rc1.319.g12ef029c8a

