Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31575C3A5A1
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380018AbiDDVVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379131AbiDDQhB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 12:37:01 -0400
X-Greylist: delayed 427 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Apr 2022 09:35:05 PDT
Received: from st43p00im-zteg10073501.me.com (st43p00im-zteg10073501.me.com [17.58.63.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302DA15A3C
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1649089676;
        bh=PO6eC42AVZ60WODoWCqQ+LGLs7Y189rdmolGYVlyO6o=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=T62JmjIcp+ZwTaIFV1vOYjYyhvEZoktIaET0ltSpg0bFD7ZGOio1UA4THFew4uh8G
         XqjhDmAES+SNboriZInAlNJyj/cKNBmy9Ju/H2vEvyNNABmFEUHmHsVnoybLL+cifW
         wuu15arHdl8DFwBXwG42QGt44kgA35x1x9ZPkuW/LKuf6X+H7XZq3t5MWRKtR4jsTY
         2NKq1tZ4QeIRYMU+SHBgPTGQoPDJjUzW83DvVtOwKVDW9pQYjyX3WjP23JCsevrVVR
         EglNKRyfFT34/nnhfBVrDDEfJ72IUpGTqonkRpAjmY/g/StU10VLY2LpWsd0XHVIDt
         9125ztW4MLrlA==
Received: from max-mbp-1449.fritz.box (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10073501.me.com (Postfix) with ESMTPS id C5C743611D5
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 16:27:55 +0000 (UTC)
From:   Maximilian Reichel <reichemn@icloud.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: `git checkout` is not a no-op as documented
Message-Id: <D0A0CC41-C41E-4856-B969-2A6DD3C14079@icloud.com>
Date:   Mon, 4 Apr 2022 18:27:53 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=840 phishscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2204040093
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Running the following commands:
```
#!/bin/bash
git -c init.defaultBranch=3Dmaster init workDir
cd workDir
git commit --allow-empty -m first
git checkout -b other
git commit --allow-empty -m second
git checkout master
git merge --no-ff --no-commit other
git merge # shows merge in progress
git checkout # should be no-op
git merge # shows no merge in progress
git commit --no-edit # fails
```

What did you expect to happen? (Expected behavior)
I tried to merge another branch with `--no-ff --no-commit` but used the =
checkout command before commiting the changes.
Since the documentation states:
> You could omit <branch>, in which case the command degenerates to =
"check out the current branch",
> which is a glorified no-op with rather expensive side-effects to show =
only the tracking information,
> if exists, for the current branch.
I expected that the checkout with omitted <branch> only shows the =
tracking information and does not change the current states since it is =
advertised as a no-op.
So I expected the following output:
```
Initialized empty Git repository in /test/workDir/.git/
[master (root-commit) c521e9e] first
Switched to a new branch 'other'
[other 617af42] second
Switched to branch 'master'
Automatic merge went well; stopped before committing as requested
fatal: You have not concluded your merge (MERGE_HEAD exists).
Please, commit your changes before you merge.
fatal: You have not concluded your merge (MERGE_HEAD exists).
Please, commit your changes before you merge.
[master d2d6409] Merge branch 'other'
```


What happened instead? (Actual behavior)
After running the checkout command, I can longer use `git commit` to =
finish the merge and commit the changes.
I got the following output:
```
Initialized empty Git repository in /test/workDir/.git/
[master (root-commit) c521e9e] first
Switched to a new branch 'other'
[other 617af42] second
Switched to branch 'master'
Automatic merge went well; stopped before committing as requested
fatal: You have not concluded your merge (MERGE_HEAD exists).
Please, commit your changes before you merge.
fatal: No remote for the current branch.
On branch master
nothing to commit, working tree clean
```

What's different between what you expected and what actually happened?
I expected `git checkout` to only show the tracking information as =
stated in the documentation.


Anything else you want to add:
I tested this on git 2.35.1 and 2.21.0, which are both affected.=20

[System Info]
git version:
git version 2.35.1
cpu: x86_64
built from commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.25-linuxkit #1 SMP Tue Mar 23 09:27:39 UTC 2021 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show=
