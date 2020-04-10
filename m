Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3BAC2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 05:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E03206E9
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 05:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ozlmWKzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgDJFjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 01:39:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55430 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgDJFjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 01:39:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CD0743C94;
        Fri, 10 Apr 2020 01:39:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6NDAVyVTZQYjM5CKHQExnFyW5q8=; b=ozlmWK
        zu/BJCCXwAvPcYAV3EeTli6G8DmvPBThYtQxu+xy9gTaiVFkuT6G/d2EfCLYcmZo
        X30qKio39jlIZQ6UdE1K53xup6zDCsdSUnTWEAnbpsaFvWa5gqf6OE1612SpEwwO
        0m5tf3HuYrbfrQSxK+0xjnpMlKld09HAKmK7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L8l0mNDw067BjmTiIFZH9lzzG6MG4Gpj
        XS0IMgqO2C5maEEfXEZ1ZsdulHxsmHFlAehW3BrI4kZH0yZ8ZimW9CsAKoc9NEmj
        hEpI7W84oB+tjavoIzeEWsg6o7QerDJuTxELqy3y1ldC26PM+OFKSUT4u9LfoxF7
        jlrHc5AeE2A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 631E243C93;
        Fri, 10 Apr 2020 01:39:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E251343C86;
        Fri, 10 Apr 2020 01:39:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?=C3=89rico?= Rolim <erico.erc@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [BUG] segmentation fault in git-diff
References: <CAFDeuWO+2JEGudtnHZvSsSUOVRR83U9ziLEjSoDyMWxYhvDMKg@mail.gmail.com>
        <xmqqh7xsmg7j.fsf@gitster.c.googlers.com>
        <xmqqd08gmg3s.fsf@gitster.c.googlers.com>
        <xmqq4ktsmfnn.fsf@gitster.c.googlers.com>
        <20200409234152.GA42330@coredump.intra.peff.net>
        <xmqqv9m8kxzy.fsf_-_@gitster.c.googlers.com>
        <20200410030411.GA48173@coredump.intra.peff.net>
Date:   Thu, 09 Apr 2020 22:39:24 -0700
In-Reply-To: <20200410030411.GA48173@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 9 Apr 2020 23:04:11 -0400")
Message-ID: <xmqqa73jlx0z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A30A37E4-7AED-11EA-A55E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I prepared the patch below on top. I mostly wanted it as an auditing
> tool to find similar cases, but there were none. It may still be worth
> applying to protect ourselves in the future.

Makes perfect sense.

Will queue.  Thanks.
