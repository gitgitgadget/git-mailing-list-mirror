Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF691FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbdBNSqL (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:46:11 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33840 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbdBNSqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:46:09 -0500
Received: by mail-oi0-f54.google.com with SMTP id s203so75428136oie.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 10:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xR8AEf3H/YHVOh4Z/na9X/DUyOFcaPmpm8JVxhDeqZM=;
        b=p7mimUlpDLkii2Ix5A53wlMMbcUBfemr9bk+SWrdFax6l6DIkp8YdTRjbo6fMpM+IX
         +a8OzdmP5vQB3LcKl1H89B3BoIy90xyL4d6e7mlkrBo8jz8VvL4Srj2WyXoHwegAbRF9
         topReOLCCapUqNvPuDyJ0cx3k0RcfXgsHKLJoonbyX0F5Amjlw21CnKWWEaFBMRvwUi2
         BMhoHZfLX6bJSJfrNHk2SEwz3rIdK0NSrKJ663FFsFDZO8FN3xZD9YBVz8GHSIVYOKRq
         zcLML1P/4wq8zbWfPAossGMIHeBjwFDqgdDuyglvcNxSakIPbyzNHd3wVsJVcgJJdphN
         t13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xR8AEf3H/YHVOh4Z/na9X/DUyOFcaPmpm8JVxhDeqZM=;
        b=tRi6S8H0eVDOgB8uwzLeaeEjlwUeA6lwx1bhFalcWeQu/emkV0arSx8pFbbnKfeP0L
         9NEEZ/Q4vB4PsByJzOfCnK9oo3uYrOicYHVGFcmstj6RlORY9AOnLxhiNqkyainy7/U4
         AkaFXfDhWmGTNjRYZLMqeviIysb+Ey3gnNt+3G6luJOopItODt2/05ZlU4x+98YR4bxL
         ffKt82xRdPn4PU0WW1vpEr3mjhOiUqX3kxUUcGw6afH/GB1/tX72STg1XZu4qBxojVP/
         xDGTp7n0y27DkH9utW4omBnvKwBhweHmFADzqypOcqj65NhFCBWfcm4luevWxN3M67TF
         hwVA==
X-Gm-Message-State: AMke39mlr+FHhj5YKA25FPQDc4hc+UTGUgLtqhYaUigJLSDhz2X3i5eZ3r+sL7DA1y2NeWSa
X-Received: by 10.84.134.36 with SMTP id 33mr12784711plg.151.1487097968469;
        Tue, 14 Feb 2017 10:46:08 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:35a2:93b7:75dd:e184])
        by smtp.gmail.com with ESMTPSA id t133sm2707282pgc.24.2017.02.14.10.46.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 10:46:07 -0800 (PST)
Date:   Tue, 14 Feb 2017 10:46:06 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 1/7] grep: move thread initialization a little lower
Message-ID: <20170214184606.GA44208@google.com>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
 <20170214060237.gvzzbmjzerlqnzjv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214060237.gvzzbmjzerlqnzjv@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14, Jeff King wrote:
> Originally, we set up the threads for grep before parsing
> the non-option arguments. In 53b8d931b (grep: disable
> threading in non-worktree case, 2011-12-12), the thread code
> got bumped lower in the function because it now needed to
> know whether we got any revision arguments.
> 
> That put a big block of code in between the parsing of revs
> and the parsing of pathspecs, both of which share some loop
> variables. That makes it harder to read the code than the
> original, where the shared loops were right next to each
> other.
> 
> Let's bump the thread initialization until after all of the
> parsing is done.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I double-checked to make sure no other code was relying on
> the thread setup having happened. I think we could actually
> bump it quite a bit lower (to right before we actually start
> grepping), but I doubt it matters much in practice.

Looks good.  And yes I don't believe anything needs the thread
initialization to happen earlier.

-- 
Brandon Williams
