Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818961F404
	for <e@80x24.org>; Mon,  2 Apr 2018 22:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754746AbeDBWtH (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 18:49:07 -0400
Received: from mail-pl0-f51.google.com ([209.85.160.51]:46896 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754709AbeDBWtG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 18:49:06 -0400
Received: by mail-pl0-f51.google.com with SMTP id 59-v6so3431778plc.13
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9kybc9VI9rshQSr3+DIFXR90/lUZ10hWCzZN2qcQdQM=;
        b=dQstrzXkAf74UpUSfn9dyTsbewLeI/z00rBF29aNlAKDJH4bCKt7GSrUXzPUAaSwpE
         oXsV+kgQVFEnJ+o1ZkJJE2VcMs2ia+Mubg997TG8QdH18/S5ExR9FZm323qS6JUGekSM
         gNHwqsEu5L1fTmPj+IpLuqwwsvnR8J+Wp9OgSOgKxpTUHYERieHktGEr9ljLSp/4BF97
         k8YoA++9aBaZVlUqIwfMMrUOvPNekS1hBrpChBRzq2t0Io/JrRUjTdkjLa/281N0hUkQ
         xlBS4BRU9Xdtt7W9Q8+U5ao65rw8/AE7tza+05jr1SneFcrdHRjxT1LWBpxu9B2m8MEI
         39Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9kybc9VI9rshQSr3+DIFXR90/lUZ10hWCzZN2qcQdQM=;
        b=dzG8A/raxB28VNijmJBmHwpv1VYl5Y03mVdvaPG/wGC+FIXAZmJJiOmWVd9RD5Wfyq
         T/VQlGC7oBQp3NL6HY62qFsOegj2cN6dqMfo0gyWb/NIYzSm1NtPf06IJUntq4hihlgf
         XX7yREsogbK3yZA5gAWEGH0+/0moGntxT2anpOi62ufrX1PYHpyqzEL5kdZ/rCANTgvl
         DdC8CVnDGMbygROVWzC36gc6xwA4u1p7YBU/rBTUpI7IM09uaA7mCBqOYRdhAcYfJWzx
         L8hOhgbsYBkVSolsoTPNE76lDrO8nKF4E2+LJJFVCUwtnzuTptRx1ajXWgNY10o/6/bM
         ExHg==
X-Gm-Message-State: AElRT7H8SQXjOeEEk6Onj098YQHuRzAvqO8uqLUQecSHH86Zgo0c0J++
        7Q1Fy1wjAM5KnA8RyKgetXUFasYu6xU=
X-Google-Smtp-Source: AIpwx4+9O3ZiSwAoQW2f/EfF9UlDyc+5t1nLrW5qyvoLUnrdyzsWhnbV4s5vHAtsfNEihpgrCkzE/g==
X-Received: by 2002:a17:902:9898:: with SMTP id s24-v6mr11511269plp.318.1522709345074;
        Mon, 02 Apr 2018 15:49:05 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d77sm2654410pfe.127.2018.04.02.15.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 15:49:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com, jacob.keller@gmail.com,
        simon@ruderich.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 0/7] Moved code detection: ignore space on uniform indentation
Date:   Mon,  2 Apr 2018 15:48:47 -0700
Message-Id: <20180402224854.86922-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-attempt of [1], which allows the moved code detection to
ignore blanks in various modes.

patches 1-5 are refactoring, patch 6 adds all existing white space options
of regular diff to the move detection. (I am unsure about this patch,
as I presume we want to keep the option space at a minimum if possible).

The fun is in the last patch, which allows white space sensitive
languages to trust the move detection, too. Each block that is marked as
moved will have the same delta in {in-, de-}dentation.
I would think this mode might be a reasonable default eventually.

Thanks,
Stefan

[1] https://public-inbox.org/git/20171025224620.27657-1-sbeller@google.com/

Stefan Beller (7):
  xdiff/xdiff.h: remove unused flags
  xdiff/xdiffi.c: remove unneeded function declarations
  diff.c: do not pass diff options as keydata to hashmap
  diff.c: adjust hash function signature to match hashmap expectation
  diff.c: refactor internal representation for coloring moved code
  diff.c: decouple white space treatment for move detection from generic
    option
  diff.c: add --color-moved-ignore-space-delta option

 Documentation/diff-options.txt |  13 ++
 diff.c                         | 155 ++++++++++++---
 diff.h                         |  18 +-
 t/t4015-diff-whitespace.sh     | 341 ++++++++++++++++++++++++++++++++-
 xdiff/xdiff.h                  |   8 -
 xdiff/xdiffi.c                 |  17 --
 6 files changed, 483 insertions(+), 69 deletions(-)

-- 
2.17.0.484.g0c8726318c-goog

