Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771FAC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49735604DA
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 23:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhKCXlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 19:41:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65263 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhKCXl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 19:41:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1405E658D;
        Wed,  3 Nov 2021 19:38:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p402wpoNecBmkS+VwjxFnTbZsnvPNKZ2V8k3JL
        zaz0E=; b=d4hxK24X60Ck7Qa8PrtGsKZkzBmnWQ8CWY3qpcJKyLh3jjIlCeolvE
        3AjfDRQJ0HpZdjm4b6xMkKDJ33lA7dbQTZZcoVikkBQrZDmTvmwgEdHSZQ2t/DpR
        90QG55ELKjiCey5cMDW+J9/Z+GIp89chyAVKT4VBNGJqu+2RBNpqo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98CE4E658C;
        Wed,  3 Nov 2021 19:38:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 074C3E658A;
        Wed,  3 Nov 2021 19:38:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: disallow directional formatting
References: <pull.1071.git.1635857935312.gitgitgadget@gmail.com>
        <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com>
Date:   Wed, 03 Nov 2021 16:38:50 -0700
In-Reply-To: <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 03 Nov 2021 12:23:55
        +0000")
Message-ID: <xmqqk0ho4xo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 338789C8-3CFF-11EC-81A0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +# U+202a..U+2a2e: LRE, RLE, PDF, LRO and RLO
> +# U+2066..U+2069: LRI, RLI, FSI and PDI
> +regex='(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069)'
> +
> +! git ls-files -z ':(attr:!binary)' |
> +LC_CTYPE=C xargs -0r git grep -Ele "$(LC_CTYPE=C.UTF-8 printf "$regex")" --

One thing for the future, and one thing for the present.

 - Do some languages we would add to po/ hierarchy in the future
   possibly want to use these sequences as legitimate contents?

 - Do we need ls-files?  


For the latter, shouldn't the attribute-based pathspec work just
fine with "git grep"?  i.e.

    git grep -l -E -e $pattern -- ':(exclude,attr:binary)'

