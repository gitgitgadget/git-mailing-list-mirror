Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4276C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 22:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29DD20780
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 22:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiAgSGCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgGAWZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGAWZr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 18:25:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394BFC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 15:25:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j4so10461902plk.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 15:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dY/QKAhYwtPcy6H6CeEfWdJoo611tGhiJBo9ACuD95k=;
        b=KiAgSGCSTS1rAvdzf4inNvD4bhEDF6OqnXoennX6EDYy8Mq85489zg5cahzc8SIp0k
         a+rmgZGTJzB18TLu0LxXdDPsDz4R6m1FJO0LOOGwCMpLxL1xaf/35OoADLjoLkyNXj5c
         ssB0Lu303EDcajQbYOswMiu4e6wlFaHjPlTJ5gg8vejmRyGQfowvAsoLKhsKe82zoxrS
         s5ZZWJo1R52+cUd4SBZzSwROg+V70oEzQwonnZJJ8I0Wk9gNo5P2lWbgg2efu87MEdci
         1O8OHPDT+PunuxTml91/cttwO5wZCdLKg9HVj4Wh+oQh0XSH/KzBfT4rEmYPunjXavwp
         G8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dY/QKAhYwtPcy6H6CeEfWdJoo611tGhiJBo9ACuD95k=;
        b=G1k6fEBLdSOSiGepQaMWWYSur2NiDTHW6Wpzz4K6Tw8wAN3iEEj9ighPPLNaWptfa7
         hvg9Y2KrYauaD5DxJ/tu9C5Y6FBS7OulCXu8vGmaqojRpLzMj+SDfzyLdqdHYBxKIkpQ
         +fLHhk2XhNH50UsFQGghIYXoYJqRAc3kdZ7LXSPEA1/iUtrhLwydUmAzc4K5CFB6RhWj
         IaFhzDSWDU5c0pwHedpW5ACepvLA51CD99a/KIjL7VusxcCokqSsTJcUUh6bJeDafrnc
         /YW0BpD4EACUVfjMoHkKxJpx1rcqDIxOTwudgT/N9qjzsJ30Y99nmcu4+DtYoAdTv8ZG
         V1xA==
X-Gm-Message-State: AOAM532094z4aWUSOgM0j1arMto5Wxeu7v4P8hoKtbhxiDPWMVXHanvX
        hEAqy0GExeBvLfEOyVBNOZ4=
X-Google-Smtp-Source: ABdhPJwoKDU/OyFeuc3D4jJMqynELiopTzugTxnP9TqAFpqr7lc2nuHufJ1WyEnCi/jPQ/6qY23ldg==
X-Received: by 2002:a17:902:7204:: with SMTP id ba4mr22944240plb.250.1593642346692;
        Wed, 01 Jul 2020 15:25:46 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id c71sm4607471pje.32.2020.07.01.15.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:25:46 -0700 (PDT)
Date:   Wed, 1 Jul 2020 15:25:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, James Ramsay <james@jramsay.com.au>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: Consensus on a new default branch name
Message-ID: <20200701222544.GA2091329@google.com>
References: <20200615205722.GG71506@syl.local>
 <20200615212154.GA79696@syl.local>
 <20200616143107.GL666057@coredump.intra.peff.net>
 <20200617180617.GN21462@kitsune.suse.cz>
 <20200701173108.GD21462@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701173108.GD21462@kitsune.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Suchánek wrote:
> On Wed, Jun 17, 2020 at 08:06:17PM +0200, Michal Suchánek wrote:

>> https://lore.kernel.org/git/20200616210701.22924-1-zeevriend@gmail.com/
>
> So you completely ignore this input.

I've done enough research to know that even within the context
discussed in that message, this is not what comes to mind when the
word "main" is used.

That said, the approach so far in the Git changes discussed here has
been to focus on configurability.  We don't only have to care about
defaults: we also need to make sure Git is adaptable enough to work
well with branch names that fit the needs of particular Git-using
projects (whether that's because they use a different language than
English or because they have chosen branch names that reflect their
workflow, or for other reasons entirely).

Thanks and hope that helps,
Jonathan
