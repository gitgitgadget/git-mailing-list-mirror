Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F36C433E3
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A0720888
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4Fhapmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHSRfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgHSRfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:35:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10F0C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:35:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x10so26259784ybj.19
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TtJmOIt6JjCGaxfj1BAx04w7DGpJx5iHVWpvusgoegk=;
        b=T4FhapmpSXrZBeCVv8Ht7Ago98SWpyE9LlISwQhuoyDkCKCJhKJ7+qw2ynTm+q3qL5
         qvsPsnD2R1C7AagSOnEH9OMzJ9MJ6iQF1HBO7Mzfs79tCeofjh9/lN5Iou9OAyteetaA
         MQpLHaXpv35AApxepbyhbHG+7y63eA7tWnZAYOtCvlgan/OpGoHtCyyvxt9ZWHmtYLip
         G1R9pKiVh7JaP9WehCSPJV50WF6y3aor+nAsU1nELh4o+Vkq4gQsuXTtIn1eIcsRKACy
         WuFdAizLAt9jjYsJMkQIPVHLWdaphT1dKqloiO3u+n0byXB3ssE2vWhBt4PkohS2PApK
         MrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TtJmOIt6JjCGaxfj1BAx04w7DGpJx5iHVWpvusgoegk=;
        b=WK0bELLCwSGzd9Q76Z5eGfWJGUXZttg+luio4w7KB/feVkUaXfa6FrXxARYA6iOtCR
         bDnSv3atdNqEej7jAi9SO25nACJliI65OXxUR1HnZe5aD39LsU8v7dVikzthSmFG/5of
         pCDS0Ra9m2ImS9M5uy8iIUCvZgOuDYcWohHOxwPJivljwhRvCRw62mOnORIy9a/s2vKA
         jEer7Xh4hui4Gd+P4OtVaC18SmQ2tZ+lNCOsbyvWwassnEQ3iJ+dMN8eP4BS7fNUQ3kH
         +LRcW4+Vx7tkkFPaLZ7rZmaLDO8xQrRA/ehbuZXGNPptGmJrr8ZzgGath8bdqDtSRbT1
         sosg==
X-Gm-Message-State: AOAM531ocuBacjPjnziPC1kkJUHsiaiytEtYoZjLHTx9cby3RWb6+l7W
        6Fmx4C1qM1B1QLhJKzOD3s1uL/z8UsdXtHx6m4J9
X-Google-Smtp-Source: ABdhPJyn1O/2uTWlDTo+GY/5e8iOt2dNgs7xJHvkkgRTUURFtsnmYtOWFAuNkafehIp6n45zK2LK/asDhwkwLUA8MVrb
X-Received: by 2002:a25:fc22:: with SMTP id v34mr34400796ybd.393.1597858550065;
 Wed, 19 Aug 2020 10:35:50 -0700 (PDT)
Date:   Wed, 19 Aug 2020 10:35:47 -0700
In-Reply-To: <3a5328c0-15f0-a427-1f21-2c8e3ef8277a@gmail.com>
Message-Id: <20200819173547.3084636-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <3a5328c0-15f0-a427-1f21-2c8e3ef8277a@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: Re: [PATCH v2 06/11] maintenance: add --task option
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        gitgitgadget@gmail.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, derrickstolee@github.com, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 8/18/2020 8:36 PM, Junio C Hamano wrote:
> > Jonathan Tan <jonathantanmy@google.com> writes:
> > 
> >>> @@ -66,6 +68,10 @@ OPTIONS
> >>>  --quiet::
> >>>  	Do not report progress or other information over `stderr`.
> >>>  
> >>> +--task=<task>::
> >>> +	If this option is specified one or more times, then only run the
> >>> +	specified tasks in the specified order.
> >>
> >> We should list the accepted tasks somewhere but maybe this can wait
> >> until after part 2.
> 
> It's hard to see from the patch-context, but there is a section titled
> "TASKS" that lists the 'gc' and 'commit-graph' tasks from the earlier
> patches. Would a reference to that section be helpful?
> 
> 	See the TASKS section for the list of available tasks.

Ah, I missed that. What you have now is fine then, but a reference might
be helpful if this man page ever grows.
