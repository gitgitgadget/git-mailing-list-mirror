Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D28C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA1B6121E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhDGW4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDGW4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:56:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB11BC061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:56:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j18so725000lfg.5
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=quS4egLtab54phy6sZAfZx9lgp3XrX7ElK0t7tx1M24=;
        b=RlUqXPJKkAIbjchZNkVX1W1mX5hh1EzDIEiJa3zwTUbGV++bqHdM5uwKrI+JqvnRKY
         Ht0J5bM8O+TnaS8/k9zYSBc7FQM98eM+2lfTJ+QFEkbvmlVhlpWo6xhG3SxkyX0xUVpE
         mMVJciffI0vjtslcpE8Aqm0d/25DmiQmUbku3In7JZ6Gw11NgdWkDqDuxPT4rTyf8zEd
         BpYBzQXysGkQcWpkO0ondfr7QYgv6vPXtPKJKXW1aSn3Uw0vnKLpnMfmJ4nIRDZLCQsy
         HHhwdJ2J1L/irbUeFVzIvM18xuTuu5dfqvBXbQHxpJEn1AHNXsHKrsb1mOXgzTN/WFJM
         nKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=quS4egLtab54phy6sZAfZx9lgp3XrX7ElK0t7tx1M24=;
        b=nL4hPQULraVF+ypQAUt+SiLXwiThnDwRTw1w4KZrsuOA97v2xcooPZrZWaDfbgxQ6W
         kfXcvvd2ceeWK1q10Frt0FcHAQPgbLwhhF8nsGhhLGRI+q0EHlgVzBHHcIr8dHvbfIGg
         twLtxeOFJvJZWcs2iLw38jGDzIxtoq3ELxQ0a1N3y5QlZ3bRHlOm0oSAsob2aKfPsp+X
         +SJdpZ2MW16cMjyjBNplJ3fL+D+W/kvDLLs1GdrAMF/Luu0+8YEqsx6AzCpu2aVzMvnO
         vfXx5axEcGl57ouxh6bon5BIV4xpDM3+g4oLIeE0rCavnDMPv7Tau0aIME90poL0rHBl
         glqg==
X-Gm-Message-State: AOAM533R2xU4rkylugyV2fpx81IJtnOKY8T5/APYQezBBEDEH8bvanmp
        xVgPWSc3H2u14ys1embUesU=
X-Google-Smtp-Source: ABdhPJw7DIbgPcKjzvQWLLeLuHkLJt4jx/83cCAyq9H4pAadzpo890XJTHzVNYKTW0UQ1z2xNiWKiw==
X-Received: by 2002:a05:6512:504:: with SMTP id o4mr3780301lfb.438.1617836181281;
        Wed, 07 Apr 2021 15:56:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t25sm2580101ljo.102.2021.04.07.15.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:56:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 0/9] git log: configurable default format for merge diffs
Date:   Thu,  8 Apr 2021 01:55:59 +0300
Message-Id: <20210407225608.14611-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches introduce capability to configure the default format of
output of diffs for merge commits by means of new log.diffMerges
configuration variable. The default format is then used by -m,
--diff-merges=m, and new --diff-merges=def options.

In particular,

  git config log.diffMerges first-parent

will change -m option format from "separate" to "first-parent" that
will in turn cause, say,

  git show -m <merge_commit>

to output diff to the first parent only, instead of appending
typically large and surprising diff to the second parent at the end of
the output.

Sergey Organov (9):
  diff-merges: introduce --diff-merges=def
  diff-merges: refactor set_diff_merges()
  diff-merges: introduce log.diffMerges config variable
  diff-merges: adapt -m to enable default diff format
  t4013: add test for --diff-merges=def
  t4013: add tests for log.diffMerges config
  t9902: fix completion tests for log.d* to match log.diffMerges
  doc/diff-options: document new --diff-merges features
  doc/config: document log.diffMerges

 Documentation/config/log.txt   |  5 +++
 Documentation/diff-options.txt | 15 ++++++---
 builtin/log.c                  |  2 ++
 diff-merges.c                  | 58 ++++++++++++++++++++++++----------
 diff-merges.h                  |  2 ++
 t/t4013-diff-various.sh        | 34 ++++++++++++++++++++
 t/t9902-completion.sh          |  3 ++
 7 files changed, 98 insertions(+), 21 deletions(-)

-- 
2.25.1

