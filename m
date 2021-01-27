Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305D8C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC72120709
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbhA0D7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhA0DDT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 22:03:19 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81A1C0617AB
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 18:29:37 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z6so463708qtn.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 18:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Ec1H25fg2751GNV4z7AGzrQioJQb9Rlh2lj9nseowI=;
        b=kNiSl5MITBCdjZS7SZ6U1JHtg4FE4QEM0zL8kPLJ0XniXKjOdiuOOZpOd0knrVgEGo
         S9zIxSB84DBwjUeubAfhunu7MVYy9W1JOfKiM5BjJtdG2O2uT921U6+815j0F7BRvCeM
         JNlpp8EK7l+j8ffePQuUlgqN8/ldQNobL4bTnMFPgZcg69oGYCWhE4zNOWgeXotBry9A
         aSH1LRe11JEnzPREzmmvmTmtZ4BqsMZ6e2lqPAPmH9yvoP/Wyw0HEO4r/Y3NFuWI/T9I
         ZuloJXHG0cMV9fecu4tQPXKg9pOZCnWq4BBwtec0pC5JD+pLxvrW/q7incvtfzRAneUo
         //Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Ec1H25fg2751GNV4z7AGzrQioJQb9Rlh2lj9nseowI=;
        b=cnbO4XHg8YHgG89Ssui7IUL84IjoPgyfMPlpNOP7me2bjQDwD62MXmKitzybymFNJ2
         JLpMJvPwgKeESRq/+r1S2a30I2k7qdhlvA47sT1IHyTsq9gSsJyd2hQCoFp2qgIyLDdH
         C3i2CMHubXeq2NlQ7p7fj8WixOjyQtWdq3Us4KK9g1nucyeYbZztKoXKOYG6BHidFDi0
         AEm1mRPVMUxCw/98Tmsh7oXjUAvZLQP+gwofvlVc0ZXN/kamcAX4x9HIn7p5qmfqcGxH
         AbsTVsPllY0340ibZipiXYU+4aBOigKH9I0gC94FW9cpwFywlgn9zuhP8wgCnDyCloA+
         Cdpw==
X-Gm-Message-State: AOAM5333wUWa8oDf3QIToBZmRd/8LS+1VvqoZTEPShUdqiAppTZUBUDb
        QNbMk6fnGdNslFpJtK8D6Do36Q==
X-Google-Smtp-Source: ABdhPJxgOUSGAllVCtxCOVSZ2v1Lx8iafJe8tnu8Lc4RCFWPVrfaZeZcjT8kCsHfsHJqJPXmQPi8GQ==
X-Received: by 2002:ac8:1109:: with SMTP id c9mr7801299qtj.120.1611714576889;
        Tue, 26 Jan 2021 18:29:36 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5cad:8534:72d4:8c70])
        by smtp.gmail.com with ESMTPSA id y67sm330313qka.68.2021.01.26.18.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 18:29:36 -0800 (PST)
Date:   Tue, 26 Jan 2021 21:29:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/17] Refactor chunk-format into an API
Message-ID: <YBDQBkmCFUTMM5/C@nand.local>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 04:01:09PM +0000, Derrick Stolee via GitGitGadget wrote:
> This version also changes the approach to use a more dynamic interaction
> with a struct chunkfile pointer. This idea is credited to Taylor Blau [2],
> but I started again from scratch. I also go further to make struct chunkfile
> anonymous to API consumers. It is defined only in chunk-format.c, which
> should hopefully deter future users from interacting with that data
> directly.
>
> [2] https://lore.kernel.org/git/X8%2FI%2FRzXZksio+ri@nand.local/

Great; I am very happy that you found my patch to be useful. I'm glad
that you decided to start from scratch, too, since as I recall there
were some unresolved test issues that I punted on in case you decided to
abandon the topic altogether.

> This combined API is beneficial to reduce duplicated logic. Or rather, to
> ensure that similar file formats have similar protections against bad data.
> The multi-pack-index code did not have as many guards as the commit-graph
> code did, but now they both share a common base that checks for things like
> duplicate chunks or offsets outside the size of the file.

Definitely good.

> Here are some stats for the end-to-end change:
>
>  * 638 insertions(+), 456 deletions(-).
>  * commit-graph.c: 171 insertions(+), 192 deletions(-)
>  * midx.c: 196 insertions(+), 260 deletions(-)
>
> While there is an overall increase to the code size, the consumers do get a
> bit smaller. Boilerplate things like abstracting method to match
> chunk_write_fn and chunk_read_fn make up a lot of these insertions. The
> "interesting" code gets a lot smaller and cleaner.

Like I said in [1], I don't think a net +182 line diff is reason alone
not to pursue this topic. I don't think that an chunked index v3 will
come as part of my work on the on-disk revindex format, but I do think
that it's something brian may be interested in. So, I'm feeling rather
certain that we'll eventually have new callers, at which point this will
reduce duplication overall.

[1]: https://lore.kernel.org/git/X8%2FK1dUgUmwp8ZOv@nand.local/

Thanks,
Taylor
