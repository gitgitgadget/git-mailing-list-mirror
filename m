Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E299220D09
	for <e@80x24.org>; Mon, 17 Apr 2017 01:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932506AbdDQBtM (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 21:49:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61877 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932128AbdDQBtK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 21:49:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EA6C8B242;
        Sun, 16 Apr 2017 21:49:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=i2ECBhoOR7jY
        dYvfq5gljqqLnR4=; b=WIn6w+somd/L3/i5a3rBcnLf/4tA0sbZd99KwcmWCJa/
        al6O3IU2c2ukEO1PZy6lISIvF7l2gm7O6F0QnMU8hDG421/HZHODQZDJV6CXMcw0
        GeaZeqq9JEW6+o88oBPzrKsAvuAzahr7WUfMfUpv8hRsWPNe/9cBUnDJ0mczQ+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iF8mpO
        nUvmw3laVoHno9sQVgu+6I02q3YoWHVThrMhgxVeHgI15EIgFNJ99e9JgNpR5OkU
        wy35BLCcV7jIXVDR0+tnyHIaWLcRrUCS1oQfyeMSDxznqPEUywbBt8WrBQmYJsiV
        mWv8b7FZbU/ELLMY7tNqHUShnB38aSf/yNQI4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53F418B241;
        Sun, 16 Apr 2017 21:49:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3A938B240;
        Sun, 16 Apr 2017 21:49:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?Li=C5=A1ka?= <mliska@suse.cz>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
        <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
        <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
        <33c63fb9-281c-8fd2-66e7-b85f62f4f447@web.de>
        <8555c61f-2617-eec8-6dbe-87c79c6ca302@suse.cz>
        <587b0cb9-bd66-ddf7-5cca-023df3470883@kdbg.org>
        <e392e05c-2815-8cfa-eed0-bd990f8ce954@web.de>
        <357d045a-b1c5-1a73-2256-839efb543fe3@kdbg.org>
        <96beb4c6-0569-0c12-8151-462c20be6a2a@suse.cz>
Date:   Sun, 16 Apr 2017 18:49:07 -0700
In-Reply-To: <96beb4c6-0569-0c12-8151-462c20be6a2a@suse.cz> ("Martin
 =?utf-8?Q?Li=C5=A1ka=22's?=
        message of "Fri, 7 Apr 2017 16:23:13 +0200")
Message-ID: <xmqqy3uzkdm4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0C18A77C-2310-11E7-8F7A-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Li=C5=A1ka <mliska@suse.cz> writes:

> From 0bdf4d717d3d368dd9676d15d20f8592c4d22fde Mon Sep 17 00:00:00 2001
> From: marxin <mliska@suse.cz>
> Date: Wed, 5 Apr 2017 14:31:32 +0200
> Subject: [PATCH 1/2] Fix nonnull errors reported by UBSAN with GCC 7.
>
> Replace call to memmove with newly introduced function memmove_or_null
> and call to memcpy with COPY_ARRAY macro.

I didn't closely follow the discussion, but with these three lines
(which will be the primary thing future readers of this change in
"git log -p" output will rely on), it is unclear why this change was
made.  For that matter, it is not clear what "nonnull errors" are,
either.

> Signed-off-by: Martin Liska <mliska@suse.cz>
> ---
>  apply.c            | 4 +---
>  builtin/ls-files.c | 2 +-
>  git-compat-util.h  | 8 ++++++++
>  3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index e6dbab26a..121f3f414 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2802,9 +2802,7 @@ static void update_image(struct apply_state *stat=
e,
>  			img->line + applied_pos + preimage_limit,
>  			(img->nr - (applied_pos + preimage_limit)) *
>  			sizeof(*img->line));
> -	memcpy(img->line + applied_pos,
> -	       postimage->line,
> -	       postimage->nr * sizeof(*img->line));
> +	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->nr);

I am suspecting that postimage->nr can be 0 and newer compliers can
give warning "hey what's the point of copying 0 bytes?" which can be
squelched by moving to COPY_ARRAY()?  If that is the case I like the
change (but as I said, it is unclear if that is what is going on
here).

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index d449e46db..0a6cc1e8a 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -391,7 +391,7 @@ static void prune_cache(const char *prefix, size_t =
prefixlen)
>  		}
>  		last =3D next;
>  	}
> -	memmove(active_cache, active_cache + pos,
> +	memmove_or_null(active_cache, active_cache + pos,
>  		(last - pos) * sizeof(struct cache_entry *));

Does this change come with the same or a similar motivation as the
above (i.e. pos could be the same as last)?

"Something or NULL" is a name we use for a function that returns
something (under normal circumstances) or returns NULL.  This
wrapper is not about returning NULL at all, as far as I can see, and
is misnamed.  If it is about "avoid moving 0 bytes", similar to how
COPY_ARRAY() is used in the previous hunk, perhaps MOVE_ARRAY() is a
better name?

Thanks.

>  	active_nr =3D last - pos;
>  }
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 8a4a3f85e..81f6e56ac 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1002,6 +1002,14 @@ int git_qsort_s(void *base, size_t nmemb, size_t=
 size,
>  		die("BUG: qsort_s() failed");			\
>  } while (0)
> =20
> +static inline void *memmove_or_null(void *dest, const void *src, size_=
t n)
> +{
> +	if (n > 0)
> +		return memmove(dest, src, n);
> +	else
> +		return dest;
> +}
> +
>  #ifndef REG_STARTEND
>  #error "Git requires REG_STARTEND support. Compile with NO_REGEX=3DNee=
dsStartEnd"
>  #endif
