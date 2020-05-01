Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B78DC4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F1E20857
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ur4SiQ6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgEAPor (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEAPoq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:44:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFCCC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:44:46 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b1so8215573qtt.1
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zSGLlUOxnGeEu3QhI5oUHrfRboZC09LfXUp6WveUhRg=;
        b=ur4SiQ6wGOuVeNaYOCuikYNKedBkbTg76QM9kTIwuwkshmzj8xcWwISqx4EnurAIXG
         DfoPifaSOQ5MZzQyl47WzJ7Y1h7uJtwbkNtkjVQ+zJR9VfMk+s6pUEWpT6B4R8yHp1O/
         VMKFQE2N82dlAp5mO4T+w+y7gEd/2LdmVDA2p1k2oJjjYEY/M8GecaWwpPtYgzhSVOLL
         xqO3tX/jGh5tPvDbfDn4z3ASlVXTYYDSX+A1FFclxFnGtmRJXJ7Uxv/T+0ppL2wpPyCY
         tt4a0UJudIXm7x+I2Q5F9VPt7K6aFi6K4i0XFs5/SqJH51cCFiKg3NyBNHqoxcOpTyS1
         B4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zSGLlUOxnGeEu3QhI5oUHrfRboZC09LfXUp6WveUhRg=;
        b=pyiv9i/sF71TjI4Diad1V0m4vG9aMW6Bz4haINjuC86uNJiGTDQPktNSXJn8E+uo8o
         H1Mt1gxd5f7yS1dxN+8xg9q0ALJB0lH16gNdJAKpjVOgQQnEQBIOWUywfhfKDn8xNCTs
         9WqV1SFipuyj/kuEKRu29S+SuzoTAkTgJjfIRLtBPuZ7O+PVYqkaFkzyCAvVRXXDJ1HG
         F864Thrks7GiSO3L7Dpcsj9DB+gB70CUooWZhq396sfloWXuk59e7IPFuZcahebaYM2k
         j4T8HZ3mOLh1GGa4TrlooBXkpkRXVPLjz2Qqd1YgjA3jA7MikGg9s5a6xDzg+EjT32fJ
         ChKQ==
X-Gm-Message-State: AGi0PuZoX7eNFXzHJFcIbb3pE0IpIX7yuxtYorG8CC49TsjtNRUC0WU/
        yyJBU+6shDsg28YyQRhBQRaACUZEa7Q=
X-Google-Smtp-Source: APiQypIqYigGAsPLYUTuB8yH0uoXOoyUj0IuPm3nlkoX4OVHw0XVakYTy9ibFbV1PJWuJF02K7b6Sw==
X-Received: by 2002:aed:3fab:: with SMTP id s40mr4581781qth.140.1588347885394;
        Fri, 01 May 2020 08:44:45 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 10sm3251613qtp.4.2020.05.01.08.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 08:44:44 -0700 (PDT)
Subject: Re: [PATCH v2] Teach git-rev-list --simplify-forks
To:     Antonio Russo <antonio.e.russo@gmail.com>,
        git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
 <08d5460b-d80b-28a3-19dd-d438afbdfba9@gmail.com>
 <2a668dd2-35c0-7510-fc4d-6c44e8407a07@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7d85d901-714e-12c7-69fd-38f49c686440@gmail.com>
Date:   Fri, 1 May 2020 11:44:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <2a668dd2-35c0-7510-fc4d-6c44e8407a07@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2020 10:13 AM, Antonio Russo wrote:
> On 4/29/20 7:12 AM, Derrick Stolee wrote:
>> On 4/29/2020 4:01 AM, Antonio Russo wrote:
>>> When used with --graph, instead of displaying the full graph, display a
>>> spanning subgraph produced by a depth-first search of the graph visiting
>>> parents from left to right.  Edges to already visited commits are
>>> discarded.  This process is repeated for every commit to be displayed.
>>>
>>> This is valuable to reduce visual clutter when there are many merges
>>> that were not rebased onto each other and the user is primarily
>>> interested in the state of the branch being merged into.
>>
>> My earlier comment to recommend how to fix the test failures intended
>> to demonstrate that this area of code requires a bit of precision. I
>> took some time to review this patch, but I find it needs some significant
>> updates.
>>
>> tl;dr: The way you manipulate the commit parents seems incorrect to me,
>> but perhaps there is enough prior art in the way we simplify parents to
>> make that acceptable. Someone else will need to chime in on that part.
> 
> First, thank you for taking the time look at this.  I understand your
> hesitation about the "amputation" of the history, but in some sense
> that's the point of this option.  I really want to be ignorant of the
> details of when the fork branched off.  I would like the reported
> history to be appear nearly equivalent to a rebase-and-fastforward only
> merge style, which results in a much simpler git log --graph.
> 
>> It may be possible to do this "drop edges" entirely inside of graph.c
>> (the graph rendering code) instead of revision.c, which would automatically
>> work with the performance gains from the newer topo-walk algorithm.
> 
> Non-local information about the commit graph needs to be used to do this
> amputation of the history.  We cannot know how many parents we want to
> display until we've completely explored all the parents of that node.
> Unfortunately, that means that the whole graph needs to be loaded, and I
> cannot really see how there would be any gain by doing this in graph.c.
> 
> Caveat: there are semi-streaming DFS implementations (i.e., O(n log n)
> space) that we might be able to use to get the first line out the door
> quicker. I would, however, like to leave that to another patch.
> 
> I will also add that, for the tests I've done, all performance penalties
> have been insignificant (less than ~5% for showing the first commit),
> while there are significant performance _improvements_, e.g., ~40% for
> displaying the full tree.
> 
> A notable exception is --all, which can be ~50x faster for the full
> output, but is often dramatically slower to show anything (i.e., the
> first line).
> 
>> There are enough deviations from code and test style that this will
>> need a significant revision regardless.
> 
> (Please see forthcoming revision 3).
> 
>>> This second revision of the patch sets revs->limited.  This forces the
>>> graph of commits to be loaded, and simplfiy_forks() therefore reliably
>>> traverses it.  This addresses the test failures mentioned before (see [1]).
>>
>> This will have a significant performance impact on the option, as you will
>> not see even the first result until the DFS has completed.
> 
> First of all, short of using some other, more sophisticated streaming
> version of this algorithm, the full DFS must finish before the first
> commit having two (or more) parents can be shown.
> 
> That said, the performance is not significantly affected:
> 
> I ran the following test (2.26.2, with my patch on top of it):
> (git lg = git log --graph --pretty=oneline)
> 
>  % time git lg -n1 --ignore-merge-bases e896a286df > /dev/null
>  0.73s user 0.02s system 99% cpu 0.746 total
> 
>  % time git lg -n1 e896a286df > /dev/null
>  0.72s user 0.01s system 99% cpu 0.731 total
> 
>  For the linux git repo:
> 
>  % time git lg -n1 --ignore-merge-bases v5.7-rc3 >/dev/null
>  9.25s user 0.39s system 99% cpu 9.646 total
> 
>  % time git lg -n1 v5.7-rc3 >/dev/null
>  9.02s user 0.35s system 99% cpu 9.378 total
> 
> So the performance seems basically unaffected for very limited graphs.
> It's also about 40% faster for complicated ones (as mentioned in my
> first email):
> 
>  % time git lg --ignore-merge-bases e870325ee8 > /dev/null
>  0.83s user 0.06s system 99% cpu 0.886 total
> 
>  % time git lg e870325ee8 > /dev/null
>  1.41s user 0.03s system 99% cpu 1.443 total
> 
>  For the linux git repo:
> 
>  % time git lg --ignore-merge-bases v5.7-rc3 >/dev/null
>  11.86s user 0.62s system 99% cpu 12.489 total
> 
>  % time git lg v5.7-rc3 >/dev/null
>  21.56s user 0.55s system 99% cpu 22.108 total

First, run `git commit-graph write --reachable` to create a commit-graph
file which has generation numbers. In this case, I get the following:

$ time git log --oneline --graph v5.7-rc3 >/dev/null

real    0m13.548s
user    0m13.348s
sys     0m0.200s

$ time git log --oneline --graph -n 1 v5.7-rc3 >/dev/null

real    0m0.007s
user    0m0.004s
sys     0m0.004s

Notice exactly how much better this gets for the first result with that
file.

> This is because the amputated graph is much simpler, and the rest of the
> code needs to do much less work.
> 
> Passing --all is another beast, and does indeed suffer:
> 
>  % time git lg --ignore-merge-bases --all >/dev/null
>  4.06s user 0.04s system 99% cpu 4.105 total
> 
>  % time git lg --all >/dev/null
>  189.59s user 0.04s system 99% cpu 3:09.65 total
> 
>  (and for the first line)
> 
>  % time git lg -n1 --ignore-merge-bases --all >/dev/null
>  3.86s user 0.02s system 99% cpu 3.874 total
> 
>  % time git lg -n1 --all >/dev/null
>  0.83s user 0.02s system 99% cpu 0.848 total
> 
> (If you need to use --all for the Linux git repo, you should not use
> --ignore-merge-bases).

I think this is a deficiency in your implementation, not a hard rule
about how these options would need to interact.

Thanks,
-Stolee

