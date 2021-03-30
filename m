Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2119DC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D191E61994
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhC3X0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:26:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63783 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhC3X0s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 19:26:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 282B7C1A49;
        Tue, 30 Mar 2021 19:26:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=J0PIh+22germ
        ck6PlAfCOyq+sjc=; b=A/wkdJFtDp+zHjdtDwefsBSfvKSQOWyMfQPdESFWaXkE
        oN6tt/7XcjdlA4fMe/VT75RZ2oeV00qGhq+40wimznyvmOh8hN9nOpjxm7eum3M5
        qodh3BTkaSZfTWvS2jyqcKLtBGW68dFskD+/UDWhQV8qJ+lpoyJUpqYpFHBByb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bOjr17
        oLPowJgN3z4nmx+aPMqTCOAidhpoUWnxSsZG0R1MsphKjz/blVzx/eq6ehB1pCQW
        nm9MFLLk7F9vPXSibjjYDN84GBVAx/bsPxbTv/4jZ2ZEETG0XfWsmK0flTcmolo5
        b3g0IIICso8AhVtrKzOzC8lNv2ppYfT2sHjK8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E281C1A48;
        Tue, 30 Mar 2021 19:26:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C859C1A47;
        Tue, 30 Mar 2021 19:26:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 05/22] pickaxe tests: refactor to use test_commit
 --append --printf
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-6-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 16:26:45 -0700
In-Reply-To: <20210216115801.4773-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:57:44 +0100")
Message-ID: <xmqq5z18b4ui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 64FE580C-91AF-11EB-86D7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor existing tests added in e0e7cb8080c (log -G: ignore binary
> files, 2018-12-14) to use the --append option I added in
> 3373518cc8b (test-lib functions: add an --append option to
> test_commit, 2021-01-12) and the --printf option added in a preceding
> commit.
>
> See also f5d79bf7dd6 (tests: refactor a few tests to use "test_commit
> --append", 2021-01-12) for prior similar refactoring.

This does not exactly look like a "refactoring".  There are at least
two differences and it is the courteous thing to do to readers to
note them and explain why these differences do not impact the
correctness of the tests, I would say.

 * The original uses a dedicated branch, while the rewritten uses a
   dedicated repository for these tests.  This does not impact the
   correctness as long as all the tests that originally used the
   branch are made to run in this new repository with "git -C".

 * The youngest change removes the binary sample file, while the
   rewritten only truncates it.  This does not impact the
   correctness, because a removed file and a file whose lines are
   all removed behave in the same way with respect to -G/-S.  Both
   will reduce the number of occurrence of -S<needle>, and make
   "removal" (-) lines of -G<needle> appear in the patch.

>  test_expect_success 'setup log -[GS] binary & --text' '
> -	git checkout --orphan GS-binary-and-text &&
> -	git read-tree --empty &&
> -	printf "a\na\0a\n" >data.bin &&
> -	git add data.bin &&
> -	git commit -m "create binary file" data.bin &&
> -	printf "a\na\0a\n" >>data.bin &&
> -	git commit -m "modify binary file" data.bin &&
> -	git rm data.bin &&
> -	git commit -m "delete binary file" data.bin &&
> -	git log >full-log
> +	test_create_repo GS-bin-txt &&
> +	test_commit -C GS-bin-txt --append --printf A data.bin "a\na\0a\n" &&

The --append on the first one does not make any difference ;-)

> +	test_commit -C GS-bin-txt --append --printf B data.bin "a\na\0a\n" &&
> +	test_commit -C GS-bin-txt C data.bin "" &&

The original removes the file at the end, while this merely
truncates it.

> +	git -C GS-bin-txt log >full-log
>  '
