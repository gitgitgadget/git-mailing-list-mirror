Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C35209FC
	for <e@80x24.org>; Mon, 17 Apr 2017 22:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbdDQWIa (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:08:30 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35199 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbdDQWI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:08:29 -0400
Received: by mail-pf0-f182.google.com with SMTP id i5so71312460pfc.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47B35Yz4POAvxMHrIlyzflM0zDZgDpfyLAiKSKN+6u4=;
        b=FoG7nGjP0qe+q7e8zTWs1J8CkjXOkfZ4h1w9Pomc075NqZ3HrZsmwMzbhFM6GxShkB
         xTty57wK78y3g2cI5MRxPJjMmaI3yMwsGLLITwTIX83sV67QOzjxAQZW3Ldjwvks2q36
         2urvPSsHG2IbZhjDCM+hQJvnnb8jj9CeyeX9Nu1oNuRRngwAfFLkYq0cz4ab+/6EvSfa
         j8DRgmdmuUB1yoOS7n+ouSGe6DQW4Z32v79KD/kwT45uFhA8GMylkySDjvgfDxIA2CGq
         spZdPi7eDM1ck4bLfAkIQ2IzZ6t/Rrx8URG36ajDBjQbCiIkdMmObdFP6aoa8zE6yuZL
         0EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47B35Yz4POAvxMHrIlyzflM0zDZgDpfyLAiKSKN+6u4=;
        b=FvOANK9p6L+K7yzpxz/eqx8FFXAigtXWk1apWTMs98FCRl0m3UOQ9UZl7qSDrXSuI1
         zHw4gT/Wcc4EfoFMbPx89kq8IsqCV3oqMh5zIBp6l6ZsKs5revz8rSBIIGwV/Go4tVbv
         IcWhdQub1cC2y3kpu2/tfqNfQTqob3rPLfCuOiCoo3BSMVmTHG+EYhoyk/rYXkqHL3aA
         snjLRFhYMiHSp9l2zox/VLg48OlMpCNpxvh0IwAbiHpqu4Yv1btkbJmMOAayEdlwjOx+
         mbSc2yyIZqQTVV5LS1UZKux/kw/8uV5xvGu6iNhKMqJx5Ap6Qex6CpiXrypfpbs8tbZ1
         owmw==
X-Gm-Message-State: AN3rC/7fLa2H2qWBRA6c5X0of5ZWjX65SzrdNUdqJYVbCdhTCp+G+92I
        +vaM75l48/ogFhBs
X-Received: by 10.98.25.69 with SMTP id 66mr14224767pfz.84.1492466908413;
        Mon, 17 Apr 2017 15:08:28 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.163.186])
        by smtp.gmail.com with ESMTPSA id v12sm12644915pgn.5.2017.04.17.15.08.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 15:08:26 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v4 00/10] forking and threading
Date:   Mon, 17 Apr 2017 15:08:08 -0700
Message-Id: <20170417220818.44917-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170414165902.174167-1-bmwill@google.com>
References: <20170414165902.174167-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4 fixes a few minor compatability issues:
* add 'extern' reference for 'environ'
* small portability change with the signal handeling
* remove trailing ',' in enum
* null_fd not opened with O_NONBLOCK

Brandon Williams (9):
  t5550: use write_script to generate post-update hook
  t0061: run_command executes scripts without a #! line
  run-command: prepare command before forking
  run-command: use the async-signal-safe execv instead of execvp
  run-command: prepare child environment before forking
  run-command: don't die in child when duping /dev/null
  run-command: eliminate calls to error handling functions in child
  run-command: handle dup2 and close errors in child
  run-command: add note about forking and threading

Eric Wong (1):
  run-command: block signals between fork and execve

 run-command.c              | 425 ++++++++++++++++++++++++++++++++++++---------
 t/t0061-run-command.sh     |  11 ++
 t/t5550-http-fetch-dumb.sh |   5 +-
 3 files changed, 356 insertions(+), 85 deletions(-)

-- 
2.12.2.762.g0e3151a226-goog

