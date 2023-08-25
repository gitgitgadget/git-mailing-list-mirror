Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65EBC3DA66
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 19:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjHYTA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 15:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjHYTAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 15:00:17 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D942126
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 12:00:15 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58d31f142eeso15338297b3.0
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692990014; x=1693594814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zKL/kcNK5CUDkbyx+I2o9fT1pY7mtnJH1AqbgQNGVg=;
        b=UyYb5XO7Tjl511r5Pm1ZOEWTDR4cFp/qZ2VIkc1kjYridEufAGzv7S33LbGai0qjtN
         m54Ng/ZFw4ypHJSAcP1OZKDwdBvqEkbwn7LPhdwAhCa1kEMX54ye1cv/NePYCk4kxIb0
         eAJvwPu0OzkMfTWqS5dFyj68TpfVB26JbnCgBWa5WsRJQsd6MdSGEjcuzNit4x+wD6eg
         nf1hGAuTEbeygX45VYAtHPZYU/thGymHuQhBreTkl8PcnfE/TGVic1Oi72VC1eZtiM5t
         MIgpPr8hixm/xS6ViyGFTCRmLwvZYgpcPGOntJEgbcrdiWLf/zMxThckTV4vX60pTB7/
         RhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692990014; x=1693594814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zKL/kcNK5CUDkbyx+I2o9fT1pY7mtnJH1AqbgQNGVg=;
        b=alNWjx6SFG8qS5PrKOK4hQ4Tnup03WUCpbczinjgEELo8Sst9dWkDau1CJ4eAVSpYW
         eEW2oxKCQ7Q86kBt5vuHjznflK3+f1OMAOcugNRfSeuFSf/5z3tyeHDMaWKZS6zSzOnr
         ohAZWgXEeHTaXdkhjUT1dcQGwF+6985XfpKiWg3lnkwgsD09MutbR4WP4awK8fhPWvyO
         +HD0EObqzkvPJ/4R6BMuAF0Sn9FgHGDOMcF08LVsAiQLT6Wm+OiYbbXElKJ/EBCTN8Sc
         kmpTJc9A+LpXr956LGPvxooVY/8i50zDEGNDaKJhoCkTC0mGrpiZpfXplAxGAMGdGurA
         oDEA==
X-Gm-Message-State: AOJu0Yxtwd1QoAo+duU+zli1xi0SqnJWmwbD1tKJAcEQvFHlXFfuqBUI
        Rvj8wH9t7U+M3NJnTwVeu4binQ==
X-Google-Smtp-Source: AGHT+IGdBoQVFIkLkccq9kgFUnwji2P1ci9ulJjfjDzgAazdiIDQ932QPpGwQa7NzfZGr49n1/mwOQ==
X-Received: by 2002:a81:a014:0:b0:586:563:e61f with SMTP id x20-20020a81a014000000b005860563e61fmr20799314ywg.45.1692990014294;
        Fri, 25 Aug 2023 12:00:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x204-20020a0dd5d5000000b005897fd75c80sm646050ywd.78.2023.08.25.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 12:00:13 -0700 (PDT)
Date:   Fri, 25 Aug 2023 15:00:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/6] bloom: prepare to discard incompatible Bloom
 filters
Message-ID: <ZOj6PazHzDeQrY88@nand.local>
References: <ZOfeE1K8aRIECVm4@nand.local>
 <20230824230527.2332958-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824230527.2332958-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2023 at 04:05:27PM -0700, Jonathan Tan wrote:
> Up to here is fine.
>
> > +	hash_version = r->settings.commit_graph_changed_paths_version;
>
> Instead of doing this, do this (well, move the struct declaration to
> the top):
>
>   struct bloom_filter_settings *s = get_bloom_filter_settings(r);
>   hash_version = s->hash_version == 2 ? 2 : 1;

Do we need this normalization? We assign s->hash_version in
commit-graph.c::graph_read_bloom_data() by reading it from the start of
the BDAT chunk, so this should only ever be 1 or 2.

> > +	if (!(hash_version == -1 || hash_version == filter->version))
>
> No need for the comparison to -1 here.

I'm not sure I understand your suggestion. When we fetch the filter from
get_or_compute_bloom_filter(), we have filter->version set to the
hash_version from the containing graph's Bloom filter settings.

So (besides the normalization), I would think that:

    struct bloom_filter_settings *s = get_bloom_filter_settings(r);
    struct bloom_filter *f = get_bloom_filter(...);

    assert(s->hash_version == f->version);

would hold.

I think the check that we want to make is instead: is this Bloom
filter's version (or equivalently, the hash version indicated by that
graph's BDAT chunk) something that we can read? And I think "what we can
read" here is dictated by the commit_graph_changed_paths_version member
of our repository_settings, no?

Thanks,
Taylor
