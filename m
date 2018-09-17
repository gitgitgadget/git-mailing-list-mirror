Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298A31F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeIQWXH (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:23:07 -0400
Received: from avasout07.plus.net ([84.93.230.235]:41025 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeIQWXH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:23:07 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id 1wnVgFM3ZjlDz1wnWg2070; Mon, 17 Sep 2018 17:54:54 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=k9PIc0Wdk3ELfBD9l7QA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] read-cache.c: fix a sparse warning
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Ben Peart <peartben@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
References: <c92b2f25-315d-141b-8974-dd05d7fd2b9e@ramsayjones.plus.com>
 <CAPig+cSm52i=ypGoPGGumhP+_waq=OU2QZ=p3oVzTTzLsNpfNA@mail.gmail.com>
 <2efc8b66-3d26-f794-b5fe-6a4b013feeaf@gmail.com>
 <d7c66568-0e6d-9d92-4559-d4963c0412ec@ramsayjones.plus.com>
Message-ID: <ae1b3014-f56a-d379-2d76-03f95a4cf388@ramsayjones.plus.com>
Date:   Mon, 17 Sep 2018 17:54:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d7c66568-0e6d-9d92-4559-d4963c0412ec@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKqGNJw5Utd4EJX1X3whYiTzyn4KAkAhuDLf28jZfwjB1PXPH7d3fVyD6l+xh/iOE1bknNFb07UOd29Wfx0da+7C6FBJ2irqEpQ0IKFZ1OWyy35GS3XJ
 PFdVDEzvWPGyApZrOUO+7rnjQ499Xsb9pqfTBcA9OTNieMFIbeVUc+E9K/j4Z0l/G8upBOgojSfULw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/09/18 17:27, Ramsay Jones wrote:
> 
> 
> On 17/09/18 15:15, Ben Peart wrote:
>>
>>
>> On 9/16/2018 3:17 AM, Eric Sunshine wrote:
>>> On Fri, Sep 14, 2018 at 7:29 PM Ramsay Jones
>>> <ramsay@ramsayjones.plus.com> wrote:
>>>> At one time, the POSIX standard required the type used to represent
>>>> a thread handle (pthread_t) be an arithmetic type. This is no longer
>>>> the case, probably because different platforms used to regularly
>>>> ignore that requirement.  For example, on cygwin a pthread_t is a
>>>> pointer to a structure (a quite common choice), whereas on Linux it
>>>> is defined as an 'unsigned long int'.
>>>>
>>>> On cygwin, but not on Linux, 'sparse' currently complains about an
>>>> initialiser used on a 'struct load_index_extensions' variable, whose
>>>> first field may be a pthread handle (if not compiled with NO_PTHREADS
>>>> set).
>>>>
>>>> In order to fix the warning, move the (conditional) pthread field to
>>>> the end of the struct and change the initialiser to use a NULL, since
>>>> the new (unconditional) first field is a pointer type.
>>>>
>>>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>>>> ---
>>>> If you need to re-roll your 'bp/read-cache-parallel' branch, could you
>>>> please squash this into the relevant patch (commit a090af334,
>>>> "read-cache: load cache extensions on a worker thread", 2018-09-12).
>>>
>>> The information contained in this commit message is so useful that it
>>> might make sense to plop this patch at the end of the series rather
>>> than merely squashing it in. (Or, if it is squashed, include the above
>>> explanation in the commit message of the appropriate patch.)
>>>
>>
>> I'm happy to squash it in if I end up re-rolling the patch series.  I'll include the information in the commit message above as a comment so that it is in close proximity to the code impacted.
>>
> 
> I will be happy with whatever decision you take regarding whether
> to squash this in or add it on top of your series. However, if you
> do squash it in, please don't add the commit message info as a
> comment to the code. No matter how you word it, I can't imagine
> that it would be anything but superfluous - the kind of comment
> that would be removed after review! ;-)
> 
> The information in the commit message about pthread_t, which I
> thought was common knowledge, was not really the main point of
> the argument supporting the patch. (Search for "How do I print
> a pthread_t", for variations on this theme).
> 
> The main point for me: don't conditionally include a field at the
> beginning of a structure and then use an initialiser in a variable
> declaration. (Unless, I suppose, the first unconditional field had
> the same type - but probably not not even then!)
> 
> The fact that the conditionally included field itself had an 'opaque'
> type was just an additional complication.

BTW, I just noticed that you explicitly initialise each field of
that structure (not surprising), so an even simpler solution is
to simply remove the unneeded initialiser! ;-)

ATB,
Ramsay Jones

