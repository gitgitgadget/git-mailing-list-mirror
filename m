Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E48C433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 03:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA4064F04
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 03:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhCRDnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 23:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCRDmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 23:42:47 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05256C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 20:42:47 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so3951186otn.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 20:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waleedkhan-name.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Y8gm4rqhq9KJxGhKukbc3LmQvlQsoRZoXQYUyHNJt2A=;
        b=tglR8iKSU7Ibp2FR3RrKDBTY0KhfrTopLtRKp78vZQvYApg8xeZIfSH60a9Vn260SC
         jGyrUaYBPg9i7BZ+Ydcqje7DC7zrbTQfhgHMXcNBA8QaFgir5vgEpRVSeT3jsMzcT+HE
         6G+HJSt7SXMgAh6X3sMd+lWOgPpaaMpUEi0ILDbSLncikudvi/G6Ort1AX1T84ciEKwO
         pTiLAexvRSs5g/1xF3gt7E06HYIweGf08GhRrpZkXLU6hoJEE1I3FOItiyqMloP3c3ap
         T6OEXlEh9fzCPkC+X/NKIVCyCGOH6gg7ixGyQc7eIRTb52E8ZmTbCHE785a0OF9fY01q
         pOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Y8gm4rqhq9KJxGhKukbc3LmQvlQsoRZoXQYUyHNJt2A=;
        b=tTQki8Yx+28Vxquk7iKc6JZ3aNy6s2XikjFY3l6oq2px7/kCHxcVIkZ+ki7/2LAMfQ
         fhk0uKWdkZemDKnIQDcWhDr93PvYMONxHtSkrAcZL9cxtnWFFJAtzuFL9J95hvdhA2ce
         SamgbYFVVv51ejSiWB6XgLM18/pmKXMkdFQ28ZcssEM+Ak6J6/Qa6S+AAKlBdydkDHe6
         GhHLC955TO6Wtf3ejbkFF/imgQRpaIbxYG0aHq09wBhvK/sjss7/o8525HaekGAWO6yt
         BYAnfjVbARks+3FmqN3oMnlMxmUMEzOZwiLK4ekPDSrkzcesyfUFcecaT69w9oIT1CXi
         +Mjg==
X-Gm-Message-State: AOAM530D/6vQQJt9RuZCs0NsLKASyTdcYQ+tVmYVdE5a6tfSWYcUZXAr
        U3We//i0eJVkdBVqWZY6kFvVlW+hSaRBhSlcQcuzYbctFEKE784c
X-Google-Smtp-Source: ABdhPJxcC9DyRIchfW4niQ93EOH5kce/Jim5k2cXQhjXSANqHmNW3swzT6W4WolSecFHZ2IBohgEvPQ9Ctr0bE43kxw=
X-Received: by 2002:a05:6830:225b:: with SMTP id t27mr5695127otd.73.1616038966210;
 Wed, 17 Mar 2021 20:42:46 -0700 (PDT)
MIME-Version: 1.0
From:   Waleed Khan <me@waleedkhan.name>
Date:   Wed, 17 Mar 2021 20:42:10 -0700
Message-ID: <CAKjfCeDdSRk5QwyYduvbQvz0zC9FCZ3+5bseeOmZBOULxZ0D7w@mail.gmail.com>
Subject: Bug: reference-transaction hook for branch deletions broken between
 Git v2.30 and Git v2.31
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

The `reference-transaction` hook seems to have broken between Git
v2.30 and v2.31, or at least violated my expectations as a user.

I didn't see any mention of the `reference-transaction` hook in the
release notes, so I assume that this is a bug. Given that there's
documentation at `man githooks` for the `reference-transaction` hook,
I assume that the feature is no longer in a preliminary stage, and so
a bug report is warranted. I couldn't find any mention of a
`reference-transaction` hook bug already having been reported in the
mailing list search online.

## Reproduction ##

To reproduce, run this script:

```
#!/bin/sh
set -eu

# Change between Git v2.30.0 and v2.31.0 here.
GIT=${GIT:-$(which git)}
echo "Running version $("$GIT" version)"

# For determinism.
export GIT_COMMITTER_DATE="Wed Mar 17 16:53:32 PDT 2021"
export GIT_AUTHOR_DATE="Wed Mar 17 16:53:32 PDT 2021"

rm -rf repo
mkdir repo
cd repo
"$GIT" init
"$GIT" commit --allow-empty -m 'Initial commit'

mkdir .git/hooks
cat >.git/hooks/reference-transaction <<'EOF'
#!/bin/sh
echo "reference-transaction ($1):"
cat
EOF
chmod +x .git/hooks/reference-transaction

"$GIT" branch -v 'test-branch'
echo "Created test-branch"
"$GIT" branch -v -d 'test-branch'
```

## Expected behavior (git v2.30) ##

This is the output:

```
[master (root-commit) 3b61ecc] Initial commit
reference-transaction (prepared):
0000000000000000000000000000000000000000
3b61ecc56006fcc283d42b302191e1385f19b551 refs/heads/test-branch
reference-transaction (committed):
0000000000000000000000000000000000000000
3b61ecc56006fcc283d42b302191e1385f19b551 refs/heads/test-branch
Created test-branch
reference-transaction (aborted):
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/test-branch
reference-transaction (prepared):
3b61ecc56006fcc283d42b302191e1385f19b551
0000000000000000000000000000000000000000 refs/heads/test-branch
reference-transaction (committed):
3b61ecc56006fcc283d42b302191e1385f19b551
0000000000000000000000000000000000000000 refs/heads/test-branch
Deleted branch test-branch (was 3b61ecc).
```

It's pretty strange that there was an "aborted" reference-transaction
from 0 to 0, especially with no previous "prepared"
reference-transaction, but that's not the bug in question, and I can
work around it by ignoring such transactions on my end.

Notice that as part of the branch deletion, there is a
reference-transaction from a non-zero commit hash to a zero commit
hash.

## Actual behavior (git v2.31) ##

```
[master (root-commit) 3b61ecc] Initial commit
reference-transaction (prepared):
0000000000000000000000000000000000000000
3b61ecc56006fcc283d42b302191e1385f19b551 refs/heads/test-branch
reference-transaction (committed):
0000000000000000000000000000000000000000
3b61ecc56006fcc283d42b302191e1385f19b551 refs/heads/test-branch
Created test-branch
reference-transaction (prepared):
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/test-branch
reference-transaction (committed):
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/test-branch
reference-transaction (aborted):
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/test-branch
reference-transaction (prepared):
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/test-branch
reference-transaction (committed):
0000000000000000000000000000000000000000
0000000000000000000000000000000000000000 refs/heads/test-branch
Deleted branch test-branch (was 3b61ecc).
```

My issues are 1) the reference-transaction deleting the branch goes
from a zero commit hash, instead of from the non-zero commit hash
3b61ec, and 2) there's two such "committed" transactions for some
reason. Like the other example, there's also a mysterious unpaired
aborted transaction, but I assume that's not new behavior in this
release.

## `git bugreport` system info ##

`git` 2.30 bugreport (built from source):

[System Info]
git version:
git version 2.30.2
cpu: x86_64
built from commit: 94f6e3e283f2adfc518b39cfc39291f1c2832ad0
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Thu Oct 29 22:56:45
PDT 2020; root:xnu-6153.141.2.2~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.21)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh

`git` 2.31 bugreport (built from source):

[System Info]
git version:
git version 2.31.0
cpu: x86_64
built from commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Thu Oct 29 22:56:45
PDT 2020; root:xnu-6153.141.2.2~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.21)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh

The issue also reproduces in CI builds of Git on Linux.
