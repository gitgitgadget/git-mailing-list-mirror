Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCDFC35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D314720870
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UVH+K+G0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGV6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 17:58:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58941 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEGV6W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 17:58:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C9ACD1B5C;
        Thu,  7 May 2020 17:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RMHBQubt/8m9UsolFZeJ9IOFOoc=; b=UVH+K+
        G0Q/q3SXOxZEDOh8EuoAXfMG7CGo4ashclqMm7kXjritaF7LT4CjFGXb32CXyNcx
        OnXR62rt1GvhKg6ERMTDp4fNYL6ZAzQjk3ZQlP+dAm025HKWq8xtObN3JpsD3T9n
        +oE8ievPr0Wg/54XTf+TJlytBfY929VQAcw/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OcFuFIIrLkoxMVyEL5kGWyS5PT2yCjEy
        BZlRGw7Nd1VL1FheFdyzrc0lIpA5ebBnDfB3qHCLduMryNwodFP5tv/3ibBZRN7+
        7+ohtffajrd2cgWuzzcJdkfE9jaaIbojZlJ5MWXDmnEpZrpArkHoIWd8B1VNz5hq
        0GsyGxcZeuM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 941E8D1B5B;
        Thu,  7 May 2020 17:58:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC93BD1B5A;
        Thu,  7 May 2020 17:58:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: allow per-branch config for GitHub Actions
References: <20200504162311.GE12842@coredump.intra.peff.net>
        <20200504215824.GC45250@syl.local>
        <20200504233634.GB39798@coredump.intra.peff.net>
        <20200505002055.GC64230@syl.local>
        <20200505164326.GA64077@coredump.intra.peff.net>
        <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
        <20200505182418.GA66702@coredump.intra.peff.net>
        <20200505210451.GA645290@coredump.intra.peff.net>
        <20200507162011.GA3638906@coredump.intra.peff.net>
        <xmqqwo5n34ka.fsf@gitster.c.googlers.com>
        <20200507204626.GG29683@coredump.intra.peff.net>
Date:   Thu, 07 May 2020 14:58:16 -0700
In-Reply-To: <20200507204626.GG29683@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 7 May 2020 16:46:26 -0400")
Message-ID: <xmqqo8qz2yrr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBC6AABA-90AD-11EA-BAAB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It was deliberate in the sense that I would allow them to write useful
> messages to the Actions log. If they want to do nonsense like
> "::set-output", then it's their foot and their gun.

It's not like fooling the framework you laid out here is a
potentially useful attack vector.  We can assume that it is unlikely
for the custom allow-ref to be writing a string that happens to
begin with double-colon by mistake and making it harder to debug.

> I don't know if Actions distinguishes between stdout and stderr here
> (i.e., if we redirected the script's stdout to stderr, would that
> prevent this case or not?).

Perhaps we can experiment with "echo >&2 we are getting called" in
the allow-ref script itself ;-).

In any case, I'll queue it on 'pu'.  Thanks.

