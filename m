Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CEEC433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 09:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388B464EED
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 09:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBZJJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 04:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhBZJJR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 04:09:17 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B2AC06174A
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 01:08:36 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id o1so1761011qta.13
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 01:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ItM1QObM3Ura0qmMBXrxgm2LSN5rvdr2KPWhYDe6jtk=;
        b=iC4IF2HETT7tvqkswCMQQEjoVkDIlwuHuORb4WkC3bCy2nQxEV//bFi3KWAJiRSUc3
         IqZHdECpyk4cN5eH/iQczs819m8fn1Q8537rbGxXnrXkvC9BwfckY9GPuDlo4y33ca+5
         sN7+gyRVgr4UNX9DMvS1g+oV5mOPoTsZhj+2EZzN7imoz+qe/6qpiFdiT/jSxGpj5EOM
         a2/NBpoiEy8PGsFCK9djQpk7xTGcY4+zP92FZak80t8IgETndP251MaxGP3AJoqJegs0
         6IwSsV33wl64qtJ7AcndUCkgWMFlrOywaaiBtsRp7AgWnxVInXbKnNPjWMVjTIpPBbIK
         EK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ItM1QObM3Ura0qmMBXrxgm2LSN5rvdr2KPWhYDe6jtk=;
        b=m5kAM4xNPRoErB5x2qx3YbAq6b5hqV87spbi6+aA34lZpYY9iJDB94lsU1BvlWEG5M
         eTyWo93Kg9r4oiBcKYCvDZPbV2yxss+lI9vFdRJ/jt87K0K/Caclak0PRL4uPTgGs5po
         fQAwEtqL5Yx6gn+f2GbKktjB/GMFuEf9tSBkzdi0us8FxfRB/vhjWgmtQD023kBAnsqO
         NE9bHj45Mw1mtYGtl8DfB5HoE7DN9cLXdHvVQxVrUd/iyoellGlGIg1HN45Us/nVvBep
         CiLFbNQJWBiwHASPQBVk5UU7/am15cUxJ9SV52s9QwY07XQPMx5Qq4B+G9ndSDfbZ9SR
         jAgw==
X-Gm-Message-State: AOAM532Kik9/9UwN9aAm8Nourm7MlMI66gRRxqN0+Z+cYdsDuFHXJdz7
        RuZD0m7hKgbK5pmN6hUQSWNat+h0TBHtIcqov8cC1Ax+LPg=
X-Google-Smtp-Source: ABdhPJypLdr+VZAQYFfXqCfvx9PjVw40MIWM9rCpeWjgHJqEQpE3DuSjr1nypB7urEyGTWGS7QVPLpQjkjLDHgBZklU=
X-Received: by 2002:a05:622a:54e:: with SMTP id m14mr1820697qtx.128.1614330515568;
 Fri, 26 Feb 2021 01:08:35 -0800 (PST)
MIME-Version: 1.0
From:   Jean-Marie Lemetayer <jeanmarie.lemetayer@gmail.com>
Date:   Fri, 26 Feb 2021 10:08:24 +0100
Message-ID: <CAAdc0hwmR7BF53_66LNaceLrkFPDphU-y2sLEGB_1YoR5ErQsg@mail.gmail.com>
Subject: [RFC] new subcommand: git sync
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I created a new "git sync" sub-command a few months ago to deal with the pull
request workflow.

Its goals are to:
 - keep all configured branches synchronized with the remotes (--set-upstream)
 - do not touch your wip feature branches (which has diverged from upstream)
 - prune the remotes

As I use it on a daily basis, to synchronize the remotes and then be able to
quickly rebase my pull requests. I think it's worth sharing. What do you think?

For now it is a simple shell script available here:
https://github.com/jmlemetayer/one-time-setup/blob/main/git-sync

If you think it's a good idea, I'll propose a series of patches with the new
sub-command, the manual page and the associated tests.

Best regards,
Jean-Marie Lemetayer
