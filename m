Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E89C6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 22:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjH2WE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 18:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjH2WEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 18:04:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBC99C
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 15:04:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so5653072276.2
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 15:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693346675; x=1693951475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gcIUAUfR2U+VLnjXuO7jr4+Okcha6SYoSJD9Ez73JCE=;
        b=DeY8gKM8zE70mM1Z4sbl2/ljf4VUetD0iU7sn2fVO9cA07JIeQ8ZM2G+nI/OIwVW0h
         BdZu2N52/s/vnX+7Wv04MEObq6nKLIpmJmU8cAg6zwotcxRo8SbCvpBb0P2dD0RgZyeb
         aOwQu1VL44S5OUGPCvr5RAt1rk+QHrAQVbCYIZmHZVgKPOkZoQ2+3DDBc1ShXRLw/d2O
         k4LiOyseXOHFv2NNzCBkRMk9YjweKysDZiJJNZ3hEW+BW+c52z4YEekJzxOIST7k0BGw
         IVwcTL/JwYvr/zgMJnIlY9qtNJg0X/imzv1neW+aBhV/v4gSi+1l/qOfgTi8tPpAgIF5
         LmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693346675; x=1693951475;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcIUAUfR2U+VLnjXuO7jr4+Okcha6SYoSJD9Ez73JCE=;
        b=gtby03b4h/ye0AC2grIvMbJNmvNaxBbsBIKt13KBeJLl3UhAChrqjGPAORjuyG05Le
         5YYIh1nIRM0I3MIc11RPW9LfiQyuzi3wozYNZHo5TReF/YymJ22MQNtGGg0Xd1PxxFt1
         tLBIcS5bul8qEzjlDyVarSH34ca0szvDkKbBXX1R+eabBhGbDPL8eBcQAbOcWvT0Y1s1
         SIIh17+9xsAvL2xkqmlEvIU2HLJGZLgtogDQntioSXud5/2hekccQD1dVd5FSEi2mvkR
         gY+HYl10BnrM7amSSUCubIwMH1APcjg+CgaNC9k0A2o2GFuCxdtHXs6n/LgcFO/RsGwY
         kznQ==
X-Gm-Message-State: AOJu0Yw6gIWryPCxB3c/QzbeLEDznV0MexTXduuZ2UEttvpVdPT3ujB4
        KCzO/7N98w6omd7G8ONKF4CD7fqzt3on68MBIiNZ
X-Google-Smtp-Source: AGHT+IF1Q0StQb2ALaD2lYaPBTy1WN+7vRlmKaAZGQOO0s0cUro+PLKQoCpA6oOvYHNBL0b0TQhvtbT49afKlMVzbjTs
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:ec07:4d48:eb22:d87c])
 (user=jonathantanmy job=sendgmr) by 2002:a25:dc91:0:b0:d74:6a19:a595 with
 SMTP id y139-20020a25dc91000000b00d746a19a595mr11276ybe.4.1693346674788; Tue,
 29 Aug 2023 15:04:34 -0700 (PDT)
Date:   Tue, 29 Aug 2023 15:04:32 -0700
In-Reply-To: <ZO5DheoYy/syeJ+9@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230829220432.558674-1-jonathantanmy@google.com>
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

Here are answers to your questions, but I'll also reply to the latest
version stating that I'm OK with this patch set being merged (with my
reasons).

Taylor Blau <me@ttaylorr.com> writes:
> Apologies for not quite grokking this, but I am still somewhat confused.
> 
> Suppose we applied something like your suggestion on top of this patch,
> like so:
> 
> --- 8< ---
> diff --git a/bloom.c b/bloom.c
> index 739fa093ba..ee81976342 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -253,16 +253,16 @@ static void init_truncated_large_filter(struct bloom_filter *filter,
>  struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
>  {
>  	struct bloom_filter *filter;
> -	int hash_version;
> +	struct bloom_filter_settings *settings;
> 
>  	filter = get_or_compute_bloom_filter(r, c, 0, NULL, NULL);
>  	if (!filter)
>  		return NULL;
> 
>  	prepare_repo_settings(r);
> -	hash_version = r->settings.commit_graph_changed_paths_version;
> +	settings = get_bloom_filter_settings(r);
> 
> -	if (!(hash_version == -1 || hash_version == filter->version))
> +	if (filter->version != (settings->hash_version == 2 ? 2 : 1))
>  		return NULL; /* unusable filter */
>  	return filter;
>  }
> --- >8 ---
> 
> We have a handful of failing tests, notably including t4216.1, which
> tries to read settings->hash_version, but fails since settings is NULL.
> I believe this happens when we have a computed Bloom filter prepared for
> some commit, but have not yet written a commit graph containing that (or
> any) Bloom filter.

Ah, I discovered this independently too. I think it happens when we
write version 2 Bloom filters to a repo that has no Bloom filters
currently. So, r->settings.commit_graph_changed_paths_version is set to
2, but settings is NULL. I think the solution has to be a combination
of both (use commit_graph_changed_paths_version, but if it is -1, check
get_bloom_filter_settings()). But having said that, as I said above, we
can go with what you have currently.

> But I think we're talking about different things here. The point of
> get_bloom_filter() as a wrapper around get_or_compute_bloom_filter() is
> to only return Bloom filters that are readable under the configuration
> commitGraph.changedPathsVersion.

But this is my contention - sometimes commitGraph.changedPathsVersion is
-1, so we need to find out which version is readable from elsewhere.

> We have a handle on what version was used to compute Bloom filters in
> each layer of the graph by reading its "version" field, which is written
> via load_bloom_filter_from_graph().
> 
> So we want to return a non-NULL filter exactly when we (a) have a Bloom
> filter computed for the given commit, and (b) its version matches the
> version specified in commitGraph.chagnedPathsVersion.

Yes, except add "or autodetected from the first commit graph file that
we read if nothing is specified in commitGraph.changedPathsVersion" to
the end.

> Are you saying that we need to do the normalization ahead of time so
> that we don't emit filters that have different hash versions when
> working in a commit-graph chain where each layer may use different Bloom
> filter settings? 

By "emit" do you mean write filters to disk? If yes, I'm worried about
reading them, not writing them - for example, when running "git log"
with a path. I am worried precisely about the commit-graph chain in
which different layers have different Bloom settings, yes.
