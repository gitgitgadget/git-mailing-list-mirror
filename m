Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634FC2047F
	for <e@80x24.org>; Sat, 29 Jul 2017 13:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753728AbdG2N04 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 09:26:56 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:50534 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753633AbdG2N0y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 09:26:54 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id bRlcdf56g3CyHbRlcdjHIu; Sat, 29 Jul 2017 14:26:53 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=xeHo_GJDZS1XWc6Ss7oA:9 a=uBz5hOFO0hgVMxGz:21
 a=nBQ2xry2uNDo_2Xo:21 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <244AA0848E9D46F480E7CA407582A162@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jonathan Tan" <jonathantanmy@google.com>,
        "Ben Peart" <peartben@gmail.com>
Cc:     <git@vger.kernel.org>, <jrnieder@gmail.com>, <sbeller@google.com>,
        <git@jeffhostetler.com>
References: <cover.1500508695.git.jonathantanmy@google.com> <3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com> <d8beb406-6d03-d893-4f37-83a7bdd6b9ac@gmail.com> <20170720141342.6a89aace@twelve2.svl.corp.google.com> <d014682f-66a5-c3c1-cf66-ef4bb28de076@gmail.com> <20170721133308.422e736d@twelve2.svl.corp.google.com> <96e8a347-d6b5-e21e-4129-2957fc26db19@gmail.com>
Subject: Re: [RFC PATCH v2 2/4] promised-object, fsck: introduce promised objects
Date:   Sat, 29 Jul 2017 14:26:52 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170729-0, 29/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfE1V85YrYHumwcisZpFSm/LNgBLjvwD2V5xgfIN6GlcuTsFY/4xlBnJi0P+zKyhNu2gdsEFzHTmWU+wiEtanyKEEF+kTFIMMCSroaCDLoSnCiWXz/pst
 G3ulsQd6VRVh2Vlvz2gxNldqzMfNl0mHyRI9r0WbdnQbjWDtbpXF9FFxFNJZ1YCGZoDjeCx0kALORhQu7wY/SRyKX3yj457//oB3Az5NJCzjt5wS4i3CB4tz
 1RA654H8fCMrPJxrQk799kHsOcF3knJRyTozgawLiRcbFmgwOCuBEIzp11pnV5Kv5aL/9+iMEWnKmV1ZVTsiT0mX5JOdk+4+aEMZS0/q2ps=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Ben Peart" <peartben@gmail.com>
Sent: Tuesday, July 25, 2017 4:10 PM
> On 7/21/2017 4:33 PM, Jonathan Tan wrote:
>> On Fri, 21 Jul 2017 12:24:52 -0400
>> Ben Peart <peartben@gmail.com> wrote:
>>
>>> Today we have 3.5 million objects * 30 bytes per entry = 105 MB of
>>> promises. Given the average developer only hydrates 56K files (2 MB
>>> promises) that is 103 MB to download that no one will ever need. We
>>> would like to avoid that if possible as this would be a significant
>>> regression in clone times from where we are today.
>>>

A question in the broader context of Narrow clones that I'd be interested 
in.

How narrow are the tree levels that contain the hydrated files? The question 
splits a couple of ways:

A. If one goes to the highest tree that contains all the 56K files, how many 
files and sub trees would be in that complete tree (i.e. what fraction of 
that 'top' tree is inflated).
A2. Is there some deep/wide metric that indicates how tightly together the 
inflated files tend to cluster?

B. If instead we look at just the trees in the paths of those inflated 
files, those trees will also reference other trees/blobs that are not 
inflated, how big is that list (it would indicate the size of a narrow 
repo's object store that holds the oid stubs)

I would quess / expect that the typical inflation only has a few clustered 
areas of interest, but it maybe that in such a big reality (*) the inflated 
files are actually spread very widely. (*) as per various blog posts saying 
there was no realistic way of partitioning the BigWin repo!

I'd be interested in any such sparsity metric (apologies if I've missed 
previous reports).
--
Philip

>>> I'm also concerned about the performance of merging in promises given we
>>> have 100M objects today and growing so the number of promises over time
>>> could get pretty large.
>>
>> After some thought, maybe a hybrid solution is best, in which it is
>> permissible but optional for some missing objects to have promises. In
>> that case, it is more of a "size cache" (which stores the type as well)
>> rather than a true promise. When fetching, the client can optionally
>> request for the sizes and types of missing objects.
>>
>
> In our GVFS solution today we do not download any size or object type 
> information at clone as the number of objects and the resulting file would 
> be too large.  Instead, we have a new sizes endpoint 
> (https://github.com/Microsoft/GVFS/blob/master/Protocol.md) that enables 
> us to retrieve object sizes "on demand" much like we are enabling for the 
> actual object content.
>
> This protocol could easily be extended to return both size and type so 
> that it could be used to retrieve "promise" data for objects as they are 
> needed. Having a way to "cache" that data locally so that both git and 
> other code could share it would be great.
>
> At a minimum, we should ensure the data stream passed back is the same 
> whether at clone time or when hitting a "promises" end point. I think it 
> would also be helpful to enable promises to be downloaded on demand much 
> like we are doing for the object data itself.
>
>> This is good for the large-blob case, in which we can always have size
>> information of missing blobs, and we can subsequently add blob-size
>> filtering (as a parameter) to "git log -S" and friends to avoid needing
>> to resolve a missing object. And this is, as far as I can tell, also
>> good for the many-blob case - just have an empty size cache all the
>> time. (And in the future, use cases could come up that desire non-empty
>> but non-comprehensive caches - for example, a directory lister working
>> on a partial clone that only needs to cache the sizes of frequently
>> accessed directories.)
>>
>> Another option is to have a repo-wide option that toggles between
>> mandatory entries in the "size cache" and prohibited entries. Switching
>> to mandatory provides stricter fsck and negative lookups, but I think
>> it's not worth it for both the developers and users of Git to have to
>> know about these two modes.
>>
>>>>> I think we should have a flag (off by default) that enables someone to
>>>>> say that promised objects are optional. If the flag is set,
>>>>> "is_promised_object" will return success and pass the OBJ_ANY type and 
>>>>> a
>>>>> size of -1.
>>>>>
>>>>> Nothing today is using the size and in the two places where the object
>>>>> type is being checked for consistency (fsck_cache_tree and
>>>>> fsck_handle_ref) the test can add a test for OBJ_ANY as well.
>>>>>
>>>>> This will enable very large numbers of objects to be omitted from the
>>>>> clone without triggering a download of the corresponding number of
>>>>> promised objects.
>>>>
>>>> Eventually I plan to use the size when implementing parameters for
>>>> history-searching commands (e.g. "git log -S"), but it's true that
>>>> that's in the future.
>>>>
>>>> Allowing promised objects to be optional would indeed solve the issue 
>>>> of
>>>> downloading too many promises. It would make the code more complicated,
>>>> but I'm not sure by how much.
>>>>
>>>> For example, in this fsck patch, the easiest way I could think of to
>>>> have promised objects was to introduce a 3rd state, called "promised",
>>>> of "struct object" - one in which the type is known, but we don't have
>>>> access to the full "struct commit" or equivalent. And thus fsck could
>>>> assume that if the "struct object" is "parsed" or "promised", the type
>>>> is known. Having optional promised objects would require that we let
>>>> this "promised" state have a type of OBJ_UNKNOWN (or something like
>>>> that) - maybe that would be fine, but I haven't looked into this in
>>>> detail.
>>>>
>>>
>>> Caveats apply as I only did a quick look but I only found the two
>>> locations that were checking the object type for consistency.
>>
>> I haven't looked into detail, but you are probably right.
>> 

