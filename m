Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4B820A40
	for <e@80x24.org>; Tue,  5 Dec 2017 19:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbdLETO4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 14:14:56 -0500
Received: from siwi.pair.com ([209.68.5.199]:44790 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbdLETOy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 14:14:54 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1912C844E2;
        Tue,  5 Dec 2017 14:14:54 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DB0B5844E1;
        Tue,  5 Dec 2017 14:14:53 -0500 (EST)
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Philip Oakley <philipoakley@iee.org>, Vitaly Arbuzov <vit@uber.com>
Cc:     Git List <git@vger.kernel.org>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
 <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley>
 <0e851e08-0dcc-da3b-b2c4-42afcdbf6ca4@jeffhostetler.com>
 <6C1247A43F8841F98E070C264045BF49@PhilipOakley>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7bcdbd52-0cfa-58b2-e40a-1852cc70ce69@jeffhostetler.com>
Date:   Tue, 5 Dec 2017 14:14:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <6C1247A43F8841F98E070C264045BF49@PhilipOakley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/2/2017 1:24 PM, Philip Oakley wrote:
> From: "Jeff Hostetler" <git@jeffhostetler.com>
> Sent: Friday, December 01, 2017 5:23 PM
>> On 11/30/2017 6:43 PM, Philip Oakley wrote:
[...]
>>
>> Discussing this feature in the context of the defense industry
>> makes me a little nervous.  (I used to be in that area.)
> 
> I'm viewing the desire for codebase partitioning from a soft layering
> of risk view (perhaps a more UK than USA approach ;-)

I'm not sure I know what this means or how the UK defense
security models/policy/procedures are different from the US,
so I can't say much here.  I'm just thinking that even if we
get a *perfectly working* partial clone/fetch/push/etc. that
it would not pass a security audit.  I might be wrong here
(and I'm no expert on the subject), but I think they would
push you towards a different solution architecture.


> 
>> What we have in the code so far may be a nice start, but
>> probably doesn't have the assurances that you would need
>> for actual deployment.  But it's a start....
> 
> True. I need to get some of my collegues more engaged...
>>
[...]
>> Yes, this does tend to lead towards an always-online mentality.
>> However, there are 2 parts:
>> [a] dynamic object fetching for missing objects, such as during a
>>     random command like diff or blame or merge.  We need this
>>     regardless of usage -- because we can't always predict (or
>>     dry-run) every command the user might run in advance.
> 
> Making something "useful" happen here when off-line is an obvious goal.
> 
>> [b] batch fetch mode, such as using partial-fetch to match your
>>     sparse-checkout so that you always have the blobs of interest
>>     to you.  And assuming you don't wander outside of this subset
>>     of the tree, you should be able to work offline as usual.
>> If you can work within the confines of [b], you wouldn't need to
>> always be online.
> 
> I feel this is the area that does need ensure a capability to avoid
> any perception of the much maligned 'Embrace, extend, and extinguish'> by accidental lockout.
> 
> I don't think this should be viewed as a type of sparse checkout -
> it's just a checkout of what you have (under the hood it could use
> the same code though).

Right, I'm only thinking of this effort as a way to get a partial
clone and fetch that omits unneeded (or, not immediately needed)
objects for performance reasons.  There are several use scenarios
that I've discussed and sparse-checkout is one of them, but I do
not consider this to be a sparse-checkout feature.

  
[...]
>>
>> The main problem with markers or other lists of missing objects is
>> that it has scale problems for large repos.  Suppose I have 100M
>> blobs in my repo.  If I do a blob:none clone, I'd have 100M missing
>> blobs that would need tracking.  If I then do a batch fetch of the
>> blobs needed to do a sparse checkout of HEAD, I'd have to remove
>> those entries from the tracking data.  Not impossible, but not
>> speedy either.
> 
> ** Ahhh. I see. That's a consequence of having all the trees isn't it. **
> 
> I've always thought that limiting the trees is at the heart of the Narrow clone/fetch problem.
> 
> OK so if you have flat, wide structures with 10k files/directories per tree then it's still a fair sized problem, but it should *scale logarithmically* for the part of the tree structure that's not being downloaded.
> 
> You never have to add a marker for a blob that you have no containing tree for. Nor for the tree that contained the blob's tree, all the way up to primary line of descent to the tree of concern. All those trees are never down loaded, there are few markers (.gitNarrowTree files) for those tree stubs, certainly no 100M missing blob markers.

Currently, the code only omits blobs.  I want to extend the current
code to have filters that also exclude unneeded trees.  That will help
address some of these size concerns, but there are still perf issues
here.


>>> * Marking of 'missing' objects in the local object store, and on the wire.
>>> The missing objects are replaced by a place holder object, which used the
>>> same oid/sha1, but has a short fixed length, with content “GitNarrowObject
>>> <oid>”. The chance that that string would actually have such an oid clash is
>>> the same as all other object hashes, so is a *safe* self-referential device.
>>
>> Again, there is a scale problem here.  If I have 100M missing blobs,
>> I can't afford to create 100M loose place holder files.  Or juggle
>> a 2GB file of missing objects on various operations.
> 
> As above, I'm also trimming the trees, so in general, there would be no missing  blobs, just the content of the directory one was interested in.
> 
> That's not quite true if higher level trees have blob references in them that are otherwise unwanted - they may each need a marker. [Or maybe a special single 'tree-of-blobs' marker for them all thus only one marker per tree - over-thinking maybe...]

Also omitting certain trees means you now (obviously) have both missing
trees and blobs.  And both need to be dynamically or batch fetched as
needed.  And certain operations will need multiple round trips to fully
resolve -- fault in a tree and then fault in blobs referenced by it.

And right, you still need to be able to refer to trees that have *some*
of their children missing.  It's not a clean tree-only boundary.

So, given all that, any set of markers would be incomplete and/or would
need to be aggressively updated to be correct.  What we have now in
Jonathan's "promisor" code allows us to infer at object-lookup time
that any missing object (from a tree-to-child or commit-to-tree reference)
is expected and can be resolved.  And this doesn't require any markers
or additional on-disk lists of SHAs or packfile format changes.


[...]
>>> * The stored object already includes length (and inferred type), so we do
>>> know what it stands in for. Thus the local index (index file) should be able
>>> to be recreated from the object store alone (including the ‘promised /
>>> narrow / missing’ files/directory markers)

The packfile only contains the objects it contains.  The IDX file
is an index of that.  Neither know of objects (or sizes of objects)
that they don't have.  The have child references (tree to contained
blob), but those are just dangling -- and may be in a different packfile.

[...]
>>> As a safety it could be that the .gitNarrowIgnore is sent with the pack so
>>> that fold know what they missed, and fsck could check that they are locally
>>> not narrower than some specific project .gitNarrowIgnore spec.
>>
>> Currently, we store the filter_spec used for the partial clone (or the
>> first partial fetch) as a default for subsequent fetches, but we limit
>> it there.  That is, for operations like checkout or blame or whatever,
>> it doesn't matter why a blob is missing or what filter criteria was
>> used to cause it to be omitted -- just that it is.  Any time we need
>> a missing object, we have to go get it -- whether that is via dynamic
>> or bulk fetching.
> 
> Deciding *if* we have to get it, while still being 'useful', is part of the question I raised above. In my world view, we already have the intersting blobs, so we shouldn't need to get anything. diff's, blame's, checkout's, simply go with the stub values and everything is cushty.

That is not possible in general.  Suppose I have all of the trees and blobs
for my "cone" of the source tree (say "Documentation/") and I only plan to
make edits with in that cone.  I can do sparse-checkout and commits and all
is well.  Suppose I want to merge my work with Alice and Bob.  I can pull
their branches and I can merge any edits they also made in my cone of the
tree and all is well.  *BUT* if they both edited a file that is outside of
my cone, my git-merge has to file-merge the contents of the 3 versions (the
ancestor, Alice's, and Bob's) of the file.  I don't have the blobs for them
because I only got blobs for my cone of the tree.  Likewise, I also may not
have the 3 containing tree nodes.

So, I either need dynamic object fetching -or- I need a dry-run mode to
predict the missing objects

>>
[...]
>>>
>>> I believe that its all doable, and that Jeff H's work already puts much of
>>> it in place, or touches those places
>>>
>>> That said, it has been just _thinking_, without sufficient time to delve
>>> into the code.
>>>
>>> Phil
>> [...]
>>
>> Thanks
>> Jeff
>>
> 
> Thanks for the great work.
> 
> Philip

Thanks for the comments,
Jeff
