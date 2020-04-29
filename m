Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3642AC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 15:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BEA214D8
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 15:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LdySKBST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgD2PgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:36:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59670 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgD2PgL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 11:36:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA456D625A;
        Wed, 29 Apr 2020 11:36:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E/z4L9enlTFR8e8QVE2TInpBxCY=; b=LdySKB
        STvdXtpF5FdYsJmDce38oqk2tUnXq5Ot0yldmvNvy0hoqE/WALDl/on/SP3lfLx+
        5BFhhxWuYm5b6D7lVWFgnIxRZRHFvsVd6B5qhoMUCglEQO8Jmxlf6YtuoF52K3pZ
        ZvQS0mDHrtxfguGh2QvbP9okN5ZNGkDKBWklI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mTBF2CaZXmF3dCzmzjzLqHOBrSiUxHVp
        pNaL22qOkFDGzT85OpRVY0nG8wwtYMP+JuMGotcfeMaMNYdHUXEEFFX0b1DEsnCQ
        rCKDuiji4fEBKgzV0szW/WuoRmX55cJ9jgmiqtwITisbLdaGIpiwHzhJ0QrxKx4d
        6qY9OwezHsw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2F80D6259;
        Wed, 29 Apr 2020 11:36:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 14644D6257;
        Wed, 29 Apr 2020 11:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH v3 3/3] credential: handle `credential.<partial-URL>.<key>` again
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
        <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
        <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com>
        <xmqq4kt8bk5r.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004250027550.18039@tvgsbejvaqbjf.bet>
        <xmqqr1w7yzjc.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004291657220.18039@tvgsbejvaqbjf.bet>
Date:   Wed, 29 Apr 2020 08:36:05 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2004291657220.18039@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 29 Apr 2020 16:58:05 +0200
        (CEST)")
Message-ID: <xmqq8siez4m2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24A38DB4-8A2F-11EA-BB0E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> while the other branch lacks the extra blank line just before the
>> single quote is closed.  I queued 850ef627 (SQUASH??? ...
>
> Thank you for pointing that out. I already did that: ...
> Do you want me to send another iteration, for completeness' sake?

Then if I squash 850ef627 on my end, we'd be in sync, so unless
there is any other change, no need to resend it.  Have we got enough
eyeballs that looked at the patches already?

Thanks.

