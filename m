Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F12AC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00802080C
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uQRKETuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgIPWuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:50:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65097 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgIPWu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 18:50:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9BD288CFA;
        Wed, 16 Sep 2020 18:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jvy0ybxn/XERb5ga754rSENHtPA=; b=uQRKET
        uJJp6gfX6UnHx9s0mzZlDxuZBw6ZE3GliPYfyJGin9dmYz8oB/mG+UoqIk77HASs
        6UHUYtG6+Dj30bFnvDxxdF3MidvXxGBtOTfDY2+FQS78SPR9yJnuYDsdNARLFQoz
        16XbgJ6Q6gM3IIjw9ZI7nGHxBK2Ac+L1BL+/I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UVe+132R4HrQZyVjja7xGNhd4EHE2WMJ
        JqlClEHnAD4kTdUXaYJ7qgMkbH2VMh9TH4TkZUduDBzQ8eKwOI6qJYID9GRwJMlf
        801tR9eydLz8SsRQBlJIenTRUb8AS2nUyjhuX7FVpUsBhH0fLfIfJsAm8OZPXpG2
        AzNsfka4uuA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E122488CF9;
        Wed, 16 Sep 2020 18:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D60488CF8;
        Wed, 16 Sep 2020 18:50:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
References: <20200915135428.GA28038@pflmari>
        <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
        <20200916201830.GA44969@coredump.intra.peff.net>
Date:   Wed, 16 Sep 2020 15:50:23 -0700
In-Reply-To: <20200916201830.GA44969@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 16 Sep 2020 16:18:30 -0400")
Message-ID: <xmqqbli5uyj4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01DE8F00-F86F-11EA-9632-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Adding a command-line option for "all" is a good idea, but will probably
> mean needing to add the "unset" sentinel value I mentioned in the other
> email.

Sorry, I do not quite follow.  I thought that assigning the
(misnamed --- see other mail) ALL to the "family" variable would be
sufficient?

    enum transport_family {
            TRANSPORT_FAMILY_ALL = 0,
            TRANSPORT_FAMILY_IPV4,
            TRANSPORT_FAMILY_IPV6
    };
