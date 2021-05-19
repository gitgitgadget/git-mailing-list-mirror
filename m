Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C67C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090B161042
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhESTzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 15:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhESTzC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 15:55:02 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137A3C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 12:53:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so10653620pfn.6
        for <git@vger.kernel.org>; Wed, 19 May 2021 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Za9j8TnnEWtcMLsil3X2Z1yipR3/e8XTZn12B8z8GBA=;
        b=iQBRXyQQY9mzRW1u7qj3m5LmFCSY+1WIqcmSjJSjtGWLQA7G8HPJ/nN1OXCtKRTkX3
         mBSeu8NAVQ2ttwBptUadGrzK5A3WbZYUXoFqXy4HGzkT9ROdJqO/c1zkJsOPIPW8/qZk
         y5TtLRPGUlxPLpHCnYZ3U+7TkK9inSqvZyw9AYqWnYG+WPXBR6YSNQaZhBDoULYklefh
         cJsrDt3f/75YbE3bWHSh5y79r6VLjiHJ6vRgjjNiz73wibT8Rk+vc93Gj1pJnmYvP9w5
         bZdjmWVgZxoWVYFAY/ytPlwaeUyEWjlYlNpC0BUGrkGieU5QwcOfSDzlq8DngsC1NrZj
         eTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Za9j8TnnEWtcMLsil3X2Z1yipR3/e8XTZn12B8z8GBA=;
        b=tAxW2cOXFdYZSlCgdMu945exaOi9A+ol4xzIgiUidawoJDAD2azuw5Ya+Uc4JuM2Ab
         nJzJKrANEsnf1N7KdPSQaZijbLaffZx0xQ58yP4f0IG+FUMSRNRwfp+7B4tLM0w4a44o
         giGCPPKnECAzZpgieN/E9kfmERIFhw13ZhytClCw2DYNux/EYDcDoGHZDpMOKHccqhEU
         6T7xz2kEUK0E/jpY0DPSTH4q4tO4extCgAgQ/jJ7eyR4iKkmMHhtU4cGL01AqcNwfnZb
         wlQLPTDTcfbzTY/1WLNK7ljxHMgEiUS2251vYsxgtfPl03gP3T2M4snX2yoLwQPs/PSR
         1Ubw==
X-Gm-Message-State: AOAM530cSNavjNUFi3v8RZq4eSSg+o5j6m1fKhR3UKtsiYMs6evWHa/4
        rY/wTofm77kzrh4tw6b/mp0wo35Zx3U=
X-Google-Smtp-Source: ABdhPJyMMFSQcgoHvJryo2mHkgrYVVKHdozc/YQD86A3ys42mp/Te6YkfPSv4+21Zn0wDsWwAmktjQ==
X-Received: by 2002:a62:7fc5:0:b029:2de:5813:8890 with SMTP id a188-20020a627fc50000b02902de58138890mr793632pfd.60.1621454021553;
        Wed, 19 May 2021 12:53:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4edd:d685:2ff9:b567])
        by smtp.gmail.com with ESMTPSA id i9sm5794029pjh.9.2021.05.19.12.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:53:40 -0700 (PDT)
Date:   Wed, 19 May 2021 12:53:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] doc: explain the use of color.pager
Message-ID: <YKVsw3uqb66ifzvd@google.com>
References: <YKTXlTjwOUi4W+R8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKTXlTjwOUi4W+R8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> The current documentation for color.pager is technically correct, but
> slightly misleading and doesn't really clarify the purpose of the
> variable. As explained in the original thread which added it:
>
>   https://lore.kernel.org/git/E1G6zPH-00062L-Je@moooo.ath.cx/
>
> the point is deal with pagers that don't understand colors.

Missing "to" before "deal".  More importantly, I think I'd find a
reference to the commit or a quotation from the affected user more
helpful than a reference to the mailing list archive, since that would
make this a bit more self-contained.  (Especially since I think this
is un-subtle enough that chasing through the mailing list thread
doesn't add much to my life. :))

[...]
> --- a/Documentation/config/color.txt
> +++ b/Documentation/config/color.txt
> @@ -127,8 +127,9 @@ color.interactive.<slot>::
>  	interactive commands.
>  
>  color.pager::
> -	A boolean to enable/disable colored output when the pager is in
> -	use (default is true).
> +	A boolean to specify whether `auto` color modes should colorize
> +	output going to the pager. Defaults to true; set this to false
> +	if your pager does not understand ANSI color codes.

I quite like the "set this to false if your pager does not understand
ANSI color codes" part --- short and to the point.

The sentence before takes me long enough to understand that I don't
think we've gotten the wording right yet.  Before I suggest some
wording, let's make sure I understand the behavior correctly:

- unlike other color.* settings, this can only be "true" or "false".
  It cannot be "auto".

- in other color.* settings, "auto" means "colors are used only when
  stderr goes to a terminal".  A pager typically ultimately writes to
  a terminal, but (1) it's not guaranteed to (e.g., xless writes to
  its own window instead) and (2) more importantly for us, it's not
  guaranteed to write terminal escapes as is.

- so this setting can be used to answer "for the sake of evaluating
  color settings, should we treat output that is going to a pager as
  going to a terminal?"

If I understood correctly, how about some text like the following?

	A boolean to specify whether `auto` color modes should colorize
	output going to a pager, in addition to their behavior of
	colorizing output going to a terminal. Defaults to true; [etc]

Side note, not about this patch: we treat pager.color as a synonym for
color.pager.  Is that something we want to document, or is that an
instance of being extra friendly when the user makes a typo?

Thanks,
Jonathan
