Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5B720899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbdHHWJN (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:09:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51840 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752021AbdHHWJM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:09:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E0E797C7A;
        Tue,  8 Aug 2017 18:09:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WUiC2nW/hVGS
        9IcAiQ5/5xXZH4I=; b=JtFYGlcrqRdnTb+8nLCXwJfR+7fnO2XefRje8HlF7OMe
        qRJMumNvNwKNVrHxxKIDtHnHhkrZv5q+olcRzNTs5pLzfcQbVat6aqFZuTAyZeXt
        WMhLrm1OAZJ5ctMr4xd1GZZ424KUk5/xVW+jdddgad5hNR+7ROVjEydZ0w2Bock=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iISwQx
        NDzot4KGRseprIG/vutPlBIG54JGR9sQ6BFbhlyZsXhxKE5Mr8BaU6Ezeoszq8gN
        DIyvPhnXO1YhXWvCkTPY+TUlcj8IH3VEGdtTT/mn8ZNIbc3MNBpofnGbKpk2OGS/
        BcZVOoB73RW/H6Aq1nQN/hfDgZYeFZWEqVEL0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13DC097C79;
        Tue,  8 Aug 2017 18:09:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5265D97C72;
        Tue,  8 Aug 2017 18:09:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        David Coppa <dcoppa@openbsd.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] t4062: stop using repetition in regex
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
        <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
        <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de>
Date:   Tue, 08 Aug 2017 15:09:01 -0700
In-Reply-To: <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 8 Aug 2017 17:18:31 +0200")
Message-ID: <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 30322992-7C86-11E7-A94C-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 08.08.2017 um 16:49 schrieb Johannes Schindelin:
>> Hi Ren=C3=A9,
>>=20
>> On Tue, 8 Aug 2017, Ren=C3=A9 Scharfe wrote:
>>=20
>>> OpenBSD's regex library has a repetition limit (RE_DUP_MAX) of 255.
>>> That's the minimum acceptable value according to POSIX.  In t4062 we =
use
>>> 4096 repetitions in the test "-G matches", though, causing it to fail=
.
>>>
>>> Do the same as the test "-S --pickaxe-regex" in the same file and sea=
rch
>>> for a single zero instead.  That still suffices to trigger the buffer
>>> overrun in older versions (checked with b7d36ffca02^ and --valgrind o=
n
>>> Linux), simplifies the test a bit, and avoids exceeding OpenBSD's lim=
it.
>>=20
>> I am afraid not. The 4096 is precisely the page size required to trigg=
er
>> the bug on Windows against which this regression test tries to safegua=
rd.
>
> Checked with b7d36ffca02^ on MinGW now as well and found that it
> segfaults with the proposed change ten out of ten times.

That is a strange result but I can believe it.

The reason why I find it strange is that the test wants to run
diff_grep() in diffcore-pickaxe.c with one =3D=3D NULL (because we are
looking at difference between an initial empty commit and the
current commit that adds 4096-zeroes.txt file), which makes the
current blob (i.e. a page of '0' that may be mmap(2)ed without
trailing NUL to terminate it) scanned via regexec() to look for the
search string.

I can understand why Dscho originally did "^0{4096}$"; it is to
ensure that the whole page is scanned for 4096 zeroes and then the
code would somehow make sure that there is no more byte until the
end of line, which will force regexec (but not regexec_buf that knows
where the buffer ends) to look at the 4097th byte that does not exist.

If you change the pattern to just "0" that is not anchored, I'd expect
regexec() that does not know how big the haystack is to just find "0"
at the first byte and happily return without segfaulting (because it
does not even have to scan the remainder of the buffer).

So I find Dscho's concern quite valid, even though I do believe you
when you say the code somehow segfaults.  I just can not tell
how/why it would segfault, though---it is possible that regexec()
implementation is stupid and does not realize that it can return early
reporting success without looking at the rest of the buffer, but
somehow I find it unlikely.

Puzzled.

> You get different results?  How is that possible?  The search string is
> NUL-terminated in each case, while the point of the test is that the
> file contents isn't, right?
