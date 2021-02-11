Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA71C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 18:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B10260238
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 18:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhBKR77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 12:59:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55913 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhBKR5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 12:57:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53F95A2693;
        Thu, 11 Feb 2021 12:57:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PQXCdilF93gG
        sPFtUzux9a26bQI=; b=oQiiwCCRHjTxmlyNRRrto4SQYLHRcTapZTYFg5Fn6Kxa
        N+RQ5rW6lR8NWp55mD8TyjGiXUiWl6D/T+JavQGGykI33Hq4BfAUZTEdBq0LhiI8
        l7QHghq3QUShpCMS5QNqW2FSju5ntzJ2ai0LZeQ85v7Ic8IrzKKPMN1otXQbe2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wXg+Yn
        P4U7/Q4wOfmFbTMZoO0TATh6LVq6m7CG/I/O4XkGM0/pYRXkxgS5M8DSJtr2y/ia
        ZSgvYIaRA1NsiF8HhmB0qvTnQwSK/3iP11lHceaigk/x9mDv3DsN8S5vN7V3dCIS
        UDD+sYv5XWiYKIcWzu4k60Q2uAt1057Ol7AF8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C44BA2692;
        Thu, 11 Feb 2021 12:57:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCDE9A2691;
        Thu, 11 Feb 2021 12:57:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] rev-list --disk-usage
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
        <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
        <xmqqh7mkycno.fsf@gitster.c.googlers.com>
        <YCOu70m5SKU7L4CS@coredump.intra.peff.net>
        <xmqq1rdn51gz.fsf@gitster.c.googlers.com>
        <YCREYmBsnv2wgvXZ@coredump.intra.peff.net>
        <YCRpBCNJ2yNTbc2i@nand.local>
        <YCUOSmnsJ4LLPFgK@coredump.intra.peff.net>
        <875z2ydd4l.fsf@evledraar.gmail.com>
Date:   Thu, 11 Feb 2021 09:57:12 -0800
In-Reply-To: <875z2ydd4l.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 11 Feb 2021 13:04:26 +0100")
Message-ID: <xmqq1rdmxzbb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9198394C-6C92-11EB-BC67-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I think this is the "narrowly scoped" bit from Junio's response above.
>> It would be a bit weird to have an examples section for rev-list that
>> only mentions this rather obscure feature.
>
> I don't think the lack of an EXAMPLES section or the relative obscurity
> of the switch should preclude us from adding useful documentation.
>
> Yes it would feel a bit out of place, but we can always have a
> sub-section of EXAMPLES, and we've got to start somewhere.
>
> In this case I don't see why it couldn't be added to OPTIONS, we've got
> some very long discussion there already, and as long as there's a clear
> separation in prose from an initial brief discussion of the switch and
> further prose it won't be confusing for readers, they can just page pas=
t
> the details.

OK.

In any case, [v2] as we have it (with test number relocation) should
be good as-is, so I'd start preparing to merge it down to 'next'
soonish.

Thanks.
