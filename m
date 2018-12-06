Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7050C211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 06:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeLFGl7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 01:41:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61589 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeLFGl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 01:41:58 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6C3A3BBAE;
        Thu,  6 Dec 2018 01:41:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aTDa9yJ0QMPryWTE3Oe2glolJmo=; b=fe/oZx
        CM63JH9rxVn6eT4+2CBiXKiXOUYYL14OQTmOfFvasfN/6RkFG1R1DOznfnhgq+L1
        ywjze+UlKGE5hFdzxyQATcR8oSkHG3DZ6pA6ehQN+u0FuVzRm+875tw9UEal+wik
        56pI1HhCWFBMa1HwDtrdVSFZzFYamhfHSvPcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZqwEOpffOFUhi+9cQIuOj0zjzt+98lK5
        aCgjew0DZdjbetGPtjeHyt3K0ybXMZIzLBpVeZ2Kb0Z1iafJRudbZYEeEfPtn6Q0
        EaacSk754TW71lPkfTCBVgF0Gis1cLOgcMbXzbDUAL432wc2hvowBhFnn1K2yWYi
        nmB9RGretS8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9FA583BBAD;
        Thu,  6 Dec 2018 01:41:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AAE763BBAA;
        Thu,  6 Dec 2018 01:41:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a test repeatedly under load
References: <20181204163457.15717-1-szeder.dev@gmail.com>
        <20181204163457.15717-4-szeder.dev@gmail.com>
        <20181205054408.GE12284@sigill.intra.peff.net>
        <20181205103454.GJ30222@szeder.dev>
        <20181205213625.GD19936@sigill.intra.peff.net>
        <xmqqefavbj28.fsf@gitster-ct.c.googlers.com>
        <20181206053525.GA29481@sigill.intra.peff.net>
Date:   Thu, 06 Dec 2018 15:41:51 +0900
In-Reply-To: <20181206053525.GA29481@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 6 Dec 2018 00:35:25 -0500")
Message-ID: <xmqqva4788cw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04A85ED0-F922-11E8-AE31-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Each "wait" will try to collect all processes, but may be interrupted by
> a signal. So the correct number is actually "1 plus the number of times
> the user hits ^C".

Yeah and that is not bounded.  It is OK not to catch multiple ^C
that races with what we do, so having ane extra wait in the clean-up
procedure after receiving a signal like you suggested would be both
good enough and the cleanest solution, I think.

Thanks.
