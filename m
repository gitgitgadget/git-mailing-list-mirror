Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B8CC433F5
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 10:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiBMKhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 05:37:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiBMKhf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 05:37:35 -0500
X-Greylist: delayed 501 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 02:37:29 PST
Received: from vps.robotics-erlangen.de (vps.robotics-erlangen.de [IPv6:2a01:4f8:c0c:180a::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCC5DE40
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 02:37:28 -0800 (PST)
Received: from [0.0.0.0] (cs6-jump.informatik.uni-erlangen.de [131.188.36.15])
        by vps.robotics-erlangen.de (Postfix) with ESMTPSA id 7944F100128
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 11:29:04 +0100 (CET)
To:     git@vger.kernel.org
From:   Tobias Heineken <tobias.heineken@robotics-erlangen.de>
Subject: [Bugreport] Git Checkout-Index from sub-folder
Message-ID: <eb022c46-81be-2112-76fa-3c8b783767bc@robotics-erlangen.de>
Date:   Sun, 13 Feb 2022 11:29:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

I've run into an issue with git checkout-index -a --prefix FOO/,
where it would not do any (visible) actions
when called from a sub directory.

The following bug report (including a minimized example) was created in 
a virtual machine (with a more recent git), but I first noticed the bug 
on my machine with git version 2.17.1.

I did not find a public git issue tracker online,
so I have no idea if this issue already came up.
I'm also currently trying to test this on a more recent git than 2.31,
but I don't know when I'll have access to that.

Thanks for your help,
Tobias Heineken


==== git-bugreport-2022-02-13-1034.txt ====
Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
```
mkdir test
cd test
git init
echo "Hallo Welt" > test
git add test
git commit -m "initial commit"
mkdir temp
cd temp
git checkout-index -a --prefix NEW/
```

What did you expect to happen? (Expected behavior)
I expected to get a copy of my test file in either test/temp/NEW/test or 
test/NEW/test.

What happened instead? (Actual behavior)
Nothing (at least nothing observable to me).
Note that doing git checkout-index on top level (test) works, but when 
changing the working directory to the sub directory temp first it does 
no longer work.
Also note that git checkout-index --prefix NEW/ -- ../test kind of 
works, as it creates test/NEW/test. Not the first place I was looking 
for that file, but at least it is there.

What's different between what you expected and what actually happened?
There is no copy of my test file.

Anything else you want to add:
I would be fine with either of the following 4 options:
(1) The Manpage for git checkout-index clearly states that it should 
only be called in the git root directory (test in this case)
(2) The prefix is interpreted relative to the current working directory 
(and this is clearly explained in the manpage)
(3) The prefix is interpreted relative to the git root directory (and 
this is clearly explained in the manpage)
(4) git checkout-index complains visibly when called with a working 
directory that is not equal to the git root directory

[System Info]
git version:
git version 2.31.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.3.18-59.24-default #1 SMP Mon Sep 13 15:06:42 UTC 2021 
(2f872ea) x86_64
compiler info: gnuc: 7.5
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
