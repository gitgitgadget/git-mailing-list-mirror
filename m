Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2427AC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 17:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE7561400
	for <git@archiver.kernel.org>; Mon, 24 May 2021 17:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhEXRsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 13:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhEXRso (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 13:48:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72554C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 10:47:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x7so9787131wrt.12
        for <git@vger.kernel.org>; Mon, 24 May 2021 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PYNnIFlpdMYyDOkM+dtw4fikU3cdgXgGStoaLsRD834=;
        b=JXO7hGq/TnD0QBfSaK1dUOq0PPME4KPjkzmn3ONRJ5zdakjGxL4ubwmADM2tMo9L6P
         MVvdumOm76JARvW3I5aWNf4sixnmJxTCK8JSTk73TUh+z1oKMb/4lTj8KmpbYz/HjF2d
         yqx4DcpJhoRFawsXsjbwifaxozMhgvveUI6yM68ijmRgoV94FqjUXZ1xNLFxgxW40jw0
         p4Gb4XfV4M536GRvTn0NWnFsFce0xOoAqKuUKlRmPqgw54TjWcahr85WAtwZwfI78lef
         jX+DWTe9I7qOnstWNTtMOCXvuHVsC2facuwg1F9t1UjV/GallUkMK8zfwRpauu0RCFBN
         e/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PYNnIFlpdMYyDOkM+dtw4fikU3cdgXgGStoaLsRD834=;
        b=G2Y68J1Oi4EhjJsHb6Clnllu1MknaFGdWc7NDeuwpdTFBL0nApy8JOllVKscPU+WQL
         ZGIGgVR1TbiuMNn8oUxIXoAxJWyWiZUAh+5Yic2rg+hk21b+/h4DjYUyC2Tcx+h+NNoi
         R4svv94+p+vuozid687VGLyN/EUPnLHxHuXLyuuK/3QTHlmEbkSQwFrWPaCBHi/rXgr9
         bWXg1n1ip2Aq9K+9gdit9gOTUENmmQNDoktty1zGF19apNUDy1dSiAlYXXfBtNHrw3Ql
         H44Ss+dXXj7gB6i7+O21l7sUfGrR1znt3muWjOqoPHi+y6kbaTgmSPm4JvEhhQQ0NGfi
         vb7g==
X-Gm-Message-State: AOAM530JUArVIaSvvMAVncq5TkZdaKGA7MHUbS2aRsnpABgRpiC82fq1
        aJE+ONl/MzpD2N7cM+mPY2JqksLwNmM=
X-Google-Smtp-Source: ABdhPJxhIVX0Iq+C0TZbgKKpuy1g6DnHgXXYtJTu9OmkqWWkIg8AOnY+iEnN13wiO/A0HlN39DwGBA==
X-Received: by 2002:a5d:4151:: with SMTP id c17mr23536200wrq.262.1621878434579;
        Mon, 24 May 2021 10:47:14 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.176.212])
        by smtp.gmail.com with ESMTPSA id c6sm6192917wrt.20.2021.05.24.10.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 10:47:13 -0700 (PDT)
Subject: Re: fast forward merge overwriting my code
To:     Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <009aa860-7ffa-7105-b2fd-cf5996639a3a@gmail.com>
Date:   Mon, 24 May 2021 19:47:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 24/05/2021 08:13, Andre Ulrich wrote:
> 
> So this is how we proceed:
> - my prof has a repo on GitHub
> - I have forked the repo
> - I have cloned the forked repo
> - I have created a branch 'update' in my local clone
> - I edit a notebook on the branch 'update' and commit
> - I push 'update' to my forked repo on GitHub
> - I create a merge request
> - my prof reviews the changes and accepts them (if I have done 
>   acceptable work)
> 
> So the last point is where we still want to do some fine tuning. 
> Right now this looks about: my prof fetches my edits and locally 
> checks out a branch to compare the changes with git diff. But in this 
> diff view you can't edit the files. So you have to separately open up 
> another window to edit the changes (lets say my prof only wants to 
> keep some of my changes, but not all).

I think that last point highlights the issue you guys are having - 
using `merge` for doing both (1) actual merge, but also (2) review and 
edit at the same time, which is wrong (or very unconventional, to say 
the least).

In ideal case (meaning no conflicts, no matter if 3-way merge or a 
fast-forward one), merge should accept all the changes being merged 
in from the side branch and incorporate them into the main branch. 

From this basic and the most common scenario alone it is visible that 
merge should not "keep some changes, but not all" - the very point of 
a merge is to (try to) keep _all the changes_, period.

Now, as for the "try to" part - in some cases not all changes can be 
kept as they are, like when both branches changed same files and same 
lines (or close to), so that's when Git hands over the resolution to 
the user, to determine what is the desired outcome of a conflicting 
merge.

Still, even in this case, the final outcome should be considered a 
sum of all the changes, even though some might have been altered or 
rearranged in order to better work with each other (as different 
branches might have done the same thing in a different way).

In any case, it should not be up to the merge (process nor commit) to 
discard (nor add!) some of the non-conflicting changes you have made on 
your 'update' branch - it is possible to do (something usually called 
an "evil merge", and for a reason), yet is not a good practice.

As an example, imagine you have commits 1, 2 and 3 on your 'update' 
branch, and upon merging your professor decides to accept changes 
from commit 2 only, completely discarding changes from commits 1 and 3. 
Your history will end up looking something like this:

(1) ---X-----------M 'master'
        \         /
         1---2---3 'update'

... where M is the merge commit, merging branch 'update' into 'master'. 
As it is, it's reasonable to expect of M to contain all the changes 
brought in by 1, 2 and 3 - yet it is not the case, which could be 
rather confusing (on later history review).

What would be a more common/usual scenario is, after trying a local 
merge M and seeing some changes should not be accepted (like commits 
1 and 3), have your professor communicate the problem with you so you 
can fix the issues yourself, inside 'update' branch, and iteratively 
repeat this process as long as 'update' branch is not "perfect" - at 
which point it can be accepted _as a whole_, that is.

You professor should not accept to merge your changes as long as they 
are not all correct, and he specifically should not be using the 
merge to correct the issues himself.

Depending on your preference, he _could_ be doing the changes himself, 
too - but again doing so through standalone commits (on your 'update' 
branch, for example), _not_ through a merge commit.

Based on example (1) above, the finally merged changes history could 
instead look like this:

(2) ---X-------------------M1 'master'
        \                 /
         1---2---3---4---5 'update'

..., where commits 4 and 5 are fixes made on 'update' after your 
professor's comments on commits 1, 2 and 3, and M1 is the merge which 
finally accepts all the changes from 'update'.

Alternatively, if you use rebase, you can alter problematic commits 1 
and 3 directly instead, so the history would look something like this:

(3) ---X-----------M2 'master'
        \         /
         1'--2'--3' 'update'

..., where original commits 1 and 3 are changed in order to be 
acceptable for the merge, becoming commits 1' and 3', while commit 2' 
would stay the same as original commit 2. Again, merge commit M2 
accepts all the changes as they now are (all correct).

Also, if commits 1 and 3 are completely wrong and not required in the 
first place, yet another alternative (using rebase) would be to drop 
them altogether, ending up with a history like this:

(4) ---X----M3 'master'
        \  /
         2" 'update'

..., where commit 2" would be exactly the same as original commit 2, 
and commits 1 and 3 are dropped from the history completely - and 
transparently, _not_ using the merge to do so, as in original example (1)
(and your explained scenario).

I hope these examples somewhat help, the main point remaining that 
merge should not be used to discard/disapprove certain (especially 
non-conflicting) changes, but only to finally accept/approve _all_ 
the changes, possibly modified in the meantime as a result of an 
iterative review and additional work.

Note that there's nothing wrong in having your professor do his own 
local merges as part of this review process, but those should be only 
temporary, to be discarded and not accepted until everything can be 
merged (and accepted) as-is.

Regards, Buga
