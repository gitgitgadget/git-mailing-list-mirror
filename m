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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865CFC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5666F61006
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhDKJ42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 05:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKJ42 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 05:56:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E35C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:56:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id 12so9866196wrz.7
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fJEe0mvaWsXhrWVoa++ptauaqAkWPwiRBqJWIdcdAo=;
        b=IbROA2KFyjYvbYdS2C3TtdzoBD2sTv/8WjlpkrrRQuw3tMhmzfuncAqfVfuv+lW5lC
         TgZPI6rugJPDv31Yd1UktG9JZ8J6YArwaVdpyv1ZkseJ5MN1zy/HhMyoeubP63X+n4Wx
         SH6h7Bo67GVUX9X4sm29SpiOaSK2HVHJ6h/G2SBmHSPnvrsrcrshba8VHO2dfCCYCJDj
         0TTJkKaEuxhm4L+KkMruMr5hhFFKGEvzO82AQyl5Rxs+Ryq97Hb0SYMihHjMZk+PK7Q2
         ye7S5QlmiKzhWqffC7KcGotysCvJ0/w0IRuugoNU+8B3e9un0i2/2owWTfsGFiOHmQ2+
         iZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fJEe0mvaWsXhrWVoa++ptauaqAkWPwiRBqJWIdcdAo=;
        b=SNewSzqEAbV/76ctRhfAC3FzAFagFkHlVAgS4jIVsPnDOXdl+ES0BSeiH0qa9Oj/oB
         f71hvKzKRhNBmKfCIWpbdhOy9N9iDwgdHXMLvJC/F4FVVmzhGrF68isvcghGGErTLzu8
         VkH7I0OBr5MC6FACSLZLEgDzQ+U8uCHE/6U4WqgZPBUq8oNf40ml96rxnZW2JOPdNyic
         DsdBEbPj5aGBQtdKKCJmyoAdYjdAbrw+IN2HoRxB93uoXsqofG5waUFW+NErx27q3Qlg
         fNEDah6GFu7UMb0gsPHv3kZOiUC2J1Pz5gNa/RswDhy1BXfwh0dR5TpWWR0ZscaI7Xex
         gZIw==
X-Gm-Message-State: AOAM532sUM15dywxLvHUz4f0BxctvjWjGKYPyzY6gc3LNDTygrCO4X+V
        O1NDpeVC9Mhg6Rb1xi7i0SWM9zs9uKw=
X-Google-Smtp-Source: ABdhPJxvfvj3vx93tGVQ7ymg/wJKkd/hZlK/SHZSz2Hhhxv+5u5OhL2ecCX+U7DjXmdVjdjzlXPJ7A==
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr26397425wrv.353.1618134970899;
        Sun, 11 Apr 2021 02:56:10 -0700 (PDT)
Received: from localhost.localdomain ([81.0.37.230])
        by smtp.gmail.com with ESMTPSA id j30sm12994099wrj.62.2021.04.11.02.56.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 02:56:10 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 0/4] Finish converting git bisect to C part 4
Date:   Sun, 11 Apr 2021 11:55:34 +0200
Message-Id: <20210411095538.34129-1-mirucam@gmail.com>
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
https://gitlab.com/mirucam/git/commits/git-bisect-work-part4-v3.

Specific changes
----------------

[1/4] run-command: make `exists_in_PATH()` non-static
* Amend comments.
---

[2/4] bisect--helper: reimplement `bisect_visualize()`shell function in C
* Replace strvec_split() to sq_dequote_to_strcvec().
* Add missing "--" argument.
* Add missing comma in cmdmode enum.

---

[3/4] bisect--helper: reimplement `bisect_run` shell function in C
* Create BISECT_RUN file.
* Fix if condition.
* Remove continue statement in loop.
---


Miriam Rubio (1):
  bisect--helper: retire `--bisect-next-check` subcommand

Pranit Bauva (2):
  run-command: make `exists_in_PATH()` non-static
  bisect--helper: reimplement `bisect_visualize()`shell function in C

Tanushree Tumane (1):
  bisect--helper: reimplement `bisect_run` shell function in C

 builtin/bisect--helper.c | 138 ++++++++++++++++++++++++++++++++++++---
 git-bisect.sh            |  87 +-----------------------
 run-command.c            |   2 +-
 run-command.h            |  12 ++++
 4 files changed, 145 insertions(+), 94 deletions(-)

-- 
2.29.2

