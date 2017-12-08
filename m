Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772061FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 22:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbdLHWxE (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 17:53:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54444 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752644AbdLHWxD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 17:53:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23311B1D18;
        Fri,  8 Dec 2017 17:53:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=VrljmkwFeVlm07gIOVMBrzT7e
        YE=; b=vlHGthC7L9dnwSHosL83bl0Z5uwGt3qQ9V6A5sd3YFfkvt1OvsCKd98bD
        1JFvEo73id25/4OPxrRrVbTeTlonzJJr0RXqGR7HtE4VuTxseBvVyf97DYjaofRD
        NA9KsiHeNIvDsGy6Uyygabk0atF97pWnYbRs8tQqLOiaPO0mEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=GAzAWe/BJjyFOhNmFF6
        pzWbr37/rjO/V3b7GGb9QnCx+Hl9CZnxQMY0lZonl51JsTw4iDamDyE5xdTLEAnR
        QT9YcGNlECcIehqToURhi5gSs8llGU8qwwqZfgnhSJWUGF70QcTuqT1Qpf9varr9
        lUwRbM7oFaShsNjac86GXt7E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C204B1D17;
        Fri,  8 Dec 2017 17:53:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 91AE2B1D15;
        Fri,  8 Dec 2017 17:53:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: use the sha1collisiondetection submodule by default
References: <20171208223001.556-1-avarab@gmail.com>
        <20171128213214.12477-1-avarab@gmail.com>
        <20171208223001.556-5-avarab@gmail.com>
Date:   Fri, 08 Dec 2017 14:53:01 -0800
Message-ID: <xmqqo9n86dde.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8BAD7878-DC6A-11E7-B79E-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Instead the Makefile will emit an error if the contents of the
> submodule aren't checked out (line-wrapped. GNU make emits this all on
> one line):
>
>     Makefile:1031: *** The sha1collisiondetection submodule is not
>     checked out. Please make it available, either by cloning with
>     --recurse-submodules, or by running "git submodule update
>     --init". If you can't use it for whatever reason you can define
>     NO_DC_SHA1_SUBMODULE=3DNoThanks.  Stop.

Sounds OK. =20

But I actually do not mind to (and may even prefer to) have an
endgame opposite of what this series tries to lead us to.  We've
tried to have this as submodule, we've seen that the arrangement
works, and now we declare victory and get rid of the submodule.

That endgame allows us not force people to grab an essential part of
the codebase as an external dependency from another place, which
feels quite bad, especially when their primary interest is not in
dogfooding submodule but in building a working version of Git.

Removing one and keeping the other between the two will make the
distribution more streamlined by removing the build-time knob we
need to tweak, but the one that gets removed does not have to be the
in-tree one that allows people to "git clone" from just one place.

