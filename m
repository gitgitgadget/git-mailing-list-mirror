Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D44C1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbcHARtc (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:49:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753949AbcHARta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:49:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ADAE3260A;
	Mon,  1 Aug 2016 13:49:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4MeQziuz0raMZy+vcxcIr8Wt/so=; b=deoxtc
	ks8r85WOfORV44sIR7dMz4cGLEComqla1ZMzHMDAD93BXKezQvskNEiQa/INEz/t
	xbD5uIBvK8mx+17T9T2z6+ZCfgnR6XmGecW/8Cye0RzSkbI93PzgLfogMdt3GiNn
	zpbZKhsPf8dW0uy+18K6RhTghjabcEj1XV5kw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VL6jdazx95Hbgum2uyxUOQ8KuWZWV2pD
	5fEk1I9cUHESxOYP5Z8ciakCRkgIzNlRCtgYDqfa3BkXPXy6b+Rjj6w2F/RyqSE2
	z2uPhbvPi0HdImrS/nI7QwhUmx3aQyGyakvW5HOM+KEmpai5e9XBeAVVSFlKxQaG
	JNeSvRpC4mA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DB5532609;
	Mon,  1 Aug 2016 13:49:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC5D932608;
	Mon,  1 Aug 2016 13:49:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Paul Tan <pyokagan@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset cached ident date before creating objects
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
	<CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
	<20160729002902.GD9646@sigill.intra.peff.net>
	<CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
	<20160729155012.GA29773@sigill.intra.peff.net>
	<xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
	<20160729180517.GA14953@sigill.intra.peff.net>
	<CACRoPnS2kDRLiY8KX3K4Havh7d1GWy3mUXSiYCzw45BznuwYeA@mail.gmail.com>
	<20160730024135.oaqtjpo5l2e3dam2@sigill.intra.peff.net>
Date:	Mon, 01 Aug 2016 10:49:12 -0700
In-Reply-To: <20160730024135.oaqtjpo5l2e3dam2@sigill.intra.peff.net> (Jeff
	King's message of "Fri, 29 Jul 2016 22:41:36 -0400")
Message-ID: <xmqqbn1cl6qv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42FA8740-5810-11E6-A361-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> So maybe we would have to put reset_ident_date() at the end of the
>> function instead, at least after git_committer_info() is called.
>
> Yes, although "reset and end" still feels a bit weird to me.
>
> I'd almost prefer to just have long-running programs insert resets at
> strategic points.

Certainly "reset at the end" feels weird but it can be explained as
"for a one-shot thing we use the first time of the default date and
it gives a consistent timestamp; conceptually, things that make
multiple commits are like doing that one-shot thing multiple times
in a row."

When viewed that way, it is not _too_ bad, I would guess.

