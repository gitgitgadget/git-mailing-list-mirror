Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DC72018B
	for <e@80x24.org>; Mon,  1 Aug 2016 21:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbcHAVyx (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:54:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751467AbcHAVyv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 17:54:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74E0C32DB9;
	Mon,  1 Aug 2016 17:54:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z9us9VIvvhlgHCTfrD5woBglUXw=; b=IKA+nt
	F124ZYRKcMeYSXkZVqrTJG+0B1pQXpJUh5m4Wa2kQvz9BDzg1P033DqsczHwWmnD
	x3X4fb+E+4o7LMDZC33/9xAj47xOKltwFkVOJVLh2t5aH++Njdwmt1erJufuxotU
	mmoe77MrePcbUmL13jF1yX+6c9NzjP3canWZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mUChJxQqbexq0G2jGx8S+c5BaYAiV024
	SQYPa8V9opIUUcp8KRIuuCK+ci7JUk/9kR1BJ+mO2/pxqBToGJoFYc7t94dUGa3Q
	RABofV6+dHR14vZ+gg5vyHDZHuO2f5lPNi2YRRm2OOThTARDm9A50C58ZB+82Hrc
	UPK8dB9lFdY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CF3632DB8;
	Mon,  1 Aug 2016 17:54:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA97F32DB5;
	Mon,  1 Aug 2016 17:54:49 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Paul Tan <pyokagan@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset cached ident date before creating objects
References: <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
	<20160729002902.GD9646@sigill.intra.peff.net>
	<CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
	<20160729155012.GA29773@sigill.intra.peff.net>
	<xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
	<20160729180517.GA14953@sigill.intra.peff.net>
	<CACRoPnS2kDRLiY8KX3K4Havh7d1GWy3mUXSiYCzw45BznuwYeA@mail.gmail.com>
	<20160730024135.oaqtjpo5l2e3dam2@sigill.intra.peff.net>
	<xmqqbn1cl6qv.fsf@gitster.mtv.corp.google.com>
	<20160801180047.sgzqgh7pvp2qzwug@sigill.intra.peff.net>
	<20160801193659.hag2yax2rniczkbo@sigill.intra.peff.net>
Date:	Mon, 01 Aug 2016 14:54:47 -0700
In-Reply-To: <20160801193659.hag2yax2rniczkbo@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 1 Aug 2016 15:37:00 -0400")
Message-ID: <xmqqinvkgno8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91D5ED24-5832-11E6-8A17-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I also didn't go looking for other spots which might want similar
> treatment. Junio mentioned that the sequencer code still uses an
> external commit process, so cherry-pick/revert are OK. git-fast-import
> creates a stream of commits, but already deals with this issue in a
> separate way. And I couldn't think of other programs that want to make a
> string of commits.

Thanks.  I wonder if do_commit() may be a more appropriate place to
reset this, but the difference only would matter in "am --resolved",
and a call to do_commit() it has will always be the first commit in
the process, so there would not be anything to clear, which would in
turn mean that it would not make any difference.

Will queue.



