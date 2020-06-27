Return-Path: <SRS0=mvrS=AI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14511C433E0
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 15:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09DD20702
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW2qygoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgF0P4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0P4O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jun 2020 11:56:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144F3C061794
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 08:56:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n24so12162968ejd.0
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=As1rd1D2K9ORPxZsjejoYq00a78FUYW4A0+dLwJl+JU=;
        b=WW2qygoPXhx0GdMqrBrg8jISxsXtBRio9q4TTxeUSaCxA/25eWArluJnuYlYWtGgpa
         KhajmchE8K1orR02zBTRVNDwI1WnfD7f2Li1PlUbBDrZ/v5VrwVuhRpQCft12EUL4Chl
         HC/HhEkTMBmagNq/c5XtmW0GcHXfcqz+7l7PtE3sYEGC5BdBRbQHs8XJuFOsAXKNOYjB
         uVF6E1QPEYxpsFaVeCtCZV+aERy2wL76FDaDfa5sZMjWhC1NNZxqrV2bd9Eu4FN37h8t
         s2ORk+YzJoZvjYv97V1/yzLTQ5TUlR/leRgERhb04RPe+ljwzIFDUC8Ry1VpE/kA0tTr
         HVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=As1rd1D2K9ORPxZsjejoYq00a78FUYW4A0+dLwJl+JU=;
        b=a8OIaurjCHLPwRdumA50NXUtWXBW6cGV8L4eeS4B1D/g5CY2NTyVjBCmoZ3Da2KxjX
         TNnG+mlaYY5WLNCMjtde+MPn/xX8ubSLN1b+A/uQEw71o1cclBAFzVqTjE+xoxWEz+we
         jQV9rTnsc/i8IHbUDzKuNsjd/EGjQNI6MsXg7fmRHKrGJS33If+UjHLVaUGRZkHEpFUP
         lTfOuIPOhf+8QCn8duMl9VTqPe+Pn70ZyfWGRr4+yCBNv2wpGheYDX1igRIKwjuhNxkr
         xXtLU+dJHkJ619AnaflIi0ZJkSUpztfaRuBhi+aveUSCrurcn090QirnFcnGM+Gwz9f5
         KEpQ==
X-Gm-Message-State: AOAM533cSAe3c0j2N37I1lIXxJTXUWHUNUjn2kMfN6aZD0ytIabHEJT9
        GpdChmZ10y/85PcMaiIDzGUdrS/4
X-Google-Smtp-Source: ABdhPJxOSJgs3fbNET5/Ec28kd64SuaxnwcJLdwnX1KCHgQXmmPIDB6RTNzAY27qWHL6W/iDp0zC4g==
X-Received: by 2002:a17:906:90c1:: with SMTP id v1mr7015793ejw.481.1593273372582;
        Sat, 27 Jun 2020 08:56:12 -0700 (PDT)
Received: from szeder.dev (92-249-246-85.pool.digikabel.hu. [92.249.246.85])
        by smtp.gmail.com with ESMTPSA id s24sm4601855ejv.110.2020.06.27.08.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2020 08:56:12 -0700 (PDT)
Date:   Sat, 27 Jun 2020 17:56:10 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 04/34] commit-slab: add a function to deep free entries
 on the slab
Message-ID: <20200627155610.GN2898@szeder.dev>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
 <20200529085038.26008-5-szeder.dev@gmail.com>
 <8030939b-44fe-e251-5b76-2b2f260b980f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8030939b-44fe-e251-5b76-2b2f260b980f@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 04, 2020 at 12:43:32PM -0400, Derrick Stolee wrote:
> On 5/29/2020 4:50 AM, SZEDER Gábor wrote:
> > +void free_depth_in_slab(int **ptr)
> 
> This needs to be "static" to compile with DEVELOPER=1.

You are right, of course, but...

Do you get an error because of this when building with DEVELOPER=1?  I
don't get an error when building with DEVELOPER=1...

> (I'm working to apply your patches on top of ds/line-log-on-bloom
> so we can get the benefit of these universally-good things. I just
> want to report the things that I stumble on.)

Thanks.

