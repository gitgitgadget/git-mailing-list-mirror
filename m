Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B421C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 16:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCSQ1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCSQ1W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 12:27:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8751B332
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:27:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v1so2213785wrv.1
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679243239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CvMIvVUG+MWCyyahBy2kTKrtJnLDzOhp9iI7TZG0Fvc=;
        b=C0SlbsfsYsnOlN4l0uhxYi6ac29tIZZbGDnz5mvDtdJjheaQ1sMUMo14odZ4hoPq2K
         qASDexHUZ7/TYXz2I0PWSe77mxadDWTtG316U5uE8sG/q0+bDvqfqZBwJCoMCdLC1ujo
         BgQGpqyu4Aj1G1tqu/tf9WmRdt8IYj7kGWAfrP1mDr2VWMIYvs42u0Cq1xs/SDqFtAPn
         q0l3shBYWVQGd5sf5zmKu4ZY2UZbQfadKekspOE3IY69cIBZYv1LAq09d1aa+H7dqg3z
         +G+X6Hvu3iimKFe5WIIvXJJTqvkIo9jUtIT7bK1nHEfN7BZUVYWhjcD8e70qNB9xu0vC
         y/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvMIvVUG+MWCyyahBy2kTKrtJnLDzOhp9iI7TZG0Fvc=;
        b=WNX1DxandB/Bd0gGQQu4EXnONg8CwIwdLKRc9x0oqDiSyl5tpgE11LGn9gBBuyNUff
         FeTbzm8artY9VIxvIAsUl/xtdCvdqZDV9HVg+6biMy14v3NiqFu/Vj60AlcGy1ogeT4t
         CoME0+hvfJri1SRgheaRqhjOnJhgv823T2y7UVIhjRFiGvGUGR35Fycm5int1ncEjJUB
         GprkTi9Y+GSUJzOcyYB6nPZQIOr9Ye7Nw37XlXzt2TdxJE9BvsBPvuv7wLmGAJt64l5h
         IpgD3fKAxetmnuyMqs9+nCHNAsuVYOKFygfQ50mYO5dO37Lo1PaSrTWMmsq+ODj4y2ID
         Or2Q==
X-Gm-Message-State: AO0yUKWL/1K1oA8hSaQxKlkohZeU1IYCzx0HXJzTJqALMG6p7Y4xuLH7
        rdBLV/pifCJJ3oVUuUfI9V508sHezMY=
X-Google-Smtp-Source: AK7set9/V1HLnsC34ze4RGv9VR22EL1sfoWolLhKzk6qDxZzwS+Y4he/w9AlK7vf7GvsdsdpL/FhYA==
X-Received: by 2002:a5d:6ace:0:b0:2cf:e688:51bd with SMTP id u14-20020a5d6ace000000b002cfe68851bdmr12503315wrw.31.1679243239260;
        Sun, 19 Mar 2023 09:27:19 -0700 (PDT)
Received: from localhost (62-165-236-170.pool.digikabel.hu. [62.165.236.170])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d4f89000000b002cfe466e894sm6909756wru.38.2023.03.19.09.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:27:18 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] Remove unnecessary inclusions of parse-options.h from headers
Date:   Sun, 19 Mar 2023 17:27:10 +0100
Message-Id: <20230319162712.654137-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.40.0.499.g88fa0b00d2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some source files use parse_options(), but don't include
parse-options.h, while some headers do include parse-options.h, though
don't really need it.  These patches fix these issues.

This series has a small and simple conflict with the 'ds/ahead-behind'
topic, and it will have small conflicts with Elijah's header cleanup
series as well:

  https://public-inbox.org/git/pull.1493.git.1679207282.gitgitgadget@gmail.com/T/#t


SZEDER Gábor (2):
  treewide: include parse-options.h in source files
  treewide: remove unnecessary inclusions of parse-options.h from
    headers

 builtin/ls-remote.c           | 1 +
 builtin/pack-objects.c        | 1 +
 builtin/receive-pack.c        | 1 +
 builtin/reflog.c              | 1 +
 builtin/send-pack.c           | 1 +
 diagnose.c                    | 1 +
 diagnose.h                    | 3 ++-
 list-objects-filter-options.c | 1 +
 list-objects-filter-options.h | 3 ++-
 ref-filter.h                  | 2 +-
 remote.c                      | 1 +
 remote.h                      | 2 +-
 revision.c                    | 1 +
 revision.h                    | 3 ++-
 send-pack.c                   | 1 +
 15 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.40.0.499.g88fa0b00d2

