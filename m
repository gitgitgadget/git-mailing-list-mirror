Return-Path: <SRS0=mvrS=AI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F29C433DF
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 16:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1448206A5
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 16:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg+2mfYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgF0Qdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgF0Qdk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jun 2020 12:33:40 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C12C061794
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 09:33:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id mb16so12210273ejb.4
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zVfYTJDPhjfmVl/Osfvq7cl++TUVJnQmEQP2ubgisig=;
        b=gg+2mfYkL6McIF0DRS2bA71BANcs/piikJNAPL0jg8v267jVxRnVy0XgqteJaKC9Y/
         vISxXPWZ87CQ3UIE176Yeth4MoyweIm2aPcwY7uD0Q+xN+eS7z4aH/5vzLmExHulz6l2
         srkxLKIswodv/rf749VahvIrOreFBe32+4wvYvu1+VhAY1eOmDVPCHW2TRwt9tGiV2EL
         vLADrtYCqnwpIFVUtlc0nmzAu2N8jSZtT/fZ36ncmlnN6B6iTrtq7XdPiVAt7uv25Bwb
         MHn8sVvNdzcU3rvnkk6MZzF7Cqk70jwL7/hK0wNzxZDGGolpgx0BBgjshFALEV6m2KQK
         h/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zVfYTJDPhjfmVl/Osfvq7cl++TUVJnQmEQP2ubgisig=;
        b=rBkywRpW2EbSLmqqYnGKemfuMkLm0o8xO7ORph0/DLmjyKWrsVxkEwESBe+KXyO5cZ
         xiO5GmasTGCGrp2PmdsEYzxLmwnGs3BY7yHbN1y+RBxbw6YCHMMFvgZaWosdBATfgORP
         9ZLlbRL3y76x04GpQCbKwqLHGPabfiYv27dMEdR4sgpkbsdH2rRhF/HKhXzPftEE2GaQ
         iJsDLYRaXs/AIaAnydkL1QrdlsXu1SwoR6552dVGqjZdnp7tHWMG02AP6wqwkN7Zlbjc
         z3V2vmDoBSiY6PkcUbmrxlcZDnpKNWA1Te7WDzrIqXSoOyQzQcZl9WV2rHy6i5zEepZj
         5W4w==
X-Gm-Message-State: AOAM533Nb33kSDZyjjK+dcb/NkbIIhZYq857/KBCywvtLm4USIcmhj6A
        gB6TQ9L2udtO7uvhAUjSMIBcGke2
X-Google-Smtp-Source: ABdhPJzX4HzK3tVgirFXbQATLqiFYUb2ij0ngPt+ppWAzkd/FzTaIlHARg8qh2uahjlHTCUH5bufFw==
X-Received: by 2002:a17:906:b15:: with SMTP id u21mr7299840ejg.520.1593275618682;
        Sat, 27 Jun 2020 09:33:38 -0700 (PDT)
Received: from szeder.dev (92-249-246-85.pool.digikabel.hu. [92.249.246.85])
        by smtp.gmail.com with ESMTPSA id u18sm2208903edx.34.2020.06.27.09.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2020 09:33:38 -0700 (PDT)
Date:   Sat, 27 Jun 2020 18:33:35 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 03/10] bloom: fix logic in get_bloom_filter()
Message-ID: <20200627163335.GO2898@szeder.dev>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
 <2f809499abadd83b81b3d38d0cad9a2fd08b5440.1593174637.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f809499abadd83b81b3d38d0cad9a2fd08b5440.1593174637.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 12:30:29PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The get_bloom_filter() method is a bit complicated in some parts where
> it does not need to be. In particular, it needs to return a NULL filter
> only when compute_if_not_present is zero AND the filter data cannot be
> loaded from a commit-graph file. This currently happens by accident
> because the commit-graph does not load changed-path Bloom filters from
> an existing commit-graph when writing a new one. This will change in a
> later patch.
> 
> Also clean up some style issues while we are here.
> 
> Helped-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  bloom.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/bloom.c b/bloom.c
> index c38d1cff0c..2af5389795 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -186,7 +186,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  	struct diff_options diffopt;
>  	int max_changes = 512;
>  
> -	if (bloom_filters.slab_size == 0)
> +	if (!bloom_filters.slab_size)
>  		return NULL;
>
>  	filter = bloom_filter_slab_at(&bloom_filters, c);
> @@ -194,16 +194,14 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  	if (!filter->data) {
>  		load_commit_graph_info(r, c);
>  		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
> -			r->objects->commit_graph->chunk_bloom_indexes) {
> -			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
> -				return filter;
> -			else
> -				return NULL;
> -		}
> +		    r->objects->commit_graph->chunk_bloom_indexes)
> +			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
>  	}
>  
> -	if (filter->data || !compute_if_not_present)
> +	if (filter->data)
>  		return filter;
> +	if (!compute_if_not_present)
> +		return NULL;

Some callers of get_bloom_filter() invoke it with
compute_if_not_present=0, but are not prepared to handle a NULL return
value and dereference it right away:

  write_graph_chunk_bloom_indexes():

                struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
                cur_pos += filter->len;

  write_graph_chunk_bloom_data():

                struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
                display_progress(progress, ++i);
                hashwrite(f, filter->data, filter->len * sizeof(unsigned char));

I don't know whether this was an issue before, but I didn't really
tried.  Unfortunately, starting with this patch this causes
segmentation faults basically in all real repositories I use for
testing.

  expecting success of 9999.1 'test': 
          for i in $(test_seq 1 513)
          do
                  >file-$i || return 1
          done &&
          git add file-* &&
          git commit -q -m one &&
  
          git commit-graph write --reachable --changed-paths
  
  Segmentation fault
  not ok 1 - test


  Program received signal SIGSEGV, Segmentation fault.
  0x0000000000515848 in write_graph_chunk_bloom_indexes (f=0x9fe650, 
      ctx=0x9d2000) at commit-graph.c:1101
  1101                    cur_pos += filter->len;
  (gdb) print filter
  $1 = (struct bloom_filter *) 0x0



>  	repo_diff_setup(r, &diffopt);
>  	diffopt.flags.recursive = 1;
> -- 
> gitgitgadget
> 
