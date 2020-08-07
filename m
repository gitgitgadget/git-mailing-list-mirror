Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D486C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 17:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E426D20748
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 17:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ayj2poB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgHGRPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:15:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63547 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGRPY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 13:15:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D8EC5EF0B9;
        Fri,  7 Aug 2020 13:15:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3y+4KTpsckFEOVsCODqQp4cURYo=; b=ayj2po
        B3XZp44TTDC7noESYH9i7uQsINz5jbmHS6Xwx8EKSNOFBI1lO6UF3tMj3mZau6hy
        jzGHbMXmx0kHevpBKpNZUaNcHHHPwhfiPBt0h9EDo+l23zT78l9G/uq98DmAY0SM
        +TE92L77jJ2LIA4mlp7+djJITj0FmVpwbDK9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mcTiLh6GxPh8GpvVzoNBMwrDregM08xx
        zZ2ny3dBeLySTOoZOxsUtYuf5QyvWO/FrCIRpLhvQH8FRfJzV6U9TBx7fUgLaocp
        fuiQ4UwziMf9N+Q7XjgVRzUboOS1zzdPXxAjvMQ63jlv2SjeG0nSwE76zDw2RyEq
        rrCDA5Ltvl8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB366EF0B8;
        Fri,  7 Aug 2020 13:15:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 100C4EF0B6;
        Fri,  7 Aug 2020 13:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, pc44800@gmail.com, chriscool@tuxfamily.org,
        stefanbeller@gmail.com
Subject: Re: [PATCH v2 5/5] submodule: port submodule subcommand 'summary' from shell to C
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
        <20200806164102.6707-6-shouryashukla.oo@gmail.com>
        <xmqq5z9vjsvz.fsf@gitster.c.googlers.com>
        <20200807163135.GA12568@konoha>
Date:   Fri, 07 Aug 2020 10:15:18 -0700
In-Reply-To: <20200807163135.GA12568@konoha> (Shourya Shukla's message of
        "Fri, 7 Aug 2020 22:01:35 +0530")
Message-ID: <xmqq8seqidi1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9233664C-D8D1-11EA-9AEC-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Understood. I will base this patch on the above series. Seems like a
> great series of  great change! BTW, I asked a couple of things in the
> cover-letter which I think you might have missed.

No I didn't miss. I didn't resopnd because I didn't have particular
answers to them.
