Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3332EC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1741160EB6
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbhIWRnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:43:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56785 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhIWRnI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:43:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 520FF15F46F;
        Thu, 23 Sep 2021 13:41:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=W+qiluxj+SA2
        wqrI6YbTnEDhtniCOCYJ5j5GGEyV4Dk=; b=OikHFu1lg7/7SB08NkxF99iD7Tgd
        p8/dEuPm5AynZFi/2YljhOKaXm+rz1RKsS/D+XUF9z/AUQMKh60G2K6eh8IxHDKX
        pdy2lKzAXJtQdWmIXZ+Jbqxoi/QyKvMHlPoOQQ1ASS/eQaBztpT8z1AK4AKrMhVs
        It+k/m28LXa47bQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BB6515F46E;
        Thu, 23 Sep 2021 13:41:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AE84115F46D;
        Thu, 23 Sep 2021 13:41:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work
 with DEVOPTS=pedantic
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
        <xmqqmto48ufz.fsf@gitster.g>
        <YUtiNuUiBU4Xg4gw@coredump.intra.peff.net>
        <xmqqzgs479d5.fsf@gitster.g>
        <YUuPYDkxjDIvIfwI@coredump.intra.peff.net>
        <xmqqo88k40pd.fsf@gitster.g>
        <YUypOEywhzEWpoef@coredump.intra.peff.net>
Date:   Thu, 23 Sep 2021 10:41:32 -0700
In-Reply-To: <YUypOEywhzEWpoef@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 23 Sep 2021 12:20:08 -0400")
Message-ID: <xmqqpmsz196b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7E5C3794-1C95-11EC-BD7E-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 22, 2021 at 05:03:58PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>=20
>> > I almost suggested using "git.c" as the dummy file, since we know it
>> > must compile anyway. But that probably has other problems (it's more
>> > expensive, and if it _does_ have an error, the results may be
>> > confusing).
>> >
>> > It's a shame we can't just try to do the _real_ compiles using the
>> > auto-dependency stuff, and then fall back if they fail. But I think
>> > there's a chicken-and-egg problem there with "make" doing real work,=
 and
>> > figuring out the dependencies to do real work.
>>=20
>> Yeah, if compiling any of the real sources is inexpensive enough, I
>> would think that would be the happy way to go.  Do we have a trivial
>> source that almost never changes?  Perhaps version.c (especially if
>> we kick out two helper functions that do not really belong there)?
>
> Perhaps. TBH, I find =C3=86var's latest patch to just add -Wno-pedantic=
 to be
> the simplest and most obviously-correct fix.

Yes, that is very much to-the-point.  If we have trouble with being
pedantic, forcing us not to be is a fine solution ;-)
