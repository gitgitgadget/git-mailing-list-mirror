Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC663C433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 00:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC1964F70
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 00:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhCMAAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 19:00:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51497 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbhCLX7i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 18:59:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 942C1BF298;
        Fri, 12 Mar 2021 18:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FnVyG2yROj9x
        gtzoWnkLU0wpGfQ=; b=wfghQiB5n0xGe+l9yXtaP60k8R8YZa4USceLwjXzONkz
        8dNzA4UOHTrObFGoJU3i15y+A/U9fE+f7C7DRRFFP3t1GqkU9ay9CVY8eW1B2zYB
        8YA98dpiwV7JrGv2teOTrC5jJdnFE2EOBxh4VpcfH6gKAAoHjkhsi0CsLTG6I9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NTkHhn
        iSavl3FD3QUiWm/O7Ul+2fc9lMit53xpPTqUydYbODRAUYTLg7yZTKbPyoceclbJ
        vR5p8AvruTTi4b7b5EjEiEyntfVy4i3CdYVpJXmJcrxKsx+UGCKQrgb3j5gVV9yY
        O5LCQUVkC92E5DhloT+NC0cYyWSowM5JFODDY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C6F1BF297;
        Fri, 12 Mar 2021 18:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D658BF296;
        Fri, 12 Mar 2021 18:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 00/10] describe tests: refactor & fix recent broken tests
References: <20200223125102.6697-1-benno@bmevers.de>
        <20210228195414.21372-1-avarab@gmail.com>
Date:   Fri, 12 Mar 2021 15:59:36 -0800
In-Reply-To: <20210228195414.21372-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 28 Feb 2021 20:54:04 +0100")
Message-ID: <xmqq1rcj6hzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 002CDDB4-838F-11EB-BEEA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> While looking at the "git describe" tests due to the on-list
> %(describe) discussion I discovered that the feature added in
> 30b1c7ad9d (describe: don't abort too early when searching tags,
> 2020-02-26) has never been tested for.

This came during -rc freeze and got reviewed, so I'd expect a reroll
sometime but does not have to be done in a hurry before the final
which is expected to happen on the 15th.

Thanks.
