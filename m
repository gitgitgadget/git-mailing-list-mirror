Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47280C433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFAE2053B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cCQ2uuZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbgG1Qks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:40:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60863 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgG1Qks (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:40:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B84EE817A;
        Tue, 28 Jul 2020 12:40:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gjmPonw+/gG69vXOGkz6lp2kpzc=; b=cCQ2uu
        ZCAgFpLwrOr6+pyYRBjo8dDXNLJ5HT/SXCu4exQxuXF6lZufNGZvA1jV3WBYWLMU
        HjivRgJ5FP2DQK9XXo/tlyBB1HEzCjfHhKa4LXvpZ4U4zaiYNX+SYSwxvi3FwKIG
        Tn+at5myKMkzNW9RczKv0FMnRQeOJZ/u2YzHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qqe7qwSPIaiB0Sqj20lAqKW1Im1xgMGM
        g6qYm0shzSK1zDQ5Kh+rW0eSUWp4TmbuymJwU/FQxYMOS0r+t4uQqyYHcQ1kumCW
        NFa7PAsOWCll1U43np/P5mZWRhCkpzvEVuqZ/hisjsAIFkpyZFcNdHsCe1xqIvFl
        HzGu8dyVGgg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03AA7E8179;
        Tue, 28 Jul 2020 12:40:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EE8B2E8177;
        Tue, 28 Jul 2020 12:40:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Anders Waldenborg <anders@0x63.nu>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
References: <87blk0rjob.fsf@0x63.nu> <xmqqr1swg9lc.fsf@gitster.c.googlers.com>
        <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
        <87a6zkr5z7.fsf@0x63.nu>
        <CAP8UFD1JZhNVDJ=fe-FLzmBqSbAwyaJuABK-G+-keL4LanZbpA@mail.gmail.com>
        <20200728154132.GA817108@coredump.intra.peff.net>
Date:   Tue, 28 Jul 2020 09:40:40 -0700
In-Reply-To: <20200728154132.GA817108@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Jul 2020 11:41:32 -0400")
Message-ID: <xmqqmu3jegon.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 136EA16A-D0F1-11EA-89F7-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's inevitable that you'll have to do some data cleanup like that
> anyway. Lumping together prefixes isn't flexible enough to coverall
> cases. Using trailer.*.key to manually map names covers more, but again
> not all (e.g., if the project used to use "foo" but switched to "bar",
> but the syntax of the value fields also changed at the same time, you'd
> need to normalize those, too).
>
> So to me it boils down to:
>
>   - returning the data as verbatim as possible when reading existing
>     trailers would give the least surprise to most people
>
>   - real data collection is going to involve a separate post-processing
>     step which is better done in a full programming language

Yeah, I agree that these are good guidelines to use when we think
about the feature.

> The original %(trailers) was "dump the trailers block verbatim". But
> that's not super useful for parsing individual trailers. So "only"
> actually starts parsing the individual trailers. I'd argue that the
> %(trailers) behavior is correct, but that %(trailers:only) should
> probably be doing less (i.e., just parsing and reporting what it finds,
> but not changing any names).

Yes, sounds sensible.
