Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520EDC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3276160295
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhIHNmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhIHNmX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 09:42:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BC9C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 06:41:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i3so1765129wmq.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=Jb9g/NbRDfyIKwxmmhDqeHMthnceS+ej2lSTxEauxig=;
        b=AU9pO/ZYn3gdk+k1MUyDWXUxM03QWuyG3IoJPYO/9R9cEdAyv2sMM99G4oWoI/iihQ
         7vUiSlEFjwjjcl9RkI7YmUGCJUIWMb6ra5QoxRJz6QDTCX5L1jwN0YEkCARkcC+xsh97
         12+ttmgBdQSk7xM0JE9qq8/7hm3sfrofrJhnyUklaBnyptcikryW5wvaKA60G89u4W2/
         /CWdO0BwO5tTRpRx9Wypia3Wf8AJxoUYVxOhA0xirUeHhPuEtSbtTqTkRF+Bjy5b6N8m
         OATjNh7nQtYwgcKZUlmzvTzAqCxI2w9X9NzhJC+141UsWjaPIbXTWF1dxgNIiRGA++hd
         QPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Jb9g/NbRDfyIKwxmmhDqeHMthnceS+ej2lSTxEauxig=;
        b=amsqiwnMgSdw8iXX5o9ycFazq63QhORB7UXzUDpVPpTdcbt87QptNRPyo8qTCE3/LT
         RlvRhb/OojoloxV7xNr8FXHhAVWGQcPFUuDk6kbI7osLPJDpPWaj+m/u3jcXkNhvcTHx
         K1oZqAGCsFiL2JH98MWdSu4jw3mHiXfPFDisGZ+RCH8kr8hP/1fp7XYK7C6TL9XpvZ8G
         OiZbA/QjYtc2f75wIP+NldzY/URiyRSHXdIw5WDCwZxpwWAHxXmnv/wLi3PEXhlUG+cJ
         Mb+OBIt749T0xyf87aKlSe9Ma9O2V4d3E7VlV5bgTAGFEP5fm/D5qebIdFBfaizPlkAh
         HfRQ==
X-Gm-Message-State: AOAM532G7HI9i+Sxdd3O0es6d+5D4J9PC6uGNauDxKsF2Cf5NNlrsc2L
        HgAbmOqcJMWsex1kEU3NKSKyyXOsZIA=
X-Google-Smtp-Source: ABdhPJx/OZJMU7IMqI1eQ0yz2BS8B36GLjWB208C0GSA/Ki2QLjUca3cNjWWbEubheDJvUhAGh2S3Q==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr3627274wml.47.1631108473879;
        Wed, 08 Sep 2021 06:41:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i27sm2112004wmb.40.2021.09.08.06.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:41:13 -0700 (PDT)
Message-Id: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 13:41:07 +0000
Subject: [PATCH 0/5] rebase -i: a couple of small improvements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the re-reading of the todo list after an exec or reword command and stop
forking "git checkout" when checking out "onto"

Phillip Wood (5):
  sequencer.c: factor out a function
  rebase: fix todo-list rereading
  reset_head(): mark oid parameter as const
  rebase -i: don't fork git checkout
  rebase: remove unused parameter

 builtin/rebase.c |  3 +-
 reset.c          |  4 +--
 reset.h          |  4 +--
 sequencer.c      | 88 ++++++++++++++++++++----------------------------
 sequencer.h      |  6 ++--
 5 files changed, 43 insertions(+), 62 deletions(-)


base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1034%2Fphillipwood%2Fwip%2Frebase-reread-todo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1034/phillipwood/wip/rebase-reread-todo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1034
-- 
gitgitgadget
