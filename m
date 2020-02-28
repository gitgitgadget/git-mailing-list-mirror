Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98F4C3F2C6
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 00:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC47B2087F
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 00:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLQk40sw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgB1AEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:04:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40164 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbgB1AEn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 19:04:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id b185so705510pfb.7
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 16:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EJTmU3uvyDKqudvVUDoYtq4d19HD+0oJpdA3Oj2mNeQ=;
        b=QLQk40sw+2oU2+Tu8JDy55TSWawEkesD9uxv+09o+B8dVtSdYGse/oOdICApUnWdNi
         dm+YxMiRVYv+ri83WQOqN7CcCZRS0KZCW/cEwT4s9cHDOsJVvF438/JFum1EuBLEwzwT
         hoN/RDpL9j0K7zgKyo8RVaOhiER5DGAOrdTcibB9Ce3exjgRokfgybH++mETKStqbe73
         FbDRXiMlUPn4vYdQeoRcqJe2lNHmvhmLulFJBhd08DxZKimgpI5K4tF8t9nDMlGOrher
         KGIccm71axMlUvFPIpWiiKXebTYxI7uTt9iYpz6r1znOsBy4wrsbCJJxFb/Z4ue40fbk
         i+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=EJTmU3uvyDKqudvVUDoYtq4d19HD+0oJpdA3Oj2mNeQ=;
        b=XhNCCQ7FgB8M1Bz2sV7hhO+pNdrzloslNhzX+3dDR0/s/CElYgpCiZ1/Vxybfm2T8w
         V9IOepOrA7uyIlQr4nA+50jiocIBEmGOPg1wuQEkr8Nl2hyhF7zcnGTx3diDKm7f9bwF
         tUfvDFhnCAmjt5T6GFRkOQ1DcfBfkBlctlK0BGdET3nwvom6/ntGWXfBpd4DY57dPqis
         dI9aIbEYjVpFRUKJXqsbqDjlh9uR7JzzGJ0tcGLPICsoFdpxWHmWJjIbRvzMtosVLsqn
         0qbSqRexntdoRmwopRWs9JofZ+u3+OikWn0sOZcwi0k/DJPQ4op4wgJd7vhiWWM0jbOM
         6YtQ==
X-Gm-Message-State: APjAAAWx4QdOBVhz7cFyoO5bWhTNIbnqF98fPij3Jpm3o9mTxUYCD9J0
        LW1C1VrnycDc3YoHP4oRdoEvhg==
X-Google-Smtp-Source: APXvYqx52SGpZz4wOA3fcATPbvIBUX661qR9zdUGm4XHxGMFV/pxGhfsNmcQmBi8LRGyKmQjq9g2xA==
X-Received: by 2002:aa7:85d8:: with SMTP id z24mr1677969pfn.202.1582848282170;
        Thu, 27 Feb 2020 16:04:42 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id c26sm8808227pfj.8.2020.02.27.16.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:04:41 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:04:37 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 4/7] index-pack: remove redundant child field
Message-ID: <20200228000437.GD12115@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com, peff@peff.net
References: <cover.1570663470.git.jonathantanmy@google.com>
 <cover.1571343096.git.jonathantanmy@google.com>
 <3359b66b841e7eabdc45d3d937e97208b22e2901.1571343096.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3359b66b841e7eabdc45d3d937e97208b22e2901.1571343096.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.17 13:17, Jonathan Tan wrote:
> @@ -380,27 +378,37 @@ static void free_base_data(struct base_data *c)
>  	}
>  }
>  
> -static void prune_base_data(struct base_data *retain)
> +static void prune_base_data(struct base_data *youngest_child)
>  {
>  	struct base_data *b;
>  	struct thread_local *data = get_thread_data();
> -	for (b = data->base_cache;
> -	     data->base_cache_used > delta_base_cache_limit && b;
> -	     b = b->child) {
> -		if (b->data && b != retain)
> -			free_base_data(b);
> +	struct base_data **ancestry = NULL;
> +	size_t nr = 0, alloc = 0;
> +	ssize_t i;
> +
> +	if (data->base_cache_used <= delta_base_cache_limit)
> +		return;
> +
> +	/*
> +	 * Free all ancestors of youngest_child until we have enough space,
> +	 * starting with the oldest. (We cannot free youngest_child itself.)
> +	 */
> +	for (b = youngest_child->base; b != NULL; b = b->base) {
> +		ALLOC_GROW(ancestry, nr + 1, alloc);
> +		ancestry[nr++] = b;
>  	}
> +	for (i = nr - 1;
> +	     i >= 0 && data->base_cache_used > delta_base_cache_limit;
> +	     i--) {
> +		if (ancestry[i]->data)
> +			free_base_data(ancestry[i]);
> +	}
> +	free(ancestry);
>  }

I had a small complaint that we're allocating new memory in a function
where we are trying to free up space, but in practice it probably
doesn't matter. And this is removed in a later patch anyway.
