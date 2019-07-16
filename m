Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB2B1F461
	for <e@80x24.org>; Tue, 16 Jul 2019 19:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbfGPTBS (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 15:01:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56452 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbfGPTBS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 15:01:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4D376ECE3;
        Tue, 16 Jul 2019 15:01:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kdzf4oPmr+1WgIE+Tv+kf3ur3ck=; b=KP7tln
        Fi3hUTiRR/gLGgxPokWAwGvBRU9v+aATzSxWmH9s8giZ0CBocT1mP+XgBMAQ5SnQ
        HcZ3Ro8z1gLCvTzFf++2xxDppTibmK4DFYv2FkDXcwnSZ+ZHyGZjwxWsUylPPKS0
        AbMa1dXoIYD8xncfFGiK/DsNsmWjOBYyrg1wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RwU4BQWuDLiJQ5qlOLBAm21hNzuTxSa9
        Xw0SEMiuOg2qddgyeAQQjx2mzIxbECWEqDlr2yKpNXT6pLkgSy76iP18VvcBwyMM
        M/LaihbVyo5S63kcBfp6VleQ+Pp0TULajU1A/SBqGenVd8baE8k1GUAW0S5SFwN1
        ftTo2+7/fo0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD1396ECE2;
        Tue, 16 Jul 2019 15:01:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 191896ECDD;
        Tue, 16 Jul 2019 15:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Carlo Arenas <carenas@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
        <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org>
        <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
        <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
        <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
        <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
        <20190714005129.GA4525@sigill.intra.peff.net>
        <54c2ee44-ee99-ea4a-3154-f642e0060877@kdbg.org>
        <20190715144602.GA26636@sigill.intra.peff.net>
        <4be7a0a1-0256-40c3-4abc-d3d9302f527b@kdbg.org>
        <20190715181527.GA30747@sigill.intra.peff.net>
Date:   Tue, 16 Jul 2019 12:01:10 -0700
In-Reply-To: <20190715181527.GA30747@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 15 Jul 2019 14:15:27 -0400")
Message-ID: <xmqqo91t3itl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14A10146-A7FC-11E9-A902-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But I'd be happy if we could address it in another way (e.g., convincing
> sparse to stop complaining about it, or just decide it's not worth
> dealing with). One other thing I haven't seen discussed in this thread:
> we could actually make our preferred style be for all structs to define
> a FOO_INIT initializer, like we already do for STRBUF_INIT, etc. That's
> a much more heavyweight solution than what's being discussed here, but
> it comes with an extra benefit: it's easy to catch and change all users
> if the struct switches away from zero-initialization.

I'd rather not to go that route.  When we say

	static struct foo foo;

we are happy with the natural and trivial zero initialization of the
structure.  If we didn't have to say STRBUF_INIT, the codebase would
have been a lot nicer with less noise. Because the implementation of
the strbuf cannot take the trivial zero initialized state as a valid
one, we had to sprinkle " = STRBUF_INIT;" all over.

And that "quiet and nice" form is a moral equivalent of

	struct foo foo = { 0 };

that has been discussed in this thread.  I'd rather not to see it
turned into distinct FOO_INIT, BAR_INIT, etc. to force the reader to
think these structures all need their specific initialization and
wonder what's the reason for each of them.

One universal "struct foo foo = STRUCT_ZERO_INIT;" that is applied
to all kinds of structure I could live with (but only if we have a
good way to squelch sparse from bitching about it).  Perhaps we
could define it as "{}" for GCC, while keeping it "{ 0 }" for
others.  As I said, { 0 } is undefensible if we insist that a null
pointer must be spelled NULL and not 0 (as CodingGuidelines says),
but as long as we declare that we take "{ 0 }" as a mere convention
(like we used to use the "int foo = foo;" convention to squelch
"uninitialized but used" warnings) that is outside the purview of
language-lawyers, I am perfectly fine with it, and if it is hidden
behind a macro, that would be even better ;-)



