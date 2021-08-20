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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15490C4320A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB7F61158
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhHTRXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhHTRXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:23:38 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0559C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:22:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso9575314wmg.4
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4SqzrmGUjBEXR0oDmmZDmWU4+jOMmqCG9U/g7lm3Xdc=;
        b=dZ+6DjajWyuQyx3BGhUIVIcDQzDkti5D/rSJ4HFYpS2CJwoMIflZ3i4hRhsWAlsWbB
         26cRzg3hTUxmAM+v7u5zzsgO5IGJ28bbAF5a6OXq9c/kBJLFaIFcgneDV8HRqGwFEITI
         sjoaLn1yxqts1kROlc+L3nPQOLd0MR/3wc5Ey2XJbdkvPILJ3yS4/74kUQjB1Hzpir5N
         lriBb3TBuku7e4GgFrGI6FRX87R0tISRPfI86UBjR/xuxtDUEyZppliywMipFVtRnV25
         u847vpb+uRYTa2KtkSnRlB7sr71GT7ppqvGRZ1Th4qmzXzSbJcqgrfOGawK19Kj4X7P1
         BSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4SqzrmGUjBEXR0oDmmZDmWU4+jOMmqCG9U/g7lm3Xdc=;
        b=B1JbNMRiw9wTMoknRZktgvxhHRP7GY2Kavd5lW16jlzP6LIk8ydpLmHWzdm/A+dWMt
         NLQtzw5322buqn7CGVfOBIltL+l9QjgNlmQt9Lj/s8g7dRoBY9qpBou1Kj5xgs+lVAfo
         foII7uorDPARjP32FKM6aNWi2xaLGg8KQ34KUsxRS/U5ECfzEilhAPl5SiYcYvktI1sj
         w59yGbTfQbqLD5R7+N5EJ5YPFFrxuwBm0T519CsRBjfYiHAA29G7DM/4H6kFk7kkvr6y
         egGBRnc007TWG41QLuThg9hEK793Wk0S6a1HcVWCAvqOhUerOXglRiaWkHAp/57z+piS
         HNrQ==
X-Gm-Message-State: AOAM530fr5aa1FPX2yROODthyYnhhbHlRFQPoypdcQQg4rcMo9WaIlRD
        r7LSwYdB68g2Pdqkvp5yqRxUfZRV2Tc=
X-Google-Smtp-Source: ABdhPJxIpJNIX+U8EUSlpcO8lG7LjP7dymhgPWl8iCfoL/MmAqNwY9FXeqOGk7T6rzYjFNF2G6eMQA==
X-Received: by 2002:a05:600c:b51:: with SMTP id k17mr5035449wmr.149.1629480178319;
        Fri, 20 Aug 2021 10:22:58 -0700 (PDT)
Received: from localhost.localdomain ([178.237.232.111])
        by smtp.gmail.com with ESMTPSA id x13sm6623278wrq.44.2021.08.20.10.22.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Aug 2021 10:22:57 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 0/6] Finish converting git bisect to C part 4
Date:   Fri, 20 Aug 2021 19:21:42 +0200
Message-Id: <20210820172148.2249-1-mirucam@gmail.com>
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
subcommands, addition of tests and removal of some temporary subcommands.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part4-v5.

I would like to thank Johannes Schindelin, Bagas Sanjaya and 
Christian Couder for reviewing this patch series.

Specific changes
----------------
[1/6] t6030-bisect-porcelain: add tests to control bisect run exit cases
* Add evaluation of error code 255 in test 'bisect run fails with exit 
code equals or greater than 128'.
* Remove test with error code smaller than 0.
---

[4/6] bisect--helper: reimplement `bisect_visualize()`shell function in C
* Use strvec_push() instead of strvec_pushl().
---

[5/6] bisect--helper: reimplement `bisect_run` shell function in C
* Add error message.
* Remove exit variable.
* Write contents of bisect_state() in BISECT_RUN file and show to user.
---

Miriam Rubio (3):
  t6030-bisect-porcelain: add tests to control bisect run exit cases
  t6030-bisect-porcelain: add test for bisect visualize
  bisect--helper: retire `--bisect-next-check` subcommand

Pranit Bauva (2):
  run-command: make `exists_in_PATH()` non-static
  bisect--helper: reimplement `bisect_visualize()`shell function in C

Tanushree Tumane (1):
  bisect--helper: reimplement `bisect_run` shell function in C

 builtin/bisect--helper.c    | 157 ++++++++++++++++++++++++++++++++++--
 git-bisect.sh               |  87 +-------------------
 run-command.c               |   2 +-
 run-command.h               |  12 +++
 t/t6030-bisect-porcelain.sh |  18 +++++
 5 files changed, 182 insertions(+), 94 deletions(-)

-- 
2.29.2

