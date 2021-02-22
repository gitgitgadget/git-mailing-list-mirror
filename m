Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5226DC433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 20:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B6064E32
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 20:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhBVUEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 15:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhBVUDy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 15:03:54 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FCCC06174A
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 12:03:03 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q77so14655584iod.2
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 12:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=LY6LpAtx9eJsiCkx7plx1TyzmTMUQtqtRrvCe751Ruk=;
        b=KUUakYeopxMLI5j7L3i8QM8NdKiSI3k6KaL7muoosjb5xsRFzQ3UpVpv4mpdJPFT7N
         JhHDPay+F7fwSPdIzGO4vGYOSzGoWMfcV+C+altRMoDLGiJXaR7HLcZ6AcpPwqzCgsBp
         bbMJz5Mk55jJAhYeIeCuaNC18zeiwBFKMUNrpICOMniYRW6aPGi5hJK1nidzRFJk6Vzp
         7IiNZro5XJgX+Iy2EoqSNk3kb2/wOzDYj7sjW/xOQOuihy53Gw1eWaJGNG1/HhwYas42
         4tdhEQQq8/z5/3pYVfoujuobCWqN/epkS/WJVo4cuXTic5+WTWs8hmC8fOS+DOOBy85F
         88YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LY6LpAtx9eJsiCkx7plx1TyzmTMUQtqtRrvCe751Ruk=;
        b=kiREiXuY0GyzBwqbXkDgPiMq7xEcXA2q4Exh0Fxhg6hF/ZSuxfu4kyJ2+3L0Onfk5I
         6rO6IIHhgy3r9FNOPc9kiLQIbirntdvSBxDd8qO0Bg7M+BomRt6iX/6roZFx88W4MQbe
         iD6h7N7m15JPfK+8VWBeEM9zekBLq8rYCfZy34ByTKi4FDl9QSN36/W3sItvfzv6k4F6
         mTtXVNEbJoYhMDtYequXuZA78ttL4V3kV6gxj7x6MTQZ1iPU7Z4w365DSaAL3K27cAcf
         ce1mO8Bl9tvbpNnN/ZvmmQ5w0wZ1sOlN6NIanUbfKn4nji41HUqi6CdAW1NaY9QjoT/V
         rGvg==
X-Gm-Message-State: AOAM533xv0shAN8FanXJATHkuSeDukpeRnZ8nf3Q+0sTlVIuc+v32j5Z
        ifV413ERRYI5yOWDQB+Rhpvhlrz6399+2jvipVDbQESiMisUEA==
X-Google-Smtp-Source: ABdhPJzHPA9ttjmmlQV6R9qjjKPNBgh339J5jfzpvvXM7vEX5zBGSDhtAB9miDoZtJAhUuuFs8qXW3ZX0VSJsIcU/yA=
X-Received: by 2002:a05:6602:200e:: with SMTP id y14mr11245919iod.94.1614024183271;
 Mon, 22 Feb 2021 12:03:03 -0800 (PST)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Mon, 22 Feb 2021 12:02:54 -0800
Message-ID: <CA+dzEB=Ts=OdoYey+f-t+oLXAAv=f5hEJNpzb0G=LTpGPs+faw@mail.gmail.com>
Subject: git since 2.27.0 shows unfetchable object name for `git describe` for
 reannotated tags
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This does seem intentional given the commit message for
ff165f00c1065d94c0bcab8708364e6dc5655f5d

https://github.com/git/git/commit/ff165f00c1065d94c0bcab8708364e6dc5655f5d

However this is causing an issue when using `git describe --tags
--abbrev=0` where I expect the command to print out either the old tag
name or the new tag name, however it prints out neither:

https://github.com/pre-commit-ci/issues/issues/45

Is there a command that I can use to print out the old result (which
worked correctly) instead of the new, broken result?

Anthony
