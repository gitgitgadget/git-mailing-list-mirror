Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADA02047F
	for <e@80x24.org>; Sat, 29 Jul 2017 12:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbdG2MvS (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 08:51:18 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:6519 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbdG2MvR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 08:51:17 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id bRD9df2Ik3CyHbRD9djGaS; Sat, 29 Jul 2017 13:51:15 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=1XWaLZrsAAAA:8 a=NEAV23lmAAAA:8 a=iQkOLWIDAFB1s80PQ94A:9 a=wPNLvfGTeEIA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <8EE0108BA72B42EA9494B571DDE2005D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jonathan Nieder" <jrnieder@gmail.com>
Cc:     "Jonathan Tan" <jonathantanmy@google.com>, <git@vger.kernel.org>,
        "Ben Peart" <peartben@gmail.com>
References: <cover.1499800530.git.jonathantanmy@google.com> <C299C45128634A21AF9D65E1B2B52C5B@PhilipOakley> <20170717180322.GM93855@aiede.mtv.corp.google.com>
Subject: Re: [RFC PATCH 0/3] Partial clone: promised blobs (formerly "missing blobs")
Date:   Sat, 29 Jul 2017 13:51:16 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170728-10, 28/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfOKARZlLyVt9a8E/x9fWHoj7fPSfn9g0Vi8UibafFDBrIe7E5su3ixVRcVJ7bDuNaFF6ua+1EEhHTCGq1WO+3jSy5GGPUeDVD6k/lBoHJAzJQ6AzsrVq
 aYpUkNH/gDG9+M8Q6TBDMJkJp3n+jk5GLptUDKuqJAdroxDheT3U8qPtK9+NQ0hCFaPNMxSqsg4mx0xpENzqr2GNi73R13b8kQWTZ0U0HXnYCdexh1JJr4tz
 e0+1UxQrpY4BN7dEQaaq5b6OJRypc98DBQFkmZuCt6E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jonathan Nieder" <jrnieder@gmail.com>
Sent: Monday, July 17, 2017 7:03 PM
> Hi Philip,
>
> Philip Oakley wrote:
>> From: "Jonathan Tan" <jonathantanmy@google.com>
>
>>> These patches are part of a set of patches implementing partial clone,
>>> as you can see here:
>>>
>>> https://github.com/jonathantanmy/git/tree/partialclone
> [...]
>> If I understand correctly, this method doesn't give any direct user
>> visibility of missing blobs in the file system. Is that correct?
>>
>> I was hoping that eventually the various 'on demand' approaches
>> would still allow users to continue to work as they go off-line such
>> that they can see directly (in the FS) where the missing blobs (and
>> trees) are located, so that they can continue to commit new work on
>> existing files.
>>
>> I had felt that some sort of 'gitlink' should be present (huma
>> readable) as a place holder for the missing blob/tree. e.g.
>> 'gitblob: 1234abcd' (showing the missing oid, jsut like sub-modules
>> can do - it's no different really.
>
> That's a reasonable thing to want, but it's a little different from
> the use cases that partial clone work so far has aimed to support.
> They are:
>
> A. Avoiding downloading all blobs (and likely trees as well) that are
>    not needed in the current operation (e.g. checkout).  This blends
>    well with the sparse checkout feature, which allows the current
>    checkout to be fairly small in a large repository.

True. In my case I was looking for a method that would allow a 'Narrow 
clone' such that the local repo would be smaller (have less content), but 
would feel as if all the usefull files/directories were available, and there 
would be place holders at the points where the trees were pruned, both in 
the object store, and in the user's work-tree.

As you say, in some ways its conceptually orthogonal to the original sparse 
checket (which has a full width object store / repo, and then omitted files 
from the checkout.
>
>    GVFS uses a trick that makes it a little easier to widen a sparse
>    checkout upon access of a directory.  But the same building blocks
>    should work fine with a sparse checkout that has been set up
>    explicitly.
>
> B. Avoiding downloading large blobs, except for those needed in the
>    current operation (e.g. checkout).
>
>    When not using sparse checkout, the main benefit out of the box is
>    avoiding downloading *historical versions* of large blobs.
>

> It sounds like you are looking for a sort of placeholder outside the
> sparse checkout area.

True.

> In a way, that's orthogonal to these patches:
> even if you have all relevant blobs, you may want to avoid inflating
> them to check them out and reading them to compare to the index (i.e.
> the usual benefits of sparse checkout).

In my concept, it should be possible to create the ('sparse'/narrow) index 
from the content of the local object store, without any network connection 
(though that content is determined by the prior fetch/clone;-). The proper 
git sparse checkout could proceed from there as being a further local 
restriction on what is omitted from the worktree.

Those missing from the narrow clone would still show as place holders with 
content ".gitnarrowtree 13a24b..<oid>" (so we know what the hash oid of the 
file/tree should be (so they can be moved/renamed etc!). The index would 
only know the content/structure as far as the place holders (just like 
sub-modules are a break point in the tracking, with identical caveats)


It would be interesting to know from Ben the level of sparseness/narrowness 
has been seen typically in the BigWin GVFS repo case.

>  In a sparse checkout, you
> still might like to be able to get a listing of files outside the
> sparse area (which you can get with "git ls-tree") and you may even
> want to be able to get such a listing with plain "ls" (as with your
> proposal).
>
> Thanks and hope that helps,
> Jonathan

Thanks, yes. It has help consolidate some of the parts of my concept that 
has been in the back of my mind for a while now.

Philip 

