Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E904C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051C620665
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XZ3VohQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKJVAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:00:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59085 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJVAt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:00:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 798F99AEDB;
        Tue, 10 Nov 2020 16:00:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HROh4ySa7MZc9gPJmZHs3WAUCcI=; b=XZ3Voh
        QfWzRM12krk6DSJZb4lYg28xCvDBw0yvwsRyH+VIiWVqjwSXMVMYrqJgvb9UhIxQ
        05kiKr7CoC23GD4y89ciwFdPjbZJWv8jzgl125EDCbisgwh5yK6WhBSPAZvvY+Y8
        6UShRxhtk8R6HF52VPStqmxhzWJ5HI7G6KN+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lNFwLp24XHqR0nmUpq8JMIunsdEVIBik
        4Mgp8pNVlBjm+anpI2X/+puWMIVUt82KmWNgBYtzd/18H+0/plksEoLKqDeHRtN9
        Ipnr+z1tPzwza0jnKupEZWZNaTYL7pS1d/8hoe7h6MFvQQdA6C6VK7OsXPb7YVUX
        L4uk4Re9/Is=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F12A9AEDA;
        Tue, 10 Nov 2020 16:00:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D58A59AED9;
        Tue, 10 Nov 2020 16:00:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] t5411: consistent result for proc-receive broken test
References: <CANYiYbHQKshFg=1xAv8MFfSjmFfQ0uJRm3mQBnZMsTd1n7R-Ow@mail.gmail.com>
        <20201109105846.64303-1-zhiyou.jx@alibaba-inc.com>
        <xmqqh7pyb61f.fsf@gitster.c.googlers.com>
        <20201109231246.GA677345@coredump.intra.peff.net>
        <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
Date:   Tue, 10 Nov 2020 13:00:46 -0800
In-Reply-To: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
        (Jiang Xin's message of "Tue, 10 Nov 2020 19:49:53 +0800")
Message-ID: <xmqqzh3p53lt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE0D3092-2397-11EB-BEFF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Thanks Peff for pointing the root cause. Will use the "gently" forms
> of packet_write_fmt() and packet_flush() in patch v3.

Another thing I noticed.  Its tests are based on a codebase where
master is called main, which means it is not designed to be usable
with the 'master' or 'maint' track.  

Because the topic is no longer "just apply a band-aid to paper over
test flakeyness" but is fixing the codepath that matters in real
user experience, I'd prefer to see it applicable even to the
maintenance track.

Thanks.
