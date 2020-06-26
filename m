Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8BCC433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA67D208C7
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ItkqVlBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgFZVHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:07:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56768 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgFZVHp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 17:07:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54D09CDD8F;
        Fri, 26 Jun 2020 17:07:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PkB2+ZyxiemLBHzIojx8DY3d73c=; b=ItkqVl
        BflY1j8MjeOx7ypGxelcHmolRd3IFUQu7fkbPsP1JfkVWjQuf6b4edAMZQu6NeoK
        fDqWaa+CMTgLwjPwrnAnz6Hpx+WVqFXBpqep1oG3rr0JEBEG5n4TBFdFnMjUb0nJ
        7YMUUgHj8HIANsLYhcN4s8fj/LgdlnJSYXTm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v+M3IJZ7Q7eT/MMFTCky0bFX4R5DyNi/
        QHekVxrotgwujyRkzx5U5ABt5fUX7IczYPlNvjHq2lKpVNITtmdC5XmZcV62IjJZ
        L4SeXMDJSn6nViwCKLqT8mwqlpzPeo8C1UvcDtfNsvghe9VWZRtoM6wr1yp79DHX
        +JfA8N4rg28=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BCCBCDD8E;
        Fri, 26 Jun 2020 17:07:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5C94FCDD8A;
        Fri, 26 Jun 2020 17:07:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Craig H Maynard <chmaynard@me.com>, git@vger.kernel.org
Subject: Re: Regarding Git and Branch Naming
References: <B4814F42-7AF8-4D80-93D4-FAF752C72F21@me.com>
        <CAPx1GvcZk2o7f8-27xokwxUayWwO+t5qdsMjLrjBymc+WHznmw@mail.gmail.com>
        <20200626203539.GA1173768@coredump.intra.peff.net>
Date:   Fri, 26 Jun 2020 14:07:37 -0700
In-Reply-To: <20200626203539.GA1173768@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 26 Jun 2020 16:35:39 -0400")
Message-ID: <xmqq7dvth6xy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1153CC5C-B7F1-11EA-A9DC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We definitely _could_ extend HEAD to allow a "not pointing at anything"
> state. Presumably for reading that would behave like the "pointing at a
> branch that doesn't exist yet" case. But I think the experience it
> creates for writing is not very good. I.e., I think the best we could do
> is something like:
>
>   $ git init
>   $ git add some-files
>   $ git commit -m whatever
>   fatal: HEAD does not point to any branch
>   hint: use "git checkout -b <branch>" to make commits on <branch>

... or you could stay forever on detached HEAD state.

Very briefly in early days of Git, the envisioned use case (which
quickly was retracted) was to use one repository per one line of
development (so you'd pull among the repositories you have, and each
repository does not even need to have "the default" branch---there
was no need for any branch).  Staying forever on detached HEAD is
pretty much in line with that.

> Perhaps that's not _too_ bad, but it feels a bit unfriendly (and
> definitely more likely to cause backwards compatibility issues than
> picking _some_ default name). There would also be a lot of corner cases
> to cover and debug (e.g., "git checkout foo" moving away from the "no
> branch" state should make the usual complaints if we'd have to overwrite
> or modify index and untracked files).

I do not see much point in adding such a new set-up, only to risk
introducing unexpected and unnecessary bugs.  Such extra engineering
resource is better spent elsewhere, I would say.



