Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78D8C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 02:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE66161AEC
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 02:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhKSCuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 21:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhKSCuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 21:50:14 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB28C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 18:47:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id m24so6981690pls.10
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 18:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=P3oHrXrvW7LR9ICKt+GDXcJaqb5QiXw2z04tfc7yXSw=;
        b=fakm7bhxGlFyQl0HLH/CqVcK23MSHwxD7GncGKHRyLi3xGVeyhJezZe7+zW396APUv
         Chp2f1jZk+vbpOelDbhmu/BAFhh69NQMi0Fr4nkVWqm9LvGPntLSwQ4swkwc4NYK88jM
         6su0IM6OnSHzRdWbCUDdheZ1aus3pY4A720m5Xr/Suso1jzg612anAF4jaZ+YIcWDwVN
         uyqYvLhEMdW9/tV1K177LadfBhRDzgPz980HDjbyB2GzAvK3NJMuk+IpxgjWJw7WtxGg
         PqzFbC4/m+TVgic3nyfrNpWwBtu9vxQkBT8kcb2Vd9ZwxP/L8rdjDwuLTZURxCp5TZmy
         /ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=P3oHrXrvW7LR9ICKt+GDXcJaqb5QiXw2z04tfc7yXSw=;
        b=R75tlaJclct5v303xwK3yw9rc679vg3KqGue4tsemOXeVqiuQl5jhhd5neW/DT9Iwq
         /jU7X2saEkQAwH+D5rnevmAGsw1mTPomiOemZWeK+LjTqErg/8gCTsNsAo9eYM1Jdt5n
         Lp9d24rKQjSp3FGr4gatsFRscPLU7Z7lQhB31fJC+QqRynESZRXApsUfTnhIyj/lOs//
         3lfgzSWu0O5q3WYM/BPZlKBkjeu9XuepzWUNrcObqsKJn/Ti177K2XDUkqGO1PWL53S+
         FxiD0mGYt3ln4KM4Qkpmg3t3nTE4seWgvFezuS9u2EQjbaAGLxFGL1cN26VnXfjFemf1
         uVhg==
X-Gm-Message-State: AOAM531FPi8Y9+d+uyKtF4Ml3YbFb05GhSDuNOA5EJqn7ImR629JHlr2
        taupMxNc7fFVRfTuFwRg47wPIaB5+sDshcbnVAthLPMrIIXbfQ==
X-Google-Smtp-Source: ABdhPJw+oKYoZVSRS4ceWvVUsL1TBsTX9GO6q0gwWjcwdaUorA75UACvDqD0BJA4H68sJ+Wl21/clvcE+tEQ4EQ/Z4o=
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr305263pjb.173.1637290033111;
 Thu, 18 Nov 2021 18:47:13 -0800 (PST)
MIME-Version: 1.0
From:   Thor Andreas Rognan <thor.rognan@gmail.com>
Date:   Fri, 19 Nov 2021 03:46:57 +0100
Message-ID: <CAMn8hCcFLR-YyLaawtbtjpVUKd45Z4C6t1kWj+-WBZVNtNgozw@mail.gmail.com>
Subject: Ambiguous verification response when ssh-based signatures
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

$ ssh-keygen -t ed25519 -C "me@example.com"
$ mkdir -pv ~/tmp/example && cd ~/tmp/example && git init
$ git config commit.gpgsign true
$ git config gpg.format ssh
$ git config user.signingkey "$(cat ~/.ssh/id_ed25519.pub)"
$ mkdir -p ~/.config/git/ && touch ~/.config/git/allowed_signers\
 && chmod 0600 ~/.config/git/allowed_signers
$ cat ~/.ssh/id_ed25519.pub | awk '{print email " " $0}' email=$(git
config user.email)\
 >> ~/.config/git/allowed_signers
$ git config gpg.ssh.allowedSignersFile "$HOME/.config/git/allowed_signers"
$ git commit --allow-empty -m "Initial commit"
$ git verify-commit HEAD

What did you expect to happen? (Expected behavior)

A verified signature without any error message.

What happened instead? (Actual behavior)

$ git verify-commit HEAD
Good "git" signature with ED25519 key SHA256:...
Too few arguments for sign/verify: missing namespace
$ git log --show-signature
commit 4697b474dd5ec0de14870d5b0eba5f579b852bbd (HEAD -> main)
Good "git" signature with ED25519 key SHA256:...
Too few arguments for sign/verify: missing namespace^M

What's different between what you expected and what actually happened?

Ambiguous signature verification message.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Mon Aug 30 06:12:21
PDT 2021; root:xnu-7195.141.6~3/RELEASE_X86_64 x86_64
compiler info: clang: 13.0.0 (clang-1300.0.29.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash


[Enabled Hooks]
