Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83EBC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 14:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DFD610CC
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 14:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbhGTOAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240179AbhGTNvp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 09:51:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62048C0613E0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 07:32:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a13so26216323wrf.10
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=waLhSwmzkrR4GZ2NEL+2i7O+dQ6qjHxro4zSfZkMr54=;
        b=UBUtUQ9T0Z9+Jcxoccs79N1ReW4ZYuhPz/+w/fOVow7diFFl0HGgozCbo1stHXTZhI
         VfIyQICkS1IOCiN1tds3GlfZOUMOtC7SUPSrfbyddy02edgZKGg6wS6+eYSqo58q66J2
         1/4HpTgIQUcax6OUwAacqNKZo5iwJB4ZM3ycvjrVenMj/c0/yUGtqH63F5zjFTdRv/z7
         02NvJFJcGKBQtFOMeNIVxtdhqreW699JJqfTcx2PDkHSJ9qhVEhR4qFK5i0MuyyXrKA3
         MquatsM/VY/XuOxT9Ps9mFGnIgyhXQta6fKWgXRKORznv49qxZEVPOHoEwDfNhgG+dR0
         2+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=waLhSwmzkrR4GZ2NEL+2i7O+dQ6qjHxro4zSfZkMr54=;
        b=F/XZ6SuZ6GRPJSsFhH3ruKGH56pp2X+fU1jw/JNd5Yfs0yOiDCOxGcPNWDkNJIyGL+
         ppq5asgGmOBTuU20BF6WHWgKVa1J1qQbnOcPUFrTSs62EQg/CHUJqT+96SCnCRUjRQ1u
         Zw2VGOZjAEA0bndVYagV3mfVeQ1b5lwjd61aifBj3dvj9nf+VXtcZESdC8tP02YDHr9q
         /TvKVqSQoTcV6ia0/Xmq022DzQiTauXFzsHUErjh+dmERHNg1lpCFDt70zmbuKblttFb
         /hc2f5BhbHyho+N1Fb7v9moAuP9Uwfz9xMW3hdctinpDo7rwA5iWzBwsDOKsviAGxbie
         uQOQ==
X-Gm-Message-State: AOAM532uArK4FvOiBLRmtcL5tEeBcDyHH7KfeBajyx20gcId9rSeIoBf
        y6Ejcg1hSz4lBpI35wqPv78Gdhiv9jlqTJ6LjqDb3IRAr1KXkA==
X-Google-Smtp-Source: ABdhPJya+VmZ8XMxaPTJ1Bk8FGeJtYSFoFqBbnWLP1jzAKIa/hgbYVxCsIudOotH6dBjJxmr+WdALS4Bp9ZHG49OkSc=
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr18669180wru.311.1626791531811;
 Tue, 20 Jul 2021 07:32:11 -0700 (PDT)
MIME-Version: 1.0
From:   Bertrand Provost <provost.bertrand@gmail.com>
Date:   Tue, 20 Jul 2021 10:32:00 -0400
Message-ID: <CAPKfN0NJ65Qmx+tCPi2L_QhPfFcrhAHMSb2JSYSe26mtkcwf+Q@mail.gmail.com>
Subject: [bug][git-gui] Git gui is not executing prepare-commit-msg hooks when
 run from a worktree
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

What did you do before the bug happened? (Steps to reproduce your issue)
- Create a worktree of a git in a new directory
- Add prepare-commit-msg hook
- Open `git gui` UI from the worktree directory

What did you expect to happen? (Expected behavior)
It should fill the commit field with the hooks

What happened instead? (Actual behavior)
Nothing

The hook works fine in the original directory (with the full .git)

[System Info]
git version:
git version 2.31.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.0-77-generic #86-Ubuntu SMP Thu Jun 17 02:35:03 UTC 2021 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]
prepare-commit-msg

-- 
Bertrand Provost
