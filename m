Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB1D201CF
	for <e@80x24.org>; Tue, 16 May 2017 01:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdEPBAy (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 21:00:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33898 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdEPBAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 21:00:53 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so17825237pfk.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0g5FvGIUBZ70wT0xOqdnT16KZfA0G0OyuAuREUQMKzk=;
        b=ZHr+hBXlFTJ8NSLlk4rnWUqiuD3Zx6+FXlS6v7k9scBDy7F9Lldn8kkO57USWXEksi
         kMlvdN5d8v3w4HjUPxc+OHvVIfnFBQLSUYVT6lYMNHe20LHg8RcmZcQt8I8vgrgMiS1E
         QEkHAfSCbV+3EbEAEa0gFw4jWB6t32y/cdq7JZn1wsIpiDDoI2UjbIUv9Ovk19sRgRVZ
         UazHT71mtTXudyM5tf0wvIBM8Aas+KS/jRFW01EMT00L2j8bHlvcQweLJLcKK3O+lVjR
         BbyELspjv+IfhtmC31RlCBIXfmUX6Xpqdkv+6vI/n5C3Gp9f2IFLl4eGdAEQE8j726fN
         CzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0g5FvGIUBZ70wT0xOqdnT16KZfA0G0OyuAuREUQMKzk=;
        b=MZHEM3XbQpP2TlL9wzAOiTtFucwB5HLZvhgQTR71DptgaWTOALg6X+7BeodWHS9v4R
         8FQZgRIivdjDS4c6lUZhgdVrFBRj1RCyHLYABfJvblpyFm8E1PkBX69Sb8t8sBSR9XyN
         EJ7wXPXog1qLso/ZQUroNrMEjTJqblmd9HVKdzhXOSQOEsnYasbYKDrs2RWKS7pBsdSd
         jzvXiYw2/oOADy75wOWzGmBVsLSy5A9YFUlAdIG4sNBS6hU/IpjbL3DF56QLyks+brtq
         lTr+rAcuoi7Mg29+6k/wj9URDB81nX3D07MQBLVrezzWbSFRs65cj8hCzeCgakXo8xxq
         GSKw==
X-Gm-Message-State: AODbwcAVoPuH6E+cf+oa+euYTbQpdJ0EbeJamyvTtC0yw0Zwje2JsBy0
        M/nH6xifTPaQKQ==
X-Received: by 10.99.143.11 with SMTP id n11mr8880489pgd.232.1494896453136;
        Mon, 15 May 2017 18:00:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id r90sm21922596pfl.82.2017.05.15.18.00.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 18:00:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, peff@peff.net,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com
Subject: Re: [PATCH 07/19] diff.c: convert fn_out_consume to use emit_line_*
References: <20170514040117.25865-1-sbeller@google.com>
        <20170514040117.25865-8-sbeller@google.com>
Date:   Tue, 16 May 2017 10:00:51 +0900
In-Reply-To: <20170514040117.25865-8-sbeller@google.com> (Stefan Beller's
        message of "Sat, 13 May 2017 21:01:05 -0700")
Message-ID: <xmqqtw4l4nuk.fsf@gitster.mtv.corp.google.com>
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
> This covers the parts of fn_out_consume.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index aef159a919..93343a9ccc 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1289,7 +1289,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  	const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
>  	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
>  	struct diff_options *o = ecbdata->opt;
> -	const char *line_prefix = diff_line_prefix(o);
>  
>  	o->found_changes = 1;
>  
> @@ -1301,14 +1300,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  
>  	if (ecbdata->label_path[0]) {
>  		const char *name_a_tab, *name_b_tab;
> -
>  		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
>  		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
> -
> -		fprintf(o->file, "%s%s--- %s%s%s\n",
> -			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
> -		fprintf(o->file, "%s%s+++ %s%s%s\n",
> -			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
> +		emit_line_fmt(o, meta, reset, "--- %s%s\n",
> +			      ecbdata->label_path[0], name_a_tab);
> +		emit_line_fmt(o, meta, reset, "+++ %s%s\n",
> +			      ecbdata->label_path[1], name_b_tab);

How is the loss of line_prefix from this call site compensated?
emit_line_fmt() receives o so it is possible diff_line_prefix(o)
may be called there and prepended to the output over there, but I
somehow do not think that is the case---in fact 06/19 does not seem
to teach emit_line_fmt() to do something like that.

Unless emit_line() is now taught to do the line_prefix thing, that
is.

But then the hunk we see below, which didn't add line_prefix to the
output, would add an unwanted prefix, so that is not likely.

Hmph...

>  		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
>  	}
>  
> @@ -1349,7 +1346,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  		diff_words_flush(ecbdata);
>  		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
>  			emit_line(o, context, reset, line, len);
> -			fputs("~\n", o->file);
> +			emit_line(o, NULL, NULL, "~\n", 2);
>  		} else {
>  			/*
>  			 * Skip the prefix character, if any.  With
