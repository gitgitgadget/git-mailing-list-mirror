Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB6FC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5A020692
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vJ3C6A6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDJWEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:04:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56851 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJWEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 18:04:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F2F79C597D;
        Fri, 10 Apr 2020 18:04:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NKC7/UYKfZ7v7JglZ+L+MEBGuAM=; b=vJ3C6A
        6LZZG1I6+K1mTZPYHNBLFYSiQ2O8TPCURduj/HZHQaUPKCbKqIz7HHkSGpbbD86O
        SsqkrclzNj4IVnF0pg2Pup7ytHMUEpq2CFZNElQcvlXh+sT/DoIPgDGlOTqBrlfB
        qDTfsEIu3wpy00doTjIz3FdhGrXhFsJvd59zE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PkErapc0BK3TX48xBvCMfaL4DoKBwUL4
        I5inp5crLJT5GchXOXcnx3bs/l+gXcMTmKH9DvNHKBm15LvXE9MXYwgQ0CkBq56g
        YOE9M2gVGJplizIHzXR0IIkY6nLWgO+syhO+haZedi/83JJ5uCQiqY5ADFUUiX3W
        RSfnLhwJits=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB1ADC597C;
        Fri, 10 Apr 2020 18:04:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 43285C597B;
        Fri, 10 Apr 2020 18:04:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] config: reject parsing of files over INT_MAX
References: <20200410194211.GA1363484@coredump.intra.peff.net>
        <20200410195007.GF1363756@coredump.intra.peff.net>
Date:   Fri, 10 Apr 2020 15:04:31 -0700
In-Reply-To: <20200410195007.GF1363756@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 10 Apr 2020 15:50:07 -0400")
Message-ID: <xmqqzhbjgfps.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 425C56C2-7B77-11EA-9ED7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So given the fact that these are insane cases which we have no need to
> support, the weird behavior from feeding the results to printf even if
> the code is careful, and the possibility of uncareful code introducing
> its own integer truncation issues, let's just declare INT_MAX as a limit
> for parsing config files.

Makes sense.

> +	if (c != EOF && ++cf->total_len > INT_MAX) {

Would this work correctly if size_t is uint?  Sure, as int-max would
fit within it.  And of course if size_t is wider than uint, there is
no problem in this comparison.

Thanks.
