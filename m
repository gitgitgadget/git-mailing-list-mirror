Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084FFC433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79C56128D
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354883AbhDGReh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354864AbhDGRed (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 13:34:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77EEC06175F
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 10:34:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e12so5780057wro.11
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQVlfWz7qQSiFn74RrxJJZo4ddMeAnY8/+rPiPEVouQ=;
        b=D2NK9ZHHGrRoXbzoDoVMy7aGoWl1pck6uBApmPCRQjTkFoL66ZLF6b0q1AuDGuhSgg
         DUfxuoSpKqSpvaVNomKER1u++Z08wp4OpRqhbcKQ/JQSZybMk+YibazoKnpGdWwblpR6
         Ba3P0ELho58dMNroIJqLt9o5j/s+sLCmHzf0zXhdhDxKRmtQ918NXnQu+KIZKgjtlMnC
         f8wJ9yyXwmajOp8Sq4FSiJXSrZeiHcDGKW4L5uak/1G7uanf6fMeIm+eGKgQTaryWQUZ
         io650hx1CYoIUDRx8rVRQy8nLjpGT0xhHuFeEgijZxQTBqUvCJqlrI221dqv0gd6Ejqs
         o+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQVlfWz7qQSiFn74RrxJJZo4ddMeAnY8/+rPiPEVouQ=;
        b=uBxUt0HTuzBXA32wmTrD5NXbrVywvhwxpbbali+fTnRmkJWTfCNmhu93LQcCkoq+1j
         uqCvJj8sDiiyyU4MFlBmvKG2vmgBUGmmvlghQMKzq4CU5mDeRRtVc3AsJ6miGXOCx8Ow
         JJuLkR4ZaFP//87S5AHu6vCAX+hr+rqMkOgydZQ91M6+OTXPJmI36QJMxntnNewGBjZ5
         jCKgQSqg0VBfxnxZrRK+ZUEK4469/pYx5WdReui8HqBzZo3/KZsTx/N0S3zGC8eLundY
         nYgDUpR9ayJQuNR3PgUrJZ241DUSeIi9Mr9gQGbwSDqJAtAub3475q3wZlW9YiAnklgO
         Fa1g==
X-Gm-Message-State: AOAM532GIZU/1f/VNvSkOcDDrqjOmNTWOjM4Sc5vFWr4/RhCkLEThqt5
        VrotB9s7TjO37DEPybMjtY/c/NTigwod1A==
X-Google-Smtp-Source: ABdhPJwxt7OP1zE5n602H7/QngNVtP3yXmj2pD4lcXGrQ7Y++8yVWqa/bRDSKjgFBXBuM3te6ozXxw==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr5711937wrs.54.1617816862606;
        Wed, 07 Apr 2021 10:34:22 -0700 (PDT)
Received: from localhost.localdomain ([81.0.37.230])
        by smtp.gmail.com with ESMTPSA id o7sm41657197wrs.16.2021.04.07.10.34.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 10:34:22 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 0/4] Finish converting git bisect to C part 4
Date:   Wed,  7 Apr 2021 19:33:29 +0200
Message-Id: <20210407173334.68222-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a fourth part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This fourth part is formed by reimplementations of some `git bisect` 
subcommands and removal of some temporary subcommands.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part4-v2.

General changes
---------------
* Rebase on master branch: 2e36527f23 (The sixth batch, 2021-04-02).
* Change argv_array structs to strvec.

Specific changes
----------------

[2/4] bisect--helper: reimplement `bisect_visualize()`shell function in C
* Add `|| exit` to bisect_visualize call in shell script.
---

[3/4] bisect--helper: reimplement `bisect_run` shell function in C
* Add `|| exit` to bisect_run call in shell script.
---


Miriam Rubio (1):
  bisect--helper: retire `--bisect-next-check` subcommand

Pranit Bauva (2):
  run-command: make `exists_in_PATH()` non-static
  bisect--helper: reimplement `bisect_visualize()`shell function in C

Tanushree Tumane (1):
  bisect--helper: reimplement `bisect_run` shell function in C

 builtin/bisect--helper.c | 124 ++++++++++++++++++++++++++++++++++++---
 git-bisect.sh            |  87 +--------------------------
 run-command.c            |   2 +-
 run-command.h            |  10 ++++
 4 files changed, 129 insertions(+), 94 deletions(-)

-- 
2.29.2

