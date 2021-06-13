Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CE8C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB74611CE
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 07:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhFMHwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 03:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFMHwI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 03:52:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39741C061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:50:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u24so42266199edy.11
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 00:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vXrTAI+4LJqYkcUg4Ivtijp6qJA7yvsNgJVsNBJbm8c=;
        b=T+G8n8gYLnriXRJubGBAUGz05rK/M+YUwJxXCyTCpZl8SjG6M8qwlAktKGqccVTrkW
         SMTAjh+FFt7x0tcj/yIYr4zUJ5OxsrPNppY0bYgv5uy+Mnjo2KIsMpBjw1qhRGsH8FTH
         iUVLEI5OKPihLcUEDk2t2bfWH7IGHlU8MKny3JFiORbwk42i+DXc/brX5BZ/XES7nJXA
         tkumvVjxIRwdEmbakPYw2gmR897dLiNX6bv8e9AL2FURbdLsFD2vMd8x4joVO+X/Gi79
         JvMoY4LUxpKvmaO8FaS13DpumWchCyoepZrBA9/byzraxTPgb6YApP8pi0PtB+KSlrDU
         hkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vXrTAI+4LJqYkcUg4Ivtijp6qJA7yvsNgJVsNBJbm8c=;
        b=ky4VBnIPfBYRPNSyvaggG7x2K+5ShIW4dp08QYMXctcy+pPV7BHJ5iYsomFsptUpxH
         1r6SaAWd10UkZr5R3lJEK13epW+lC0mfI7tlG6WSlAe7/+IyLuWEU43SMT+V02rrUwyO
         2PIHald9LfkXI+oBqmHk0jV4q84EkpUXucTyQUuVFqwjOtV10Y1ZhOFxCs+vp+wbwmwG
         cI39LngX+2dJuTAZL33wrXEAdAz2l/kva5hEPMUgSXaxv1EA2pjiKHPOC+O6157Gb0U4
         Yx6DfBzmKVARptiMhhqv3bUHGHmAPoV4bHQrEsiAUq5Zm5NJjmS17EoFgF1PVUE/QNAH
         JAVQ==
X-Gm-Message-State: AOAM5317DkJh7P7IHx4CDU+GoMsKEfDXb/0G9+lp0i5m/dygtUyWFEpv
        2WFK+Aw+lTABRsktSD45FCo=
X-Google-Smtp-Source: ABdhPJz/RDG9NdVdNMpuBSB9T6HK7/xBKQVDEZvWV5EpHmIs4Zm65gbnd9G/VVBa8PnnTYXLff6FFg==
X-Received: by 2002:a05:6402:5256:: with SMTP id t22mr12151622edd.54.1623570605561;
        Sun, 13 Jun 2021 00:50:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e22sm5295705edv.57.2021.06.13.00.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 00:50:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] sideband: append suffix for message whose CR in
 next pktline
Date:   Sun, 13 Jun 2021 09:47:22 +0200
References: <87im2s5jjm.fsf@evledraar.gmail.com>
 <20210612050711.4057-4-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210612050711.4057-4-worldhello.net@gmail.com>
Message-ID: <87eed619w3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 12 2021, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> When calling "demultiplex_sideband" on a sideband-2 message, will try to
> split the message by line breaks, and append a suffix to each nonempty
> line to clear the end of the screen line. But in the following example,
> there will be no suffix (8 spaces) for "<message-3>":
>
>     PKT-LINE(\2 <message-1> CR <message-2> CR <message-3>)
>     PKT-LINE(\2 CR <message-4> CR <message-5> CR)
>
> This is because the line break of "<message-3>" is placed in the next
> pktline message.
>
> Without this fix, t5411 must remove trailing spaces of the actual output
> of "git-push" command before comparing.

Nice, i.e. let's generally fix the output instead.

> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  sideband.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/sideband.c b/sideband.c
> index 6f9e026732..abf2be98e1 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -185,6 +185,10 @@ int demultiplex_sideband(const char *me, int status,
>  
>  			if (!scratch->len)
>  				strbuf_addstr(scratch, DISPLAY_PREFIX);
> +			else if (!linelen)
> +				/* buf has a leading CR which ends the remaining
> +				 * scratch of last round of "demultiplex_sideband" */
> +				strbuf_addstr(scratch, suffix);
>  			if (linelen > 0) {

I haven't thought about this carefully but isn't there some way to
combine these if/else if/if statementsn that's clearer?

I.e. here we're doing an "if" check for a !lineline and then an "if"
that can't be true if !linelen.

Isn't this the same as:

if (!scratch->len) {
    ...
} else {
        if (!linelen)
            ...
        else if (linelen > 0)
            ...
}

Or are there cases where we take that "linelen > 0" arm if
!scratch->len?

>  				maybe_colorize_sideband(scratch, b, linelen);
>  				strbuf_addstr(scratch, suffix);

