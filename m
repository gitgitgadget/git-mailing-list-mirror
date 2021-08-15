Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5772C4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 14:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE346112E
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 14:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbhHOOcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhHOOcT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 10:32:19 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF1DC061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 07:31:49 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id t16so12270538qta.9
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DFIWd+cq3O+WqeiD69VD9Wn63wsguJ5ly90NyF8st9M=;
        b=GkonDw4NyORAEtzj9XZwkNd/tQSyMsix/7MIAFYTx56mGj53GDXqMhBPR9bMH+Ku+c
         kIQfcM1FfZ4tLXOUP1XrpTy9H5aThs91p8Wgm6bMpsJuYM2yc+OV6Ur172b5vNWZoTQt
         /uxGKdNRTMgYsUoUhpLVSyRfoi2miGxw3Cr6r/E2t3+0hBm7Jqm6o/0XjSt5zV8MU67M
         w1TIAYdl1OvxfQybHxKNUxV9PV+9pQwx2RDawLiUM4qesOaPova4OGfeJKQ12Zk0j8hn
         ZOEMkGtBNy4zp9xMlASgabeJjL0e6BhL0/9v84jLAfoCDQuUcjCOd3F2GOLY4yfUVte4
         AFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DFIWd+cq3O+WqeiD69VD9Wn63wsguJ5ly90NyF8st9M=;
        b=WcXGsuZUJMSt8U1BWxiToa5p7vRcohLKUqPG333c5tgFiPwtcUy/bPGkYL+dsq4XDY
         x8Jb+yymSDwuGHpKnnZj4T5OQP1QlixZBsBZ2ccmjcRyW5LJp2R61A8Pduojh7MPzBN0
         OORADB62P6HRu5uLy6f0nOKAlAjQwifGREIhRBCRTbl1d4W6JeKANxxu8tBxkl9QdHZC
         kvQQbkmAST6kLt8Os9jLmuYyUR5QmvHinUD1Tqr/tFS57A0BJPz3Y9VBn8pes6p6nq32
         GzfQoe4IcQvgdD0DEmRtNsPi2vhcE6on+4Yt4W2IS7IX/AlBWFs28IO6RWUDpGMacttj
         FP4g==
X-Gm-Message-State: AOAM530vkVXvI9L7gdwCa7cyVEkZv4QbONwygv2ADanYb/+MwO8x3h5E
        JlksHLvtyLFq+dclpGXQ+90=
X-Google-Smtp-Source: ABdhPJyAvAjapgEN1vBpdXBVwbOV9HkQQnSJZwC7wgnIPE/8SGEY0qfHn8hGFyeGFvW+q6ub9ho7bg==
X-Received: by 2002:a05:622a:14d:: with SMTP id v13mr10197842qtw.241.1629037908683;
        Sun, 15 Aug 2021 07:31:48 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id i16sm3522500qtq.52.2021.08.15.07.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 07:31:48 -0700 (PDT)
Subject: Re: Bug with Git shallow clones and submodules
To:     Kevin Phillips <thefriendlycoder@gmail.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <CANNNLMC_XEqjYPOig+pbqrS30dPCTmcDSev6yg+5EEBkJCaaig@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <1a98c659-e7db-50a6-faf3-b3b4c15df679@gmail.com>
Date:   Sun, 15 Aug 2021 10:31:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CANNNLMC_XEqjYPOig+pbqrS30dPCTmcDSev6yg+5EEBkJCaaig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kevin,

Le 2021-08-11 à 10:59, Kevin Phillips a écrit :
> We recently came across a bug in one of our Git projects which make
> use of submodules. The basic problem is we have a Git repo that has 1
> submodule within it which is set up to check out a specific branch,

Just to make sure we are on the same page: you can't have a submodule
"set up to check out a specific branch", at least
not in the sense that the submodule is always "checked out" on a branch,
and the superproject knows that the submodule should always be "on that branch";
that's not how submodules work. As specified in [1], the config `submodule.<name>.branch`
which your repo has in '.gitmodules' is only ever used by
`git submodule update --remote`. The superproject itself only records at which *commit* the
submodule is at.

> and when we attempt to perform a shallow clone on the parent repo the
> checkout fails with a "Server does not allow request for unadvertised
> object" error. After doing a lot of testing and reading online I found
> this StackOverflow thread (https://stackoverflow.com/a/61492323) that
> explains our problem in great detail, which indicates to me that this
> is likely not a problem specific to us, so I thought I'd report it to
> see if it could be fixed.

I think your situation is related, but not exactly the same as the SO
post. But torek's answer sure explains a lot of important points that
are relevant in your situation.

> 
> In our specific use case, we found the problem specifically when
> running a build of our project using Gitlab CI. This tool
> automatically performs a shallow checkout of projects being built by
> using a "--depth=50" parameter. This caused odd Git checkout errors to
> appear on our CI builds which weren't directly reproducible by our
> developers local builds. Upon closer examination we were able to
> reproduce outside of the CI environment by performing a checkout as
> follows:
> 
>      git clone --recurse-submodules --depth=50  git@<path_to_repo>.git .
> 
> Based on my initial research, which was helped greatly by the
> StackOverflow thread I linked to above, I was able to deduce the
> following contributing factors:
> 
> The submodule that was causing us grief was the dpdk library located
> here: http://git.dpdk.org/dpdk-stable/
> 
> This repository has a default branch named "default" which has only 2
> commits on it: one for initializing the repo and one additional commit
> All releases of this library are created from branches named by the
> release version, and they all seem disjoint from one another, and they
> are all disjoint from the default branch (ie: changes from the release
> branches are never merged into the default branch)
> 
> our parent repo, which is an internal / non-public repository that can
> not be shared, has a single submodule defined in it with the following
> .gitmodule definition:
> 
> 
> [submodule "dpdk-stable"]
> path = dpdk-stable
> url = https://git@dpdk.org/git/dpdk-stable
> branch = 19.11
> 
> the specific revision we are checking out has the OID
> 78bc27846101e481438a98c68cac47e4476085c0 which corresponds to the
> 19.11.8 tag
> the following git clone operation succeeds:
> 
> git clone --recurse-submodules git@<path_to_repo>.git .
> 
> the following git clone operation fails:
> 
> git clone --recurse-submodules --depth=50  git@<path_to_repo>.git .

Thanks for the details here. I came up with this short reproducer script,
which I think shows the behaviour you are seeing:

~~~bash
#!/bin/bash

set -e

rm -rf test && mkdir test && cd test
rm -rf project clone

# Create project
git init project && cd project
echo "content">file
git add file
git commit -m "initial in proj"
git submodule add -b 19.11 https://dpdk.org/git/dpdk-stable
git -C dpdk-stable -q checkout 78bc27846101e481438a98c68cac47e4476085c0
git add dpdk-stable
git commit -m "add lib to project"
cd ../

# Clone project
GIT_TRACE2=3 git -c protocol.version=2 clone --no-local --recurse-submodules --depth=50 project clone 3> >(grep -E 'git clone|git fetch|git submodule|git rev-list' )
~~~

Note that in the "Create project" phase, I use the HTTPS URL
https://dpdk.org/git/dpdk-stable, which is the recommended HTTPS URL at [2].

> 
> we can work around the problem by doing a shallow clone with the
> no-single-branch parameter, as in:
> 
> git clone --recurse-submodules --depth=50 --no-single-branch
> git@<path_to_repo>.git .
> 
> Based on my current level of understanding, Git is automatically
> setting the --single-branch flag when cloning submodules but only when
> doing a shallow clone of the parent. This seems wrong to me. 

In fact, the logic in the code is twofold:

1. In 'git clone', '--depth' implies '--single-branch' [3]
2. In 'git clone', '--single-branch' is used to clone submodules if
    '--recurse-submodules' is used. This is the case since 132f600b06
    (clone: pass --single-branch during --recurse-submodules, 2020-02-20)

I'm not sure why you think this is wrong (in theory)...

> In
> addition, even if Git was going to enforce the single branch option on
> submodules it stands to reason that it should be respecting the branch
> defined in the .gitmodules file (ie: 19.11 in our case) instead of
> using the default branch (ie: "default" in this case). 

... in practice, here you are right: it is indeed unfortunate that the
branch specified in '.gitmodules' is not used for the initial clone of
the submodule if they are cloned with '--single-branch'.

> My guess is, if
> it were respecting the branch name then we wouldn't be getting the
> "unadvertised object" error because the referenced OID would exist in
> the submodule checkout because it would have the correct branch
> checked out.

I think your are right, since the following command does work:

     git clone --single-branch --branch 19.11 https://dpdk.org/git/dpdk-stable &&
     git -C dpdk-stable checkout 78bc27846101e481438a98c68cac47e4476085c0

> 
> For reference, this problem appears to be reproducible on several
> different platforms (ie: several different Linux distros and Mac OSX
> at least) and several different Git versions up to v2.32.0 which is
> the latest version at the moment. Hopefully this problem can be fixed
> in a future release of the command line tools. In the meantime we've
> had to hack around the problem in our Gitlab CI builds by disabling
> the shallow checkout features, which is less than ideal

If you run my reproducer script above, you should see the steps that the code
does to try to retrieve the commit you need, 78bc27846101e481438a98c68cac47e4476085c0:

1. It invokes 'git clone' for the submodule:

     child_start[0] git clone --no-checkout --progress --separate-git-dir $PWD/test/clone/.git/modules/dpdk-stable --single-branch -- https://dpdk.org/git/dpdk-stable $PWD/test/clone/dpdk-stable

2. It checks if the clone downloaded the needed object:

     start git rev-list -n 1 78bc27846101e481438a98c68cac47e4476085c0 --not --all

    We know that it did not, because as noted above, the branch from '.gitmodules'
    is not used in the single-branch clone, so only object from the 'default' branch
    are available.
3. It realizes the object is not there, so it runs "git fetch" in the submodule
4. It checks again with the same 'git rev-list command' if the fetch downloaded
    the needed object. Of course, it did not, because since the branch in '.gitmodules'
    is not used for the initial single-branch clone, at that point the fetch refspec
    in the submodule is '+refs/heads/default:refs/remotes/origin/default', and so a
    simple 'git fetch' does not bring any new object.
5. It falls back to fetching the needed commit by its hash:

     start git fetch origin 78bc27846101e481438a98c68cac47e4476085c0

6. The server at https://dpdk.org/git/dpdk-stable refuses this request and you get

     error: Server does not allow request for unadvertised object 78bc27846101e481438a98c68cac47e4476085c0

OK so why does the server refuses the request ? If you take a look at [4], you will
understand that it's probably because the configs 'uploadpack.allowReachableSHA1InWant'
and 'uploadpack.allowAnySHA1InWant' are both false (i.e. their default value) on the
https://dpdk.org/git/dpdk-stable server. So the behaviour here is not a bug, it's
working as it should (but leads to a bad experience for you).

What is not unfortunately not mentioned in the documentation at [4]
is that the two configs that I mention above only apply if version 0 of the Git transfer
protocol is in effect. So this would mean that even though we specify '-c protocol.version=2'
in the 'git clone' command in my script, the server uses protocol v0. Protocol v2 works
starting in Git 2.18, so let's check what version is running at dpdk.org:

$ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote https://dpdk.org/git/dpdk-stable 2>&1 | grep agent
packet:          git< 6ee0521feb765d9105241a3f6693762c471655cf HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed no-done symref=HEAD:refs/heads/default agent=git/2.20.1

OK, it's running Git 2.20.1. And the list of capabilities above implies that it's responding
with protocol v0, even if my local Git version if 2.29, which defaults to protocol v2. If
it were responding with protocol v2, we would see:

$ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote https://github.com/git/git 2>&1 | grep agent
packet:          git< agent=git/github-g78b452413e8b  # server version
packet:          git< agent=git/github-g78b452413e8b
packet:          git> agent=git/2.29.2  # client version
packet:          git< agent=git/2.29.2

And grepping for "version" would confirm it:

$ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote https://github.com/git/git 2>&1 | grep version
packet:          git< version 2
packet:          git< version 2

I can't explain why the server refuses to talk with protocol v2. Maybe Jonathan (CC-ed),
who worked on the implementation of protocol v2, would be able to explain that.

And it gets weirder. If you instead use the Git URL (instead of the HTTPS URL)
for the dpdk-stable submodule [2], then the server responds with protocol v2!

$ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote git://dpdk.org/dpdk-stable 2>&1 | grep agent
packet:          git< agent=git/2.20.1
packet:          git> agent=git/2.29.2
$ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote git://dpdk.org/dpdk-stable 2>&1 | grep version
packet:          git> git-upload-pack /dpdk-stable\0host=dpdk.org\0\0version=2\0
packet:          git< version 2

And indeed, if you use the 'git://' URL in the 'git submodule add' command in my reproducer
script, it succeeds !

It don't understand this behaviour either.

So a workaround for you would be to use the 'git://' URL in your '.gitmodules',
if the Git port (9418) is not blocked in your infrastructure.

I hope this helps,

Philippe.

P.S. for Jonathan I noticed some additional weirdness while debugging this:
Some servers respond with a different Git version depending on the protocol:

$ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote  git://gcc.gnu.org/git/gcc.git 2>&1 | grep -E 'agent|version '
packet:          git< version 2
packet:          git< agent=git/2.26.2
packet:          git> agent=git/2.29.2
$ GIT_TRACE_PACKET=1 GIT_TRACE_BARE=1 git ls-remote  https://gcc.gnu.org/git/gcc.git 2>&1 | grep agent -E 'agent|version '
packet:          git< 882f1d58bfa56737ff2de84c3cd1e0acfc318b86 HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed no-done symref=HEAD:refs/heads/master agent=git/2.27.0

Here again, with HTTPS we fall back to protocol v0. The same behaviour happens
with git://sourceware.org/git/binutils-gdb.git...

1. https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt--bltbranchgt
2. https://core.dpdk.org/contribute/#clone
3. https://git-scm.com/docs/git-clone#Documentation/git-clone.txt---depthltdepthgt
4. https://git-scm.com/docs/git-config#Documentation/git-config.txt-uploadpackallowReachableSHA1InWant
