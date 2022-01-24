Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81573C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 17:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbiAXRIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:08:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52072 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiAXRIX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 12:08:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2345A174C6C;
        Mon, 24 Jan 2022 12:08:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=pXZJ2yExInzQP7LHIzGHjFClN
        HEDVGRsBgfUascCiH8=; b=WH3Y7/T5M+vsCv8YRxtqgoC11hHz2vlVyNISjJq2P
        6kLIM29J4geggLxSsW9qDK2bEB8c1Za+rFipOe49ykf0ScyeE7dBfVOpKyy14RHq
        pA/57kukzjGvnVbt3Hw/3pz4SArOHq/oUoV556dqtNGNEgmBf1MP6os1qyFX5WhQ
        KE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1ADBC174C6B;
        Mon, 24 Jan 2022 12:08:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8CF6B174C6A;
        Mon, 24 Jan 2022 12:08:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] wrapper: use a CSPRNG to generate random file names
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
        <20220117215617.843190-1-sandals@crustytoothpaste.net>
        <20220117215617.843190-3-sandals@crustytoothpaste.net>
        <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
        <3a2b17ac-6ce2-cc29-6993-a9718df61741@web.de>
        <xmqq7daxt0pk.fsf@gitster.g>
        <f31dd12e-6d27-a070-77e4-ad53fb319735@web.de>
Date:   Mon, 24 Jan 2022 09:08:17 -0800
Message-ID: <xmqqa6fl6ozi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 39F9A6A0-7D38-11EC-B0E6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> ...  But
> a replacement for git_mkstemp_mode() with two umask(2) calls looks less
> attractive to me than fortifying git_mkstemps_mode() with a good source
> of randomness.

True.

Also, it is not like we are supplying our own implementation of
random source, but are just pluggig various system-supplied random
source into our code, so I do not see the "auditatiblity" problem we
heard earlier too much of an issue.
