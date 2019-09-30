Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A938A1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfI3BvK (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46992 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3BvK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id 201so6389458qkd.13
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+59ScLgg6gvCPiPaVrgq45X0/YVz/3sa5rzKCPOuJo=;
        b=XpvuILXFfILWfPlwk1oV79SuUaT7b+fj007zNZFSHE7M+5xFMOXyBi7PDGhyNk0xkV
         EuGKHBWCTmZZ3VrNFZ5AXuDpwa6TVqHMqqyo0fvJgt05HOP9XWm+uiMQdY7Hsu/QxW7u
         aprlrdTxqsmS3SZeFwxi6r5YbV/TM/5a/TlN838LV9q0Ra6IgAB44qACQhmTZ8s3aSZm
         h56lKwuwhHKCUmy1r9EBNOSRDxm0tWFAegsqXVkGaggpFYa0JR7QxIm3EvBZzhNmMzp1
         QQYAHHwYk+TWDLA0IZInYcrtGjfDuRvnMihEpR8dv5jx2/7ZBrGVm9ZVXHoke0hScVDa
         1dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+59ScLgg6gvCPiPaVrgq45X0/YVz/3sa5rzKCPOuJo=;
        b=r7TyE97TRAcfmcmDgevcv+sc5FpzCdxOzfdZUTzaz3Q4d2H76fEbGivHX9/TlFntmx
         ItiFtsXGnn5s9M0xpak72CD0MIs8RQ34dtW3q5gCcQy25ANMXPPDZJ4ww+hWUp0m0CPm
         C5tRhtdq8AzHNkGMkMh9UzL6tROeuXeaQUYqbTOpRo4jRPGOedpDOz2hGufe3losIiL2
         J5n9mYgmK2ZiNYPVidjyETLXzwL9nIfvtJU1z60myIgLojGKw+gWyHW09/S63FPC4DJD
         OX+VZt0DfLBAij+l6i/JLswiLircOlmPszx4ovT1Vb/pe+ZeCdj8SIsneYkFk1yoHoJh
         wyUA==
X-Gm-Message-State: APjAAAVbmEd3eLkgnySx62/NCdPNalJd7neeXU26Xqr+aijZofu85ooQ
        H+rSWwCZsN91Q7+HSbY1zWfd+EsvXKI=
X-Google-Smtp-Source: APXvYqze5zsm6dgRkWAvWb5E6TeyXGgQgK6u2LaUk2P1+d5gRVVHuP9v6pWAfOPtwhhcnSZWDbZsWw==
X-Received: by 2002:a05:620a:119a:: with SMTP id b26mr16577949qkk.39.1569808268889;
        Sun, 29 Sep 2019 18:51:08 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:08 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com
Subject: [PATCH v2 00/11] grep: improve threading and fix race conditions
Date:   Sun, 29 Sep 2019 22:50:46 -0300
Message-Id: <cover.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1565468806.git.matheus.bernardino@usp.br>
References: <cover.1565468806.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series focus on re-enabling threads at git-grep for the
non-worktree case. They are currently disabled due to being slower than
single-threaded grep in this case. However, by allowing parallel zlib
inflation when reading objects, speedups of up to 3x were observed.

The patchset also contains some fixes for race conditions found in the
worktree git-grep and thread optimizations to hopefully increase
overall performance.

This version was almost entirely re-written from scratch so I thought a
range-diff wouldn't be very useful. The major differences from the first
one are the race condition fixes and being able to run --textconv and
--recurse-submodules threaded now.

Matheus Tavares (11):
  grep: fix race conditions on userdiff calls
  grep: fix race conditions at grep_submodule()
  grep: fix racy calls in grep_objects()
  replace-object: make replace operations thread-safe
  object-store: allow threaded access to object reading
  grep: replace grep_read_mutex by internal obj read lock
  submodule-config: add skip_if_read option to repo_read_gitmodules()
  grep: allow submodule functions to run in parallel
  grep: protect packed_git [re-]initialization
  grep: re-enable threads in non-worktree case
  grep: move driver pre-load out of critical section

 .tsan-suppressions         |  6 +++
 Documentation/git-grep.txt | 11 +++++
 builtin/grep.c             | 90 +++++++++++++++++++-------------------
 grep.c                     | 32 ++++++++------
 grep.h                     | 13 ------
 object-store.h             | 37 ++++++++++++++++
 object.c                   |  2 +
 packfile.c                 |  9 ++++
 replace-object.c           | 11 ++++-
 replace-object.h           |  7 ++-
 sha1-file.c                | 57 +++++++++++++++++++++---
 submodule-config.c         | 18 +++-----
 submodule-config.h         |  2 +-
 unpack-trees.c             |  4 +-
 14 files changed, 205 insertions(+), 94 deletions(-)

-- 
2.23.0

