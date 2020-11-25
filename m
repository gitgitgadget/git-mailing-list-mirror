Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE831C2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E44720DD4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 00:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nnpBnbej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgKYAju (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 19:39:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54592 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKYAju (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 19:39:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA771F41DC;
        Tue, 24 Nov 2020 19:39:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g3E9HJ7k99K3bHHooYcL/8AimFY=; b=nnpBnb
        ejTN2e7KsPkt2S3ZYbAy12PAbhnTb2CjAAHoOO4waHErsLTjVn9BlQnMJvQ/vbYo
        Ez3xDQ/4IpGZ9IoDNflIuVGxa1jEJsSYC70HOFUBDDToz+5TKBQY3U8H1lS45SZu
        v6X0j9AMcyeIYPrHbMnZSF7k0wEB43HSg8zcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tYWPmAHuSk7qBylDGWGy4YulDJTu02tC
        Zi1nC/PISorFtCbv3CTyAnxpyXbkOEd0K2q4tgxLx/CoIFXY3ifXj8+gKto+3dzo
        f9DqGjN1O5x5AV3EqJRWUGlfEQ7Ny4/g5qXNS5u+Gqvs4wNOLFcDu/lXWyDgSfC1
        c3G/u/qvBmo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2BD2F41DB;
        Tue, 24 Nov 2020 19:39:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 166A9F41DA;
        Tue, 24 Nov 2020 19:39:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Pick the right default and stop warn on `git pull`
References: <20201123191355.GA132317@mit.edu>
        <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
        <20201123202003.GB132317@mit.edu>
        <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
        <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
        <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
        <X7xWSs3/vVqKl6sK@coredump.intra.peff.net>
        <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
        <X7xgow4pchnhf2iY@coredump.intra.peff.net>
        <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
        <X7xw0xb9UnGKbS8m@coredump.intra.peff.net>
        <CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com>
        <CAMMLpeSoGtqeCm6u-zrHqvPhW7brvNk_kwde3uqmbPcP1JgMHg@mail.gmail.com>
        <CAMP44s2z3vv2LwoMesydVL3qWrJh0VvHSUy+FpnqguoipRRD9g@mail.gmail.com>
        <CAMMLpeQvofhPjcJ19JrqJs1W3YoQSP+hOainuZJa=QeJzYc+5w@mail.gmail.com>
Date:   Tue, 24 Nov 2020 16:39:42 -0800
In-Reply-To: <CAMMLpeQvofhPjcJ19JrqJs1W3YoQSP+hOainuZJa=QeJzYc+5w@mail.gmail.com>
        (Alex Henrie's message of "Tue, 24 Nov 2020 16:23:49 -0700")
Message-ID: <xmqq7dqagtgx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B639788E-2EB6-11EB-B3D4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> We'd only need a warning if both pull.ff and pull.rebase are unset,
> since that's the only situation where the behavior would change. And
> providentially, we already have a warning in that exact case, although
> we should probably tweak it to explain what the new behavior is going
> to be :-)

If we were starting "git pull" from scratch without any existing
configuration and command line options, pull.mode might present a
simpler end user experience, but I have to say that pull.ff and
pull.rebase that are fairly well ingrained in docs and users' minds,
the above plan sounds like a better option to reduce the cognitive
overhead for users.

>> And yes, it should be possible to do what you suggest, but have you
>> tried? I suspect both the code and the documentation would be quite
>> convoluted.
>
> Yes, I have written a very simple patch that implements the behavior
> that I am suggesting. I will send it to the mailing list later
> tonight.

Let's see how well the comparison between two approaches play out.
Thanks.
