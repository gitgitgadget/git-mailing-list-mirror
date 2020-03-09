Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59676C10F27
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 14:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDAB21655
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 14:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H6yfvTKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgCIO7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:59:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53842 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgCIO7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 10:59:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB8ADB21FF;
        Mon,  9 Mar 2020 10:59:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bFPg1guMbWVvLoaYrZm2e86T3y4=; b=H6yfvT
        KYH5oaaHeq3d+m9e1fnE1BkoAtOMzIcB7qUKYDAgS7pkRsCWr8C/6NOe5K6B9il+
        i2xmlKbc44HaOCPFe9eTYX6I/qOVb9V8RfsQxCrZVhbSWr5/rCrXX0b3YszcMHef
        /0OsD5F6xU4N1+vnNvYiaqESCZ7nn0Zj6CaFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SOJNpTfqgvPybLhfNT98YaEsVcBNqOYt
        XWDrtuViyYshRX+lRw2VwvycCZsT7lZ1U1jAIJpSA7GSsFckPMqNPgOHyf6897qG
        LqlQwUp+iNGZw3LByM1/bLIrdpmq1PAvHXXIE9/eWy3megU+Coxc9B1epe2YMMLF
        GhPnKOFLsrk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3EF8B21FE;
        Mon,  9 Mar 2020 10:59:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC7B9B21FB;
        Mon,  9 Mar 2020 10:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
References: <20200302230400.107428-1-emilyshaffer@google.com>
        <20200302230400.107428-3-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
        <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com>
        <xmqqr1y52w5y.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2003082319260.46@tvgsbejvaqbjf.bet>
Date:   Mon, 09 Mar 2020 07:59:08 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003082319260.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 8 Mar 2020 23:24:39 +0100 (CET)")
Message-ID: <xmqqr1y11sn7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 888180D4-6216-11EA-B1A8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 6 Mar 2020, Junio C Hamano wrote:
>
>> What makes it possible by making "git bugreport" stand-alone is for
>> it to link with libraries that the remainder of Git, including the
>> transports that link with libcurl, has no business linking with (a
>> library to obtain system details for diagnostic purposes, for
>> example).
>
> That would, however, make `git-bugreport` more fragile than `git`, i.e.
> the former might fail to launch under more circumstances than the latter.

That's a bug.  You can go fix it when it happens.
