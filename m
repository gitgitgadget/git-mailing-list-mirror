Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9054C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893CB64E79
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBQVD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:03:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51926 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhBQVDc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:03:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFE0412345E;
        Wed, 17 Feb 2021 16:02:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1glGLAwcH09p
        tmm8Mek4e4Sr43M=; b=wHmbzdPbDl6ryy/Gyl6tjGCtH5xzrFleDCsF40dkb8Rx
        Y208KSZyyxha2ayFe7sGpB51qN2tf3PErEcTRTsUMGSVPpLIf/0r+SJBMM1wNJns
        V9evOLLOum0VQ+7AcWNH4LGQq5zusJnww0fByaCCFD/Gb6NnRy9zEWyL9nac1wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=X1Heg7
        DGudVKOvGAwUzm/Wgy45gPdX1Q9hCAWL5/zIsqSlYxCviR6UjUTLIVFZ1tqL9949
        Cj5CoSgX5xgZJl73bWVD8gW0ifgWr5Jvx92fqMEuFHA3TQyW/IV066VFpjVN9m4N
        Y9zuaV+5UtZgtRLuzgvOwggFQo8SGz1uOvfk4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C85AC12345D;
        Wed, 17 Feb 2021 16:02:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E6AF312345B;
        Wed, 17 Feb 2021 16:02:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/14] fsck: API improvements
References: <87blcja2ha.fsf@evledraar.gmail.com>
        <20210217194246.25342-1-avarab@gmail.com>
Date:   Wed, 17 Feb 2021 13:02:44 -0800
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 17 Feb 2021 20:42:32 +0100")
Message-ID: <xmqqo8gijtl7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7BEAA78A-7163-11EB-B15E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Jonathan Tan pointed out that the fsck error_func doesn't pass you the
> ID of the fsck failure in [1]. This series improves the API so it
> does, and moves the gitmodules_{found,done} variables into the
> fsck_options struct.
>
> The result is that instead of the "print_dangling_gitmodules" member
> in that series we can just implement that with the diff at the end of
> this cover letter (goes on top of a merge of this series & "seen"),
> and without any changes to fsck_finish().
>
> This conflicts with other in-flight fsck changes but the conflict is
> rather trivial. Jeff King has another concurrent series to add a
> couple of new fsck checks, those need to be moved to fsck.h, and
> there's another trivial conflict in 2 hunks due to the
> gitmodules_{found,done} move.
>
> 1. https://lore.kernel.org/git/87blcja2ha.fsf@evledraar.gmail.com/

Let's get this reviewed now, but with expectation that it will be
rebased after the dust settles.
