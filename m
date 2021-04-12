Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292B3C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E9061206
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbhDLSix (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 14:38:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65049 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbhDLSiw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 14:38:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A43BC60EB;
        Mon, 12 Apr 2021 14:38:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=blIoRETppQknbvBWreoy21BBUNk=; b=mc1HLv
        aDet61yhiF2bQdj3+nDjs8cA8KdrY1xruGkRTmaJ4CtdU88Cx8N2LLVDfadb98uu
        ygfQCPHokIwHCZIKJA1C9cOEv5TC9sLbOSPNEyqWnD4OlKIje/hCkDIOaRru1w+d
        zPPUl+qEBeE3jsJaUKz9DWOIPPaRgIwBYXRzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=atS2NCJHS+OMSci+FzK3Qck1O4KDtpyC
        8TDoRofEjgqeC4DXzqYICnq1qgz256Zonv6VYfoTPu+4aQJskDqcDxsMTVoeAPGA
        5cvTunbyQim6KPw+iz4q0eZ+Ksxwz9qcGTA6fmgn/w+NTxySNnkhtso+Yq19GAWY
        Xt4N6VSdz5U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82052C60EA;
        Mon, 12 Apr 2021 14:38:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13612C60E9;
        Mon, 12 Apr 2021 14:38:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/16] check-non-portable-shell: complain about "test"
 a/-o instead of &&/||
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-01.16-8e4b4a2a216-20210412T110456Z-avarab@gmail.com>
        <CAPig+cQFFsLeE921WpzTxVnBMnNRiKs4N=hUQ2UQi1VznNEQwg@mail.gmail.com>
Date:   Mon, 12 Apr 2021 11:38:32 -0700
In-Reply-To: <CAPig+cQFFsLeE921WpzTxVnBMnNRiKs4N=hUQ2UQi1VznNEQwg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 12 Apr 2021 13:00:06 -0400")
Message-ID: <xmqqsg3vcpqv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48B6EEDE-9BBE-11EB-86DB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Given that these flags are considered obsolescent, thus may someday be
> dropped from some implementations, these seem a better fit for the
> "portability issues" section than the "coding style preferences"
> section. (I'd probably just drop those section titles, though.)
>
>> +       /\btest\s+-[a-z]\s+.*?\s+-a\s+/ and err '"test A && test B" preferred to "test A -a B"';
>> +       /\btest\s+-[a-z]\s+.*?\s+-o\s+/ and err '"test A || test B" preferred to "test A -o B"';
>
> These will only match the simplistic forms of `test -X blah` (where
> "-X" is some single letter option), but will miss expressions such as
> `test "$foo" = bar`. Crafting a regex to match more generally would be
> non-trivial, so this simpler match is a reasonable start. Okay.

Would it be a trivial improvement to do

    'test', followed by anything other than '&' or '|', and then
    followed by '-a' or '-o'

instead?
