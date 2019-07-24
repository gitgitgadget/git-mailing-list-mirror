Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F661F462
	for <e@80x24.org>; Wed, 24 Jul 2019 21:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbfGXVE6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 17:04:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61765 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfGXVE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 17:04:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E870A1645D6;
        Wed, 24 Jul 2019 17:04:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SIZLLMqKrcKs
        4m6buH/Wc3ao5UQ=; b=vqawN/zZoc8Y12cFAen2oXvLZQt4yupfFDMwtW2/9Bct
        8MwM94DNVo+QQ+/S4D+1aaOxBkxz4dhkl1NmK6bbd9BCTTLv3U9pV+18tmPjmeMN
        uJfcxo68kSw307Frp0HeOaFWk7DrMg9txY5PL+P52VHoi1IUnkE1kjv+BHqHruI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Qk4bzB
        Nc/BQA8pkbYAqjw/z/hLaR2f8EcRZUZFAzJiVQW/2IYT8JYZOByEoM9x9AJalCmI
        swDAiIlvPaUQ3XbSDuNr//kT3P4IlPyXoNt6jyzE8tH/xq6bbo9ZtmE0Kv4sOyof
        Pb4cA09asA0C0Ltfmvzi4drW9ndQ4fu7Umb/M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEBD81645D5;
        Wed, 24 Jul 2019 17:04:55 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 528F51645D4;
        Wed, 24 Jul 2019 17:04:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
References: <20190721183115.14985-1-carenas@gmail.com>
        <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
        <87muh57t5r.fsf@evledraar.gmail.com>
        <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com>
        <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet>
        <CAPUEspgytjywYHywGT4yAwYpQbMUicN4bpHfoD+M_HMe8YdPtg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1907241245540.21907@tvgsbejvaqbjf.bet>
        <87lfwn70nb.fsf@evledraar.gmail.com>
Date:   Wed, 24 Jul 2019 14:04:54 -0700
In-Reply-To: <87lfwn70nb.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 24 Jul 2019 20:22:48 +0200")
Message-ID: <xmqqpnlzqh3d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AFED98FC-AE56-11E9-9866-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The PCRE2_NO_UTF_CHECK flag means "I have checked that this is a valid
> UTF-8 string so you, PCRE, don't need to re-check it".

OK, in short, barfing and stopping is a problem, but that flag is
not the right knob to tweak.  And the right knob ...

>  1) We're oversupplying PCRE2_UTF now, and one such case is what's bein=
g
>     reported here. I.e. there's no reason I can think of for why a
>     fixed-string pattern should need PCRE2_UTF set when not combined
>     with --ignore-case. We can just not do that, but maybe I'm missing
>     something there.
>
>  2) We can do "try utf8, and fallback". A more advanced version of this
>     is what the new PCRE2_MATCH_INVALID_UTF flag (mentioned upthread)
>     does. I was thinking something closer to just carrying two compiled
>     patterns, and falling back on the ~PCRE2_UTF one if we get a
>     PCRE2_ERROR_UTF8_* error.

... lies somewhere along that line.  I think that is very sensible.
Let's make sure this gets sorted out soonish.

Thanks.

