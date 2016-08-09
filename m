Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152371F859
	for <e@80x24.org>; Tue,  9 Aug 2016 17:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbcHIRjz (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 13:39:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751919AbcHIRjw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 13:39:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF8E831EE3;
	Tue,  9 Aug 2016 13:34:13 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+ODe7YTxvQ71YOJtaCloVRX/Foo=; b=e4i8GO
	WP+5ZCSfDc2mH0GRinJUjgYJLDvNny4BRXtAVCFfklZOyYV/wWa1U8lJ+O+WgWB3
	GmJ+9h5goyA3EFmnZsZSQp3aou1H6N2cDIAeSn+13DALyWgYIQkthF1rFAEQONPJ
	ACxB9L4jgifVnGgRyOZHzp/0GzaB0XSsI0rjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I7PXxD4uFdDinKrD1LW7MN6F2va0sVOz
	Gvx3fqakM2Ysb6VLfaA2UPoPEbGvk9mTXZEmOQiCynQNFlIKWb9MW8MZdD5mi/0g
	VOnN2B5HoYUIQBQ1sYm1R8+lGGylWrROC1Wd8SEXjuOqbKWjnV+9ZbnoZ/Vn0mIJ
	Tr9hsSslu9Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4AFC31EE2;
	Tue,  9 Aug 2016 13:34:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 026FA31EE0;
	Tue,  9 Aug 2016 13:34:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
References: <alpine.DEB.2.20.1608021004080.79248@virtualbox>
	<xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1608031021050.79248@virtualbox>
	<CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
	<alpine.DEB.2.20.1608031753431.107993@virtualbox>
	<CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
	<alpine.DEB.2.20.1608041730130.5786@virtualbox>
	<6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
	<xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
	<3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
	<20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net>
Date:	Tue, 09 Aug 2016 10:34:11 -0700
In-Reply-To: <20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net> (Jeff
	King's message of "Tue, 9 Aug 2016 07:37:03 -0400")
Message-ID: <xmqqh9atc0do.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CD46B6E-5E57-11E6-9B74-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes all what I wanted to say, and a lot
more, so I don't have to say much ;-)

>  - I really like the flow of having conversations next to patches. I can
>    look at the index of the mailing list folder and see what people are
>    talking about, how big the threads are, etc, at a glance. Moving
>    between messages and threads involve single keystrokes.
>
>    Similarly, having local storage is _fast_. I think GitHub is fine for
>    a web app. But when I'm reading a high-volume mailing list, I really
>    want to flip around quickly. If there's even 500ms to get to the next
>    message or thread, it feels clunky and slow to me. Obviously I spend
>    more than 500ms _reading_ most messages (though for some I see the
>    first paragraph and immediately jump away). It's just the latency
>    when I've decided I'm done with one thing and want to move to the
>    next.

Viewing threads in a threaded mail client to help prioritizing
various topics being discussed is what I value the most and I am
not sure how I can be as efficient with the pull-request page.

>    The threading in GitHub comments and pull requests is also not great.
>    Each PR or issue is its own thread, but it's totally flat inside.
>    There are no sub-threads to organize discussion, and it's sometimes
>    hard to see what people are replying to.

It may be a good UI that is optimized for drive-by contributors.  It
is just that it is not very well suited (compared to mailing list
discussions) to conduct high-volume exchange of ideas and changes
efficiently.

