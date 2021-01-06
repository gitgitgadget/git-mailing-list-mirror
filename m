Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC69C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B5123131
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbhAFTat (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 14:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbhAFTat (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 14:30:49 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B9AC061575
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 11:30:08 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c14so2846324qtn.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 11:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OngFq+kxKM3tALaj3bdIMLqrmy/9Hpu8eGw75Kn9K7E=;
        b=IKf/HiyIzUro7/+gp60W2L6a8k/16IIRjfnAn6PwkJjECIwFjSlY78QRn+w8paAm+H
         hKpRWRce6p0EvA80PbtUUARm4V4vaoFe6hPtsvFVtUSZFbFxqxRC2ivlIWoX8yxwkHCD
         UnLo5Cm6xMq/vPV9MsuU+Jc2IvLhGbFR/5pG3Qq5rp37HJNuviizHaiplpBd0wZ05dFq
         0mqlIVxrN+QNXkIFd2IziqGLMpcJc1RJlw3zj30b4oub8mmSRnxaYCMP8+1UjPrYcZhz
         ab3lJ3YuNbN1ZYwFHwH7JRO36ULiQxVlW/5aGSbeV3meFMeXe9RLQk7qpKf1GpV9e92+
         Vq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OngFq+kxKM3tALaj3bdIMLqrmy/9Hpu8eGw75Kn9K7E=;
        b=mQBW6FaI/rrrwk+ZjVY1waZldfT8xNLZMJ1fZWXaaHKSU3FLC/Gh8W6pTOV2Ar3/VO
         XRCX+1O5cYngZOgVU594SCLDCdwp0zxIvtF6BdH4H5xTbv0olhjj+VO2hfGuw3oue2nL
         D3MWna2TVl4BjA2CcMVoKyGiOYGCPelTZPqPGDAIOP8k7xPh75z70kWRKxLSuK3CpVPD
         4aGVWrVKk33OeGhW7lT5YO3uPDYoLfkG3vGrJ5OWTmtjzyOhOEdmqmRq1Va986k/Jxh8
         HQBMPjG7qYA/n6xFs13bwEch0HMfPc5pqmcHoLRqNYRHw1SUdDmR7LddbGWlAPbbc4UR
         ppyA==
X-Gm-Message-State: AOAM530VnvyPoISXR3KRZc0u/G2jz3IT7mc6h1v8R2aCR8IUe4HVbEKm
        YK8IPCzK0lWwyqB4A++5E84=
X-Google-Smtp-Source: ABdhPJxA3XI/TyPE+LyVk8Tn4XiV/Y/4Y2rzbYdMN7igGpbQOLHQ89dQ7EEWbT54KMGtyCEp7hehkw==
X-Received: by 2002:a05:622a:34d:: with SMTP id r13mr5532426qtw.93.1609961407935;
        Wed, 06 Jan 2021 11:30:07 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id h1sm1625545qtr.1.2021.01.06.11.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 11:30:07 -0800 (PST)
Subject: Re: [Bug] 'git submodule update --single-branch' still fetching
 master
To:     - - <sven@nichtgerade.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <898607890.216528.1609892347792@email.ionos.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <05fafba4-6415-7b61-92ae-112bdc8fd7be@gmail.com>
Date:   Wed, 6 Jan 2021 14:30:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <898607890.216528.1609892347792@email.ionos.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sven,

Le 2021-01-05 à 19:19, - - a écrit :
> Hello,
> 
> I encountered today some problems while trying to track a single branch with 'git submodule add' and 'git submodule update'. Please find my bug report below.
> Any help would be very welcome! :)
> 
> Kind regards,
> Sven Krummen
> 
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> I've got two repositories, 'project' and 'lib', and I want to add 'lib' into 'project' as a git submodule.
> The 'lib' repository contains the 'master' branch, which is quite heavy-weighted (~900MB), and a 'light' branch (~10MB) with a mostly unrelated history to 'master'. The 'master' branch is the default branch.
> Similar to using 'git clone -b light --single-branch path/to/lib' I want to track only the 'light' branch as a submodule to reduce traffic on our build server.

Thanks for a nice scenario description. Just a note on wording though (to make sure
we are on the same page): you can't have a submodule "track" a branch, at least
not in the sense that the submodule is always "checked out" on a branch, and the superproject
knows that the submodule should always be "on that branch"; that's not how submodules work.
As specified in [1], the config `submodule.<name>.branch` is only ever used by
`git submodule update --remote`, i.e. the superproject itself only records at which *commit* the
submodule is at.

> 
> To add the submodule to 'project' I tried to run:
> (a) 'git submodule add -b light path/to/lib'
> (b) 'git submodule add -b light --single-branch path/to/lib'
> But git was always fetching the whole 'master' branch of 'lib' before switching to 'light'.

That's not a bug (in my opinion) since it's in a line with the documentation [1].
There is no way at the moment for the initial `git submodule add` to pass
'--single-branch' and '--branch' to the underlying `git clone`.

> 
> After commiting & pushing everything to 'project''s remote, I started over with a fresh clone of 'project' to test whether 'git submodule update' would only fetch the 'light' branch (typical use-case for our build jobs):
> (c) 'git clone path/to/project && cd project'
> (d) 'git submodule update --init --remote --single-branch lib'
> But again, git was fetching the whole 'master' branch of 'lib' before switching to 'light'. This behaviour seems to be independent of the used options of 'git submodule update'.
> 
  
I can partly reproduce that behaviour. The following script creates "lib" with two branches,
master and light, that *do not* share any history.

~~~
#!/bin/bash

TEST_AUTHOR_LOCALNAME=author
TEST_AUTHOR_DOMAIN=example.com
GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
GIT_AUTHOR_NAME='A U Thor'
GIT_AUTHOR_DATE='1112354055 +0200'
TEST_COMMITTER_LOCALNAME=committer
TEST_COMMITTER_DOMAIN=example.com
GIT_COMMITTER_EMAIL=${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
GIT_COMMITTER_NAME='C O Mitter'
GIT_COMMITTER_DATE='1112354055 +0200'
export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
export GIT_COMMITTER_DATE GIT_AUTHOR_DATE

mkdir test
cd test

rm -rf project lib clone

git init lib && cd lib
echo "content">file
git add file
git commit -m "initial on master in lib"
git checkout --orphan light
echo "content">file
git add file
git commit -m "initial on light in lib"
# Switch HEAD back to master
git checkout master
cd ../

git init project && cd project
echo "content">file
git add file
git commit -m "initial in proj"
git submodule add -b light ../lib
git commit -m "add lib to project"
cd ../

git clone project clone && cd clone
echo 'RUNNING: git submodule update --init --remote --single-branch'
# This fails
git submodule update --init --remote --single-branch
echo 'RUNNING: ls -al lib'
ls -al lib
echo 'RUNNING: git -C lib ls-files -s'
git -C lib ls-files -s
echo 'RUNNING: git -C lib branch --all'
git -C lib branch --all
echo 'RUNNING: git -C lib config --get remote.origin.fetch'
git -C lib config --get remote.origin.fetch
# Try to update again
echo 'RUNNING: git submodule update'
GIT_TRACE2=1 git submodule update 2> >(grep -E 'start git fetch|^From|^ \*' )
~~~

The output should end with:

RUNNING: git submodule update --init --remote --single-branch
Submodule 'lib' (/Users/Philippe/Code/GIT-devel/test/lib) registered for path 'lib'
Cloning into '/Users/Philippe/Code/GIT-devel/test/clone/lib'...
done.
fatal: Needed a single revision
Unable to find current origin/light revision in submodule path 'lib'
RUNNING: ls -al lib
total 8
drwxr-xr-x  3 Philippe  staff  102 Jan  6 14:03 .
drwxr-xr-x  6 Philippe  staff  204 Jan  6 14:03 ..
-rw-r--r--  1 Philippe  staff   28 Jan  6 14:03 .git
RUNNING: git -C lib ls-files -s
RUNNING: git -C lib branch --all
* master
   remotes/origin/HEAD -> origin/master
   remotes/origin/master
RUNNING: git -C lib config --get remote.origin.fetch
+refs/heads/master:refs/remotes/origin/master
RUNNING: git submodule update
14:14:09.745288 common-main.c:49                  start git fetch
14:14:09.892463 common-main.c:49                  start git fetch origin cc09362ae7314174785faed3e5ee72a8e2db5460
 From /Users/Philippe/Code/GIT-devel/test/lib
  * branch            cc09362ae7314174785faed3e5ee72a8e2db5460 -> FETCH_HEAD
Submodule path 'lib': checked out 'cc09362ae7314174785faed3e5ee72a8e2db5460'

You can see that the first 'git submodule update --init --remote --single-branch'
fails. 'ls' and 'ls-files' tell us that the submodule is not checked out,
and that the submodule index is empty.
'git branch' and 'git config' then reveal that indeed only the 'master' branch exists
in the submodule, so '--single-branch' was passed correctly but not the branch itself.
Afterwards, issuing 'git submodule update' a second time will issue a simple 'git fetch',
which will not work because of the single-branch refspec, then it will try fetching
the commit by its hash, which works, and then it will checkout that commit.

Looking at commit 132f600b06 (clone: pass --single-branch during,
  --recurse-submodules, 2020-02-20), which introduced the '--single-branch'
option for 'git submodule update', it seems that what we have at the moment
is partly a documentation bug, i.e. the doc should say
"Clone only the history leading up to the remote HEAD during update",
and not mention '--branch' at all. I'm CC-ing Emily and Peff who were involved
in that series. Looking at the mailing list thread where
this feature was discussed [2], it seems that mentioning 'branch' in the description
of 'single-branch' was just a leftover from v1 of the series that was forgotten
in later iterations.

Also,looking at the code, the '--remote' option has no effect at all for the initial clone
of the submodule. It is only taken into account after the initial clone.
I think it would make sense for it to also influence the initial
clone, so that it would behave as you expect, i.e. the code looks at the branch
in '.gitmodules' and this branch is passed to the underlying 'git clone' if '--single-branch'
was passed to 'git submodule update'.


> What did you expect to happen? (Expected behavior)
> (a) or (b) To create a submodule which is tracking the 'light' branch of 'lib' and to fetch *only* this branch.

That would be a diffenret feature request, and I think it does make sense
for (b) to work. I don't think that '--branch' should automatically
imply '--single-branch' though (i.e. I don't think (a) should change
behaviour).

> (d) To fetch and checkout *only* the 'light' branch of 'lib'.
> 
> 
> What happened instead? (Actual behavior)
> (a) Fetching 'master' (or the full 'lib' repo?), then checking out the 'light' branch.

Yes, this does a plain 'git clone' so all branches are fetched.

> (b) Error as option '--single-branch' is not supported for 'git submodule add'.
> (d) Fetching 'master' (or the full 'lib' repo?), then checking out the 'light' branch.

As my script above shows, this does fetch only the 'master' branch, and then *if* we issue
a second 'git submodule update' it then fetches the required commmit by hash and checks it out.
It would be nice if you could send a reproducer (i.e. a complete script like the above) that
shows exactly the behaviour you are seeing, if indeed in your scenario it really checks out
the 'light' branch. I'm not sure I understand how that could happen...

> 
> 
> What's different between what you expected and what actually happened?
> As the 'master' branch of 'lib' is quite heavy-weighted, I do not want to fetch 'master' at all. By using the option '-b light' to specify which branch shall be tracked, there is no need to fetch other branches besides 'light'. I'm not sure if it is really necessary for 'git submodule add' to fetch anything, as this could also be done by a subsequent 'git submodule update'.

In the past, 'git submodule add' used to not clone the submodule at all,
but this was deemed not very useful so now it does 'git clone' underneath.


Hope that helps,

Philippe.

[1] https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt--bltbranchgt
[2] https://lore.kernel.org/git/20200108231900.192476-1-emilyshaffer@google.com/t/#u
