Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAD9C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 21:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F01208CA
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 21:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO22cApz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHaV7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 17:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHaV7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 17:59:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD2BC061573
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 14:59:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b79so826541wmb.4
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=0L/vAq5AnWPynhjSrjdBZVknNePpw8XK6dwAPvFcWqM=;
        b=gO22cApzkqgDfiZQZCKOfUxWoSE0u+qdtUHipAE4NjbDMAI6qwI53ECGvmLSNAfjjS
         Oo1g6z9oafrz9fPlKzLjuIYDUoNNCd5z8pIEe4DEWm2T3YOcMPA4ihxx3M2MEXaHpOd3
         AUCUu3q3SPV2wSw38WZwbXGEPmGR4xhLLxXqlPaNjY7Dox5ChytQzYHLIa+NwF0l+L9/
         ShBPC+8CC/tvuB+08zuOBq0bIv1gxDWHW+FGsQeTr1lms3YSHIwBgnJyZqpfE/BgYrw7
         763kR0UDVieD5vEPo0to2HbjpZzLkBZXBDWh82dxUiCNP866A/UIF0ZW59aF5WT8byh+
         wexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=0L/vAq5AnWPynhjSrjdBZVknNePpw8XK6dwAPvFcWqM=;
        b=JDCTw7RuIzRVYRVSgaOSdS+JpdnO8AHAbwgPvNfiaBWICKDErDsShXNoAySJGUFmP4
         TgnJfTIS7+TLXSMeS5ExtR4lYqLcBqaRhX1sRMsUPZOL4cbRkjI6XrsU404DNac502j9
         mDK9sPvDyjNz4N9j9aXqXbNQ3Hdo6Fl1V9fG+XP9sV8cbHK7l6E35/MM201GaoHahMHx
         gk6LU6xLiMVwHlFeaI6syYdgPiVWiKnRmumyRdDYzFTK23i0bT9UaN1TjDyJRlRrjxoh
         iY5m8teaanHkghwb9SStvZqGu0SVxZGBzTYXdbdw+CCw9lqCTk52lrhozvst2SRTs8Cg
         ydng==
X-Gm-Message-State: AOAM5328hyvqiz9H6M2l8l3TyaSBtek77ykUoTxT1oKJGP99UnUZBPjP
        Gs25aIYx5sgDax+gQhrlijPquFHezm8=
X-Google-Smtp-Source: ABdhPJypWk0Qz55C8Q29f93mvl95T0aMU4PoQp6xg1EbnXmT/SPUz9Insxi16OT19599cDaYJp84Sw==
X-Received: by 2002:a05:600c:c7:: with SMTP id u7mr1214800wmm.135.1598911180974;
        Mon, 31 Aug 2020 14:59:40 -0700 (PDT)
Received: from mbp-de-thomas.home (lfbn-tou-1-1379-99.w90-89.abo.wanadoo.fr. [90.89.187.99])
        by smtp.gmail.com with ESMTPSA id w15sm1664098wro.46.2020.08.31.14.59.40
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2020 14:59:40 -0700 (PDT)
From:   =?utf-8?Q?Thomas_B=C3=A9tous?= <th.betous@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Bug Report: "git reset --hard" does not cancel an on-going rebase
Message-Id: <34B7EFB9-8710-4993-ACCD-604313D543E7@gmail.com>
Date:   Mon, 31 Aug 2020 23:59:38 +0200
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I would like to report an inconsistent behavior of the rebase/reset =
commands. I don=E2=80=99t know whether it is an actual bug or something =
else but according to me something is not right.
When a rebase gets paused (because of a conflict for instance) I would =
expect the command "git reset --hard" to cancel this on-going rebase but =
it does not.
I expect this because for instance "git reset --hard" cancels a =
cherry-pick in the same use case so I think the behavior of these 2 =
commands should be consistent.

The issue can be reproduced with the following commands:
# First trigger a rebase that will paused because of a conflict
# (there is probably a simpler way to end up in this use case)
$ git init test-repo-rebase-reset
$ cd test-repo-rebase-reset/
$ touch file
$ git add file
$ git commit file -m 'First commit=E2=80=99
$ echo "dummy line" > file
$ git commit --all -m 'Second commit=E2=80=99
$ git switch --create new-branch HEAD~1
$ git rm file
$ git commit -m 'Remove file=E2=80=99
$ git rebase master
# Let=E2=80=99s check that the rebase got paused because of the conflict
$ git status
$ git reset --hard
# Even after the =E2=80=9Cgit reset --hard=E2=80=9C the rebase was not =
aborted
$ git status
# Now let=E2=80=99s check what happens with the cherry-pick command
$ git rebase --abort
$ git switch master
$ git cherry-pick $(git rev-parse -1 new-branch)
# The cherry-pick got paused because of the same conflict
git status
# Let=E2=80=99s try to abort the cherry-pick with the reset command
git reset --hard
# Double check the cherry-pick was aborted
git status

I think the behavior will be the same on all OS but if it helps I was =
able to reproduce it on Cygwin/Windows 10 with git 2.28.0 and Mac OS =
with git 2.26.0

Note that in the commands above I didn=E2=80=99t give any revision to =
the reset command but the issue would be the same if I did. Moreover it =
makes it even more confusing I think: you can move your HEAD to any =
revision while the rebase is still waiting to be completed.

What do you think? Does this behavior seems normal to you?

Thank you in advance for your answer.

Best regards,

Thomas=
