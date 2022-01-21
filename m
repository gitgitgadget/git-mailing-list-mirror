Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64210C433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 11:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiAULyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiAULyn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 06:54:43 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43C1C061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:54:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id n10so26427534edv.2
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 03:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=G30Y2Fssk8ADiZodHhLgshGCj9yuMX3e1NPDP/tz+Y4=;
        b=mhD0m3mdIb39UatjWPzlrfOmbWIytv8fzDxkD3GLOSGARmp8Yv/8n+ARPviEmM0kkc
         rbI9kIj94PQOBD0Z1C7frEtkuv+u9e1cgWiUJpillkv+SSQPZF8SQh92b1R6GzTOXYR2
         nTgsZUMYd+l+YMjIx4+iu6iLl8kTnfv0WaMYXODeo8xJMw0uUDF2FxA3cNmilvhpxsFF
         OjW7jjsOSunDJqLwKwV6dC/VnhBLnFW+Q3qbupnpK0GmfoZjTDmLqWSD4ktjjzjav8ax
         EDLLGurE0zyU4eKnnUD3iv44eG2BzG0AGfyr7Zy52Q+HBSaoBd1TmND3IX6Sl16tjchn
         A6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=G30Y2Fssk8ADiZodHhLgshGCj9yuMX3e1NPDP/tz+Y4=;
        b=Q6pm3BokxYFe3hUaogoebB+XHcLAoIvDIT3nDKZCJxZlaZSPzH3IxMctLx2PX2ZPhK
         xMqghLoW9H33vRFPixRLqeAhcPnuCllHcQqGHn9HBod8diKNpXWZB+gu4h0VU1DgBlJs
         YX8DGo8nsvyNLLjpaCOR7/cgxxbHmv6u+jicddfzfNffLzwHXLvFthVoJb7HMDwD9JQa
         6wJ+IaCTlgBbf/E19C4zlvIXy7t+09pVx4/DJRMbgU2ZcJDLvx3WA81RVtRQNUR83dO/
         7RDxx0AQAYL++Jw+WCJ24ra120KC4nIeESHBqMr2ORlNaAsKUhvsBOHow11CuqWBtX4D
         ZwQg==
X-Gm-Message-State: AOAM532Bu+dwP1hxb+eHy78yL845a/TgKk48FneJMfG0935NHti8wpdL
        fZGDp9cW8hbFM5lA2fTipSdT8ZJOVX/N0g==
X-Google-Smtp-Source: ABdhPJyzPwu9U7+yoOFOady/HaEcM3PRW7zqEt9LNdiKlFP+Fb+0ZKOXnsQL2rcQyw8ryb9g2bmOfQ==
X-Received: by 2002:a17:907:72c5:: with SMTP id du5mr3048951ejc.210.1642766080908;
        Fri, 21 Jan 2022 03:54:40 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d23sm1609743eja.86.2022.01.21.03.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 03:54:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAsV5-0027h2-Qf;
        Fri, 21 Jan 2022 12:54:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 12/15] reftable: implement record equality generically
Date:   Fri, 21 Jan 2022 12:52:09 +0100
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <6385e449ba714e3ce41f10276fc60e9757519492.1642691534.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <6385e449ba714e3ce41f10276fc60e9757519492.1642691534.git.gitgitgadget@gmail.com>
Message-ID: <220121.86sfthjocg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This simplifies unittests a little, and provides further coverage for
> reftable_record_copy().
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/record.c      | 57 +++++++++++++++++++++++++++++++++++++++++-
>  reftable/record.h      |  5 +++-
>  reftable/record_test.c | 23 +++--------------
>  3 files changed, 63 insertions(+), 22 deletions(-)
>
> diff --git a/reftable/record.c b/reftable/record.c
> index f7c77c51539..2a9e41a992e 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -430,6 +430,15 @@ static int reftable_ref_record_is_deletion_void(const void *p)
>  		(const struct reftable_ref_record *)p);
>  }
>  
> +

stray extra newline being added here.

> +static int reftable_ref_record_equal_void(const void *a,
> +					  const void *b, int hash_size)
> +{
> +	struct reftable_ref_record *ra = (struct reftable_ref_record *) a;
> +	struct reftable_ref_record *rb = (struct reftable_ref_record *) b;
> +	return reftable_ref_record_equal(ra, rb, hash_size);
> +}
> +
>  static struct reftable_record_vtable reftable_ref_record_vtable = {
>  	.key = &reftable_ref_record_key,
>  	.type = BLOCK_TYPE_REF,
> @@ -439,6 +448,7 @@ static struct reftable_record_vtable reftable_ref_record_vtable = {
>  	.decode = &reftable_ref_record_decode,
>  	.release = &reftable_ref_record_release_void,
>  	.is_deletion = &reftable_ref_record_is_deletion_void,
> +	.equal = &reftable_ref_record_equal_void,
>  };
>  
>  static void reftable_obj_record_key(const void *r, struct strbuf *dest)
> @@ -572,6 +582,25 @@ static int not_a_deletion(const void *p)
>  	return 0;
>  }
>  
> +static int reftable_obj_record_equal_void(const void *a, const void *b, int hash_size)
> +{
> +	struct reftable_obj_record *ra = (struct reftable_obj_record *) a;
> +	struct reftable_obj_record *rb = (struct reftable_obj_record *) b;
> +
> +	if (ra->hash_prefix_len != rb->hash_prefix_len
> +	    || ra->offset_len != rb->offset_len)
> +		return 0;
> +
> +	if (ra->hash_prefix_len &&
> +	    memcmp(ra->hash_prefix, rb->hash_prefix, ra->hash_prefix_len))
> +		return 0;

Similar to the memcpy() paranoia isn't this memcmp() paranoia?
I.e. memcmp() returns 0 on a n=0, so we can lose the
"ra->hash_prefix_len &&" here, no?

> +	if (ra->offset_len &&
> +	    memcmp(ra->offsets, rb->offsets, ra->offset_len * sizeof(uint64_t)))
> +		return 0;

...and here, since 0 * sizeof() will just get us zero.
