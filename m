Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94D3C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 15:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D38214D8
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 15:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzaPDCl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409170AbgDPPV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633481AbgDPPVu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 11:21:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5641C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 08:21:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k11so5325092wrp.5
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=22XnkXPbrc5+BJBUz6JAAcJRvvsYeldqK3wpHZDE/aU=;
        b=dzaPDCl7tyBAuKEyofS+pontz0AJTDM0G0NLvRe/AMrUbChndXiwcQy7lwrrmIGxcu
         s/iS/igtk5zGdXM1m7KvybH3Sq4COhBwj4zMXws7G2+u2w19G6yLq1/QtzGoiyXhuaFC
         9NS2cdiznX1KEeRGxphoyp4tXuF+i8R4mTnMAY1yyZuXRr+I25EfYX8zDyaLRQHjtoGx
         S4ELUWRDh13MtX3LRgUTdZCx4AR43TCGqFMM9eAQvPIe3V1q7JuT3bsAT49wiH/gjlrh
         rYbUeIjZJAaIqBB37kxLuqO38VWdmACs8f7ZhyARnm6YPPpuhf2Nzkn0onUYFlpHTMcU
         yNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22XnkXPbrc5+BJBUz6JAAcJRvvsYeldqK3wpHZDE/aU=;
        b=uKQiAjlk2OWnzdyjoc8fdEeVq/ZirDCNxMmUxWtjv9U3hGQF3+UTs4lFLSxLm1cTDP
         sVC0uRvQ9ZooFLpr5lPbhkCurPQSZZ4lWCO8GDmNtY0vhT2Gn7cmbjg7VRYriFHtuckQ
         wVmd3EXRXfVeUaEM8PZHqDgjrttRbqaCqKNQUa/nsYTJWqB3BlQ53Sj3lYQJPFfZmrfn
         dkO3ZWWEKc3ZnNmVNBC55E/emf1/IhLhEKreqSfmtQeakSnu/+1THBmV0B9zZ6s00Lob
         YwOToVMWFnYBYipE/Bg+j7YD6/6D7mxvQsIAGtRJ+L1QzRVqSbEWeMqxcoUWK1O8OLYb
         mgmQ==
X-Gm-Message-State: AGi0PuY8bW8Kh6ift1PIZVSSqd7RITBIkib/LXano4XfusHxtFiJX35X
        0bgNMkOkz8YyOgmBKMhtARAa7pEV4uA=
X-Google-Smtp-Source: APiQypL2tbnC76RVdGeNLUfkrN1bFX9at92QYP50Ps97ZVKTmnTXfvJYwXRZg9D/8enZQ645q46AOw==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr12644856wrr.299.1587050508108;
        Thu, 16 Apr 2020 08:21:48 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id o16sm28400095wrs.44.2020.04.16.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:21:47 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date:   Thu, 16 Apr 2020 17:21:45 +0200
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/1] remote.c: fix handling of %(push:remoteref)
Message-ID: <20200416152145.wp2zeibxmuyas6y6@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Thu, 16 Apr 2020 17:16:50 +0200
References: <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
 <20200416150355.635436-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416150355.635436-1-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So this patch does not solve:
- the memory leak mentioned by Jeff in https://public-inbox.org/git/20200328131553.GA643242@coredump.intra.peff.net/
- the non correct result in a triangular workflow mentioned in
  https://public-inbox.org/git/20200406175648.25737-1-damien.olivier.robert+git@gmail.com/
  (aka v6, with an incomplete fix)
- the code duplication between branch_get_push_remoteref and remote_get_1
  (see my answer to Jeff's code mentioned above as to why his approach
  would give a micro regression).

Luckily I have figured how to solve 2) and 3). Unfortunately I haven't have
time to work on this since two weeks, so I have just sent the original bug
fix first so at least this one gets fixed.

This is exactly as v4, except I moved the tests around to make them easier
to grok.
