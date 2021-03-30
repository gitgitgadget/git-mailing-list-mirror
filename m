Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3532AC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A48619CD
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 23:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhC3XMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:12:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54188 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhC3XMD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 19:12:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 416E112EA69;
        Tue, 30 Mar 2021 19:12:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LpoBIrAnPO/j
        geiDJb8KjSfX+Ik=; b=lP6obZqcORAZCx18HWPNLhdS/JvzPsnTDVFiA5BOaaPl
        T21Q/hlHbGM5VHR4QJ93sQpzPetqOb2IgezimRK9WIqlZvicJTflusLB2KRR+cHR
        sweMg9hTTzt9jNizbSWksljgds8+zwwwq9prdvtIVeAyqKkwKJ3gfUN0GnjyXIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cTVz40
        xX0OBIFg1tLDhq1vAYhaoY/2wphXBjNSdgfTxjGQ5vx82g0JrfsOOKJF0a+41w9A
        b/ZsuLM1Uyi8Q4cxmKZAVxoIjfegNa+JwlXLs6NobLUPhQ5+IL18wyghggiNRz+s
        YsnUG5JM6Hzx1bPbZwWDu2nDgQLV6BdUfyET0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 348A212EA68;
        Tue, 30 Mar 2021 19:12:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E53D12EA66;
        Tue, 30 Mar 2021 19:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 04/22] test-lib functions: add --printf option to
 test_commit
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-5-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 16:11:56 -0700
In-Reply-To: <20210216115801.4773-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:57:43 +0100")
Message-ID: <xmqqh7ksb5j7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 53AB7046-91AD-11EB-BA42-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  test_expect_success 'can parse blob ending with CR' '
> -	printf "[some]key =3D value\\r" >config &&
> -	git add config &&
> -	git commit -m CR &&
> +	test_commit --printf CR config "[some]key =3D value\\r" &&

OK, the first arg becomes the commit title, and the second one is
used for the filename, and the next arg is the string given to
printf, I guess.

>  test_expect_success 'rerere forget (binary)' '
>  	git checkout -f side &&
> -	printf "a\0c" >binary &&
> -	git commit -a -m binary &&
> +	test_commit binary binary "a\0c" &&

This lacks --printf.  Are we breaking the test but "test-must-fail"
is hiding the breakage here?

>  	test_must_fail git merge second &&
>  	git rerere forget binary
>  '

