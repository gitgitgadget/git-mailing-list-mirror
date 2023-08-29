Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BE4C83F16
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 19:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbjH2TOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 15:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbjH2TOU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 15:14:20 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A70193
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 12:14:15 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59234aaca15so54370917b3.3
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693336455; x=1693941255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBHmAR7Wvo8Qu79+3/NWYeM+1lX+bZKq1OhCgIXPKqo=;
        b=IQMHYN05qg/LMLWomIGXVhuWCAOju7xVh9UUJmOrarO3Ds332PC+fYO3kB1LtF9bwn
         vJtDpe6B6Bbg0CPXV519kOkej4BgJNCoyb87u0HcK+AjwEbbXPAjdnIGwNOEKHWXbnVN
         LdlEuDVgLSEjULuAK4G3khkEFRWaLiP3PWMsKhtYoph0/jBZ1OsuQNwPUtxeC5XC+DDH
         JZlSnDP7V44iiP5qqiY10juZC9V/b1RjpWpGT7r/hI5nK9lJpJvZM3BrTbA4gCUEZRy+
         8AOO/F3gKBRwSC92j3RlM94YTQpyHKD/SPWdB/nhx+HusotASzdj6lPfjM6m3zt4iJEB
         k9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693336455; x=1693941255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBHmAR7Wvo8Qu79+3/NWYeM+1lX+bZKq1OhCgIXPKqo=;
        b=Ae4ozUh6kwP0HGHXuk/c6FNutkA8E3IT30qp5ocfPdgDQqOeweJifcQMZ3ike+nDrg
         ATfoDNuukQYccv7VlAIth6Oh2MDjPRvi6daQjojBhSvzWMsIobM2S71ufsUYeWbhS5lZ
         F6o1BIRjT0TeYYV1gxxczjOK/k4p8F7RdBmlwNcdxq9aRZx68Nb4Sc/FAVaiaw/DbnK4
         MJXk18Addq4GykODJA2sfNI8CnkalcmRRASnGgVJHWXx71kyZI/+NgtQdnALW5ea4+u1
         d50ImXztI/0wspJpUxvoeuCuiCsfARArUsiyT9sLX7dXprMCishOiCGmZNnLYhvh+l7r
         F8gg==
X-Gm-Message-State: AOJu0Yx6KsM9oXuTOigFzbzPTqNaoOexVDeRdtKAIVVPK+cwWgmYu0tr
        Ob4JqpA/fyCUrtvnY4iEGXQRjClVgLkAuRw24lI4fA==
X-Google-Smtp-Source: AGHT+IFUXTBpgpn1/6a6ZTfHX2avm0LJInAxfwrvZeaAG6aBSxoj4+vzdKI8jtGbPipmpPvEsZDOqw==
X-Received: by 2002:a81:5285:0:b0:58d:5df8:f61e with SMTP id g127-20020a815285000000b0058d5df8f61emr32318043ywb.2.1693336455129;
        Tue, 29 Aug 2023 12:14:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y130-20020a0dd688000000b005704c4d3579sm2906050ywd.40.2023.08.29.12.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:14:14 -0700 (PDT)
Date:   Tue, 29 Aug 2023 15:14:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/6] bloom: prepare to discard incompatible Bloom
 filters
Message-ID: <ZO5DheoYy/syeJ+9@nand.local>
References: <ZOj6PazHzDeQrY88@nand.local>
 <20230829164926.367260-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829164926.367260-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2023 at 09:49:26AM -0700, Jonathan Tan wrote:
> > > > +	if (!(hash_version == -1 || hash_version == filter->version))
> > >
> > > No need for the comparison to -1 here.
> >
> > I'm not sure I understand your suggestion. When we fetch the filter from
> > get_or_compute_bloom_filter(), we have filter->version set to the
> > hash_version from the containing graph's Bloom filter settings.
> >
> > So (besides the normalization), I would think that:
> >
> >     struct bloom_filter_settings *s = get_bloom_filter_settings(r);
> >     struct bloom_filter *f = get_bloom_filter(...);
> >
> >     assert(s->hash_version == f->version);
> >
> > would hold.
>
> My mention to avoid the comparison to -1 was just for completeness
> - since we're normalizing the value of hash_version to 1 or 2, we no
> longer need to compare it to -1.
>
> As for whether s->hash_version is always equal to f->version, I think
> that it may not be true if for some reason, there are multiple commit
> graph files on disk, not all with the same Bloom filter version.

Apologies for not quite grokking this, but I am still somewhat confused.

Suppose we applied something like your suggestion on top of this patch,
like so:

--- 8< ---
diff --git a/bloom.c b/bloom.c
index 739fa093ba..ee81976342 100644
--- a/bloom.c
+++ b/bloom.c
@@ -253,16 +253,16 @@ static void init_truncated_large_filter(struct bloom_filter *filter,
 struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
 {
 	struct bloom_filter *filter;
-	int hash_version;
+	struct bloom_filter_settings *settings;

 	filter = get_or_compute_bloom_filter(r, c, 0, NULL, NULL);
 	if (!filter)
 		return NULL;

 	prepare_repo_settings(r);
-	hash_version = r->settings.commit_graph_changed_paths_version;
+	settings = get_bloom_filter_settings(r);

-	if (!(hash_version == -1 || hash_version == filter->version))
+	if (filter->version != (settings->hash_version == 2 ? 2 : 1))
 		return NULL; /* unusable filter */
 	return filter;
 }
--- >8 ---

We have a handful of failing tests, notably including t4216.1, which
tries to read settings->hash_version, but fails since settings is NULL.
I believe this happens when we have a computed Bloom filter prepared for
some commit, but have not yet written a commit graph containing that (or
any) Bloom filter.

But I think we're talking about different things here. The point of
get_bloom_filter() as a wrapper around get_or_compute_bloom_filter() is
to only return Bloom filters that are readable under the configuration
commitGraph.changedPathsVersion.

We have a handle on what version was used to compute Bloom filters in
each layer of the graph by reading its "version" field, which is written
via load_bloom_filter_from_graph().

So we want to return a non-NULL filter exactly when we (a) have a Bloom
filter computed for the given commit, and (b) its version matches the
version specified in commitGraph.chagnedPathsVersion.

Are you saying that we need to do the normalization ahead of time so
that we don't emit filters that have different hash versions when
working in a commit-graph chain where each layer may use different Bloom
filter settings? If so, then I think the change we'd need to make is
limited to:

--- 8< ---
diff --git a/bloom.c b/bloom.c
index 739fa093ba..d5cc23b0a8 100644
--- a/bloom.c
+++ b/bloom.c
@@ -260,9 +260,9 @@ struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
 		return NULL;

 	prepare_repo_settings(r);
-	hash_version = r->settings.commit_graph_changed_paths_version;
+	hash_version = r->settings.commit_graph_changed_paths_version == 2 ? 2 : 1;

-	if (!(hash_version == -1 || hash_version == filter->version))
+	if (hash_version == filter->version)
 		return NULL; /* unusable filter */
 	return filter;
 }
--- >8 ---

But that doesn't quite work, either, since it's breaking some assumption
from the caller and causing us not to write out any Bloom filters (I
haven't investigated further, but I'm not sure that this is the right
path in the first place...).

So I am not sure what you are suggesting, but I am sure that I'm missing
something.

Thanks,
Taylor
