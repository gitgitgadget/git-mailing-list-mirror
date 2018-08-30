Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6201F404
	for <e@80x24.org>; Thu, 30 Aug 2018 08:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeH3MbX (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 08:31:23 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33980 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeH3MbW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 08:31:22 -0400
Received: by mail-qt0-f182.google.com with SMTP id m13-v6so8904281qth.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 01:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHUf9t13lJFTrjAyLYzNXDYz6QqELrPZhtzF0BFdEGk=;
        b=UYa6i7uM7+frElF/eVITiYmkk7We9f+siURP5LR8kC9//I4RwT5h1rtF9lpngk7DxY
         aV+gqw9/NoV7NwuJUYqHTWlgFFcOCSoGDunBdTNr3uTI4ND9hNMUEVgEHWkhi8mwBiD7
         sLdSI0duudasjm3T3HKkyhxU0dKW+PRTt7Yz3kFArs5Kz9nzi6uEorm07DBhEwEqkC7+
         uVO9p9G/CDVygP0q6jyHkc+E6B75MHnvCztjCjXYkBxk6LPtvGtdtfhJ36kBJsMZCDaU
         tDgPcwtlgh3taV6hckFrWt0B/F6BqsGEuro4sRf0lUYOYFOGsCZ9cZ9TcStdb6Iu6Zdy
         cxQQ==
X-Gm-Message-State: APzg51DZTmyz2aLhtULgxEoFUMmyScvFsefm4s0esGHdstpXiTDtU6+j
        E4k+JnUhjyi44HmSjNByBQ34ZS0o+pTwEsoMQ1Uplg==
X-Google-Smtp-Source: ANB0VdawovHKJpqp6ytigrtOEpyrix2ZKyFnAehqza5nTMK8OiBf9OEOujGr368cwY+3Qwrpi2m0PiIu96AySRWyX9k=
X-Received: by 2002:a0c:e5ce:: with SMTP id u14-v6mr10030224qvm.6.1535617822004;
 Thu, 30 Aug 2018 01:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180828212026.21989-8-sunshine@sunshineco.com> <20180830073820.GD11944@sigill.intra.peff.net>
In-Reply-To: <20180830073820.GD11944@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Aug 2018 04:30:09 -0400
Message-ID: <CAPig+cSadH2LrhLvY0Dsrv_HhFibQo5wUq5GDPbNJJMq5MS8fA@mail.gmail.com>
Subject: Re: [PATCH 7/9] worktree: teach 'move' to override lock when --force
 given twice
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 3:38 AM Jeff King <peff@peff.net> wrote:
> On Tue, Aug 28, 2018 at 05:20:24PM -0400, Eric Sunshine wrote:
> > For consistency with "add -f -f", which allows a missing but locked
> > worktree path to be re-used, allow "move -f -f" to override a lock,
> > as well, as a convenience.
>
> I don't have a strong opinion on this one, as I have never used
> "worktree mv" myself. :)

I don't have strong feelings about this either (nor about "remove -f -f").

> But anytime I see "-f -f", I have to wonder what "-f" does. In this
> case, nothing. Is there some future lesser forcing we might use it for?

I had the same concern. A single --force probably ought to be
sufficient (given that there is no other meaning presently for a
single --force), but it somehow seemed wrong to override a lock with a
single --force when the other commands demand specifying it twice.

The strictness could always be downgraded later to require only a
single --force if it becomes obvious that that makes more sense.
