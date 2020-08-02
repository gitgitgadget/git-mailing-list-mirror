Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75BAC433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 17:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8369E20738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 17:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H65AcZCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgHBR5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 13:57:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63819 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHBR5r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 13:57:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6445BEC4F2;
        Sun,  2 Aug 2020 13:57:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/D2B/I907Z88
        W4Z7Lv0zp23eX58=; b=H65AcZCYbR0Z22vLdeiIUvG9PG3aAtuqKwQlwZdhGwHk
        v5yR6FVMaRygxURBmYLUDBQGLhcbaWTumqsXrj3qXwpwYdypgrChV1UXqM7dkzJa
        bqi20ikoXpLKM/HnXqy1yIlBiFSRqEBRdbZDOcxwabWRUSO9pF5JPyk4psJxClI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kfw6ib
        zFUYZup0Z3GfQtaAGG0JE1wdKtOMIkrFyKJ6UWi4RZaRZdH/2jAHgpwaqmAgqUGJ
        0+fEgqUZ3CRMchEf9bMqAhn185yCsfPpij4cwJhCBaABWxk8k8WuEqH4EgsN/vMf
        io0IqvB7dP1lEne2Ue9QOvlPhqjDs2bpnbLDs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C869EC4F0;
        Sun,  2 Aug 2020 13:57:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5B07EC4EF;
        Sun,  2 Aug 2020 13:57:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] t1450: fix quoting of NUL byte when corrupting pack
References: <20200801220611.10453-1-martin.agren@gmail.com>
        <CAPx1GvcZFVfmP8aTdXu_epdSn1EDy_cP6-=hi65c_5DbNEq+FQ@mail.gmail.com>
        <CAPx1GvcD80MfjZLiKBrH8BgsvVToZ90C057gk7b4BUzbLMNu2A@mail.gmail.com>
        <CAN0heSoYAJkZVG7_TPTo3Osz+FuR__AY5Ykc8OSwzARTotfwcQ@mail.gmail.com>
        <CAPx1GvdZNeuQqmYm8G62Zr02k=B5GK69xPw84WnvMCeJU7_amQ@mail.gmail.com>
Date:   Sun, 02 Aug 2020 10:57:40 -0700
In-Reply-To: <CAPx1GvdZNeuQqmYm8G62Zr02k=B5GK69xPw84WnvMCeJU7_amQ@mail.gmail.com>
        (Chris Torek's message of "Sun, 2 Aug 2020 09:20:13 -0700")
Message-ID: <xmqqmu3drkvf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A9A633CC-D4E9-11EA-8655-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> On Sun, Aug 2, 2020 at 7:35 AM Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>> No worries! Thanks for having a look at the patch. Is there anything
>> that could be done to make this clearer in the commit message? (I find=
 it
>> quite awkward to discuss quoting: will the reader understand which
>> quoting is part of my own formatting of the message vs which is part o=
f
>> the quoting issue I want to get across!?)
>
> This is indeed a problem...
>
> Perhaps something along these lines (generic boilerplate
> for any single-quote fixes, that should be adjusted for the
> actual fix):
>
>     In the test scripts, the recommended style is, e.g.:
>
>         test_expect_success 'name' '
>             multi-line test
>             goes here
>         '
>
>     When using this style, any single quote in the multi-line
>     test section is actually closing the lone single quotes
>     that surround it.  To avoid confusion, minimize and/or
>     eliminate the use of single quotes here.

Another thing that falls into the same class and probably be a good
addition to the above "tip" is how $variables are interpolated, i.e.

	test_expect_success 'test name' '
		test-that-references $variable &&
		another-test-that-references "$variable"
	'

are 99% of the time the right way to refer to variable that is
assigned outside the test itself (e.g. the whole four lines shown
above may be in a loop, "for variable in a b c; ... ;done").

	test_expect_success 'test name' '
		test-that-references '$variable' &&
		another-test-that-references '"$variable"'
	'

is most likely a wrong way to write for the first one (i.e. what if
the value in $variable has $IFS whitespace) and "not wrong per-se
but unnecessary" for the second one.

Same applies to $(command) substitution, but it is more important.
"Step out of the quote, evaluate and step back into the quote"
pattern would mean the command is evaluated while formulating the
body of the test, not while running the test, which often is not
what the author intended.

Thanks.
