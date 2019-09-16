Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C811F463
	for <e@80x24.org>; Mon, 16 Sep 2019 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfIPLbS (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 07:31:18 -0400
Received: from wp558.webpack.hosteurope.de ([80.237.130.80]:54762 "EHLO
        wp558.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbfIPLbS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Sep 2019 07:31:18 -0400
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1i9pDw-0008He-0i; Mon, 16 Sep 2019 13:31:16 +0200
Subject: Re: Git diff|status against remote repo
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git <git@vger.kernel.org>
References: <3218b394-4dcf-0b99-c561-b1811f0be3d6@peter-speer.de>
 <20190916104505.cykdm2edrz7wy3fm@yadavpratyush.com>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Message-ID: <3f0ad1d5-aed4-9bfa-d3f6-09bae21a5dca@peter-speer.de>
Date:   Mon, 16 Sep 2019 13:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190916104505.cykdm2edrz7wy3fm@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1568633477;49480cc5;
X-HE-SMSGID: 1i9pDw-0008He-0i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Am 16.09.19 um 12:45 schrieb Pratyush Yadav:
> On 16/09/19 11:02AM, Stefanie Leisestreichler wrote:
>> Hi.
>>
>> I am far from being a pro in git.
>> There is something I do not understand.
>>
>> This is my git config:
>> [core]
>>          repositoryformatversion = 0
>>          filemode = true
>>          bare = false
>>          logallrefupdates = true
>> [remote "origin"]
>>          url = ssh://git@192.168.2.2:/home/git/PROJECT.git
>>          fetch = +refs/heads/*:refs/remotes/origin/*
>> [branch "master"]
>>          remote = origin
>>          merge = refs/heads/master
>> [branch "develop"]
>>          remote = origin
>>          merge = refs/heads/develop
>>
>> I have a local repo called "develop" also on each involved dev machine.
>>
>> Developer A has made changes on nearly each file of the project by changing
>> the namespace and locally commited those changes to his local branch
>> "develop". After that he did a git push.
>>
>> On a not involved machine M I did a git clone
>> ssh://git@192.168.2.2:/home/git/PROJECT.git and after that I did a "git
>> checkout develop" which was followed by a message like "Branch develop is
>> following remote branch develop from origin". I can see all the changes
>> Developer A has made.
>>
>> On my machine DEV I am on my local branch develop. Since I did not pull or
>> merge from origin already, I am not able to see any of those changes
>> developer A has made. So far so good. But I would expect, that git status
>> (which results in "On branch develop. Your branch is up to date with
>> origin/develop) or "git diff origin/develop develop" or "git diff
>> origin/develop...develop" (both no output at all) would give me a hint that
>> I am x commits behind origin/master or (git diff) will show me the changes
>> Developer A committed to the Repro. But nothing...
>>
>> What am I doing wrong?
> 
> You haven't gotten the new commits from origin, so your local repo can't
> know how ahead/behind it is from its remote version.
> 
> Run `git fetch origin`.
> 
> Now if you run `git status`, it should show you that you are X commits
> behind origin.
> 
> `git pull` does two things: `git fetch` and `git merge`. fetch
> "downloads" all the commits from remote, and merge then puts them in
> your local branch. So if you do a `git pull`, developer A's changes are
> now merged into your tree. But if you only do a fetch, origin/master
> gets updated, but not your local master. So now status can know how far
> you are behind, but your local branch is not changed yet.
> 
> Once you are ready to finally get those changes in your local branch,
> run `git merge origin/master`.
> 

Thanks a lot. git fetch did the trick.
