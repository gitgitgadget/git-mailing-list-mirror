Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C5C4743D
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 20:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A2F6120A
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 20:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFDULD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFDULC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 16:11:02 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E05EC061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 13:09:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id k11so8937477qkk.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VjtByhZd0JtSePxCS+9COQI1XefTuJfPBfUA+fi3l30=;
        b=w64S7e6Wn6kqCtbvTy2veYw5r8OCU691Z9VBTJyvXCykqvKniKz+T7haLQkv/uhBQa
         iSd+u7tc4UE1P/yR/CL8xKZ1CGQgmiYlWChL0xDtJ2EYDleeAVjNkyzCwFrmOMzeaB+r
         6948dMUK1PwoBuWGMm1Mxkiu32BKMZMBfAWRYcWS+z8wGOn9XAzjCpsj2AEtZPoPr+WN
         4jKLQZIyL0kTVVS9WXVzqyZdJQM34SnjphfFH0XfRWKUHg/R+AOFT8G7Y2UIooll4fnH
         iBfUMy1kyxwTPRCUh73RoZBCqrpP61Kx8Dl0Ggmz61W2JvDEmMAiWa6i1DpWVnuONOm7
         KoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VjtByhZd0JtSePxCS+9COQI1XefTuJfPBfUA+fi3l30=;
        b=L+X+zo3sxpvx4zOT2sTZpDSQeZIq5nAplOKRafGcc0fTiqTzyOWnnMAYsfxoUkX+Uf
         9ytw8B+jkokCH5w2IOkwJMHShlGhZYfLZWW4cs6Y4UZykb/W1tl+BRkpg8YQIacIDQCJ
         L7E6obQmwG5VHobMgG9bhjMI3cf2cAWkb8ysiNO4HzgopC+rD7t/rJ6GQcwfisd8dGmC
         car1AYrNaJ/YbQAJrqpNyrikuKaB60eZ1XNlDglHY8jybpQLkzMLRpgmxkoK3fDK3OEJ
         nRwxvxj1uuyB6DwoTaNVeRpAI1RClVOUi2O8Zw1HX+Tz5zo7Tz4UFw6qsWCY+kMyAbk9
         JUuQ==
X-Gm-Message-State: AOAM531EMBDz+LGc05KJXouH3OLJV0pkiemIgpM8/tb9kdNvr1tJPlQX
        DSgtDxzWdYqGT6QQySliaqE+6u2QGTFBDx3R
X-Google-Smtp-Source: ABdhPJy2ZIs7LlXYQcq4jnxoWYbXhVU+2oxQjEmdzE1ED+gkTl6Bt9+pHDAaW3o3dCyxApbTJWf8Vg==
X-Received: by 2002:a05:620a:1492:: with SMTP id w18mr6193842qkj.495.1622837355197;
        Fri, 04 Jun 2021 13:09:15 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e28c:b821:dd88:1fd1])
        by smtp.gmail.com with ESMTPSA id v5sm4641204qkh.39.2021.06.04.13.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 13:09:14 -0700 (PDT)
Date:   Fri, 4 Jun 2021 16:09:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] promisor-remote: support per-repository config
Message-ID: <YLqIaVbA/uDa2qgh@nand.local>
References: <cover.1622580781.git.jonathantanmy@google.com>
 <d8f5fa9b9fab73c2e0923ccf38d5bdb15f7b7a70.1622580781.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8f5fa9b9fab73c2e0923ccf38d5bdb15f7b7a70.1622580781.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 02:34:17PM -0700, Jonathan Tan wrote:
> Instead of using global variables to store promisor remote information,
> store this config in struct repository instead, and add
> repository-agnostic non-static functions corresponding to the existing
> non-static functions that only work on the_repository.
>
> The actual lazy-fetching of missing objects currently does not work on
> repositories other than the_repository, and will still not work after
> this commit, so add a BUG message explaining this. A subsequent commit
> will remove this limitation.

Makes sense to me. I found my answer to the question that I raised
during my review of the previous patch, and I think it would make sense
to address in an amended version of this patch.

Other than that, the translation all looked very faithful to me.

> -void promisor_remote_reinit(void)
> +void repo_promisor_remote_reinit(struct repository *r)
>  {
> -	initialized = 0;
> -	promisor_remote_clear();
> -	promisor_remote_init();
> +	promisor_remote_clear(r->promisor_remote_config);

Ah, this is probably where I would have expected to see
r->promisor_remote_config->repository_format_partial_clone freed as
well.

I wondered whether or not that should have been freed, since on first
read it seemed that this function was mostly concerned with the list of
promisor remotes rather than the structure containing them. But on a
closer look, we are re-initializing the whole structure with
promisor_remote_init(), which runs the whole promisor_remote_config
callback again.

So I do think we want to free that part of the structure, too, before
reinitializing it. I would probably do it in promisor_remote_clear().

> @@ -235,9 +244,11 @@ int promisor_remote_get_direct(struct repository *repo,
>  	if (oid_nr == 0)
>  		return 0;
>
> -	promisor_remote_init();
> +	promisor_remote_init(repo);
>
> -	for (r = promisors; r; r = r->next) {
> +	if (repo != the_repository)
> +		BUG("only the_repository is supported for now");

I could go either way on whether this is worthy of a BUG() or not, but I
don't really have much of a strong feeling about it.

Thanks,
Taylor
