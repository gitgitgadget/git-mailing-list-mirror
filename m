Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743CFC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D00560F5A
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhKBMaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhKBMaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 08:30:09 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0917C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 05:27:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b71so4004118wmd.2
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2OYZfL9SRn5IRgpOpTnH35YrlP+TgIADx/mAqsiLuNA=;
        b=KJyKsNsgLYkz1Wsq/XUJ/G7BalLw0LzTY0yRV2nrlb16tBRQMewPaztULWTvacmgtJ
         cDIQQSaJ/vHM+5DThanJxFaS7WJfsPGxdXFHy74BEAgMstjMKOl8ZcaOgU2qxy5n6wyq
         vj3j6vTizXA6Da5L8bi7g7rg6xILU7GNcYcpwCRlfVFpoqWPf3kMGhQ8gcFwBCT1GCsS
         8h+PeiIIW8sJH67E5YqG+eqx7xrS2MirKMQven5Gh88ai2nwaZcHY/82WKeqGe40KzFc
         UwxVs+PEbqt6V/XGtWdF/lriD21YRByrN3v8Ilo6yfcUJCnpOAYBDpH3hrWl6hWxX/qt
         GEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2OYZfL9SRn5IRgpOpTnH35YrlP+TgIADx/mAqsiLuNA=;
        b=CxpN1sZ5Qu8CmH8iHqEE5U5XvmqTsucJBRC7E1JSc6TFbpo8ho3CfD+pJU+G5zaU2b
         BY6V/LMrrI7v3+U46ZOgJgic8PJHutg+mRegAzz9ixiaJvd1J4Rgexut3Bb04nrsLXMx
         rc0L9b6tQiUSkohPgTyf1AuDhWQJ3GUPe9KAGCusnslEvHXgOr98dbzTTJ9WkFbkCydQ
         j/08wT7rsc7qzR7Phm4gvnJNp38atvHS21PgxnCa/RL4/0q9u3m3qmWnV91yV1KmyCwH
         msd+7J4ffQHO3OKdS8PigPZT3anusvMPKk28x1Lzu6Do/oKgj2KiHNcRHX4tHPsoIPz5
         RkuQ==
X-Gm-Message-State: AOAM530IasfZUKExK2FpkjkeBvnUMgXb83S5JwKCzAaFDpqU7TcNSdFL
        bLnPEKO0PR+4feHyqEUblZttUKe/YsT7eA==
X-Google-Smtp-Source: ABdhPJwZVXYQOlhENbzYr1dj+R4KgXo84Rm4r9A95aF01gfCCDQ3rxafmdoyHPo/Cve37BbKWLLoxg==
X-Received: by 2002:a1c:4c19:: with SMTP id z25mr6659976wmf.177.1635856053049;
        Tue, 02 Nov 2021 05:27:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q84sm3332236wme.3.2021.11.02.05.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:27:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 0/8] progress: assert "global_progress" + test fixes / cleanup
Date:   Tue,  2 Nov 2021 13:27:22 +0100
Message-Id: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
References: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A minor but important fixup of v5[1], as pointed out by Carlo Arenas
the STDIN_FILENO I added in response to feedback in an earlier re-roll
had a pretty bad off-by-one bug.

As an aside that we have no tests for this "git bisect" code at all is
pretty bad, I'll try to address that separately from this series.

https://lore.kernel.org/git/cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (8):
  leak tests: fix a memory leaks in "test-progress" helper
  progress.c test helper: add missing braces
  progress.c tests: make start/stop commands on stdin
  progress.c tests: test some invalid usage
  progress.c: add temporary variable from progress struct
  pack-bitmap-write.c: don't return without stop_progress()
  various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
  progress.c: add & assert a "global_progress" variable

 builtin/bisect--helper.c    |   2 +-
 builtin/bundle.c            |   2 +-
 compat/mingw.c              |   2 +-
 pack-bitmap-write.c         |   6 +--
 progress.c                  |  23 +++++++-
 t/helper/test-progress.c    |  52 +++++++++++++-----
 t/t0500-progress-display.sh | 105 ++++++++++++++++++++++++++++--------
 7 files changed, 150 insertions(+), 42 deletions(-)

Range-diff against v5:
1:  0c0e5bfc656 = 1:  88d89652831 leak tests: fix a memory leaks in "test-progress" helper
2:  0ae86e40e16 = 2:  2fa92e7db83 progress.c test helper: add missing braces
3:  767aa010026 = 3:  400b491449e progress.c tests: make start/stop commands on stdin
4:  9bcc8cfc9d2 = 4:  7557975a122 progress.c tests: test some invalid usage
5:  3a95613cd04 = 5:  61c8da31aeb progress.c: add temporary variable from progress struct
6:  0300b802dcb = 6:  f6a76b80e91 pack-bitmap-write.c: don't return without stop_progress()
7:  4795d4835b0 ! 7:  1a2eadf28d0 various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
    +    various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
     
         We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
    -    only these two used the stdlib.h macros to refer to them.
    +    and around 10 "isatty(0)", but these used the
    +    {STDIN_FILENO,STD{OUT,ERR}_FILENO} macros in "stdlib.h" to refer to
    +    them.
     
         Let's change these for consistency, and because a subsequent commit's
         commit message outlines a recipe to change all of these for ad-hoc
    @@ builtin/bisect--helper.c: static int bisect_autostart(struct bisect_terms *terms
      			  "start\"\n"));
      
     -	if (!isatty(STDIN_FILENO))
    -+	if (!isatty(1))
    ++	if (!isatty(0))
      		return -1;
      
      	/*
8:  e58f4a0c1b9 = 8:  bff919994b5 progress.c: add & assert a "global_progress" variable
-- 
2.33.1.1570.g069344fdd45

