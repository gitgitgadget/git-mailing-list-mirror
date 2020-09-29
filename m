Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7B9C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B4921734
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d6G6N/37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgI2Ayl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 20:54:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57068 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgI2Ayl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 20:54:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDC0276919;
        Mon, 28 Sep 2020 20:54:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BV6GDvlXkSOqngO7xxR9DPZeMH4=; b=d6G6N/
        37FaIo3+GtUvLuHWqbKUcrZPygUpIS3Waq+A3hx5oSvUat5gJARhfOZIF9COO5+Y
        5UnWmQFl5ex2LcjNqvsOKwiJhOzI0jsoSMGTmopTN7g6UOXSrZLnG7yA9Uoo6wjK
        3LQS9nQpeY0Vat/OEYge1EUXj4NuUY+WXhku4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lyBhBwUYq+/JniUt+Xk9Hw2FTvQBdVW7
        CdMAU5s3sNYoImvO2fJfbbEdGIKmb1adCncoLhafOUOWLL5cjatPtnIG+l/jru0L
        k7AFpQcf3BorGmQKyRiNBS6FbObAUoR9ayh89rb+SYP5s/wC4n+xzNwOsfmKqyIM
        EmPxx7QevZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4CC976918;
        Mon, 28 Sep 2020 20:54:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5746976917;
        Mon, 28 Sep 2020 20:54:38 -0400 (EDT)
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
Date:   Mon, 28 Sep 2020 17:54:37 -0700
In-Reply-To: <20200929004448.GD898702@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 28 Sep 2020 20:44:48 -0400")
Message-ID: <xmqqsgb1ier6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59B40650-01EE-11EB-BA6B-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, that is probably what would happen. I have to admit that it's such
> an obscure case that I'm not sure I really care. It's unlikely in
> practice, and if somebody did report such a case, I think my first
> response would be "well, why did you have a broken entry stuck in your
> file?".

I think we know the likely answer.  "I once used Windows to edit the
file manually".

After which the file looks broken, so the user may have re-added via
the credential API (with LF line ending) a new entry for the host
and have been happily using the result.

