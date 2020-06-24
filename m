Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0A5C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 17:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51C22078D
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 17:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggp+FcS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405449AbgFXRY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405318AbgFXRY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 13:24:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B0FC061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 10:24:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id k18so2575942qke.4
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PH2fFmGx45KN/sgdfoLNyA17vlYLrQc5/YJ6008nF0M=;
        b=ggp+FcS4DkBaMzRBtalemdIvmBKKITHacYVYj1g27kv+gcnEW5Ak1+Ph1sh3fOembI
         Nej+fus6aGPyo/j0ISJp0xm86UY4M5iOxawhzt/xrujjq1membmeO7SnVJKjaSBUp15c
         sLv/Umv/AJQk7GJUOJn/6dst4mw/UqZtNF5EfiT4KARBPMDJOecL9fGjnEHlwki/aMRN
         XyYVr1ehur7wof6k0SCAeqMPm5qnEr5DpALYHYycWU9X+7Ow5U5HmD9WbTLhGabiXoDW
         VAL5XgLoNyLsIoFgjufpT/bX9W0kNP6/kI5g2KRk+TMFxAbBz6cKJtqZ6bbDPMndzSQ/
         3AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PH2fFmGx45KN/sgdfoLNyA17vlYLrQc5/YJ6008nF0M=;
        b=JvlcF+gZlrG/kFaWat/99PQg+H0ek9pQ8YStbIkI7Qm6eDbMj2hQ/EZtI5PjE9z0mo
         eAw6isI5S8JBWi6fwy5vS8oa15Au9Xl5xxhNZ9UBUu9sYCyfL+P9620RhUL+ONmfdiF9
         HoR94TP6YCy9MKS0+lpeb0taF/MIQsZyrpN/IepFXXTF5Fn5B+a06ntVsWPpEwl8GrOh
         +tBoH1syx9Hy15TozAfNLWy3IFkKTkS/W/ANjG33DqjwdfCNe1zPFM8MoYsst5wgjHnI
         gAgaGh/Qv60YDllTbeyqicDuVUX8DzJAgPwHT4bJZ4OY3foObYQnVynZIaiJ68MdQzDZ
         oRug==
X-Gm-Message-State: AOAM532DAIj6br61vv4lBJGWVSbhvgVhHifd/Ddfc87EQmyH+4s9Gniq
        WoncZltNGKoVjzpimS5GHkE=
X-Google-Smtp-Source: ABdhPJx711nW5kuieRKmazupC17vmxZmwn5ta76mYA1llWq+KFoBX95LGDwbWHWrGLWVzxb+o8BjAQ==
X-Received: by 2002:a37:dcc:: with SMTP id 195mr25647460qkn.251.1593019467893;
        Wed, 24 Jun 2020 10:24:27 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id m57sm4457874qtk.19.2020.06.24.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:24:27 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:24:25 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Accommodate for pu having been renamed to seen
Message-ID: <20200624172425.GA152115@generichostname>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
 <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
 <xmqqtuz08ofa.fsf@gitster.c.googlers.com>
 <xmqqd05o75so.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd05o75so.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 24, 2020 at 10:05:43AM -0700, Junio C Hamano wrote:
> I do not know how many of you regularly have interacted with 'pu'
> and now need to go through the same adjustment as I do.  Sorry for
> using you as a guinea pig for an experiment for you know what to
> gauge the cost.

Heh, I was wondering if you had any ulterior motives ;)

Since we're on the topic of the cost of renaming branches, I was reading
a reply from you back in 2011 about how HEAD symrefs are the only valid
ones[0]. I'm not sure if the situation has changed since then but
perhaps we could officially expand the scope of symrefs to allow users
to essentially alias branches? It might reduce the cost of performing
branch renames by having a backwards compatible option.

[0]: https://lore.kernel.org/git/7vsjvpq0jk.fsf@alter.siamese.dyndns.org/
