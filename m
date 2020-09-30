Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A33C4727F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42DE620759
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v+FBLmum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgI3XJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:09:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56649 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732012AbgI3XIh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 19:08:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFBA6102F84;
        Wed, 30 Sep 2020 19:08:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=moqg2VCy3tCMET+8eD9pL4RD9e0=; b=v+FBLm
        umRRzKjNh9BCgopwE44shdAztsY9cl+PY23kBfKW+LBFysI38jer0R5KM6/lExjF
        fTc9URnESmu+xBgMaIs88U4ahTWX7vfHAGkEas1kyIFCczlah4Yb/FzByRtl6A15
        ZWC8u38NKg3qvk8gzx/Mpk4NqrPRdsdjn9yJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WXxHlVez5os8kQhDEuNy6l2mB0L2OfUj
        DIktcb818/kSGwkuVo1cgnIZlw9ylZWPawVWuL6P+jVW9cAF19cTFEffuPBUBuSl
        4aO7TKYdinK1+kKQOxFXAKHg7twKGVN4UZTg33qMYG+tj5nX+tM08moOBdmnJUcg
        odMXCiPDyV0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7FD4102F83;
        Wed, 30 Sep 2020 19:08:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B603102F82;
        Wed, 30 Sep 2020 19:08:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v4 08/10] cmake (Windows): initialize vcpkg/build
 dependencies automatically
References: <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
        <pull.738.v4.git.1601479585.gitgitgadget@gmail.com>
        <14ddfc17815d68f2f32aebbc4b0ecb3ce6f25dc1.1601479585.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2009302117220.50@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Sep 2020 16:08:31 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009302117220.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 30 Sep 2020 21:17:56 +0200 (CEST)")
Message-ID: <xmqqwo0aeuc0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC824518-0371-11EB-A7FC-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> squash! cmake (Windows): initialize vcpkg/build dependencies automatically
>>
>> MSVC
>
> Aaargh! This was of course meant to be deleted after rewording the commit
> message :-(

OK.  I noticed it and what got pushed out has them removed.

Hopefully we can merge this round down to 'next' after waiting for a
day or two to see if anything new gets noticed.

Thanks.
