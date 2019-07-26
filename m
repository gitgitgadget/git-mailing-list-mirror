Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C011F462
	for <e@80x24.org>; Fri, 26 Jul 2019 20:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfGZUgr (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 16:36:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52705 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfGZUgr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 16:36:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ADA5168706;
        Fri, 26 Jul 2019 16:36:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=y2H16jS9+2Br
        YA8RHENuLMdBOr4=; b=wOwOLLg+pgHLjWU9ScFdNvgxE3LBvChtmn4p+1/L51QC
        lJ7A77l6LQoFpVjf+YdAEW+mNXuTZ3gOhCuTOIVZWk0bjyNlSzjOpJILp3O5siEU
        OKC6dPcfsiE3YSSe+o9cUHrHaQfZ6P3TR0JG96gLdwb6PvPQZXcf9/l/4rUAX1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dGiP4m
        fh5jgLqykDoj+wxt7D/8Js1wY2H8XfhnaTnC3GN2lEv7i/GE1Ku2GP0BW28YMR+F
        VM/oSHqugS3pCmTXyh2Uwu8BHzhi6CXOcntjCydp3/P6iNx6dyxYFapDnYgdlSVv
        afKcv2ErSsFeBET9+8xH3CCxlih9JLSYrz3M0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52A25168705;
        Fri, 26 Jul 2019 16:36:45 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B73CB168703;
        Fri, 26 Jul 2019 16:36:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 7/8] grep: do not enter PCRE2_UTF mode on fixed matching
References: <20190724151415.3698-1-avarab@gmail.com>
        <20190726150818.6373-8-avarab@gmail.com>
Date:   Fri, 26 Jul 2019 13:36:43 -0700
In-Reply-To: <20190726150818.6373-8-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 26 Jul 2019 17:08:17 +0200")
Message-ID: <xmqqh878mt2c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1516133C-AFE5-11E9-9DD1-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> When grepping a non-ASCII fixed string. This is a more general problem
> that's hard to fix, but we can at least fix the most common case of
> grepping for a fixed string without "-i". I can't think of a reason
> for why we'd turn on PCRE2_UTF when matching byte-for-byte like that.

Yes, exactly.  That's quite a sane and minimum fix/workaround, I
would think.

>  test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII f=
rom invalid UTF-8 data' '
> -	test_might_fail git grep -h "=C3=A6" invalid-0x80 >actual &&
> +	git grep -h "=C3=A6" invalid-0x80 >actual &&
>  	test_cmp expected actual &&
> -	test_must_fail git grep -h "(*NO_JIT)=C3=A6" invalid-0x80 &&
> +	git grep -h "(*NO_JIT)=C3=A6" invalid-0x80 &&
>  	test_cmp expected actual
>  '
