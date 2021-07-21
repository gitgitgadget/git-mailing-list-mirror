Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762C8C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601F861287
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhGUWZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:25:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51062 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhGUWZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:25:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C4E0145874;
        Wed, 21 Jul 2021 19:06:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hN3alXv1EwEk
        cwSmyVyoDu81CmKynT5xWZaBQJwR7s8=; b=bqDBC8kskdOKjxPxRM5fWM6cvmwr
        uOQVMuxeC12qwrR6praLK9fYsmzcyUob5vWvWiahuWIsa+qchN6OJ4TmZpE17Xs2
        /RIKfOJqEU+ymc0n6AOM3vDggXpiGk5owvGgq0vYl/ssasfJPQTTxYZgRAkNFm0O
        IbU/PYcXcxFxlns=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25500145873;
        Wed, 21 Jul 2021 19:06:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6A8C114586F;
        Wed, 21 Jul 2021 19:06:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/5] http: drop support for curl < 7.19.4
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
        <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
        <patch-3.5-faae88b7fec-20210721T220402Z-avarab@gmail.com>
Date:   Wed, 21 Jul 2021 16:05:58 -0700
In-Reply-To: <patch-3.5-faae88b7fec-20210721T220402Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Jul
 2021 00:22:14 +0200")
Message-ID: <xmqqlf5zb73d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 36FE35FE-EA78-11EB-AF11-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> In the last commit we dropped support for curl < 7.16.0, let's
> continue that and drop support for versions older than 7.19.4. This
> allows us to simplify the code by getting rid of some "#ifdef"'s.
>
> Git was broken with vanilla curl < 7.19.4 from v2.12.0 until
> v2.15.0. Compiling with it was broken by using CURLPROTO_* outside any
> "#ifdef" in aeae4db174 (http: create function to get curl allowed
> protocols, 2016-12-14), and fixed in v2.15.0 in f18777ba6ef (http: fix
> handling of missing CURLPROTO_*, 2017-08-11).

Hmph, doesn't the proposed log message of 1/5 need updating then?
The above says CURLPROTO_* breakage was only during a few months in
2017 and hints that we've been OK for the past 4 years, but 1/5 says
we need further work to if we want to get stuff working with a
version of cURL without CURLPROTO_* stuff, which directly contradicts
with "we fixed it at v2.15.0" above.

> It's unclear how much anyone was impacted by that in practice, since
> as noted in [1] RHEL versions using curl older than that still
> compiled, because RedHat backported some features. Perhaps other
> vendors did the same.
>
> Still, it's one datapoint indicating that it wasn't in active use at
> the time. That (the v2.12.0 release) was in Feb 24, 2017, with v2.15.0
> on Oct 30, 2017, it's now mid-2021.

Yeah, with RHEL 6 at 7.19.7 (from the proposed log for 2/5), I agree
that we'd not be worried too much about pre 7.19.4 as we used to.
