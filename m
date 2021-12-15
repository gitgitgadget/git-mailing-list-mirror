Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6C6C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 09:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhLOJu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 04:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbhLOJu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 04:50:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302F1C061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 01:50:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v11so37089671wrw.10
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 01:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=HRVvdOlfOJQ3pK4UaWgR+9kbyhUGgnJLCx0HT0XpSf4=;
        b=F2RdNK4Paxru+YzUzxtxdaJSKUteTOU5XpLezk0VhHNe5cLSStUdACfyRtAgUGwZBr
         aWa4m5/xhktjlLREM2DzNLP9R7vjR2hnaIWo4YfN1x9Ojn42ZkBltBBvolnqbj4Ss2WI
         ALOBjInw4ChKIdzvvaPWTXYLC/ApqGTFc2I4q8gLlTCLPcUHOnas/q7dd3yxQUoyC7+o
         JADuPh49aEIZ9teRCe5Vww2uxv4EcFsomW1v6nR6AVRqwatGwtUqSolR4hO1ZrMak9jY
         qjZHz5g8rdkJBoI7V7tzpsVFQFvyFs000aNz0RNPxRrj25LbBPCnGYK+N1GvKbIOWcSi
         DvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HRVvdOlfOJQ3pK4UaWgR+9kbyhUGgnJLCx0HT0XpSf4=;
        b=7Y/rTlCJMeZmiBVOXKTCtcKhK5e7pifmRLTILI6vsWMrsUG/iPelVUQofiAlMSgbWx
         rZMoUB9u2XTWHYOO55u+21yP8u3+paZHc1CQbbbFxzrIcQYn10Jhpv0SWkZJCYUPK01a
         FdCiGx3jc+dnKdxVua9Ia1y4EUNYMh4z0CmaM+cHegRnxFEvww6OBPV4r2+16BzbbZbz
         tGI/pY+uW3UHIyQ8JFv5n1PG6q69Oeh7P4yHG0gev2LhdPUaU2VJFuLS9go0Nr2tIc4t
         ozmVb3J8/Hhzlu+rX9d1qd290rxy1Yiu16TxbpD7Q+Hz8+ZCrK41VH4y0LcfS/6VxqlT
         a+Og==
X-Gm-Message-State: AOAM530PUIWXfyOGqgxnXi31WeyrS7B5M0XFr9PrftLyaBWwB0BjPZll
        aYnJcKVmWs7i/LnjCv06tt6fCyOEcnpS986ze9Eil9O3MZw=
X-Google-Smtp-Source: ABdhPJx05Lcd7aFNa6jfQY1Cx51DHbJU1TIvjNR33cgXwry5E9BkNh+hFjmuL99qI/oZQvXlFaM1wNMCI8LetOm6LHU=
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr3538722wru.384.1639561856258;
 Wed, 15 Dec 2021 01:50:56 -0800 (PST)
MIME-Version: 1.0
From:   Dotan Cohen <dotancohen@gmail.com>
Date:   Wed, 15 Dec 2021 11:50:44 +0200
Message-ID: <CAKDXFkMvXJm5+5Qxz2N5NH-s+nptayG_7+yTSPxynZxkOcaVKw@mail.gmail.com>
Subject: Git bug: Filter ignored when "--invert-grep" option is used.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened?
$ git log -8 --author=Shachar --grep=Revert --invert-grep

What did you expect to happen?
I expected to see the last 8 commits from Shachar that did not have
the string "Revert" in the commit message.

What happened instead?
The list of commits included commits by authors other than Shachar.

What's different between what you expected and what actually happened?
The "--author" filter seems to be ignored when the "--invert-grep"
option is used.
I also tried to change the order of the options, but the results
remained the same.

[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.11.0-41-generic #45~20.04.1-Ubuntu SMP Wed Nov 10
10:20:10 UTC 2021 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
pre-commit
pre-push
