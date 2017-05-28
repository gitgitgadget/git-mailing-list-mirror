Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AFB31FD09
	for <e@80x24.org>; Sun, 28 May 2017 16:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbdE1Q5Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 12:57:24 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35888 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdE1Q5X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 12:57:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id h64so4057215pge.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=tvADP0M7cHYQ7HtsdMRgHLD8Kp6EXvvWlsGdJq9jEm4=;
        b=BwW84We/l8qWirxT2PnHX/zxrtjIZUOsEeeC85W6hH9WIH63ial5/8FSEZLkJCnGQS
         3Ny+xp/3VRoVYNmedRwqiWT57oKdD1wvkZfqe9cR7YoBPcUes+BpGnW9E2bmLp7nz74N
         zRI1JKoV4ghDHzjVCslGjieJL+vgSJ4ahzqfSuDAfRO5tU4fT8Dj+8fKogwFYz2+Rg0K
         UD8cGW23VnklKWAdGeGoXo7v/mT4iLa9TIZRGoQH8lAID/y/E1ZAEgsnI8dJFHS4N/Pg
         k/LUAiP24AYCwyihU7a8JgEU/kJeCPPvPSURIBiN82/dOevdfgxaDEIs+SbCZR+AfmWj
         sHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tvADP0M7cHYQ7HtsdMRgHLD8Kp6EXvvWlsGdJq9jEm4=;
        b=CNl8mLfimVOY9fXrKZia+tW4eUr75/reZMWgN8lxwYJydwNnSGBZ8JAGZ2ikMilESL
         52XLpelIZfAx6mhVUaYkssXmkDAL2y8I0wrGaOJprOR2RXenGU5YsNfc/mS/5+wdgNB8
         /D7VrIL1IdDFBx6cegyEpsEYvfHLReEflBnBOGv/MAeQXzUDTgg5UcMUIckOdDGoEB5N
         zDEhoH5IioFtQId/VZ0B4o5gVHZEPGLYJqjiP+8oX2P841TIsMLyMFgjelcdPzWQbXJQ
         SZcjacaAQLiF1zpvL46gWJvQa+oefg9+hnXylzYtwJoRp81WVE04bT+ibLOcP11wO22J
         3+Kw==
X-Gm-Message-State: AODbwcDJtRNZLBr2WUbN+Rh8wS299az3WZ5VQATmhB5WxRGG/q8F+TzN
        QF1KDzupRS76xwmU4EFD+g==
X-Received: by 10.98.153.4 with SMTP id d4mr13455386pfe.223.1495990642356;
        Sun, 28 May 2017 09:57:22 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id w67sm12511824pfi.2.2017.05.28.09.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 May 2017 09:57:21 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     git@vger.kernel.org, t.gummerer@gmail.com, peff@peff.net,
        Johannes.Schindelin@gmx.de
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v3 0/4] Implement git stash as a builtin command
Date:   Sun, 28 May 2017 09:56:38 -0700
Message-Id: <20170528165642.14699-1-joel@teichroeb.net>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've rewritten git stash as a builtin c command. All tests pass,
and I've added two new tests. Test coverage is around 95% with the
only things missing coverage being error handlers.

Joel Teichroeb (4):
  stash: add test for stash create with no files
  stash: add test for stashing in a detached state
  close the index lock when not writing the new index
  stash: implement builtin stash

 Makefile                                      |    2 +-
 builtin.h                                     |    1 +
 builtin/add.c                                 |    3 +-
 builtin/mv.c                                  |    8 +-
 builtin/rm.c                                  |    3 +-
 builtin/stash.c                               | 1280 +++++++++++++++++++++++++
 git-stash.sh => contrib/examples/git-stash.sh |    0
 git.c                                         |    1 +
 merge-recursive.c                             |    8 +-
 t/t3903-stash.sh                              |   19 +
 10 files changed, 1316 insertions(+), 9 deletions(-)
 create mode 100644 builtin/stash.c
 rename git-stash.sh => contrib/examples/git-stash.sh (100%)

-- 
2.13.0

