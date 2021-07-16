Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F2C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 178EF613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 16:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhGPQ4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPQ4O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 12:56:14 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00846C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:53:19 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id p3so8857193ilg.8
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dyyxEfsSEtmzhTelrvuv8bKoUhKyTSBkb63aPMgAQJo=;
        b=ru0r9NpM+lFHHlh/vsTo1ebklpM3HVkgvqpCl0Ne58o8Xz/i9DmjA7HHKbCRU6c1pE
         1+V6FvuYJSymtW7plEN76f6rXi3Pr4RURu8eJpKBo3zAU/ju8Ri80KRe1oyXJ4reii8C
         ZupJJvjElkj01T8kYrtUe/h3m3NGzTgj8f8Juw+xAalocEgEKl+XBp7arDDVj26ulmQb
         60ouc/FjJjmB4i6LJ/bq8kirsJZJPYvIo80OAwtDTdxIk6AzaavV/dAUa/ANl04Dmegt
         EKHJg6rT4NsUZZ6rAY4qklh3bBesJr3edLZMQ1RfhJN8mw0PTAmefTa+D7R/md0UutPn
         ftfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dyyxEfsSEtmzhTelrvuv8bKoUhKyTSBkb63aPMgAQJo=;
        b=uaoyJISA/NVSVcbNFfktg2Ez7dzIS3e6oMvvV2yIfG6dxiiLqoiVsAQ8TGDozirXjl
         OvhWYteCOe/r6sVfmj/j5TS2yUcklMwAIg5BbNWyAPo1ttKWffSprbnXZBxOQdMGu79T
         eOGhrxqzsbmJscBoXgYReyJYq/Kjbs5diMiONZYGZ+JE04OYCY9v0j6JZBT+Y+QRyNRt
         CZjpFOSEk25OJeCpYHdpkNP7wqBusUsDkZf8sI+BsDisrTQVJLmiHW59wvrz96kDxoOR
         0ZG5ClYuBwfKYHwABh0v7IslKr5Iu2gS6xOxITSbwr65AyAD+ouFisdEwh44+ILxORtW
         LL9w==
X-Gm-Message-State: AOAM530R82zLQjo+sv5R8aAkq0WTUdFjHCkRVhkb0YUeV9NX0vDoaf+/
        1UXq0S7LgNug6Apo+QbWGgeuhQ==
X-Google-Smtp-Source: ABdhPJzCb8QFKn5A3uCa00UTvn6VvNLQjXn8ayxlPerg5M5mcXqiY77j2yoJJ5hToF5qpQ+zZykfIw==
X-Received: by 2002:a05:6e02:666:: with SMTP id l6mr7055769ilt.245.1626454399328;
        Fri, 16 Jul 2021 09:53:19 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:577b:e92e:de16:977f])
        by smtp.gmail.com with ESMTPSA id w14sm2031833ilj.76.2021.07.16.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:53:18 -0700 (PDT)
Date:   Fri, 16 Jul 2021 12:53:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] test-lib-functions: use test-tool for [de]packetize()
Message-ID: <YPG5few/PeStqe/2@nand.local>
References: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
 <patch-1.1-546974eed59-20210716T153909Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-546974eed59-20210716T153909Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 05:41:33PM +0200, Ævar Arnfjörð Bjarmason wrote:
> I ejected changing/adding test code for this v4. This keeps the
> compatibility wrappers and just narrowly changes the things that need
> a packetize_raw() to use that new helper.
>
> I left the simpler packetize() case as a "printf", it could also use
> the test tool, but in case someone cares about process overhead on say
> Windows this entire change should be strictly better than the status
> quo.

Thanks, this version of the series looks much better to me.

> +static void pack_raw_stdin(void)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (strbuf_read(&sb, 0, 0) < 0)
> +		die_errno("failed to read from stdin");
> +	packet_write(1, sb.buf, sb.len);
> +	strbuf_release(&sb);
> +}
> +

Looks good to me.

> -# convert function arguments or stdin (if not arguments given) to pktline
> -# representation. If multiple arguments are given, they are separated by
> -# whitespace and put in a single packet. Note that data containing NULs must be
> -# given on stdin, and that empty input becomes an empty packet, not a flush
> -# packet (for that you can just print 0000 yourself).
> +# These functions are historical wrappers around "test-tool pkt-line"
> +# for older tests. Use "test-tool pkt-line" itself in new tests.

Nice. This keeps the diff relatively minimal. I don't really have a
strong opinion on saying "packetize" or "test-tool pkt-line pack" in the
future. Arguably the latter is more direct, but it's also more of a
mouthful.

I'm fine to take the approach you have here, and adjust the guidance in
the future depending on if people really do start preferring one over
the other in new tests.

>  packetize () {
>  	if test $# -gt 0
>  	then
>  		packet="$*"
>  		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
>  	else
> -		perl -e '
> -			my $packet = do { local $/; <STDIN> };
> -			printf "%04x%s", 4 + length($packet), $packet;
> -		'
> +		test-tool pkt-line pack
>  	fi
>  }

For what it's worth, I would be happy to remove the printf shortcut
entirely. Some quick grepping indicates only 22 uses of the word
"packetize" in our whole test suite (one of them being the function
declaration itself). And of the 21 callers, only 10 pass at least one
argument:

    git grep -Ew 'packetize [^()&]+' -- t

So I would be fine with adding 10 more new processes to the test suite
in the name of simplifying this declaration. I don't feel strongly,
though, since the conditional here does not really add that much
complexity.

Thanks,
Taylor
