Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8671F453
	for <e@80x24.org>; Thu, 25 Apr 2019 07:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbfDYHQ6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 03:16:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55915 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbfDYHQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 03:16:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD7CE6B100;
        Thu, 25 Apr 2019 03:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IUtPmPcZtaaj
        w/lN63v2zI3R8k0=; b=lTbHklOB2r8U4MD05R24AJnE7rTwfGttJdrncOUJXI4a
        maiY/yULnSVuDFLmwjS3noMqBzbNQ5MHXV5B9OsHSeByDIiDGHlvpoYFSPWR4AqO
        Arz/0OlTSNJKxa0L38IKSQCvBve9DcdvtvvS8h2PORDpQKZcRijwMVlXnpDOrVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JHT0JD
        VvC83yu8T4LI9aH97oTiGQe79FOU0ScpsCDCMmyTGbDsM65sDC2Szb0CEvdE7yrs
        0BHvV4wpEkzwgdLCvnmj43lt9vTMM1uUpiCRPoVTqmKpUaULw7dr0S9gFWTVsV1D
        R6zhpaoEB4gJ5sQDu57XW70nLPCQr29WuZqxk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C5C396B0FF;
        Thu, 25 Apr 2019 03:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 011756B0FB;
        Thu, 25 Apr 2019 03:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
References: <20190214043127.GA19019@sigill.intra.peff.net>
        <20190214043743.GB19183@sigill.intra.peff.net>
        <20190309024944.zcbwgvn52jsw2a2e@dcvr>
        <20190310233956.GB3059@sigill.intra.peff.net>
        <20190312031303.5tutut7zzvxne5dw@dcvr>
        <20190312104954.GA2023@sigill.intra.peff.net>
        <20190313015133.n7f7lyujnlwfytre@dcvr>
        <20190313145417.GA24101@sigill.intra.peff.net>
        <20190314091254.nescpfp3n6mbjpmh@dcvr>
        <87zhoz8b9o.fsf@evledraar.gmail.com>
        <20190410225721.GA32262@sigill.intra.peff.net>
Date:   Thu, 25 Apr 2019 16:16:46 +0900
In-Reply-To: <20190410225721.GA32262@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 10 Apr 2019 18:57:21 -0400")
Message-ID: <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 17637C28-672A-11E9-AC0F-EE24A11ADF13-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Apr 09, 2019 at 05:10:43PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> I've found a case where turning bitmaps on does horrible things for
>> bitmap "push" performance.
>> [...]
>> I can't share the repo, but I had a report where just a "git push" of =
a
>> topic branch that was 2/58 ahead/behind took ~2 minutes just in
>> "Enumerating objects", but ~500ms without bitmaps.
>
> That's pretty bad, though I'm not terribly surprised.

I was revisiting the recent "What's cooking" report, and I am not
sure what the current status of the topic is.

I do not get a feel that the current bitmap implementation has been
widely used in repositories that have vastly different access
patterns---it probably has been tried only by those who can afford
the engineering cost to see if the implementation happens to work
well for their workload and some may have chosen to adopt it while
others didn't.  So it may be very well tuned for the former people
but once we merge this topic down, we'll hear from others with quite
different workload, which may lead to us tuning the code to bit
better to their workload while not hurting other existing users,
hopefully.

Or not.

I am somewhat tempted to make things more exciting by merging it to
'next' soonish, but I guess =C3=86var and you are not quite ready for
that excitement yet, judging from the following (which looks quite
sensible suggestions)?

Thanks.

> Yeah, that makes sense. By repacking you've taken all those new commits
> and included them in on-disk bitmaps. So I'd expect the "wants" to get
> much shorter, but the "haves" phase staying long means we could do a
> better job of picking commits to have on-disk bitmaps.
>
> So two avenues for exploration I think:
>
>   1. I've long suspected that the bitmap selection code isn't ideal.
>      Both in terms of what it picks, but also in its runtime (I think i=
t
>      ends up walking the same slices of history multiple times in some
>      cases).
>
>   2. The answer we get from a bitmap versus a regular traversal are not
>      apples-to-apples equivalent. The regular traversal walks down to
>      the UNINTERESTING commits, marks the boundaries trees and blobs as
>      UNINTERESTING, and then adds in all the interesting trees and blob=
s
>      minus the UNINTERESTING parts. So it can sometimes give the wrong
>      answer, claiming something is interesting when it is not.
>
>      Whereas with bitmaps we fill in the trees and blobs as we walk, an=
d
>      you get the true answer. But it means we may open up a lot more
>      trees than the equivalent traversal would.
>
>      So one thing I've never really experimented with (and indeed, neve=
r
>      really thought about until writing this email) is that the bitmaps
>      could try to do that looser style of traversal, knowing that we
>      might err on the side of calling things interesting in a few cases=
.
>      But hopefully spending a lot less time opening trees.
>
>      I'm not even 100% sure what that would look like in code, but just
>      thinking about it from a high level, I don't there's a particular
>      mathematical reason it couldn't work.
>
> -Peff
