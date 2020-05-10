Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE758C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 19:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85F120801
	for <git@archiver.kernel.org>; Sun, 10 May 2020 19:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjzmsWSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgEJT7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 15:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728071AbgEJT7X (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 15:59:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF245C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 12:59:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c21so1077785lfb.3
        for <git@vger.kernel.org>; Sun, 10 May 2020 12:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=P9W5WhnrYVSgeZJuPj9N+DOuYzqj0TDiPvkLXPWsP6I=;
        b=EjzmsWSdr8e/NN6876RuhQKZGjllUt7xvsnBGCRQwxSL/EWjU8oQfqiY7+q3fZULnR
         P95sikNsyHozhF8cgXPTXZz3kBVjw6uERpJdr80asl3H5YgUP3LjnwiGniWGIuKzzyYA
         +s5bUBzVVJV3TJcbRhztzkxHAh0og6UBS/FSJ38Zm+inqe/QOPou1bveazOENDsp81ar
         fFJ9qKEvJAgZIVX6/Fmg+TpN84bbnFlZIYOgofzx2Ju5cpyz8uiPldIpqa1uC8oeH6XR
         2sHeC23C0vUbOqo9brGk/SJOw+1vcd4IlSqdg94RwuamZaQchkneWAvkjm7BcDxMWoPX
         X2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=P9W5WhnrYVSgeZJuPj9N+DOuYzqj0TDiPvkLXPWsP6I=;
        b=MLGSo0reDUTk8tbV/05Q7c8w27/+8o1u4mEYyRcp7QxEaSHg+G0feyJupvDwh1pWe8
         598PA2ATAITPgwP+VSeBnpym5LupmzoDn6+eWPl2KvGUU9pZMpB7jniUaMuoK9NE/WPS
         N/NS8XZz4Mx2z1/hB1VFP/A38ClngWxHYvB8UeN7vUfE4/LEEiWLaurcs/pSm8IB3qyW
         4+2FxoxBIKI7us+6Cv/cpD8GeMiSVwpveNqcmvXW8/J6UbJRUDZYCCg/GwBaM/rUP+PT
         3x9S5ESC36DAB+e2ppJ7/IqGDM44AHtJYzohQT7v07/9H5nGjmTQj3UUB+UZWManAnQQ
         xiLw==
X-Gm-Message-State: AOAM530up5WwmtCFcPomxMziG/tZHuiqI25kBZJCgUUyAlbiuoZnZ0b1
        pqhJqM3bgbr9EI/461Da55vMgrtKmD9mV/32jEvr8mwsirY=
X-Google-Smtp-Source: ABdhPJztE3VQqmgtUVZQO46dFXO16oTMv9FimTWkCD4DoIY7KZ9wFsM5mt+8ShiTxaVBiLWIAubTiW7wqDxnEDp8DMI=
X-Received: by 2002:ac2:4c14:: with SMTP id t20mr8536530lfq.24.1589140759778;
 Sun, 10 May 2020 12:59:19 -0700 (PDT)
MIME-Version: 1.0
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Sun, 10 May 2020 15:59:08 -0400
Message-ID: <CALnO6CBiAy-Jf+q7Qr3rtV9wy3f7ySd0SgK1ckCZvz30ER3i6g@mail.gmail.com>
Subject: git check-ignore --verbose fails oddly when invoked via an alias
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I have some bizarre behavior I cannot explain. Worse, I've had a hard
time coming up with a minimal test-case for it.

I have the following two aliases:

    ig =3D check-ignore
    igv =3D !git ig --verbose

I use them to verify git-ignore rules occasionally. Today, I was
working on a project where git igv * kept failing (exit code 1,
indicating none of the provided files are ignored). However, when I do
git check-ignore --verbose *, I get the expected output.

You'll even see in the GIT_TRACE outputs above that one behaves very
differently from the other for unknown reasons

Debugging information:

$ pwd
/Users/Knoble/write/junk-drawer/code
$ g rev-parse --show-toplevel
/Users/Knoble/write/junk-drawer
$ tree -a sml-binary
sml-binary/
=E2=94=9C=E2=94=80=E2=94=80 .cm
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 GUID
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 myprog.sml
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 SKEL
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 myprog.sml
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 amd64-unix
=E2=94=82       =E2=94=94=E2=94=80=E2=94=80 myprog.sml
=E2=94=9C=E2=94=80=E2=94=80 .gitignore
=E2=94=9C=E2=94=80=E2=94=80 Makefile
=E2=94=9C=E2=94=80=E2=94=80 myprog
=E2=94=9C=E2=94=80=E2=94=80 myprog.amd64-darwin
=E2=94=9C=E2=94=80=E2=94=80 myprog.cm
=E2=94=9C=E2=94=80=E2=94=80 myprog.sml
=E2=94=94=E2=94=80=E2=94=80 tmp
    =E2=94=9C=E2=94=80=E2=94=80 bin
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 myprog
    =E2=94=94=E2=94=80=E2=94=80 lib
        =E2=94=94=E2=94=80=E2=94=80 myprog.amd64-darwin

7 directories, 11 files
$ cat sml-binary/.gitignore
myprog
myprog.amd64-darwin
$ g check-ignore sml-binary/*
sml-binary/myprog
sml-binary/myprog.amd64-darwin
$ g check-ignore --verbose sml-binary/*
code/sml-binary/.gitignore:1:myprog sml-binary/myprog
code/sml-binary/.gitignore:2:myprog.amd64-darwin sml-binary/myprog.amd64-da=
rwin
$ g ig sml-binary/*
sml-binary/myprog
sml-binary/myprog.amd64-darwin
$ g igv sml-binary/*
$ echo $?
1
$ pushd sml-binary/
~/write/junk-drawer/code/sml-binary ~/write/junk-drawer/code
~/write/junk-drawer/code/sml-binary
$ g ig *
myprog
myprog.amd64-darwin
$ g ig --verbose *
code/sml-binary/.gitignore:1:myprog myprog
code/sml-binary/.gitignore:2:myprog.amd64-darwin myprog.amd64-darwin
$ g igv *
$ echo $?
1
$ GIT_TRACE2=3D2 g igv *
15:48:21.773549 common-main.c:48                  version 2.26.2
15:48:21.773904 common-main.c:49                  start git igv
Makefile myprog myprog.amd64-darwin myprog.cm myprog.sml tmp
15:48:21.774443 git.c:697                         cmd_name
_run_dashed_ (_run_dashed_)
15:48:21.774473 run-command.c:735                 child_start[0]
git-igv Makefile myprog myprog.amd64-darwin myprog.cm myprog.sml tmp
15:48:21.774735 run-command.c:950                 child_exit[0] pid:-1
code:-1 elapsed:0.000249
15:48:21.775368 repository.c:130                  worktree
/Users/Knoble/write/junk-drawer
15:48:21.775427 git.c:352                         alias igv -> 'git ig
--verbose' Makefile myprog myprog.amd64-darwin myprog.cm myprog.sml
tmp
15:48:21.775439 git.c:354                         cmd_name
_run_shell_alias_ (_run_dashed_/_run_shell_alias_)
15:48:21.775445 run-command.c:735                 child_start[1] 'git
ig --verbose' Makefile myprog myprog.amd64-darwin myprog.cm myprog.sml
tmp
15:48:21.786123 common-main.c:48                  version 2.26.2
15:48:21.786579 common-main.c:49                  start git ig
--verbose Makefile myprog myprog.amd64-darwin myprog.cm myprog.sml tmp
15:48:21.787201 git.c:697                         cmd_name
_run_dashed_ (_run_dashed_/_run_shell_alias_/_run_dashed_)
15:48:21.787243 run-command.c:735                 child_start[0]
git-ig --verbose Makefile myprog myprog.amd64-darwin myprog.cm
myprog.sml tmp
15:48:21.787464 run-command.c:950                 child_exit[0] pid:-1
code:-1 elapsed:0.000216
15:48:21.787781 git.c:389                         alias ig ->
check-ignore --verbose Makefile myprog myprog.amd64-darwin myprog.cm
myprog.sml tmp
15:48:21.787794 git.c:753                         cmd_name
_run_git_alias_
(_run_dashed_/_run_shell_alias_/_run_dashed_/_run_git_alias_)
15:48:21.787801 run-command.c:735                 child_start[1] git
check-ignore --verbose Makefile myprog myprog.amd64-darwin myprog.cm
myprog.sml tmp
15:48:21.793959 common-main.c:48                  version 2.26.2
15:48:21.794206 common-main.c:49                  start
/usr/local/Cellar/git/2.26.2/libexec/git-core/git check-ignore
--verbose Makefile myprog myprog.amd64-darwin myprog.cm myprog.sml tmp
15:48:21.794427 repository.c:130                  worktree
/Users/Knoble/write/junk-drawer
15:48:21.794671 git.c:440                         cmd_name
check-ignore (_run_dashed_/_run_shell_alias_/_run_dashed_/_run_git_alias_/c=
heck-ignore)
15:48:21.795513 git.c:674                         exit elapsed:0.003100 cod=
e:1
15:48:21.795529 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.003121 c=
ode:1
15:48:21.795935 run-command.c:990                 child_exit[1]
pid:98684 code:1 elapsed:0.008108
15:48:21.795971 git.c:773                         exit elapsed:0.012124 cod=
e:1
15:48:21.795995 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.012139 c=
ode:1
15:48:21.796351 run-command.c:990                 child_exit[1]
pid:98683 code:1 elapsed:0.020896
15:48:21.796391 git.c:358                         exit elapsed:0.024746 cod=
e:1
15:48:21.796416 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.024761 c=
ode:1
$ GIT_TRACE2=3D2 g ig --verbose *
15:57:42.274337 common-main.c:48                  version 2.26.2
15:57:42.274640 common-main.c:49                  start git ig
--verbose Makefile myprog myprog.amd64-darwin myprog.cm myprog.sml tmp
15:57:42.275146 git.c:697                         cmd_name
_run_dashed_ (_run_dashed_)
15:57:42.275167 run-command.c:735                 child_start[0]
git-ig --verbose Makefile myprog myprog.amd64-darwin myprog.cm
myprog.sml tmp
15:57:42.275422 run-command.c:950                 child_exit[0] pid:-1
code:-1 elapsed:0.000246
15:57:42.275763 git.c:389                         alias ig ->
check-ignore --verbose Makefile myprog myprog.amd64-darwin myprog.cm
myprog.sml tmp
15:57:42.275781 git.c:753                         cmd_name
_run_git_alias_ (_run_dashed_/_run_git_alias_)
15:57:42.275794 run-command.c:735                 child_start[1] git
check-ignore --verbose Makefile myprog myprog.amd64-darwin myprog.cm
myprog.sml tmp
15:57:42.282613 common-main.c:48                  version 2.26.2
15:57:42.282876 common-main.c:49                  start
/usr/local/Cellar/git/2.26.2/libexec/git-core/git check-ignore
--verbose Makefile myprog myprog.amd64-darwin myprog.cm myprog.sml tmp
15:57:42.283146 repository.c:130                  worktree
/Users/Knoble/write/junk-drawer
15:57:42.283520 git.c:440                         cmd_name
check-ignore (_run_dashed_/_run_git_alias_/check-ignore)
code/sml-binary/.gitignore:1:myprog     myprog
code/sml-binary/.gitignore:2:myprog.amd64-darwin        myprog.amd64-darwin
15:57:42.284561 git.c:674                         exit elapsed:0.003839 cod=
e:0
15:57:42.284588 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.003876 c=
ode:0
15:57:42.285171 run-command.c:990                 child_exit[1]
pid:99078 code:0 elapsed:0.009354
15:57:42.285212 git.c:773                         exit elapsed:0.012930 cod=
e:0
15:57:42.285246 trace2/tr2_tgt_normal.c:123       atexit elapsed:0.012950 c=
ode:0

Failed attempt to produce a minimal example:

$ g init
D=C3=A9p=C3=B4t Git vide initialis=C3=A9 dans /private/tmp/git-test/.git/
$ mkdir subdir
$ touch subdir/{a..c}
$ ls
subdir/
$ tree
.
=E2=94=94=E2=94=80=E2=94=80 subdir
    =E2=94=9C=E2=94=80=E2=94=80 a
    =E2=94=9C=E2=94=80=E2=94=80 b
    =E2=94=94=E2=94=80=E2=94=80 c

1 directory, 3 files
$ echo a >> subdir/.gitignore
$ g status -s
?? subdir/
$ g add --intend-to-add .
$ g status -s
 A subdir/.gitignore
 A subdir/b
 A subdir/c
$ g commit --all -m 'init'
[master (commit racine) 832876e] init
 3 files changed, 1 insertion(+)
 create mode 100644 subdir/.gitignore
 create mode 100644 subdir/b
 create mode 100644 subdir/c
$ g igv *
$ echo $?
1
# ^^^ expected, nothing ignored
$ g igv subdir/*
subdir/.gitignore:1:a   subdir/a
# ^^^ also expected???

D. Ben Knoble
