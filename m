Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3151C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABA82073A
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnqfeP+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgGJCBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGJCBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 22:01:09 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CAC08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 19:01:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g13so3294708qtv.8
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 19:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HMLsxyvPI+pn5vd3lxeLwZLMCXdqzPhhfeX09Yjqk8A=;
        b=WnqfeP+Fj+PT25E9fJda/bkJIjiHYQmADeSdRpyhpQWr3z9QkEhvximA5NDikMy57X
         Brk7MihoXxVaUeGTaOwmmE4Pd54yDGzxMF2wYTA8Jbasmiux1bw9Tc7w+DLZz+PlvOH0
         JD9z6mTKgqVcZOf85Vvgils26OyYFFqRWtTc78U49C5T1yZtQL4n/oB3ku9Tn11CSlsw
         1ZZzM+IWegNeu00hAtvH7T5g2xa8eakB8b56uIMgB2hxz/LsK5BE9BLkgVWaON3dQNjV
         bpv4gtz3LPIyXsOelDRF1/zqeOXKUnKzADNpYM6wmMb1D46yLidCr52Zo56IzdFCdZOq
         1BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HMLsxyvPI+pn5vd3lxeLwZLMCXdqzPhhfeX09Yjqk8A=;
        b=G95IyUbjWV5B/Ofykjut4W8/lae6Df4mZkCQI0CQ9Ltl43lFqolQQ5cip12zD94Q3w
         kof7By0SXGhs4l4HfFFonXyk/gRLQRegOb1RqmuSiYqNzUcTgx2YYTKxOT7a8rg8oxFF
         P5hx12FFZRZa8bcsqpc2iHnPeL3WsnmkwzxqoElfkmEPI0bww0BbLWoNw6z//rPjLwow
         u/HnJSR8Pl/nOHmVMFQv2R4UDPJ2+ft/Hk3bCYtKwV/fRvrT8pAYsxxf1Jrifs86EGJf
         2S/PfjH9Vz68vShUGqdQOCmwNG+vH4thGwAY9y1xeUm/qyHdEhXZstM1Otd5Eaywm2qj
         oEEA==
X-Gm-Message-State: AOAM532JW4NxkCDsDjwLGSMaNvrpguNNtHDb1UKYaSlsJ/ftB4N1Ezmz
        hfOdOZEX0EFa4UnBQgGYCIUkX5QhoH0=
X-Google-Smtp-Source: ABdhPJyLdDlSIxe1qKydf/RkeM8iZQDD2D/mWNFfYDha5AMWKU9X5EttmNtPLVKLKy2VBxpx+0GYaA==
X-Received: by 2002:ac8:1088:: with SMTP id a8mr37319817qtj.90.1594346468293;
        Thu, 09 Jul 2020 19:01:08 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i21sm6676977qke.9.2020.07.09.19.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 19:01:07 -0700 (PDT)
Subject: Re: [PATCH 2/2] progress: remove redundant null-checking
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-3-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aebbc1ca-9936-ce1b-bacc-855d353f83f9@gmail.com>
Date:   Thu, 9 Jul 2020 22:01:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200710014242.1088216-3-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 9:42 PM, Emily Shaffer wrote:
> display_progress() and stop_progress() are tolerant to NULL inputs.
> Remove some places where redundant checks are performed before these
> NULL-tolerant functions are called.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  builtin/commit-graph.c | 3 +--
>  commit-graph.c         | 3 +--
>  read-cache.c           | 9 +++------
>  3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index ae4dc2dfcd..7964de3126 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -263,8 +263,7 @@ static int graph_write(int argc, const char **argv)
>  cleanup:
>  	string_list_clear(&pack_indexes, 0);
>  	strbuf_release(&buf);
> -	if (progress)
> -		stop_progress(&progress);
> +	stop_progress(&progress);
>  	return result;
>  }
>  
> diff --git a/commit-graph.c b/commit-graph.c
> index b9a784fece..30d9a75932 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1424,8 +1424,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
>  				    flags, split_opts);
>  
>  	oidset_clear(&commits);
> -	if (data.progress)
> -		stop_progress(&data.progress);
> +	stop_progress(&data.progress);
>  	return result;
>  }
>  
> diff --git a/read-cache.c b/read-cache.c
> index 2ddc422dbd..feb7abe37a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1581,8 +1581,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  		new_entry = refresh_cache_ent(istate, ce, options, &cache_errno, &changed);
>  		if (new_entry == ce)
>  			continue;
> -		if (progress)
> -			display_progress(progress, i);
> +		display_progress(progress, i);
>  		if (!new_entry) {
>  			const char *fmt;
>  
> @@ -1614,10 +1613,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  
>  		replace_index_entry(istate, i, new_entry);
>  	}
> -	if (progress) {
> -		display_progress(progress, istate->cache_nr);
> -		stop_progress(&progress);
> -	}
> +	display_progress(progress, istate->cache_nr);
> +	stop_progress(&progress);
>  	trace_performance_leave("refresh index");
>  	return has_errors;

Looks obviously correct to me.

Thanks,
-Stolee
