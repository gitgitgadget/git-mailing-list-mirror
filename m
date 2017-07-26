Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE4A02047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdGZXtg (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:49:36 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45525 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751078AbdGZXtf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Jul 2017 19:49:35 -0400
X-AuditID: 1207440e-743ff70000000b23-71-59792a8e795f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9D.E9.02851.E8A29795; Wed, 26 Jul 2017 19:49:34 -0400 (EDT)
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com [209.85.214.44])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v6QNnX0w013811
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 19:49:34 -0400
Received: by mail-it0-f44.google.com with SMTP id v127so18012196itd.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 16:49:34 -0700 (PDT)
X-Gm-Message-State: AIVw110idld+D8k7w/vOHNBTKR029lR7RJ6tFCg67DGghVtVRqdya6eN
        RNjrGgIsjkLXfMq/abbM3wAGJvEC7g==
X-Received: by 10.36.181.85 with SMTP id j21mr2888042iti.165.1501112973808;
 Wed, 26 Jul 2017 16:49:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Wed, 26 Jul 2017 16:49:33 -0700 (PDT)
In-Reply-To: <xmqqzibtbje5.fsf@gitster.mtv.corp.google.com>
References: <cover.1497534157.git.mhagger@alum.mit.edu> <2779ee9a75e75ff80898e51e46d561b8074e0dc2.1497534157.git.mhagger@alum.mit.edu>
 <xmqqy3riiu0f.fsf@gitster.mtv.corp.google.com> <20170720233051.GB159617@aiede.mtv.corp.google.com>
 <xmqqpocuib06.fsf@gitster.mtv.corp.google.com> <20170724165907.53zx657qmizgl4lb@sigill.intra.peff.net>
 <20170724170915.GD13924@aiede.mtv.corp.google.com> <20170724171046.rcq2vqqzikto4lbi@sigill.intra.peff.net>
 <xmqqzibtbje5.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Wed, 26 Jul 2017 16:49:33 -0700
X-Gmail-Original-Message-ID: <CAMy9T_Hj5sYwwoA4mBZFbUmriAzSaW4VWYwB3F-3DQ-6UpBU3A@mail.gmail.com>
Message-ID: <CAMy9T_Hj5sYwwoA4mBZFbUmriAzSaW4VWYwB3F-3DQ-6UpBU3A@mail.gmail.com>
Subject: Re: [PATCH 21/28] commit_packed_refs(): use a staging file separate
 from the lockfile
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42IRYndR1O3Tqow0OHzexqLrSjeTA6PH501y
        AYxRXDYpqTmZZalF+nYJXBlf78gV/OGp2Hn4G2MD426uLkZODgkBE4mntxrYuxi5OIQEdjBJ
        /No9jwUkISTwiEli5bwKiEQ/o8Sree+Yuhg5gDryJfYcFYVoLpZYfPY1G4jNKyAocXLmE6he
        OYlXG24wQtjeEl+fPgKLcwpYS/SdfsIGMfMTs8Sa7SvBEmwCuhKLeprB5rMIqErcvW8EMT9R
        ouPnT1aQMK9AgMSfDyogprBAgsTB34YgFSICahIT2w6xgExkFpjFLHHg7n92kASzgKZE6/bf
        7BMYhWchuW4WktQCRqZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrGermZJXqpKaWbGCHhy7eD
        sX29zCFGAQ5GJR7eFVMqIoVYE8uKK3MPMUpyMCmJ8k4yBQrxJeWnVGYkFmfEF5XmpBYfYpTg
        YFYS4RVSqIwU4k1JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8C7QBGoU
        LEpNT61Iy8wpQUgzcXCCDOcBGn4JpIa3uCAxtzgzHSJ/itGY48qVdV+YOKYc2P6FSYglLz8v
        VUqct1UDqFQApDSjNA9uGiwFvWIUB3pOmJcHmJCEeIDpC27eK6BVTECr5swoBVlVkoiQkmpg
        FPiuWWR5efXaWVyS3y7vilM/bN+iw1Td+TOlXcfgf7JJzyydY/PttDpCu1/6vjh4wSpUi5fZ
        6Y7DqvjkFXVKf2vZP3nrurLe3Ckm5MGWddWHvUZGgFFfTWNVm5WFb0jhq3LWOcdUnjS+SfUL
        uOMsZubkbaxzuVRIO/kRp5tbUpunmZDCAyWW4oxEQy3mouJEAHIkFGMcAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just submitted a patch [1] that fixes the `packed-refs`-is-a-symlink
problem in combination with git-new-workdir.

I haven't considered any possible problems related to
`core.preferSymlinkRefs`. That behavior should be unaffected by the
packed-ref-store patch series and I'm not very interested in working
on it.

Michael

[1] https://public-inbox.org/git/d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu/

On Mon, Jul 24, 2017 at 2:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Mon, Jul 24, 2017 at 10:09:15AM -0700, Jonathan Nieder wrote:
>>
>>> Jeff King wrote:
>>>
>>> > This seems like the correct path to me. If the existing behavior is to
>>> > lock the referring symref, that seems like a violation of the lock
>>> > procedure in the first place. Because if "A" points to "B", we take
>>> > "A.lock" and then modify "B". But "B" may have any number of "A" links
>>> > pointing to it, eliminating the purpose of the lock.
>>> >
>>> > I thought we already did this, though. And that modifying HEAD (which
>>> > might be a symlink) required LOCK_NO_DEREF.
>>>
>>> Yes, I believe the lockfile API already does so.  Since this patch
>>> creates a ".new" file, not using the lockfile API, it doesn't benefit
>>> from that, though.
>>
>> Ah, I see. This bug makes much more sense, then. And I agree doubly that
>> matching the lock-code's behavior is the right thing to do.
>
> OK.  Anybody wants to take a crack at it (it is of lower priority to
> me during the -rc freeze to deal with problems in topics on 'next'
> or higher)?
>
> Thanks.
