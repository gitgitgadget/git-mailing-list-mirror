Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DC0C433E1
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 06:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECE22073E
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 06:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dO2k3TKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgGSGQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:16:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63758 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgGSGQT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 02:16:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DF216DD34;
        Sun, 19 Jul 2020 02:16:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CcfT27emprzwNiIZSHQgw1HOrbs=; b=dO2k3T
        KnZTLdIC2QrhKcCApcCJC/PqlIKf6gmWKj08viKebeOqba6YMeCOqbR743qdpoil
        7FlQHDiQzyqhHoU+VdzkcU2iY1CHZzJ8zmbDPSOQLl2HqM6JOKJGjl5unXeF2UF+
        2SsaA/cPZgbAVKTC7kPK01EeOm020srS7Nb2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mfq5IMJuhQMM60ZyasZyak65iPLCF/H1
        HYLbo8PR/CnOlzsioniR0LaoWzcWQ9t9D4JzS7ceYdXZAX6r4mVh6mP/Fxz8Y7SP
        WmOGy79F/PhZnL5oDMFo7g7/x5oJq+ahlrgs7d3RpIIjOTZaE5KNBTFqJKfifgCq
        d2B1b6vpJRk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 321DD6DD33;
        Sun, 19 Jul 2020 02:16:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10DF96DD32;
        Sun, 19 Jul 2020 02:16:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Chris Torek via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH] git-mv: improve error message for conflicted file
References: <pull.678.git.1595028293855.gitgitgadget@gmail.com>
        <xmqqeep9d6tm.fsf@gitster.c.googlers.com>
        <CABPp-BGDp_SjJKvi+XVd6KvRLA5PVsK4xBLPvBxAimDft+0M9g@mail.gmail.com>
        <xmqq8sfgd8cu.fsf@gitster.c.googlers.com>
        <CABPp-BGJdwpwhQUp4Wa4bKBp4hQFB9OM3N1FXH7SzY0mvLDa7Q@mail.gmail.com>
Date:   Sat, 18 Jul 2020 23:16:15 -0700
In-Reply-To: <CABPp-BGJdwpwhQUp4Wa4bKBp4hQFB9OM3N1FXH7SzY0mvLDa7Q@mail.gmail.com>
        (Elijah Newren's message of "Sat, 18 Jul 2020 18:48:08 -0700")
Message-ID: <xmqqr1t89gi8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A4B0446-C987-11EA-9F46-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Really?  Wow.  I never had any clue that this was possible and never
> ran across it.  Is it documented anywhere?

Probably a test script for "read-tree -m" has a fairly detailed and
comprehensive table of possible scenarios.  

Multiple stage #1 entries were introduced to primarily support the
protection against "criss-cross merge" that confuses the history and
it is used by the resolve backend, IIRC.  

The implementation of octopus we have does not actually use multiple
stage #3 entries but just does many two-parent merges in sequence.
It started its life as a POC & stop-gap implementation while waiting
for the "real thing" that merges with multiple stage #3 entries, but
it turned out to be good enough for a relatively rare (and now
discouraged mostly due to bisection efficiency reasons) style of
merge and left in that shape until now.

