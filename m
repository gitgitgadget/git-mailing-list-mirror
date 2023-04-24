Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFBDC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 17:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjDXRFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 13:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXRFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 13:05:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCDE4C17
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 10:05:44 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52863157da6so347162a12.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355944; x=1684947944;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7b1mFXRZxjPyeJC/UXaAg1BpiDdl6FAnCpBbKswP2k=;
        b=iYYjx1HAQC5XunOr43XNmep0Pu6oj8E20nuKgvQDsRzj8ts4tpMTIyTBjyHQ5PakyW
         KvncThZB/3vndW+DT8UNKVA/Fgtx5I0Q7FwHhT5pGLDqUJp8Iuqgc6aWuP2Esax3Ze8t
         JpIgrKLD6sCD8QC4MxOGl71NczMsGXHnOA767aGB9nwAeF7oxmeoQDnn6Uy4oHfXQXn+
         pvIA/6/+TwnvgrO1u39LouhkTiWdtWg5cXZcINGb0UjmQXi9r7GC9NdQTOmh/LGudKd6
         8QlLDPx9Qr/s5wZF8eTSDMCI25jSjlt9lvn7gOQGFpcCIY8SdUcB9IhLDybwKdQDA6z8
         RGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355944; x=1684947944;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G7b1mFXRZxjPyeJC/UXaAg1BpiDdl6FAnCpBbKswP2k=;
        b=lyqtmKw4LZ6a71ADKXFg/dMh2wNvvjnGZWj75e2t4IIldqdpeS8xfHqrC1RVeYsKgp
         c8GfOvxFP62FVu4EcOgHf5FsMIAmZyiwMQJRh2nLVU4vTtgx9AKrg3voLsNKRRYhO9+Y
         QL327JhtpNBh//qUpB3Cw+4PNESQb2aoQ3jmvbl5v8ERSWCH1i0alSxPrcU7xOZrgR0X
         g1bm0lwrMbAyj9E1DqzVDhpjtcnhXSc7LQnYKOqZGRAATUXFomdB6MzB23Hlk5yL84TB
         OFh+HPBQsCctfJoVCsSLd895BgwFiji0ddTAIYb1fdc8TPX8Qs4HhThhGECihzxN10Un
         xqWw==
X-Gm-Message-State: AAQBX9f8BRd48aHpeYkXZzcrQdAjTuGF6euY0PgRg8HlVf7v/Ffkbajs
        lmechXZye2XjXmnP1XKpu44=
X-Google-Smtp-Source: AKy350Y2EX4HeIzupPWSBE667xXCWNkXVGI68SHhac3j0IvDDZ7d0BQFgblNX6QN3i6nOmVR6Jw03g==
X-Received: by 2002:a17:90a:cf8f:b0:23d:e0e8:f453 with SMTP id i15-20020a17090acf8f00b0023de0e8f453mr13841516pju.38.1682355943622;
        Mon, 24 Apr 2023 10:05:43 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0023d0290afbdsm8593444pjb.4.2023.04.24.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 10:05:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] parse_commit(): parse timestamp from end of line
References: <20230422134150.GA3516940@coredump.intra.peff.net>
        <20230422134703.GB3942326@coredump.intra.peff.net>
Date:   Mon, 24 Apr 2023 10:05:42 -0700
In-Reply-To: <20230422134703.GB3942326@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 22 Apr 2023 09:47:03 -0400")
Message-ID: <xmqqcz3tfbx5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> To find the committer timestamp, we parse left-to-right looking for the
> closing ">" of the email, and then expect the timestamp right after
> that. But we've seen some broken cases in the wild where this fails, but
> we _could_ find the timestamp with a little extra work. E.g.:
>
>   Name <Name<email>> 123456789 -0500
> ...
> So let's use the same trick as 03818a4a94: find the end of the line, and
> parse back to the final ">".

This obviously assumes that even in a broken ident, it is very
likely that the second component (where <e-mail> usually sits) ends
with a '>'.  Given that we enclose whatever garbage the end user
gave us as their e-mail inside a pair of <> ourselves, it is a very
sensible assumption, I would think.  The original parser assumed
that the end user would not have '>' inside their e-mail part of the
ident, which turns out to be more problematic than the alternative
being proposed.  It is doubly good that we already parse from the
end elsewhere.

Nice.

> +	/*
> +	 * parse to end-of-line and then walk backwards, which
> +	 * handles some malformed cases.
> +	 */

I would say "parse to" -> "jump to", but technically moving forward
looking for a LF byte is still "parsing".  "some" malformed cases
being "most plausible" ones (due to how ident.c::fmt_ident() is what
writes '>' after the string end-user gave as e-mail) may be worth
mentioning.

> +	eol = memchr(buf, '\n', tail - buf);
> +	if (!eol)
>  		return 0;

OK.

> -	dateptr = buf;
> -	while (buf < tail && *buf++ != '\n')
> +	for (dateptr = eol; dateptr > buf && dateptr[-1] != '>'; dateptr--)
>  		/* nada */;

OK.  Just a style thing, but I found that "; /* nada */" is easier
to spot that there is an empty statement there.

> -	if (buf >= tail)
> +	if (dateptr == buf || dateptr == eol)
>  		return 0;

Curious when dateptr that wanted to scan back from eol is still at
eol after the loop.  It is when the ident line ends with ">" without
any timestamp/tz info.   And the reason why we need to check that
here is ...

> -	/* dateptr < buf && buf[-1] == '\n', so parsing will stop at buf-1 */
> +
> +	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */
>  	return parse_timestamp(dateptr, NULL, 10);

... because parse_timestamp() is merely strtoumax() and would
happily skip over arbitrary number of leading "whitespace" without
stopping if (dateptr == eol && *eol == '\n').  OK, sad but correct.

