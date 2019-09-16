Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4DC01F463
	for <e@80x24.org>; Mon, 16 Sep 2019 10:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfIPKpN (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 06:45:13 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43991 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732370AbfIPKpM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 06:45:12 -0400
X-Originating-IP: 1.186.12.28
Received: from localhost (unknown [1.186.12.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 622F320016;
        Mon, 16 Sep 2019 10:45:08 +0000 (UTC)
Date:   Mon, 16 Sep 2019 16:15:05 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git diff|status against remote repo
Message-ID: <20190916104505.cykdm2edrz7wy3fm@yadavpratyush.com>
References: <3218b394-4dcf-0b99-c561-b1811f0be3d6@peter-speer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3218b394-4dcf-0b99-c561-b1811f0be3d6@peter-speer.de>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/09/19 11:02AM, Stefanie Leisestreichler wrote:
> Hi.
> 
> I am far from being a pro in git.
> There is something I do not understand.
> 
> This is my git config:
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> [remote "origin"]
>         url = ssh://git@192.168.2.2:/home/git/PROJECT.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
> [branch "develop"]
>         remote = origin
>         merge = refs/heads/develop
> 
> I have a local repo called "develop" also on each involved dev machine.
> 
> Developer A has made changes on nearly each file of the project by changing
> the namespace and locally commited those changes to his local branch
> "develop". After that he did a git push.
> 
> On a not involved machine M I did a git clone
> ssh://git@192.168.2.2:/home/git/PROJECT.git and after that I did a "git
> checkout develop" which was followed by a message like "Branch develop is
> following remote branch develop from origin". I can see all the changes
> Developer A has made.
> 
> On my machine DEV I am on my local branch develop. Since I did not pull or
> merge from origin already, I am not able to see any of those changes
> developer A has made. So far so good. But I would expect, that git status
> (which results in "On branch develop. Your branch is up to date with
> origin/develop) or "git diff origin/develop develop" or "git diff
> origin/develop...develop" (both no output at all) would give me a hint that
> I am x commits behind origin/master or (git diff) will show me the changes
> Developer A committed to the Repro. But nothing...
> 
> What am I doing wrong?

You haven't gotten the new commits from origin, so your local repo can't 
know how ahead/behind it is from its remote version.

Run `git fetch origin`.

Now if you run `git status`, it should show you that you are X commits 
behind origin.

`git pull` does two things: `git fetch` and `git merge`. fetch 
"downloads" all the commits from remote, and merge then puts them in 
your local branch. So if you do a `git pull`, developer A's changes are 
now merged into your tree. But if you only do a fetch, origin/master 
gets updated, but not your local master. So now status can know how far 
you are behind, but your local branch is not changed yet.

Once you are ready to finally get those changes in your local branch, 
run `git merge origin/master`.

-- 
Regards,
Pratyush Yadav
