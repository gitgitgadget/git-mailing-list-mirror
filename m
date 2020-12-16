Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9E4C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E777238E9
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgLPU5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 15:57:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64168 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgLPU5H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 15:57:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 589E8A6571;
        Wed, 16 Dec 2020 15:56:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5fOF5IRZHCzPxhJyAgygIiY076A=; b=KSpYb0
        MtYLeqJjhhnekPxUsLENCVoqDSxnbXynLEElms8+9HHNgf9tC93zW+aMMRwb/408
        zjE8Xbc8HJKlK7mde5FIs4zE0F7o4+cpsDW+tBcQJF8hZNgq4RDEBGhah6cO2P+K
        ppprgoO0zCVj93Z1HE6QJMioCw/QDOcHg4kGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ePcq2gHtzIyCny2uTjd1Inw+QTsWcrmg
        Hnvk0D2Oz4KXvQJPS4xQoWQdqhL/Wo4Cpcuxriwti7BFPSMC3HcUZx0m7mnERqZJ
        5B1TBPRkQU6B54ERspOh4vYJ+LcH/7H3WnjruQkf06PAkUm2CRdlP8AGahEAoC50
        LsOcq2SeR/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50E76A6570;
        Wed, 16 Dec 2020 15:56:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF941A656F;
        Wed, 16 Dec 2020 15:56:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <20201211210508.2337494-1-jonathantanmy@google.com>
        <87blewwoil.fsf@evledraar.gmail.com>
        <xmqqim94e4et.fsf@gitster.c.googlers.com>
        <878s9zx2ul.fsf@evledraar.gmail.com>
        <X9ghqMo5WS8FrBEz@coredump.intra.peff.net>
        <xmqq8s9zaica.fsf@gitster.c.googlers.com>
        <X9g9Y9LWc0NtHlQn@coredump.intra.peff.net>
        <xmqq7dpi5tvl.fsf@gitster.c.googlers.com>
        <X9pUc2HXUr3+WHbR@coredump.intra.peff.net>
Date:   Wed, 16 Dec 2020 12:56:22 -0800
In-Reply-To: <X9pUc2HXUr3+WHbR@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 16 Dec 2020 13:39:47 -0500")
Message-ID: <xmqqft4531xl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 278CBC22-3FE1-11EB-8778-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think:
>
>   git checkout --guess origin
>
> would make sense to dereference origin/HEAD to "foo", as if we had said
> "git checkout foo". That's the explicit part that seems safe. My
> question is whether:
>
>   git checkout origin
>
> should likewise do so.

I see.  I think "--guess" is by default true, so unless you have
checkout.guess=false configured, my answer to the above question is
yes.

> As you note, one can always use --detach to make
> their intention clear, and checkout is a porcelain, so we are OK to
> change it. But would users find that annoying? I frequently use "git
> checkout origin" to get a detached HEAD pointing at your master (e.g.,
> because I want to reproduce a bug, or do a "something like this..."
> patch). I'm sure I could retrain my fingers, but I wonder if I'm not the
> only one.

My fingers say "git checkout X^0" instead of "--detach" when I want
to detach for any value of X (e.g. "HEAD", "v2.28.0").  But I do
understand people like to be implicit when they can.

> Doing it for only an explicit "--guess" turns that feature into a
> tri-state (explicitly off, explicitly on, or "implicit, so be a little
> more conservative"). Which perhaps is harder to explain, but I think
> cleanly adds the new feature in a consistent way, without really
> changing any existing behavior.

Hmmmm...  I do not offhand know if that is a good idea or not.

> Related, I assume that:
>
>   git checkout --guess origin/foo
>   git checkout origin/foo
>
> should behave the same as their "origin" or "origin/HEAD" counterparts
> for consistency (obviously making "foo" in the former case, and either
> detaching or making "foo" in the second case, depending on what you
> think of the earlier paragraphs).

I think that is what I said in the "what would happen if we tweaked"
paragraph about using origin/ prefix as a disambiguator?  Then yes,
I think we are in agreement.

Thanks.
