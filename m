Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A6DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 20:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D4061157
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 20:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349654AbhIHUqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 16:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhIHUqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 16:46:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5397EC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 13:45:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y17so2994063pfl.13
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGkUxlpr6HNkAiqVo9XtLQP8Tq6ipl7vPQD95hKyv+M=;
        b=ilcKkn9FnnsJH51BfFEqvHY9Osgj56YwsoVoBJqtj4/q8EjUx6dIVPCetnkMBxfncs
         vEX4BWV1+USkWI69NALxrAX+Lj5bUTByM/IPlzATzF6d/KCOP2NnSowC15w97fF4UH98
         O3cUmUdPTY4e92Oazdi1zTOs/8UUgtZ9MLe/eg7aOTrub9NmdX8t3Ym1jFdV3ezFLJas
         DtSWLhPstvL4zI3KINW1yDt+TK7OoWRIJKH1LngdSj+UHfs/vdJLlcha6YleLfEyzqrq
         9vyhGQxHbCs4FzHfNTWymvKyW2mx8lVEpMA2e+AaG80AMyPo3+oemjkuFO+zkFGC8zEw
         Rf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=wGkUxlpr6HNkAiqVo9XtLQP8Tq6ipl7vPQD95hKyv+M=;
        b=3fIkSmBmkvNzxXFlHYsVXU8kT1m/3oqNzrGTOtUE/9S6xKFfF6GJ+gX05HO+EZIQya
         AdUUsvJHDUgcnKEXH8jMhmzjF8hMyi3oan7h6edOlfUzejyyb95qLM+5cI9uMa1KDcB7
         5OnC6nzZbUy3A7RxxzEFiG1ZfYHIuCxp7+mxoA+yserhSt1PET229JfYcZY/T2qDnqlb
         jOpQsEbZJ7RDQUj58zcnJ2o7VX7ft+CQkthTe8IMZKGflRG9+xBM1TH+qXRAcaWsbwPJ
         JQBQ69ckdgVX3IiTwq5yaUdG+M5F1fxssa5P1pUFSqyyI3wf+SAA83Psv37xs05a5Q//
         g2Nw==
X-Gm-Message-State: AOAM533Q2RZ2j6O0HVJ0PtHXffbAP2BmnDLjFfJqCnQp9Z31PZdXYkf3
        uJJfmuEWP0ytOMeGCw0m+NcJbZRnReSlow==
X-Google-Smtp-Source: ABdhPJzgQQWakwDJ6r7t8icEn/FhXC0EeN4BybNkcwOpmiXzxQef6ITINc2PZi2sByUwYWImSWTa1w==
X-Received: by 2002:a63:af18:: with SMTP id w24mr21258pge.471.1631133904158;
        Wed, 08 Sep 2021 13:45:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:f01f:16dd:49c0:66ce])
        by smtp.gmail.com with ESMTPSA id c15sm86093pfl.181.2021.09.08.13.45.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 13:45:03 -0700 (PDT)
Date:   Wed, 8 Sep 2021 13:44:57 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Subject: Re: [RFC PATCH] branch: add "inherit" option for
 branch.autoSetupMerge
Message-ID: <YTkgyQLtYZp1L5JE@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually, this patch probably makes zero sense without [1], an old RFC
patch to use a more repo-like workflow that we've been using internally
at $job. Hopefully I can get a v2 that doesn't depend on this.

[1]: https://lore.kernel.org/git/20180927221603.148025-1-sbeller@google.com/
