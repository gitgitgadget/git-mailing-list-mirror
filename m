Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1497C433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 09:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B357224F9
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 09:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbhAEJsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 04:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbhAEJsl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:41 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B892C061389
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 01:47:43 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ce23so40410671ejb.8
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 01:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rq6B7OWITegeIFZ4GsgFDacUumzp8d2Lax8G7jGCQlg=;
        b=oF77mZ8XbEfj7yEscuLhCkNwHCaxJJQnM69wPOAvswbI2NfVO/HlmZINbnBLlZJGcx
         qDqHEtnczMO4VkfwHy3XXzHxiWOWU2/l+DbNXkl51Cyj1QHUGLySZzoxSgKNQllAoafQ
         xrIwJgGjjIaZIa2392kNl0BR1ght5dV6HF246GoHoTYTuUfqMO25aZCRkO/1dJCePlxQ
         /F46eouub6tiA5PuOJIbhgiGgs0pKgFoxlrQQ17Hp4tdwA3ovcxadJea2yhdHNbjmJdm
         mUVlfrg0xlX7h0HxKMZfGecZPmeX3LheyQFkCQu3T4I7Bbl4fMtDdFFLMg1RaS+wVAbz
         hN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rq6B7OWITegeIFZ4GsgFDacUumzp8d2Lax8G7jGCQlg=;
        b=C8Eb20AKcB30XR1R2hL6/PL7gvZhx2T2XDYLeeZhbw7Dk4aTmHljvaiziaZFQWQRav
         vd7TqQDXqBiOQIbI0chqBTVEQJ3qseVIYOSJiJBMGx4s5ohdU8dg2kGokByORc/sQQ3n
         Ae6Q2//zp4FMSlDDjPczSu9GnJhCyWlzLt5S7n3soeAPF8VcufswPqqpkzRNaUPPMCAr
         4vXxCy1kdQfQPdO8WueHZyXc56r5vzPAbbi6Tmo7DIZeUU3XH8Dkei+mchCcKe7/23z0
         13zTIHVcj3KWJvgFT8TWa2aeQBmhj39eNCl9Ez3DA43smFmpEvNx37q3mLWUYeXtTROG
         /0IA==
X-Gm-Message-State: AOAM533BY2b7zMRJMaITdySjjlhtc3vEbNVihmUq7uNKlqRnJU1EXQYX
        XqA8unQgHdC0wKaRuBj455I=
X-Google-Smtp-Source: ABdhPJwD5Y/NsvrAlAsOHeMpEHJbmcVavqgbb1LTtFt9Fhd02hUfDFa3+bFbUUiPh/zHYSruACtpYQ==
X-Received: by 2002:a17:906:cd14:: with SMTP id oz20mr65065036ejb.99.1609840062265;
        Tue, 05 Jan 2021 01:47:42 -0800 (PST)
Received: from szeder.dev (84-236-109-79.pool.digikabel.hu. [84.236.109.79])
        by smtp.gmail.com with ESMTPSA id f11sm24484684ejd.40.2021.01.05.01.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 01:47:41 -0800 (PST)
Date:   Tue, 5 Jan 2021 10:47:40 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v5 01/11] commit-graph: fix regression when computing
 Bloom filters
Message-ID: <20210105094740.GO8396@szeder.dev>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <c4e817abf7dbcd6c99da404507ea940305c521b6.1609154168.git.gitgitgadget@gmail.com>
 <20210105094535.GN8396@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210105094535.GN8396@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 05, 2021 at 10:45:35AM +0100, SZEDER Gábor wrote:
> > But since c49c82aa4c (commit: move members graph_pos, generation to a
> > slab, 2020-06-17), this optimization is broken, since asking for a
> > 'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
> > while writing.
> 
> I wouldn't say that c49c82aa4c broke this optimisation, because:
> 
> did not break that optimization.  Though, sadly, it's not
> mentioned in 3d11275505's commit message, when commit_gen_cmp()
> compares two commits with identical generation numbers, then it
> doesn't leave them unsorted, but falls back to use their committer
> date as a tie-braker.  This means that after c49c82aa4c the commits
> are sorted by committer date, which appears to be so good a heuristic
> for Bloom filter computation that there is barely any slowdown
> compared to sorting by generation numbers:

Gaah, scratch this paragraph; I first misunderstood what you wrote in
the paragraph below, but then forgot to remove it.

> > Not all hope is lost, though: 'commit_graph_generation()' falls back to
> 
> You mean commit_gen_cmp() here.
> 
> > comparing commits by their date when they have equal generation number,
> > and so since c49c82aa4c is purely a date comparision function. This
> > heuristic is good enough that we don't seem to loose appreciable
> > performance while computing Bloom filters.
