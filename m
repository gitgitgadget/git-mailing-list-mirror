Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1BD20A40
	for <e@80x24.org>; Sat,  2 Dec 2017 16:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbdLBQa3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 11:30:29 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:16147 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdLBQa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 11:30:27 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id LAgLev7a5CbAZLAgLe5hiY; Sat, 02 Dec 2017 16:30:26 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=bt3WUTiwAAAA:8
 a=TiA1ws-RXzBzRM8hmZ0A:9 a=QEXdDO2ut3YA:10 a=OXx4ngWzwLx9h_IvVXMu:22
Message-ID: <A2F606CCDE4542D8AAFC41EB50909FE3@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Vitaly Arbuzov" <vit@uber.com>,
        "Jeff Hostetler" <git@jeffhostetler.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com> <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com> <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com> <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com> <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley> <CANxXvsM-q-MH3y94=tW8GmbWNjvrskPoGEhOkyAzsbZd8RrRbg@mail.gmail.com> <CANxXvsNuEmo+uaRY8t44csqzXAk3rS+D9E=LMvaLcZeg-aLvRw@mail.gmail.com> <bac032c8-b9c2-4520-58e5-d518f4efd9d6@jeffhostetler.com>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
Date:   Sat, 2 Dec 2017 16:30:24 -0000
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
X-Antivirus: AVG (VPS 171202-2, 02/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfGcOEejNGzGxRv6grKn0Acb5yssVqHYS59wKpNoqdCZyNFAY6Z2tPEUHgc/gkdRjwK3ylWTJ1lP5S90YqsHP0jWG1xCM+1Vc+HWzTgVwI5HSIGngMb5/
 6qH/zzLayiI+D/Z/t7i2foKiXJ0+MXcN47kUrt1DgpwzxLIm4JP7nAdcZf2kfBYdRBdyEAKLvUppHX2zVe5t7T+Jo7fxZEQZ/awXw7ShidQM5jwCxrcB0Bwn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff Hostetler" <git@jeffhostetler.com>
Sent: Friday, December 01, 2017 2:30 PM
> On 11/30/2017 8:51 PM, Vitaly Arbuzov wrote:
>> I think it would be great if we high level agree on desired user
>> experience, so let me put a few possible use cases here.
>>
>> 1. Init and fetch into a new repo with a sparse list.
>> Preconditions: origin blah exists and has a lot of folders inside of
>> src including "bar".
>> Actions:
>> git init foo && cd foo
>> git config core.sparseAll true # New flag to activate all sparse
>> operations by default so you don't need to pass options to each
>> command.
>> echo "src/bar" > .git/info/sparse-checkout
>> git remote add origin blah
>> git pull origin master
>> Expected results: foo contains src/bar folder and nothing else,
>> objects that are unrelated to this tree are not fetched.
>> Notes: This should work same when fetch/merge/checkout operations are
>> used in the right order.
>
> With the current patches (parts 1,2,3) we can pass a blob-ish
> to the server during a clone that refers to a sparse-checkout
> specification.

I hadn't appreciated this capability. I see it as important, and should be 
available both ways, so that a .gitNarrow spec can be imposed from the 
server side, as well as by the requester.

It could also be used to assist in the 'precious/secret' blob problem, so 
that AWS keys are never pushed, nor available for fetching!

>        There's a bit of a chicken-n-egg problem getting
> things set up.  So if we assume your team would create a series
> of "known enlistments" under version control, then you could

s/enlistments/entitlements/ I presume?

> just reference one by <branch>:<path> during your clone.  The
> server can lookup that blob and just use it.
>
>     git clone --filter=sparse:oid=master:templates/bar URL
>
> And then the server will filter-out the unwanted blobs during
> the clone.  (The current version only filters blobs; you still
> get full commits and trees.  That will be revisited later.)

I'm for the idea that only the in-heirachy trees should be sent.
It should also be possible that the server replies that it is only sending a 
narrow clone, with the given (accessible?) spec.

>
> On the client side, the partial clone installs local config
> settings into the repo so that subsequent fetches default to
> the same filter criteria as used in the clone.
>
>
> I don't currently have provision to send a full sparse-checkout
> specification to the server during a clone or fetch.  That
> seemed like too much to try to squeeze into the protocols.
> We can revisit this later if there is interest, but it wasn't
> critical for the initial phase.
>
Agreed. I think it should be somewhere 'visible' to the user, but could be 
setup by the server admin / repo maintainer if they don't have write access. 
But there could still be the catch-22 - maybe one starts with a <commit | 
toptree> : <tree> pair to define an origin point (it's not as refined as a 
.gitNarrow spec file, but is definative). The toptree option could even 
allow sub-tree clones.. maybe..

>
>>
>> 2. Add a file and push changes.
>> Preconditions: all steps above followed.
>> touch src/bar/baz.txt && git add -A && git commit -m "added a file"
>> git push origin master
>> Expected results: changes are pushed to remote.
>
> I don't believe partial clone and/or partial fetch will cause
> any changes for push.

I suspect that pushes could be rejected if the user 'pretends' to modify 
files or trees outside their area. It does need the user to be able to spoof 
part of a tree they don't have, so an upstream / remote would immediatly 
know it was a spoof but locally the narrow clone doesn't have enough detail 
about the 'bad' oid. It would be right to reject such attempts!

>
>>
>> 3. Clone a repo with a sparse list as a filter.
>> Preconditions: same as for #1
>> Actions:
>> echo "src/bar" > /tmp/blah-sparse-checkout
>> git clone --sparse /tmp/blah-sparse-checkout blah # Clone should be
>> the only command that would requires specific option key being passed.
>> Expected results: same as for #1 plus /tmp/blah-sparse-checkout is
>> copied into .git/info/sparse-checkout

I presume clone and fetch are treated equivalently here.

>
> There are 2 independent concepts here: clone and checkout.
> Currently, there isn't any automatic linkage of the partial clone to
> the sparse-checkout settings, so you could do something like this:
>
I see an implicit link that clearly one cannot checkout (inflate/populate) a 
file/directory that one does not have in the object store. But that does not 
imply the reverse linkage. The regular sparse checkout should be available 
independently of the local clone being a narrow one.

>     git clone --no-checkout --filter=sparse:oid=master:templates/bar URL
>     git cat-file ... templates/bar >.git/info/sparse-checkout
>     git config core.sparsecheckout true
>     git checkout ...
>
> I've been focused on the clone/fetch issues and have not looked
> into the automation to couple them.
>

I foresee that large files and certain files need to be filterable for 
fetch-clone, and that might not be (backward) compatible with the 
sparse-checkout.

>
>>
>> 4. Showing log for sparsely cloned repo.
>> Preconditions: #3 is followed
>> Actions:
>> git log
>> Expected results: recent changes that affect src/bar tree.
>
> If I understand your meaning, log would only show changes
> within the sparse subset of the tree.  This is not on my
> radar for partial clone/fetch.  It would be a nice feature
> to have, but I think it would be better to think about it
> from the point of view of sparse-checkout rather than clone.
>
One option maybe by making a marker for the tree/blob to be a first class 
citizen. So the oid (and worktree file) has content ".gitNarrowTree <oid>" 
or ",gitNarrowBlob <oid>" as required (*), which is safe, and allows a 
consistent alter-ego view of the tree contents and hence for git-log et.al.

(*) I keep flip flopping between a single object marker, and distinct object 
markers for the types. It partly depends on whether one can know in advance, 
locally, what the oid type should be, and how it should be embedded in the 
object store - need to re-check the specs.

I'm tending toward distinct types to cope with the D/F conflict in the 
worktrees - the directory must be created (holds the name etc), and the 
alter-ego content then must be placed in a _known_ sub-file ".gitNarrowTree" 
(without the oid in the file name, but included in the content). Presence of 
a ".gitNarrowTree" should be standalone in the directory when that part of 
the work-tree is clean.

>
>>
>> 5. Showing diff.
>> Preconditions: #3 is followed
>> Actions:
>> git diff HEAD^ HEAD
>> Expected results: changes from the most recent commit affecting
>> src/bar folder are shown.
>> Notes: this can be tricky operation as filtering must be done to
>> remove results from unrelated subtrees.
>
> I don't have any plan for this and I don't think it fits within
> the scope of clone/fetch.  I think this too would be a sparse-checkout
> feature.
>

See my note about first class citizens for marker OIDs

>
>>
>> *Note that I intentionally didn't mention use cases that are related
>> to filtering by blob size as I think we should logically consider them
>> as a separate, although related, feature.
>
> I've grouped blob-size and sparse filter together for the
> purposes of clone/fetch since the basic mechanisms (filtering,
> transport, and missing object handling) are the same for both.
> They do lead to different end-uses, but that is above my level
> here.
>
>
>>
>> What do you think about these examples above? Is that something that
>> more-or-less fits into current development? Are there other important
>> flows that I've missed?
>
> These are all good ideas and it is good to have someone else who
> wants to use partial+sparse thinking about it and looking for gaps
> as we try to make a complete end-to-end feature.
>>
>> -Vitaly
>
> Thanks
> Jeff
>

Philip

