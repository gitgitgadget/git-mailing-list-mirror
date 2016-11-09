Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67DF2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 23:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbcKIXkV (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 18:40:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55251 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754104AbcKIXkU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 18:40:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CFD84DBF7;
        Wed,  9 Nov 2016 18:40:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XIy8Z+i6CYHkl1MrHIVejmhW3R8=; b=HvD4qa
        xKjIr9HEf6QWzCZSCVzXKxl/4BUd6FqaGwlHx8DCmHgu7Fl+3726mpNtX374jzRV
        v/Z8KaRO7JdlhxQtF7OzkE409ORLGBwtDSBxal/fYbrvUjxdqvXwiY9PfufkGnWU
        0ZL6No9X+3LY0tqMF3zftTIveRhgpZMfAsaK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v1DwPT+s9sB56xestiAoXKC1l7pGRxxw
        1As/u9mssXQOkdwA8JFdp3iqdEH+MK+KIDgm9JE2MqK7slZ6g6XpYkOpclroDbz4
        j0PGcswXC7fZyQ9vLjmRXonL2hMVwQneoJdHVUZc81U5Wndk3HMtTcCm2LJTlIIy
        3MtUXsuu03g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6457E4DBF5;
        Wed,  9 Nov 2016 18:40:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D74164DBF4;
        Wed,  9 Nov 2016 18:40:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
        <20161108004038.a7gyoe6wpucxjmvz@sigill.intra.peff.net>
Date:   Wed, 09 Nov 2016 15:40:17 -0800
In-Reply-To: <20161108004038.a7gyoe6wpucxjmvz@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 7 Nov 2016 19:40:38 -0500")
Message-ID: <xmqqshr06x3y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF7A321E-A6D5-11E6-A47D-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we also need to make a final decision on the indent/compaction
> heuristic naming. After reading Michael's [0], and the claim by you and
> Stefan that the "compaction" name was declared sufficiently experimental
> that we could later take it away, I'm inclined to follow this plan:
>
>   1. Ship v2.11 with what is in master; i.e., both compaction and indent
>      heuristics, triggerable by config or command line.
>
>   2. Post-v2.11, retire the compaction heuristic as a failed experiment.
>      Keeping it in v2.11 doesn't hurt anything (it was already
>      released), and lets us take our time coming up with and cooking the
>      patch.
>
>   3. Post-v2.11, flip the default for diff.indentHeuristic to "true".
>      Keep at least the command line option around indefinitely for
>      experimenting (i.e., "this diff looks funny; I wonder if
>      --no-indent-heuristic makes it look better").
>
>      Config option can either stay or go at that point. I have no
>      preference.
>
> The nice thing about that plan is it punts on merging any new code to
> post-v2.11. :)

OK, I can go with that plan.  Thanks for an outline.
