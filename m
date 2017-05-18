Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC23B201A7
	for <e@80x24.org>; Thu, 18 May 2017 03:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755088AbdERDfs (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 23:35:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35132 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755082AbdERDfs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 23:35:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so4093478pfd.2
        for <git@vger.kernel.org>; Wed, 17 May 2017 20:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F8mxyM2uwWcJqta4KIedblvdTm3pF750PwpotWQX9l4=;
        b=QUSXU1ujXdbqnRbyEEy3Yc0fouX5qeJRb8WFO6tXfw7Gs9SrRnHVQaGMxHVJXsgXwL
         UaujBzMa14V4CHVmg2GDfETzwBnoeVQzrTCSH2xcVxisIXYTx4Tzmu2foX1ncchwhO0U
         6AUothVUT13gfjqhRE8O/hbw3Y4mxxLGZrB/8IetaRbDyFXrrL/fJSn/6r5pLHgW1nrb
         wDZJvt5UXt+9a5t5LJMJ129rbm+LGuBo42G1FtxozkIqh0HfmeS7lLbRj2IHCFpLiKhf
         7pZIH/RAcE5U15tUqJuu8wPRNFEX7s1i0i2DoymU400ZadX7Y2aVQXMKGpE/1nmDVqKc
         D95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F8mxyM2uwWcJqta4KIedblvdTm3pF750PwpotWQX9l4=;
        b=LelZ74naLpAqt/dzPBhQtSftCPRcNVdLAfyD1HLXej6YIjxQNeyGQntXUXFOr1cEtz
         miwLwxDu98JgbB2qcQZ3gSC2k8NMmtRCL7le2N5U6Nr8cp5myT+oYRqsiCfsPRpyyHeF
         WSFqO7Ezuf/Sf+njlnHYMu5k/wUidraGF1Ht69z++LmxaHQjxmnCYGGlaTJWByTLZIBA
         7MUbfOGV8ZqUrqwT8P5Zt/5vIj3yssLGTuYgN9uoz/XCG2yrJB95ATHLXnPFjm2oZzUY
         4EVJCUGIyxLZRO3FAjsRFZzG+wTOqvxOqP8B3MyTW2p9nCWT6e7QRD6IGLrSesKZuAw+
         ksxA==
X-Gm-Message-State: AODbwcDmRcQODBL+S/HDpDA5DPNiIhnsXMkytNNTfK+OggB0v2+Izz+n
        o+LzPeHPGm6UVA==
X-Received: by 10.99.178.90 with SMTP id t26mr2090319pgo.136.1495078547424;
        Wed, 17 May 2017 20:35:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f155:f4fa:305b:79e3])
        by smtp.gmail.com with ESMTPSA id j21sm5912807pfj.80.2017.05.17.20.35.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 20:35:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCHv2 11/20] diff.c: convert emit_rewrite_lines to use emit_line_*
References: <20170514040117.25865-1-sbeller@google.com>
        <20170517025857.32320-1-sbeller@google.com>
        <20170517025857.32320-12-sbeller@google.com>
Date:   Thu, 18 May 2017 12:35:46 +0900
In-Reply-To: <20170517025857.32320-12-sbeller@google.com> (Stefan Beller's
        message of "Tue, 16 May 2017 19:58:48 -0700")
Message-ID: <xmqqefvmvnu5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In a later patch, I want to propose an option to detect&color
> moved lines in a diff, which cannot be done in a one-pass over
> the diff. Instead we need to go over the whole diff twice,
> because we cannot detect the first line of the two corresponding
> lines (+ and -) that got moved.
>
> So to prepare the diff machinery for two pass algorithms
> (i.e. buffer it all up and then operate on the result),
> move all emissions to places, such that the only emitting
> function is emit_line_0.
>
> This covers emit_rewrite_lines.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 3dda9f3c8e..690794aeb8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -722,15 +722,25 @@ static void add_line_count(struct strbuf *out, int count)
>  static void emit_rewrite_lines(struct emit_callback *ecb,
>  			       int prefix, const char *data, int size)
>  {
> -	const char *endp = NULL;
> -	static const char *nneof = " No newline at end of file\n";
>  	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
> +	struct strbuf sb = STRBUF_INIT;
>  
>  	while (0 < size) {
>  		int len;
>  
> -		endp = memchr(data, '\n', size);
> -		len = endp ? (endp - data + 1) : size;
> +		const char *endp = memchr(data, '\n', size);
> +		if (endp)
> +			len = endp - data + 1;
> +		else {

This side does not initialize "len" at all, which means ...

> +			while (0 < size) {
> +				strbuf_addch(&sb, *data);
> +				size -= len;
> +				data += len;

... we do random computation here.

> +			}
> +			strbuf_addch(&sb, '\n');
> +			data = sb.buf;
> +			len = sb.len;
> +		}
>  		if (prefix != '+') {
>  			ecb->lno_in_preimage++;
>  			emit_del_line(reset, ecb, data, len);
> @@ -741,12 +751,13 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
>  		size -= len;
>  		data += len;
>  	}
> -	if (!endp) {
> +	if (sb.len) {
> +		static const char *nneof = "\\ No newline at end of file\n";
>  		const char *context = diff_get_color(ecb->color_diff,
>  						     DIFF_CONTEXT);
> -		putc('\n', ecb->opt->file);
> -		emit_line(ecb->opt, context, reset, 1, '\\',
> -			  nneof, strlen(nneof));
> +		emit_line(ecb->opt, context, reset, 1, 0,
> +			    nneof, strlen(nneof));
> +		strbuf_release(&sb);
>  	}
>  }
