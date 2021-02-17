Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1909BC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D596264E79
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 01:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBQBlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 20:41:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54168 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhBQBlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 20:41:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DD21119D3B;
        Tue, 16 Feb 2021 20:40:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8MD9VpgXSx+t
        0IihPRBKLD7vEls=; b=yQtHZ5sRersALd0au/YIxUeT3gMuAy7G4sFzsg6umlHn
        oHifI/+k0d6+Ul5bg8tNkA4mlewf9S190WuMxPu4bIhbL//2kAOEXe84FcFS48IE
        J561rpQs2S154i4Shc2dYmCQuzLW5pG2oYdTFZMqOk9DbzC7aNcspBb9+uvDKyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AZi81k
        zxhYbuH4m0NnDJY9U8oqE0aJE92kjqz11IKRk9SlkJUFUmHDHBUvYEPZUznYjQ23
        8TS3ode2vjMc3fEAxnuLxsNDfUEnjkElvLZJWiTRH6kj/dnCQ+8ctiuzNBHgQm9B
        a/Cl2nqa2GzGMUybJ+tpPfW+MRJhrbtdn4NeM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45788119D3A;
        Tue, 16 Feb 2021 20:40:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8EB42119D39;
        Tue, 16 Feb 2021 20:40:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 11/27] blame tests: simplify userdiff driver test
References: <20210215005236.11313-1-avarab@gmail.com>
        <20210215154427.32693-12-avarab@gmail.com>
        <c1e637d5-ad69-1726-2b38-476d0192ca02@kdbg.org>
        <87eehfa36w.fsf@evledraar.gmail.com>
Date:   Tue, 16 Feb 2021 17:40:16 -0800
In-Reply-To: <87eehfa36w.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 17 Feb 2021 02:33:11 +0100")
Message-ID: <xmqqr1lfmpz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 173FDBAE-70C1-11EB-9523-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> +	fortran_file=3Dfile.f03 &&
>>> +	test_when_finished "rm .gitattributes" &&
>>> +	echo "$fortran_file diff=3Dfortran" >.gitattributes &&
>>> +
>>> +	test_commit --author "A <A@test.git>" \
>>> +		"add" $fortran_file \
>>> +		"$(cat file.template)" &&
>>> +	test_commit --author "B <B@test.git>" \
>>> +		"change" $fortran_file \
>>> +		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
>>> +	check_count -f $fortran_file -L:RIGHT A 3 B 1
> ...
>> Please place "$fortran_file" in dquotes on the check_count line.
>
> Why do we need to dquote a convenience variable defined in the test
> itself that'll never contain spaces or other funny things we'd get if w=
e
> had $(pwd) or whatever in there? It wouldn't hurt, but maybe I'm missin=
g
> some reason for why it's necessary or desired here.

Always dquoting when the code does not depend on splitting at IFS
whitespace reduces cognitive load.  The person who looks at the
variable reference, $fortran_file, has to wonder if the unquoted
form is used to take advantage of being split at IFS whitespaces, or
the test author saved two keystrokes because the filename does not
have any such whitespace, and go back to the assignment to check.

