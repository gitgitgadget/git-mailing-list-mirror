Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF158C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 11:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbiHILGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 07:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbiHILGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 07:06:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C6F20F5F
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 04:06:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z19so11032351plb.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=8MnY2vCC1+3F6tJ4iiAboyj7bvfn6EB6Bsgpl3RZ7iE=;
        b=FC/VQcssrcyGeOARCvCwbPadMtydt5/e/LAM05Y8EOjvIJBpo5NwIPQH8E9roR12UD
         I1kjOieWJfyLRqWHaACSCCb3UJ0go6IvseZ1i4PM0llSa6mDmG83wyiu3GrQwqtZv1/u
         1Lm1HlYxIXMeyualRszX/pjvrTJ6UACk7SW+bObgLi71Yen4/Sr8muLOczXKXvN+EKlS
         rt3L70AME3z3qtUdWyql0rrGiPkmpP7IrDGAld3sYk/++BraY8jExjkiU6N4VsiMDzc5
         yAsABK+wc5zveO9iQNTyS3DHAzeqFJ0XJG3ZQ4YGEZrf7tRmoMGVH/G6bNcJjm6lEzbn
         tgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8MnY2vCC1+3F6tJ4iiAboyj7bvfn6EB6Bsgpl3RZ7iE=;
        b=odiw7Z1FB6ffVM/UBCDOonQivHk4An3F3fRAogBHMw9PuLWdhZQaKwBHsww5NMirwZ
         LEy7uvQrTZZldgIkY/mAZHNqk56f/SrpVaCUkVfQsh181T903JGw1ZKy7D/WQ0UJ80sD
         Sv/cQriThjP0Aw6+sJK0MX7air/72W+DGC83EthhJoPkyXbuF11CMU7SC6MKENWI3k7B
         jVlH/qlXccAkR27t3Hmvw1jPpg82HEMgIgbwz6aYhHVwV/zB4/+Rii1pRr9KVEQYDnAa
         V9n7VVRqWUBQJJbFQDum04GsMGYMhNGuZK4U5xv2VzEyB5F3+U/p+I+AC1hjLfYOKiEc
         Wq6A==
X-Gm-Message-State: ACgBeo0KdVTs3JcwghwFFcUSzEgeg0o5g2wkiqMY5a7+YRigqvP/Mn+P
        vqsepYCsfI2MN8Xfb0YNMCicnn68Ia/yIFNq
X-Google-Smtp-Source: AA6agR4oVVBgZ5Cuzmw/0nr08pXTxXZ4ZpIQaeElIXzrYZEfE+D11+tZ3RM3aWriZvZHIfKONPt/RA==
X-Received: by 2002:a17:90b:3a91:b0:1f5:2048:cb9f with SMTP id om17-20020a17090b3a9100b001f52048cb9fmr33415038pjb.174.1660043174008;
        Tue, 09 Aug 2022 04:06:14 -0700 (PDT)
Received: from cosmos.melik.windwireless.net (melik.windwireless.net. [206.63.237.146])
        by smtp.gmail.com with ESMTPSA id cp2-20020a170902e78200b001690d398401sm10506369plb.88.2022.08.09.04.06.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 04:06:12 -0700 (PDT)
From:   David Chmelik <davidnchmelik@gmail.com>
Subject: Re: 'git clone,' build makes user non-writable files (should be
 option keep user-writable)
To:     git-l <git@vger.kernel.org>
References: <822787da-bc26-0d72-a5c4-808a3d10126e@gmail.com>
 <YtPtQ6qsIviyTBF2@zbox.drbeat.li>
 <158251f2-9fa4-45b7-4c24-907c94602b6e@gmail.com>
 <CAPx1Gvc6ci1CjhL-zjwqkR=4o2yQTrT0V_Hb9bUBNuaBn47M8A@mail.gmail.com>
 <ccbc1e81-b406-9e73-7aa5-956ffae7074b@gmail.com>
 <CAPx1GvceFLRL_O5zYW98tPdNV9S_Y=fChJafsq+HGkEYixKsZA@mail.gmail.com>
Message-ID: <b47b88fb-89bd-732c-3aeb-75a474a7fdb5@gmail.com>
Date:   Tue, 9 Aug 2022 04:05:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAPx1GvceFLRL_O5zYW98tPdNV9S_Y=fChJafsq+HGkEYixKsZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/22/22 8:54 PM, Chris Torek wrote:
> On Fri, Jul 22, 2022 at 5:29 PM David Chmelik<davidnchmelik@gmail.com> 
> wrote:
>> On 7/22/22 10:40 AM, Chris Torek wrote:
>>> All true. But Git has no control over, or affect on these: Git does
>>> not attempt to affect ownership or permission of any build products
>>> at all. Git only attempts to affect the execute permission of
>>> specific files as directed by the committed file mode (and provided
>>> `core.filemode` is enabled).
>> Not even projects' .git* subdirectories? They typically are/become
>> user-unwritable though deletable with several/many confirmations so I
>> usually sudo (recommended against).
> Ah, I thought you were (and I definitely was) talking only about the
> *build products*. The stuff inside `.git` itself: some of that, Git 
> does set
> to unwritable.
Initially wasn't; don't know why took three replies to clear up 
(initially clearly specified non-root usage which others ignored and 
mentioned/focused unrelated root topic).

> There is no need to use `sudo` though: a simple
> "rm -rf .git" will blow away the Git repository itself. However:
Starts with 'rm -rf .' which is bad and worse is one key away from 'rm 
-rf /': anyone who accidentally pressed <ENTER> after either what I put 
in quotation marks (I did both as root on my personal files and entire 
PC in 1990s... have you ever?  It was normal to use root account then 
rather than non-UNIX-like OS that lock it) wants to never again so 
typically uses alias which done with sudo (still considered worst last 
resort) still has fewer confirmations (one rather than every single 
user-unwritable file). I can't believe I'm asking to encourage avoid 'rm 
-rf', on mailing list of a tool on UNIX/GNU/Linux (POSIX-based) 
operating systems, original which people started avoiding 'rm -rf' in 
1970s, but now people say just do it!

>> I'd rather opt-out of .git* subdirectories for every clone.
> In that case, *don't run `git clone in the first place*. The purpose of
> `git clone` is to get you the entire repository. If you want a single 
> working
> tree, use `git archive` to make an archive from the commit you want,
> and extract that archive to get the tree you want, without getting all
> the *other* revisions.
Seems much more complicated (and less-documented) and most popular git 
sites (though #1 isn't Free/Libre/Opensource Software (FLS, OSS, FOSS, 
FLOSS) so rightly condemned) disallow archive.  Though I my shell alias 
rewrites 'git clone' to then 'chmod u+w .git*' or alternatively 'find . 
-iname .git* -perm u-w -exec chmod u+w {} \+' and usually before 
archiving, 'sudo rm -rf .git*', aliases are sometimes unavailable and 
now a few projects won't compile without such directories.  I know you 
can't control popular sites' mistakes (nor projects never doing 
normally-numbered releases) and they should be irrelevant: unfortunately 
most projects use most popular/broken sites, sadly including core 
component projects for some/most/all POSIX-based OSs, so couldn't syntax 
be easier/detailed so testers can opt-out user-unwritables (for 
thousands/millions major cases archive disallowed)?
         Apparently many/all version control systems (VCS) make such 
(initially) user-unwritables so may consider this request odd but for 
tester-only people, it's not odd to dislike such we don't use (unless 
ever changes... I've used VCS last  11+ years (likely since late 1990s 
or early '0s) and don't plan to use .git* & etc. decades into 
foreseeable future but in very-slight chance I do presumably such 
files/directories would be useful... for now I've spent hours/days over 
decades in frustration: 11+ years ago when projects had a minor bug said 
'try from VCS (nightly)' I was glad but led to nightly/critical bugs and 
user-unwritables... VCS are a godsend for decreasing years update waits 
but (as with most science/technology) have advantages & disadvantages...)
--D

