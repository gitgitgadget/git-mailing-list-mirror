Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43F51F461
	for <e@80x24.org>; Wed,  3 Jul 2019 18:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfGCSK0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 14:10:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61486 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfGCSK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 14:10:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B3ED1537E9;
        Wed,  3 Jul 2019 14:10:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3gQ2mjY2W/BQcmCBroDQRKR0x08=; b=sicRbT
        l4IwDFvr4OsqQIm8XK3weBJyKQTyfUOvbiq2I01q7nAb41Wg/w7mXchldHXhNkVf
        f2smpOn1Nl0r6lrOEpYFvBj9bSZpZ1kewhT26krXehg/GWaB0X2tgljeds/3EAJt
        sanYeBd7+0KBM3xdWRuqAuJOVTJoSX485r+Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WKSohFD6ysuIbM9EDT8oppjFSVrtsv2W
        D9efETPVb3iYyIKFmG59I8w9ADG7oUDAm40Jvj+p6cUbnjRSLnhIWTp7WdjS4cFm
        FjXr8Wf+dc4eN6mPpFnwTkhFprCv4EhV9JrVWIv0p1uDBi/2TPfyL3a1FFY5Bvvr
        TXxxMWD478M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22E661537E8;
        Wed,  3 Jul 2019 14:10:24 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 786C01537E7;
        Wed,  3 Jul 2019 14:10:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Janos Farkas <chexum@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] repack: warn if bitmaps are explicitly enabled with keep files
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
        <875zow8i85.fsf@evledraar.gmail.com>
        <20190623180226.GA1100@sigill.intra.peff.net>
        <20190623180825.3ospajjgat3clwiu@dcvr>
        <20190623224244.GB1100@sigill.intra.peff.net>
        <20190628070211.hfweqcons6c6gy52@dcvr>
        <87zhm26uq9.fsf@evledraar.gmail.com>
        <20190629191600.nipp2ut37xd3mx56@dcvr>
        <xmqq7e917h9x.fsf@gitster-ct.c.googlers.com>
        <20190703173814.GA29348@sigill.intra.peff.net>
Date:   Wed, 03 Jul 2019 11:10:22 -0700
In-Reply-To: <20190703173814.GA29348@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 3 Jul 2019 13:38:14 -0400")
Message-ID: <xmqqftnn0z1t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D38D001C-9DBD-11E9-9679-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>
> A much more robust solution would be to stop conflating user-provided
> permanent .keep files with temporary locks. I think that was a mistaken
> design added many years ago. We probably could introduce a different
> filename for the temporary locks (though I am not entirely convinced
> they are necessary in the first place, as gc expiration-times would
> generally save a racily-written packfile anyway).

True, true (and I tend to agree).

> Or perhaps we could differentiate our temporary locks from "real" .keep
> files by looking at the content; I think our locks always say something
> like "(receive|receive)-pack \d+ on .*", and it wouldn't be too onerous
> to commit to that, I think (or even adjust it to something even more
> unambiguous).

True, but it may be overkill to open and read.

> It does muddy the meaning of packed_git.pack_keep a bit.  Some callers
> would want to consider it kept in either case (i.e., for purposes of
> pruning, we delete neither) and some would want it kept only for
> non-locks (for packing, duplicating the objects is OK). So I think we'd
> end up with two bits there, and callers would have to use one or the
> other as appropriate.

Yeah, I agree that we'd need to treat them separately in the longer
run.

Thanks.
