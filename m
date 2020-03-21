Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0556C43332
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 06:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A838620754
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 06:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="opBQKuzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgCUGMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 02:12:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42595 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgCUGMe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 02:12:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so4183301pgs.9
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 23:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KGQWfzZ6LxvCPy85bPhjnjzU/QZJT7xHRb9xYkAEp6s=;
        b=opBQKuzWjzXtM/z8HuDpocC8+BVlScQjqH9uBJtSZBtQ7JwzF8jVdD1fcxVkI53v52
         QN9snE4lbyyDvfSeL9EDbIOggZqxef3Rqo36r7+b+4QvNnTyX5JgXeKgKKIlGXl/vWSq
         g36jLPr6gg9tuHyXYDdNhjF/2hczMDDyJKdo+lN/wV1sG1C5IIndbiDND3Xn2KZFOrxp
         EUyiL9Qz7Wp+vqH3xq0+7K8RFMdu8OljAr0PSJ0pm5gdRvs9e8BTLONc5X/L5Vt2rgUs
         ub1Rxx9j7MNpugQDkXeGWcGprQvLtx5epu9/RfMjM9QgFjNB9Hw076pic/D5eWRX02sM
         eeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KGQWfzZ6LxvCPy85bPhjnjzU/QZJT7xHRb9xYkAEp6s=;
        b=VMcM//172xXfgr2fPrePDiRp5AEzaVt7xbsRJRhHq394uiFJ/+HtlV170iI3P0HEal
         BfoiM8L7G323oYDV6/pBmr7yOtkJi/N7pzBtlJcSW1YOhyEiPQ/6aBKWyaBFB7IsuBgY
         bmd7ltUiYkPWiONaehhKgF2bPnLVbMTwRXtEJNYb2fT8u2W7qjZpC/Bk1/tLIvrTJEMz
         bg+3b9pLPDtraBD1E95GZGFWXnVPqBIvc+TSMhm47KN331RCxU9OnnM0YlwQdCAqvyQy
         EKqrz/9/Vj42/TbnHXWtOjMx54I+P4bmCqwfZFYaXblgrR7a9t1ZTyvPEpjd0xZXbf3O
         +Npg==
X-Gm-Message-State: ANhLgQ2r9PVnXq14iAWVv4rbuXHFg/l4PJpHAQg20h+vaxCVWr3KYPhQ
        VTphKfL7M6BH3vCcxmCU0RXxW6gcfTc=
X-Google-Smtp-Source: ADFU+vsE+ZTnWYUSvXeQm2ODIzuQhCbDZFDw+vf1ar+qFC6t+SHhIvCF+jiRq0S7Z9CR6QgWbQ7cfQ==
X-Received: by 2002:a62:1c4c:: with SMTP id c73mr13060371pfc.64.1584771152418;
        Fri, 20 Mar 2020 23:12:32 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id u5sm7193980pfb.153.2020.03.20.23.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 23:12:31 -0700 (PDT)
Date:   Sat, 21 Mar 2020 00:12:31 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 0/1] commit-graph: avoid unnecessary tag deference when
 merging
Message-ID: <20200321061231.GB30636@syl.local>
References: <cover.1584762087.git.me@ttaylorr.com>
 <xmqqo8sq9uhb.fsf@gitster.c.googlers.com>
 <20200321050455.GB1438317@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200321050455.GB1438317@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 21, 2020 at 01:04:55AM -0400, Jeff King wrote:
> On Fri, Mar 20, 2020 at 09:56:16PM -0700, Junio C Hamano wrote:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > This patch avoids an unnecessary tag dereference in
> > > 'merge_commit_graph()', which can improve the running time of a
> > > commit-graph write by around ~7.4% on average.
> >
> > That I suspect depends heavily on what portion of your total
> > committishes consist of tags, no (in an absurdly extreme case, if
> > there is no tag in the repository, there won't be any improvement)?
> >
> > What tag-vs-commit ratio is the above "average" number based on?
>
> I think the point is that in this code path we've already identified the
> candidates as commits (because they were in an existing commit-graph
> file), so treating the items as a committishes in the first place is
> unnecessary. If an object isn't itself a commit, we should be dropping
> it from the proposed output (possibly we ought to give a warning in such
> a case, too, as it indicates the previous writer did something wrong).

Yes, exactly. Thank you.

> -Peff

Thanks,
Taylor
