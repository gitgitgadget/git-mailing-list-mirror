Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32391C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 23:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiGKXas (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 19:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiGKXar (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 19:30:47 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401E211
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 16:30:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0650D12CC2A;
        Mon, 11 Jul 2022 19:30:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rERNjq6pchrrUIVYuR9T22XNIabAsWPyF1tj0g
        /bJL0=; b=t+bTLiafKwTtF20eQq+eyRRg8Vh80nclgblBguWP6YBmVYoyiHx4Pp
        DPNVIebO72K4WnO1SFaQqFFql7sx0UPpWT4T2kxmJO+FXrSE4qUEDfKu9E52RUcm
        0iQbvmKCReUMq2YyDSJuyxmd87LQ6c/0DxZNa7FjKrfT5ezmpr4Jg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F129B12CC29;
        Mon, 11 Jul 2022 19:30:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 614BC12CC28;
        Mon, 11 Jul 2022 19:30:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH 3/4] .clang-format: do not enforce a ColumnLimit
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
        <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
        <RFC-patch-3.4-06d4b76a364-20220711T110019Z-avarab@gmail.com>
        <YsymlrUviwwoKHZX@tapette.crustytoothpaste.net>
        <xmqqh73nl12r.fsf@gitster.g>
        <CAPig+cSkGsS4VouBoaTB_zBEL48-=JBf4PKLJMpj8r342n=YUw@mail.gmail.com>
Date:   Mon, 11 Jul 2022 16:30:42 -0700
In-Reply-To: <CAPig+cSkGsS4VouBoaTB_zBEL48-=JBf4PKLJMpj8r342n=YUw@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 11 Jul 2022 19:05:00 -0400")
Message-ID: <xmqqtu7njkgt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B8DCBE2-0171-11ED-9118-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> So, even if you manually wrap the code to fit nicely in 80
> columns, if clang-format is set to 132 columns, then it will
> automatically reflow your nicely hand-wrapped 80-column code out
> to 132 columns, which I think is not what we'd want (at least
> those of us who always work in 80-column terminals and
> editors). But perhaps there is a configuration knob which disables
> clang-format's "reflow-to-occupy-full-width" behavior? brian?

Agreed.

We should keep in mind that there is no single good fill-column.

When we say "wrap your lines at around 80 columns", we mean that
when there is a good place to fold at around column 65 and the next
good place is at column 82, then it is OK to go slightly over 80 and
wrap at 82, which may be better than wrapping at 65.  If the last
good place to wrap is at column 72 and the long function call at the
end of the line makes you go past the 82nd column, wrapping at
column 72 might be better.

I wonder if there is an automated formatter that understands this
kind of shades of gray and lets us express that.

Thanks.
