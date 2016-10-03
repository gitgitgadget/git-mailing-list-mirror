Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD1A920987
	for <e@80x24.org>; Mon,  3 Oct 2016 19:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbcJCTRj (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 15:17:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53340 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752264AbcJCTRh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 15:17:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 033FE42554;
        Mon,  3 Oct 2016 15:17:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ABSUub5t4LP/n5vESZKUOPGyh1E=; b=gKo1lm
        P91m/3D4GCZis4wQrpqLUZMp4NJWrKO+rTlk0p3qqpXdLW2g6NmN5Ofaanta0twf
        E4qngSUkTDqRvMomQ3BCdQpSQnjxhdl1zDSD3iasznE6PuHzm4sGE22JXe2AgTbb
        U3hPUsGsR/RDJQYwaEanfOgqyAJPU8J1XcMt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bQn2WohzU0YPDBwOoC4Tegycb05kpLGU
        ZhS1bgQWRHOtd1jNhrKW45VvYp5Lo0CcX+evcV6+gt0qC9PLa4iOqpNnckekQ16r
        3221dpbGAVX3pNVJujnsr/InUn3CLdq7BvB0gyETIc9lZioP3JhuirTH+s2PjO2o
        wLHlvwh6640=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEFC342553;
        Mon,  3 Oct 2016 15:17:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70B7D42552;
        Mon,  3 Oct 2016 15:17:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
References: <cover.1475176070.git.jonathantanmy@google.com>
        <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
        <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
        <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
        <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
        <e03fdabd-6690-5244-5f79-1715b0364845@google.com>
Date:   Mon, 03 Oct 2016 12:17:33 -0700
In-Reply-To: <e03fdabd-6690-5244-5f79-1715b0364845@google.com> (Jonathan Tan's
        message of "Mon, 3 Oct 2016 10:44:54 -0700")
Message-ID: <xmqqbmz16y42.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A765ED4-899E-11E6-AA41-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> That sounds reasonable to me. Would a patch set to implement this new
> trailer block heuristic (in both sequencer and trailer) be reasonable?
> And if yes, should trailer know about the "(cherry picked from"
> prefix? (I can see it both ways - knowing about the "(cherry picked
> from" prefix would make it consistent with sequencer, but it seems
> like a detail that it shouldn't know about. Writing
> "Cherry-picked-from:" instead probably wouldn't solve our problem
> because, for backwards compatibility, we would still need to support
> reading the old format.)

If we were to go that route, I'd suggest keeping the historical
practice supported, exactly because you would need to be prepared to
cherry-pick an old commit.

It may be necessary for the code to analize the lines in a block
identified as "likely to be a trailing block" more carefully,
though.  The example 59f0aa94 in the message you are responding to
has "Link 1:" that consists of 3 physical lines.  An instruction to
interpret-trailers to add a new one _after_ "Link-$n:" may have to
treat these as a single logical line and do the addition after them,
i.e. before "Link 2:" line, for example.

I also saw

	Signed-off-by: Some body <some@body.xz> (some comment
        that extends to the next line without being indented)
	Sined-off-by: Some body Else <some.body@else.xz>

where the only clue that the second line is logically a part of the
first one was the balancing of parentheses (or [brakets]).  To
accomodate real-world use cases, you may have to take into account a
lot more than the strict rfc-822 style "line folding".


