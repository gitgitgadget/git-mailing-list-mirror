Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA90F20193
	for <e@80x24.org>; Thu,  4 Aug 2016 21:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966364AbcHDVMf (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 17:12:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934199AbcHDVMc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 17:12:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A2FF32040;
	Thu,  4 Aug 2016 17:12:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ITwtm0Ll1vinSAY4PjZWQB0vzYo=; b=JTSVC+
	sIQDAgMd5XRNL0sWcZbHI3x82kuyncLsOKJZyfFFexuJyvtQdUjNGu/S4ZrBsloH
	8m7IF6lrbGbt6CwGcKbJKBZtAVhVssrxhBZ79+Sc121hjkzRbfSRGDA4lYIUhcJd
	xTqw2OdiDTL2/BupOFc7QjmreQ1Lgun91lSHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GRAzaamcOhR1ANuEymfQbaNbiooaTkq2
	zbwY5kJsecNmruHP6AizWCcEDXY5blt8H7Oafh7c0M2dX6almrzzntclAx7xVxB3
	lMqO646ZFNQrVFmCYZgHiIK5cryIB2XVIkN84G1DFmUgxduMzZJlI7SyuP8cpQFv
	rcKhsZkn/vo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 70CC53203F;
	Thu,  4 Aug 2016 17:12:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D55363203E;
	Thu,  4 Aug 2016 17:12:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
References: <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
	<xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608021004080.79248@virtualbox>
	<xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608031021050.79248@virtualbox>
	<CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
	<20160803163449.iwjv4youmsf6okme@sigill.intra.peff.net>
	<xmqqbn19aj5t.fsf@gitster.mtv.corp.google.com>
	<20160803165652.zek5df7tv5reg6w4@sigill.intra.peff.net>
	<alpine.DEB.2.20.1608041706040.5786@virtualbox>
	<20160804180749.foowbsmce72s46ww@sigill.intra.peff.net>
Date:	Thu, 04 Aug 2016 14:12:22 -0700
In-Reply-To: <20160804180749.foowbsmce72s46ww@sigill.intra.peff.net> (Jeff
	King's message of "Thu, 4 Aug 2016 14:07:49 -0400")
Message-ID: <xmqq37mk1bnt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 241FFC54-5A88-11E6-90C5-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Like you, I have occasionally been bitten by Junio doing a fixup, and
> then I end up re-rolling, and lose that fixup.

... which usually is caught when I receive the reroll, as I try to
apply to the same base and compare the result with the previous
round.

> But I think such fixups are a calculated risk. Sometimes they save a lot
> of time, both for the maintainer and the contributor, when they manage
> to prevent another round-trip of the patch series to the list.

Yes.

> IOW, if the flow is something like:
>
>   1. Contributor sends patches. People review.
>
>   2. Minor fixups noticed by maintainer, fixed while applying.

This includes different kinds of things:

    a) Trivially correct fixes given in other people's review.

    b) Minor fixups by the maintainer, to code.

    c) Minor fixups by the maintainer, to proposed log message.

    d) "apply --whitespace=fix" whose result I do not even actively
       keep track of.

>   3. Only one small fixup needed from review. Contributor sends
>      squashable patch. Maintainer squashes.
>
> then I think that is a net win over sending the whole series again, for
> the contributor (who does not bother sending), reviewers (who really
> only need to look at the interdiff, which is what that squash is in the
> first place), and the maintainer (who can squash just as easily as
> re-applying the whole series).

> And that is the flip side. If the flow above does not happen, then step
> 2 just becomes a pain.

I think I can

 * stop taking 2-a).  This is less work for me, but some
   contributors are leaky and can lose obviously good suggestions,
   so I am not sure if that is an overall win for the quality of the
   end product;

 * do a separate "SQUASH???" commit and send them out for 2-b).
   This is a lot more work for a large series, but about the same
   amount of work (except for "remembering to send them out" part)
   for a small-ish topic.  A contributor needs to realize that I
   deal with _all_ the incoming topics, not just from topics from
   one contributor, and small additional work tends to add up.

to reduce #2.  Essentially, doing these two are about moving more
responsibility of keeping track of good suggestions in the review
discussion to the contributor, but a bad thing is that it does not
mean that the maintainer can stop keeping track of them.  We need a
way to make sure leaky contributors do not repeat the same issue in
their reroll that has already been pointed out and whose solutions
presented in the previous review.  Fetching from 'pu' and compare
has been one way to do so (that is why I publish 'pu' in the first
place, not to "build on", but to "view"), but apparently not many
contributors are comfortable with that idea.

There is no good way to reduce 2-c) and 2-d), but on the other hand,
there is no strong need for a special channel to propagate these
back.  2-c) can be a regular review comment (but again that risks
"the leaky contributor" problem) and 2-d) will happen automatically
when applying the rerolled version.
