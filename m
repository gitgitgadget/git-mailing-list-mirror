Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E6C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 00:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCE924673
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 00:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhjjTWov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfLQAdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:33:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36184 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfLQAdq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 19:33:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so6551001pfb.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 16:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ibRl3C1QvqfUZIM6Ypu4tvwq6Ze5lRzRcIaCbS/i/0Q=;
        b=AhjjTWovhEQPALkQgRTzR9RqJwPPYdFV8t8tQmrLdWoFVSq/iUk6OHnapxQiDAdsPU
         jYF7ZJen5RBM1F9P8V3gTucBE6pGsHTxz/vS+8hTgDXJu19IaPFnXpBzePCmgsLzf2pi
         oP2f2de2rT0IT2gM8Wc1Wy20SasH71XF2AMNbw0UVYNLS1ZJmvpjZbMIYH/dyZiPndJd
         wW9svJDhJUbv3Uzhb8lTddwOFsVFoEcTXy+cwfl7rEGHEgxSwVOoPariTI9gg1cxxT3F
         lzMx0GW4LiwoziMH43+tzqoEKZXc2YvPTh+pIlrsA0fx01AfiVAzh2ufN/RAOr4gX6Pi
         qKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ibRl3C1QvqfUZIM6Ypu4tvwq6Ze5lRzRcIaCbS/i/0Q=;
        b=ZiX6GMiAL4ZOldgP1O6Dusz4heKBuhFzuVzAWq5iOZZfBiPc0y6BQ4A/d/zwZEqlpH
         6bnhMkUwHy0W/5E2fPTjJZjk9bQJljhNFe3dYedRTRHL/jKzCXTWfUJsZjYUzZFwzUtf
         dGDFPrUC9ikzQSzAtGBVu4KkbgX68vw5RvGzafTtqKtMjWV97/dMT2VOqxpTW3FfV5ON
         2S2gJ/Cah135vcY9HbIwAjAOLwSLGwMWFIjgVd1OQgcNBRSelddhOvx+wbcGfttzz6KD
         mey7cNtyX5jwUnn2aFQcj49umiU3LIoxk4K9mOda4vbcNGmUIyFes0OZv4qGDcf2SR20
         0SkA==
X-Gm-Message-State: APjAAAXVl+BSnn6NTUyFSs47syC4gYmwqLZ0Ds6cWnMVd8S4S4JT495/
        P56FoO4D8RMOb1dG28A39gWlng==
X-Google-Smtp-Source: APXvYqzXwo+91BF6dL6LTbWHJAtLknvADEXOibr78K8p1P4sIQ2guZLOHIwWlnap6et1VGET4JER8w==
X-Received: by 2002:a62:aa0b:: with SMTP id e11mr19644713pff.28.1576542825649;
        Mon, 16 Dec 2019 16:33:45 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id r14sm23441831pfh.10.2019.12.16.16.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 16:33:44 -0800 (PST)
Date:   Mon, 16 Dec 2019 16:33:40 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] grep: support the --pathspec-from-file option
Message-ID: <20191217003340.GO135450@google.com>
References: <20191213041254.13202-1-emilyshaffer@google.com>
 <xmqqpngskrpd.fsf@gitster-ct.c.googlers.com>
 <52cf5a3b-09e4-f4d2-a5d0-36b6ddc442f6@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52cf5a3b-09e4-f4d2-a5d0-36b6ddc442f6@syntevo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 09:13:09PM +0100, Alexandr Miloslavskiy wrote:
> On 13.12.2019 19:26, Junio C Hamano wrote:
> 
> > Hmph.  This has nothing to do with "--pathspec-from-file" that was
> > advertised on the title of the patch.  It used to be that
> > 
> > 	git grep -f one -f two
> > 
> > can be used to read patterns from two sources, but that is no
> > longer possible, is it?  Am I missing a larger benefit to accept
> > this regression?
> 
> Ouch, that comes completely unexpected to me. It's good when someone
> experienced watches over :)

Yeah, I'm surprised by it too - and surprised that there wasn't a test
to ensure this behavior.

I can put it back as a callback. I'm going to add a second patch to this
topic to enforce 'git grep -f one -f two' with a testcase.

As for missed benefits, they all have to do with ugly code vs. pretty
code. I don't think it's enough of a reason to lose functionality.

 - Emily
