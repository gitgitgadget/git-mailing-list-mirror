Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC2C20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 23:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdK3XnY (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 18:43:24 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:35223 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbdK3XnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 18:43:23 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id KYUCewolypb8rKYUCe7hlW; Thu, 30 Nov 2017 23:43:21 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=w-CU6Wn9AAAA:8
 a=NEAV23lmAAAA:8 a=bt3WUTiwAAAA:8 a=5rxgeBVgAAAA:8 a=1XWaLZrsAAAA:8
 a=jTXH3keun7ioI7dlA5cA:9 a=cBD710fqDZ8ksa7O:21 a=hiHJVFWNwn90IT64:21
 a=QEXdDO2ut3YA:10 a=OXx4ngWzwLx9h_IvVXMu:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Vitaly Arbuzov" <vit@uber.com>,
        "Jeff Hostetler" <git@jeffhostetler.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com> <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com> <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com> <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
Date:   Thu, 30 Nov 2017 23:43:18 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171130-6, 30/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfPG1+MhgYtGqF5lhYRXkmwEpbGuFnmjZdhZerm7N11Ywewz5pbaC1GrXZELcdvNk0hQTBO6eqKd4sz0O9qxy8ZpYHOaf+IXEt7Rg6NyJ3xUl64dAYo3s
 v6YcC7TXx2k92nJ2J2uJLJqIlv0Zw55+WQ7G5azpcTUtaoHGOhHIR51K5t9CxAV+fYjC5VWm5oIBfNUwI9AM49vmAuudgT5RmYjq9tOt9JO0R5+CJxNO/Hjd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Vitaly Arbuzov" <vit@uber.com>
> Found some details here: https://github.com/jeffhostetler/git/pull/3
>
> Looking at commits I see that you've done a lot of work already,
> including packing, filtering, fetching, cloning etc.
> What are some areas that aren't complete yet? Do you need any help
> with implementation?
>

comments below..
>
> On Thu, Nov 30, 2017 at 9:01 AM, Vitaly Arbuzov <vit@uber.com> wrote:
>> Hey Jeff,
>>
>> It's great, I didn't expect that anyone is actively working on this.
>> I'll check out your branch, meanwhile do you have any design docs that
>> describe these changes or can you define high level goals that you
>> want to achieve?
>>
>> On Thu, Nov 30, 2017 at 6:24 AM, Jeff Hostetler <git@jeffhostetler.com>
>> wrote:
>>>
>>>
>>> On 11/29/2017 10:16 PM, Vitaly Arbuzov wrote:
>>>>
>>>> Hi guys,
>>>>
>>>> I'm looking for ways to improve fetch/pull/clone time for large git
>>>> (mono)repositories with unrelated source trees (that span across
>>>> multiple services).
>>>> I've found sparse checkout approach appealing and helpful for most of
>>>> client-side operations (e.g. status, reset, commit, etc.)
>>>> The problem is that there is no feature like sparse fetch/pull in git,
>>>> this means that ALL objects in unrelated trees are always fetched.
>>>> It may take a lot of time for large repositories and results in some
>>>> practical scalability limits for git.
>>>> This forced some large companies like Facebook and Google to move to
>>>> Mercurial as they were unable to improve client-side experience with
>>>> git while Microsoft has developed GVFS, which seems to be a step back
>>>> to CVCS world.
>>>>
>>>> I want to get a feedback (from more experienced git users than I am)
>>>> on what it would take to implement sparse fetching/pulling.
>>>> (Downloading only objects related to the sparse-checkout list)
>>>> Are there any issues with missing hashes?
>>>> Are there any fundamental problems why it can't be done?
>>>> Can we get away with only client-side changes or would it require
>>>> special features on the server side?
>>>>

I have, for separate reasons been _thinking_ about the issue ($dayjob is in
defence, so a similar partition would be useful).

The changes would almost certainly need to be server side (as well as client
side), as it is the server that decides what is sent over the wire in the 
pack files, which would need to be a 'narrow' pack file.

>>>> If we had such a feature then all we would need on top is a separate
>>>> tool that builds the right "sparse" scope for the workspace based on
>>>> paths that developer wants to work on.
>>>>
>>>> In the world where more and more companies are moving towards large
>>>> monorepos this improvement would provide a good way of scaling git to
>>>> meet this demand.

The 'companies' problem is that it tends to force a client-server, always-on
on-line mentality. I'm also wanting the original DVCS off-line capability to
still be available, with _user_ control, in a generic sense, of what they
have locally available (including files/directories they have not yet looked
at, but expect to have. IIUC Jeff's work is that on-line view, without the
off-line capability.

I'd commented early in the series at [1,2,3].


At its core, my idea was to use the object store to hold markers for the
'not yet fetched' objects (mainly trees and blobs). These would be in a 
known fixed format, and have the same effect (conceptually) as the 
sub-module markers - they _confirm_ the oid, yet say 'not here, try 
elsewhere'.

The comaprison with submodules mean there is the same chance of
de-synchronisation with triangular and upstream servers, unless managed.

The server side, as noted, will need to be included as it is the one that
decides the pack file.

Options for a server management are:

- "I accept narrow packs?" No; yes

- "I serve narrow packs?" No; yes.

- "Repo completeness checks on reciept": (must be complete) || (allow narrow 
to nothing).

 For server farms (e.g. Github..) the settings could be global, or by repo.
(note that the completeness requirement and narrow reciept option are not
incompatible - the recipient server can reject the pack from a narrow
subordinate as incomplete - see below)

 * Marking of 'missing' objects in the local object store, and on the wire.
The missing objects are replaced by a place holder object, which used the
same oid/sha1, but has a short fixed length, with content “GitNarrowObject
<oid>”. The chance that that string would actually have such an oid clash is
the same as all other object hashes, so is a *safe* self-referential device.


* The stored object already includes length (and inferred type), so we do
know what it stands in for. Thus the local index (index file) should be able
to be recreated from the object store alone (including the ‘promised /
narrow / missing’ files/directory markers)

* the ‘same’ as sub-modules.
The potential for loss of synchronisation with a golden complete repo is
just the same as for sub-modules. (We expected object/commit X here, but it’s 
not in the store). This could happen with a small user group who have 
locally narrow clones, who interact with their local narrow server for 
‘backup’, and then fail to push further upstream to a server that mandates 
completeness. They could create a death by a thousand narrow cuts. Having a 
golden upstream config reference (indicating which is the upstream) could 
allow checks to ensure that doesn’t happen.

The fsck can be taught the config option of 'allowNarrow'.

The narrowness would be defined in a locally stored '.gitNarrowIgnore' file
(which can include the size constraints being developed elsewhere on the
list)

As a safety it could be that the .gitNarrowIgnore is sent with the pack so
that fold know what they missed, and fsck could check that they are locally
not narrower than some specific project .gitNarrowIgnore spec.

The benefit of this that the off-line operation capability of Git continues,
which GVFS doesn’t quite do (accidental lock in to a client-server model aka
all those other VCS systems).

 I believe that its all doable, and that Jeff H's work already puts much of
it in place, or touches those places

That said, it has been just _thinking_, without sufficient time to delve
into the code.

Phil

>>>>
>>>> PS. Please don't advice to split things up, as there are some good
>>>> reasons why many companies decide to keep their code in the monorepo,
>>>> which you can easily find online. So let's keep that part out the
>>>> scope.
>>>>
>>>> -Vitaly
>>>>
>>>
>>>
>>> This work is in-progress now.  A short summary can be found in [1]
>>> of the current parts 1, 2, and 3.
>>>
>>>> * jh/object-filtering (2017-11-22) 6 commits
>>>> * jh/fsck-promisors (2017-11-22) 10 commits
>>>> * jh/partial-clone (2017-11-22) 14 commits
>>>
>>>
>>> [1]
>>> https://public-inbox.org/git/xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com/T/
>>>
>>> I have a branch that contains V5 all 3 parts:
>>> https://github.com/jeffhostetler/git/tree/core/pc5_p3
>>>
>>> This is a WIP, so there are some rough edges....
>>> I hope to have a V6 out before the weekend with some
>>> bug fixes and cleanup.
>>>
>>> Please give it a try and see if it fits your needs.
>>> Currently, there are filter methods to filter all blobs,
>>> all large blobs, and one to match a sparse-checkout
>>> specification.
>>>
>>> Let me know if you have any questions or problems.
>>>
>>> Thanks,
>>> Jeff

[1,2]  [RFC PATCH 0/3] Partial clone: promised blobs (formerly "missing
blobs")
https://public-inbox.org/git/BC1048A63B034E46A11A01758BC04855@PhilipOakley/
Date: Tue, 25 Jul 2017 21:48:46 +0100
https://public-inbox.org/git/8EE0108BA72B42EA9494B571DDE2005D@PhilipOakley/
Date: Sat, 29 Jul 2017 13:51:16 +0100

[3] [RFC PATCH v2 2/4] promised-object, fsck: introduce promised objects
https://public-inbox.org/git/244AA0848E9D46F480E7CA407582A162@PhilipOakley/
Date: Sat, 29 Jul 2017 14:26:52 +0100

