Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407FBC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 19:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259DC610FF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 19:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhIOTam (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 15:30:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60061 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhIOTam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 15:30:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45715E6EBB;
        Wed, 15 Sep 2021 15:29:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z+MBqzStGpacGpmRSBMsdIXzTCETYIDqjmciyR
        sVRVs=; b=m1/TGBDdAoVHPs+EqveXR87a6MfZAS6Oj7YCMBBiYedm7eHt54yadS
        0rXlUwJBDH1HcC++JlbqZ/Sd/o61rr6A1i4R/16PyS4XLdoR51jeH8JfsTndvSKl
        v9MPS2KoQvR3V4fPt26hEqXT2HQJQU9Z+aQFOKqxYT+xd+ORUXU0o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C3B4E6EBA;
        Wed, 15 Sep 2021 15:29:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3C67E6EB9;
        Wed, 15 Sep 2021 15:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v2 0/8] repack: introduce `--write-midx`
References: <cover.1631331139.git.me@ttaylorr.com>
        <cover.1631730270.git.me@ttaylorr.com> <xmqqmtodwsnz.fsf@gitster.g>
Date:   Wed, 15 Sep 2021 12:29:20 -0700
In-Reply-To: <xmqqmtodwsnz.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        15 Sep 2021 12:22:08 -0700")
Message-ID: <xmqqilz1wsbz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A421FC8-165B-11EC-BDED-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But if it is the case, I'd step back a bit and further question if
> "else if" is a good construct to use here.  We'd return if .m passes
> midx_contains_pack() check, and another check based on .to_include
> gives us an orthogonal chance to return early, so two "if" statement
> that are independent sitting next to each other may have avoided
> such a bug from the beginning, perhaps?

OK, I went back and checked your response to a review in an earlier
round.  If .m and .to_include cannot be turned on at the same time,
then I think "else if" would express the intention more clearly.

But if we go that route, the whole "if ... else if" may deserve a
comment that explains why .m and .to_include are fundamentally and
inherently mutually exclusive.  In other words, is it possible if
future enhancement may want to pass both .m and .to_include to allow
the code path to check both conditions and return early?

Thanks.
