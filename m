Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75FB11F462
	for <e@80x24.org>; Sat, 27 Jul 2019 20:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbfG0U2D (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 16:28:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41726 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0U2D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 16:28:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so25897842pls.8
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKIsvC2375e7HLSn/vH5hJWZeEjTHtLOJlUs665wMGA=;
        b=X1iniDqPJcPZ1Q2/uW07VkFyqsf8hCGr5Y5l2cGR59iS83IjAy4aT/bVLEq7jKcS1I
         u10imPFFxD2rER+gdkwotvlNj09L0RcwDHiQYDmCixep4S3ydSNac0Ls7RrmXEQPuRay
         aWZKl8BMjvX2Z1ATze85e5oeEdBaXvDyXf2DdQ3zMx2cgX2VZ5owkA+1bGcse3x88BHw
         Jo+ye50MeL+/Xf2nua+novVySE7pZ6NWUNy0rwRs/8hkSUPBel/J25RQDNCFpwooiZNI
         kDs+fBZ0yUgVwRpyfyYVJNkj+0FHQ8LqnR3MLvyWb63Jd7mTnQw4TdntqC91AT6GrMTj
         vlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hKIsvC2375e7HLSn/vH5hJWZeEjTHtLOJlUs665wMGA=;
        b=U4tOI1Wo31nI05m516+NRd9MzfLd4cq9cuiMjfG1WW9eRqrX2YqY5D/AvvtAeZWdc6
         i4A5VvF+fILjEBf8z1K8h88YLFKalVmQ3X4llU3e9wOxkSFhRheZAFvb5VALssb/z0Sn
         WHT0ssLQN3uxqyWC6WBkyo9sFEQMDLqi4NlLaEuWiom20DpBww4MY+E6ygXlNbig4w++
         KVBCEHmBuL08KrDMfWf8F6HwhDU1xn2L3bpElGArPKyE7ToM8e2Ji9+pLuvhy8cDn6Al
         r/D/fEZjwdLMhO/t0j1D9uoGDzKND/gayFbphARNT7kkRYlGeIEjr9bFqtskZuOCx7WK
         2KtA==
X-Gm-Message-State: APjAAAWWTuqd4f+W/kuPhad+VjNcsgaoReVuUVktu6ZsdtSQRj5AYtFZ
        43IQJfN1+t0320VLp2O7Pkm+bVt9lw0=
X-Google-Smtp-Source: APXvYqzByYLwRNqgYdJbvyhr88Y1THAUyZcISco7Ld99VUkg8W5iJ6shelDbEiHktD9jPgipzyj5pQ==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr101831345plc.2.1564259282320;
        Sat, 27 Jul 2019 13:28:02 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id t8sm64671302pfq.31.2019.07.27.13.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Jul 2019 13:28:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [PATCH 0/3] grep: memory leak in PCRE2
Date:   Sat, 27 Jul 2019 13:27:56 -0700
Message-Id: <20190727202759.22310-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a small memory leak that was introduced when PCRE2
support was added, and that should be visible with t7813 and valgrind

Applies cleanly to maint and master but will conflict slightly with
ab/no-kwset (currently in next) and most likely other changes introduced
about this same codebase (ex: ab/pcre-jit-fixes) but hopefully the
spreading on short simple commits helps with reviewing.

Carlo Marcelo Arenas Belón (3):
  grep: make pcre1_tables version agnostic
  grep: use pcre_tables also for PCRE2
  grep: plug leak of pcre chartables in PCRE2

 grep.c | 12 ++++++------
 grep.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.22.0
