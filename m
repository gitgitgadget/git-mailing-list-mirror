Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F70C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7230D64F70
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbhCDU3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:29:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59235 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbhCDU3C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:29:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D614EA7CE6;
        Thu,  4 Mar 2021 15:28:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UNYG9BJ/PcF0adxYCQSPu8QKwqg=; b=pJNTjc
        4nIuRKwY3Xgu8DM4Gro9k0inHhD55tuhXvKilH09v9RHklpUwSgxWF0BOrPnbfYD
        AwTFFjQbSLxgVyrHeaZ+uoC2oIsvgC2dUbu2ndSW/X6DO2Wb9YYMPKV8kgYEHQRA
        Z8DHDmV7ZPGhXbXwjmaq20EpTWHuEmg/mYogM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D9BNmB8dw9aWwmTKV3zeMWe+nmeZWwbN
        aIUQJM+tO27ooW15iBGH1dq7847STC9SGzXLDGosrSwx4s6ixyW4OXK2PeqJt3fT
        ZPE6uoZgOTKMeHEHeTtFAGYxkCfcyH5HdyWerTK0ljJ/i+4wmgxa62DWrKK/8AXi
        2H38TOx2aPg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC312A7CE5;
        Thu,  4 Mar 2021 15:28:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DCBBA7CE4;
        Thu,  4 Mar 2021 15:28:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 03/12] pkt-line: (optionally) libify the packet readers
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <e05467def4e158a5f1cfa3aafffdb5c77097859a.1613598529.git.gitgitgadget@gmail.com>
        <xmqqwnuohv4t.fsf@gitster.c.googlers.com>
        <6b1ce8c0-0881-77a0-deda-677e34560cc0@jeffhostetler.com>
        <YEDxUFJmPH4nP6Qk@coredump.intra.peff.net>
Date:   Thu, 04 Mar 2021 12:28:20 -0800
In-Reply-To: <YEDxUFJmPH4nP6Qk@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 4 Mar 2021 09:40:16 -0500")
Message-ID: <xmqqeeguek9n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 298082B4-7D28-11EB-BAC1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think the flag is doing sensible things; it's just that the word
> "never" in the name is confusing, since it is "never except this one
> time".
>
> Would PACKET_READ_GENTLE_ON_READ_ERROR be a better name, to match
> GENTLE_ON_EOF? I was tempted to just call it "ON_ERROR", since it also
> include parsing errors, but maybe somebody would think that includes ERR
> packets (that is more of a stretch, though, I think).
>
> Likewise, I kind of wonder if callers would really prefer suppressing
> the error() calls, too. Saying "error: the remote end hung up
> unexpectedly" is not that helpful if the "remote end" we are talking
> about is fsmonitor, and not the server side of a fetch.

Both sounds sensible.
