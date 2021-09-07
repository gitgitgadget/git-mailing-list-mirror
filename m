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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B91C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0446610FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244611AbhIGMBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhIGMA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:00:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F0FC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 04:59:52 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id w8so9686222pgf.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eV9dWJ+RZe+x8yq0Hvn+3hdZhwcxpNWSg8fzsD+GyGc=;
        b=aPf/bf/EY9h+7B9yHBQ1K3AIvPTqriaurRNWr8+rTqc35gkojQeOL+7d334zjI1GqU
         SZHHXVfyLV5z5ihEGuBYMdLEHYjUdiuM7sW+e5haoqpqGfL3gDIh4dYkk9FnWZUICNdD
         cXyF8klh1PUgzORUeQ4HZIgrnDZB6a17jNii8vORk0raaILsfZdK2EMzD4WsHku5uQZz
         1gmp8ynkcSYojgmyi8AhG2UyJLglKkKUeTN3fLsHsdhBNtfuVnZ0oNA9iHK27tZz97Pn
         3s2h+jLNowNFCahvszhdkmSHWaMLww2iKYpcW8nRGZIqc2G9+rBkr5cPapd+p2gnFvnT
         1FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eV9dWJ+RZe+x8yq0Hvn+3hdZhwcxpNWSg8fzsD+GyGc=;
        b=oJ2jJCrieaNGuJoNFUfUO7tAebic+oA061OUIFKoKPMBdeqAxm2LThxZCyrpN5W7Fq
         OJ0QfQhCRi2uBHBlFvAv1N1yYKaN6m9v910S/BNOby1Z2NLT0MLtCo5C/GcbX5yyUwqd
         Uet6Tyo4wOAWl3gmkA36DGDCQcMkNNiE5cEPdPBdJjat7ftu/kwo/7NUkoCLgJdLL/RW
         z59xbsd1cWxaRgdjzgfIhufUl0ozLYCkXz3f7mlQibeUk6ie0iWsJZ4+1sB37sRNVPyB
         NsZl+KTWYFuxkt230Wbj9n+pvDG+jGxWtefYvfhhRVe41jeDOnkMCP5EVEanxU1VZ/Rl
         +Ung==
X-Gm-Message-State: AOAM530LcswNE5IARSCEQZe+sFKq8pUmrFODhq5cdpE8tIzUREdcFzKa
        DfI5O9GZFHHkSg8Y411Vk24KSqscO30=
X-Google-Smtp-Source: ABdhPJyPMg+jwYft5wPlPK/YnQ3toiXswWvBdjpa6Nnjin/J7WOythrzwq6JXm7pSQ9bshjPSytqRg==
X-Received: by 2002:a05:6a00:1411:b0:40b:9ed8:13ea with SMTP id l17-20020a056a00141100b0040b9ed813eamr20429443pfu.61.1631015991587;
        Tue, 07 Sep 2021 04:59:51 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.04.59.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 04:59:51 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 00/13] submodule: convert the rest of 'update' to C
Date:   Tue,  7 Sep 2021 17:29:19 +0530
Message-Id: <20210907115932.36068-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: This series uses ar/submodule-run-update-procedure [1]

This series builds upon the previous conversion work on 'submodule update' and
moves out all of that shell logic in 'git-submodule.sh' into
'builtin/submodule--helper.c'. Even though this patch series looks long, a lot
of it is preparatory patches and cleanup of unused functions that result from
this conversion. The real action happens at [6/8].

As with the other series, the goal is to be a faithful conversion, with no
change in behaviour.

This would be the last command whose logic would be moved into C, other than
'submodule add', whose patches have been sent already.

After this works out, we can invert the shell-C relationship and make
'submodule' a proper C builtin.

Fetch-it-Via:
git fetch https://github.com/tfidfwastaken/git submodule-update-list-1

[1] https://lore.kernel.org/git/20210824140609.1496-1-raykar.ath@gmail.com/

Atharva Raykar (13):
  submodule--helper: split up ensure_core_worktree()
  submodule--helper: get remote names from any repository
  submodule--helper: introduce get_default_remote_submodule()
  submodule--helper: rename helpers for update-clone
  submodule--helper: refactor get_submodule_displaypath()
  submodule: move core cmd_update() logic to C
  submodule: remove fetch_in_submodule shell function
  submodule--helper: remove update-clone subcommand
  submodule--helper: remove update-module-mode subcommand
  submodule--helper: remove shell interface to ensure_core_worktree()
  submodule--helper: remove print-default-remote subcommand
  submodule--helper: remove relative-path subcommand
  submodule--helper: remove run-update-procedure subcommand

 builtin/submodule--helper.c | 764 +++++++++++++++++++++---------------
 git-submodule.sh            | 145 +------
 2 files changed, 455 insertions(+), 454 deletions(-)

-- 
2.32.0

