Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A268DC433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 17:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhLLRn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 12:43:56 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:8573 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhLLRn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 12:43:56 -0500
Received: from host-84-13-153-69.opaltelecom.net ([84.13.153.69] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mwSt5-00070b-FA; Sun, 12 Dec 2021 17:43:52 +0000
Message-ID: <7ffa36ab-da93-0fe7-8d21-f489b16a3340@iee.email>
Date:   Sun, 12 Dec 2021 17:43:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: New (better?) hash map technique in limit case.
Content-Language: en-GB
To:     Glen Choo <chooglen@google.com>, Git List <git@vger.kernel.org>
References: <e30ae0dd-739b-7ecd-735e-992395b31ccc@iee.email>
 <kl6ltufg843d.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <kl6ltufg843d.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,
On 10/12/2021 22:52, Glen Choo wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> Recently I saw a report [1] on a new theoretical result about how to
>> manage hash maps which get nearly 'full', which beats Knuth's limit
>> formula. The full paper is at [2]
>>
>> As I understand it, the method adds the gravestone entries early during
>> has collisions to avoid clumping of such collision insertions, rather
>> than always having to enter the collision list at the end. This keeps
>> the available slots relatively randomly spaced.
>>
>> It feels like the old random bus arrival problem where the average wait
>> for next bus is identical to the average time since the last bust, which
>> is the same as the average bus interval (thus 1 + 1 = 1), and the
>> technique maintains that advantageous perception.
>>
>> Given Git's use of hashes, it sounds like it could have uses, assuming
>> the theory pans out. I've not yet gone through the paper itself [2] but
>> hope springs eternal.
>>
>> Philip
>>
>> [1]
>> S. Nadis and M. I. of Technology, “Theoretical breakthrough could boost
>> data storage.”
>> https://techxplore.com/news/2021-11-theoretical-breakthrough-boost-storage.html
>> (accessed Nov. 18, 2021).
>>
>> [2]
>> M. A. Bender, B. C. Kuszmaul, and W. Kuszmaul, “Linear Probing
>> Revisited: Tombstones Mark the Death of Primary Clustering,”
>> arXiv:2107.01250 [cs, math], Jul. 2021, Accessed: Nov. 18, 2021.
>> [Online]. Available: http://arxiv.org/abs/2107.01250
> Very interesting, thanks for sharing. I haven't read the full paper
> either, but this is an interesting result.
>
> It seems that this result is limited to hashmaps with a approximately
> equal number of insertions and deletions..
>
> From [1]
>
>   They found that for applications where the number of insertions and
>   deletions stays about the same—and the amount of data added is roughly
>   equal to that removed—linear-probing hash tables can operate at high
>   storage capacities without sacrificing speed.apacities without
>   sacrificing speed.
>
> and [2]
>
>   ...We then turn our attention to sequences of operations that contain
>   deletions, and show that the tombstones left behind by those deletions
>   have a primary-anti-clustering effect, that is, they have a tendency
>   to speed up future insertions
>
> Do we have any such use cases?
I know that we use hash maps, but haven't followed there actual usage in
various optimisations.

Obviously we use hash naming of objects but that's generally a
red-herring, I think, unless we are over-abbreviating the hash so that
it's no longer unique (which could be happening somewhere).

I suspect that some of the hosting providers may be more interested from
a File system perspective, as I think we just pass the object store
problems to the FS. Then again, all the mono-repo and partial checkout
corporate users are likely to be interested, especially if this unblocks
some historical misunderstanding about the limits and how to handle them.

--
Philip
