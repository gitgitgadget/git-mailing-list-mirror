Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D82A201A7
	for <e@80x24.org>; Mon, 15 May 2017 22:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbdEOWlB (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 18:41:01 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33333 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbdEOWlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 18:41:00 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so69950082pfh.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8Yb4LD/B9yAtx6ni7lLL++W5mr3eZKsDTnB6kpRdGXY=;
        b=WYzL2JPPlazV577k9kOnvRtJL7SfSkVqBz0+BLFeyieF/eL2t22X7qMjQNnZ4nU3Qo
         sEYu15ovAWUUquvxRyWN2+pq/20I+sRVwwdV6PB/3Q32+fwgruLXiDdUMa4ADlGrO01J
         AMRKl2vpCUb31XbJw5z1l5f3n8lKwfLgf5z47QMJYlzxBbI9WpunOOSbn+CSTju4gm+Y
         nktl4/eatiiwm521OfiCJkrUFhbSGa08Kz4cNTsqy7/X1bSCydQAlnosOgEGhrp6yFGs
         SWGakXUD+AjvZUE/onf01OOfl4e/NDY4DC4Bb6XC86MIOrGz1gFnqrwsc5J5+tdCSN4L
         JYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8Yb4LD/B9yAtx6ni7lLL++W5mr3eZKsDTnB6kpRdGXY=;
        b=bKtLFkowlxoVnxFDp8mu00iHSUv25Ty0RD6YQVD2/oSJetrZZe5O5XggOsrDCD7TRL
         TBawUZDJXwj2RqhV1p8XaRT20jxX9gw2Xq5AdCbKQ7ip8qSddLQaADHhoBgenGIvNuAg
         0FH2lTQFFia9I3VNzVLgauglLBB5YOapAs5Swu5GRMDU+f/0vtuv8MFrYRLgnA7ZYQjL
         /A3IkKIYSDXqUkENKWgpqQRGhGXY3BSxGLOgM2r4eVSXQLEIB9fDoGkt9n26eaqcrAh0
         9F4W40p2JX5+5tqqy6fg3l8LMVwVP9ErsdOw+NOugIrmaxj68jM4ld0g64ZCsFX1WcmT
         47Ng==
X-Gm-Message-State: AODbwcBXrjFNQ4dpsXgppeM6S6GOczNLhng1xonIjIlrPt+OoSVOVUZA
        1WCIsFhAlVrFUdu+
X-Received: by 10.84.129.65 with SMTP id 59mr11484319plb.166.1494888059402;
        Mon, 15 May 2017 15:40:59 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f484:2515:b6cf:fcc0])
        by smtp.gmail.com with ESMTPSA id t71sm22052630pfk.29.2017.05.15.15.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 15:40:57 -0700 (PDT)
Subject: Re: [PATCH 14/19] diff.c: convert word diffing to use emit_line_*
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-15-sbeller@google.com>
Cc:     peff@peff.net, gitster@pobox.com, mhagger@alum.mit.edu,
        jrnieder@gmail.com, bmwill@google.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <f49dc4f8-cc83-934f-e582-79efdc613f70@google.com>
Date:   Mon, 15 May 2017 15:40:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170514040117.25865-15-sbeller@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/13/2017 09:01 PM, Stefan Beller wrote:
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
> This covers all code related to diffing words.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 56 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 91dc045a45..07041a35ad 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -886,37 +886,38 @@ struct diff_words_data {
>  	struct diff_words_style *style;
>  };
>
> -static int fn_out_diff_words_write_helper(FILE *fp,
> +static int fn_out_diff_words_write_helper(struct diff_options *o,
>  					  struct diff_words_style_elem *st_el,
>  					  const char *newline,
>  					  size_t count, const char *buf,
>  					  const char *line_prefix)
>  {
> -	int print = 0;
> +	struct strbuf sb = STRBUF_INIT;
>
>  	while (count) {
>  		char *p = memchr(buf, '\n', count);
> -		if (print)
> -			fputs(line_prefix, fp);
> +
>  		if (p != buf) {
> -			if (st_el->color && fputs(st_el->color, fp) < 0)
> -				return -1;
> -			if (fputs(st_el->prefix, fp) < 0 ||
> -			    fwrite(buf, p ? p - buf : count, 1, fp) != 1 ||
> -			    fputs(st_el->suffix, fp) < 0)
> -				return -1;
> -			if (st_el->color && *st_el->color
> -			    && fputs(GIT_COLOR_RESET, fp) < 0)
> -				return -1;
> +			if (st_el->color)
> +				strbuf_addstr(&sb, st_el->color);
> +			strbuf_addstr(&sb, st_el->prefix);
> +			strbuf_add(&sb, buf, p ? p - buf : count);
> +			strbuf_addstr(&sb, st_el->suffix);
> +			if (st_el->color && *st_el->color)
> +			    strbuf_addstr(&sb, GIT_COLOR_RESET);
>  		}
>  		if (!p)
> -			return 0;
> -		if (fputs(newline, fp) < 0)
> -			return -1;
> +			goto out;
> +		strbuf_addstr(&sb, newline);
> +		emit_line(o, NULL, NULL, sb.buf, sb.len);

I suspect that this will need to be refactored more thoroughly. Here, 
for example, emit_line (which prints the prefix) is printed nearly 
unconditionally, whereas in the original version, "fputs(line_prefix, 
fp)" is only printed when "print" is true.

> +		strbuf_reset(&sb);
>  		count -= p + 1 - buf;
>  		buf = p + 1;
> -		print = 1;
>  	}
> +out:
> +	if (sb.len)
> +		emit_line(o, NULL, NULL, sb.buf, sb.len);
> +	strbuf_release(&sb);
>  	return 0;
>  }
>
> @@ -994,25 +995,25 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
>  	} else
>  		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
>
> -	if (color_words_output_graph_prefix(diff_words)) {
> -		fputs(line_prefix, diff_words->opt->file);
> -	}
> +	if (color_words_output_graph_prefix(diff_words))
> +		emit_line(diff_words->opt, NULL, NULL, "", 0);
> +
>  	if (diff_words->current_plus != plus_begin) {
> -		fn_out_diff_words_write_helper(diff_words->opt->file,
> +		fn_out_diff_words_write_helper(diff_words->opt,
>  				&style->ctx, style->newline,
>  				plus_begin - diff_words->current_plus,
>  				diff_words->current_plus, line_prefix);
>  		if (*(plus_begin - 1) == '\n')
> -			fputs(line_prefix, diff_words->opt->file);
> +			emit_line(diff_words->opt, NULL, NULL, "", 0);
>  	}
>  	if (minus_begin != minus_end) {
> -		fn_out_diff_words_write_helper(diff_words->opt->file,
> +		fn_out_diff_words_write_helper(diff_words->opt,
>  				&style->old, style->newline,
>  				minus_end - minus_begin, minus_begin,
>  				line_prefix);
>  	}
>  	if (plus_begin != plus_end) {
> -		fn_out_diff_words_write_helper(diff_words->opt->file,
> +		fn_out_diff_words_write_helper(diff_words->opt,
>  				&style->new, style->newline,
>  				plus_end - plus_begin, plus_begin,
>  				line_prefix);
> @@ -1109,8 +1110,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
>
>  	/* special case: only removal */
>  	if (!diff_words->plus.text.size) {
> -		fputs(line_prefix, diff_words->opt->file);
> -		fn_out_diff_words_write_helper(diff_words->opt->file,
> +		fn_out_diff_words_write_helper(diff_words->opt,
>  			&style->old, style->newline,
>  			diff_words->minus.text.size,
>  			diff_words->minus.text.ptr, line_prefix);
> @@ -1136,8 +1136,8 @@ static void diff_words_show(struct diff_words_data *diff_words)
>  	if (diff_words->current_plus != diff_words->plus.text.ptr +
>  			diff_words->plus.text.size) {
>  		if (color_words_output_graph_prefix(diff_words))
> -			fputs(line_prefix, diff_words->opt->file);
> -		fn_out_diff_words_write_helper(diff_words->opt->file,
> +			emit_line(diff_words->opt, NULL, NULL, "", 0);
> +		fn_out_diff_words_write_helper(diff_words->opt,
>  			&style->ctx, style->newline,
>  			diff_words->plus.text.ptr + diff_words->plus.text.size
>  			- diff_words->current_plus, diff_words->current_plus,
>
