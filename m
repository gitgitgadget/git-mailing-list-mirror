Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84BCC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 22:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FCF23130
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 22:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405322AbhALWfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 17:35:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56218 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbhALWe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 17:34:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 908E71011A0;
        Tue, 12 Jan 2021 17:34:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=yoeWjWpTIGGzAvBiNb3NspG+z
        g0=; b=j1NHlufU8wNLGjWEj2X24Te/FC4/RDBQ1nCA8s8gH52R8IJPR5qGfqUwW
        5pfWU6v99Ci9R1PEjYEdr8DH8ce7tgbMJI8OU9khSCV0d04rmciTyWIFHTMtrTr8
        RGcnWQyOxVuRgV3FjQdjDAbTgRuROXXBnwpV4OwUSP29obGsys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=Sn5DSqxUu7a8gVdKTgH
        S27lvJ4dcl1V70xK7mSrcN1/1eKUAbf9MOvpV6jj2cISIA+xJqItWQSit07ow+CZ
        Qc2vHshFWXhvysI4ThpYCAvPGKj6Htxg5b1FlAL2etkgHBz0xPaa5Mo05ufRxuGJ
        rRfc5qBOiazYW1eunl6ojmrA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8983210119C;
        Tue, 12 Jan 2021 17:34:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CFB8410119A;
        Tue, 12 Jan 2021 17:34:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 14/22] test-lib functions: add --author support to
 test_commit
References: <20210105130359.21139-1-avarab@gmail.com>
        <20210112201806.13284-15-avarab@gmail.com>
Date:   Tue, 12 Jan 2021 14:34:13 -0800
Message-ID: <xmqqr1mp23a2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4CB01F6C-5526-11EB-B09C-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add support for --author to "test_commit". This will simplify some
> current and future tests, one of those is being changed here.
>
> Let's also line-wrap the "git commit" command invocation to make diffs
> that add subsequent options easier to add, as they'll only need to add
> a new option line.

Makes sense.

> -	git commit -m "Initial Commit" --author Frigate\ \<flying@over.world\=
> &&
> -	git tag Initial &&
> +	test_commit --author Frigate\ \<flying@over.world\> \
> +		"Initial Commit" foo Initial Initial &&

Why not fix the value of the author while at it to be more readable?
E.g. --author "Frigate <flying@over.world>"
