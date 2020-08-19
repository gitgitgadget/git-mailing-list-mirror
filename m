Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB5CC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 08:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD38A205CB
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 08:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVir0MSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHSIUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSIUa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 04:20:30 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF68C061389
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 01:20:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so25290519ejb.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 01:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RICZdjaX/Hzsn2E66zQz81RK5aDtkSLcoLG8PWpq4xM=;
        b=LVir0MSOW1UcdqS6pyTvvJAS9uk95iSfwVc6mzcsBWvQW1tKurOK6ltwR9P5DOpWGH
         xyqpifNBFvZ2/IEDzk6e8LSoUCa5Y1hGp5iO2lAxXDWEv1bTz0wDEsYRzABlw5xiAz1Y
         hFIQQZhjjQjT6YyK8N8CRJrO820EJdf43oqWRM+ynPFcpdORvOObdCb8aPMow2FSwUnz
         rBJZYl960Ic9UVtKBb5+dkza9lKnGufiEr7ZDqz4goMJ0zPotzy4TtM15HbFt64yq26u
         qz5esk/74qg3UF9orlWyXiLZ58JxPBNBgKcuT59QiZ3EHrULILdb4NmGkU7bKQvBk4AQ
         B/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RICZdjaX/Hzsn2E66zQz81RK5aDtkSLcoLG8PWpq4xM=;
        b=H7IQH1TuvuscqcAlpSWWqvHny67zpd6/rskW74dX7PU8SZMSx56qOm7lPFAPRRGOWS
         xs3m6iK3P1/169pVN7UyKahvFJuPghwmuWpecQcpgt8vUGitJNk+m0EGZdk0Ln2kwMnq
         Kwx21tm1uamuuI9yg0rLf7IvcMB3mgyb0iiWkM2Y7XjnJkQ+g7ZvP9zySurzPKKRm0YN
         yuxJiQDPCJ/qsHnhjC9kSkim/1AOgnu7b6KzP9B/I72P6frTwlZcBqlHkCMcoXVHGeti
         M5o5dfSmmXhes+sL0zVod82Kn4Z9GjhF2TM8pxbALA9di0sMpT/qSB9GQiwqbMObk6Ek
         eGDA==
X-Gm-Message-State: AOAM530h1PgTv/v9Mnc4ANc6d8YNHrUIlgPor79tZWQX33EbqgyS6DRo
        Wiy37dqywAULz54WaDttRMQ=
X-Google-Smtp-Source: ABdhPJwfDJDwUfCYixIg2slhbw/oMMr8opkIZJaW3hxjfz0irv4fo7iD/3Z3VA6+sk5l2d8RApg6HA==
X-Received: by 2002:a17:906:cc4a:: with SMTP id mm10mr3037162ejb.451.1597825227748;
        Wed, 19 Aug 2020 01:20:27 -0700 (PDT)
Received: from szeder.dev (84-236-109-47.pool.digikabel.hu. [84.236.109.47])
        by smtp.gmail.com with ESMTPSA id b24sm17833125edn.33.2020.08.19.01.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2020 01:20:26 -0700 (PDT)
Date:   Wed, 19 Aug 2020 10:20:21 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200819082021.GA5238@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 04:52:14PM -0400, Taylor Blau wrote:
> Introduce a command-line flag and configuration variable to fill in the
> 'max_new_filters' variable introduced by the previous patch.
> 
> The command-line option '--max-new-filters' takes precedence over
> 'commitGraph.maxNewFilters', which is the default value.
> '--no-max-new-filters' can also be provided, which sets the value back
> to '-1', indicating that an unlimited number of new Bloom filters may be
> generated. (OPT_INTEGER only allows setting the '--no-' variant back to
> '0', hence a custom callback was used instead).

Forgot the most important thing: Why?  Please explain in the commit
message why this option is necesary, what problems does it solve,
how it is supposed to interact with other options and why so.

