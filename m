Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7843C433E4
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 16:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F9420674
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 16:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="hL4xiuB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGXQAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGXQAt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 12:00:49 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32753C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 09:00:49 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id t7so4318493qvl.8
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T4B/1sXgS1JOKvEjSygoD8m3iAhIa/JB9zgUtWM3zgU=;
        b=hL4xiuB+HxtUYUAC5EU2IIoBplKoirsC1AF75LkGabvEjHHQgJL5B6I4NvLvFSOIqp
         FxG9z3WcWE9McVAvpbN5TMPMmOrFwThoXw3fE4jwbs/2XojjmISG2I1EpMIKO4cb+3or
         7nOq9/M4b9hG7tJr5jyj9fZYY1ooW9R6OAUVWp0elRHTf9nEkZI9Ps75z+rg17WXFWcV
         oN5eTbDs0u+aEGAPtU6mmHnGjkTZKSKKeNu1L5cnkRsAs+b3zTV9+M36UFUbC59ucr9d
         Rm//SYS3Jxky1gFH9RXjtppUf8NVxvN0w4iIgDrKR8anMw3c+RGeejSBnjazVgxGAMIk
         aH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T4B/1sXgS1JOKvEjSygoD8m3iAhIa/JB9zgUtWM3zgU=;
        b=PkWwq3HEoLc5vhhsgPOXhbOJj7VMz+qR660CGnhFu0lIUzyMaF25o875IVVah4s76B
         Ph/tnyJ9xuQUtXG6RRdAsSPEojlajMc8XsvD+IPi+/g1PrHGHNXaIlBCNZ0pqjvnN8cB
         D+npc044JvzVi1PXnHXYuBQItsHP5OlGX6Ve+6ffn3sftmagNTEA+7F4yE2PYbxjbm7h
         8nvFhUPYr+g4r0rXndPFxSrU4DqmKSZlbWTXq9G8nB0uKwWzmQWJtkMyiQ7BWgvRr4aT
         sJu4feFJGyrdpIV4ZJrmI2kSUuZjVfvruHvSwn2a2zg0IVzpHxO7ENp6nqJcbD80QU8K
         P6FQ==
X-Gm-Message-State: AOAM533HmUEzUFGyEoRh5A13DHdRZ+WSMsrcEYI/fZiWt0M+i0u+cp9U
        ch0njCrRae5zJzf8ixfOtLTl1w==
X-Google-Smtp-Source: ABdhPJwtDf+8CX+241tJUlGWr0qvRfcmw+CnOdp2maDUQHf2O3m5H1drn9lFqksx/mKp9WwHzhDvww==
X-Received: by 2002:a0c:ed2b:: with SMTP id u11mr10648991qvq.45.1595606447995;
        Fri, 24 Jul 2020 09:00:47 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e588:f326:57e3:7769])
        by smtp.gmail.com with ESMTPSA id r188sm1963549qkd.70.2020.07.24.09.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 09:00:47 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:00:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Tommaso Ercole <Tommaso.Ercole@qlik.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Creation of a branch named that has a directory prefix equal to
 the name of another branch fail.
Message-ID: <20200724160045.GA10590@syl.lan>
References: <DM5PR1801MB2076F807C0B9F29A152DBEB7F0760@DM5PR1801MB2076.namprd18.prod.outlook.com>
 <DM5PR1801MB20762477763E6298C7FE6315F0770@DM5PR1801MB2076.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR1801MB20762477763E6298C7FE6315F0770@DM5PR1801MB2076.namprd18.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tommaso,

On Fri, Jul 24, 2020 at 10:26:14AM +0000, Tommaso Ercole wrote:
> As per compiled bug report, creation of a branch that has a prefix that map to a folder, when that prefix is just an existing branch in the repo fails.
>
> I.E. 'a/b/c' when 'a/b' just exists.

This is a known limitation of loose references, since each reference is
stored in a file in $GITDIR/refs.

Reftable support within Git will lift this limitation. In the meantime,
if your references aren't updated you can store them as packed refs
which don't have this limitation, but note that they will be expanded
loose if you touch them again (i.e., this is a good solution for tags,
but not development branches).

Hope that this helps.

> Best regards,
> Tommaso Ercole
> Head Programmer
> Content Delivery

Thanks,
Taylor
