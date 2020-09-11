Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BA3C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 493402075B
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEtoUyMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgIKSZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgIKSZa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 14:25:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3BCC061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:25:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so5253547wmh.4
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=RQ9lgdFILH46x9ydPY3yX6uTaMQstzpy5gIxICaWCek=;
        b=PEtoUyMZMDJhiHhFsDLH5Vug1cF5smoeSfbFwih/+ccgYHPCcl7WYJ5X2qGpgHqSnW
         sOEwTocApaMz+6/Npsz4hYCgDmz3euYTTReJ8vT2lIrOce255ECMqFJnczQpahO03VqN
         4ltwt6ye4yJ5FPadLvQVNM3t/bsRkw1KVcKKzog9RBcvFQY49/Fz5yRe+i5g5fVppUTY
         yPWVQjoexyqfsXTskopMIrxqmylf1b4ojPRzyC0kmrWIe+hyuldXPJvXseTK8xrj1KKm
         jPgvQqsftT9qRjB5G9VMMYybxyx+U9QwFM/j3eGOXLR8IrIbvjDNWjcvMHuuAdphBjOb
         RFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RQ9lgdFILH46x9ydPY3yX6uTaMQstzpy5gIxICaWCek=;
        b=ipNlfcavJITgV1QOxp7CQMkbTx8Ieq0WfK6yLcA+c3a8KemFUdle/4Ldsfd+ZVMet7
         iuHFQpA7IsMlHaJqZVR1lRKCIXgXQlX0q8xWU8mu9MOdrqqDmswqm5s0TiwzAxeDnPCV
         jRRYTbmu0181CcCYg/sjNbPlC/y4wV7nQudyWg63SyAD/emzQnqIgTlFcf014npG8UuQ
         q27804jH/i+ACjVG5Duq2rLqwhj7FHCwP/TA+Ot48QjFFxpl9KPDNua8eEiVJeTPkvLW
         /SaC1S793KX4ulZ4ceZ6H5WSibO0Gq1Cqqm3/NTDHUt0dDr/47IjZuAMUODeSWvKNrQA
         zvgw==
X-Gm-Message-State: AOAM533JNIq31IJvvQRVTaaRn6NbQkyFfPhfEAfx/77N2hFKrR0wJqMD
        r6yPJY3saYB4aDpN6Rr4bkPeRw2NmfA=
X-Google-Smtp-Source: ABdhPJwVz1l3lRe226ITadn2plqo1N6j3mtBWyL98cVDiugshWKy4ETnbF923TaOUZgy1wdT1wxgQA==
X-Received: by 2002:a1c:f608:: with SMTP id w8mr3639079wmc.161.1599848728176;
        Fri, 11 Sep 2020 11:25:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm5936902wma.16.2020.09.11.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 11:25:27 -0700 (PDT)
Message-Id: <pull.727.git.1599848727.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 18:25:23 +0000
Subject: [PATCH 0/4] clone: allow configurable default for -o/--origin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Took another pass at supporting a configurable default for-o/--origin, this
time following Junio's suggestions from a previous approach as much as
possible [1]. Unfortunately, Johannes mentioned that --template can write
new config values that aren't automatically merged without re-calling 
git_config. There doesn't appear to be a way around this without rewriting
significant amounts of init and config logic across the codebase.

While this could have been v2 of the original patchset, it's diverged so
drastically from the original that it likely warrants its own root thread.
If that's not appropriate though, I'd be happy to restructure!

Thanks for all the advice Junio and Johannes! This feels significantly
better than my first attempt.

[1] 
https://lore.kernel.org/git/pull.710.git.1598456751674.gitgitgadget@gmail.com/
[2] https://github.com/gitgitgadget/git/pull/727#issuecomment-689740195

Sean Barag (4):
  clone: add tests for --template and some disallowed option pairs
  clone: call git_config before parse_options
  clone: validate --origin option before use
  clone: allow configurable default for `-o`/`--origin`

 Documentation/config.txt       |  2 +
 Documentation/config/clone.txt |  5 +++
 Documentation/git-clone.txt    |  5 ++-
 builtin/clone.c                | 65 ++++++++++++++++++++++++++-------
 t/t5606-clone-options.sh       | 67 ++++++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/config/clone.txt


base-commit: 54e85e7af1ac9e9a92888060d6811ae767fea1bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-727%2Fsjbarag%2Fclone_add-configurable-default-for--o-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-727/sjbarag/clone_add-configurable-default-for--o-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/727
-- 
gitgitgadget
