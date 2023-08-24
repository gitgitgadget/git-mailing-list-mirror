Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326A7C6FA8F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 23:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243992AbjHXXGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 19:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbjHXXFe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 19:05:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C7E1981
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 16:05:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d799aa369so5493067b3.0
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692918330; x=1693523130;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u+HG6pqUsdiPvtxPvzOKPyFUvHDsZWOlCEpoDg+8+1Y=;
        b=2MHG7JbyfO9FS3j11+Em3Jb+xM/N78fTt9oJEiS1fT0+VaOYwPExk8QigFu0L67jDz
         LqUfGDCnYTdGnGWaj9WQ+OTriuOBxMHt0uHk2bXKzNnM0344LjCfwYnbDd4UO3AvPi/m
         8Zd3h5G+Y9csADHGxoFpz2K59z2X2dBzHqB2c9piWMClrb4iAwTae++qDAs5+cc1KdPp
         Ik1aoaKiMnGkSODzIUNrsmppnuGPzPCbQv4TlzEXLQ1jGAwExZO3sUyQFDQd7hWtqywg
         5XJEXissS3nB+KfxuJABT+35gquGKAA/kJn8/YANLOPGJ5LXQNWqvAUsJk6rxPhI6NOX
         aFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692918330; x=1693523130;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+HG6pqUsdiPvtxPvzOKPyFUvHDsZWOlCEpoDg+8+1Y=;
        b=LgS26MZj0RcHMeJls8qZ/nqq9ZwW7HPxpU7Q5RKDO5D/Ynp5qgBInNQ+W8yHyVw4k2
         vkNec2xJh/P2fA9G3vxMuW9ooCOUOrJdV0NI/8vAhmXNrtFtKH652PewyL9m8CeQNfzk
         j9OLZ0pmN4U0NAhl2GmObfLKkuR+DrQgazLWakob/M2HugG08tVT2TxjIW6AxgVW04mg
         cj1VwSqHZQRtORxXhRP9iRWQVFc7h/MiBHGbIqinxRYHZ98NCmbYY/x/07j+3oI8idQY
         xBlBJJiK38kqhhysdgvyOE95OgsXD7pWqoD8nc9a0TcOtDZCXVjHOGpoar95Ubb7cpJI
         Llcw==
X-Gm-Message-State: AOJu0YwlFuQl1DuAjv4KsRujgyzb/wXdxTa4SUTGp/aHIso8nm0TLsog
        0GbXGlgFHmmjZ0FwGgTQT1L25skf2s+jVcaAgcSV
X-Google-Smtp-Source: AGHT+IE0uYrjop2PP4k3ZLbCm4I7bwgNoNF0mQfVnh2jqmOAUg2YaoGzHvAsVe7fWiMRCxbj44pU0RN6AZ4YKezSyVZc
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:d0eb:2757:7b54:470])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b724:0:b0:583:a3c1:6b5a with
 SMTP id v36-20020a81b724000000b00583a3c16b5amr281223ywh.4.1692918330194; Thu,
 24 Aug 2023 16:05:30 -0700 (PDT)
Date:   Thu, 24 Aug 2023 16:05:27 -0700
In-Reply-To: <ZOfeE1K8aRIECVm4@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230824230527.2332958-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH 2/6] bloom: prepare to discard incompatible Bloom filters
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> I'm not sure I'm following. Are you saying that we should use
> get_bloom_filter_settings() instead of reading the value from
> r->settings directly?
> 
> > then compare filter->version to version 2 if hash_version is 2, and to
> > version 1 otherwise.
> 
> Hmm. I think we're already doing the right thing here, no? IIUC, you're
> saying to do something like:
> 
>     struct bloom_filter_settings *s = get_bloom_filter_settings(r);
>     struct bloom_filter *f = get_or_compute_bloom_filter(r, c, ...);
>     int hash_version;
> 
>     if (!f)
>       return NULL;
> 
>     prepare_repo_settings(r);
>     hash_version = r->settings.commit_graph_changed_paths_version;
> 
>     if (!(hash_version == -1 || hash_version == s->hash_version))
>       return NULL; /* incompatible */
>     return f;
> 
> ?
> 
> If so, I think that we're already OK here, since s->hash_version is
> always going to take the same value as f->version, since f->version is
> assigned in bloom.c::load_bloom_filter_from_graph(), which does:
> 
>     filter->version = g->bloom_filter_settings->hash_version;
> 
> Or are we talking about two different things entirely? ;-)
> 
> Thanks,
> Taylor

Ah, sorry for not being clear. What I meant is in how you compute
hash_version after we have found that filter is not NULL.

> +struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
> +{
> +	struct bloom_filter *filter;
> +	int hash_version;
> +
> +	filter = get_or_compute_bloom_filter(r, c, 0, NULL, NULL);
> +	if (!filter)
> +		return NULL;
> +
> +	prepare_repo_settings(r);

Up to here is fine.

> +	hash_version = r->settings.commit_graph_changed_paths_version;

Instead of doing this, do this (well, move the struct declaration to
the top):

  struct bloom_filter_settings *s = get_bloom_filter_settings(r);
  hash_version = s->hash_version == 2 ? 2 : 1;
  
> +	if (!(hash_version == -1 || hash_version == filter->version))

No need for the comparison to -1 here.

> +		return NULL; /* unusable filter */
> +	return filter;
> +}

This is fine.


