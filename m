Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F014C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2395B619E8
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhCXBRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:17:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51529 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhCXBRb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:17:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 555DAB8CE7;
        Tue, 23 Mar 2021 21:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UNitwwsEKfuH
        GqUdDSffZHEQVJg=; b=cY2fDLmkLa5uShxyL9p/MbHlTs9Bd+QS6Wbc/jvPPYff
        DGF5UdnGODM7TVUxC/FiDbwReD3+jm6QOqp7E3uUNmUFMKZYRsYcMCb+pLhTs+Lg
        a0dwEPMC7nwNDn1vnkDlRfTcMwv+DpvZEmV1VTDJla/zHxYk/fqZjfzFfWy3RzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XyIpAs
        raUCb06Omt1QPNMmh5j8rVJ09WSyr6AcrApw/HnJPS8phRj8kHp7hQic9gUPD+Bh
        64GAJccMtYhzrHli/+71t1sNEBvP/A0XL8wOkPNmmEvBfLWKpTIukArYXHMY2/NS
        uQj4SvEw32a5yazyW4e8q3WonBaGVG9NEHcpE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B5F7B8CE6;
        Tue, 23 Mar 2021 21:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70BC6B8CE5;
        Tue, 23 Mar 2021 21:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Emily Shaffer" <emilyshaffer@google.com>, git@vger.kernel.org,
        Robert Foss <robert.foss@linaro.org>,
        "Drew DeVault" <sir@cmpwn.com>, Rafael Aquini <aquini@redhat.com>,
        Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH v3] git-send-email: Respect core.hooksPath setting
References: <20210323162718.1143982-1-robert.foss@linaro.org>
        <patch-1.1-cc0ba73974a-20210323T173032Z-avarab@gmail.com>
        <xmqqeeg51ojs.fsf@gitster.g> <87zgytpehg.fsf@evledraar.gmail.com>
Date:   Tue, 23 Mar 2021 18:17:28 -0700
In-Reply-To: <87zgytpehg.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 24 Mar 2021 01:44:27 +0100")
Message-ID: <xmqq7dlx1hav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B3A66A24-8C3E-11EB-89FF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> While I'd like to see it land I'm skeptical of parts of that approach[1=
]
> and expect we'll have more re-rolls of it, and in any case the conflict
> in send-email[2] will be trivial to resolve.
> So I think it makes sense
> to queue up this narrow fix and not have this wait on the larger topic.

Well, that is what I am doing for now, queue up this narrow change,
while resolving the conflict to use Emily's topic.  Which means that
the new code this topic adds is never exercised while the other topic
is still cooking in tree.

> 1. https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/20210311021037.3001235-36-emilyshaffer@g=
oogle.com/
