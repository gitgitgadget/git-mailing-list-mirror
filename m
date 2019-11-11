Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC951F454
	for <e@80x24.org>; Mon, 11 Nov 2019 09:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKJBv (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 04:01:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55347 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJBu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 04:01:50 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B3D58573B;
        Mon, 11 Nov 2019 04:01:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GVs7Q4Lsh1XNo27S11IEBFfVwJ8=; b=r8qRwi
        jq+bnNaB3kn8y3Q+t0IsSiUw4EUskATf/+UR8gRRmx2VnJ7mnMdlu8C54vgkJzfW
        Y/5VWTQJd/bdiWMDPlpB6J/A5t0KcZ4EnLpPHP/PheFUf/KTvNe+29oy/2VpzUsR
        bl7xFWzC4RnC5EsYW8mACL9HKUwaQRmaHEHYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nu5cFrsoyM54OwuVzo8etB/9uhE/brl3
        7HGJ3f57MNnSRZ60iq2XqKBxM7XF8VXBevonsevnYGbg5UTOI/XjmGDUXkq6NB5T
        vG5KrI9kgsTo9Grn2dnvUAxmi2yGjEyVHfHj8Yxcub9UdOhNYvrXzjcRX7YL/6+S
        3Vyk54HQbF8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 529CA8573A;
        Mon, 11 Nov 2019 04:01:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 82F5A85739;
        Mon, 11 Nov 2019 04:01:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 2/3] bundle-create: progress output control
References: <1f7f0aa1e8fae54bf967ae83a160be2b30db634f.1573248640.git.gitgitgadget@gmail.com>
        <20191110204126.30553-1-robbat2@gentoo.org>
        <20191110204126.30553-2-robbat2@gentoo.org>
        <20191111040750.GB6379@sigill.intra.peff.net>
        <robbat2-20191111T065646-317702456Z@orbis-terrarum.net>
        <20191111081047.GA17861@sigill.intra.peff.net>
Date:   Mon, 11 Nov 2019 18:01:45 +0900
In-Reply-To: <20191111081047.GA17861@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 11 Nov 2019 03:10:47 -0500")
Message-ID: <xmqqv9rqhjly.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E438FED8-0461-11EA-B63C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 11, 2019 at 07:28:55AM +0000, Robin H. Johnson wrote:
>
>> > Do we need all four of these?
>> I copied the exact set of messages from git-pack-objects, and I do think
>> the same set makes sense specifically to mirror pack-objects for the
>> moment.
>
> I'm not sure I agree. In what situation would anybody use "git bundle
> create --all-progress-implied", for example? Literally no other Git
> command except pack-objects has "--all-progress" or
> "--all-progress-implied" (even ones which call pack-objects under the
> hood to print the progress!), and the presence of the latter in
> pack-objects is due to a backwards-compatibility thing in the early days
> (where --all-progress did too many things, but we could no longer change
> it). I think it would be a mistake to spread it further.

I am quite cure I agree with your reasoning that we would want to
limit the "--all-progress-implied" craziness from spreading ;-)

Thanks.
