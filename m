Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFA7C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 23:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E5923603
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 23:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbhAGXZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 18:25:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50081 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbhAGXZj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 18:25:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 917CB11EAA0;
        Thu,  7 Jan 2021 18:24:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/AZ71SdXlbYP
        MrjIkGMMyAgZ8a0=; b=mYvhfMo9JLGSV8tyv1T0V0Wn0midx091LNnmcAC+r3HH
        mX2YssH5e4e+PSw7Z3rSUsq58gSGkgxOYLBdFZ3qsVlJi66f6jwK5GeSLDrPGNWb
        7Q/kq2IEqm810qbXAh8Q/OjB142HETCLmvlYMLyNiAjX8vbK56e2ld7+f1aAbc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ixBz4L
        zfP4PP7VFNrYv+8VlnvDcDM7flvoVhkl/XGx0nrsU3RDXcFxvqAE0PcDsSs/BWMU
        a1HsZIHjGrfUWIIG98KPVxPp+mkn4NCig/CB0pE2QvpfjJTOVGkXfTyHXG7Dt0JA
        3X8hca3YK97QCWD5BLT5TZSeanQFv55+DJfJk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8926111EA9F;
        Thu,  7 Jan 2021 18:24:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D049E11EA9E;
        Thu,  7 Jan 2021 18:24:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Matthew DeVore <matvore@google.com>,
        git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, Johannes.Schindelin@gmx.de,
        karthik.188@gmail.com, pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 5/7] ref-filter: move ref_sorting flags to a bitfield
References: <20210106100139.14651-1-avarab@gmail.com>
        <20210107095153.4753-6-avarab@gmail.com>
Date:   Thu, 07 Jan 2021 15:24:53 -0800
In-Reply-To: <20210107095153.4753-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 7 Jan 2021 10:51:51 +0100")
Message-ID: <xmqqpn2gjpoa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8C9B65AE-513F-11EB-88E8-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Perhaps there's a more idiomatic way of doing the "for each in list
> amend mask" pattern than this "mask/on" variable combo. This function
> doesn't allow us to e.g. do any arbitrary changes to the bitfield for
> multiple flags, but I think in this case that's fine. The common case
> is that we're calling this with a list of one.

An obvious alternative would be to pass two masks, one for setting
and the other for clearing, instead of passing a mask and a bool
that says if the mask is for setting or clearing.

The helper that follows such a design would be:

	void ref_sorting_tweak_flags(struct ref_sorting *sorting,
				     unsigned set, unsigned clear)
	{
		while (sorting) {
			sorting->sort_flags |=3D set;
			sorting->sort_flags &=3D ~clear;
			sorting =3D sorting->next;
		}
	}

and the caller in the endgame would become

	...
	} else if (list) {
		unsigned set =3D REF_SORTING_DETACHED_HEAD_FIRST;
		unsigned clear =3D 0;

                *(icase ? &set : &clear) |=3D REF_SORTING_ICASE;
		ref_sorting_tweak_flags(sorting, set, clear);

which may be more lines but probably copes better when adding new
bits.

Thanks.
