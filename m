Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE1BC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0791B61076
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhKDRW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:22:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63884 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhKDRW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 13:22:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 183C016D995;
        Thu,  4 Nov 2021 13:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YjA/reYD9zpZ
        b6sDrrGF5kksyOPUXf+CJFF4VtOxoVE=; b=nbqtaVnWiak0I03Mcy2g7rAEX6Qw
        AooX2gIk7py6TqlvmpetJFZ+NsZtQhp7XOTcs5aEWYbzZntN0nvG6ma4wxr+65nJ
        9tg5bnp0VXd9zYvuOCztWEteSG8bVg5nGSi7eSlrZ9lGX+7mWNLYa74YfYZa3dja
        eRrygSixSo/Z2Yk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 120D616D994;
        Thu,  4 Nov 2021 13:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BE50116D991;
        Thu,  4 Nov 2021 13:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] ci: disallow directional formatting
References: <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com>
        <pull.1071.v3.git.1636031609982.gitgitgadget@gmail.com>
        <211104.86ee7whvoz.gmgdl@evledraar.gmail.com>
Date:   Thu, 04 Nov 2021 10:19:44 -0700
In-Reply-To: <211104.86ee7whvoz.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 04 Nov 2021 14:48:29 +0100")
Message-ID: <xmqqpmrf3kjz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 681E2464-3D93-11EC-989C-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +# U+202a..U+2a2e: LRE, RLE, PDF, LRO and RLO
>> +# U+2066..U+2069: LRI, RLI, FSI and PDI
>> +regex=3D'(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2=
069)'
>> +
>> +! LC_CTYPE=3DC git grep -El "$(LC_CTYPE=3DC.UTF-8 printf "$regex")" \
>> +	-- ':(exclude,attr:binary)' ':(exclude)*.po'
> ...
>    ! git -P grep -nP '[\N{U+202a}-\N{U+202e}\N{U+2066}-\N{U+2069}]' ':!=
(attr:binary)'

So you are comparing

 * requiring bash and C.UTF-8 locale to be available

vs

 * requiring git built with PCRE

assuming that "Dscho says doesn't work with PCRE and you say it
works with PCRE" is resolved?  They seem roughly the same
difficulty to me.

