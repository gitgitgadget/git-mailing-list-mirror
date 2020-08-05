Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895CEC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DD5233FD
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 15:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFG2ULYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHEPye (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgHEPsr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 11:48:47 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9594C0D941C
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 08:16:07 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z3so27447351ilh.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 08:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=emaIMZYhKo2QOPIxGlNASXCLJVVzwVu79w51jMqtU6o=;
        b=iFG2ULYlLi0t5JHSOIVKJjiGVpAN1PwxS19v6zioujPu042M+/2SYTw7VW+AtM9ejB
         Eta44c9khsz6LOBmfbkbYfJQub7JBpJLFZKPdZTfWp529ajOpVd+f9ROjv94CfpHtsav
         x2YcL7+wZ242s8xi0qTJHiNtKhlg4ZHNbFwkR4MkwvQdSDbxFeErBrZv//dPdDd3TM8C
         JmPVes139Lg60xSHo5cJ7gaquJJVSjTbqooRUxBwIdlijzqplXn0dAcwQ6/xOtSo4onT
         6RS5EdPfrCCjI8b2Sz14UVtsf7G8EC6tcfninAU0RZXPRjQfRbOw5/fLk5C0HTw5reaI
         zFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=emaIMZYhKo2QOPIxGlNASXCLJVVzwVu79w51jMqtU6o=;
        b=fT4/E0egMr8Xk6GUPJRbyrPVAbIxy7odUcb+rSZLaBRrTiIsPL9QsFEbegGrB8E4tJ
         Nczwpzuylg5eEkRts3mTsRPVsiUtXpTc81WdpvkxsjOsp4hrvp7Pv0LzvMekmyOWQDY7
         p5jwiMyWaUTJThwzldYFkzGXdt5z2MjzgK1VqlX8yq68xvZBExBr/ZMrnJxiPoIqh2hG
         P9Lt+rGYcAuMUa3Y2ldHtYkn7wJq2GwWr/pzVKmEiBSAkkTJ7E13Fuhj/g0668vBydAv
         q/uygAl7ou/qwmXnccMNc+9nZPIDgHk4WCk/D2FI4jeiRAklL6GGckTOqiLrdp/lZLIi
         tN5A==
X-Gm-Message-State: AOAM5316pOpA7QL/zFhmix0SfcPAxWKWbzzv6MdY62xqq2pLEfzyIOs0
        FTu2AKT+uiguBZCcRI/QcOj01ozO5NFNRV4WS/ORdylAgZU=
X-Google-Smtp-Source: ABdhPJwIMyYxaI8FDY+MtlNuQ2FN5EjeT9osqXN7uAWrc1LLNuqKLxFak4Jdh2BBKR8p+OrHALb9hm/DaDiXzxNrgXY=
X-Received: by 2002:a92:da01:: with SMTP id z1mr4582447ilm.2.1596640566869;
 Wed, 05 Aug 2020 08:16:06 -0700 (PDT)
MIME-Version: 1.0
From:   christian w <usebees@gmail.com>
Date:   Wed, 5 Aug 2020 11:15:56 -0400
Message-ID: <CADjceoQxoL932W4mkfhG6VOgrQBhs9k6tXkWSkraKVPmUP+uCw@mail.gmail.com>
Subject: ls-files bug report
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

git ls-files --others 'some/path/*.some.extension'

What did you expect to happen? (Expected behavior)

only list files under some/path/ that had .some.extension

What happened instead? (Actual behavior)

It listed those files and also all untracked folders underneath some/path/

What's different between what you expected and what actually happened?

The folders did not match the grep pattern but were still listed.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.28.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 17.7.0 Darwin Kernel Version 17.7.0: Thu Jun 18 21:21:34
PDT 2020; root:xnu-4570.71.82.5~1/RELEASE_X86_64 x86_64
compiler info: clang: 10.0.0 (clang-1000.11.45.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
pre-commit
commit-msg
post-commit
post-checkout
post-merge
pre-push
post-rewrite
