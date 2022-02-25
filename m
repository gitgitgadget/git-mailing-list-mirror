Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E706C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 06:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbiBYGON (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 01:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBYGOM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 01:14:12 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3463C1B0BE3
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 22:13:40 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BFAB1795A7;
        Fri, 25 Feb 2022 01:13:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pNHwSeKb6F6rnE2utGTF91ZBia4vdybeZ3N1Ho
        2QdGI=; b=Jsx61g978DHwBTLQfJP6SqidCTTPQ/ntgKQgZ11T0UOZlrEoE9D/Bu
        98adCo1589Rv1jQ8Hs1wk0et79xGV72cEuN8dU5nLFeErjTZB231/kWNiYbKJ7b4
        9PwK3XEQOAi6bev/nzFXwn2mdpyBmKAoVwgTJj0MX2UGzjK0D3OXg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34BCA1795A5;
        Fri, 25 Feb 2022 01:13:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E9891795A3;
        Fri, 25 Feb 2022 01:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Lawall <julia.lawall@inria.fr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
References: <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
        <pull.1147.v4.git.1645766599.gitgitgadget@gmail.com>
        <e1c5a3258263d05530f236c247603c2f342dac85.1645766599.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:13:36 -0800
In-Reply-To: <e1c5a3258263d05530f236c247603c2f342dac85.1645766599.git.gitgitgadget@gmail.com>
        (Abhradeep Chakraborty via GitGitGadget's message of "Fri, 25 Feb 2022
        05:23:19 +0000")
Message-ID: <xmqqh78nh3sf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11EFE47A-9602-11EC-B69F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +
> +		// OPTION_GROUP should be ignored
> +		// if the first two characters of the help string are uppercase, then assume it is an
> +		// acronym (i.e. "GPG") or special name (i.e. "HEAD"), thus allowed.
> +		// else assume the usage string is violating the style convention and throw error.

Style.

	/*
	 * This is how our multi-line comments
         * look like; with slash-asterisk that opens
         * and asterisk-slash that closes one on their
         * own lines.
	 */

Also avoid overly long lines.

> +		if (opts->type != OPTION_GROUP && opts->help &&
> +			opts->help[0] && isupper(opts->help[0]) &&
> +			!(opts->help[1] && isupper(opts->help[1])))
> +			err |= optbug(opts, xstrfmt("help should not start with capital letter unless needed: %s", opts->help));
> +		if (opts->help && !ends_with(opts->help, "...") && ends_with(opts->help, "."))
> +			err |= optbug(opts, xstrfmt("help should not end with a dot: %s", opts->help));

These two calls to optbug() use xstrfmt() to grab allocated pieces
of memory and pass it as a parameter to the function, which means
the string is leaked without any chance to be freed.

Do we care?

>  		if (opts->argh &&
>  		    strcspn(opts->argh, " _") != strlen(opts->argh))
>  			err |= optbug(opts, "multi-word argh should use dash to separate words");

The existing use of optbug() we see here does not share such a
problem.
