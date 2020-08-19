Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8332DC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0AC204EC
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 13:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtH8V+mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgHSNhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgHSNfb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 09:35:31 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C2BC061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 06:35:31 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m20so18124545eds.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DIO05+R3utiw8wHh5DnISr/TM2AW5irZvvsIYZdqe2M=;
        b=FtH8V+moZb2tFgeQMxXRnq6qFjAcSZLy/9h2RHNTAeAE7K8XhdecwsjdAqYWx4I6pS
         0RTMuOQegU/uVEbGxNWFpldkJ+FWSUYp/L9DxTv0qTbq1CY24yq+rhxH4LBp4KnoEi9c
         E115WOoDqqA8GU4Zkh/mtUIYBZasDgw+mNtyMHmTPLtZt5mwnhkObuZW1D97TEOhjPOK
         1K8epeQF3hVU2FSu/a4WwyK8VCyozqmRL0hBUOhrqxE7+voEBnB2WTfEkEfWmDL0kOvc
         RvE2/w6UeP+BzrHUtOFAOTKPW5//8YE7wVvQRpMfZgOJamhjLksaQayMa4HdEv2Cv5wC
         jq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DIO05+R3utiw8wHh5DnISr/TM2AW5irZvvsIYZdqe2M=;
        b=F/5+N8FyqoV21SbU27oro3DBSJuJ54XJTzThQRl8SAAFHsL05t+L1JcXKpAbUUwAId
         W9gvKX6+uCnl/JnXfuz8NFuDLDi6A6U2VzAEO6H9aeTHgJPLfi6KMmCLvHujWgmIBuVq
         3P0bAJolGIMoNJyb85Jd+CHVdRa5bzhhVUMN3KPXBbHMvqiZedZvqD4iHODEIRUmZNsS
         gHIk7uLu8VYp/ftxvlEdR6bQDAz/9oNtZNQ4AbXL4wuueS3OLQAzRfEjED5yuYu07Q2F
         dBn3aOCSsDe2eJCk7lvUbNN6edBzNyLv99OnSQO/p/ZKIFx+UVN+V65p2X0bSolQQtIW
         kXSQ==
X-Gm-Message-State: AOAM533WOw8aUI5mGAgQOVI1wc1G1FaBgSVxhqGA/IgokIr8j2JycwYk
        +utpRQCr0A77LZDVSmqMHq4=
X-Google-Smtp-Source: ABdhPJwjH0TX0pie8BjztxrFlL69Q4/4xDHILfihPF8o1w3Np36Pje2xgu6fVWoTkye5oD61b8/png==
X-Received: by 2002:a05:6402:84e:: with SMTP id b14mr24108922edz.115.1597844129787;
        Wed, 19 Aug 2020 06:35:29 -0700 (PDT)
Received: from szeder.dev (84-236-109-47.pool.digikabel.hu. [84.236.109.47])
        by smtp.gmail.com with ESMTPSA id s16sm18848667ejr.31.2020.08.19.06.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2020 06:35:28 -0700 (PDT)
Date:   Wed, 19 Aug 2020 15:35:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 12/14] commit-graph: add large-filters bitmap chunk
Message-ID: <20200819133526.GE29528@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <619e0c619dd12e2bea2b80c7d249ba66fe2a315c.1597178915.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <619e0c619dd12e2bea2b80c7d249ba66fe2a315c.1597178915.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 04:52:07PM -0400, Taylor Blau wrote:
> When a commit has more than a certain number of changed paths (commonly
> 512), the commit-graph machinery represents it as a zero-length filter.
> This is done since having many entries in the Bloom filter has
> undesirable effects on the false positivity rate.

This is not the case, the false positive probability depends on the
ratio of the Bloom filter's size and the number of elements it
contains, and we size the filters proportional to the number of
elements they contain, so the number of elements shouldn't affect the 
false positive rate.

On the contrary, it's the small filters, up to around 30-35 bytes, 
that tend to have larger than expected false positive rate when using
double hashing.

