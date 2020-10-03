Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3727C4363C
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 00:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E73620663
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 00:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CksxAA9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbgJCA4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 20:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJCA4a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 20:56:30 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FA3C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 17:56:30 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x201so4865298qkb.11
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 17:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YPB054RKsfhKNvlr++NRDGscBG9UC1uw0JY+sVRufs4=;
        b=CksxAA9cAC5VvrVMHcw+DBWkT2nIjR0PmE1BKLyHVvWGW3PY+eJe0DODkSy1gicYwN
         g5JtRzST6iwQ5FVctBoCHLMdMPKaPN3InEB7jgdojkDeZ4vMnC6K4zq0uY+/m8oLQSAq
         yRvy6MWqL8PncBM0Zt1rSUpQNwJn86CJHhJG11ZkuEoI3vRKLOtWDO1eB62diEhUCQok
         5fTH3I3Uki2oVTebMmbcOtjtN3Vo9ghPqce7JLaPADtgbiJ5JvbOACOI60WxgIjhKxRv
         LVLpxMVHWDvPN9vsMkLWOmNSEebiZqCDC28Uhs1I3qCQvQljFy6YhixRyAYh+Nty7wfW
         LMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YPB054RKsfhKNvlr++NRDGscBG9UC1uw0JY+sVRufs4=;
        b=nbkzxBav4JTu745eOQ6Fm0RryiYhYVCaUx5gEYp0eLBbZ6EPbKdqe/UndMHG82jhRZ
         vCqSzUugQ4FmMAsvWln0aw8c7nywew4b/NlhGChebB9Z2VCXZjVHk4bxUVpYFFQY6EK4
         a20b55J247FZDxHtSbr5/sszyiV8b9AQYGssDGolUhMdXgph21wdD8SPzBRnUJQpQuyA
         Fo8kHLVARlyUepjqqHhncyjudSYLnQKwH6/MV970PWm1PE/1S8msNGuAknOkk3Re48JM
         Xw3JDfY47T725SppjuJa4iRPzMGOauCpdytve6Wv9XsapD3asD7XbaLtDw9RapedoPj6
         e8hA==
X-Gm-Message-State: AOAM532621UYIlPby6OAatV7DdcapUK8leELrk/I43Zo5aFFF5kP6eL9
        pm2RWbU1X5//ln9htAGZT6lsKFfq+hT2p9Lz
X-Google-Smtp-Source: ABdhPJycLt6YmSUg+zckL+kuj2PgjVLSz3xqooCSgkDZZCR6s9tNFs9tbbCAkDXWCyzD+apj+stgmQ==
X-Received: by 2002:a37:a2cc:: with SMTP id l195mr4216755qke.324.1601686588977;
        Fri, 02 Oct 2020 17:56:28 -0700 (PDT)
Received: from [192.168.0.108] (d-65-175-178-104.nh.cpe.atlanticbb.net. [65.175.178.104])
        by smtp.gmail.com with ESMTPSA id t2sm1953227qti.25.2020.10.02.17.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 17:56:28 -0700 (PDT)
Subject: Re: git blame --ignore-rev does not work
To:     Harrison McCullough <mccullough.harrison@gmail.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <CAHLeu+x-z4ntmBezcVUWssZrCm03Md6ZR8-ZQmjkeB5YT89caQ@mail.gmail.com>
 <d805f025-fbfb-0249-a50c-ff857dc2e29d@web.de>
 <3e9b34f9-f61e-f3f1-45a3-6352641e434a@google.com>
 <CAHLeu+zSaTwPEDQ=CuFua0NdEppM+OjFaREU+Yiy9udK1OUK4w@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <c77eb54a-ecfd-508b-ed6a-030e66d8e257@google.com>
Date:   Fri, 2 Oct 2020 20:56:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHLeu+zSaTwPEDQ=CuFua0NdEppM+OjFaREU+Yiy9udK1OUK4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 10/2/20 6:52 PM, Harrison McCullough wrote:
> Thank you for your feedback! I do have some more information to
> provide that is confusing.
> 
> I tried running `git blame -w`, and this correctly ignores the
> revision I tried to ignore with `--ignore-rev`, etc. So it appears
> that the algorithm to attribute lines to commits is capable of
> ignoring the commit in question (in the lines I've inspected) but it's
> not doing it when I use the "ignore-rev" capability—only the "ignore
> whitespace changes" capability.
> 
> Does anyone have any ideas about why that may be the case? Does the
> "ignore whitespace" and "ignore commit" algorithms use different
> logic? I would have assumed that they shared most of the logic.

Yeah, the logic is a little different.  IIRC, the "whitespace ignore" 
affects individual diff_hunks that are generated during the blame 
process, generated by calling into xdiff.  That's when blame tries and 
figure out what lines change from target/child to parent.  So the "blame 
chunk" that gets analyzed is different, depending on whitespace-ignore 
or not.

The "blame ignore" logic happens after that, and it operates on the 
output of xdiff.  If the 'target' is one of the ignored commits, it 
looks at those chunks produced by xdiff (differences from target commit 
to parent) and for each line in the target commit, attempts to figure 
out what line in the parent to match it to.

The matching process is imperfect.  It uses a fingerprinting algorithm 
to find a likely candidate line in the parent's diff hunk.  The 
fingerprinting is based on matching the two-character pairs in each 
string.  (I didn't write the fingerprinting, btw).  It does some ranking 
of the lines, picks the best one, and a few other 'search quality' 
things.  etc.  If it fails to find a matching line in the hunk, it'll do 
a simple O(n) scan in the entire file.  But when it looks in the entire 
file, it has a threshold of similarity, so you don't match arbitrary 
things.  (Threshold is 10 two-letter pairs, I think).

Anyway, my guess is that when you use the ignore-whitespace option, it 
changes the diff hunks enough that blame_chunk() gives a different 
result.  This could be because there are larger diff hunks (more search 
space for the "good" initial scan).  Or maybe because you have a 
different set of two-character pairs or something.

> I would love to provide a concrete example, but the only time I've
> been able to reproduce this is with proprietary code. I'll try to
> create a new repository with a similar commit and see if I can ignore
> it there.

I'd be glad to take a look, though I don't know how fixable it is. 
My guess is you're hitting right on the edge of the "find a similar line 
inside a hunk" and "couldn't find a good change in the entire file" 
threshold, and any change would just be tuning it for your repo.  But 
maybe not, and I'd like for --ignore-rev to work for you.

> For the information of those interested, the commit I'm trying to
> ignore is a "reformat the world" commit. We introduced the tool
> "astyle" into our codebase, and as part of that effort I ran astyle
> over our entire codebase.

Same situation for me - reformatted a lot of code and didn't want to 
break blame.  =)  That was the original motivation.  I've actually used 
it a lot for other things now, such as finding out which commit changed 
a line in a particular way.  git blame, look around.  git show XXX, 
realize i want and older commit, git blame --ignore-rev XXX, etc.

> Is it possible that the commit isn't being ignored because it's too
> big? It did change over 1300 files....

That should be OK.  The algorithm doesn't care about the other files in 
the commit - only the one that you are blaming.

Thanks,

Barret


> 
> On Fri, Oct 2, 2020 at 4:44 PM Barret Rhoden <brho@google.com> wrote:
>>
>> Hi -
>>
>> On 10/2/20 5:40 PM, René Scharfe wrote:
>> [snip]
>>> I don't know if these revisions are not ignored due to bugs or because
>>> the feature just isn't strong enough, yet, but I would expect your
>>> particular case to be represented by at least one of these...
>>
>> Correct.
>>
>> When skipping a revision, the algorithm attempts to find another
>> revision that could be responsible for the change.  But it might not be
>> able to find anything.  Consider a commit that just adds a few lines to
>> a file with only 'foo' and 'bar':
>>
>> commit: "Adding Lines"
>> -------------
>>    foo
>> +No commit
>> +ever touched
>> +these lines
>>    bar
>>
>> If we ignored that revision, which commit do we assign those lines to?
>> If they were "similar" to the existing lines, then the algorithm might
>> match.  But in general, we can't find 'correct' (as defined by a user)
>> matches for arbitrary changes.
>>
>> I usually run git with these settings:
>>
>> [blame]
>>           ignorerevsfile = .git-blame-ignore-revs
>>           markIgnoredLines = true
>>           markUnblamableLines = true
>>
>> Which points out when --ignore-revs is doing something.
>>
>> Thanks,
>>
>> Barret
>>
>>
> 
> 

