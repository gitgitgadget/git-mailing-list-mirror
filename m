Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A7C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 14:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC73220736
	for <git@archiver.kernel.org>; Mon, 11 May 2020 14:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LeugX0hK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgEKObP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 10:31:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57569 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgEKObP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 10:31:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6438BC814C;
        Mon, 11 May 2020 10:31:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AHmYN57sezoYAbGuiu4z3Wlwv1w=; b=LeugX0
        hKTPkZFkf7wZQEMF65DkkIgP267TjcNlC+RW6XTcMzk/MVCLLyG+HdqRCnqfFb1z
        xkEjomL+eBvTit2eKbBszMm17SdRQnQUy9GsU49OXROXCbjVNawjs6IR1+553kE2
        jshK95L7vN/cwxAJ6wQIdXNHAUOa0iWyBHdzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cD+jPttRE0o9CHX7SzSHbb3kgvqv3Z6L
        WViqopVizHKGvYSGJriyYdUK1SolrG45NXraVXSIMhlB1UsCOTcbXeFpoFi8JOql
        9RDQXbqgNXR0V3k7U9mpVAv10SnGjILB/Yanr0AKViEkYr8iOq/JvRAd5cqrzA6/
        miTy8APreTA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BDC9C814B;
        Mon, 11 May 2020 10:31:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B11FC814A;
        Mon, 11 May 2020 10:31:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     George Brown <321.george@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
        <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
        <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
        <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
        <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
        <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
        <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
        <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
        <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
        <xmqqk11jtxl3.fsf@gitster.c.googlers.com>
        <xmqqftc7twaa.fsf@gitster.c.googlers.com>
        <CAFKec1VGMwn3_4AEuY8Vrs60UQbX-fvqCkzKd8VARAUScbA=rA@mail.gmail.com>
Date:   Mon, 11 May 2020 07:31:08 -0700
In-Reply-To: <CAFKec1VGMwn3_4AEuY8Vrs60UQbX-fvqCkzKd8VARAUScbA=rA@mail.gmail.com>
        (George Brown's message of "Sun, 10 May 2020 21:20:00 +0100")
Message-ID: <xmqq5zd2tufn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F210156-9394-11EA-A36C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Brown <321.george@gmail.com> writes:

> Yes. Another version that someone else implemented used similar method
> by unsetting "$GIT_EDITOR" when invoked from Vim and modified "git jump"
> to use cat when "$GIT_EDITOR" was empty.

That's curious, because with the same approach, that someone else
could have gone one step further to set GIT_EDITOR to 'cat' when vim
invokes via a macro and then there is no need to modify git-jump at
all.  "Curious" because I would intuitively think that unsetting
GIT_EDITOR and setting it to a specific value, 'cat', would require
about the same amount of effort.
