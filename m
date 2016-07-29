Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77FFC1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 17:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbcG2RPc (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 13:15:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59854 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752269AbcG2RPb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 13:15:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DD4B32349;
	Fri, 29 Jul 2016 13:15:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SuMhvRRvjuh94cugxhkY4KtukcU=; b=hK6qPA
	9DAK+bxb+xYay90iCrZsrY9m3BoZxLrQGvdcOIEv7GQGnw7AfWm9KqbFyKyNo8tY
	4TQ1zKw565KZKQdaqgwExrbLIJTZ15o854tosYgjvJm1kZeISj832FMIKLRwpNGc
	juAZoFQqY+usUjytFvI9ULE8RyYVnbvhDHmnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UJGp8f6ZTWBy2Zwj7qMg82jyv0bWxRD8
	cbW/QPxZ7wKpv1SckaV+JAaKxqsTltpirLvsF9C1GS1iauMLa3alisTNzF+5a4TF
	RTGEa+i86H46rfF5xKwp3zbdc5DfQeJ6vLsiTd+RHFDqYIe5CZ7NyPpSmmEg1N7z
	+Uvia652hcw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82FF032348;
	Fri, 29 Jul 2016 13:15:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06CE032347;
	Fri, 29 Jul 2016 13:15:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Small trivial annoyance with the nice new builtin "git am"
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
	<CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
	<20160729002902.GD9646@sigill.intra.peff.net>
	<CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
	<20160729155012.GA29773@sigill.intra.peff.net>
Date:	Fri, 29 Jul 2016 10:15:26 -0700
In-Reply-To: <20160729155012.GA29773@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Jul 2016 11:50:12 -0400")
Message-ID: <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C4DC886-55B0-11E6-9DB1-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 28, 2016 at 05:37:08PM -0700, Linus Torvalds wrote:
>
>> > and then to sprinkle calls liberally through builtin-ified programs when
>> > they move from one unit of work to the next.
>> 
>> Maybe we can just add it to the end of commit_tree_extended(), and
>> just say "the cache is reset between commits".
>> 
>> That way there is no sprinking in random places.
>
> Hmm, yeah, that might work. As you mentioned, there are cases where we
> really do want the timestamps to match (especially between author and
> committer). So we would not want this reset to kick in where callers
> would not want it.
>
> So I'm trying to play devil's advocate and think of a case where
> somebody would not want the time reset after creating a commit.
>
> One obvious impact would be reflog entries, since we would reset the
> time between the object creation and the ref write (so your reflog entry
> would sometimes be a second or more after the commit time it writes).
> I'm not sure how much anybody _cares_ about that; they're much less
> intimate than author/committer times.

As long as it is understood that a commit object is created and then
a ref is updated to point at it in this order, I do not think there
is any confusion on the party who reads the reflog, I would think.
