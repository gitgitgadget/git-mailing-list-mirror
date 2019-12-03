Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15768C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 06:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7B6206E0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 06:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MWhjZtOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfLCGT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:19:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45843 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfLCGTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 01:19:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id w7so1254674plz.12
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 22:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mfRi4yAQQhAAm4UuOnqRUjNUd75anrzPVgOj2PK3qNc=;
        b=MWhjZtOqCbGpugud4YY80uR2UpJU613tHnl6/yA/KBnuQpijMKVhVTG1wpJAizs4bf
         2MvuV2ScFNnOqUfRjQ9RoHvZQlFBDGPT67hy07ws0mtru7rChTm33n9kitkzl07jp0fX
         J93QPaPwIVpONBnGeLDenpmgi1QmSj/boKV64UOFOIa3LgVV1D3NJFkgjhuw9GoYuu2e
         LeONDfxbvMgv5nz+qJOndd1q6CEe342WTLO4voE68YLp+V5zSsp+7+1RQrV2NxsX15MT
         dV/+KaJ23RrtDfeN//E0zipykukNsqTLqaznMCnDDeG5MRf26UncZRzY5/CIO2IXq+HW
         wLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mfRi4yAQQhAAm4UuOnqRUjNUd75anrzPVgOj2PK3qNc=;
        b=FfCMmqeRAimsNrLrJnEtGb8AzbWQNQL1VG8CFcP0E9IKFNOY/D+QcC2QVDA7+LEqnI
         7TwnLeZEviCSdpnQZH7vwZIKcWlKwe2Tm7K+wftF2NAK/dMYppHsQhKtD2U6Fgg3q8WK
         m0ISJiESGaZN3x4EKMhxFvGJDkurgF825Rbh8ctLgDFINgsDfZx9jBTpAv5jvvroPnDX
         At86UO4WlTP+09LWJ7ZtWtTegdxzUWqfridd5EDSbx5B+FgaObKYDX+OfMThyDu9DyOr
         ToTzXZtYkE3jJLRThHJfsu4YbdcM3r+sfeFg9jCNPkMZv7rrlO/VDB0l09UbpzSUaL/f
         fJ0A==
X-Gm-Message-State: APjAAAWvoxbrt/ADwu44FkunclTqgULNWHg8VqxLq0f40zwCXLreS2fA
        rLO+3ubPaNTM7u004BVfdWnLw4eKvsq6JQ==
X-Google-Smtp-Source: APXvYqzHQLhkmBesX7+WcFODJMBWP2VaILIx+Cq2drNh4uPLEdmAJYo7c+XOYTs517SoydgwmXcLig==
X-Received: by 2002:a17:90a:2668:: with SMTP id l95mr3693164pje.98.1575353995084;
        Mon, 02 Dec 2019 22:19:55 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:10fc:56b2:d967:f5c8])
        by smtp.gmail.com with ESMTPSA id z10sm1730710pgg.39.2019.12.02.22.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 22:19:54 -0800 (PST)
Date:   Mon, 2 Dec 2019 22:19:54 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Colin Stolley <cstolley@runbox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] packfile.c: speed up loading lots of packfiles.
Message-ID: <20191203061954.GB74594@syl.local>
References: <20191127222453.GA3765@owl.colinstolley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191127222453.GA3765@owl.colinstolley.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Colin,

On Wed, Nov 27, 2019 at 04:24:53PM -0600, Colin Stolley wrote:
> When loading packfiles on start-up, we traverse the internal packfile
> list once per file to avoid reloading packfiles that have already
> been loaded. This check runs in quadratic time, so for poorly
> maintained repos with a large number of packfiles, it can be pretty
> slow.

Thanks for sending your patches to the list, and for working on this! I
have been most excited to see this develop internally, and I'm glad that
the new paths have been exercised enough to send the patches.

So, I'm quite interested to see what you find in terms of wiring this
code up to work with khash. If that's something that you don't have time
for, please do let me know and I'd be happy to take it up myself.

Other than that, this has been thoroughly reviewed internally, and so I
don't have much more to add to this patch than what we have already
discussed.


Thanks,
Taylor
