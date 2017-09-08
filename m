Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C432082D
	for <e@80x24.org>; Fri,  8 Sep 2017 12:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755517AbdIHMpC (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 08:45:02 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:54743 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755036AbdIHMpB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 08:45:01 -0400
X-AuditID: 1207440f-a5bff70000007960-4e-59b290cc34d7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 73.18.31072.CC092B95; Fri,  8 Sep 2017 08:45:00 -0400 (EDT)
Received: from [192.168.69.190] (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Cive6031698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 08:44:58 -0400
Subject: Re: [PATCH 08/10] files_ref_store: use a transaction to update packed
 refs
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <25b38730abe97c29d04116b4b2c6067934dfca14.1503993268.git.mhagger@alum.mit.edu>
 <20170908073816.lnlq6lpabtiu7rra@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <21ec2708-e8e2-8503-fe90-48a70c802cc6@alum.mit.edu>
Date:   Fri, 8 Sep 2017 14:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170908073816.lnlq6lpabtiu7rra@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqHtmwqZIg68zdC3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC26p7xltPjR0sNssXlzO4sDu8fOWXfZPRZsKvV41ruH0ePiJWWPz5vkAlij
        uGxSUnMyy1KL9O0SuDIebVvDWjBVq+LBnHXMDYz3FLsYOTgkBEwkLh4q7GLk4hAS2MEk8eLp
        ZUYI5zyTxL4zZ1i7GDk5hAVCJXpOPmIDsUUEZCW+H94IVsQssIVJ4t3cDnaIjkOMEr+frmIC
        qWIT0JVY1NMMZvMK2Et8mX2fCWQdi4CKRPP/dJCwqECERN/by+wQJYISJ2c+YQGxOQVcJLbu
        bQBrZRZQl/gz7xIzhC0ucevJfKi4vMT2t3OYJzAKzELSPgtJyywkLbOQtCxgZFnFKJeYU5qr
        m5uYmVOcmqxbnJyYl5dapGuil5tZopeaUrqJERIN/DsYu9bLHGIU4GBU4uFd4b0pUog1say4
        MvcQoyQHk5Ior0wPUIgvKT+lMiOxOCO+qDQntRgYChzMSiIQOd6UxMqq1KJ8mJQ0B4uSOK/6
        EnU/IYH0xJLU7NTUgtQimKwMB4eSBC8XMOqFBItS01Mr0jJzShDSTBycIMN5gIbrg9TwFhck
        5hZnpkPkTzEqSonzavYDJQRAEhmleXC9sGT1ilEc6BVh3nsgVTzARAfX/QpoMBPQ4JLnG0AG
        lyQipKQaGJdv7800+xfYdJD1hu2cyKbgasWPKYs3fV+tVsL0yEwjdEV6i9Pdg56RpUezZa2i
        5/95eKrv/oOvUW7tdasndHJK89U0fvjvpBn3N/aF/9JF4f37onJts6ZLd2Z//Kdax/WvROz2
        /xecUwM2lp7j0smYfqy4LYT1dmhcbeWmz0ee9PpsKr0lqMRSnJFoqMVcVJwIADCGLncxAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/2017 09:38 AM, Jeff King wrote:
> On Tue, Aug 29, 2017 at 10:20:32AM +0200, Michael Haggerty wrote:
> 
>> First, the old code didn't obtain the `packed-refs` lock until
>> `files_transaction_finish()`. This means that a failure to acquire the
>> `packed-refs` lock (e.g., due to contention with another process)
>> wasn't detected until it was too late (problems like this are supposed
>> to be detected in the "prepare" phase). The new code acquires the
>> `packed-refs` lock in `files_transaction_prepare()`, the same stage of
>> the processing when the loose reference locks are being acquired,
>> removing another reason why the "prepare" phase might succeed and the
>> "finish" phase might nevertheless fail.
> 
> That means we're holding the packed-refs lock for a slightly longer
> period. I think this could mean worse lock contention between otherwise
> unrelated transactions over the packed-refs file. I wonder if the
> lock-retry timeout might need to be increased to accommodate this. On
> the other hand, it looks like we take it after getting the individual
> locks, which I'd think would be the expensive part.

That was my thinking, yes. While the packed-refs lock is held, the
references being created/updated have their reflogs written and are
renamed into place. I don't see how that can be shortened without
compromising on correctness (in particular, that we want to process
creates/updates before deletions to try to preserve reachability as much
as possible during the transaction). As an added optimization, the
packed-refs lock is not acquired at all if no references are being deleted.

> Are there other callers who take the packed-refs and individual locks in
> the reverse order? I think git-pack-refs might. Could we "deadlock" with
> pack-refs? There are timeouts so it would resolve itself quickly, but I
> wonder if we'd have a case that would deadlock-until-timeout that
> otherwise could succeed.

That's not true. `files_pack_refs()` does the following:

1. Lock the `packed-refs` file.

2. Start a packed ref-store transaction.

3. Iterate over the loose ref cache. For each reference that should
   be packed:
   * add it to the packed-refs transaction as an update to set it
     to the loose value (without specifying an old_sha1)
   * if pruning is on, schedule the loose reference to be pruned
     (in an internal data structure, without locking the file).

4. Commit the packed ref-store transaction.

5. Release the packed-refs lock.

6. For each to-prune loose ref:
   * lock the loose reference
   * verify that it still has the value that was just written to
     the `packed-refs` file
   * if so, delete the loose version of the reference
   * unlock the loose reference

The packed-refs file and loose references are never locked at the same
time during pack-refs, so no deadlock is possible.

But you are right to assume that it *should* be so. The algorithm
written above is a tiny bit unsafe (and has been for years). It is
possible, though admittedly very unlikely, for the following to happen
in the gap between steps 5 and 6:

1. One process updates the value of branch "foo" from A to B.
   (Remember that A is the value that was just written to the
   `packed-refs` file by step 4.)

2. `pack-refs` is run *again* (while the first `pack-refs` is out
   on its lunch break), writes value B to the `packed-refs` file
   for "foo", and deletes the loose version of "foo".

3. Yet *another* process changes "foo" back from B to A. This
   creates a loose version of "foo" with value A, which overwrites
   the packed version with value B.

4. The first `pack-refs` process resumes at step 6, sees that
   "foo" "still" has the value "A", so deletes the loose reference.

This would leave "foo" at the obsolete value "B" (i.e., the value
written to the `packed-refs` file for it by the nested `pack-refs` process.

I think that fixing this problem would require the `packed-refs` lock to
be held while `pack-refs` is pruning the loose references. But given how
unlikely that chain of events seems, and that fixing it would increase
contention on the `packed-refs` file and allow the deadlock that you
described, I lean towards leaving it as-is. Though admittedly,
contention over a loose reference lock could make the race more likely
to be hit.

I also just noticed that the `refs_to_prune` linked list is leaked here
(as has also been the case for many years). I'll fix that separately.

>> Second, the old code deleted the loose version of a reference before
>> deleting any packed version of the same reference. This left a moment
>> when another process might think that the packed version of the
>> reference is current, which is incorrect. (Even worse, the packed
>> version of the reference can be arbitrarily old, and might even point
>> at an object that has since been garbage-collected.)
>>
>> Third, if a reference deletion fails to acquire the `packed-refs` lock
>> altogether, then the old code might leave the repository in the
>> incorrect state (possibly corrupt) described in the previous
>> paragraph.
> 
> And to think I had the hubris to claim a few weeks ago that we had
> probably weeded out all of the weird packed-refs inconsistency and
> race-condition bugs. :)

Haha, job security.

Michael
