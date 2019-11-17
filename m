Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A54A51F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 22:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfKQW0S (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 17:26:18 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:55753 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfKQW0S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 17:26:18 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47GRWW3ZsSz5tlD;
        Sun, 17 Nov 2019 23:26:15 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id EE7CD2EB8;
        Sun, 17 Nov 2019 23:26:14 +0100 (CET)
Subject: Re: working directory status
To:     Sivanandan Srilakshmanan <ssrilaks@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
References: <CACKP9ctDPFn_oqHVSO9Lfi2aMDkAtiuViCv6PvYtmag+P+oaLQ@mail.gmail.com>
 <20191117072942.cycm2kyvt2g2bhaz@yadavpratyush.com>
 <CACKP9cs+eJMtwWJtc3c_TXOUacpaxHUP4Ugw5oSpDfKcABaR7g@mail.gmail.com>
 <e5f25791-694d-6b5c-138b-ac99b4f50b13@kdbg.org>
 <CACKP9cv=J=_sDUsLZi7-GerFD=qbHuJT0MBdfgsMsN4pD25L2A@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6bb36048-6649-ebe3-062f-c5564f7d4ec4@kdbg.org>
Date:   Sun, 17 Nov 2019 23:26:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CACKP9cv=J=_sDUsLZi7-GerFD=qbHuJT0MBdfgsMsN4pD25L2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.11.19 um 21:33 schrieb Sivanandan Srilakshmanan:
> Reading git documentation, my understanding is that, if you needed to
> use "git worktree add" then it is recommended to keep your work tree
> (Working Dir) outside of your repository.
> My understanding, please correct me if I am wrong, is to have multiple
> worktree outside of the Git Repository.

That sounds reasonable. Note though that if you need N worktrees, then
you have one worktree with the (non-bare) repository, and N-1 worktrees
outside that repository.

> if you used "git clone" to setup your directory and your worktree is
> included in the same location as the Git Repository, then GIT_DIR is
> not required.

Yes.

> Please assist me to understand what I am doing incorrectly. The
> "output 1" below is incorrect because Local_Newfeature (working
> directory / worktree) is associated with the incorrect branch
> (Local_Kumfeature_branch)
> Local_Newfeature directory should be pointing to "Local_Newfeature_branch".
> 
> Output 2 is correct.
> 
> ====== Output 1 - incorrect =========================================
> C:\test\Local_Newfeature>git --work-tree=C:\test\Local_Newfeature status
> On branch Local_Kumfeature_branch
> Your branch is up to date with 'Lakshman/feature_branch'.

You observe this incorrect output because you have GIT_DIR set.
Obvously, Git looks at the branch that the HEAD of $GIT_DIR refers to.

Do not set GIT_DIR if you do not know what it is good for.

> ===== Output 2  - correct =============================================
> C:\test\Local_Newfeature>git branch
> * Local_Kumfeature_branch
>   Local_MyTest_branch
> + Local_Newfeature_branch
> + Local_SGSfeature_branch
>   Local_feature_branch

If Output 1 is incorrect, this is not correct, either: Note that
Local_Kumfeature_branch is marked as the branch for this directory, but
you intend it to be Local_Newfeature_branch, yet it is marked as living
in a different worktree.

Do not set GIT_DIR if you do not understand the consequences.

> C:\test\Local_Newfeature>git worktree list
> C:\GitRepo                (bare)
> C:/test/Local_Kumfeature  b0a097e [Local_Kumfeature_branch]
> C:/test/Local_Newfeature  b0a097e [Local_Newfeature_branch]
> C:/test/Local_SGSfeature  b0a097e [Local_SGSfeature_branch]

I do not know whether it is a sane use-case to have a bare repository
and separate worktrees.

Do not do that. Make a regular clone with a worktree and create
secondary worktrees from there.

-- Hannes
