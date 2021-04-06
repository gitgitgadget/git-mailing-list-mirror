Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FFC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 00:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A7C6128B
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 00:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbhDFAK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 20:10:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55016 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242936AbhDFAK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 20:10:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A28F2115BDA;
        Mon,  5 Apr 2021 20:10:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oQ+N1Amm5yDYCBTUgZixI1/8WeY=; b=LAW5Fg
        EsZ46/T4v6bjjZWYBMleVPIBudn6kMDz0Wx9i4+CpOqUmz1YOCEwiRpRJPSMl6uO
        OpuCmSHg+4yC7Sx1KeL5uEnziviABH3ODvjHeK6cpLQ0XUKWm9/so56auWVICHGK
        Gg2wDHqL2e4XmbwF6C1IC7dAK7ZM/J5Vs8r5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fSvl5lwdh9svKH3gOmUBSItkt2blhQz4
        ffl/6j2CEzR5OgRCG/es1FNCB2brtO3VWmC5q7MXcm3BCS60BZ6W5qM3HCiqhTae
        fIqNxXrx0UD7Rn6u/VAISriX2IbdQGi167kcBfrUIlpPgFVMwJsxM4Tmnszl9OSn
        7n1PkzIqU5Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A7D5115BD9;
        Mon,  5 Apr 2021 20:10:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D90A2115BD8;
        Mon,  5 Apr 2021 20:10:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Jerry Zhang <jerryxzha@googlemail.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Subject: Re: [PATCH 1/1] git-apply: Allow simultaneous --cached and --3way
 options
References: <20210403013410.32064-1-jerry@skydio.com>
        <20210403013410.32064-2-jerry@skydio.com>
        <CABPp-BGhvQF9k1Jw9NPbZWMkNSffqR777-4S-y-Sh=Etvw-SAA@mail.gmail.com>
        <xmqqy2e00zaf.fsf@gitster.g> <xmqq1rbq276g.fsf@gitster.g>
        <CAMKO5CtCk_sJsFFiKKFR1wCSyY226CbxPtN6=p6JRzocSuv8jQ@mail.gmail.com>
        <xmqqy2dw4bh3.fsf@gitster.g>
        <CAMKO5CuYE1VA2h2zDo-b77WQDgj1LriwifruziPA30Yb7uS=6A@mail.gmail.com>
Date:   Mon, 05 Apr 2021 17:10:17 -0700
In-Reply-To: <CAMKO5CuYE1VA2h2zDo-b77WQDgj1LriwifruziPA30Yb7uS=6A@mail.gmail.com>
        (Jerry Zhang's message of "Mon, 5 Apr 2021 16:29:15 -0700")
Message-ID: <xmqqblas46ja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 789C03CA-966C-11EB-8EE1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Unrelatedly would you have context on why --3way falls back on 3way
> rather than trying 3way first then falling back on apply_fragments if
> blobs don't exist?

Historical accident, following the order in which these features
were invented, plus applying a single patch straight has been faster
than doing a 3-way.

I tend to agree with what you are hinting at, though, as I do not
offhand think of a situation in which a successful 3way merge would
be less correct than a straight patch application, and if the user
explicitly has told us to do "--3way", that is a sign that it is
acceptable to try 3way first even if it costs more cycles.

Those who has been giving "--3way" from inertia would notice if the
performance difference is large enough and may complain, though.
