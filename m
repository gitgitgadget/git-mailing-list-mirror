Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF2320401
	for <e@80x24.org>; Wed, 21 Jun 2017 19:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdFUTgb (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:36:31 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36301 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdFUTga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:36:30 -0400
Received: by mail-pg0-f68.google.com with SMTP id e187so20944064pgc.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=98UFzW8aWtbMuATlsBIaWvgzAtWBsOlPU35QH2jgUvE=;
        b=gZGo0AFPvjhK3D5rEH6Wu23JksNLpf/Nns8jWymMVeix7x8Ty0tdWcVDsTxeCmCRrs
         bhWz5s5mjaB98x5M48X057QIEMj3C5a5WIWu+m/8I2kj+NAT6kaW66NhH0mCBGXhkwDz
         cycZZiqqx7DD2u4ZKU47aKA6qSv4ft50tVLZlFSFwRIE5SURSKkMpO4GTbTd4QuHC4w/
         iGZsHlVSs5qAQoc8XK1maovcTNPLj7bYFbCBwVb0AdHusjQIBp55qypbSZQleEwmCNqO
         x0QBAk2BMLANK+Y5rCAew16lpyy3t5L+hMlDGzNIH5F40la46T0mK5KWxgCsW6vZb3UW
         joFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=98UFzW8aWtbMuATlsBIaWvgzAtWBsOlPU35QH2jgUvE=;
        b=JTNu0TL5gVOWMp3r1rOmKgnKlpLeeK0fzA2T4xS6yMch0N0UFsphNudyNKoJecn5oF
         hadyH7j20FjURBuz6630b19QJ6dg4SKoWK5xmKwHFsX1nEie91FMP3KfX/0n0W5ju6Py
         wvxbJFhGOTd0+WS+9/wFvffmU3M6G8kEzbLxx11fujAL5XwPmoDFqcQXgBKkvovus6ke
         8QfVz8bx0n8VLplU2Z4cJhPgepyipEuT5KoPCJnwAKcM4+6k4u7HGbWFXb/94cqskQ6G
         BSM90HiUhngVWIGKFIwQqFUo/AjYyvqnJ7OHw2Ut34zyqjf3YZfHAaxNtTV9EHMsP8Eb
         LLhg==
X-Gm-Message-State: AKS2vOyvXGdAFUz505w92C/CkrVAFoPg3ilLRksSuNcL9jzp0XyxPU4u
        zuRw4i503tnnzw==
X-Received: by 10.98.53.134 with SMTP id c128mr28194730pfa.55.1498073789721;
        Wed, 21 Jun 2017 12:36:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id a4sm23268033pfc.22.2017.06.21.12.36.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 12:36:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jonathantanmy@google.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [PATCH 04/26] diff.c: introduce emit_diff_symbol
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-5-sbeller@google.com>
Date:   Wed, 21 Jun 2017 12:36:28 -0700
In-Reply-To: <20170620024816.20021-5-sbeller@google.com> (Stefan Beller's
        message of "Mon, 19 Jun 2017 19:47:54 -0700")
Message-ID: <xmqq7f05p1z7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 2f9722b382..89466018e5 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -559,6 +559,24 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
>  	emit_line_0(o, set, reset, line[0], line+1, len-1);
>  }
>  
> +enum diff_symbol {
> +	DIFF_SYMBOL_SEPARATOR,

Drop the last comma from enum?

> +static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
> +			     const char *line, int len)
> +{
> +	switch (s) {
> +	case DIFF_SYMBOL_SEPARATOR:
> +		fprintf(o->file, "%s%c",
> +			diff_line_prefix(o),
> +			o->line_termination);
> +		break;

As the first patch in the "diff-symbol" subseries of this topic,
this change must seriously be justified.  Why is it so important
that a printing of an empty line must be moved to a helper function,
which later will gain ability to show other kind of lines?

> +	default:
> +		die("BUG: unknown diff symbol");
> +	}
> +}
> +
>  static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
>  {
>  	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
> @@ -4833,9 +4851,7 @@ void diff_flush(struct diff_options *options)
>  
>  	if (output_format & DIFF_FORMAT_PATCH) {
>  		if (separator) {
> -			fprintf(options->file, "%s%c",
> -				diff_line_prefix(options),
> -				options->line_termination);
> +			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0);
>  			if (options->stat_sep) {
>  				/* attach patch instead of inline */
>  				fputs(options->stat_sep, options->file);
