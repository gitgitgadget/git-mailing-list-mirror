Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D59C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 07:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1AA207ED
	for <git@archiver.kernel.org>; Wed, 20 May 2020 07:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6Fqc5RU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgETHz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 03:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETHz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 03:55:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA6FC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 00:55:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d10so1065211pgn.4
        for <git@vger.kernel.org>; Wed, 20 May 2020 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/pJmK+O6ROVj4s7ndS7G+mQ5Ks/vgkYIiDJBpeL0ff0=;
        b=w6Fqc5RUEXUV2gSxof7w6N67mrIBP7dEAcmoR1w9p9j1cXZw+Dd7Qe0kP8VDYqkvXK
         gqVsBQAgODSjvKSC+pt5r1FW/CHCxHQNGu8Xb+9MGKJOxN/MbP/mx2Qb0CdNq4F8KpQp
         MLmhb1Xk0MwjsixiwPCDBgJb3xl7Yjjh5mN8K1MlyTLGZFggKUeg46wmEsCwNvN61lfA
         0xIMDgf6t8SipFl2kHt7a/opNAmi2MiFC4xtU49lQ+noZS6njIM7Jp//7jK+GEdogA2P
         ZzQgx9obIWD2L4ALEI48FeIoe4KLAoHiEO7UPKzZUcAa6UIw3NwkHsb21N8nOQ9NBBIQ
         zuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/pJmK+O6ROVj4s7ndS7G+mQ5Ks/vgkYIiDJBpeL0ff0=;
        b=WId4r6fSOuUTCZPiMpjff7Pt/QMSdCDpzFG1Ii9uop42YlauD9MuHUsECVZSSKyVAc
         QaaNtwWyEmASaiYgpHsn2ZZshzxNaq/8ALiri9mianbfhgVFD5npAC6X9CxddyZJGEST
         wHXP4lCX9D7yS6OrWoBWR3XbZuE++7S2iG+OSldTsjEClsTCg0tjLMINdSEaKNrizm4V
         K1bQ3L+33IWTvTpElJdeW9CY18RyqcYcqHVSXTOPEGVfIZOQt+/ZNR0+ZypOLT736dIq
         myfWupdnXlSRzafN8AxmiarybuUfYz6SoPq47unB3Km+ANrfq/kL7NHFvs/TBQ3g6HyL
         xZpA==
X-Gm-Message-State: AOAM533kVKN9BCbNQHPTy/lbAB5cNG/SMySE8lUomR4mpyRGWNmXms0Z
        ZUUnrOwO0I8lLgfHlYHeoGz5
X-Google-Smtp-Source: ABdhPJzRmkifkHMLualmWHNu7RrfLqoam8frQTSzmQcZG6pKy4ae+CjDqwD5hLoxFhW+PxS064rZiw==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr2910361pgf.140.1589961356846;
        Wed, 20 May 2020 00:55:56 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:dd0a:7c30:1f7e:ebdb:aa2a])
        by smtp.gmail.com with ESMTPSA id w26sm196429pfj.20.2020.05.20.00.55.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 00:55:56 -0700 (PDT)
Date:   Wed, 20 May 2020 13:25:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: git-send-email: Ability to populate CC using more tags
Message-ID: <20200520075551.GA3155@Mani-XPS-13-9360>
References: <20200519184041.GB4397@Mani-XPS-13-9360>
 <f723cce2bcbccbfdf6ebc80d1e68ba4fe10c2aee.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f723cce2bcbccbfdf6ebc80d1e68ba4fe10c2aee.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 19, 2020 at 12:06:45PM -0700, Joe Perches wrote:
> On Wed, 2020-05-20 at 00:10 +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > Currently 'git-send-email' lacks the ability to CC people described using
> > tags such as Acked-by and Reported-by etc...
> > 
> > While doing a bit of googling, I found a patch from Joe [1] but that doesn't
> > look like made its way. And in that discussion I didn't see any real objections
> > for the patch intention apart from the usage of the term 'trailers'.
> > 
> > So I'm just curious if Joe or anyone has plan to resubmit it! If not I may
> > do that.
> > 
> > PS: 'bylines' as mentioned by Joe seems reasonable to me.
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://lkml.org/lkml/2016/8/30/650
> 
> You need to use the "--misc-by" option.
> 
> Perhaps you need to update your git version
> as that was added with:
> 
> commit ef0cc1df90f6b6c2987ab2db8e0ccf2cfc421edf
> Author: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> Date:   Tue Oct 16 09:39:23 2018 +0200
> 
> send-email: also pick up cc addresses from -by trailers
> 

Ah, yes. This does the job :) I didn't notice this earlier.

Thanks,
Mani

> 
