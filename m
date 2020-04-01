Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F199C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 18:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173C820784
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 18:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="v2maqImX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbgDAS4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:56:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46554 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDAS4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 14:56:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id s23so295899plq.13
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IAUcDbgLiiXHDmZdgROGVp1DoOyTa+qbOnU8SqaofAI=;
        b=v2maqImX4RPnS39FRPDvS4dXtD04RJn0TLAM46jJH0ztVqJqvhrsIXbxuFloE4PN69
         TkZ/joFJD3mycd7pJhPZknX1FE0kFUq9QW2AuG09SzrlUMtb7NgeHyjbNp/SLnUaUoM5
         sq0PyKzgksfd/xwp0juJxTfPmmdHv6uN0L2hhAPt/IQPJ1dPuW+CJVGQuqdlJIg93vRa
         JZfxqVvheRysri9QntoFq1yWR2hg33FcbId5CHN4/WxcsfnGSAxP6VhVkPlcRqyfteqB
         iLVOBMy18DxjgBZ1VNE+47tXqQsKJi7IdG0crMP0wy03lolFpYbPnFcdVPP/scT2etni
         k/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IAUcDbgLiiXHDmZdgROGVp1DoOyTa+qbOnU8SqaofAI=;
        b=hIXan+Yu5xPmJa8hBBbBzIC/6cLPB2iLIG8lSpTJLtARNaeH3ourbyc58/M9AsEyR/
         WETMQo0ezQijqsl2RBN5X6SQnoYOCXurrp+KxVN+EkRJPDz4qe55xSoDt6+6UVNRzt6a
         WVH1kskKWt50ClmgKhelbvjgkcQMHcfZUOxKYSCe6wX8xR7ZFK62l9oezf7ivY+ksfni
         mrUCq6jvVGGeObjpmFDyEC8WN6Rp0LvwN82MRJVhaCD1McbWXqcvNcWP2gcRhRuTF0hT
         Yp9nJ7vhze94Dz03dHWL0FoOycw38bpXqPzaizfVVz+uIGSpFUw8J4KLBaQ8cbPHuBNo
         g8Hw==
X-Gm-Message-State: AGi0PuZYD6aM4yDzx2UiEtXdbyRkbA9TaIgCrl/zFtVgfE/fmTOTsPIK
        re+iECWzMi7mzaKNqUVPYV4PVA==
X-Google-Smtp-Source: APiQypKsCgIqmtscHuw3mz3ICpPuBfKazdS37NwzASRsCD6tRcJ4vmz6d9rwHd3iDJdLQs8tr1458A==
X-Received: by 2002:a17:90b:110f:: with SMTP id gi15mr6395366pjb.184.1585767391703;
        Wed, 01 Apr 2020 11:56:31 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h198sm2086304pfe.76.2020.04.01.11.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 11:56:30 -0700 (PDT)
Date:   Wed, 1 Apr 2020 12:56:29 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-graph: fix buggy --expire-time option
Message-ID: <20200401185629.GA13599@syl.local>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
 <bbd2b8e4-47f5-a99e-fb14-b6c1ce2ad9a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbd2b8e4-47f5-a99e-fb14-b6c1ce2ad9a9@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 01, 2020 at 02:17:50PM -0400, Derrick Stolee wrote:
> On 4/1/2020 2:11 PM, Derrick Stolee via GitGitGadget wrote:
> > Also I noticed that the help text was copied from the --max-commits
> > option. Fix that help text.
> ...
> > diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> > index 4a70b33fb5f..8000ff0d2ee 100644
> > --- a/builtin/commit-graph.c
> > +++ b/builtin/commit-graph.c
> > @@ -140,7 +140,7 @@ static int graph_write(int argc, const char **argv)
> >  		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
> >  			N_("maximum ratio between two levels of a split commit-graph")),
> >  		OPT_EXPIRY_DATE(0, "expire-time", &split_opts.expire_time,
> > -			N_("maximum number of commits in a non-base split commit-graph")),
> > +			N_("do not expire files newer than a number of seconds before now")),
>
> and of course I messed this up even now.  Should be:
>
> > +			N_("do not expire files newer than a given date-time")),

I wonder if the double-negative can be avoided. Perhaps this should be
instead:

  expire files older than the given date-time

or similar.

> -Stolee

Thanks,
Taylor
