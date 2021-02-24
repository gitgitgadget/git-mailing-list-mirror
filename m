Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEC2C433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 16:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE6864F08
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 16:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhBXQye (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbhBXQx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 11:53:29 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5907C06174A
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 08:52:46 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id t11so4196092ejx.6
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zL4r4yqvs0ddKQ3PcMvw+58nI/eAoCBApFCUtX8tlFk=;
        b=aLF89OJPSE738EfdS9JcPjRGtWx57xY3dFswuWPyAW+o+hi8GmLoTH+RPOOV4Kwz6V
         dUWCK4Jp/hWUeoe7G3U+SCdaMJIUJK6GKxee17fwzcP8MpxAFIEkzOsHVVXG/sign+Y6
         KiGkwZ5sbfTo96BoHFAlz+9mwBkwhEfrT2IIKxBmnLxvvCaeFrlZGoFJQo4Y9mN5pshR
         xhIih1owu+PaQ3J0Gj3Ad8nVmaNSrs1SlgtsnxamUjXiMe0A92ZjE8NBXuRCnF9Zi3ON
         QMppnBj+p96TN5VbYKys9Zg8QrDsP7XEWDegCqFm55f0Imth1N0opLS5r/GhVJvddifi
         FCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zL4r4yqvs0ddKQ3PcMvw+58nI/eAoCBApFCUtX8tlFk=;
        b=AlydKkbG6p5oxeTfdRRqWaMamRMgD040l4jFliuWpmb8XlcpcqFAjgyXA7+UtodhHF
         0zZGwwasJ4wz5ypwSRwAl2yMAUwX1DWQi+Xa1Nn+yhuwuYE/kiV5At/IjmYxhv5oAOTZ
         hRE9rrLZmetUPnxwNwFdGgMrhyzsCKUKX92FfvJvmitaZncnIUQR4VUNMp/5JTNv49U/
         qaKQucnqgpvM7b5wWa6qZUfyg8t+Y0ImqIdRYBIUfeqNC3xt9XPhwLCGZLQUTfy81lsp
         1hEEVK8NUdtpxISdLcEpkME9n77OVgK6y4KNTjorUvEl5OaA9Qz95+xP8gGtJU40ouHq
         azXg==
X-Gm-Message-State: AOAM53179c4HEgKJIGlQH77I7/T7+8tn/nhE+jl8t53i0dfKdbAanbHO
        ExfLaoKyTZNHXttE0AqqOKM=
X-Google-Smtp-Source: ABdhPJxEgs6Eu/zO6PLo9m1FeovVzpeY6O5veis55g+xVyrafuMVMnImsQyv+G0R5wNElAGbE8neOw==
X-Received: by 2002:a17:906:1b0e:: with SMTP id o14mr8760657ejg.541.1614185565568;
        Wed, 24 Feb 2021 08:52:45 -0800 (PST)
Received: from szeder.dev (92-249-246-249.pool.digikabel.hu. [92.249.246.249])
        by smtp.gmail.com with ESMTPSA id i17sm1896089ejo.25.2021.02.24.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:52:45 -0800 (PST)
Date:   Wed, 24 Feb 2021 17:52:42 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 03/17] commit-graph: use chunk-format write API
Message-ID: <20210224165242.GB3590451@szeder.dev>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
 <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
 <ddebf2389880e14a332e354f7b1dbc86a3964985.1613657259.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddebf2389880e14a332e354f7b1dbc86a3964985.1613657259.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 18, 2021 at 02:07:25PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The commit-graph write logic is ready to make use of the chunk-format
> write API. Each chunk write method is already in the correct prototype.
> We only need to use the 'struct chunkfile' pointer and the correct API
> calls.

This patch series messes up the "Writing out commit graph" progress
display, and starting at this commit I get:

  $ git commit-graph write --reachable
  Expanding reachable commits in commit graph: 837569, done.
  Writing out commit graph in 3 passes: 166% (4187845/2512707), done.

Note that 166%.

Before this commit I got:

  Expanding reachable commits in commit graph: 837569, done.
  Writing out commit graph in 5 passes: 100% (4187845/4187845), done.

Note the different number of passes.

