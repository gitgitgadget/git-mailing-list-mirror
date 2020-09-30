Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24260C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42DE206E3
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZPNDqHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgI3VPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3VPq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 17:15:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F48AC061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 14:15:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e17so908529wme.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sFx4eQuQuG3bl4wxM0TCPlDYVQ8Nyqj619hU7tdCIGg=;
        b=SZPNDqHm6mdSQrGzMqKm8onkUgR8ctMw15h8+nQIilBYNojIz8chsZ7vf7XGhNuDTp
         mpBwRVd5HnDdWtdqk9A22L8ryH3P3of3RU64rJROaJk7T1xp4Q0jtrmGVn/1hWliVEte
         fDXJqJYyiG3sQa6S1Gm+p/cXvICjHhR7w6TzQmoLHpxXb4S7pp6QsrLxoG5oxWc/hejt
         Ga+MZCEChSgPjmonvNh0DHQqNOYYf3DqeKF6GXftmsc7lZ3r+altUDTiW3tgywnoLfwd
         z+dFGzJCMgdS66KUsySYitHGxVvvZbP5nht4SubcsH1ILBrHfRhiTigfiGwK9aadolHJ
         YFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sFx4eQuQuG3bl4wxM0TCPlDYVQ8Nyqj619hU7tdCIGg=;
        b=eyjnxdEDyGm3qvHNS2p5IVgVSUvGbYiT35uwGdYlKhN6BwfgMzh5Wa1xsoZKaPbdZt
         QPOi9ImSqG0rCQY27sBbtrrAI69zTNz4nRI+SOJ1xjLCYIWTJdPcxHlLpwvojl5FF2fB
         5rvfxxj9hDtZoaWdtiZcxgpHU5TK6ixHfzYzliMebR8o77TejYHsyLhvkZCbqKCVyy5y
         eYkBFe73S4OLp3g5Z39dPsduU25Re4O4gCCXlzEiMmkrccC7hIvocNv/fw79igIRDHri
         iF0O6kJEzqMP5EZtYIKcgzC0CLh3+saPgdyy3qGQEPoODhwOlFPCtewK++YgI5EOdx5X
         qzJQ==
X-Gm-Message-State: AOAM5331zp4c5q7lkLUM3iGlZNG/zdjT+fxiCq1YT2aQNV8YxUGNj78A
        O8NXdOTMiQFaS0vxVh5EBexTDli7bzQxx281qqAdTNH4FFDbcg==
X-Google-Smtp-Source: ABdhPJxSGIbOE9tSGb2ZzyIR6lpj3p4dNb3CR8PVEAFGD3w60+BxgIBRmJrBM71nkXSKAEZFaUFjkhs7SrZffIB4DIY=
X-Received: by 2002:a7b:c959:: with SMTP id i25mr5191297wml.39.1601500544207;
 Wed, 30 Sep 2020 14:15:44 -0700 (PDT)
MIME-Version: 1.0
From:   Harrison McCullough <mccullough.harrison@gmail.com>
Date:   Wed, 30 Sep 2020 15:15:32 -0600
Message-ID: <CAHLeu+x-z4ntmBezcVUWssZrCm03Md6ZR8-ZQmjkeB5YT89caQ@mail.gmail.com>
Subject: git blame --ignore-rev does not work
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened?

1. Commit changes to <FILE>
2. Observe that this commit has a hash of <HASH>, e.g. through git rev-parse
   HEAD
3. Run `echo <HASH> > .git-blame-ignore-revs`
4. Run `git config blame.ignoreRevsFile .git-blame-ignore-revs`
5. Run `git blame <FILE>`
6. Run `git blame --ignore-revs-file=.git-blame-ignore-revs <FILE>`
7. Run `git blame --ignore-rev=<HASH> <FILE>`


What did you expect to happen? (Expected behavior)

The three git blame commands should attribute each line of the source file to a
commit, but none of those commits should be the one specified by <HASH>.


What happened instead? (Actual behavior)

All three git blame commands included lines attributed to <HASH>.


What's different between what you expected and what actually happened?

The commit identified by <HASH> was not ignored.


Anything else you want to add:

I tried this in a brand new repository and everything worked as expected. I do
not know why it is only failing in this repository. It is a large repository I
use for work, but I'm using the same version of Git in both places.


[System Info]
git version:
git version 2.28.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 18.7.0 Darwin Kernel Version 18.7.0: Mon Apr 27 20:09:39
PDT 2020; root:xnu-4903.278.35~1/RELEASE_X86_64 x86_64
compiler info: clang: 11.0.0 (clang-1100.0.33.17)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash


[Enabled Hooks]
post-commit
post-checkout
post-merge
pre-push
