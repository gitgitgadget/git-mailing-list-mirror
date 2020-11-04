Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F6C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 18:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243EE20639
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 18:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G3qgMuxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgKDSAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 13:00:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55967 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgKDSAt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 13:00:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3067FF70D5;
        Wed,  4 Nov 2020 13:00:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w31vsLasKnkmcfJXYv8oLsSrjyI=; b=G3qgMu
        xzJ/ikmnYnZ0mpcAbS+SpcFHFzaDoeuUYZNfAzNaOf7UowZJ5oXKOsJjGPLhL2w2
        qCjmj0bOXyvqeqOJXTyn1SwizyEtMeEhF3jwTBJgm42/8Yppo9Idh21KPHenom4w
        47jhcg9h+bdA/1oDptHmhd2KZrLb6gDGPO3lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ROD4Y2cLdWlKjM+hyTQCdBjoLyTnPgdx
        VP3B/3FVVXdnqqeFbL0TziB0GzpH/5ZXNRmNQc/jUbdSm5cdbXIubx/ItrRs0DVr
        M/ZI55mNls9fZ0SGm3ae1rYjTZWEuDDWH8/8t2EOu5L0LezfRPeT3DiW3PESQXsm
        DXGW2OzZONg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2961FF70D3;
        Wed,  4 Nov 2020 13:00:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 746B9F70D1;
        Wed,  4 Nov 2020 13:00:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Postler <johannes.postler@txture.io>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] format-patch: support --output option
References: <20201104132428.GA2491189@coredump.intra.peff.net>
        <20201104132907.GC3030146@coredump.intra.peff.net>
Date:   Wed, 04 Nov 2020 10:00:43 -0800
In-Reply-To: <20201104132907.GC3030146@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 4 Nov 2020 08:29:07 -0500")
Message-ID: <xmqq361pngs4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A96F948E-1EC7-11EB-9914-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +test_expect_success 'format-patch --output' '
> +	rm -fr outfile &&
> +	git format-patch -3 --stdout HEAD >expect &&
> +	git format-patch -3 --output=outfile HEAD &&
> +	test_cmp expect outfile
> +'
> +
> +test_expect_success 'format-patch --cover-letter --output' '
> +	rm -fr outfile &&
> +	git format-patch --cover-letter -3 --stdout HEAD >expect &&
> +	git format-patch --cover-letter -3 --output=outfile HEAD &&
> +	test_cmp expect outfile
> +'

It is pleasing to see an obvious and clear demonstration that
"--output=X" is equivalent to "--stdout >X".
