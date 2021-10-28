Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68110C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C986610E7
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhJ1Qrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:47:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64090 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhJ1Qrq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:47:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D48ED16185A;
        Thu, 28 Oct 2021 12:45:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+tfVQ6jrPow63w1RsdF8eg6X68EL5fJFTNFBvB
        Gzhwo=; b=U0Sqr/hroBC/oIoUEby1adA30tzngGmEICEWaysMMsoqTrI01KaQXq
        hg7kdci8hChURA91X87POBZqXfgmDitJKp/v0OkKubo22OVpywAB++tb1kqkmqcz
        q1QRemOxKf3RwU68nD5WQG8CGh/gvGTX+dOCs3g67IEGjIieCC/9M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCC0F161859;
        Thu, 28 Oct 2021 12:45:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 18042161858;
        Thu, 28 Oct 2021 12:45:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Documentation/Makefile: fix lint-docs mkdir dependency
References: <YXeu4Hl2cmIPqobd@coredump.intra.peff.net>
        <xmqqlf2et3r3.fsf@gitster.g>
        <211028.861r45y3pt.gmgdl@evledraar.gmail.com>
        <YXq1OE/p5VoPR3WZ@coredump.intra.peff.net>
Date:   Thu, 28 Oct 2021 09:45:14 -0700
In-Reply-To: <YXq1OE/p5VoPR3WZ@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 28 Oct 2021 10:35:36 -0400")
Message-ID: <xmqqzgqtrtd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D99ADE4-380E-11EC-AD1E-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There's an in-between, I'd think, where the many "foo/bar/baz/$@"
> targets have an order-dependency on "foo/bar/baz", and that single rule
> uses "mkdir -p" to create all of the directories.
>
> It doesn't buy us much simplification in this case, though, because
> various rules independently depend on .build/gitlink/lint-docs/howto,
> .built/gitlink/lint-docs, and .build/gitlink, etc. So we still end up
> with roughly the same number of rules, though the directory rules don't
> have to depend on one another.
>
> It also means that these "mkdir -p" may race with each other, though in
> general I'd hope that most "mkdir" implements could handle this.
>
> Something like this works, I think:

Hmph, what I actually meant was to make sure that the recipe to
create the files to have "mkdir -p $(basename $@)" in front, instead
of having "we need to prepare the containing directory in order to
have a file there" in the makefile.

> ...
> At any rate, I don't think there's any urgency on that.

Sure.  I think I've picked up the one at the start of this thread
already, so we should be good.

Thanks.
