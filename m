Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2A9C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C3923877
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLGSRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:17:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51267 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgLGSRE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:17:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C1D08A259;
        Mon,  7 Dec 2020 13:16:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p0NmJMuSO2G/AYvvsWdViK+sjRs=; b=GXv52U
        PEZG5j9Q9o6fSJaa0QimDzTA8wJiT4NqV5dR8U1nxKfM1ZNpD8RC7sueqXvJLjQP
        tESPPwKKdU39UqI0zEitiRI4qtTFK8LLMlYPnEm2xPFPDKLVVemaH9R9zWg0PuxV
        WvSAgROdYshI9Q6J78SIZmSGlOJ0kCqusVMr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xa8J9WKOcJUVVAAcstBv1A43/+8r96Y4
        tcnyZWDKIxF2BhV26KNguXK9NSvLr3to819gOZq64hPpEOTHyJjWnl5/WqoADxrF
        v59o6bW1mIZOHOEFZ+poU7nf94PrLMdHrStI3RYuUbbynS9mMWIiWTN9o++dyprC
        vcN9DRoxA7w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8354A8A257;
        Mon,  7 Dec 2020 13:16:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 143B38A256;
        Mon,  7 Dec 2020 13:16:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
        <20201204061623.1170745-3-felipe.contreras@gmail.com>
        <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
        <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
        <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
        <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
        <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
        <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
        <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com>
        <xmqqeek2cc14.fsf@gitster.c.googlers.com>
        <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
Date:   Mon, 07 Dec 2020 10:16:20 -0800
In-Reply-To: <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
        (Felipe Contreras's message of "Mon, 7 Dec 2020 03:16:14 -0600")
Message-ID: <xmqqpn3lbhxn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EBC374E-38B8-11EB-8165-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> When the user has specified "pull.mode=ff-only", the command dies with:
>
>   The pull was not fast-forward, please either merge or rebase.
>
> When the user has not specified any mode (by default), the command
> would output a warning:
>
>   The pull was not fast-forward, in the future you will have to choose a
>   merge, or a rebase.

I quite don't get it.  They say the same thing.  At that point the
user needs to choose between merge and rebase to move forward and
ff-only would not be a sensible choice to offer the user.

> Just to put this series in context: it's only part 1; it does not
> introduce pull.mode, and it doesn't make --ff-only the default.

I'd view the "in a non-fast-forward situation, the warning kicks in
to those who haven't chosen between merge and rebase (i.e. no
pull.rebase set to either true or false, and pull.ff not set to
only), which is a bit more gentle than the current situtation" a
good stopping point.  That state is already making ff-only the
default for unconfigured users, or you can view it as shipping "git
pull" in a shape that has the more dangerous half of its feature
disabled to avoid hurting users.  So I am not sure why you keep
saying you do not have --ff-only as the default.
