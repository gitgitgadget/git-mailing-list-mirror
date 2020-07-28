Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218DAC433E3
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA810207FC
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 23:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8RKy4AW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgG1XKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbgG1XKW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 19:10:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E8C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 16:10:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t142so1109388wmt.4
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=gzh7YKgzB/jAbU1gtQVton6NdNumcdlHhZudED+Dmns=;
        b=o8RKy4AWgInCTpKhqI8A9Vq3nWBMG+arIx7vdLZUR8V2tB12paT/g3JqSqsLFvmxTO
         EGuldxMkgbaq6uFg3HLhnfg+C97fO+v0ctN75LrFkY9ByzkC6/SE2YT/Nj7Pw6vrKMZr
         WSokkYzmyYAPgllaCmMW++EY8gu4yyTKM+4oGgnBgmf3U7uBjW0Ec7EkTHZ2OlC3mQGB
         wBxOcIcWRxGybM5qnfvvoUFHUd1/KGZZvMSvgqfDJJPy8rMnYEfTrfRnW4BpXYk6Sxlg
         VsS6ZP4ZjxHNwuSenVomXemG48nnyVWG08OWR1dWQVo6wkqAu85PF6e779LbE7x33nfI
         ldLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=gzh7YKgzB/jAbU1gtQVton6NdNumcdlHhZudED+Dmns=;
        b=SL5FrqCJT0vf5bH8RZxrKM2IOMtmsv/NaB/z8DXHKUKWJkm0ElHp0eskvRix5SDEKg
         WSgiyZ4mwfiADfl7Tbs++lUMqTLwi85+WGlvH2UvmYQNlbSA/1NnPzKGpEdsQ5ZtTXd2
         kKZcGQqYIjwPUPbt6Yx3nFtlZy5VTOuqrOSG4AGqFU2hWFOFJq2mphddwGs0vr83eE5m
         g1t0U2xBAkeAd5/CWThWjgHVssTB0p2IkJGlbVsviWHL7l2OQnSWJYh9Gb5uog0me5kH
         U0mQvPOfBaiFr9e2Uc3TeCEzU2S194VlQZEruBmlduiZAwHHFSLnSgpbdITvTLMRkJx8
         4UeA==
X-Gm-Message-State: AOAM531o+BYn9gzC/Q4a4DBUZTRzAeBHRmTkDjQR+/vdUSBfa4T0Wb5Q
        BxEDtHp4TR5rC9dWoG5xLJJtcm9h
X-Google-Smtp-Source: ABdhPJw9Ue7ZN9Gf6W6kZfky3y26Sude9p2HqIWjeOiUoAI320quIyDx2e/jRrF4peEgi8bl6fS/sg==
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr5781282wmu.142.1595977820988;
        Tue, 28 Jul 2020 16:10:20 -0700 (PDT)
Received: from [192.168.1.64] ([81.141.108.232])
        by smtp.gmail.com with ESMTPSA id j24sm777285wrb.49.2020.07.28.16.10.20
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2020 16:10:20 -0700 (PDT)
From:   Another Email <yetanotheroneemail@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Issue when adding new files to staged changes using interactive mode
Message-Id: <5BDF4B85-7AC1-495F-85C3-D429E3E51106@gmail.com>
Date:   Wed, 29 Jul 2020 00:10:19 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git init test
cd test
echo "test" > test.txt
git add -AN
git add -p

What did you expect to happen? (Expected behavior)
The file would be added to staged changes after confirming each =
individual change in an interactive mode.

What happened instead? (Actual behavior)
I get "error: test.txt: already exists in index".

What's different between what you expected and what actually happened?
The file wasn't added to staged changes.

Anything else you want to add:
It used to work before updating to 2.28, previous version was 2.26 if =
I'm not mistaken. I couldn=E2=80=99t find any mention of changes in the =
recent release notes.

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
uname: Darwin 19.5.0 Darwin Kernel Version 19.5.0: Tue May 26 20:41:44 =
PDT 2020; root:xnu-6153.121.2~2/RELEASE_X86_64 x86_64
compiler info: clang: 11.0.3 (clang-1103.0.32.62)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

