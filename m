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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654C1C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E809610F7
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhFOSeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhFOSeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 14:34:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D841C06175F
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:32:04 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so15275034otk.5
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6zRff1ZSORVRPj1LEBPx5q9MAR5ayAZLpLEY9GV55I8=;
        b=EpwdgxGafT8kmHIf9qfmmxU7A0vB6jXG1aoTekvZKS5vdYgRkL3w5uW4EEqpr+JeyE
         aJ76Zpb0g9qbyxVKPlihpWC6EuwsuEbNGRrYWtP3n2PcrPYTl966MVGvS2wHmZpk2w7r
         jMFKR7VOSpvSeQ2vGIaYEFudaxe+noRRPkUzvvdRXn4DmQfvr66kjWLuP73MwfguOvnp
         NpREJUO6HEWozZChDrD4atVh8eWB4OwbwrMvYCaeNVi/PUZ0Gbz379V6YlbDbgZ2sxOv
         Q2cqnyiVJE6w7cxhb56dkWn7YLfravIe+3K1F1iIgFTy7xp6Ay77KGgPgoJ939j1SvN/
         FNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6zRff1ZSORVRPj1LEBPx5q9MAR5ayAZLpLEY9GV55I8=;
        b=dwrXEtrPJwAXEUZBQvsrQcEwEgqoFgADH8UHNOrlF4UnDVJq97rkrZQr1upsFVF4Q6
         6zvpnuU0cIWQUeNmTuDoA4+n7D3efr8hdPUk4cXtrz6BOyVD7jpprFKpuSIgxUGDGiPa
         6R0RWeTFKlo7mFOUMCCai47aMWR4/1tGnKlVTsW4UWW57PtPV4OHyoav4xDO+YGdvXty
         UWZ6BR877wF2l59yGjsYWIxQs/c+Jwaqy83NAefaZn8MTzExjhH2bhzE++tZ7R2Nkjz1
         GGaYzezLXaRhm5jgUEvYXiUNBTjIz5SG5/N6yVprBw8xRe7Kx+TNF1XsZ6rBUyC2y081
         nrLA==
X-Gm-Message-State: AOAM53262J8iXqiY72MVbCZ2zKzXEg2qfx3gz+ypk8KCXXAUfvQEq4o0
        YZco+wZhlXBu7iLCwCHsQhP7LXycx6duUw==
X-Google-Smtp-Source: ABdhPJzByBU0OxFG5t8pWkcjM1h83M8JIoKplBvXPgxwCS+lDUb8kB7Im4pNKBEVr5JqlJaaD4+0Wg==
X-Received: by 2002:a9d:3e8:: with SMTP id f95mr488493otf.53.1623781923633;
        Tue, 15 Jun 2021 11:32:03 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p6sm2143341oot.28.2021.06.15.11.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:32:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2] test: fix for TEST_OUTPUT_DIRECTORY
Date:   Tue, 15 Jun 2021 13:31:57 -0500
Message-Id: <20210615183157.104999-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
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

Since v1 I completely changed the approach and instead of using --root
which leaks test results, I remove TEST_OUTPUT_DIRECTORY from
GIT-BUILD-OPTIONS.

Apparently only people who would care are the users of
t/valgrind/analyze.sh which now would need to specify that variable
themselves.

Marginal convenience for the users of an obscure script is not a good
reason to break t0000-basic.sh.

Range-diff against v1:
1:  04047359b9 < -:  ---------- test: fix for TEST_OUTPUT_DIRECTORY
-:  ---------- > 1:  d8430aee08 test: fix for TEST_OUTPUT_DIRECTORY

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
2.32.0

