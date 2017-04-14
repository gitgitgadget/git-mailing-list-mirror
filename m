Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D562209FA
	for <e@80x24.org>; Fri, 14 Apr 2017 16:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753563AbdDNQ7Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:59:16 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36727 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbdDNQ7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:59:10 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so45462261pge.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/XbYNdXyS36xVZzBP0pAIYwuQRj4omhV+yHy7ddmN7o=;
        b=v1LOJunf0f2fJiQdvBYwIrPNzpmd7UFDoVQkNtobn0dyfsgjske1OV1FgCm/2IFmnG
         8+BUIi9PRE+NP8TbYWSLgg8SOy71nnW1zkR6wfR0pUrt14PPAiGiRN8CoKgFAEP462I+
         gl1LplDbXweqxt09Kuf4gtSbQMpZYulfPVTHfREPPCkZatqrwC1vccIXXBWp+HIze8+e
         jfY+IpaKGBJsxaqCFeDFMsrHklBZujz/CSFGqQ6srDBHnBgOEJ+jMSgag7SZZbL1DklK
         tGgTL+FBj0SaQMqTnD8MJD1ByDFyElt5ydm5e2nCy2rlYO/uul/gcROFuFeiaiHf6jtW
         wqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/XbYNdXyS36xVZzBP0pAIYwuQRj4omhV+yHy7ddmN7o=;
        b=U4bfxXfRhlsIvD5MEUPuF4USQ7ntJzLvXKaptP0QPvR2rm2GiDfHtVti2E6Ou3Piay
         cKc+4Ok7wguOVvb17fqhQZFbbK79R7ZF9grZz/yT70Bp7kgMgbFtd5cplACPwPQpGSM7
         wnDOU/6r5FVVga9+usXnDccvFmdM+7pojOTokDdxSUWH/KJobEdeV4dBpiZZmfbU733B
         pWM5IF8vZeAaeE3MhxwGdvv85nh/kQa55aQCEwjD9KV2mwQoLfXsjb/mYTD6W1JpSccd
         /3FSEqUs3hsQ9qUyckopaG3+pXQ+nHoELNw8czBvZcyG+U8dsuM55zO0nn5b4B4U0Fi3
         Kvtw==
X-Gm-Message-State: AN3rC/7aNRq5/NVvgI4cMLlvFvhDFxGz2U6LGKSj8bC/vvp1O/WI/kb2
        OacyttCGxCshIh9E
X-Received: by 10.99.6.139 with SMTP id 133mr625465pgg.154.1492189149620;
        Fri, 14 Apr 2017 09:59:09 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm4276591pgj.23.2017.04.14.09.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Apr 2017 09:59:08 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v3 00/10] forking and threading
Date:   Fri, 14 Apr 2017 09:58:52 -0700
Message-Id: <20170414165902.174167-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170413183252.4713-1-bmwill@google.com>
References: <20170413183252.4713-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v3:
 * More error handling for dup2/close calls in the child
 * Added a test in t0061 to test for regressions in run_command's
   ability to interpret scripts without a "#!" line
 * In the event execve fails with ENOEXEC, attempt to exec one more
   time by invoking the shell to interpret the command

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

 run-command.c              | 426 ++++++++++++++++++++++++++++++++++++---------
 t/t0061-run-command.sh     |  11 ++
 t/t5550-http-fetch-dumb.sh |   5 +-
 3 files changed, 357 insertions(+), 85 deletions(-)

-- 
2.12.2.762.g0e3151a226-goog

