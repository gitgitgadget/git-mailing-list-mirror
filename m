Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AB901F461
	for <e@80x24.org>; Fri, 12 Jul 2019 18:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfGLSVy (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 14:21:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51016 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLSVy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 14:21:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4892E70BB4;
        Fri, 12 Jul 2019 14:21:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LkvTjQ0Jlm12AzXscyOKdIsg160=; b=lqvJw8
        EdhnNN8jEHxe4CL3c1TiZNC6UNywY/Wokg7hlDLwUMh8YKoLNZVBr5Ds1Gx43NAz
        4Grjbl+gtc4Gvj5NqdZ/JSi/mAldyOko2TiTuc+in1Q/bzrSOAXq7/ipBVYKc36z
        5lnweVnZbN9c1VW5Ds6d5iPRQyU0vPTls7VdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZQBg+GAXeBBngLENE3d50KaxUoZ4yqjz
        YkJCPxGlJYZitKTlAAAOkvJWXF8HXZqw1+einaMqOhW/PypeSuyz+GvCu9WGNXfa
        jOSVqR2qLb7BMJnn6Ggp2QBbjdrvXmFjBwn+0ubX9wzV0KbmwdwnILQ26wGlMedN
        16WtJ5aUv7g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 407EE70BB3;
        Fri, 12 Jul 2019 14:21:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 648F270BB1;
        Fri, 12 Jul 2019 14:21:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 0/5] oidmap: handle entries with the same key
References: <20190707083002.7037-1-chriscool@tuxfamily.org>
        <xmqqd0ikxok6.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 12 Jul 2019 11:21:47 -0700
In-Reply-To: <xmqqd0ikxok6.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 08 Jul 2019 13:24:09 -0700")
Message-ID: <xmqqlfx3p0zo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA1B4E7C-A4D1-11E9-833A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> This is an RFC patch series that is not intended to be merged for now,
>> as it looks like we don't need oidmaps that can handle several entries
>> with the same key yet.
>
> What does it even mean for a map to allow multiple entries per key?

Ah, one thing that I was missing (perhaps it was obvious to
everybody else but me X-<) was that this is merely to expose what is
already available in the underlying hashmap API, so let's not bother
with the "don't people usually do a single key to a value, which
happens to be a bag of stuff (not just a single stuff)?" question.

And from that "a generic hashmap can do this, and an upcoming code
needs to use a hashmap keyed with oid in the same fashion" point of
view, the new wrappers the patches add all made sense to me.

>> As I needed this for my work on reftable, I thought that...
>
> I actually think that showing how it is used in the real application
> (reftable?) is the best way to illustrate why this is useful and to
> get opinions from others.

This part still stands, though.

Thanks.
