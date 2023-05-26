Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1EBC77B7A
	for <git@archiver.kernel.org>; Fri, 26 May 2023 08:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbjEZI2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 May 2023 04:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjEZI2u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2023 04:28:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2283B12F
        for <git@vger.kernel.org>; Fri, 26 May 2023 01:28:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3a611b3ddso2295250e87.0
        for <git@vger.kernel.org>; Fri, 26 May 2023 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google; t=1685089723; x=1687681723;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TrES/oDZBGl/LZRpU/vpWAyBQI6Z3AElCxvgm41gUM4=;
        b=dsNmLssnKbvQeap1e1RZQlwWcp+3/HjdPjzAMub/wva+8jbJTGs4QkpF6hQG8/Ddlj
         aCnRoYtakjhkGjHNI5E8dV3peEYU2uYTaikqnIh+oYWJWiCiKpUDR/ESO5mCaISZZz+C
         kN5xlrFbK88sgQTfH2Z2ji/u3+ATaVe8Y+fFnDqCLDD9pdsGbbMa4j0Zrt6wC6b+a8a/
         Xr4yRU36hzf3kjOcwyW1/h9+0GR+zV2/PXcxGiSy56n/CpgnmMtctwWyf2IC387ZXbFn
         0vflPr3WuX6XWcNQMRTh2hHOS3KAokq9COQwBCcR1Z+VZGlXC4evAnfkGTv8T4WrdoiU
         0HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685089723; x=1687681723;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrES/oDZBGl/LZRpU/vpWAyBQI6Z3AElCxvgm41gUM4=;
        b=E954eY0Dh7/3O0jzUx0StmzPz/JlUSw8SXAAm9ukwftplwbuJ/97HYXVtd4I5yejqb
         dbYqjXGA2jkrlCs4OAw6CFp6RH3awV17GBV+g70ZkxAXT3bbuBmps9UaxWUHS+4AEh7I
         Em7r0S82UrlJN5xJIvWYHUH8oMoNZZtNvFsMBPzJc4+O4AgWGcUUzT6rcpenhK0DbZTp
         rIZhOplgbojFOIUqcRPkK06tSKkuqHMacT0JaPg9u8z7mX0Yz9ShtA1VQExasNVLvZmM
         Obe3/YeHbaGMyWd4dG+iqkoPdNNQJRRgndr2wQdJtC3kWGuDrTGwycuk7NmhVVIji3zi
         pdFA==
X-Gm-Message-State: AC+VfDxBmpXgXMYvWEBFgJ/tcL0up8o5ts1iOd8lcgz4kX07S68HE74f
        R8fvI3xU6rMIRbFhuoy1NG14YU3Ni7w/750u6V29hyZZZ8ATN8RsGgFBbQ==
X-Google-Smtp-Source: ACHHUZ7fXPuYr1thqK+UoskpYLkSYF1nYbpaMUJDDodTVNxzrUK6pNVdXOO14FvjyyVy4ZfymppR0evLsXSdqZRxwfw=
X-Received: by 2002:a05:6512:3e16:b0:4f2:47ea:2f32 with SMTP id
 i22-20020a0565123e1600b004f247ea2f32mr1727441lfv.23.1685089722906; Fri, 26
 May 2023 01:28:42 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Krag <jan.krag@eficode.com>
Date:   Fri, 26 May 2023 10:28:26 +0200
Message-ID: <CAF0TW5uB0zbSqw7rUFxED77683h7qHoqeBD6dnSOCpajGV=tYw@mail.gmail.com>
Subject: Bug: global remote.origin.url silently overrides git clone <URL>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have stumbled across some very unexpected behaviour in git related
to remote.origin.url. I initially reported it to the security mailing
list because of concern of possible exploits, but Glenn Choo and
Taylor Blau deemed that the issue was outside Git's security boundary,
and thus safe to discuss on the public list.

In short, I found out that if a user for some reason, either
intentionally/maliciously or unintentionally sets `remote.origin.url`
to a repo URL in their *global* config, then a subsequent `git
clone`operation will *silently* use this URL instead of the one
provided as the command line argument to `git clone`.

I believe this is unintentional behaviour, and not just a corner case
I haven=E2=80=99t thought of, because of the following observations:

* The folder name to clone to is still taken from the command-line specifie=
d URL
* Git still prints =E2=80=9Ccloning into=E2=80=A6=E2=80=9D and the folder n=
ame that the user specified
* Git sets sets the *local* `remote.origin.url` to the value provided
* However, Git fetches the actual repo content, and subsequent
workspace checkout, from the URL in the global config, without any
notification to the user.

Security implications: I believe that this behaviour could
theoretically be mis-used for supply-chain attacks, especially on a
build server, but Glenn and Taylor pointed out that if an attacker has
access to modify a global git config, then there are much worse things
they could do. Also, I realise that most build servers these days
don=E2=80=99t actually use `git clone` under normal operations (rather they
use git init, git remote add, git fetch) so the problem isn't that
severe.

If a team disables the regular build server fake cloning behaviour and
does actual cloning in e.g. a shell step for more control, an attacker
with access to pipelines running on the same build node, could
potentially set the global url to a malicious fork of a repo used in
other pipelines, and silently make the other pipelines clone this
forked and patched repo, and potentially execute code within.


What did you do before the bug happened? (Steps to reproduce your issue)
What happened instead? (Actual behaviour)
------------------------------------------------------------------

I discovered the problem in the wild, reproduced it on my Mac (see
later) and then went through the following controlled reproduction in
a Docker environment.

`docker run -it --entrypoint /bin/bash bitnami/git:2.19.2`

```
$ git config --global remote.origin.url https://github.com/JKrag/sc_demo.gi=
t
$ git clone https://github.com/eficode-academy/git-katas.git

Cloning into 'git-katas'...

$ cd git-katas
$ ls
README.md (i.e. content from sc_demo, not git-katas)

$ git remote show origin
* remote origin
Fetch URL: https://github.com/JKrag/sc_demo.git
Push URL: https://github.com/JKrag/sc_demo.git
Push URL: https://github.com/eficode-academy/git-katas.git

$ cat .git/config
...
[remote "origin"]
url =3D https://github.com/eficode-academy/git-katas.git
...


$ git config --list --show-origin |grep "remote\.origin"
file:/root/.gitconfig remote.origin.url=3Dhttps://github.com/JKrag/sc_demo.=
git
file:.git/config
remote.origin.url=3Dhttps://github.com/eficode-academy/git-katas.git
file:.git/config remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*


$ git fetch
$ git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean

$ git config --global --unset remote.origin.url
$ git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean

$ git fetch
remote: Enumerating objects: 2443, done.
remote: Counting objects: 100% (1109/1109), done.
remote: Compressing objects: 100% (465/465), done.
remote: Total 2443 (delta 699), reused 674 (delta 642), pack-reused 1334
Receiving objects: 100% (2443/2443), 2.46 MiB | 6.29 MiB/s, done.
Resolving deltas: 100% (1052/1052), done.
From https://github.com/eficode-academy/git-katas
+ 398b171...8bc6cc8 master -> origin/master (forced update)
* [new branch] brent-clark-SED-Sw-Mgr/improve-overview ->
origin/brent-clark-SED-Sw-Mgr/improve-overview
* [new branch] improve-rebase-powershell -> origin/improve-rebase-powershel=
l
* [new branch] pr-verify -> origin/pr-verify
* [new branch] reorder-instructions-unclear ->
origin/reorder-instructions-unclear
* [new branch] sofusalbertsen-patch-1 -> origin/sofusalbertsen-patch-1
* [new branch] sofusalbertsen-patch-2 -> origin/sofusalbertsen-patch-2
* [new branch] test-script -> origin/test-script
* [new branch] tree-vis -> origin/tree-vis
* [new branch] uppercase -> origin/uppercase
* [new tag] 0.1.1 -> 0.1.1
* [new tag] 0.2.0 -> 0.2.0
* [new tag] 0.3.0 -> 0.3.0

$ git rev-list --max-parents=3D0 --all
398b17173d150371977cc12d4406f927a4be32ea # Initial commit from sc-demo repo
ad31d12363a181b998317d5f075d89b3fb990122 # Initial commit from git-katas re=
po

```


What did you expect to happen? (Expected behaviour)

First off, I would expect that Git used the url specified on the
command line, as it is normal that command-line arguments override
both local and global configs.
Alternatively, if there really is a good reason to use the global
configured one, git should at least take the folder name from there
and print out =E2=80=9CCloning into [global configured repo name]=E2=80=9D

In reality, I can=E2=80=99t see any reason why there would ever be a need t=
o
configure global remote.origin.url, and ideally doing so could lead to
an error/warning message, but I also know that the philosophy behind
Git config is to basically allow any settings, and there is no natural
place to =E2=80=9Cstop=E2=80=9D such entries, although I guess it might be =
reasonable
to expect a warning at least when cloning a new repo.

Anything else you want to add:
--------------------------------------------
Yes, I am aware that this is a very obscure scenario, and as an
experienced Git user, it had never crossed my mind that this could
happen, but I saw it =E2=80=9Cin the wild=E2=80=9D a few weeks ago, when de=
livering a
2-day Git training. I asked the participants to clone our =E2=80=9Cgit-kata=
s=E2=80=9D
repo (as in the reproduced scenario above), and then one participant
was VERY confused because the folder then had =E2=80=9Cher own code=E2=80=
=9D, and she
couldn=E2=80=99t understand why. After going through her bash history and
verifying that there was no other good explanation, I finally found
the explanation by looking in the global config where I found the
unexpected setting. The user had no real idea how it had gotten there,
except some vague idea of having tried =E2=80=9Csome stuff=E2=80=9D to fix =
=E2=80=9Csome
issue=E2=80=9D a long time ago. Since she only used a single repo on her
computer, she would never really have noticed under normal conditions.

Platform:
----------------
Problem originally seen =E2=80=9Cin the wild=E2=80=9D on an Ubuntu laptop r=
unning Git
2.17 as I recall.
Issue reproduced on OSX Git 2.39.2, and in docker containers running
2.19.2 and 2.40.

[ Local Mac ]
[System Info]
git version:
git version 2.39.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.4.0 Darwin Kernel Version 22.4.0: Mon Mar 6 21:00:17
PST 2023; root:xnu-8796.101.5~3/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh

[ Bitnami/git:2:40 ]
$ docker run -it --entrypoint /bin/bash bitnami/git:2.40.0
root@89543b59ce2c:/# git version --build-options
git version 2.40.0
cpu: x86_64
$SHELL =3D /bin/bash

[ Bitnami/git:2.19.2 ]
$ docker run -it --entrypoint /bin/bash bitnami/git:2.19.2
root@6a86a5c92e58:/# git version --build-options
git version 2.19.2
cpu: x86_64
$SHELL =3D /bin/bash
$ uname -a
Linux 6a86a5c92e58 5.15.49-linuxkit #1 SMP Tue Sep 13 07:51:46 UTC
2022 x86_64 GNU/Linux


Regards Jan

-----------------------
Jan Krag
Git Trainer & DevOps Consultant
jan.krag@eficode.com
www.eficode.com
Copenhagen, Denmark
