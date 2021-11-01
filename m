Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E41C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 23:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BA060F5A
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 23:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhKAX2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 19:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhKAX2j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 19:28:39 -0400
X-Greylist: delayed 508 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 Nov 2021 16:26:04 PDT
Received: from out3.mail.ruhr-uni-bochum.de (out3.mail.ruhr-uni-bochum.de [IPv6:2a05:3e00:8:1001::8693:359b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B28C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 16:26:03 -0700 (PDT)
Received: from mx3.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
        by out3.mail.ruhr-uni-bochum.de (Postfix mo-ext) with ESMTP id 4Hjppf6qgRz8SSh;
        Tue,  2 Nov 2021 00:17:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ruhr-uni-bochum.de;
        s=mail-2017; t=1635808651;
        bh=L6htD2EtZoDnom4WPH6MO1vHVoS+UI6IV0c8NhuMgMA=;
        h=From:To:Subject:Date:From;
        b=tV7IaW8tuywg4AkqeLN1f4mFKmjq/lANx2bfMuFlPAxrBNW6hbNH5LW1YsKATLLyh
         NKmT+ywNOjoIGrRWJJkudB7euJ6bgPI5RP45316X2SliZadwarK7zdvXl6bopmeKTr
         QRZMBZTBs5D8Vux085BM5o1C+AOZ7ZzcEl/GHevU=
Received: from out3.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
        by mx3.mail.ruhr-uni-bochum.de (Postfix idis) with ESMTP id 4Hjppf6Cbyz8SSM;
        Tue,  2 Nov 2021 00:17:30 +0100 (CET)
X-Envelope-Sender: <jonas.kittner@ruhr-uni-bochum.de>
X-RUB-Notes: Internal origin=134.147.42.236
Received: from mail2.mail.ruhr-uni-bochum.de (mail2.mail.ruhr-uni-bochum.de [134.147.42.236])
        by out3.mail.ruhr-uni-bochum.de (Postfix mi-int) with ESMTP id 4Hjppf4Z04z8SRK;
        Tue,  2 Nov 2021 00:17:30 +0100 (CET)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.1 at mx3.mail.ruhr-uni-bochum.de
Received: from DESKTOPQLLGRNK (dslb-088-070-035-227.088.070.pools.vodafone-ip.de [88.70.35.227])
        by mail2.mail.ruhr-uni-bochum.de (Postfix) with ESMTPSA id 4Hjppf29pRzDgys;
        Tue,  2 Nov 2021 00:17:30 +0100 (CET)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.0 at mail2.mail.ruhr-uni-bochum.de
From:   "Jonas Kittner" <jonas.kittner@ruhr-uni-bochum.de>
To:     <git@vger.kernel.org>
Subject: `BUG: sequencer.c:921: GIT_AUTHOR_DATE missing from author script` when trying to reword in interactive rebase
Date:   Tue, 2 Nov 2021 00:17:29 +0100
Message-ID: <000201d7cf76$a4861460$ed923d20$@ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdfPdgtz1cFYD/vCSbC8rVP0e41wcA==
Content-Language: de
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I encountered the following bug and filled out the template provided with
`git bugreport` below.
Kind Regards,
Jonas Kittner

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

In the interactive prompt I changed `pick` to `reword`, saved and closed the
prompt.
Commands to repoduce see below

```
root@135b2edea980:/# git init bug
Initialized empty Git repository in /bug/.git/
root@135b2edea980:/# cd bug/
root@135b2edea980:/bug# touch foo
root@135b2edea980:/bug# git add .
root@135b2edea980:/bug# git commit -m "foo"
[master (root-commit) 8fef261] foo
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo
root@135b2edea980:/bug# touch bar
root@135b2edea980:/bug# git add .
root@135b2edea980:/bug# git commit -m "bar"
[master 79a46e6] bar
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 bar
root@135b2edea980:/bug# git log --oneline
79a46e6 (HEAD -> master) bar
8fef261 foo
root@135b2edea980:/bug# git rebase --interactive
--committer-date-is-author-date 8fef261
BUG: sequencer.c:921: GIT_AUTHOR_DATE missing from author script
Aborted (core dumped)
root@135b2edea980:/bug# git --version
git version 2.33.1
```

What did you expect to happen? (Expected behavior)
I expected to be able to reword the commit message like without passing the
`--committer-date-is-author-date` argument.


What happened instead? (Actual behavior)
segfault: `BUG: sequencer.c:921: GIT_AUTHOR_DATE missing from author script`

What's different between what you expected and what actually happened?
wouldn't expect a segfault, but the option to be able to edit the commit
message

Anything else you want to add:
This was inside an ubuntu focal docker container, git was installed via the
ppa ` ppa:git-core/ppa`

https://github.com/git/git/commit/7573cec52c0274ceb166c425be4288f6b3103d6f#d
iff-0e574dc9087fc7831bbc1403545a8561f08869576c1ccc4146aa276146ff9777R888-R88
9
this seems to be not the case and needs to be handled differently I guess?


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.11.0-38-generic #42~20.04.1-Ubuntu SMP Tue Sep 28 20:41:07
UTC 2021 x86_64
compiler info: gnuc: 9.3
libc info: glibc: 2.31
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]


