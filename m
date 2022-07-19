Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E9AC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiGSVgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiGSVgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:36:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09579B855
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:36:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so136975wmb.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ym+FJD9otbcILoWeD+FoU+KcsjU/Feh3pvIkGIp++20=;
        b=OQCD5G98d+yz9OCAgPptaAY9w2OHcIiZp4emBs6BeGK7Et8DS4jq+mKo/6BTt7V5et
         945l8CGZM0cyHkKYyfYKQZVPZOAKBmKevVBFAha0VT4gYRZUDksr04yQWGUBGpgCCsDa
         Sm1440BCuCCOXjLJe+AKxvYmonGxlu7A3NNYO5ipWR+70EqA4rC6V36ugT38+pX/EDiJ
         pFDhqV/YpPTAd0ihfXIXMQr5XCCnwv0cx/cUMuYyY1JHHjxWBlk1JDOottQHKov7bGmW
         nLbJpfAQfwp4j2yzG1huiMeRrZZ8yBH73pWHxnuWud1X1uM0QYKJZNlqfr5FqiMdfuX6
         G4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ym+FJD9otbcILoWeD+FoU+KcsjU/Feh3pvIkGIp++20=;
        b=0WYVMvtdDTlZm3lXoWOU2aNi+OLRNlfMGIzibEaTFwV9+YpJtW+GkT5cvAM256MjtH
         H1dAm+dClP5gpkfaTrkeTne/Vve3ZEg6NM/trfQihU3AmWzRvyHRaqI7MDU5bFfBXEnv
         93UYX6rNNuZvgkYe+z4KC6y2Cnw4ZIPtCn6Xa9huzJyo1m3owSY9HlBQFzXnzpWnHJjI
         BfaB1RKh9izhYTO7+HfluoOz5a1wbiBgH4h2RrTWfDdNgaZKqkU3dAlszeZ1IGVeCq7W
         nz0TgOdynPzaaVVX/WcODK5qQu5nuQ3do42cfLmVQBiIa58Rm86VQHa8Plp24WfcFHqO
         tYEA==
X-Gm-Message-State: AJIora/sdpy73abmuHI+nJIK6Uh3LEOShTnsqS68TAi0xCxflOcn34Hz
        /jtRpesnh9zZNvdkLVqODJ+quO/4igs6JYvgf/rKHWD99tA=
X-Google-Smtp-Source: AGRyM1su/vtvK0WAQFhSwV5op5wk1uzGOJeCmnwimKcL+qso0UvMQwRGQTgZkeOciUZdT5jnksfkZrD0J7FJRA6phS4=
X-Received: by 2002:a1c:2944:0:b0:3a2:fece:29de with SMTP id
 p65-20020a1c2944000000b003a2fece29demr1006427wmp.115.1658266606598; Tue, 19
 Jul 2022 14:36:46 -0700 (PDT)
MIME-Version: 1.0
From:   Kache Hit <kache.hit@gmail.com>
Date:   Tue, 19 Jul 2022 14:36:35 -0700
Message-ID: <CAC7ZvybvykKQyMWcZoKXxFDu_amnkxZCDq2C6KHoyhmHN2tcKw@mail.gmail.com>
Subject: BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. Output of git bugreport:

---

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Wanted to retain git tree structure when pulling latest and rebasing.
First indication of error was the `rebase -r` of the merge commit

What did you expect to happen? (Expected behavior)

successful --rebase-merges rebase of my commits on top of master

What happened instead? (Actual behavior)

```sh
=E2=9D=AF git rebase -r master
BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
(179457 > 1040)
zsh: abort      git rebase -r master
```

What's different between what you expected and what actually happened?

Anything else you want to add:

I'm currently "stuck" in this state, not sure how to recover or repro:

```sh
=E2=9D=AF git s
BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
(179457 > 1040)
error: git died of signal 6

=E2=9D=AF git log

=E2=9D=AF git d head~
error: git died of signal 6
BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
(179457 > 1040)

=E2=9D=AF git log # works

=E2=9D=AF git status
BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
(179457 > 1040)
zsh: abort      git status

=E2=9D=AF git commit --amend
BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
(179457 > 1040)
zsh: abort      git commit --amend

=E2=9D=AF git checkout head
fatal: Unable to create '/Users/XXXXX/YYYYY/.git/index.lock': File exists.

Another git process seems to be running in this repository, e.g.  #
All of this was run while git bugreport was running
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.

=E2=9D=AF rm /Users/XXXXX/YYYYY/.git/index.lock

=E2=9D=AF git checkout head
BUG: fsmonitor.c:21: fsmonitor_dirty has more entries than the index
(179457 > 1040)
zsh: abort      git checkout head

=E2=9D=AF git checkout head
fatal: Unable to create '/Users/XXXXX/YYYYY/.git/index.lock': File exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.
```


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Tue Feb 22 21:10:41
PST 2022; root:xnu-7195.141.26~1/RELEASE_X86_64 x86_64
compiler info: clang: 13.0.0 (clang-1300.0.29.30)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-commit
pre-push
