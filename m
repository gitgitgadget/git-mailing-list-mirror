Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1A1C48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAFC613CD
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhFQAb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 20:31:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51469 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbhFQAb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 20:31:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4917B74E8;
        Wed, 16 Jun 2021 20:29:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mjo4wY2bUBdYrBrqOsOO+mru93hhUnP84Gafn0
        ywEkk=; b=ootbNQFZcdMNCpbatIEKTsGvpUFaatlwj7UooQ7bMXHofjbX46KTjV
        wYCcNZIvOUVwfzQ6QBuH5q8sCy+JXWU9YDAO5n18/XWtqRl6kEHj95BlOrJTGWCr
        YC7GNx2IJEgIS2areKBy2NrqjM1QB2NDhkf6WBczUF9Gzdr3pEKj4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9F4DB74E7;
        Wed, 16 Jun 2021 20:29:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A1B6B74E6;
        Wed, 16 Jun 2021 20:29:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] test-lib: fix "$remove_trash" regression and
 match_pattern_list() bugs
References: <xmqqa6nqsd2i.fsf@gitster.g>
        <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
        <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net>
        <xmqqeed2p3jx.fsf@gitster.g>
        <YMnRC8v4RLDk2+K9@coredump.intra.peff.net>
        <87k0muxcd7.fsf@evledraar.gmail.com>
        <YMnllMXvRJKSdGID@coredump.intra.peff.net>
Date:   Thu, 17 Jun 2021 09:29:18 +0900
In-Reply-To: <YMnllMXvRJKSdGID@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 16 Jun 2021 07:50:44 -0400")
Message-ID: <xmqqlf79nxk1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E177C12-CF03-11EB-933B-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> My thought was that the subshell takes us back to the original state,
> regardless of what it was. As opposed to "set +f" which takes us back to
> a particular state. But it is unlikely that we'd have done a global "set
> -f" before calling this, so maybe that is being overly conservative.

Overly conservative, yes, but if it is not too much overhead, I
think it is a good practice anyway.

