Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528C4C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 14:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206DA2077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 14:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B99/LSIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbgDAOGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:06:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46255 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbgDAOGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 10:06:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id g7so21620671qtj.13
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LzrFokBq4cCOspjxf/hGSuxjlneoPnzTD6GzpF6A0lw=;
        b=B99/LSIkoEtzTPsWqhEFgtd8oiC4ryGLi0dncuI1oHmuvati8o166mm6KHnM8zKMqU
         pZ+tzasrFeUP6xMwtNUmYaMlMl0qwgeFaWGrl/vwpeJHmhLFBY1HCMexqZ7crsGCPj+y
         lptwLs7VOlACU94VIvYHJMJyr8uw9t2a30zdAPwr0MvunrFUl5lZ5VtHq9BL7yl9QA89
         xDRDqz8jQKEkOeho+a+5ugStpb15uwaQYC8TdE4pvg9k5P6q3mxmiVU3hSQd5f01vQws
         4ptHnNn5kH+1N2cOVlbCIXXfD9iADj2QbSFn7Oogf04D8/T1d5ZglGFXLfT+7E3AAtq1
         75BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LzrFokBq4cCOspjxf/hGSuxjlneoPnzTD6GzpF6A0lw=;
        b=ouS5OK79K6YMmgUio5dGoUVSppt6AV48S3vLtCSlKWob7YrQAtgHN7UEmP0npA4cXV
         22kwBmxv2awgUu0nQ69kjKOkV5Cf8J3SE64mcJXOJCxAfm0t5iP2oL6Er4HYQCPZmvJS
         Pe+jfqC9oozUQvf4BXU9w14YxMTl/y+hjDQuW46aW9v73Y1zlsz0ZCyH8NE6R6o7Xe2z
         eJRi3DoYUlHUvEdeLepMVNqd+BRz746UOztALA7RgkNpmMOdlvI0Y4+TrCfXKMvRXfP2
         sb9DiZalgEnwG+pvOcffvQdwr0RUiFH8x5EpdS6Shh76VKRLkNzFxWYwLKuqPKD5aKfV
         ABHw==
X-Gm-Message-State: ANhLgQ1XAkt5GMmK9gF9zSIWQ5KI6vpIk+mM/233XVAh5ymWpx7slPno
        W3Z4ojalfm1kDftOSGgPnkGOwGgL
X-Google-Smtp-Source: ADFU+vttACSQ1CyEg+W60wZ1msUpMT9cC8G8trDZDeLwH+pjA6a8v6bDTPZ9xhf/PcYmbh9VQVjWgQ==
X-Received: by 2002:ac8:6c5d:: with SMTP id z29mr10683285qtu.176.1585750005941;
        Wed, 01 Apr 2020 07:06:45 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id 77sm1476034qkh.26.2020.04.01.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 07:06:44 -0700 (PDT)
Date:   Wed, 1 Apr 2020 10:06:43 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix -Wmaybe-uninitialized warnings under -O0
Message-ID: <20200401140643.GA880372@generichostname>
References: <33984eeaabbfbcfd4b9d3903549d8b7d6c4ced7e.1585726172.git.liu.denton@gmail.com>
 <20200401095255.GA60227@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401095255.GA60227@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, Apr 01, 2020 at 05:52:55AM -0400, Jeff King wrote:
> On Wed, Apr 01, 2020 at 03:30:16AM -0400, Denton Liu wrote:
> 
> > When compiling Git under -O0, gcc (Arch Linux 9.3.0-1) 9.3.0 produces
> > many -Wmaybe-uninitialized warnings. These are false positives since
> > when Git is compiled under -O2, gcc is smart enough to see that the
> > code paths that use these variables all initialise them beforehand.
> > Nonetheless, these warnings block the compilation process when
> > DEVELOPER=1 is enabled (which enables -Werror).
> > 
> > Fix these warnings by initializing these variables with dummy values (0,
> > -1 or NULL as appropriate).
> 
> Hmph. I almost always compile with -O0 and have been using gcc 9.3.0
> since it was packaged for Debian a few weeks ago, but I don't see any of
> these warnings.
> 
> The current version in Debian unstable is 9.3.0-8, which picks up some
> extra patches from the upstream gcc-9 branch. But even if I download a
> snapshot of the original 9.3.0 release, it builds fine.
> 
> So why does your version behave differently? And if this is a temporary
> state for a buggy version of gcc (that may be fixed in the next point
> release), is it worth changing our source code to appease it?

A correction to the earlier message... It seems like I wasn't reporting
the correct settings. I was actually compiling with -Og, not -O0
(whoops!).

I tested it with gcc-8 and it seems like it also reports the same
problem. Also, -O1 reports warnings as well.

I guess the question is do we only support -O0 and -O2 or should we
support the levels in between as well?

Sorry for the confusion,

Denton

> 
> -Peff
