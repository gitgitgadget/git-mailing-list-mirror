Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F4C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 21:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5F720748
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 21:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BlyydVCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGJVJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:09:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60844 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgGJVJK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 17:09:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A92D1D3E38;
        Fri, 10 Jul 2020 17:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MksgKlDf6krG+w/7/I6ynP/Tft8=; b=BlyydV
        CFwI464krWvrxdD/jojGLqyvOaiwkG7MwvfzAVYc4YdL+/4oMv8aw4yIk4FHtQ0x
        pXWDatroRCgSXLkGPKgTTzlsEL4jJX6cGDK3MTEbnpWEQVZ27jwl3HJDQMk5xSyN
        Qq6yh4hzfv3kUAmV6j/8aVYPztVayDT1o4ePc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mAIqOFiJnPrsHiI3r9ygCdLwAKhXW9Mz
        YJH4tHBvdCkHIQQNB0h8Q2DzVKsgp050/FGLuCPrGbTOwDHR7QKjsXAQkMfIqi4Z
        fSnhjOmuCHCk9LDF+8mdS5CBwjE5/BzIIkdr4SSaMMO2fa9Kl+JIHIN04ZXSEH5W
        DtoCUzP0Bdk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1561D3E37;
        Fri, 10 Jul 2020 17:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E9DB2D3E30;
        Fri, 10 Jul 2020 17:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
References: <20200710014242.1088216-1-emilyshaffer@google.com>
        <20200710014242.1088216-2-emilyshaffer@google.com>
        <20200710021451.GI9782@camp.crustytoothpaste.net>
Date:   Fri, 10 Jul 2020 14:09:04 -0700
In-Reply-To: <20200710021451.GI9782@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 10 Jul 2020 02:14:51 +0000")
Message-ID: <xmqqpn93rsb3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96B74CCE-C2F1-11EA-B88F-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> So to make sure I understand this right, we'll collect traces regardless
> if it's enabled, but we'll still honor the --quiet flag if the user
> doesn't want to see them?  If so, I'm definitely in favor of this
> change.

Hmph, if we know we won't be emitting, why spend cycles to collect
traces in the first place?  Does it make the code simpler to follow
or something?  As long as it is done when the user requests a trace
to be taken, I do not care about the wasted cycles too much, I think ;-)

> I was worried when I read the cover letter that we'd display
> them to the user regardless, but from reading the patch and the commit
> message, it seems I misunderstood.
>
> I think the making the verbose flag a parameter simplifies the code
> nicely and puts the rendering decision in the right place.

OK.
