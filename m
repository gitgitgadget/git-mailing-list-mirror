Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52EFC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 12:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384120AbiDUM2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384097AbiDUM2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 08:28:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D7BC83
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g18so6441050wrb.10
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2sW33EgACjjLyY0ML8zL0jWrBPUVSpKjlF2dkXGWAPE=;
        b=ps1a8f7/mGMe9sJm8J8J7qY2RmWaHeMediaDEiFYVRkLE2N7VYdoIYzVqYeVz0kohE
         RcehhVYmq2ST3a2LX+hJhFKNoJ17Qpk4CJHkBxvXZV4iV3pyqpNStNEDOM/kNO/MjS+n
         nLsQV0oZEwZQxP+o0XGGkBmpsKp/Z2t59loP3pbk5McTUqwig1PMlA4OUZ14ygT6Ujfu
         qNLBWQ1jv/HDHX5Bs4HID8wSRpnr+IxbAoqxtqW0F3Vc1KXWygsU2sSN+DG6T7s2PFa3
         zNzrzG6HIJWypnlK5dVb+oD/zjl7cNX2WR9GOvEkd246B+KzpNwFikkXjZglgxJpauVS
         ah9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sW33EgACjjLyY0ML8zL0jWrBPUVSpKjlF2dkXGWAPE=;
        b=BZXeL5qWSAliSku/CsdOCgCQX3vdPJtGgdWlKEaHgyp4i0U2KPzDilmO12/ckjbWKx
         pXLvhxvVYiHAKhJeA3KyDoSwR2COcsdM20fwkxmKGxzOqEwmG8XqE7bx6d801x9pf40n
         f2oj4KzOhTM+4OVwHYdW5wNrga9xJHVtLuh0k22ZwyrgRhmz6gDiKRqOoHPWfvojf4MK
         YL34LeC6z+GjN9m4oHvvsF4u073Gi4lGYkvhIlBKKNPpauykPi4dCdel7ZCBWe8q2NxK
         +3dQyXEW4Q1AUGQxIrLhukBue4ixFZu460ru5L3UHPQwYe0s94smQ3RiNv0zz9L49Hu2
         pL1Q==
X-Gm-Message-State: AOAM532avQgT/vxVj+XxnL4Hnqyw75K5djsSrVrzZSKLC81/09hjJoyJ
        8hOtR/NMHuLWUSQaQSL4S0pVeMRcB5kQmg==
X-Google-Smtp-Source: ABdhPJwlK1XGaTJU6ySpH8nwT4URfHs0WcAV4Fe2PLnsi2apGqyu3Wuyu7T6CjOUR4+ba+A0WSvttA==
X-Received: by 2002:adf:fe0c:0:b0:20a:c08c:c742 with SMTP id n12-20020adffe0c000000b0020ac08cc742mr1748899wrr.432.1650543934493;
        Thu, 21 Apr 2022 05:25:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c2c4700b0038eb7d8df69sm1920168wmg.11.2022.04.21.05.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:25:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] hook API: connect hooks to the TTY again, fixes a v2.36.0 regression
Date:   Thu, 21 Apr 2022 14:25:25 +0200
Message-Id: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.893.g80a51c675f6
In-Reply-To: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes the regression reported by Anthony Sottile[1] with hooks
not being connected to a TTY. See 6/6 for details.

It would also have been possible to rip the
run_processes_parallel_tr2() out of hook.c, as we currently only use
it for nproc=1. However it's the plan to have it run multiple hooks,
and as 3/6 argues it's a good idea in general for our parallel
execution API to learn a mode similar to GNU parallel's "--ungroup",
even though at the conclusion of this series the hook API is its only
user.

1. https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com/

Ævar Arnfjörð Bjarmason (6):
  run-command API: replace run_processes_parallel_tr2() with opts struct
  run-command tests: test stdout of run_command_parallel()
  run-command: add an "ungroup" option to run_process_parallel()
  hook tests: fix redirection logic error in 96e7225b310
  hook API: don't redundantly re-set "no_stdin" and "stdout_to_stderr"
  hook API: fix v2.36.0 regression: hooks should be connected to a TTY

 builtin/fetch.c             |  15 ++--
 builtin/submodule--helper.c |  12 ++--
 hook.c                      |  19 ++---
 run-command.c               | 135 +++++++++++++++++++++++++++---------
 run-command.h               |  56 +++++++++++----
 submodule.c                 |  13 ++--
 t/helper/test-run-command.c |  44 ++++++++----
 t/t0061-run-command.sh      |  45 ++++++++++--
 t/t1800-hook.sh             |  39 ++++++++++-
 9 files changed, 287 insertions(+), 91 deletions(-)

-- 
2.36.0.893.g80a51c675f6

