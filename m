Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989002023D
	for <e@80x24.org>; Wed, 17 May 2017 05:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbdEQFDX (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 01:03:23 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34512 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbdEQFDW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 01:03:22 -0400
Received: by mail-pg0-f65.google.com with SMTP id u187so336643pgb.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 22:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3bfBU69pd8n6JKVB2ra8ggIX80Pt3czh0VLYmHPFOeQ=;
        b=lNJb6y+VSeTcVL/GrG7UBqKkmuoy0aq9y3fBrztv0+9GF4KzufA8ci3ddsVlGmodtx
         dQAGT8HVWy9MUvOZrVZClmBKV18XSDT7H+l+Q2BPEWQpa83mwU9eA9zjcvf6JiE3zakW
         C2uRLOmL/dzM2aYq8cj2Bs03OVilKQ7I5rdwuA8Np8XSvqHVdODcPkrrvy5jxWsu7NfC
         1l9ksc6F3ag0ybuHlxnrWwcL/7Jumnqr9lQsZgrE8jn6MyglSGwkw8yAK+bzFjhJcONL
         JXj7cZvwfw8o+bfEq4xdyqqdbtQANNJhu6wAOPEazrZRWNu3W167Y8jiN6FAjGjF8N15
         2cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3bfBU69pd8n6JKVB2ra8ggIX80Pt3czh0VLYmHPFOeQ=;
        b=Ab6FKM6TqgVYUlaKBoYeQ88znGSbpBp2ZNE9ODmFRLe/hJ74JkrOE2b3Gd52yCxofS
         21WvDGnmr1kbkkdyJZLcYb4sVj0eevz+Czx4Ij9n5ngh/994XoWR/xn29bukMa/qI2bp
         mKc2lLUmWY4QbkwixVl4917hnKBSFGzrewbiUng8B30xc3oVRKfDCE6+5TwU6Gtu8P40
         XbZMw0Pxom2EDYoLfjGlkoqY9JsM62GF0Rxn33bzvOZjLL655Eae/U4jzzvkdPPfOGbG
         MsklRYks5rDrC2Bvgn07TPwQeAJojCIascmCprbqGM+h6SkoKLBWvqBsHicxzRmhDDip
         Hvcw==
X-Gm-Message-State: AODbwcDNpM9jXstVROVbv8SvUN9V9QEcC3QIbzJre5frz/sBSvKhOhGZ
        YWXmFe0nTYnpcw==
X-Received: by 10.99.97.83 with SMTP id v80mr1824756pgb.94.1494997401586;
        Tue, 16 May 2017 22:03:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id t3sm1181684pfl.60.2017.05.16.22.03.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 22:03:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCHv2 11/20] diff.c: convert emit_rewrite_lines to use emit_line_*
References: <20170514040117.25865-1-sbeller@google.com>
        <20170517025857.32320-1-sbeller@google.com>
        <20170517025857.32320-12-sbeller@google.com>
Date:   Wed, 17 May 2017 14:03:20 +0900
In-Reply-To: <20170517025857.32320-12-sbeller@google.com> (Stefan Beller's
        message of "Tue, 16 May 2017 19:58:48 -0700")
Message-ID: <xmqqefvoxeg7.fsf@gitster.mtv.corp.google.com>
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
> +			while (0 < size) {
> +				strbuf_addch(&sb, *data);
> +				size -= len;
> +				data += len;
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

The reason why we can lose the LF immediately after the incomplete
line we found in the above loop is because the updated emit_line_0()
adds LF if its input is an incomplete line?  Even before this series
started, emit_line_0() was already prepared to see a complete or
incomplete line and emit the "reset" color after the optional EOL
bytes at the end, so emit_line() and emit_{add,del}_line() calls
throughout the code can pass the body of the line with or without
the EOL and right things will happen.  Sounds about right.




>  	}
>  }
