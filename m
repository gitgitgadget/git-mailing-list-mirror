Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B53C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122F62075D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="hOaxztCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGJTRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgGJTRH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 15:17:07 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B679EC08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 12:17:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b185so6378517qkg.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5ZESGPuw8U1CSUx2z3/AWFgnHQfvmVUK0jbJSWKFa+Y=;
        b=hOaxztCtVteSDYe9L/c17x5v+3LafNIUZOTNXGxycid2Vk30rUDke4TWwpOK/4Leff
         w3sUIgNKIPn6xOV9TqLi29o3SjfLXSGU6aiIKxB5nJcFPqLJBdommBxn+SSzsWwIBrqe
         E4AaNS831Kd/kiUmmmgxqUOCL8zqjgRR4zp+WllB5JJni+sHJZaK0cxH4/CD7Olko9QZ
         uhxKMDmlBsTycG4DG+ju6J7y02NJ7hhu/Wa/9WLo9X0Amtl41ONtEVE2diMRRLGrP7DS
         AS5Mc+50gJzqy2GYekofCt/YHX9IfReBwBLQpTF8dMmL4z7cbDDS/u/T8uDyLiLxXTjl
         Xqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5ZESGPuw8U1CSUx2z3/AWFgnHQfvmVUK0jbJSWKFa+Y=;
        b=kYL4yjfEAIvjvr9AjCatGzfCXt0Kx1FyyJgGi5wBspE+Hu7LORo7vhd+sxoKty6K7J
         HCwavc5Kvm/GjDZFLUb+9vcrjAsYCX42GrI+SQAN0OIyW5FcauaBUffNG57v1egtNx3y
         G/0+psy4LVyAnNiivWkwbZ32K/7SYTrO3ajrmmndTMaY9pbMy4y7c9GzAEzanvC1fxJi
         jy5LFYOUELBMz+BjNKtDmoZmIc/V9Q5JVceJic6iALuUU43GOJuS1G3D+RL2jlPZ+Po3
         OzzE8jQVpT11Juv43aNV1tfUikd8Lr24dMOBFmpxUoStCH5c6h9CmXAd9J0j7hQloA0q
         N3mg==
X-Gm-Message-State: AOAM530oHNHAx9HlTBe8n0fPnIQd6XeazbvslixeK+oaMR9qzUsd1bVA
        YZTpUeDRvC8syeVuwA/8a0nLiQ==
X-Google-Smtp-Source: ABdhPJziCf9BzqgjSI53/ZaEfLUMzaN/e45U52gCzMtjcgPpHEKC+gJiSzZkK8PKhdqHUoJLMNgrQw==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr70029653qkm.494.1594408626894;
        Fri, 10 Jul 2020 12:17:06 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:4c16:d6c9:a96a:4df9])
        by smtp.gmail.com with ESMTPSA id e9sm8179892qtq.70.2020.07.10.12.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:17:05 -0700 (PDT)
Date:   Fri, 10 Jul 2020 15:17:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        dstolee@microsoft.com, peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: fix "Collecting commits from input"
 progress line
Message-ID: <20200710191704.GA65960@syl.lan>
References: <56403dd377b996d21a4da1e01ffd6e691ac120bd.1589407014.git.me@ttaylorr.com>
 <20200710190238.16376-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710190238.16376-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Szeder,

On Fri, Jul 10, 2020 at 09:02:38PM +0200, SZEDER Gábor wrote:
> To display a progress line while reading commits from standard input
> and looking them up, 5b6653e523 (builtin/commit-graph.c: dereference
> tags in builtin, 2020-05-13) should have added a pair of
> start_delayed_progress() and stop_progress() calls around the loop
> reading stdin.  Alas, the stop_progress() call ended up at the wrong
> place, after write_commit_graph(), which does all the commit-graph
> computation and writing, and has several progress lines of its own.
> Consequintly, that new

s/Consequintly/Consequently

>
>   Collecting commits from input: 1234
>
> progress line is overwritten by the first progress line shown by
> write_commit_graph(), and its final "done" line is shown last, after
> everything is finished:
>
>   $ { sleep 3 ; git rev-list -3 HEAD ; sleep 1 ; } | ~/src/git/git commit-graph write --stdin-commits
>   Expanding reachable commits in commit graph: 873402, done.
>   Writing out commit graph in 4 passes: 100% (3493608/3493608), done.
>   Collecting commits from input: 3, done.
>
> Furthermore, that stop_progress() call was added after the 'cleanup'
> label, where that loop reading stdin jumps in case of an error.  In
> case of invalid input this then results in the "done" line shown after
> the error message:
>
>   $ { sleep 3 ; git rev-list -3 HEAD ; echo junk ; } | ~/src/git/git commit-graph write --stdin-commits
>   error: unexpected non-hex object ID: junk
>   Collecting commits from input: 3, done.
>
> Move that stop_progress() call to the right place.
>
> While at it, drop the unnecessary 'if (progress)' condition protecting
> the stop_progress() call, because that function is prepared to handle
> a NULL progress struct.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  builtin/commit-graph.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 75455da138..796954da60 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -251,7 +251,7 @@ static int graph_write(int argc, const char **argv)
>  			}
>  		}
>
> -
> +		stop_progress(&progress);
>  	}

Thanks for spotting this, and sorry for the couple of progress-related
bugs that I seem to have generated. I appreciate you looking into it and
fixing some of these.

>
>  	if (write_commit_graph(odb,
> @@ -264,8 +264,6 @@ static int graph_write(int argc, const char **argv)
>  cleanup:
>  	string_list_clear(&pack_indexes, 0);
>  	strbuf_release(&buf);
> -	if (progress)
> -		stop_progress(&progress);
>  	return result;
>  }
>
> --
> 2.27.0.547.g4ba2d26563


All looks good here. With the exception of the small typo that I
noticed, this is:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
