Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8453C54FCF
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 17:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C82420772
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 17:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BV/9l0Pb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCYRZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:25:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56235 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbgCYRZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 13:25:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F19F167939;
        Wed, 25 Mar 2020 13:25:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i5b88zW32Kfl+j5CBmNwQW/FXAk=; b=BV/9l0
        PbytkgDoMAYEdSqQF01PlixQb9efO+edpx8rbnuEHDwwmISd+ggTWcR2Ai40G2/q
        W19cBa19kGPBDOiqp39NDQF8XvoXTvLDelrx0JXP9VplidQUGm08JscsY3Lkn5nO
        NNAnGqlPy45Pc3pw70X+D4Kr8825hWfCu9mUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jrN38zv3ddRwIVrVo2guZMhbKx4Ma0+r
        5UMldwJkRacHWj4SB9fBAqHSbAAnphECsnTaGio5DxbbrbtBeoUS+2iGcabUSrh0
        kGAxSr44PWg4wGCidkpQgOHbWo0OdQymYp5Pujb9lnCLlPXnhL2cHW847jZibrpt
        l31rD8L4LAY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E900D67938;
        Wed, 25 Mar 2020 13:25:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7594567937;
        Wed, 25 Mar 2020 13:25:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 10:25:54 -0700
In-Reply-To: <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 25 Mar 2020
        05:41:19 +0000")
Message-ID: <xmqqsghwwdlp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF2B8280-6EBD-11EA-BAC1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -if test_have_prereq GPG &&
> -    echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
> -then
> -	test_set_prereq RFC1991
> -fi
> +test_lazy_prereq RFC1991 '
> +	test_have_prereq GPG &&
> +	echo | gpg --homedir "${GNUPGHOME}" -b --rfc1991 >/dev/null 2>&1
> +'

OK.  To make it fully lazy, we do need to test GPG while lazily
checking for RFC1991.  Makes sense.

Thanks.
