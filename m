Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DA9C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2DF6056C
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346028AbhIGUHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:07:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63174 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbhIGUHu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 16:07:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9787DF72C;
        Tue,  7 Sep 2021 16:06:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YPhYbi5Q4580qz0hSQr5ZXwAo7PqqA6vs9CCfV
        GTXlU=; b=m60990VaLYbAqtsM/nrqCPt4NOg/RM8dVdBGFZq3LUNrUOO1o3/xjl
        EITjTurTR8FX2ZVka5iC8JpwsaRi3I3Pt79X25G32mwcvPA4Rs0gq/uNfwuWYtkn
        SiDweqLuoYc6nVRxGDuJXm+tx1I75tCrR9mLcPCVgEAJupx1HGJVk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C19D4DF72A;
        Tue,  7 Sep 2021 16:06:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38F63DF729;
        Tue,  7 Sep 2021 16:06:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: implement "quick" formats
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
        <YTNps0YBOaRNvPzk@coredump.intra.peff.net>
        <CAOLTT8QYe3PBPxSH8CYY+FatSfT7C5m6nccR2xMZ1yxSDFh5OQ@mail.gmail.com>
        <YTTBCWlsC1cBZMio@coredump.intra.peff.net>
Date:   Tue, 07 Sep 2021 13:06:41 -0700
In-Reply-To: <YTTBCWlsC1cBZMio@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 5 Sep 2021 09:07:21 -0400")
Message-ID: <xmqq35qgb166.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E6F24E8-1017-11EC-8827-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It was mostly meant as a proof-of-concept to see where the time was
> going, and what was possible. It _could_ be used as a stop-gap while
> improving the general performance, but it's gross enough that it's
> probably not a good idea (it's increased maintenance, but also it
> dis-incentivizes fixing the real problems).

Thanks.  I have to agree with the assessment.
