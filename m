Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92360E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 14:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjJHOfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 10:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjJHOf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 10:35:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE9FAB
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 07:35:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bdcade7fbso638083666b.1
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696775725; x=1697380525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIQzpUiuQxmBT3Z3GzjZJnVMGYdwo75Zj70Bl2Aw+hM=;
        b=kbayHaUtqIgVqQHkVvlmR3pvMLGTtXMM/oLLvTaReannKhFJwqErxpoczss6WsKYc4
         zeUmc1Fgl3rFUZ0bmxkcpmzCm5CaA6GaLAF3xDTi4X2Ln2dnSjTuRNrVMcYU/i/ek74y
         qA94kug4PlKm1rF9Z6WpHDfePndSsZofUtNldmrlckHd/AAVoP+yF0l2WWJ6rPCcoIn5
         QXi4XwI0cALzU15eQdGeycVI6lcVC08qyRGQYPr0gCAbNPz40PzxyuE37MWj2sTEYdWH
         7/JkBBUX53ZKzkXu8/UN7XsZUlpCqWHDOFOobgm/D3Y3W+H9pnDI82Hqdop6my9cEJp0
         hZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696775725; x=1697380525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIQzpUiuQxmBT3Z3GzjZJnVMGYdwo75Zj70Bl2Aw+hM=;
        b=lw+IxZt3BnYjn2mEu2+7QBB2fxoHhHX5UzeLujAPopg4vHrVHwhs/3PskLCsfCa5vn
         NkAX72X52JSyAqt+8x3z0yfKto4mr9hoBkwzXsOF7r7+VqIzO6LaWiEPenXrFuTPsFwS
         5d5cTqBm1fSZ8A01HwJp6tPyBgaco2Rt9PMe+KCrwxUiRl+6GMqq69yCDWfbv0LjtM4k
         FJyn0VQfmG4IH6JEF2uOsCIa7AAQApz2s9QXs1PSgelwXdPD+NlRvK4AZwefivz51RJT
         pri0w5TitVJLII3vZSZ+qZ53JkPkVeErL2oDysx6i6I54uVDtsxCfMv0i/ZkMN8/NWFJ
         /Pjw==
X-Gm-Message-State: AOJu0YzV+6s1A6P9pQQ5VQDITMYBtn5vU8H4IkU0v520sznnx+wSdmZg
        xXR9WckvJkeNJ4oMrUDLFno=
X-Google-Smtp-Source: AGHT+IFqx5lIdLhAxQB0hrMYgyV87CnOMppmd8XcA9NARmLojbM4UkXR0vDnaOKg2UcmL/2zZBy83g==
X-Received: by 2002:a17:906:30ca:b0:9b2:b7f2:bc7b with SMTP id b10-20020a17090630ca00b009b2b7f2bc7bmr11292298ejb.37.1696775725276;
        Sun, 08 Oct 2023 07:35:25 -0700 (PDT)
Received: from localhost (94-21-146-30.pool.digikabel.hu. [94.21.146.30])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170906ae4800b009b27d4153c0sm5672788ejb.178.2023.10.08.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:35:24 -0700 (PDT)
Date:   Sun, 8 Oct 2023 16:35:23 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/15] commit-graph: new filter ver. that fixes murmur3
Message-ID: <20231008143523.GA18858@szeder.dev>
References: <20230830200218.GA5147@szeder.dev>
 <20230901205616.3572722-1-jonathantanmy@google.com>
 <ZRIRtlbsYadg7EUx@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRIRtlbsYadg7EUx@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2023 at 07:03:18PM -0400, Taylor Blau wrote:
> On Fri, Sep 01, 2023 at 01:56:15PM -0700, Jonathan Tan wrote:
> > > > My original design (up to patch 7 in this patch set) defends against
> > > > this by taking the very first version detected and rejecting every
> > > > other version, and Taylor's subsequent design reads every version, but
> > > > annotates filters with its version. So I think we're covered.
> > >
> > > In the meantime I adapted the test cases from the above linked message
> > > to write commit-graph layers with different Bloom filter versions, and
> > > it does fail, because commits from the bottom commit-graph layer are
> > > omitted from the revision walk's output.  And the test case doesn't
> > > even need a middle layer without modified path Bloom filters to "hide"
> > > the different version in the bottom layer.  Merging the layers seems
> > > to work, though.
> >
> > For what it's worth, your test case below (with test_expect_success
> > instead of test_expect_failure) passes with my original design. With the
> > full patch set, it does fail, but for what it's worth, I did spot this,
> > providing an incomplete solution [1] and then a complete one [2]. Your
> > test case passes if I also include the following:
> >
> >   diff --git a/bloom.c b/bloom.c
> >   index ff131893cd..1bafd62a4e 100644
> >   --- a/bloom.c
> >   +++ b/bloom.c
> >   @@ -344,6 +344,10 @@ struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
> >
> >           prepare_repo_settings(r);
> >           hash_version = r->settings.commit_graph_changed_paths_version;
> >   +       if (hash_version == -1) {
> >   +               struct bloom_filter_settings *s = get_bloom_filter_settings(r);
> >   +               hash_version = (s && s->hash_version == 2) ? 2 : 1;
> >   +       }
> >
> >           if (!(hash_version == -1 || hash_version == filter->version))
> >                   return NULL; /* unusable filter */
> >
> > [1] https://lore.kernel.org/git/20230824222051.2320003-1-jonathantanmy@google.com/
> > [2] https://lore.kernel.org/git/20230829220432.558674-1-jonathantanmy@google.com/
> 
> Hmm. I am confused -- are you saying that this series breaks existing
> functionality, or merely does not patch an existing breakage? I *think*
> that it's the latter,

It's neither: the new functionality added in this series is broken.

> since this test case fails identically on master,
> but I am not sure.

Not sure what test you are referring to.  My test demonstrating the
breakage succeeds when adaped to master, because master doesn't
understand the commitgraph.changedPathsVersion=2 setting, and keeps
writing v1 Bloom filter chunks instead, so all commit-graphs layers
contain the same version.

> If my understanding is correct, I think that patching this would involve
> annotating each Bloom filter with a pointer to the bloom_filter_settings
> it was written with, and then using those settings when querying it.

In general we are better off when we don't write Bloom filter chunks
with different settings in the first place.

