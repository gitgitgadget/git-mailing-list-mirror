Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3917C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 21:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiAMVi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 16:38:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58813 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiAMVi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 16:38:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA7E9160BA3;
        Thu, 13 Jan 2022 16:38:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CQ64jCGdZqSX
        NL+GCDV7uyfoGh6o4moSnRv8y9o/WAw=; b=OxisBw73rn47dNxzFb1RKCHkdPQe
        wGeA1Ew0eaM1RvYlDLYjc+gLq/v4owlCT6hkrSWn56yam/y7L23ow7IIwEC4iphV
        M2hF8Ta/HySppRnZ576SxS4sdQq5sZFi8Ju0T7gmP92UEbQ1GXNYH58xP2UCeND0
        Qdbasb2Ns5LwW8c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3471160BA2;
        Thu, 13 Jan 2022 16:38:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2E527160BA1;
        Thu, 13 Jan 2022 16:38:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Han-Wen Nienhuys <hanwen@google.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] reftable tests: avoid "int" overflow, use "uint64_t"
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
        <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com>
        <Yd3aZ5Q9Ph0H+Ijn@nand.local>
        <CAFQ2z_M0Fjjx8tAd_cXqk9K9q43hwienEy=UsLJi2aW8G3sEwA@mail.gmail.com>
        <Yd3dao5Qh5yl/cBs@nand.local>
        <45baffd7-c9f3-cc52-47b4-ea0fee0182a8@kdbg.org>
        <Yd3mCVLyxkVTNcS9@nand.local>
        <e8e2c37d-39f1-0ae4-7894-07e85628a757@kdbg.org>
        <xmqqh7a8vkuq.fsf@gitster.g> <Yd8m2YeDZrgSiFzJ@nand.local>
        <220113.867db4vtk6.gmgdl@evledraar.gmail.com>
Date:   Thu, 13 Jan 2022 13:38:55 -0800
In-Reply-To: <220113.867db4vtk6.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 13 Jan 2022 11:04:07 +0100")
Message-ID: <xmqqh7a7gvtc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 35CD3A7E-74B9-11EC-B288-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The reason I left it at 0xffffffff is because the current test clearly
> doesn't care about using the maximum width of the type, and I was just
> trying to get rid of the associated compiler warning.

Sounds sane.  Let's take the original one you sent out, and those
who want to make things consistent can swap it with ~((uint64_t)0)
after the release.

Thanks.
