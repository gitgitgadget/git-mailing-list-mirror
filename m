Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330EDC56201
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 19:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06B422248
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 19:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EcIorMTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgKSTfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 14:35:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55699 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgKSTfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 14:35:22 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 867CB988E4;
        Thu, 19 Nov 2020 14:35:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5mMDs2BRLGmU
        n3GKlsXM9wZxewU=; b=EcIorMTX4sE8ib27iQx7rkaehOsz24H6Mnv8Ab6ihpyZ
        h7tG2vu9kmfkVJvUvMMNnKhBjVAATGEjEU0/8RHoHRHog11sBeKMp7rn7OXwJuCh
        rSflqCWBOy6j31jKF4k5sdxXsnPDRSB6jhjOZ/i51QJpEbUrC1My2THppIWe5CM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vRDKOH
        ALC4HgpYaTjZRHkNmXVibrYgV19bzyyXadvRg8Xmfp90mVyDqPdooq2e4ujdpKPm
        3kaQCTTFq+YTrjGB5DvYhUdm7NrxCAvVivqwI6oelhtyrrLSXQkqrVNVDHJLNOob
        5IjCpA/n1NVtb1fmSsjtAmc4lnV/Amqw85XDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DD57988E3;
        Thu, 19 Nov 2020 14:35:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05ECA988E2;
        Thu, 19 Nov 2020 14:35:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default
 branch (sort of)
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet>
        <20201113161320.16458-1-avarab@gmail.com>
        <20201113191418.GA764688@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet>
        <87h7psg6lz.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2011162118060.18437@tvgsbejvaqbjf.bet>
        <87ima2rdsm.fsf@evledraar.gmail.com>
        <xmqqsg963bg9.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011191030170.56@tvgsbejvaqbjf.bet>
Date:   Thu, 19 Nov 2020 11:35:18 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011191030170.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 19 Nov 2020 10:32:30 +0100 (CET)")
Message-ID: <xmqqk0uhxhqh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B55812C-2A9E-11EB-8C2A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio & =C3=86var,
>
> On Wed, 18 Nov 2020, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > P.S.: Shouldn't the pull patch in d18c950a69f be using the advice
>> >      facility, not warning()?
>>
>> I think warning() is the right thing here, as it is self squelching.
>> Setting pull.rebase (even to 'false') is sufficient---there is no
>> need to set advise.setpullrebase to 'false' on top.
>
> Right. The only reason to use `advise()` would be to allow users to
> squelch the warning by setting `advice.*`.
>
> On the other hand, warnings are not colored, but advice messages are.
>
> And now I realize that the same holds for `init.defaultBranch`: it is a=
lso
> self-squelching. And it also might benefit from the coloring to make it
> stand out a bit.
>
> Thoughts?

I do not see colors well.  You'll always get "find some other way to
make it stand out more to those like us---if you canhdo so without
colors, that would be ideal" from me, so please don't ask me to vote
for more colors.


