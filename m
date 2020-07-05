Return-Path: <SRS0=5lEM=AQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA7AC433DF
	for <git@archiver.kernel.org>; Sun,  5 Jul 2020 20:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C022073E
	for <git@archiver.kernel.org>; Sun,  5 Jul 2020 20:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgGEUmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:42:47 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:56535 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbgGEUmq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jul 2020 16:42:46 -0400
Received: from host-92-20-155-32.as13285.net ([92.20.155.32] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jsBTG-0008iY-5E; Sun, 05 Jul 2020 21:42:43 +0100
Subject: Re: [PATCH] doc: log takes multiple revision ranges
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
 <xmqqd08wc5bd.fsf@gitster.c.googlers.com>
 <51E0F312-E132-4E8E-AFE6-570CB02B4590@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <f55e0109-af9a-7c21-1cbf-41b2531560e4@iee.email>
Date:   Sun, 5 Jul 2020 21:42:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <51E0F312-E132-4E8E-AFE6-570CB02B4590@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,
This had been sitting in my inbox..

On 30/03/2020 13:52, Philippe Blain wrote:
> Hi Junio, 
>> Le 28 mars 2020 à 21:34, Junio C Hamano <gitster@pobox.com> a écrit :
>>
>> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>>
>>> `git log` accepts multiple revision ranges, but makes no mention of that
>>> in its documentation. Currently readers have to go to the `git
>>> rev-list` documentation to discover this useful feature.

I'd concur that sometime the documentation is not as educationally
informative  as it could be. Often it leaves readers to second guess
what is meant, or redirects to other reference sections with similar
presumptions that the reader already understands.  Documentation is
harder than coding because of these differences in writing style. Often
Git appears to prefer the normative standard style.

>> I have a mixed feeling about this change.  Surely you can write
>>
>> 	git log   v1.0..v2.0   v4.0..v5.0 -- Makefile
>>
>> and you can explain that the command appears to take two "ranges",
>> but I do not think we want to encourage it to those who do not
>> understand what the above actually *means*.  
>>
>> Specifially, it does *NOT* list commits between v1.0 and v2.0, or
>> between v4.0 and v5.0, that touch the path Makefile.  In other
>> words, you didn't really give two ranges with the syntax.  What the
>> A..B notation means could be called a range, only when it appears
>> alone.
>>
>> And we have *no* intention of changing the semantics.
> Of course, I understand.
>
>> "A..B" is a mere short-hand for ^A B, and it may appear to be a
>> range, but "A..B C..D" does not make "two ranges".  It still merely
>> is a short-hand for ^A B ^C D, and if C reaches A and B (in the
>> above example, v4.0 is very likely to reach both v1.0 and v2.0), it
>> means the same thing as "C..D", i.e. "git log v4.0..v5.0 -- Makefile".
> Yes, you are right.
>
>> So I have a mildly strong opinion against the change to the synopsys
>> and the short-help; it is a bad change that does not help users.  If
>> there are not sufficient explanation on the equivalence between A..B
>> and ^A B on "git log" documentation but there is one elsewhere, adding
>> a reference to help users learn is very much appreciated, though,
> So the 'git log' documentation states: 
>
>     origin..HEAD specifies all the commits reachable from the current commit 
>     (i.e. HEAD), but not from origin. For a complete list of ways to spell <revision range>, 
>     see the Specifying Ranges section of gitrevisions[7].
>
> What I wanted to achieve with this patch is to make readers aware that 
> they can write e.g.
>
>     git log branch1 branch2 branch3 branch4 --not master
>
> to see commits on each of branch1-4, that are not on master, 
> since this is not immediately obvious (at least to me)
> in the 'git log' man page. 

The whole revision walk stuff is tricky. Finding the right starting
point for explanations is key, along with picking out where 'normal'
errors are made, as these do help users who aren't simply 'checking the
manual'. (the 20-20 hindsight problem)

For example, your "that are not on master", and what that means, needs
to be brought out to the new reader rather than being buried
mid-sentence. Most readers will miss those mid-sentence key points and
they can't learn until they have some significant problem that points it
out to them. Sometime we need to point at the 'wrong' things, not just
the right things. (e.g. if branch3 had ben merged a couple of revisions
ago...)

> Even following the link to gitrevisions[7], 
> it is not explicitly mentioned in the "Specifying Ranges" section 
> that a range denotes the set of all commits reachable by all given refs, 
> minus the ones reachable by all given refs prefixed by '^' or '--not'.
> However, this is really clear in the 'git rev-list' documentation, 
> which uses  '<commit>...' in the synopsis
> and clearly talks about the "set of commits" point of view:
>
>     You can think of this as a set operation. Commits given on the command line form 
>     a set of commits that are reachable from any of them, and then commits reachable 
>     from any of the ones given with ^ in front are subtracted from that set. The remaining 
>     commits are what comes out in the command’s output. Various other options and 
>     paths parameters can be used to further limit the result.
>
Set operations don't help everyone, just sayin'.

In some cases: The fact that we exclude any commit reachable from any of
the "^" commits should be mentioned first, and then we select any left
that are reachable from the named tips. This puts a different spin on
the  understanding, and helps catch those that have not understood the
other descriptions. It can then be easily linked to the 'two ranges'
case producing otherwise unexpected results.
> Do you think it would be appropriate that this explanation could somehow also appear 
> in the 'git log' (and maybe also 'gitrevisions') documentation ?
>
> Thanks for the quick feedback,
> Philippe.
Philip
