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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AAEC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E0823340
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbhAWPmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 10:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbhAWPm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 10:42:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F4FC0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:46 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so7969241wry.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lf/eYMc38JGAlwtlUXYWFYE15gcyWdDX5bVsHoGApME=;
        b=FyvLcWt8txpzO9mRZ6OUs+6ckvZ0lk79BWl0/LUmPrC4pQFuy2tZl7jznK6zXSnysY
         SYCe+uJw25VJdZM5kxmaGfUGbO9GJ5ac/CrAoeC/KLR+ulX/5iLmLrxu9J9CyZHH3ItK
         1PmgYY8rvIC6lX6wfdF6PJZDm1gx6CNevVYPavvgpPgdaV3QpUjXTHX8XaFmvTjuZHWg
         DS1OP146DTH3ihQ/5jH1JAJIQg7AcGbqQEb0TuNZA8zhNH44s9oNRv9seqM6nGpn6k5c
         dutKSoGarH8GVwPQrhY4qN5h6lmpF6G2B6xCLMs47Iw8OPhf4RYd3zhBaeXZCuZ/raXz
         1FfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lf/eYMc38JGAlwtlUXYWFYE15gcyWdDX5bVsHoGApME=;
        b=m/c1lrtzp1lUaD2xwYyUcc1krXnIw42pfPPN8iaTajWVuLmvVCmHiQ29z1nBgTwuHw
         C3eP9h+QP2XCXhHvusduoNDVX6zS8aLj2eacjinUQvAJJbwbNyCJW/3/TlvnsfMJvLNT
         sYKY3LGh2dvTTMZopaqWkTQgrp5Df4thGs/9jmiCt3xfgnfj5RzW2TOQH4Tp1KwcdQJp
         iQk6m0beBS+67kStu/IkqDY5SWZKWvyaKHwdYZ3EmucbmPhja3lZUN3YFQmktblARAZo
         Ewuy/uoICeU8t6mTcsdtwuL1jbTDYvH8mZoyX669MWTfe9X7Ei9by6eU0leVxuROXkJ5
         lYlA==
X-Gm-Message-State: AOAM530FzGe6B67Lk3gmkLSqpwE5s8q1QaKs//5TWjHN6y1yeCXYZBuz
        44/l4FJUd63e3Wo58K8xrM5AXwf2tiM=
X-Google-Smtp-Source: ABdhPJy35NHwNOynZXZ6P0j26QZ6FPVCzIlSjgq+fXXa0nOgN0h1BAOD9L6MMgj7qwd9ri4JG2RmQw==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr1137054wrm.424.1611416505399;
        Sat, 23 Jan 2021 07:41:45 -0800 (PST)
Received: from localhost.localdomain ([81.0.50.72])
        by smtp.gmail.com with ESMTPSA id o8sm16772353wrm.17.2021.01.23.07.41.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 07:41:44 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 0/7] Finish converting git bisect to C part 3
Date:   Sat, 23 Jan 2021 16:40:49 +0100
Message-Id: <20210123154056.48234-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a third part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This third part is formed by reimplementations of some `git bisect` 
subcommands and removal of some temporary subcommands.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part3_v2.

I would like to thank Rafael Silva and Johannes Schindelin for their
reviews and suggestions.

Specific changes
----------------

[1/7] bisect--helper: reimplement `bisect_log` shell function in C
* Change command description message.
---

[2/7] bisect--helper: reimplement `bisect_replay` shell function in C
* Remove get_next_word().
* Change process_replay_line()'s while loop implementation.
* Change error message.
---

[6/7] bisect--helper: reimplement `bisect_skip` shell function in C
* Use strstr() instead of wildmatch.
* Remove strvec use.
---

Pranit Bauva (7):
  bisect--helper: reimplement `bisect_log` shell function in C
  bisect--helper: reimplement `bisect_replay` shell function in C
  bisect--helper: retire `--bisect-write` subcommand
  bisect--helper: use `res` instead of return in BISECT_RESET case
    option
  bisect--helper: retire `--bisect-auto-next` subcommand
  bisect--helper: reimplement `bisect_skip` shell function in C
  bisect--helper: retire `--check-and-set-terms` subcommand

 builtin/bisect--helper.c | 178 ++++++++++++++++++++++++++++++++-------
 git-bisect.sh            |  58 +------------
 2 files changed, 150 insertions(+), 86 deletions(-)

-- 
2.29.2

