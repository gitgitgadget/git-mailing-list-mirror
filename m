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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A43FC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D8264F5F
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhBCV4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhBCV4G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:56:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2545CC061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:55:26 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id g10so1087643wrx.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38vW6wb5f9mtZNd9ZZJK1YdZa4emjE14mJ1zCk6NyuE=;
        b=kMEY46U1/jyd9dJclajb/25d3aUlpAmgdsAw9mvInOj7l6UGN/ccxbitTxYJpeWkJI
         gU25WPP5LtCQ/fMl5ODQROjiSAZVhPqNfcQonVVSgY1uHXyW3BDIiEUmajZW+xk1RNdR
         ZAjVOFUCxBN7yKS5GH2Dgil3OhjFz+X54RV4RoVh+K9Ft6/33gavqNdCQPwOs3Q3zjqU
         M8Vv+ypVuCOjF4Gq4gDlGzA0eTCfNJzqkzX0qrpvksq9V+Ffeoc+nKnYiCXGAzt6ccju
         04EnmHLg/D+aYlP2S1JUkl/cw4Zol1uKRhAgBjCE+Hb517OEAPxv35/al2AtWTFrZwie
         3rPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=38vW6wb5f9mtZNd9ZZJK1YdZa4emjE14mJ1zCk6NyuE=;
        b=sl9wfkP08Q8RN/pkiaFQzn4+tduiEBdAiDEuPzgiXc2p1nyl2gv8pjlOiQ9EvTDuJh
         SS1fOFj+ZD0fXCmMohtFhOvm4f8Dw/3nyh58OE2jK6SbQ98m9Fyo1voMhEJB6uwR9/Xx
         McEXE0ikQx0VcEZChbqmyhBjNQpUmmAZsm9wxAJbIV+w8mkzz3UWPoVU5cg1oy4aCCae
         SnOixxS3zCDAsRwVQFO1PoBYFog75iNt9IN0iPnAmD0sjCr6cyxiKTbdyfPbeetZC7r0
         7mPTX7HweSf/j8yeIJPDzQvqLH/zxuj99RNb09r+SsLBuNlmohF2+yM/GKxM8OWsZzDT
         2RHA==
X-Gm-Message-State: AOAM5334ZCvkBCeRIc0Nc8MKWYss1VLsWq2I6snfsbCP7WlxVg4j4s6C
        J3oog5U7c9kJ1wJf8QZJ862v70jd/2s=
X-Google-Smtp-Source: ABdhPJyBl5laNFbrKZW4V6jVPH4EygLfzIoM63cNLfaHmkp6qBDn2iILnduLAxUqb9J+GuHQoEWuyQ==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr5736411wru.64.1612389324960;
        Wed, 03 Feb 2021 13:55:24 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.148])
        by smtp.gmail.com with ESMTPSA id 143sm2609531wmb.47.2021.02.03.13.55.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 13:55:23 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     rafaeloliveira.cs@gmail.com, Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 0/7] Finish converting git bisect to C part 3
Date:   Wed,  3 Feb 2021 22:54:31 +0100
Message-Id: <20210203215438.96760-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
https://gitlab.com/mirucam/git/commits/git-bisect-work-part3_v5.

I would like to thank Christian Couder and Đoàn Trần Công Danh for their
reviews and suggestions.

Specific changes
----------------

[1/7] bisect--helper: reimplement `bisect_log` shell function in C
* Add return error message.
* Add helped-by trailer in commit message. 
---

[2/7] bisect--helper: reimplement `bisect_replay` shell function in C
* Remove braces.
----

[3/7] bisect--helper: retire `--bisect-write` subcommand
* Remove break statement.
----

[4/7] bisect--helper: use `res` instead of return in BISECT_RESET case
* Add break statement.
----

Pranit Bauva (7):
  bisect--helper: reimplement `bisect_log` shell function in C
  bisect--helper: reimplement `bisect_replay` shell function in C
  bisect--helper: retire `--bisect-write` subcommand
  bisect--helper: use `res` instead of return in BISECT_RESET case
    option
  bisect--helper: retire `--bisect-auto-next` subcommand
  bisect--helper: reimplement `bisect_skip` shell function in C
  bisect--helper: retire `--check-and-set-terms` subcommand

 builtin/bisect--helper.c | 183 ++++++++++++++++++++++++++++++++-------
 git-bisect.sh            |  58 +------------
 2 files changed, 155 insertions(+), 86 deletions(-)

-- 
2.29.2

