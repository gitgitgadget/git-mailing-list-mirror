Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F119C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A005208A9
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heluHGDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgHZL5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbgHZL5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 07:57:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE42C061757
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 04:57:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so896655wmb.4
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9eP1oJPL+DnoKjCGcyUvQ/XkzCJUJMyeq6vX3BH4ww4=;
        b=heluHGDCWuwN8hyeEh4YuoUGuF3hRg1i5nj8uthlEuPl3wJRZRVngb3AVV0dY7u8rj
         SE5QpN0fpXdvnTtCWSUUGLvJ6IvfMBUEdYGlWhGIdyvnsITvcXs6jPBNMojgd8+5SvZv
         0XQsfGsrjBDMypLYiKB7VFDFFjzOlxbg6+HYBhuDgyINBYOAt/ET+HO9Mocm8q+Pf7X2
         92JFXsz5Gbx+NXonY2F80mXMYPtKiA1AcDscErlf4A2tawZsmlRXeivV91YdwYMQ0Jmx
         HwuurZ1iD/uy15hJ4ZdLZcbQsJx56U0zCkB/FggNG1yRQbpgXn+H31FGclFCOQJsPeto
         ztAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9eP1oJPL+DnoKjCGcyUvQ/XkzCJUJMyeq6vX3BH4ww4=;
        b=S3RJdOnZxPuRyg+PfRw1QqOJLRyn8XCS6XqhYWi2q0BBeq8kDQFMn2NQpUv9ejD3nG
         f7yeePKkN8UHPXIWHMaZnUHV5rDILmR2Vkam76WizcqB2daIyqCOF0Q7yGsW80BjHhrF
         sgyus+rQhJXSWHzEQDVN660PyESIWxdkWTftYMgGIHItPEDs/uzLxbZojMNhAa6Ioj1k
         rWovUxCfZ1Tw8QxfYNkxe55B2BXfiCeG6Z5DWL/UhJIcrf+U8iJHM+o9qJwwduG+ZHH0
         nf6g5C99SGcLTUQOP1+Ogfv7oUsPV+pVuP+/NLB9/DzfUPkKPozuhXw2/W+Kac/N47mA
         ggtg==
X-Gm-Message-State: AOAM530MlIcIdrW5wsL3louJseSxB3PoIYTetRF3dSOfzNs+tsYjZMwv
        l1m+RNLOWvDKb4hs66aKxI58Ieh2PME=
X-Google-Smtp-Source: ABdhPJzL/iSShSOqSsJblGqhLEuov8gOQ7W9VeMMV1rOFMq2E8tkYsAuq2DUHwBYbmZc25+D1tawXg==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr6757517wmc.188.1598443020748;
        Wed, 26 Aug 2020 04:57:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm5606300wrx.90.2020.08.26.04.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 04:56:59 -0700 (PDT)
Message-Id: <99a53284925315995e30d417cb58dfb176b036ed.1598443012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
References: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Aug 2020 11:56:52 +0000
Subject: [PATCH v3 3/3] ci: stop linking built-ins to the dashed versions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Originally, all of Git's subcommands were implemented in their own
executable/script, using the naming scheme `git-<command-name>`. When
more and more functionality was turned into built-in commands (i.e. the
`git` executable could run them without spawning a separate process),
for backwards-compatibility, we hard-link the `git` executable to
`git-<built-in>` for every built-in.

This backwards-compatibility was needed to support scripts that called
the dashed form, even if we deprecated that a _long_ time ago.

For that reason, we just introduced a Makefile knob to skip linking
them. To make sure that this keeps working, teach the CI
(and PR) builds to skip generating those hard-links.

This is actually not such a big change: e4597aae6590 (run test suite
without dashed git-commands in PATH, 2009-12-02) made sure that our test
suite does not require dashed commands. With this Makefile knob, the
commitment is just a little stronger (running tests with `--with-dashes`
would _still_ not see the dashed form of the built-ins).

There is a subtle change in behavior with this patch, though: as we no
longer even _build_ the dashed executables, running the test suite would
fail if any of Git's scripted commands (e.g. `git-request-pull`) still
This would have succeeded previously (and would have been unintentional,
of course) because `bin-wrappers/git` sets `GIT_EXEC_PATH` to the
top-level directory (which would still have contained, say,
`git-rev-parse`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6c27b886b8..1df9402c3b 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
-make
+make SKIP_DASHED_BUILT_INS=YesPlease
 case "$jobname" in
 linux-gcc)
 	make test
-- 
gitgitgadget
