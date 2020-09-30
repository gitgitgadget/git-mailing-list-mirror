Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9E6C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D79B2076A
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t3h2ZTej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbgI3W4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:56:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64449 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbgI3W4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 18:56:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A439D102E47;
        Wed, 30 Sep 2020 18:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lw233MGHtKHLe67biQyq6O8WprA=; b=t3h2ZT
        ejdJajcwBiVfhZxmv7dodJvrdpcNCrShMhGyuPInnQLvWrAi5upQf1zgP39gxrHo
        natf5NUIVinQza6twdkZVUZ0MgLeSZqIsDSYyhe0TnKrvOFOU4F5Vn/rWcY5s5ud
        u25QfzIhc/w3EQy6114gyG5StmCrZMfjv9pgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yUzpYzK1K78qdHEiL+OlOyqBT1sLpBIx
        AiI8TR5GxQJYTi5ieWz1FqNiWcrPK2hyASVPMx9Kgwqqpv9n4oelXGjWjhIyxGC5
        ZddRzss7W7m++KnB42+71wPHgBAFpCqN6sKCfR40LxCGekbdv+oAoJxwNR9S+xB8
        Nee48gVIK1A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C718102E46;
        Wed, 30 Sep 2020 18:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E15AB102E3C;
        Wed, 30 Sep 2020 18:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
        <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
        <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
        <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
        <20200929003000.GA898702@coredump.intra.peff.net>
        <xmqqwo0difdh.fsf@gitster.c.googlers.com>
        <20200929004448.GD898702@coredump.intra.peff.net>
        <xmqqsgb1ier6.fsf@gitster.c.googlers.com>
        <20200929030043.GA905754@coredump.intra.peff.net>
        <xmqqeemigawq.fsf@gitster.c.googlers.com>
        <20200930223913.GB1908000@coredump.intra.peff.net>
Date:   Wed, 30 Sep 2020 15:56:27 -0700
In-Reply-To: <20200930223913.GB1908000@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 30 Sep 2020 18:39:13 -0400")
Message-ID: <xmqq5z7ug9gk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CE56816-0370-11EB-8280-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 30, 2020 at 03:25:09PM -0700, Junio C Hamano wrote:
>
>> OK, so what's the final verdict from us?  This is good enough to
>> move forward as-is?
>
> I'd prefer to see the credential-cache--daemon changes either dropped,
> or split out into a separate patch with the justification of: this
> probably doesn't matter in practice, but it makes the whole protocol
> between client and server treat CRLF consistently.
>
> I had also raised a question in:
>
>   https://lore.kernel.org/git/20200929004220.GC898702@coredump.intra.peff.net/
>
> about whether they just care about the empty line, or about CRLF on data
> lines. If the former (which is what the commit message claims), then I
> think we can do something much simpler. But I suspect it is the latter,
> and it is simply the commit message that is a bit misleading.
>
> Other than those nits, I think the series is OK.

Sure.  But credential-store side is also iffy; it is not like they
want CRLF on data lines (if they want CR in data, that needs to be
encoded).  The only reason I can think of that the change to
"-store" makes any difference is when people edit it, but the file
is not designed to be manually edited, so even that part of the
series needs a better justification.  It's not like "We want to be
compatible" without "why it is better to be compatible" is a good
rationale, when we define the file format not to be manually edited
in the first place.

Thanks.
