Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4902C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiAJRrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:47:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63230 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbiAJRrr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:47:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD2B71017D2;
        Mon, 10 Jan 2022 12:47:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0HeuwSVskZrlI4FmF4y49b32wFPh0Jzh9ek2kB
        MoOH8=; b=gQ1upgWR0D1yhskYqbnwkt1iPOYY0fhDiEl4qqoZzOPHhyt1vM9FC8
        DHJm5IAxEtgaHQjcbUOjA8OAfXXlXhM0hR5JyYA1RTIW2j2/zNCG7NOYuGFdR44c
        zVTkk4bRNLhJXOAdnMlXHNRIc0Eg2KbA7V8e7zR6s+foHuur076Yc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D452D1017D1;
        Mon, 10 Jan 2022 12:47:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4976A1017D0;
        Mon, 10 Jan 2022 12:47:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        congdanhqx@gmail.com, git@vger.kernel.org, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
References: <nycvar.QRO.7.76.6.2201071401240.339@tvgsbejvaqbjf.bet>
        <20220110082254.54400-1-dyroneteng@gmail.com>
        <nycvar.QRO.7.76.6.2201101346090.339@tvgsbejvaqbjf.bet>
Date:   Mon, 10 Jan 2022 09:47:44 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2201101346090.339@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 10 Jan 2022 13:49:13 +0100 (CET)")
Message-ID: <xmqqh7ab1nzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B7809E8-723D-11EC-BB1B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> [...] about the using "strbuf_addf(line, "%7s" , "-");" or
>> "strbuf_addstr(line, "      -");". [...]
>>
>> Why I prefer more of the former that is because, for the single line,
>> it's more readable I think.
>
> I strongly disagree. Using a format requires the reader to interpret a
> `printf()` format, to remember (if they ever knew) the rules about padding
> with `%<number>s` formats, and then to satisfy themselves that the result
> is correct.

Both "more readable" and "cognitive load" are quite subjective.

FWIW, I have a slight preference to the former because I do not have
to count the whitespaces to figure out at which column the construct
is trying to align to.  Most of the time, however, I may not deeply
care if the thing is aligned exactly, and "     -" might be easier
to scan and getting alarmed by seeing "%7s" to wonder if there is
something unusual going on.  When I am reading not for finding out
the precise output format but for general correctness, bunch of 
unknown number of spaces followed by a dash might be easier to see.

But once you know the language, "%7s" is not so alarming, and it
does make it easier to see both for casual scanning and for counting
columns.  It also is likely that those who know the language would
make more efficient developers to fix and/or enhance the code, so I
prefer to optimize the code for them.

