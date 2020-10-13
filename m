Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4226C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F6225216
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O0k5JOMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgJMPxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:53:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60223 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731285AbgJMPxr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 11:53:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B7DA716DE;
        Tue, 13 Oct 2020 11:53:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sYdwN05ekkzgfw/cHWFoMtb9P8E=; b=O0k5JO
        MT6J4/BJJ5XnzGVbXHlfN50uHmdxJo0fmXkWtiyKiP3hNboNiLio98TDdjjALWEh
        AbkHoiEN18HBI5zNUs4ZMwyJk6Bdq9VzKUQ1khoP09sigQxXsHE554vJLBUrd8EY
        hCTs7V9FaRT2bh3RUQIjjm9gc9aBzclswulAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wWvJCs5jEhrmHQZkzEZV/19i/ZaJ6sG8
        b4rmwmjZIUF4uMe7Rkk0OP0wvmTKYmvcChvQVaJphIb7lyvdTzHEYs7Hk0sahCnS
        mVWpv6uh+OaGt1Hbtr26q/KgTN4FjDCEPSEpBYI0Mco47d6AJeRDcxaoYdSc4FPa
        g4nZ215KMXY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12F9D716DC;
        Tue, 13 Oct 2020 11:53:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CDD9716DB;
        Tue, 13 Oct 2020 11:53:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching changes
References: <20201001120606.25773-1-michal@isc.org>
        <20201012091751.19594-1-michal@isc.org>
        <20201012091751.19594-3-michal@isc.org>
        <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet>
        <20201013063646.GB3278@larwa.hq.kempniu.pl>
        <nycvar.QRO.7.76.6.2010131401110.50@tvgsbejvaqbjf.bet>
Date:   Tue, 13 Oct 2020 08:53:43 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010131401110.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 13 Oct 2020 14:02:05 +0200 (CEST)")
Message-ID: <xmqqft6iktq0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45F05E0A-0D6C-11EB-924C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Oh wow, from a cursory look it seems as if the diff machinery was not
> exactly careful with releasing memory. I might be mistaken, but if I am
> not, then this would deserve a separate patch series, methinks.

I wouldn't be surprised if newer parts of it is much less careful
than the older parts of the machinery.  Most callers of the diff
machinery, including "log -p" that repeatedly generates patches,
would however run just a single setup for the entire series of diff
invocations before tearing it down AFIAR, so leaking the result of
parsing the command line option may not be such a big deal to these
callers.  But some callers added recently may not follow the access
pattern, in which case the machinery may have to be made more
leakproof.

Thanks.
