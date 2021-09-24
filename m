Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE34C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE0261250
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbhIXSAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:00:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53983 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344419AbhIXSAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:00:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 358AF166BDB;
        Fri, 24 Sep 2021 13:59:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GJbbtCB+naRE
        lOWpEXOufendx17DK0L/u5PFuYUW2vo=; b=OD3sRaIRNMScHNOmXoqy4pITCOjJ
        C5kg6DPlQR2YWLFLN0qRF9i26dNgX1VabdhuKCAbVhjdNGEdrvHTE9uApviqMVIU
        agweXJKdBZrhgxVa+33fcLKh1l85J3owOsomKwt7bbCtxCieqgW2ivT93gJxmmkP
        9aTXR42/3Sv7Fek=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D9B9166BDA;
        Fri, 24 Sep 2021 13:59:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 90AE9166BD3;
        Fri, 24 Sep 2021 13:59:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: Is "make check-docs" useful anymore?
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
        <pull.1038.v2.git.1631626038.gitgitgadget@gmail.com>
        <bc9a4534f5bc6756ab2df869b55e390183c4ff30.1631626038.git.gitgitgadget@gmail.com>
        <87o88i2keu.fsf@evledraar.gmail.com>
Date:   Fri, 24 Sep 2021 10:59:07 -0700
In-Reply-To: <87o88i2keu.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 24 Sep 2021 15:00:42 +0200")
Message-ID: <xmqqpmsxvor8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1D86FDEC-1D61-11EC-A2BA-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I didn't notice until after it hit master that this caused a regression
> in "make check-docs":
>
>     $ make -s check-docs
>     removed but documented: git-version
>
> The "fix" is rather easy, i.e. adding "git-version" to the whitelist.
>
> But I wondered about $subject, i.e. we want to run the "lint" part, but
> do we really need something reminding us that there isn't a mapping
> between Documentation/*.txt and *.o files present at the top-level?

There were multiple things check-docs wanted to catch originally.

 - commands not referred to from the main page
 - a new command added without documentation
 - an old command removed while leaving documentation

It may be that we no longer remove commands, so the last check may
be less useful.

> If we're going to keep it in pretty much its current form then the CI
> integration added in b98712b9aa9 (travis-ci: build documentation,
> 2016-05-04) seems rather useless when it comes to this, i.e. we should
> either adjust it to exit non-zero,...

Yes, that is a good thing to do.

Thanks.
