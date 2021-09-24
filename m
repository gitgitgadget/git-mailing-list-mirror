Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57EEC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B696B61038
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbhIXVaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:30:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52273 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbhIXVaH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 17:30:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D62BFD21B9;
        Fri, 24 Sep 2021 17:28:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yGeHjBhSlMvBbKH7hyL8BC+HWzmjSGmtgzqRu4
        pIRik=; b=Nr2hNHXOeITfRptD/nHMWwzsK0hyaWLB+DsyxXoBfuM3zcFd7isQ9e
        M/yAfl0vN0v7W/mf6+xVWOdfgo4f+mbibeZWV1kaMfJXIHVPnU3Ivxljzxi284+F
        ROYCu1/F8HohHeDMEUm0pExnAo39mW2jmNTMw87seVRmCfD5CvZvw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE753D21B6;
        Fri, 24 Sep 2021 17:28:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3DF9FD21B4;
        Fri, 24 Sep 2021 17:28:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
        <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
        <YU49+Y+nRhl1mgof@coredump.intra.peff.net>
Date:   Fri, 24 Sep 2021 14:28:29 -0700
In-Reply-To: <YU49+Y+nRhl1mgof@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 24 Sep 2021 17:07:05 -0400")
Message-ID: <xmqqa6k1slxe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CDD0C80-1D7E-11EC-8D40-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I had thought to extend with the operator, like:
>
>   # equality
>   [includeIf "env:FOO==value"]
>   # regex
>   [includeIf "env:FOO=~v[a]l"]

Yup, that matched my aesthetics better ;-)

> But as you note, "=" is somewhat problematic, and without that we can't
> use the "usual" operators. Plus there's no usual operator for globbing. ;)
> So embedding it in the name is fine by me (and mostly a bikeshed thing
> anyway).

Perhaps.  I am not sure if we deeply care about "git -c var=val" in
this case, especially since this is part of includeif, though.  It
may be more important to keep the syntax useful and extensible for
everyday use than for one-off "git -c" testing.

> I agree we don't really need a "/i" variant here.

Case insensitive environment variable names, no, but case
insensitive matching of values, maybe?  But I'd be happy to see us
start very minimally (even just envEQ alone without any other
frills, or optionally envNE to negate it, would be fine by me).

> Should we allow whitespace around key names and values? E.g.:
>
>   [includeIf "env: FOO: bar"]
>
> is IMHO more readable (even more so if we had infix operators like
> "==").

This asserts what? FOO=" bar"?
