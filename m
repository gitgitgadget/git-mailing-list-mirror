Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4525F1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 16:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfGZQT5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 12:19:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64041 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfGZQT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 12:19:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F263969971;
        Fri, 26 Jul 2019 12:19:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MSAg7Cr3cQep
        RJoBoOGkWA8XAS0=; b=JQUHkPRzm8dgXxbvxpZFrxkzdoJygq63a5ejhz0wy/K2
        xcCuqVjIdb9wHasz5HG+YHSlgRJK+kSSWPmq4TkT3xSkRe8OE6oATjyBmETgFL3C
        eBRv4Wn0XzFm91UJEmu+gisbihD0AyW2Xytt9OyQ9fSjca3eL8dU1o+AztwFNnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=A4OEiC
        v45Rc2fZKaTTGeZcmDgthW7qj7pBlD5vzjhKQ9AixF80Id+qfWIJNReZpD+fsk/5
        GOp7p3j4rRiRrDYV7b3i1ip2acl+mnSt8ohkqzAqInggf+DxZilcFCzf6YUuTvvD
        vgNWKME/9l76gRw3gWWFrWDttGu5mImTKqstw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9ECF69970;
        Fri, 26 Jul 2019 12:19:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 200D469969;
        Fri, 26 Jul 2019 12:19:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
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
        <xmqqpnlzqh3d.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907251143430.21907@tvgsbejvaqbjf.bet>
        <xmqqlfwmqnb5.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907252021230.21907@tvgsbejvaqbjf.bet>
        <87ef2c7roy.fsf@evledraar.gmail.com>
Date:   Fri, 26 Jul 2019 09:19:46 -0700
In-Reply-To: <87ef2c7roy.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 26 Jul 2019 17:15:25 +0200")
Message-ID: <xmqqy30kojj1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 30A9683E-AFC1-11E9-87D3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> FWIW what I meant was not that we'd run around and iconv() things, it
> wouldn't make much sense to e.g. iconv() some PNG data to be "UTF-8
> valid", which presumably would be the end result of something like that=
.
>
> Rather that this model of assuming that a UTF-8 pattern means we can
> consider everything in the repo UTF-8 in git-grep doesn't make sense. M=
y
> kwset patches *revealed* that problem in a painful way, but it was ther=
e
> already.

We already do assume that pathnames are UTF-8 (pathspecs on MacOS
are converted and then they are matched assuming that property).
Further, with the same mechanism, I think there is an assumption
that anything that comes from the command line is UTF-8 (and if I
recall correctly, doesn't the Windows port of Git force us to use
the same assumption---I recall we needed tests tweak for that).

In the very very longer term, I do not think we would want to keep
the assumption that the text encoding of blobs is always UTF-8, and
it would be nice to extend the system, so that blob data could be
marked in some way to say "I'm in Big-5, and not in UTF-8, so please
treat me as such" and magically the needle and the haystack can be
made to agree, with iconv() either one of them. =20

But I do not think the current topic to fix the immediate/imminent
breakage should not be distracted by that.  Let's keep assuming that
any blob, when it is text, is UTF-8.

And from that point of view, I think the two pieces of idea in your
earlier message does make sense.  We can try to match as binary most
of the time, as UTF-8 would not let a valid UTF-8 needle match in
the haystack starting in the middle of a character.  When the user
is trying to match case-insensitively, we know the haystack in which
the user is interested in finding the needle is text, even though
there may be non-text blobs as well.

For example, "git grep -i 'foo' t/" may find a few png files under
the t/ directory.  We do not care if they happen to contain Foo and
we do not mind if they appear or do not appear in the result.  The
only two things we care about are (1) foo, Foo, FOO are found in the
text files under t/ and (2) the command does not die in the middle,
before processing all the files, only because a png file it found
were not UTF-8 valid.
