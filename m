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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D9C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888A8611C0
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhIIJsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhIIJsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 05:48:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE86EC061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 02:47:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so908402wms.4
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TU1br2H8KBW8SHU92E+eGR5bkEckxngSiFgDBg3SSVM=;
        b=b9r3fsNW/X2Fn2iUjlMSb3mW1WokXdeLx8X8cIUhDOmXsLtOL5u7Sr8UXU1EesPhzm
         Uk4zjD6+bUtkeZLIZ+TDVxwZh5sk16vuRq2gGNrr6O54KF3fBo2hvrtYEKTJzdrRP1V4
         iPL+bL+7BTLwejuUlkXuQDi0zqboOrqFrGEyOPOBql+71nGQrbWECyDNosiyZP7Ytgg7
         8vb5iWQM1xkH3R2lJSpnHgb2ONyVh76x7hdOCkTrPYeTYfyDwiE8Zn3hml2aMXLq8ena
         0j0EZAJndDwVtSy28jr9SKfibZwowt3lUr+bztzCriSPruix6M5vBPKGTXVftJYlhI6L
         vHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TU1br2H8KBW8SHU92E+eGR5bkEckxngSiFgDBg3SSVM=;
        b=sJbmsR0kfd8McZbAhPna35bWMYUhjkd9p80JNqsJ5XCumlWBZb+B5ST2PFHmSrNjXR
         SBW1AGNyOwpOpJ8o2OK018e6FB3lvaWhkM7SKgbOee3ZJXtlC8s2HxC41sW8MzGsONXm
         paAWSb/wmsKwBNG60lTOVh3/kxC8DgXJFhzCtTKCj+VEGuRRgYKOH0Xaio3RXLB0j9yX
         hZHKWJX0+S06GF196mj8H8meVphSgP/HPiuRcAeAMr0jZ/s+/yRbBPRocLkt59etuEWC
         HdvRBAh2tLzrOeZT4dXtfyvD8/XF6Wod0mSuuDWiDG/qkkp3Vf/SMZFmfA2fyxzJs9zQ
         UnYg==
X-Gm-Message-State: AOAM532Fwz47j2d+XaGy6MdmvRx1lfaRfLLeDYLEkbPq4MZR1nnjxBXg
        hd1Tg+LXx0IhQKXUVawKu49oMGOTwk0=
X-Google-Smtp-Source: ABdhPJzHu3yXrFpTzR8Qdk4rP7K2fwftjfcM48vOVLJbk8suM2yT6Y0OJJ6VYYhraxCfeRcwQrjzIg==
X-Received: by 2002:a05:600c:2210:: with SMTP id z16mr1998558wml.70.1631180830554;
        Thu, 09 Sep 2021 02:47:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm1265380wrs.60.2021.09.09.02.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 02:47:09 -0700 (PDT)
Message-Id: <pull.1035.git.1631180828.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 09:47:04 +0000
Subject: [PATCH 0/4] Follow-up to js/pull-release-backs-before-fetching
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This implements the API enhancements suggested in
https://lore.kernel.org/git/xmqqh7eu3mjb.fsf@gitster.g: we introduce a way
to let run_command() handle the releasing of the file handles to the object
store. It should make the code easier to work with in the future because it
will be more obvious how to support Windows better when copy/editing code.

Johannes Schindelin (4):
  run-command: prettify the `RUN_COMMAND_*` flags
  run-command: offer to close the object store before running
  run_auto_maintenance(): implicitly close the object store
  Close object store closer to spawning child processes

 builtin/am.c           |  1 -
 builtin/fetch.c        |  2 --
 builtin/gc.c           | 18 ++++++------------
 builtin/merge.c        |  1 -
 builtin/pull.c         |  3 +--
 builtin/rebase.c       |  1 -
 builtin/receive-pack.c |  3 +--
 run-command.c          |  6 ++++++
 run-command.h          | 23 ++++++++++++++++-------
 9 files changed, 30 insertions(+), 28 deletions(-)


base-commit: 7e44ff7a3983ad0c7be5c9edcfea2e8355ce9a65
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1035%2Fdscho%2Fclose-object-store-in-run-command-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1035/dscho/close-object-store-in-run-command-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1035
-- 
gitgitgadget
