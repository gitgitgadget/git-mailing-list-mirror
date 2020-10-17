Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B3DC433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 15:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7553920708
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 15:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRoVmL6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438503AbgJQPOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 11:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438500AbgJQPOC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 11:14:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10429C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 08:14:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a17so2927648pju.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 08:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kS7ZvxstqjT57/MofUs5mdyiATW3HcxB72uKq+eGlrA=;
        b=sRoVmL6qmlHCqA1obGUlKHrjcKzEFrQg1d8VCg8QYuq0ol9hh5mUaKZoNfQrtlJU8o
         jV+UtV0/AdnIi0QKIJEqem1ZKYTk+01XzMga9HyWHKqNA8hfmK0NiWxxFlSPtiAYX2G2
         bbDe61UH+MC+fGxGsejXraoFjpC3T4oclm/geE7KnH4PkkBkBBYfU/fA1/y+fHLACFqC
         mhv2OQq3IS9NqWPe0jtcUNBPMTFAblnXkEqxiIu22nbTdBjSy19TSkck7kQFeSHFBCcH
         NPrcAy9lm/TxODIAo6UKi6e346xRHQZmsMyIwqabvQQt+CAapcCU2a0BfkxVMAkU5nv0
         CIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kS7ZvxstqjT57/MofUs5mdyiATW3HcxB72uKq+eGlrA=;
        b=PNGRnIpptQozFkxahwhD7oq7r3+mF8JGze4V4dsIzigMZnsSkfJ15tXFNsko+GBPjb
         3FedGPVi2KvnZhlhcfeAGpLwpm/rn+fqRplC7Va0UPLNQO1xCqirb2xidjQMyMSFpMG1
         IGBfbYu+z3WVGuOm0WadySeVdrj91N/ELWxeVkaxof6OLhvDqiY8eLAOAcrChptkIa5J
         qEMNn9vOzl+yB29Wa7am4oIuXKPOKvk6H1U8bWw/B5y4g8587df4p3QdHNilOlktSdg5
         Vz6kJ5MpYOwN79MM5lUKcA22YT7QKvyvtKpvQkAUJ8roN0EbCbvSYXsArAQWIyBXhFj7
         7LkA==
X-Gm-Message-State: AOAM531ZnPiIqCbgF94a+J6KLPpR1MV7p7GdloFR6X4qsa9hqFT0FmXZ
        3pkgrhsWoxyPt4O52cDsbSmt9oimF6w=
X-Google-Smtp-Source: ABdhPJzOrGMBPmyAMj+4U+JuA379FjFkHRHrCZt2kToSWpxktDMyya1N9eyus9KLLsr4Zv4xqjwYNg==
X-Received: by 2002:a17:90b:50a:: with SMTP id r10mr9235560pjz.231.1602947641529;
        Sat, 17 Oct 2020 08:14:01 -0700 (PDT)
Received: from localhost ([2402:800:63a8:e735:e424:e5d:450a:d98e])
        by smtp.gmail.com with ESMTPSA id e19sm6137115pff.34.2020.10.17.08.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 08:14:00 -0700 (PDT)
Date:   Sat, 17 Oct 2020 22:13:58 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v2 2/5][Outreachy] t7102,t7201: remove unnecessary blank
 spaces in test body
Message-ID: <20201017151358.GA2837@danh.dev>
References: <20201015175709.20121-1-charvi077@gmail.com>
 <20201017075455.9660-1-charvi077@gmail.com>
 <20201017075455.9660-3-charvi077@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017075455.9660-3-charvi077@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-10-17 13:24:52+0530, Charvi Mendiratta <charvi077@gmail.com> wrote:

Welcome to the list.

> Some tests use a deprecated style in which there are unnecessary blank lines after the opening quote of the test body and before the closing quote. So we should remove these unnecessary blank lines.

In Git project, we wrap the commit message's body to 72 columns per
line (for more information, please take a look at
Documentation/MyFirstContribution.txt).

And we rarely say "we should", if the change shouldn't be applied,
it won't be applied.
Instead, we ask the code base to fix itself. Perhaps:

	t7102 and t7201 still follow the old style of having blank
	lines around test body, which is not consistence with our
	current practice.

	Let's remove those unnecessary blank lines.

Thanks,
-- 
Danh
