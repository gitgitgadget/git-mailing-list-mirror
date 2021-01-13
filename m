Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097EBC433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 08:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA3523382
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 08:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbhAMIzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 03:55:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58775 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbhAMIzi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 03:55:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5F03104F39;
        Wed, 13 Jan 2021 03:54:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0IpH8lfkNWOLQnue1y6Xc3chZ/M=; b=P53XEX
        2TVHYCzR35OiGZn5xU4n72ovalzwczqk/rbJ9naJQwliuNfk14gMn2MIPrQKC3re
        JNldo4vn6w9b7S3Rpv5sBeDBeL0ebNLt39C/FyZm4GYPhhe9iYU8sL6acKQDevOw
        tjwfDy9akF/3O+twsPa8f/Rt5ZALitWE1nacg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NEduT3uRgY2hFALOhieU2G5qLce/UhSR
        pgSlinRMyoYFodzsYWRPyzkNNhStqxpQAUG/66lRvva4xiY42LtZslALIUwfKqyL
        WS7JAEJ6PLawQi4WNVW+Z2QP98u3mA29VvcD3ahwHc6IpHKUE1y7pzCbKMh2UQ6v
        xwfu4vovWlY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A17CC104F38;
        Wed, 13 Jan 2021 03:54:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E01F0104F37;
        Wed, 13 Jan 2021 03:54:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH 01/20] pack-revindex: introduce a new API
References: <cover.1610129796.git.me@ttaylorr.com>
        <fa6b8309088fd04410ca7276c5cf14db0fb82fb2.1610129796.git.me@ttaylorr.com>
        <xmqqa6tdz2fo.fsf@gitster.c.googlers.com>
Date:   Wed, 13 Jan 2021 00:54:52 -0800
In-Reply-To: <xmqqa6tdz2fo.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 13 Jan 2021 00:06:03 -0800")
Message-ID: <xmqqv9c1xllv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00E65D06-557D-11EB-A9E6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Without knowing what exactly "pack position", "offset" and "index
> position" refer to, the above three are almost impossible to grok.
> Can we have one paragraph description for each?  Something along the
> lines of...
>
>  - Pack position: a packstream consists of series of byte ranges,
>    each of which represents an object, so the objects can be
>    numbered from 0 (the object whose data is stored at the earliest
>    part in the packfile) to N (the object whose data is stored at
>    the tail end of the packfile).  The number corresponding to an
>    object in this order in the packfile is called the "pack
>    position" of the object.
>
>  - Offset: The ofs_t distance between the beginning of a pack stream
>    and the beginning of data that represents an object is called the
>    "offset" of the object in the packfile.
>
>  - Index position: for a single pack stream, there is a table that
>    maps object name to its offset and the entries in this table are
>    sorted by the object name (this is what pack ".idx" file is).
>    The location (counting from 0) of an object in this table is
>    called the "index position" of the object in the packfile.
>
> I am not sure if the above correctly reflects what you meant by
> "position", though.

Please scratch the above.  I see Peff already pointed out pretty
much the same, and his phrasing looked a lot cleaner than my
attempt.

Thanks.
