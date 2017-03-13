Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5788B20373
	for <e@80x24.org>; Mon, 13 Mar 2017 22:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbdCMWTy (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 18:19:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52390 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752941AbdCMWTv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 18:19:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8395086182;
        Mon, 13 Mar 2017 18:19:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DW30pbWPb11Km+nIMHMV7hUcCho=; b=Xz0Pdm
        hDUPvyJq4es8MBbfql3tsS2ypmnty4qoAGPQ+MZrexD3AWKgk+1kgOHBSQtN9PZ+
        43GUJBeOSe/+CERbH4YIPmAKm5HUXBQTP9fjHfuLp79WuyTc7pyA2mwROHvTMMBx
        f0UUKe5PnRHfd1glmpbBauf1HlcRbnTfoIcbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cJyEg1/HY4V6m5n7ZSHkIifa1cgN3PWH
        OxRMeeR++S9gCzNSZO5JXQAeH/KXTPspkzhP7xMSiLAJnUEFiosM+STAoLA86JgH
        wdYdwoDnAGEL/wnPbo0dkURnWFVmWTL7enolB6JMWI0WPPhUzr9XlK1kuK/W0fib
        tuilf+erWCY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C85686181;
        Mon, 13 Mar 2017 18:19:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EAB178617E;
        Mon, 13 Mar 2017 18:19:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Domagoj Stolfa <domagoj.stolfa@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible git blame bug?
References: <20170313201104.GA32821@workstation>
        <xmqqmvcorjyo.fsf@gitster.mtv.corp.google.com>
        <CAPc5daVRX_-bJ_2reDLKJin9PNfy6EjbD14T=Mpx=9P8xzdmuw@mail.gmail.com>
        <20170313214400.GA98717@workstation>
Date:   Mon, 13 Mar 2017 15:19:47 -0700
In-Reply-To: <20170313214400.GA98717@workstation> (Domagoj Stolfa's message of
        "Mon, 13 Mar 2017 22:44:00 +0100")
Message-ID: <xmqqfuign7jw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BD75300-083B-11E7-B1F0-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Domagoj Stolfa <domagoj.stolfa@gmail.com> writes:

> For example, saying:
>
> $ git blame time.h --since=2017
> ^e19f2a27ed8 (Domagoj Stolfa 2017-03-12 20:43:01 +0100  33) #ifndef _SYS_TIME_H_
>
> $ git blame time.h --since=2016
> ^21613a57af9 (bz  2016-03-13 21:26:18 +0000  33) #ifndef _SYS_TIME_H_
>
> $ git blame time.h --since=2015
> ^48507f436f0 (mav 2015-03-13 21:01:25 +0000  33) #ifndef _SYS_TIME_H_
>
> and so on, with different hashes.

The output lines "^deadbeef" does *NOT* mean that commit deadbeef
changed the revision.  It just is telling you that the hisory was
dug down to that revision and it was found that since that revision
there is no change (and you told the command not to bother looking
beyond that time range, so we do not know what happened before that
time).

It is understandable, when your history has a lot of merges, the
history traversal may stop at commits on different branches.

Imagine a case where the line in question never changed throughout
the history:

          o---o---B
         /         \
    O---o---o---A---C---o---o

Imagine A is from 2015, B is from 2016 and C is from 2017.  C's
first parent, i.e. C^1, is A and C^2 is B.

If you ask the command to stop digging when you hit a commit on or
before 2017-03-13 (03-13 is because today's date is appended to your
2017), your traversal will stop at C and you get a line that begins
with ^C.

If you ask it to stop at 2016, A won't be even looked at because it
is older.  The command will keep digging from C to find B.  If B's
parent is also newer than the cutoff, but its parent is older, then
the line will be shown with ^ and commit object name of B's parent.

If you ask it to stop at 2015, the command will first consider A
(C's earlier parent) and pass blame to the lines common between
these two commits.  In this illustration, we are pretending that the
file did not change throughout the hsitory, so blame for all lines
are passed to A and we don't even look at B.  Then we keep digging
through A to find the culprit, or hit a commit older than the
specified cut-off time.  The line will be shown with ^A or perhaps
its ancestor.

So it is entirely sane if you saw three boundary commits named with
three different time ranges.

