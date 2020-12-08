Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E77C4167B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C8E2388C
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgLHURl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:17:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58531 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgLHURa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:17:30 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9643B624E;
        Tue,  8 Dec 2020 15:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hCNhoHey9ZAFIIkjj3pMgIWql7Q=; b=K3jQFJ
        X0LKgQ46DNsVBuOXo1rlY7kWJce2OkfEp6KjoyMIx8B0hd/aQo4ZZyjV2dPW5F0b
        3V39hpekg8IVlIRm4b3ds3AZ5ga+TXwrGpM5Xr0fZmE3YcA/eWv/fRj7ab1M1aLv
        7c2iwm29iWsbCFxbFMRH1SXIcM0EOPIu/CJjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SVON/EMCVZu2qYgmsJu80WCehexrx4Xp
        VCDFxivkYqpTOryLnowsKab6Qe2ojq/PZVV9S31x92mLIvTGkdTEfZbj2KJwG5ol
        O7ui0HXHPhDeN31Sa6892jKEtnSfMc3/nghUoxhgidC8jgCDL2D3o/M+4resYuZf
        TFeQg38eXBY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0301B624D;
        Tue,  8 Dec 2020 15:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 236D8B624C;
        Tue,  8 Dec 2020 15:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?V?= =?utf-8?Q?=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
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
        <xmqqpn3lbhxn.fsf@gitster.c.googlers.com>
        <CAMP44s2nmVnXiBA8S=vHBZznuRNKKe=xGOEBJ80MYhA_XCqNkg@mail.gmail.com>
        <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
        <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
        <xmqq360h8286.fsf@gitster.c.googlers.com>
        <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
Date:   Tue, 08 Dec 2020 12:16:46 -0800
In-Reply-To: <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
        (Felipe Contreras's message of "Mon, 7 Dec 2020 21:15:05 -0600")
Message-ID: <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C387A98-3992-11EB-A940-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> That is exemplified by the fact that this whole thread started from a
> user that refused to configure pull.rebase and expected the Git
> project to just do the right thing (which is basically choosing a
> useful default).

Which is basically asking for impossible, and I do not think it is a
good idea to focus our effort to satisfy such a request in general.
There is no useful default that suits everybody in this particular
case.

The "force ff-only" approach indeed gives a very sensible default
behaviour of dying for those who haven't expressed the choice
between rebase and merge in a situation where the difference between
the two results in histories of different shapes.

But for anybody who uses git for real (read: produces his or her own
history), it would be pretty much a useless default that forces the
user to say rebase or merge every time 'git pull' is run.  That is
why I am not enthused by the pull.mode=(rebase/merge/ff-only)
configuration.  The third choice does help completeness.  When a
user asks "the documentation tells pull.mode can be set to
non-default behaviour---what value can one set it to to get the
default behaviour of not allowing any original work?", it can be
answered if we had pull.mode=ff-only.  But other than that, I do not
see any real use for the choice, which would mean in practice,
pull.mode would have only two useful values, rebase or merge.  That
does not feel a good enough reason to supersede what already exists,
which is pull.rebase=yes/no.

Perhaps there is a good reason why certain classes of users would
want to configure pull.mode=ff-only (i.e. "I might type 'git pull'
by mistake, please stop me if I did so on a branch I have real work
already.").  If that is the case, I would very much agree that it
would be awkward to express that choice in the current framework to
choose between pull.rebase=yes/no and pull.mode=(rebase/merge/ff-only)
would become a lot easier to explain.

I dunno.
