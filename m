Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699F120209
	for <e@80x24.org>; Wed, 28 Jun 2017 05:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbdF1FGp (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 01:06:45 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35562 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdF1FGo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 01:06:44 -0400
Received: by mail-pg0-f49.google.com with SMTP id j186so25928431pge.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 22:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xxky0TZMGW8Oeo6CCRvy2uJyA/SUe5AQZ93+pwXYhng=;
        b=ZCYMFLe3arHb7Fbc0RywT7Vhwd7BlV1Z0awgYck6FisXx3awtcmUq5yPUx6MyCnQ2U
         YbTuHgNrEo0ojo1aZC9um0IZw1l3OcnLpLGd+7KUoRlJBvS9XJ1JMn7zk3/skC2cSWwo
         vUBlQ+2Es/Ny5vpiqDXBTyN6ME1yGBsPHwHsDCPhhvb08Aem2PoC7YG/TvNL77IRZVIj
         GmcYUX94x03/5IPnGmrZGfKhp2zQ+aDCB27fUbygzOmiHRaEhF3DkoV+qbwtYwPhDoBS
         VINWi5yG3pUxIxhhCggOOBKrmAib8yydRonSqpj3s3XwVFfoA2zhaW3G6nk8ku9dZGdO
         bzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xxky0TZMGW8Oeo6CCRvy2uJyA/SUe5AQZ93+pwXYhng=;
        b=tup+ya7SkSGcvtd6JbB1c24sHqEpvQy49jDW7Su2glcEa9c2ZQ3jaahKwyZlnxCPkT
         pdbSFOe1inkg7TiCqod9C90aH11rMFtfG2ja3ZGZLHdbbiXhSQJPZbpfBt8d1IiQXjYP
         UkH7XMiL/h+SXdOj+8qibYG8M1U5m7rwfL+dn+eROqLSpC9IWu1BKiBjNpORXWcCQbz6
         DxTVxfIdshL4VutfTJrC0XKczFQiSegGlMxZPd1efEhlDjR6JWoJqYzlzj5haeyxn3GP
         HlYrDbMuNJsL3h8xhfDgF2TC9QOVB9ZHnjN7KV3bWgsSgWqvBTNnKuyspeE3MKnVTn4F
         eaug==
X-Gm-Message-State: AKS2vOzFPo7q98M08xHmx7xkiAzoPx+Y9j+iz/F2I8n02K/7qkLDSZ7d
        utHn1TldxbM63g==
X-Received: by 10.84.229.7 with SMTP id b7mr9732814plk.216.1498626403101;
        Tue, 27 Jun 2017 22:06:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id r27sm1744133pfe.0.2017.06.27.22.06.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 22:06:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 6/6] diff.c: detect blocks despite whitespace changes
References: <20170628005651.8110-1-sbeller@google.com>
        <20170628005651.8110-7-sbeller@google.com>
        <xmqqshikye0o.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 22:06:40 -0700
In-Reply-To: <xmqqshikye0o.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 27 Jun 2017 20:41:59 -0700")
Message-ID: <xmqq37akya3j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Looking at the implementation of get_ws_cleaned_string() that is the
> workhorse of emitted_symbol_cmp_no_ws(), it seems to be doing wrong
> things for various "ignore whitespace" options (i.e. there is only
> one implementation, while "git diff" family takes things like
> "ignore space change", "ignore all whitespace", etc.), though.

This probably deserves a bit more illustration of how I envision the
code should evolve.

In the longer term, I would prefer to see emitted_symbol_cmp_no_ws()
to go and instead emitted_symbol_cmp() to take the diff options so
that it can change the behaviour of the comparison function based on
the -w/-b/--ignore-space-at-eol/etc. settings.  And compare two strings
in place.

For that, you may need a helper function that takes a pointer to a
character pointer, picks the next byte that matters while advancing
the pointer, and returns that byte.  The emitted_symbol_cmp(a, b)
which is not used for real comparison (i.e. ordering to see if a
sorts earlier than b) but for equivalence (i.e. considering various
whitespace-ignoring settings, does a and b matfch?) may become
something like:

        int
        emitted_symbol_eqv(struct emitted_diff_symbol *a,
                           struct emitted_diff_symbol *b,
                           const void *keydata) {
                struct diff_options *diffopt = keydata;
                const char *ap = a->line;
                const char *bp = b->line;

                while (1) {
                        int ca, cb;
                        ca = next_byte(&ap, diffopt);
                        cb = next_byte(&bp, diffopt);
                        if (ca != cb)
                                return 1; /* differs */
                        if (!ca)
                                return 0;
                };
        }                           

where next_byte() may look like:

        static int
        next_byte(const char **cp, struct diff_options *diffopt)
        {                  
                int retval;

        again:
                retval = **cp;
                if (!retval)
                        return retval; /* end of string */
                if (!isspace(retval)) {
                        (*cp)++; /* advance */
                        return retval;
                }

                switch (ignore_space_type(diffopt)) {
                case NOT_IGNORING:
                        (*cp)++; /* advance */
                        return retval;
                case IGNORE_SPACE_CHANGE:
                        while (**cp && isspace(**cp))
                                (*cp)++; /* squash consecutive spaces */
                        return ' '; /* normalize spaces with a SP */
                case IGNORE_ALL_SPACE:
                        (*cp)++; /* advance */
                        goto again;
                ... other cases here ...
                }
        }


