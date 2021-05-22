Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5FEC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 18:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1616E61139
	for <git@archiver.kernel.org>; Sat, 22 May 2021 18:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhEVSES (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhEVSER (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 14:04:17 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C341CC061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 11:02:52 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id h7so11520317qvs.12
        for <git@vger.kernel.org>; Sat, 22 May 2021 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rsgTj65jXdifF1/99rAkTrQMLxMemHXa8SCFjdxpUVc=;
        b=fTgrWdXPPkJbz/sSFOweewoMYMt3zRMs0vIIEwjsnbindhX0YkKd+y2JGwXEPY1/aP
         Ic571B1pJzBRzqJYS+/B8g5HseRqc9lk4udbpaPSS/4N+fJXK8hXQlKYHTsEly0pl40+
         Y+y2mTbtFmi3csTwB2Rjx/ZATLC+wXG1XGY+06L8bdDBtlPCtEPEGes3Y7mlNfQIMDhY
         2PjFoewsc1Uu48VplWj6QOIKyNcGz4wyYP66BOwgWFUiKN1isKmZ5d2OqE5mKVcVWIMo
         A960w2m5QR1klAzRseBlQY4QPU+RX8aoNRbfacCNNoHtrdsnaYOFJY+rQH0WxehvCZY9
         YAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rsgTj65jXdifF1/99rAkTrQMLxMemHXa8SCFjdxpUVc=;
        b=Q8scIgVhDB/Bk3EinSg57V4Spvo7feniB9PAHW72x7UrlUwtKTOP4HowHML2DzNihG
         7ftR9LzlpKoOxm88FIrVCMcUMKjoDziLU0RJmDhbS4D1SVnf02ofSQaB0UpPnHHKgeLw
         oi3LEPvl+K7n9otO1Z5XSX+G94YUkH6kWWfRxcY9atFe0llEqsAvbdWhztz9QSL8UvN2
         d33xC2MDhP6XPr2U0CvpH87TY9zOzM+YRjBPsUvqOwPp6PItd1FZ0DN3xi/Y/KiLVRt7
         m7NhhPbXlTUJwBakwUMFxFZaTEiyAxRHps6g312aHVjzcHPe8Zyu+c1UZ7741RPGObuw
         NtuQ==
X-Gm-Message-State: AOAM531o09yjKABvNmJzQiUaeW3v7h44kUOJNDWM0HYKPmBXauOmZIm7
        w+Pxs/s+4uHbV0HGk13nkRU=
X-Google-Smtp-Source: ABdhPJySqhVfu6sFXq/htU8R0fo6TyjEPV3FYDrJXZZIl9k7RX3aX812WuLwI8rG2kuJBXRxEXfMTg==
X-Received: by 2002:ad4:5f87:: with SMTP id jp7mr20411453qvb.46.1621706571901;
        Sat, 22 May 2021 11:02:51 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id g63sm7561005qkd.92.2021.05.22.11.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 11:02:51 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: Bug in git submodule update --remote
To:     Ben Avison <bavison@riscosopen.org>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        raykar.ath@gmail.com
References: <c4b27662-1228-a1ff-26fc-637897ffc8e7@riscosopen.org>
Message-ID: <2c99d00c-d580-2ab9-ffda-256bbb628392@gmail.com>
Date:   Sat, 22 May 2021 14:02:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <c4b27662-1228-a1ff-26fc-637897ffc8e7@riscosopen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

Le 2021-05-14 à 14:11, Ben Avison a écrit :
> A recent-ish change in git 2.27.1, introduced in commit f0a96e8d, has also got me wondering about whether some related functionality is correct. I'm not sure what the best way to fix things is, so can I invite opinions?
> 
> The scenario: I have a repository with a submodule. The submodule's upstream repository uses a fork workflow, so the submodule has two remotes, one for pulling in other people's changes, and one for uploading my own pull requests.
> 
> $ mkdir myproject
> $ cd myproject
> $ git init
> $ git submodule add https://github.com/acme/library
> $ cd library
> $ git remote add -f myfork https://github.com/user/library
> $ cd ..
> $ git add .
> $ git commit -m "Initial commit"
> $ git remote add origin https://github.com/user/myproject
> $ git push -u origin master
> 
> Furthermore, assume I forked https://github.com/acme/example some time ago, so that the master branches between it and my fork have diverged.
> 
> Time passes. People hack away on both projects. I want to fix a bug or implement a new feature in the library, so I start by ensuring both are up-to-date:
> 
> $ git pull
> $ git submodule update --remote
> $ cd library
> $ git checkout -b new-feature
> $ # hack away
> $ git add .
> $ git commit -m "New feature"
> $ git push -u myfork new-feature

Starting on a slight tangent, I know the 'git push -u $remote $branch' command
is often mentioned in tutorials, but since you are using the forking workflow,
I would suggest looking into the 'remote.pushDefault' / branch.$.pushRemote configs [1]. This allows you
to track upstream/master on your feature branches (i.e. the branch into which your feature
will eventually be integrated), and to push directly to your fork with a simple 'git push' :)

> $ cd ..
> 
> Some more time passes, and I want to work on it again. Again, I start by ensuring I'm up-to-date. Before git 2.27.1, I could do:
> 
> $ git submodule update --remote
> 
> Now, I get:
> 
> fatal: Needed a single revision
> Unable to find current myfork/HEAD revision in submodule path 'library'

That's a shame. Dscho's f0a96e8d4c (submodule: fall back
to remote's HEAD for missing remote.<name>.branch, 2020-06-24) did not touch
git-sumodule.sh, so when I took a look at it in [3] I did not think of going through
the code path...

> 
> What's going on is that within "git submodule update --remote", the sha1 used is formed by looking up the submodule's ref "<remote>/<branch>". The change in git 2.27.1 is that if no remote tracking branch is stated in the superproject's .gitmodules file, <branch> defaults to "HEAD" rather than "master" as previously. That's fine if <remote> is "origin", but in practice, it depends on how the submodule is currently checked out:
> 
> * if it's in detached HEAD state, <remote> is set to "origin"
> * if its branch is not a tracking branch, "origin" is also used
> * but if it's a tracking branch (as I used in my workflow above - not uncommon in pull request workflows because you might grant other people access to the branch during the review process) then it looks up the name of the remote which is being tracked
> 

Yes, that's indeed the behaviour of submodule--helper.c::get_default_remote,
which is called by submodule--helper.c::print_default_remote, i.e.
'git submodule--helper print-default-remote', which is called by
git-submodule.sh::cmd_update (line 580 as of v2.32.0-rc1).

> First observation: a ref called "myfork/HEAD" presumably *could* have been created by the "git remote add" command, reflecting that remote's default branch. Should it?

I think that's what happens with the '-m' switch, i.e. 'git remote add -m master myfork $url'.
The symref $remote/HEAD can also be created after adding the remote
with 'git remote set-head myfork --auto' [2], which will
query the remote's real default branch (i.e. the remote HEAD) and set the local symref accordingly.
The fact that this is not done automatically upon
'git remote add' (or git fetch) is a historical mistake in my opinion but some others might disagree.

> 
> In practice, that's not actually what I'd want, though. If I do "git submodule update --remote", I personally normally do so as a shortcut compared to cloning everything again. I don't expect the behaviour to change depending on whether I happen to have left one of the submodules checked out on a tracking branch or not: myfork/master is potentially quite out of date compared to origin/master.

I completely agree.

> 
> It also makes very little sense to me that issuing "git submodule update --remote" twice in quick succession would leave us in a different state, because the first call puts all the submodules into detached HEAD state, meaning that the second call always looks up the remote tracking branches from the submodule's "origin" remote.

I also agree.

> 
> One way this could be fixed is that if <branch> turns out to be "HEAD", we could force <remote> to be "origin". However, this doesn't address the equivalent problem that arises if the remote tracking branch *is* named in .gitmodules.
> 
> I'd therefore like to propose that "git submodule update --remote" *always* uses the remote named "origin" to form the ref used to check out the submodule. However, I'm not sure whether everyone would agree that this constitutes a bugfix, or whether I'd need to introduce a new switch to enforce this behaviour.
>

I prefer introducing a new config variable, as you suggest in your patch
downthread. I'll comment there with more details, but I do not like the
approach of hard-coding 'origin' with no escape hatch. Personnally I use
'origin' for my fork and 'upstream' for the autoritative repository in all
my clones, and I can't do this in submodules because of the fact that 'origin'
is hard-coded at few places in the submodule code, so let't not hard code it yet
one more time.

Cheers,

Philippe.


[1] https://github.blog/2015-07-29-git-2-5-including-multiple-worktrees-and-triangular-workflows/#improved-support-for-triangular-workflows
[2] http://git-scm.com/docs/git-remote#Documentation/git-remote.txt-emset-headem
[3] https://lore.kernel.org/git/D2ED942B-9397-472A-B017-190016531547@gmail.com/
