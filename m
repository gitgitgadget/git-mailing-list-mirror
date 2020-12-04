Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD51C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD78022CA0
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgLDThv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:37:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51413 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbgLDThv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:37:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDA81A8F61;
        Fri,  4 Dec 2020 14:37:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a6NRS+QcnMdrLdhhyymAIMkQ12E=; b=xixggF
        MII8WdHX7jU8eVWJmRuLXlTthCy9Sxv8ZyS9kgYW1znpAElY1jZvG7Ea8P2E+Dn8
        X22edGSwZ2nJ3vZBkgAj0oGw6cs42puB3vD41zIqvWv1a4OSM3thsx+AA8wa6xyw
        VTXaHi0/qxNtg1uuBMY2oT5TmC2XPKe7jIizU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nf+6x/U7Fu5ceZLN3LWEz1G7s2NMG/bz
        LKa3rO/qmWvGIUeKnib8Q0mdPlxdBTtdIC1ZqwFCXUWAP85DMwZSnFoVVJ23LifU
        94MbWPEUzHymzkfmiNIZPxls7RZbJsYtSwFLhgE1UvjD/ytZAqJ0pCpmBfKKGCVh
        RkOIfI41jNM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD5E5A8F60;
        Fri,  4 Dec 2020 14:37:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 505B2A8F5D;
        Fri,  4 Dec 2020 14:37:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Git <git@vger.kernel.org>,
        "Raymond E. Pasco" <ray@ameretat.dev>, Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is
 not set either
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
        <20201125020931.248427-2-alexhenrie24@gmail.com>
        <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
        <CAMP44s1Hwun+P=j5BBbVUT-ACS4hJCyRCJT-=6WvwK913fXq7g@mail.gmail.com>
        <xmqq7dpyix1d.fsf@gitster.c.googlers.com>
        <xmqqmtyuhemi.fsf@gitster.c.googlers.com>
        <xmqqpn3qfhps.fsf@gitster.c.googlers.com>
        <CAMP44s02N9LJxi_eme8+nqEQameKtpNJtTXWDT2q3_EPV09gag@mail.gmail.com>
Date:   Fri, 04 Dec 2020 11:37:06 -0800
In-Reply-To: <CAMP44s02N9LJxi_eme8+nqEQameKtpNJtTXWDT2q3_EPV09gag@mail.gmail.com>
        (Felipe Contreras's message of "Fri, 4 Dec 2020 00:37:28 -0600")
Message-ID: <xmqqh7p1fjml.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18AE972A-3668-11EB-9FEE-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> What we want to see can be done without such backward incompatible
>> changes, e.g. declaring the combination of "--ff-only" and
>> "--[no-]rebase" incompatible and/or the last one wins, I would say,
>> and I suspect Alex's RFC was an attempt to make the first step in
>> that direction.
>
> It's debatable whether or not that is "backwards incompatible".
>
> Currently "--no-rebase --ff-only" fails if the merge is
> non-fast-forward. With the proposed change of semantics it would work.
> That's a change.

But with such a change, "--ff-only --no-rebase" would work by
ignoring the "I want to reject non-ff situation" request from the
user, no?

> Keep in mind the whole point of the changes: to make --ff-only the
> default.

Sorry, I know you keep repeating that "keep in mind", but I do not
quite see why anybody needs to keep that in mind.  Has a concensus
that the repurposed --ff-only should be the default been
established?


