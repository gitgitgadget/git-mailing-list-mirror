Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0107DC35249
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58722085B
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bO+dlHlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgBEDJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:09:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37775 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbgBEDJz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 22:09:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id z12so228798pgl.4
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 19:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yrtmH5WNG8KsmuOw0vqao1cQSO/m6J8ZraaJP81n3YE=;
        b=bO+dlHlFpoyFBWNDLibh9F4pK2LUlSADL/dyinlVp5TR3Du0V4n3zv/vQ1ZE2FpJ46
         +2E4f0vWnTaYxmFP1Ph2e4TM6GqusXKgCmxdgo6uWo+SSgKzhGZTywXtTX6+b2Blfljc
         WqsWtHJ94IP+Eg/iIbfuLaD/8x72j67NyT2Nd/jxeXn8sii9a4YHHLF0YLSRdIEmJWsl
         8LZ3KNP9OLzoD4Xg9bwIgrRBXp8NYIS5oJI0QG6dgoejAnbHZYbx5Lffd1XVn9RWIyrH
         g2toNrE3PzZHxyvtr9qKY40QvDNd5xLqUNqB2jbJk5jy2rKmvMdn5xFGiMc0KSJ5IUvS
         dlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yrtmH5WNG8KsmuOw0vqao1cQSO/m6J8ZraaJP81n3YE=;
        b=Y6qEY9WRmtIxWvzVBCo1SG8Ff/zGh10JfGk9j3wdL9WCTWChH+etq97SCz1D/uGqgR
         Tcsf5tc0gKqH6FcG7CckbRCn1IdRlr0XL6vi6xSRo/oK/T2VdLMoF2SoPZBsTCFfN/dy
         MWlQLDy43kzQiWV5D6QpPVhBryV2B9DDGp8KfZ8ApXMvDpwUHux6B0LKnN5pTnJ4Kzkd
         YjgYzL49cHj1ezP8O1pI5ZEbF4jhGIVP/gTNOLdqVOPbN13IPDOUxKnbhvO/lLOhPo6c
         Od0IC6nvC/ikaofWuCxXUrX7udPM3olIumIs+1gD+yVDiz2V+ki83VY6crYLUB1ahElr
         +Ohw==
X-Gm-Message-State: APjAAAXSAzkTtOg4UGxHdWK/6/X7A3VarSKRwCU3qtDh1OBU3YpB0gjG
        12RFtlEi6qI+fguOBhVqWiYzCw==
X-Google-Smtp-Source: APXvYqy6Rn97Agv6PlNTzCBMuCuy1wL5uWYpTqPkuAylkmFQhJ9fcgE6QgTRTG/tQB3VgRJVBnI7dw==
X-Received: by 2002:a65:5282:: with SMTP id y2mr34413979pgp.255.1580872194956;
        Tue, 04 Feb 2020 19:09:54 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id x25sm26612595pfp.30.2020.02.04.19.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 19:09:54 -0800 (PST)
Date:   Tue, 4 Feb 2020 19:09:49 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 13/15] bugreport: add packed object summary
Message-ID: <20200205030949.GP87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-14-emilyshaffer@google.com>
 <xmqq4kw6899e.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4kw6899e.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 11:03:57AM -0800, Junio C Hamano wrote:
> emilyshaffer@google.com writes:
> 
> > From: Emily Shaffer <emilyshaffer@google.com>
> >
> > Alongside the loose object counts, it can be useful to show the number
> > of packs and packed objects. This way we can check whether the repo has
> > an appropriate ratio of packed to loose objects to help determine
> > whether it's behaving correctly.
> 
> This step makes me wonder if we want to see the midx as well.
> Didn't we have a bug that manifests only when midx is (or is not) in
> use?
> 
> Similarly, I think use (or non-use) of the commit graph may also be
> a useful information for diagnosing.
> 

Sure. I'll look into both of these. Would you rather see them as add-ons
later, or do you want me to hold off on a v6 of this set until they're
ready?

 - Emily
