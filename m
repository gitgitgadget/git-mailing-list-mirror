Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD121C433F5
	for <git@archiver.kernel.org>; Sat,  9 Apr 2022 21:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiDIVfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Apr 2022 17:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiDIVfK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Apr 2022 17:35:10 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE363DD
        for <git@vger.kernel.org>; Sat,  9 Apr 2022 14:33:01 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c4so13461371qtx.1
        for <git@vger.kernel.org>; Sat, 09 Apr 2022 14:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=dMgXV/mptx8DT3CUXX7rLIlXsug8K2ZXfOazsa5OLD4=;
        b=C+3luBvzuxY0r3uKmsrS5+fkEnq4v4U84FNEfArislzCOqhGJd7qZbZ7NGQWHZeKsN
         pL+f5dktUVVh2WrvKeq9GBe7166X94KmqIxM7r8ZYqEetfzQVZ7nmlYR+di/jQ8dmhqH
         MJjDBwhyIvQiZ2X1RbWBbuwjkb79uI08xiyAMV3oXt/8dmQszTq/FUlnNTVXg3X4YGXi
         YF0UwOSHiFVXqQxV0j4JBI9mK79HVchgkl7ScRZMvh+s4PDgsLnfYz6BLMADa/aq7e/j
         LuTX/YQ5lXL2iWZr3uvLfmYjJrPp1+fg4/m9wIhe/1b2OFESrOIokoSEy2IXXy2N9fsI
         KbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=dMgXV/mptx8DT3CUXX7rLIlXsug8K2ZXfOazsa5OLD4=;
        b=yOPfoLXjoE0TBHSkOiOd4ocpnzMFrBKzIB+Nhnpvkuy6QueD54c4vKjlqJMKWsC4kf
         zn830ZCQzskNfoMtCUhCTRcf3DRRLfrPgMjsj2JICvKmjrO9/UEHaGwDXkMutesquuBC
         h/hMJtFdcxYOl03PcHc8YR+cwZZF+cwCB8Iootm9f0tzqm319PwE10FtyCRGW9urncak
         XQEai82wfBgkwqcSD90K/9/efkskm1Qu31sAQDAtwN2R/ZzFdrp5QQbAowc5HPb/yIlg
         r9BeaRJfE3t5bd1+fu6bVRTQ8Uq73VqOun1A/p2rvWNMohD2yvN+4QKrWjik4Rhbet46
         UtHg==
X-Gm-Message-State: AOAM530U1L4j0r8RRKKt31RyAf7TPjcJ8nXzhxQPWHY/wBGac0RmZAUv
        FyYiPuYxEmmsy5IWF1ALlmggf7+79iU=
X-Google-Smtp-Source: ABdhPJzpzw0CLElan2U1DU/bE5clFQPgnIgPioNDNwqK2PhRw/Xr06NtxjVpFqBfpWnY3mnVQAOKjw==
X-Received: by 2002:ac8:4695:0:b0:2eb:db81:4be0 with SMTP id g21-20020ac84695000000b002ebdb814be0mr10168051qto.220.1649539980267;
        Sat, 09 Apr 2022 14:33:00 -0700 (PDT)
Received: from smtpclient.apple ([2601:184:4980:1190:81cc:6131:5ef0:ae9e])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a10a600b0069a14a5858csm4443766qkk.50.2022.04.09.14.32.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2022 14:32:59 -0700 (PDT)
From:   Trevor Burnham <trevorburnham@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: git push --tags failed silently when attempting to push a large
 number of tags
Message-Id: <E7B246D2-5B72-4BA1-97DB-5300A9074C42@gmail.com>
Date:   Sat, 9 Apr 2022 17:32:58 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# What did you do before the bug happened? (Steps to reproduce your =
issue)

I ran into this issue when trying to create a mirror of a repo with =
approximately 129,000 tags. I created a fresh clone of the existing =
remote (origin), created the new remote (new-remote), then pushed the =
main branch up to the new remote. (This initially failed with `fatal: =
pack exceeds maximum allowed size`, so I pushed the branch in chunks of =
500 commits.) Here=E2=80=99s where things became strange:

```
$ git push new-remote --tags
```

That command ran without error but emitted no output, even with =
`--verbose`. The command `git push new-remote --refs/tags/\*` had the =
same result, as expected. No tags were pushed. I also tried `git push =
new-remote --follow-tags`, which failed after several hours due to a =
connection timeout.

I tried pushing some tags individually, and that worked fine. So did =
pushing up smaller subsets of tags:

```
# push all tags that start with the letter a
$ git push new-remote +refs/tags/a\*
# push all tags that start with the letter b
$ git push new-remote +refs/tags/b\*
...
```

Those worked fine, until I tried pushing up a subset with approximately =
62,000 tags, which failed:

```
# push all 62,000 tags that start with the letter c
$ git push new-remote +refs/tags/c\*
Pushing to github.com:my-org/new-remote.git
remote: fatal error in commit_refs
To github.com:my-org/new-remote.git
 ! [remote rejected]         c1 -> c1 (failure)
 ! [remote rejected]         c2 -> c2 (failure)
```

As I understand it, the error message `fatal error in commit_refs` is =
generated by GitHub. I was able to push those tags up by splitting the =
subset further, so it seems that GitHub is rejecting pushes that contain =
too many tags/too much data at once. I was eventually able to push all =
of my tags up in this way.

So to sum up:

1. Trying to push 62,000 tags at once failed with the error `remote: =
fatal error in commit_refs`.
2. Trying to push 129,000 tags at once had no effect but did not trigger =
any error (or any output of any kind).

# What did you expect to happen? (Expected behavior)

Since `git push new-remote --tags` did not succeed in pushing my tags =
(presumably due to an unexpected response from the remote), it should =
exit with a non-zero status code and emit an error message.

It would also be helpful for `git push --verbose` to include more =
output, to better identify which step failed.

# What happened instead? (Actual behavior)

The `git push new-remote --tags` command did not push any tags, but =
returned with status 0 and did not emit any output to stdout or stderr.

# System info from `git bugreport`

git version:
git version 2.35.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 21.4.0 Darwin Kernel Version 21.4.0: Fri Mar 18 00:46:32 =
PDT 2022; root:xnu-8020.101.4~15/RELEASE_ARM64_T6000 arm64
compiler info: clang: 13.0.0 (clang-1300.0.29.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


