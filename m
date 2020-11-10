Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DF7C2D0A3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E76E20789
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z9s+tstg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgKJBrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 20:47:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64970 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbgKJBrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 20:47:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 907221004CB;
        Mon,  9 Nov 2020 20:47:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G9aPqRWVfGEB663mIeuEwqEl1SQ=; b=Z9s+ts
        tgjIgOdzYIwoc8u8l+5gD9sYY0D7/DWe5et2IzLOe6YSPJSgMtXR7funMrZt8nnl
        SS8AYLjDehTMsSLK3Bg1Uy0r0N/MVFt0ALj32dHn0qmHYNR6RhRleeA2X2xc+aQt
        aPS/7niYEP+D8KEofH4XZxsa8I9g7k+oCSeRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XDB9ta/5bxGDHrfdGfNZqQIpPopDb9jz
        mILQxdCWdb62M2vsrfOaYpnuhjkA3r2KPLlgnFY3nSis5Jh207uSIXdSbc+Kz8VK
        MmsE0ihO3pqbIBnsBw1k+11QmFSTF+ux7sVrmkwHmp8nkf62TQlEeN181Os1HGFv
        NVURnEi/KQg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 88CEE1004CA;
        Mon,  9 Nov 2020 20:47:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D32451004C9;
        Mon,  9 Nov 2020 20:47:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] completion: bash: support for recursive/nested
 aliases
References: <20201110005331.532678-1-felipe.contreras@gmail.com>
Date:   Mon, 09 Nov 2020 17:47:10 -0800
In-Reply-To: <20201110005331.532678-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Mon, 9 Nov 2020 18:53:28 -0600")
Message-ID: <xmqqv9ee7zkx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6B06BC8-22F6-11EB-BAF6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Hello,
>
> As Philippe reported, aliases of aliases are not completed correctly in the
> Bash completion. This patch series attempts to fix that problem.
>
> Since v1:
>
>  * Use a loop instead of recursive calls
>  * Add a check to detect alias loops
>
>
> Felipe Contreras (3):
>   completion: bash: support recursive aliases
>   completion: bash: check for alias loop
>   completion: bash: simplify __git_aliased_command

It is unclear why 3/3 needs to be separate (in other words, is there
a reason why 1/3 and 2/3 need to be done while the function is in
the more complex form, instead of doing what 1/3 and 2/3 wanted to
do to the function in a way that does not require later clean-up?),
but other than that, the end-result looks good.

Will queue.
