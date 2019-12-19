Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEEDC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 01:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F5C21D7D
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 01:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLSB0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:26:00 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:35746 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbfLSB0A (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Dec 2019 20:26:00 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ihkZh-0001PZ-Mk; Thu, 19 Dec 2019 02:25:57 +0100
Subject: Re: Bug: Merge commit lost during interactive rebase
To:     Valentina Finocchiaro <valentinafinocchiaro@gmail.com>,
        git@vger.kernel.org
References: <CA+Kr=1i09cw6o8J==psMiVEk8LaDr7nf2C-b85=TX4z=rV1oQg@mail.gmail.com>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <ad9494ae-f1f6-269f-b4d0-49e890dcd147@virtuell-zuhause.de>
Date:   Thu, 19 Dec 2019 02:25:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CA+Kr=1i09cw6o8J==psMiVEk8LaDr7nf2C-b85=TX4z=rV1oQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1576718758;08b9b045;
X-HE-SMSGID: 1ihkZh-0001PZ-Mk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.12.2019 23:04, Valentina Finocchiaro wrote:

Hi Valentina,

see the --preserve-merges parameter, in newer versions called
--rebase-merges, for git rebase. This avoids the default behaviour of
dropping the merge commit.

Thomas

> this is to report a bug found during interactive rebase.
> 
> Bug description
> 
> Scenario:
> - New commit on top of a Merge Commit.
> - Dropping last commit during interactive rebase.
> - Merge Commit is lost in history
> 
> Steps to reproduce this bug with “git version 2.18.1” on Centos8:
> 
> [root@a86e2b632fc2 git-bug-rebase]# git --version
> git version 2.18.1
> 
> # Creating git repo
> 
> [root@a86e2b632fc2 /]# mkdir git-bug-rebase
> [root@a86e2b632fc2 /]# cd git-bug-rebase/
> [root@a86e2b632fc2 git-bug-rebase]# git init
> Initialized empty Git repository in /git-bug-rebase/.git/
> 
> # Adding stuff on master branch and first commit
> 
> [root@a86e2b632fc2 git-bug-rebase]# touch file1
> [root@a86e2b632fc2 git-bug-rebase]# git add .
> [root@a86e2b632fc2 git-bug-rebase]# git commit -m "first commit"
> [master (root-commit) 39f2f9b] first commit
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 file1
> [root@a86e2b632fc2 git-bug-rebase]# git log
> commit 39f2f9b13feb0c1a4b6173cf179b45576fca9b96 (HEAD -> master)
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:49:21 2019 +0000
> 
>     first commit
> [root@a86e2b632fc2 git-bug-rebase]# git branch
> * master
> 
> # Creating another branch: branch2, checkout on it and commit changes
> 
> [root@a86e2b632fc2 git-bug-rebase]# git branch branch2
> [root@a86e2b632fc2 git-bug-rebase]# git branch
>   branch2
> * master
> [root@a86e2b632fc2 git-bug-rebase]# git checkout branch2
> Switched to branch 'branch2'
> [root@a86e2b632fc2 git-bug-rebase]# touch file-branch-2
> [root@a86e2b632fc2 git-bug-rebase]# git add .
> [root@a86e2b632fc2 git-bug-rebase]# git commit -m "commit on branch2"
> [branch2 786f836] commit on branch2
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 file-branch-2
> 
> # Checkout on master and commit something else
> 
> [root@a86e2b632fc2 git-bug-rebase]# git checkout master
> Switched to branch 'master'
> [root@a86e2b632fc2 git-bug-rebase]# touch file3
> [root@a86e2b632fc2 git-bug-rebase]# git add .
> [root@a86e2b632fc2 git-bug-rebase]# git commit -m "commit on master"
> [master e3a957d] commit on master
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 file3
> [root@a86e2b632fc2 git-bug-rebase]# git log
> commit e3a957d99401101b9e2805c2b59459123b2c1883 (HEAD -> master)
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:52:54 2019 +0000
> 
>     commit on master
> 
> commit 39f2f9b13feb0c1a4b6173cf179b45576fca9b96
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:49:21 2019 +0000
> 
>     first commit
> 
> # Merge two branches:
> 
> [root@a86e2b632fc2 git-bug-rebase]# git merge branch2
> Merge made by the 'recursive' strategy.
>  file-branch-2 | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 file-branch-2
> 
> [root@a86e2b632fc2 git-bug-rebase]# git log
> commit 9329daf43321d1b797652abf87106134ca516929 (HEAD -> master)
> Merge: e3a957d 786f836
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:53:03 2019 +0000
> 
>     Merge branch 'branch2'
> 
> commit e3a957d99401101b9e2805c2b59459123b2c1883
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:52:54 2019 +0000
> 
>     commit on master
> 
> commit 786f836d941c101cb952aa008d10246cb0638e46 (branch2)
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:50:30 2019 +0000
> 
>     commit on branch2
> 
> commit 39f2f9b13feb0c1a4b6173cf179b45576fca9b96
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:49:21 2019 +0000
> 
>     first commit
> 
> # Commit something after merge commit:
> 
> [root@a86e2b632fc2 git-bug-rebase]# touch file-after-merge
> [root@a86e2b632fc2 git-bug-rebase]# git add .
> [root@a86e2b632fc2 git-bug-rebase]# git commit -m "commit after merge"
> [master 1f33710] commit after merge
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 file-after-merge
> 
> [root@a86e2b632fc2 git-bug-rebase]# git log
> commit 1f33710d6f011bb123cd947f82a004812b71f804 (HEAD -> master)
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:53:43 2019 +0000
> 
>     commit after merge
> 
> commit 9329daf43321d1b797652abf87106134ca516929
> Merge: e3a957d 786f836
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:53:03 2019 +0000
> 
>     Merge branch 'branch2'
> 
> commit e3a957d99401101b9e2805c2b59459123b2c1883
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:52:54 2019 +0000
> 
>     commit on master
> 
> commit 786f836d941c101cb952aa008d10246cb0638e46 (branch2)
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:50:30 2019 +0000
> 
>     commit on branch2
> 
> commit 39f2f9b13feb0c1a4b6173cf179b45576fca9b96
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:49:21 2019 +0000
> 
>     first commit
> 
> # Delete last commit through interactive rebase (merge commit is not
> shown on list):
> 
> [root@a86e2b632fc2 git-bug-rebase]# git rebase -i HEAD~3
> Successfully rebased and updated refs/heads/master.
> [root@a86e2b632fc2 git-bug-rebase]# git status
> On branch master
> nothing to commit, working tree clean
> 
> # Merge commit is lost:
> 
> [root@a86e2b632fc2 git-bug-rebase]# git log
> commit 82a34e8b224d8fa9434cc484ed153b519ffa32a5 (HEAD -> master)
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:50:30 2019 +0000
> 
>     commit on branch2
> 
> commit e3a957d99401101b9e2805c2b59459123b2c1883
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:52:54 2019 +0000
> 
>     commit on master
> 
> commit 39f2f9b13feb0c1a4b6173cf179b45576fca9b96
> Author: root <valentina.finocchiaro@gmail.com>
> Date:   Wed Dec 18 09:49:21 2019 +0000
> 
>     first commit
> 
> 
> Thanks and Best Regards,
> Valentina
> 

