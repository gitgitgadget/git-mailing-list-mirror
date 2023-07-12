Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6494EB64D9
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 15:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjGLPBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 11:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjGLPBf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 11:01:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6BEBB
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 08:01:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso4226055b3a.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689174094; x=1691766094;
        h=to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bsgyh6EctDjm8fD/wSp3vXsfXhTyPBaswy4jv5bx4U4=;
        b=JWMSqKwZwvEgpEhMOy6+wsvu+ztp1rp8brBUl/0XTXiQw43PDNYkxIVgLvQF/4ZNLl
         CtjZUqh2BAcuOilOWCzeZXu+ERi+rpenhaNjynC4zAbWNKpK+BcS0cCgayYBxceOzCwV
         g4cihMRont+7p3HDQ/6YTcgtXi3gm+BsqeFqQlGAPucDFZ3yt10xemaXwl7FgT6FOkZv
         JCsyliqbycl/toxziR6WkmIHSs7kYbdVExNg5EF0YeTml8h2qZGWOeApxuQdZGB93tOj
         vKhnQkgQpPp0OQXaDnbIKoIZRBlqsl9+6l2YUrexQXwUQgFG7u3hGmPaYWqTcvPOTM+Q
         Godg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174094; x=1691766094;
        h=to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bsgyh6EctDjm8fD/wSp3vXsfXhTyPBaswy4jv5bx4U4=;
        b=clLoICESX6ZsBTsoiE/O9l3fQevq9lEfPRHyG/4UcI1bq9hWTxww1ois1tUcfrE/Hy
         9VcI9ZcYJKR2EYPLjtChZc1w1Kmnh4Fm/lEqYU96zJslo5lbP5e5Qcot8hWz1D9PcGUg
         MkTpnfC7/9YcWaWrVHW7ja4i0UBey/oDMQG9u8f00wZFjoTAMifGVTJsPYJlLH2jh1XU
         1+aomAwzgI0aLBIdd0Dsoxd2VgfLX62XcTnKhtMPCravV2tY/Kotk/VT5NkAcaIn3Rd9
         6X0eYTYFEkYCwqyh66aTgaN1U8pQd4KrGM7BHFGIS2qoOZI4+34sEJQJKiN+keNgMKOk
         +LlQ==
X-Gm-Message-State: ABy/qLZbRendNnnyMqamloqV0dH3zOQrNOdXI43GPkX86m1kee2r6aFZ
        rJKfw34vzMon/PoeU4VtESQqQrenyIRZVhBb
X-Google-Smtp-Source: APBJJlEwW+wNqqgP/2BUb/uktvJpvu2yI154PYQzHbxP3FjrvnDhukeNciwE9/aj4j10S7lfjpnJ/A==
X-Received: by 2002:a05:6a21:6d90:b0:130:9638:36d4 with SMTP id wl16-20020a056a216d9000b00130963836d4mr15608463pzb.33.1689174093024;
        Wed, 12 Jul 2023 08:01:33 -0700 (PDT)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com. [209.85.216.45])
        by smtp.gmail.com with ESMTPSA id d190-20020a6336c7000000b005533b6cb3a6sm3624344pga.16.2023.07.12.08.01.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:01:32 -0700 (PDT)
From:   Manuel Ricci <manuelricciwc@gmail.com>
X-Google-Original-From: Manuel Ricci <manuel@webtea.it>
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-262cc036fa4so3525830a91.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 08:01:32 -0700 (PDT)
X-Received: by 2002:a17:90b:1d10:b0:263:8c2:6290 with SMTP id
 on16-20020a17090b1d1000b0026308c26290mr15033417pjb.43.1689174092332; Wed, 12
 Jul 2023 08:01:32 -0700 (PDT)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 17:01:29 +0200
X-Gmail-Original-Message-ID: <CAMvNOSqDgDnchNdNq7AvBYbMTFfy0mWMygHnX_8HjTAnBA=AnQ@mail.gmail.com>
Message-ID: <CAMvNOSqDgDnchNdNq7AvBYbMTFfy0mWMygHnX_8HjTAnBA=AnQ@mail.gmail.com>
Subject: Possible typo in git stash doc page
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

In the doc page about git stash, specifically where there're the
details about git stash push
https://git-scm.com/docs/git-stash#Documentation/git-stash.txt-push-p--patch-S--staged-k--no-keep-index-u--include-untracked-a--all-q--quiet-m--messageltmessagegt--pathspec-from-fileltfilegt--pathspec-file-nul--ltpathspecgt82308203

There's a reference about --staged or -S. I tried to execute the
command with that flag and the output is like this one:

error: unknown switch `S'
usage: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
          [-u|--include-untracked] [-a|--all] [-m|--message <message>]
          [--] [<pathspec>...]]

    -k, --keep-index      keep index
    -p, --patch           stash in patch mode
    -q, --quiet           quiet mode
    -u, --include-untracked
                          include untracked files in stash
    -a, --all             include ignore files
    -m, --message <message>
                          stash message

Even if the flag is --staged

error: unknown option `staged'
usage: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
          [-u|--include-untracked] [-a|--all] [-m|--message <message>]
          [--] [<pathspec>...]]

    -k, --keep-index      keep index
    -p, --patch           stash in patch mode
    -q, --quiet           quiet mode
    -u, --include-untracked
                          include untracked files in stash
    -a, --all             include ignore files
    -m, --message <message>
                          stash message

At the start of the same page, --staged is not present in the push
arguments, so I think that is a typo.

Have a good day

Manuel
