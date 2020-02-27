Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D79C4BA24
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 06:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07172467F
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 06:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGWGEenZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgB0GuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 01:50:03 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52321 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbgB0GuD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 01:50:03 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep11so722419pjb.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 22:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TwbHF0OoIlSHDsJeqcEQOdbOVz2RZdZo96YPugiOx4I=;
        b=WGWGEenZ/5SfaLtRqhg/a8OTR8OB+orXQ2s19/Aa6jwLFhRDCUri0sQTT8CoNcPPbK
         AIetScy8XcIWbJJsJMI0xRGF6+QB3aFRRkGkxGXUrcc0LawREB2ko7+5YBXxBTLEjb7y
         ogufqYJDFNkr+jAk6ojbeC6iiHZ1jD4Ek+PoS6rVnTFRyqsQDMYmZY+tAC9eUxzYM0ZQ
         3UIG+e+Rzz3WEeGpW5VgPjYHwCD2WaP6XsPVz3914XuwyYZet2IfOgGUFRbxlhsBpQbX
         U5zYmt/6hXit5F/4DppC0hI8DOucew0NbNUoMksQweFVp0wkLpMRPvysUhxfyLOaeEXT
         q8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TwbHF0OoIlSHDsJeqcEQOdbOVz2RZdZo96YPugiOx4I=;
        b=ICcKm2FaSYKez7YXvYJ0YRcEfwWiHjPMmZbZtny0PZxIjKDzeNB6GJYULn9/TDFoVi
         fle9b/YT6QClMfMYUcQb4U0Bj4pUN0rnmfseWH3AKymYhzgspWL/rlGPZAsRDw1Ncxes
         OuQpGngolOH5DTzcFiAbwiJi66zALZwlOh0cBNZBUkduM+MDvS8f5+y5x4g8TFaPI+7j
         ZbKsPoNNIAkFEOG/FIj74nsJmefHe0TqKXahnNma/T26ZuqzLMPD15hOaRkj49cdTv2m
         iGrwA40R4UAkCCWNZ3In2IaZXngN31Jz0UOHadwCmDPP6PqttC/olbxn2udPpCQuq7GN
         sCgg==
X-Gm-Message-State: APjAAAUTMgB64jSmv9MPHVBpPNn/aj+KGUYPtSfrsNAgYmRBQuiIrBNn
        h2XxcSmXLw8MOl3sQF61KX4=
X-Google-Smtp-Source: APXvYqzFKr0TryqnC8uA9Q5tm/9ZQ3usjnCOIYzfOeTGqRCgaOYmrC4VH0LFVajESl3Q/7llyb2Caw==
X-Received: by 2002:a17:90a:330f:: with SMTP id m15mr3237881pjb.24.1582786202457;
        Wed, 26 Feb 2020 22:50:02 -0800 (PST)
Received: from [10.197.24.34] ([139.104.2.35])
        by smtp.gmail.com with ESMTPSA id p3sm5574630pfg.184.2020.02.26.22.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 22:50:01 -0800 (PST)
Subject: Re: [GSoC][RFC][PATCH 1/2] STRBUF_INIT_CONST: a new way to initialize
 strbuf
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Robear Selwans <rwagih.rw@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20200218041805.10939-1-robear.selwans@outlook.com>
 <20200218041805.10939-2-robear.selwans@outlook.com>
 <467c035f-c7cd-01e1-e64c-2c915610de01@kdbg.org>
 <113d4221-d7bd-cf0c-ebfc-1fc08442c303@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a94a32f6-a650-4ec7-927e-032e22a23ffe@gmail.com>
Date:   Thu, 27 Feb 2020 01:50:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <113d4221-d7bd-cf0c-ebfc-1fc08442c303@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/20/2020 1:49 PM, René Scharfe wrote:
> Am 19.02.20 um 09:13 schrieb Johannes Sixt:
>> As the macro is just intended for convenience, I suggest to implement it
>> using strbuf_addstr() under the hood. That is much less code churn, and
>> the price is paid only by the strbufs that actually use the feature.
> 
> I was also wondering what the benefits of this change might be.  Saving
> one line and thus increasing convenience slightly doesn't justify all
> this added complexity.  Saving an allocation in the following sequence
> might be worthwhile:
> 
> 	struct strbuf sb = STRBUF_INIT;
> 	strbuf_addstr(&sb, "foo");
> 	/* Use sb without modifying it. */
> 	strbuf_release(&sb); /* or leak it */
> 
> I found two examples of this pattern in the code, one in range-diff.c in
> the function show_range_diff(), and below is a patch for getting rid of
> the second one.  Are there other reasons why we'd want that feature?
> Could you perhaps include a patch that makes use of it in this series,
> to highlight its benefits?
> 
> -- >8 --
> Subject: [PATCH] commit-graph: use progress title directly
> 
> merge_commit_graphs() copies the (translated) progress message into a
> strbuf and passes the copy to start_delayed_progress() at each loop
> iteration.  The latter function takes a string pointer, so let's avoid
> the detour and hand the string to it directly.  That's shorter, simpler
> and slightly more efficient.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  commit-graph.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 656dd647d5..f013a84e29 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1657,19 +1657,15 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx)
>  {
>  	struct commit_graph *g = ctx->r->objects->commit_graph;
>  	uint32_t current_graph_number = ctx->num_commit_graphs_before;
> -	struct strbuf progress_title = STRBUF_INIT;
> 
>  	while (g && current_graph_number >= ctx->num_commit_graphs_after) {
>  		current_graph_number--;
> 
> -		if (ctx->report_progress) {
> -			strbuf_addstr(&progress_title, _("Merging commit-graph"));
> -			ctx->progress = start_delayed_progress(progress_title.buf, 0);
> -		}
> +		if (ctx->report_progress)
> +			ctx->progress = start_delayed_progress(_("Merging commit-graph"), 0);
> 
>  		merge_commit_graph(ctx, g);
>  		stop_progress(&ctx->progress);
> -		strbuf_release(&progress_title);
> 
>  		g = g->base_graph;
>  	}
> --

Not only is this a good change, it no longer leaks memory.
Thanks!

-Stolee
