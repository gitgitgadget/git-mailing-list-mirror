Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1EE81FAE3
	for <e@80x24.org>; Thu, 15 Mar 2018 16:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeCOQkm (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 12:40:42 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:45359 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeCOQkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 12:40:41 -0400
Received: by mail-qk0-f174.google.com with SMTP id s9so7959809qke.12
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kBz+bRYmVm3s4skJF1ijqN3qiD/DT2OFPp0SxkBLj0s=;
        b=EuQ2CuBUsrOpPTTc2ytLFSyLKTwsbiDD6crWIw8jRwID+LzCdbdf8DmEIm5Jg3ZAut
         goCVapxZRDerqKwYb82AnwCwXlcLvKT3cSgFcmBJ35QSDoaxuPJNudx1aM0JujAwJMIP
         SAWIDNtWop21BvTrOQuuudtNPK/MoTuGYeRsGfWklHCgPcSFdRpxN/MJXdUMzxULQ0rQ
         gVNiRR2bfelrjCkFE9eCoh2jP3n+ono2YPlUSbrfW98IEIRuqQHC6cVFy3qtNoiVitMo
         IX6ThsBoittlPnjmzOmlZFpfvNeZmGL2TmCfDgxOekTc4FlyE9d8rBYHN52R4cc4XS95
         fEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kBz+bRYmVm3s4skJF1ijqN3qiD/DT2OFPp0SxkBLj0s=;
        b=lnhK+YB48xtp3hDwhhXAHh/sPe0x7fUP9kspga4MPq9ILmGytGPiV3X24iKWZ1wKHo
         zIYXKl8oduNYN58ZkJrwf6S2x+d9vfJZgoCdqpalT4xQJF74dLf4eqNCCb8KoHzzRGjT
         RzkrW9CYvrkB0gtEc84fnfI/zCOYYqaR3J0n7WqekcZM/ZWEjgJqvbEoT/y3U1GOHbGy
         WsmhfJhQ3NVhePHjakNUs107DjxrfGhbTbop/yx/wPWcynCikpM45tTH6XfO2vRNwiW1
         wKVktEQ03yFiwtfs5FdeZ5pa/b2NqF/pLIoORZHMAVGtPvcV7u7t5JRCValbE6amLhTy
         twCg==
X-Gm-Message-State: AElRT7H8iFqvzn99II1lBpFMJ/nzCkyr8vLd4FSXUSTDWWeP0hwdg8ru
        p5mSdV/gpmciBlwoE92uVtFYP2AI7Be/NNPUPqzuYQ==
X-Google-Smtp-Source: AG47ELuygBhcdyVIfExRQdnC7+XmrXrr9r3HfDhdnhy8MqznWUZhrXBheycAOj7CicEgmCsg+WELWfQeaUTNTW7N7ew=
X-Received: by 10.55.57.135 with SMTP id g129mr13414585qka.212.1521132039227;
 Thu, 15 Mar 2018 09:40:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.44.46 with HTTP; Thu, 15 Mar 2018 09:40:38 -0700 (PDT)
From:   Jake Stine <jake.stine@gmail.com>
Date:   Thu, 15 Mar 2018 09:40:38 -0700
Message-ID: <CABWk7R9xNDHJbbsMZbOyhcYXq-bD6Krvbw_mKDBJFALALS3AHA@mail.gmail.com>
Subject: [bug] git stash push {dir-pathspec} wipes untracked files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I ran into what I believe is a bug today.  I=E2=80=99m using primarily =
Git
for Windows 2.16.2 and also reproduced the behavior on Git for Windows
2.15.1 and Git 2.14.1 on Ubuntu:

Given any repository with at least one subdirectory:

1.       Create some untracked files in the subdir
2.       Modify a tracked file in the subdir
3.       Execute `git stash push subdir`
4.       The untracked files will be removed, without warning.

`git stash push` behaves as-expcted and does not touch untracked
files.  It=E2=80=99s only when a directory tree is specified as [pathspec]
that the problem occurs.

Here's the precise reproduction case executed on a linux box:

jake@jake-VirtualBox:~/woot$ git --version
git version 2.14.1
jake@jake-VirtualBox:~/woot$ git config --global user.email jake.stine@gmai=
l.com
jake@jake-VirtualBox:~/woot$ git config --global user.name "Jake Stine"
jake@jake-VirtualBox:~$ git init woot
Initialized empty Git repository in /home/jake/woot/.git/
jake@jake-VirtualBox:~$ cd woot
jake@jake-VirtualBox:~/woot$ mkdir subdir
jake@jake-VirtualBox:~/woot$ echo "test" > meh.txt
jake@jake-VirtualBox:~/woot$ echo "test" > subdir/meh2.txt
jake@jake-VirtualBox:~/woot$ git add meh.txt subdir/meh2.txt
jake@jake-VirtualBox:~/woot$ git commit --message=3D"stash bug testing"
jake@jake-VirtualBox:~/woot$ git commit --message=3D"stash bug testing"
[master (root-commit) 2c05580] stash bug testing
 2 files changed, 2 insertions(+)
 create mode 100644 meh.txt
 create mode 100644 subdir/meh2.txt
jake@jake-VirtualBox:~/woot$ echo "test" > subdir/untracked.txt
jake@jake-VirtualBox:~/woot$ echo "append" >> subdir/meh2.txt
jake@jake-VirtualBox:~/woot$ git stash push subdir
Saved working directory and index state WIP on master: 2c05580 stash bug te=
sting
jake@jake-VirtualBox:~/woot$ ls subdir
meh2.txt


The expected result is that when I do `ls subdir` the file
"untracked.txt" still exists.  Alternatively, git stash should warn me
before destroying my untracked files, and require I specify --force or
similar to invoke destructive behavior.


Thanks!
Jake Stine
