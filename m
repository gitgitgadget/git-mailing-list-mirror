Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDAEC07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 03:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDF761CAD
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 03:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhGGDJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 23:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhGGDJx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 23:09:53 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5C5C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 20:07:13 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so860925otq.11
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 20:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z0ohUL0aKJmvYIwCluIzTM4BxOpaEmmPUH5CDUg3ZE4=;
        b=ayEkjY4PtrWZpvtAvxGytfp3MurDVusgIxOvqUmBMaFKtUUCwB7/xLVsGPKQt+JWC9
         xwMf1BUmx3LqnGR1aj+RCZo65smDCp9WTRsN+tiZHN484T3w5vO6BK8vRA4osaGJBsfh
         bTIPaBsy1bDMe8zOLtkrmMpmUXelEiH3Fz72rFwmOaHHa+HLcxusgTk7M8zkzLEotCxz
         vVkwXH/bR8Cn8Y6qK9X57FMuCe2AKv37Ma+QmFdKymntHszYHhYpRBEBhY5BqyeGsaDu
         aZCWpgRSW4jjZec/o0eYKJND025Pr5K8qYkfu+gcq0Xf/mRpgeufaYGXJohrR+EFbUcE
         jpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z0ohUL0aKJmvYIwCluIzTM4BxOpaEmmPUH5CDUg3ZE4=;
        b=bbCR9a7VlZTBlXgOOG+pjJwVouZKYm8CJI9v55kRmnYSm/P3/1ZgG//fzleycwyKrt
         I8aLiXi5Cj54VCsqbYVqtim9xSozfER3rQKoEsa2QIZwEAcxbPc9rjrknZ1Ap1FNkudk
         Y2TL8jCjy6WRcxlFug+yJrXxK/IqNQTFrvo+IFPe/E3QfR2E+L5OZa0mDGx0iHo/PjN8
         CM9iLIYyWAXxm+urZYI383/jeJCouqIwHDwh3MH5z+2KDOu9SzqEHNAH3yOwktt6nq7j
         WHNdf2ovHUdZOU2WZmKlpilorSlnwry9dJ7xosjNpYbpnOo8P+w55Hf58RFFqk8lyq4K
         v3lw==
X-Gm-Message-State: AOAM531j8cJCHZq/v0fAnneNt4HU8Go/BJ4My7lYgbQIL58bdghNRC17
        yqDZWGUGtUrL9dTLStEAE1IviSLjxcE=
X-Google-Smtp-Source: ABdhPJwADVKrT5ax+xuyBQS1/PocbCZYli/MjhrKYd7chiTXVBsN1zrAoZWfVqc8z2ctkVXZwS1DZg==
X-Received: by 2002:a9d:24e8:: with SMTP id z95mr11747128ota.326.1625627232351;
        Tue, 06 Jul 2021 20:07:12 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id b10sm3850676oiy.4.2021.07.06.20.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 20:07:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 try2] test: fix for TEST_OUTPUT_DIRECTORY
Date:   Tue,  6 Jul 2021 22:07:09 -0500
Message-Id: <20210707030709.3134859-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_atexit unit test relies on the specific location of the
generated files.

When TEST_OUTPUT_DIRECTORY is unset, _run_sub_test_lib_test_common sets
it to pwd, which is two levels under the pwd of the parent unit test,
and the parent can find the generated files just fine.

But when TEST_OUTPUT_DIRECTORY is set, it's stored in GIT-BUILD-OPTIONS,
and even though _run_sub_test_lib_test_common correctly overrides it,
when the child script is run it sources GIT-BUILD-OPTIONS and
TEST_OUTPUT_DIRECTORY is overridden.

Effectively both the parent and child scripts output to the same
directory.

  make TEST_OUTPUT_DIRECTORY=/tmp/foobar GIT-BUILD-OPTIONS &&
  make -C t t0000-basic.sh

We could try to specify --root, as 6883047071 (t0000: set
TEST_OUTPUT_DIRECTORY for sub-tests, 2013-12-28) suggested, but then the
results of subtests would leak out because TEST_RESULTS_DIR would not
be changed from the parent.

Instead, let's revert part of 2d14e13c56 (test output: respect
$TEST_OUTPUT_DIRECTORY, 2013-04-29) by removing TEST_OUTPUT_DIRECTORY
from GIT-BUILD-OPTIONS.

It's unclear how much value t/valgrind/analyze.sh provides today, but
users of that script that use TEST_OUTPUT_DIRECTORY as well can simply
call the script with that variable in the environment.

It doesn't make much sense to break t0000-basic.sh for users of
TEST_OUTPUT_DIRECTORY, just to provide a little convenience for the
users of t/valgrind/analyze.sh.

Presumably this was broken since 900721e15c (test-lib: introduce
'test_atexit', 2019-03-13).

Cc: John Keeping <john@keeping.me.uk>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
Range-diff against v1:
1:  04047359b9 < -:  ---------- test: fix for TEST_OUTPUT_DIRECTORY
-:  ---------- > 1:  681cbe84b4 test: fix for TEST_OUTPUT_DIRECTORY

 Makefile              | 3 ---
 t/valgrind/analyze.sh | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/Makefile b/Makefile
index c3565fc0f8..2e25489569 100644
--- a/Makefile
+++ b/Makefile
@@ -2790,9 +2790,6 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
 	@echo X=\'$(X)\' >>$@+
-ifdef TEST_OUTPUT_DIRECTORY
-	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
-endif
 ifdef GIT_TEST_OPTS
 	@echo GIT_TEST_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_OPTS)))'\' >>$@+
 endif
diff --git a/t/valgrind/analyze.sh b/t/valgrind/analyze.sh
index 2ffc80f721..378d0a8daa 100755
--- a/t/valgrind/analyze.sh
+++ b/t/valgrind/analyze.sh
@@ -1,8 +1,5 @@
 #!/bin/sh
 
-# Get TEST_OUTPUT_DIRECTORY from GIT-BUILD-OPTIONS if it's there...
-. "$(dirname "$0")/../../GIT-BUILD-OPTIONS"
-# ... otherwise set it to the default value.
 : ${TEST_OUTPUT_DIRECTORY=$(dirname "$0")/..}
 
 output=
-- 
2.32.0.36.g70aac2b1aa

