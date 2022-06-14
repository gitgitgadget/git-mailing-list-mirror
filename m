Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8C6C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 22:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353064AbiFNWiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 18:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352978AbiFNWiw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 18:38:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A96B50E0C
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 15:38:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f8so8904317plo.9
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q1rtPQRmuZW2Z2V71M4vT/XQ5X26GD45vG8iiVI4KRM=;
        b=q13RV7B90yQjCskBBE/rQ8QJAn6H7Uw7YtMubNgw37bqv4xCu+igbIFbMA4q1fzi/X
         CZGm/1GpniiHxyhAt7pQmcXnkIC0zWybWFe2ndVHVNwOlttOralYwMz+TDnwHijVjCsW
         uKQnsvQrpBes2eD2PFp7vaKcHsWVbErTE8ovQMZf8LgO5mLITj4+O7pUzMcthBFxixih
         UyXAjzoeIwSK2/nr0Mp+WrFzPHTwvcT/8UcLv2PE3NgvqeFTxaV4IF8x+KKfLEKnRRSx
         v1+6KHD/MaH5YEUSSLK6SwyTsapaSMfbFVZlCA0lNe6VHgvgIVuYsN5pGQPVtgQm6Jag
         YNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Q1rtPQRmuZW2Z2V71M4vT/XQ5X26GD45vG8iiVI4KRM=;
        b=rxgw0YBayrxvM1ChtBncdigIztI6i1kxs2iSZMDthdFNtEHDRG4YSnlqE5Ci8Q7XGI
         mdEoSV/1nXkEr9b+WtoP/sZrfCDxbDt6ngjcZWs9gzwnElxxhVGvnyXiN+KN+G7iVdJw
         gziVxHVzmxiK07i2if32D2PDAitmH+6iHhFKLMbiLmYhE+MwQvDYu8KlJNG9LVV07VMt
         r9apy9BaFVzcR/XXA+uEjnb4BHInafccpCuql25l31B5dD6MorLnKiKR+U+sud+KvgVd
         Pbz0l0k2AcQ6qVgwqw674StKE191DHKMkn0Ba52T9uLgp+YtFKEjX8s3PpotpNuEJpX1
         J+mA==
X-Gm-Message-State: AJIora9ZkoRahPPZzhs+ws169lx800t8XUH/NekjQh5YIFjjrsN3YIE0
        Va5sqUXsZCOgn7ilRENvTJnAsQ==
X-Google-Smtp-Source: AGRyM1u29oYhATJQs9I7vbq+VGSP39K5NKWQUf4fN6o6bH8zVpUhyvuLGRVPA23daO4eCn7seps85A==
X-Received: by 2002:a17:902:d2d0:b0:168:b0b2:f068 with SMTP id n16-20020a170902d2d000b00168b0b2f068mr6174931plc.45.1655246331686;
        Tue, 14 Jun 2022 15:38:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:2875:8d7a:3bc6:3cab])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001645730e71bsm7776559pln.59.2022.06.14.15.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 15:38:51 -0700 (PDT)
Date:   Tue, 14 Jun 2022 15:38:44 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, derrickstolee@github.com,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com,
        avarab@gmail.com
Subject: Re: [RFC PATCH v2] commit-graph: refactor to avoid
 prepare_repo_settings
Message-ID: <YqkN9F9zlo6WEBvJ@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        me@ttaylorr.com, derrickstolee@github.com,
        lessleydennington@gmail.com, gitster@pobox.com, vdye@github.com,
        avarab@gmail.com
References: <2c2bfc7b43c92dc7c0a4c47a2c88dadeb39c763b.1649486398.git.steadmon@google.com>
 <20220607200231.1958109-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607200231.1958109-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.06.07 13:02, Jonathan Tan wrote:
> Josh Steadmon <steadmon@google.com> writes:
> > diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
> > index e7cf6d5b0f..e53a2635f6 100644
> > --- a/fuzz-commit-graph.c
> > +++ b/fuzz-commit-graph.c
> > @@ -11,7 +11,13 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> >  	struct commit_graph *g;
> >  
> >  	initialize_the_repository();
> > -	g = parse_commit_graph(the_repository, (void *)data, size);
> > +	/*
> > +	 * Manually initialize commit-graph settings, to avoid the need to run
> > +	 * in an actual repository.
> > +	 */
> > +	the_repository->settings.commit_graph_generation_version = 2;
> > +	the_repository->settings.commit_graph_read_changed_paths = 1;
> > +	g = parse_commit_graph_settings(&the_repository->settings, (void *)data, size);
> >  	repo_clear(the_repository);
> >  	free_commit_graph(g);
> 
> The comment doesn't explain why we need to avoid an actual repository. Maybe
> better: Initialize the commit-graph settings that would normally be read from
> the repository's gitdir.
> 
> Other than that, this patch looks good to me. Isolating a part of the
> commit graph mechanism that can be fuzzed without access to the disk is,
> I think, a good idea, and this patch is a good way to do it.

Done in V3, thanks for taking a look!
