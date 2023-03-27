Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB7CC77B60
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 07:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjC0HuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjC0Ht7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 03:49:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF8E102
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679903394; i=johannes.schindelin@gmx.de;
        bh=XhnuSfOmIc4dnxvDRwkVxz0r7POs1ilQp9Lj9wezcIo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=rsbX/8fGpIxPu7WxCrU0plxr7/lekns/DOezuGod0lV6WrsQp2wn3mvRNwk6GxpCA
         VJQlBTQPJCvag0uHpT805rAPNY01WO4pDBuMoDoHeUQ8LVIA79bXdHQkG5+5uYi9vS
         jDEITCrWa6vRW78rJ9v3yA/fxq5H2bJ1THY+YnJcStSviW6rjLYNL+IcRXPwSf1KZ8
         FBrwDIDS9etExKplQDmNlgGFJPunEk3hs+zPRQLWuBFCeUHfK+HCQw2heSPZnXl3Ry
         MVWRAUu5Txlx+HEL3fpBQfNxh4ID5zuvKekA15kxLKEoMCfoL5N+gDnx0tA7aSBk1z
         jDjpf62yLq1mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfYw-1pa81y2If2-00B7Cj; Mon, 27
 Mar 2023 09:49:54 +0200
Date:   Mon, 27 Mar 2023 09:49:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Josh Smeaton <josh.smeaton@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Bug: diff-index reports unrelated files as deleted when fsmonitor
 is enabled
In-Reply-To: <CAPbDM0d5Xe=KTLECDCJYtpzmBt2wqzZrMWVcbiisM+abopenig@mail.gmail.com>
Message-ID: <8afb1988-df49-d759-ead8-1bd384f09c82@gmx.de>
References: <CAPbDM0d5Xe=KTLECDCJYtpzmBt2wqzZrMWVcbiisM+abopenig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kxFR7rSQrQkyGYVF84AaYn+eGShNWvSLf6w4ianAzYjsaIxUo+S
 OeQsBurQLxJ5iDveWNp4v4Lp1tfqqnnAyJobWlpb074kTYYujguC0V8X4ouD/5w+N1/i9nD
 uC0iNV/uA++eIRdVCq4kzHyIoBugLWW2u4GyszWuz27I7ehG1Vv11jeqOlhXfMOdIIlZVwV
 l3viKxBLSfUmUeuWIYFmA==
UI-OutboundReport: notjunk:1;M01:P0:/9E/miK7Z/o=;fWgyVm7uBtZ703/HFWor6Gi+sYB
 Mj7nomGOjbX+wTL7iYLgsHiaRbQ3ns5O/dE51hT6Bh/ssA8/4sxl1j9ufmNbBIN1bjqo5IkQa
 FrR4ujFc5da4VpZXvGQLlCqPCveEUGd73384WQTqDhhbuydC6xlbnAdT76Qxcw2+3B+4zxDhW
 l2zQjZD/BMwbjR8XuaK2IG2z/iboEiRkLVV/Rks+Q1hthZwnkzx7xO7WIL+qmCo8tcfimu68h
 qsh+FjDtVU/TnWMg+Ni2y17HRNfCUJMGJs+CfHXIoOblPDBLADnUBVeMMyl6X6oEXRjyJ158W
 u1LK+EjhW64RWyyUxUYworT9rOKQpTvCcAmep1pEnuEFfBxt9JVzPF0Qs0ORwkxhX5X4fgSsS
 SKNwl8MdRWA/r+kIxHrLgMHz+EWaEcuOLiWfXuyLJefoTPeDd9UQERSGnH4+rmtF2DF0ZeazV
 sJpblJElJauzc6ih3hD/IadAiMxArKLqVpRW1Yb3ia3EFdlNBPx2OuqTJQecGcui+HDUo4FLk
 0+cBdKB8+lLjUSSImUvaRMVtBKhFBiekKJYNilYbVYA3E3HJMpE1bVis0dD7lim4GuH+COrVx
 V+7CM1SPtrWw/LQ+pgjyvuHQBbBDVO0Yirfd1d48atIJwiS/9m0Pv2t/qvd4BR98SLXagkwd2
 +XG5fuUKgP87kPm4tnez3tRk8p7fEkEpj5TAflTqgqpDmP7V36fqG4hID+rH1vsJ0/clGA64A
 LGydp/oClXOUhvs4j/hbFnbCsE825n/JRSlVcvMwjTTR+s5hVXJx7lNk5KyGsQY4PtRLU/9v+
 ti9+kRfuq0FEYv0/+IluDFHT8pkfSslRNfkSPZSDCutlfbh9r/yPntD2mbJ2UE9dCP164k90v
 qgSgOvQ466i0uCnqriF/af8gz5f6ZaszJTDEMa/8hyelWV7e+nKTd0m4WVBsqjKzICY0/dNqV
 2BPFES3rig1GI+Y4DTeIHtiHmvY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josh,

On Sat, 4 Mar 2023, Josh Smeaton wrote:

> git write-tree and then git diff-index reports thousands of files as
> `deleted` when core.fsmonitor is true, even though the files are still
> present on the file system.

I suspect that the issue is a missing `git update-index --refresh`. While
`git diff` refreshes the index automatically, `git diff-index` does not
(when you use low-level commands like `diff-index` you need to do such
things explicitly).

If that does not fix your problem, I encourage you to distill the issue
into a simple MCVE (https://stackoverflow.com/help/mcve), preferably in
the form of a patch, say, to t7527 (see
https://github.com/git/git/blob/v2.40.0/t/t7527-builtin-fsmonitor.sh).

Ciao,
Johannes

>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> ```
> git config core.fsmonitor true
> touch new-file.txt
> git add new-file.txt
> git diff-index --ignore-submodules --exit-code --no-color
> --no-ext-diff $(git write-tree) --
> ```
>
> What did you expect to happen? (Expected behavior)
>
> I expected that no files would be reported as having changes.
>
> What happened instead? (Actual behavior)
>
> Thousands of unrelated files were reported as `deleted`.
>
> ```
> git diff-index --ignore-submodules --exit-code --no-color
> --no-ext-diff $(git write-tree) --
> :100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> 0000000000000000000000000000000000000000 D src/tests/__init__.py
> :100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> 0000000000000000000000000000000000000000 D src/tests/site/__init__.py
> :100644 000000 d8edaad92120781998e811277f966551b12fc823
> 0000000000000000000000000000000000000000 D
> src/tests/site/test_models.py
>
>  ... thousands of other files
> ```
>
> What's different between what you expected and what actually happened?
>
> Thousands of unrelated files were reported as having been deleted.
>
>
> Anything else you want to add:
>
> Myself and a few co-workers all ran into this issue in the last few days=
. It
> presented itself when pre-commit hooks were run (specifically with the
> pre-commit
> tool from github pre-commit).
>
> When committing changes, the pre-commit tool runs the equivalent of:
>
> `git diff-index --ignore-submodules --exit-code --no-color
> --no-ext-diff $(git write-tree) --`
>
> It then stashes and unstashes those changes, causing the files to be
> removed from
> the working tree.
>
>
> ```
> $ git config core.fsmonitor true
> $ git checkout -b test-branch
> Switched to a new branch 'test-branch'
>
> $ echo "test 3" >> newfile.txt
> $ git add .
> $ git status
> On branch test-branch
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
> new file:   newfile.txt
>
> $ git commit -a -m "will it fail?"
> [WARNING] Unstaged files detected.
> [INFO] Stashing unstaged files to
> /Users/josh/.cache/pre-commit/patch1677888420-10129.
> trim trailing whitespace................................................=
.Passed
> check python ast.....................................(no files to check)=
Skipped
> check for case conflicts................................................=
.Passed
> [INFO] Restored changes from
> /Users/josh/.cache/pre-commit/patch1677888420-10129.
> [test-branch 7c899582c19] will it fail?
>  1 file changed, 1 insertion(+)
>  create mode 100644 newfile.txt
>
> $ git status
> On branch test-branch
> Changes not staged for commit:
>   (use "git add/rm <file>..." to update what will be committed)
>   (use "git restore <file>..." to discard changes in working directory)
> deleted:    src/tests/__init__.py
> deleted:    src/tests/site/__init__.py
> deleted:    src/tests/site/test_models.py
>         ... lots more files ...
>
> no changes added to commit (use "git add" and/or "git commit -a")
>
> $ git status | wc -l
>    15298
>
> $ git restore .
>
> $ git status
>
> On branch test-branch
> nothing to commit, working tree clean
> ```
>
> It can be reproduced, in our repo, without using pre-commit at all:
>
> ```
>
> git diff-index --ignore-submodules --exit-code --no-color
> --no-ext-diff $(git write-tree) --
> :100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> 0000000000000000000000000000000000000000 D src/tests/__init__.py
> :100644 000000 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> 0000000000000000000000000000000000000000 D src/tests/site/__init__.py
> :100644 000000 d8edaad92120781998e811277f966551b12fc823
> 0000000000000000000000000000000000000000 D
> src/tests/site/test_models.py
>
>  ... thousands of other files
> ```
>
> Using `update-index` with the `--no-fsmonitor` flag prior to diff-index =
does the
> correct thing:
>
> ```
> $ git update-index --really-refresh --no-fsmonitor
> warning: core.fsmonitor is set; remove it if you really want to
> disable fsmonitor
>
> $ git diff-index --ignore-submodules --exit-code --no-color
> --no-ext-diff $(git write-tree) --
> > no output
> ```
>
> The problem persists when running `update-index` without disabling fsmon=
itor.
>
> I have reported this issue to the pre-commit project, but it looks like =
an issue
> with fsmonitor + write-tree.
>
> See: pre-commit issues on github #2795
>
>
>
> [System Info]
> git version:
> git version 2.39.2 (others reproduced with 2.39.1)
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 22.3.0 Darwin Kernel Version 22.3.0: Mon Jan 30 20:38:37
> PST 2023; root:xnu-8792.81.3~2/RELEASE_ARM64_T6000 arm64
> compiler info: clang: 14.0.0 (clang-1400.0.29.202)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
> pre-commit
>
