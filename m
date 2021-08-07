Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A392AC432BE
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 01:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE4160720
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 01:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhHGBzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 21:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhHGBzW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 21:55:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CB6C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 18:55:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u16so9505302ple.2
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 18:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=05tpZUv648xLSJan39p8NYADVieoz6dzv3eDwlDEJ/w=;
        b=tbql2zwYnQKlGYZ8XYUWOPXc9Er156mBF7Q7NMYvOu3rUepO0ScB313xz0CRa4mKW4
         AOcavVN49r8GQAOoIwKFzX4fbjq/PwGHjB02DsLt6d/CQz1jv5Awi/cxBd/XnSf9jIEo
         2vgZRjgIgP61hEQEFM61u+13HKyA2HZSMUtfCE9zns1s6sLc0wxc/IihzhufbGemyfeJ
         hX+8kF7lkLFllXAkZk7GXAHQLqgr/2wZsUwo0NtZqBb/cMQ6c6AzAe1Vk2vT55ZXWSrH
         VYL4YaHJDZf9zwLfeAxOoMCUmIjBK58+GEU9HN0bNJ30Syko5Gkk3Kwsqw2VyBLJLsMW
         ZmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=05tpZUv648xLSJan39p8NYADVieoz6dzv3eDwlDEJ/w=;
        b=ZNu/nfFMQQYkta8pnJ6+/zxdL+B75P0SIHDsDAmMRqyXFInZpAaOlcrtHJJyibm4Gk
         z9FonNmkbGAVRg9MeXZ6JCGouC5YHLieQZxvUkfQt4ruuOSpZCaWBGbEk1OSSxh69g1l
         Fmrn2yOo/e/uWegmzptk86wiQObNZlcmfutUFQ2Fbm6ckWH7jregOgO/8w5Pgdqj3yNl
         xOZUS/O/dUxITx/WDnT6PI/CKxPEL4+ZpGBvoCaiZXy9ac6GK1g2tAzEpc10GbIUFSIk
         5FJPhaQeVRjMYl9wgVP2gTdaO6TwexFO/FC928RyUeocq3nlfipEPZ9aN1f9jH18rNTb
         YlXQ==
X-Gm-Message-State: AOAM530Ko5AUUIsI3lr/Jxj7sN2V1Baw84v2+DspmQpyVPnzXtHIR/AP
        KIMk9cG5xSvCzhD58oE8VpA=
X-Google-Smtp-Source: ABdhPJxHKG4pthMt+MNY+hdbkELVj8YlDyK4VMdvEUXQSMkoAu35QzEJhRjq0PoXophR9tvA5hop3g==
X-Received: by 2002:a17:90a:1d05:: with SMTP id c5mr23105908pjd.175.1628301304856;
        Fri, 06 Aug 2021 18:55:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:7578:9c9b:8fe8:cece])
        by smtp.gmail.com with ESMTPSA id j15sm11708227pfh.194.2021.08.06.18.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 18:55:04 -0700 (PDT)
Date:   Fri, 6 Aug 2021 18:55:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
Message-ID: <YQ3n9Z2nH35429mC@google.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210520214703.27323-1-sorganov@gmail.com>
 <20210520214703.27323-11-sorganov@gmail.com>
 <YQtYEftByY8cNMml@google.com>
 <YQyUM2uZdFBX8G0r@google.com>
 <xmqqh7g2ij5q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7g2ij5q.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> I am somewhat puzzled.  What does "can imagine" exactly mean and
> justify this change?  A script author may imagine "git cat-file" can
> be expected to meow, but the command actually does not meow and end
> up disappointing the author, but that wouldn't justify a rename of
> "cat-file" to something else.

Sorry for the lack of clarity.  I was describing what leads a script
author to include "-m" in a place where it has no effect.

You might be inclined to wonder why it matters _why_ a script author
would do such a thing, if the script author is wrong.  To me, it
matters because it allows us to estimate how common it is for scripts
to use "-m" in this way.

The motivating example (Rust) shows that there is at least one script
that _did_ use "-m" in this way.  Rust has mitigation, but the above
logic leads me to believe that they are not the only project that will
be affected.  And more generally, when a script author has a
reasonable reason to believe something will work, they write scripts
where it _does_ work, and then an update breaks their script, I think
it's reasonable for them not to be happy.

Jonathan
