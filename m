Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDADCC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbiCUUg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353484AbiCUUgT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:36:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5002B8AE45
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d7so22297941wrb.7
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=7a/ISRdLKTdJKt94uWPZW9VeUoJjyTRnbCiilUC3XWA=;
        b=qNubyY/TyTrVqgds7GPA5DhxaCifVwOH9UvskjcTn9F1EAtg2urel72xqz24CvBcKb
         xvtNQ0LcgZhQfgXyGxK1JDdDjILSLqOwiXkRrt4ePGgbBQodvQ9kEvOlBaBpl8Sf64sd
         qRW5P0hwdg/p0AU28oLafnxfaCs4OgtEwMxjdtfqTflM4xLdPiP5UjFJJLK20JJ5Gj+X
         nTYb/GuwG8Xec54xJo91n8QEJD3wYbJGg3Vjcf16tx6dn6UrDDDz1rRYzDTFTUz5L0y+
         VzeFg8lqI0fmAiYoP7O/hynRwYrrHVv6WpG57tbIvxVy9qqmAPb8idLoFs30peoEAfoz
         NIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7a/ISRdLKTdJKt94uWPZW9VeUoJjyTRnbCiilUC3XWA=;
        b=ETgaWzDiIPfY6lWtBSj7X2qtFXPMglwHhAikxeMxVuLLIOpVLp/xetW/5jEDU6k18D
         D6NUzFCC9qQzcyT3/QufSWbMSQ+AGlNwm44vHg0MZ33E/tIE5BbzCtH7jIqfnnGYqFGK
         2JsnNXHtOA5tSuRHADkLeHtCw0wI6GjnutY68lPFRQSuHbX3xsKk0nE7M8Z8eDvKztNP
         xKg/7q2KKTpz2ZjiQFRbdzR9lvciBoH8j9O+BkozymqoMeQ2it7JnAA7e1XE0PhjKY+u
         kUvf192+4cl3fIfcysNel/iNmyBKQnRFUkhnoOghwedwNfL/Hs2zYGCl6k0HSScjz8nE
         yMsQ==
X-Gm-Message-State: AOAM533Q/rIYQWj6g2NI6yUyoSCdYx7KPlQEXUwA3mfGWx7J5qJJEw1O
        5xdvtrFhjSglZJNxWjjZW9D5Ctc48cI=
X-Google-Smtp-Source: ABdhPJwU/d/Cg3FW3jMuoKHKg6rndQ21/jWqTAgMJpAA7xbn7oFMJX1nccGJFL4fkVLu4dXmSX1mUg==
X-Received: by 2002:adf:dd4d:0:b0:203:f178:b78b with SMTP id u13-20020adfdd4d000000b00203f178b78bmr16081432wrm.93.1647894891530;
        Mon, 21 Mar 2022 13:34:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6-20020adffc06000000b00203f2828075sm10047498wrr.19.2022.03.21.13.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:34:50 -0700 (PDT)
Message-Id: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 20:34:45 +0000
Subject: [PATCH 0/4] reset: make --no-refresh the only way to skip index refresh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maintainer's note: this is based on vd/stash-silence-reset

----------------------------------------------------------------------------

This is a follow-up to the changes in vd/stash-silence-reset [1], in which
index refreshing behavior was decoupled from log silencing in the '--quiet'
option to 'git reset --mixed' by introducing a '--[no-]refresh' option and
'reset.refresh' config setting.

After some discussion [2] on the mailing list, both the
backward-compatibility and use of global options in that series came into
question:

 * '--quiet' still skipped refresh if neither '--[no-]refresh' nor
   'reset.refresh' were specified, meaning that users could still be left
   with an incorrect index state after reset.
 * Having 'reset.quiet' and/or 'reset.refresh' potentially disable index
   refresh by default meant that developers would need to defensively add
   '--refresh' to all internal uses of 'git reset --mixed'. Without that
   option, different config setups could cause variability in index
   correctness from user to user.

In response, this series deprecates all instances of skipping index refresh
in 'git reset --mixed' except for '--no-refresh' itself:

 * Patch [1/4] removes the "fallback" behavior of 'reset.quiet' and
   '--quiet' implying '--no-refresh' if neither '--[no-]refresh' nor
   'config.refresh' were specified. In other words, '--quiet' no longer does
   anything other than log silencing.
 * Patch [2/4] deprecates 'reset.quiet', since its main use was to disable
   index refresh until it was deprecated in [1/4].
 * Patch [3/4] deprecates 'reset.refresh' to avoid users accidentally ending
   up with an incorrect index state after all resets as a result of a global
   setting's passive effects.
 * Patch [4/4] removes the '--refresh' option, leaving only '--no-refresh'.
   Because nothing but '--no-refresh' can skip the 'reset' index refresh
   anymore, '--refresh' would never be needed.

[1]
https://lore.kernel.org/git/pull.1170.v3.git.1647308982.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/80a2a5a2-256f-6c3b-2430-10bef99ce1e9@github.com/

Thanks! -Victoria

Victoria Dye (4):
  reset: do not make '--quiet' disable index refresh
  reset: deprecate 'reset.quiet' config option
  reset: deprecate 'reset.refresh' config option
  reset: deprecate '--refresh', leaving only '--no-refresh'

 Documentation/config.txt       |  2 --
 Documentation/config/reset.txt |  2 --
 Documentation/git-reset.txt    | 13 ++-------
 builtin/reset.c                | 18 +++----------
 builtin/stash.c                |  4 +--
 contrib/scalar/scalar.c        |  1 -
 t/t7102-reset.sh               | 48 +++++-----------------------------
 7 files changed, 15 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/config/reset.txt


base-commit: 4b8b0f6fa2778c1f9c373620e3f07787543914c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1184%2Fvdye%2Freset%2Fclean-up-refresh-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1184/vdye/reset/clean-up-refresh-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1184
-- 
gitgitgadget
