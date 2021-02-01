Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0746C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF25B64DB2
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 18:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhBAS0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 13:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbhBASZu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 13:25:50 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A8AC061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 10:25:10 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id n15so17238054qkh.8
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 10:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ceSQTqoStE6PybRXEz6nJAaQyaG9jJhSQ5j1OpSfzic=;
        b=ZgS4u9/HL0xlBoCSGyjQminQLawmcNgXZwflVxio8jn6xF1pgNUCfjk79U4RHJ0oC8
         9yJROOQljHhjRuHB2zCr6R+3hwL5bJCWMeg7+uSQLCYywykAfD0cvdbznsUi7q6kUhtJ
         r2UdTofAOPADZsgL9arbiBK12dOHMHo7leCsQmpOBC/Ap1qeqMnQRZtE8Ih0qAkRXlYA
         1Ic0oNGtlah9R6SPXl2T7Zn0VFJx54eB+4IDVxsx/mkFEBd/ZgXhCAIV5pQ/5ibuUfrm
         pPn3Jk3A8s4tfk36z7A/o8jM21rI1aX9t2Se5rzicJ8lYkOPw4Dp6nrB7SLLyOfKhnnd
         HbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ceSQTqoStE6PybRXEz6nJAaQyaG9jJhSQ5j1OpSfzic=;
        b=X3w+rl4oZY9iyYl72sxzkROxVeLItFz6Y2b7kVoRBgjOyQCy5IXHBQGCamm8rjZVte
         J4ukxp7RyVp9fJHZO+9M/x2RTSzaKNNPKMfS+XYiOjB952Nk3xpAV9l0jApxTg6bUIMS
         JaCc4mZ7XQoxyQtCSFLzX/Qlazmu+ObWAVEEUCJMY1zaNJWAKy0GMUgtNtNjimpjrFxC
         TMJNoOyfjFKOVMkMIkcPcE6wmJOJhucZoYGhKbguALXIycK7OPjleVm9jcp7BWdTKkUE
         Rkp5jd5d7hHaaxFL8ebJQfNmEOVF6mg/fOYVNwtcWjWrv01F5r7v0Tga3KlMGCz9jR5S
         AfnA==
X-Gm-Message-State: AOAM530sq1Ihz8dV5gdpQJRB0YddMT63KbqrCzKYKSMibIQJBFWYwMDY
        RZzYG+uAkcISIle6LwiCABCVQg==
X-Google-Smtp-Source: ABdhPJzfIujzppBNzvzOIutzeKoA5M0ASq1u38LUzNbJS/br+tazrBLHEwjSBDaQ7nV1UzmkoHrC4A==
X-Received: by 2002:a37:af86:: with SMTP id y128mr16606079qke.173.1612203909285;
        Mon, 01 Feb 2021 10:25:09 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8bd2:a84b:ef4c:2356])
        by smtp.gmail.com with ESMTPSA id g186sm14955987qke.0.2021.02.01.10.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:25:08 -0800 (PST)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Mon, 1 Feb 2021 13:25:06 -0500
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/5] commit-graph: prepare commit graph
Message-ID: <YBhHaW7JpiYeNQIp@nand.local>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <dddeec30ebfc6d8403cc10395a9d0c331d1f7ad3.1612199707.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dddeec30ebfc6d8403cc10395a9d0c331d1f7ad3.1612199707.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 05:15:07PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Before checking if the repository has a commit-graph loaded, be sure
> to run prepare_commit_graph(). This is necessary because without this
> instance we would not initialize the topo_levels slab for each of the
> struct commit_graphs in the chain before we start to parse the
> commits. This leads to possibly recomputing the topological levels for
> commits in lower layers even when we are adding a small number of
> commits on top.

I think that the situation arises as follows:

  - Prior to this patch, we didn't always prepare the commit-graph, so
    the topo_levels slab wasn't initialized either.

  - Then we try and compute the topo levels for new commits (which are
    likely to be decendants of older ones that are in commit-graphs and
    have their topo-levels already computed).

  - But in the course of computing topo-levels for the new commits, we
    have to recur on their ancestors, which *look* like they have
    uncomputed topo levels.

That all makes sense, but it may be worth cutting and pasting what I
wrote into your patch to make it clearer.

> By properly initializing the topo_slab, we fix the previously broken
> case of a split commit graph where a base layer has the
> generation_data_overflow chunk.

Makes sense.

> -test_expect_failure 'lower layers have overflow chunk' '
> +test_expect_success 'lower layers have overflow chunk' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	UNIX_EPOCH_ZERO="@0 +0000" &&
>  	FUTURE_DATE="@2147483646 +0000" &&

Terrific :-).

Thanks,
Taylor
