Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E2DC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 02:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D88239ED
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 02:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgLHCYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 21:24:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63983 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHCYk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 21:24:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E929E10159E;
        Mon,  7 Dec 2020 21:23:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5ajACC/mOxmBtuA+vX1AzaHVOSA=; b=dyBqQ4
        hqj4fgVRFGDU4MMVTeTb0CWAYy8MCk6G1F/pghqUpHuZ9Ny8v+4Q2QUfYf2zlo9H
        8S3i3Yl66Xyz+54cfm/CnKgzgUGT2amWc+xovmFTAaTbYgYbiLm1k8wOnPQkjn/R
        fiv5Wc7+owQ8yJwHsDmZqZ2VmNdOIbf+4Axm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HVj/oTjW0g4dL/IkaDj2Gm38OgI0douU
        SdsjNRJybP5gGPm51p2GGDdSRskN24cgvsWbRoSEYhPN5uzi/3r0YFjfTci0Fxdr
        Qumd5L6lydMFGSnpx0nTqTZ0F0/6FMnLKeIIrJA23ivH77Xq1VHcTqEOH6ruZh6F
        mUh+Ca2gesI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0A1F10159D;
        Mon,  7 Dec 2020 21:23:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2FDE310159C;
        Mon,  7 Dec 2020 21:23:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
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
Date:   Mon, 07 Dec 2020 18:23:53 -0800
In-Reply-To: <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
        (Jacob Keller's message of "Mon, 7 Dec 2020 15:30:04 -0800")
Message-ID: <xmqq360h8286.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B8B66A8-38FC-11EB-B173-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I think the key point is that this "in the future" is referring to "a
> future version of git will make this an error"
>
> This might be better if it said something like "The pull was not
> fast-forward. In a future version of git you will need to specify
> whether to merge or rebase, using pull.mode"

Oh, I've actually been assuming that the current "warn but go ahead
anyway asssuming the preference is to merge" can just be declared as
a bug (iow, there is no need to say 'in the future'---we'd fix the
bug right away).

> or something similar. In theory, this warning will go away once that
> future version of git changes so that pull.mode defaults to ff-only.
>
> The difference being that a warning will allow the command to continue
> doing the default of today (merging), where as an error will stop the
> command essentially just after the fetch portion finishes, without
> changing the branch.

Yup.  If we want to take things slow, that is fine by me as well,
but I am not sure if that is even necessary, given how annoying the
existing "loudly warn but still go ahead" behaviour is, and how easy
for existing users to have squelched the annoyance by choosing
between rebase and merge already.  I've always assumed that any
existing users who started using Git in the past several years have
already set pull.rebase to one or the other value and they won't be
affected by fixing "git pull" to just error out.
