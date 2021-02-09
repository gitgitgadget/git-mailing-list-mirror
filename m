Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3F0C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E62F64E6B
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhBIXOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhBIW6h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:58:37 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493AC06178C
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 14:57:24 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 8so117147plc.10
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 14:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SQtJ4mXhB+Y5OlhAOPcCDapK/qKro7s8DkoJGtYPDc8=;
        b=pFnP5nEenCTSHg6BgAUURn72VrCHXl9kmuZ4nnpn6/tZ9KEDB1yQDdNRWJzdw5XRIZ
         3izXsQCIeQF01H7bHE5gTo2OILorR0dNPudv8iEAIF2f6sIC+Tt3N2wxDtoLLpFruDJx
         Htw9d0NWBUg9tkAKC/kufAR3oioVEu8s6IyWKgcR7ae2XQQ59GIhxi0mg4Cnb3wXPZV/
         +IF29JXdRb8B+wdrmhvETzMLx1gKs/oVVtdi7uqM6rwLmnCCIpNucN8Bk7m63W4C+niR
         0WG7ZucRZIRNEs1wvy1sOLg647YVo5uq9PNWwqt+wxQSjpdyM2TMXtgNzf39q3iUd80O
         HdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SQtJ4mXhB+Y5OlhAOPcCDapK/qKro7s8DkoJGtYPDc8=;
        b=j0PmT2qW4hYMsMDT2n7DyOOsCc7zeu5Sfm9wYNyjKbkyqyt70R9KsH652nCK/mFzwo
         B6dOfjtcSK+UhfEPwWuTL+Oxzz6MMwsY6ulZDeEF6evMBaFonvPTBvuetZW94dgSXita
         N/r4PHv7DCsiw+oid8vUK4ip63Vw5mZwIOZHhrveyN/1haLWbgfD53kqTIjHUqiIyYpS
         MtGFR1Di2EEdz4mFda5LgvHeLM0+UB3BEvD+asXhRKhkowHYbQ485uyX0GUG2ZHxxRxm
         /hTC8/n7/jXT7nY0qqYTM5LL4wi8pyC7AVd8ysl4ex5AMOXu4ZegmiPSJ6iU9Eg91Rl+
         0qsw==
X-Gm-Message-State: AOAM533vzjyXYBNjpZ68q3mRP/7gmZMoRM3s5ErPO+1gOUCWaVcHOfXT
        Pfe7D7uG3Ch7F+uvkDWR/G8NSQ==
X-Google-Smtp-Source: ABdhPJzRm1XUnO5oJcduRcKs7kiiQWoXrBM8qdj2oi2WKha4bnyakqfLaxYFVABRTmj+KWsTyP+rJg==
X-Received: by 2002:a17:90a:a897:: with SMTP id h23mr150076pjq.224.1612911443583;
        Tue, 09 Feb 2021 14:57:23 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:7413:906e:c6f8:81a1])
        by smtp.gmail.com with ESMTPSA id x4sm1911pfm.64.2021.02.09.14.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:57:22 -0800 (PST)
Date:   Tue, 9 Feb 2021 14:57:18 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 06/17] hook: implement hookcmd.<name>.skip
Message-ID: <YCMTTlYF2WR4RIOV@google.com>
References: <20201222000220.1491091-7-emilyshaffer@google.com>
 <20210131034030.1025259-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131034030.1025259-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 30, 2021 at 07:40:30PM -0800, Jonathan Tan wrote:
> 
> > If a user wants a specific repo to skip execution of a hook which is set
> > at a global or system level, they can now do so by specifying 'skip' in
> > their repo config:
> 
> Usually the present tense describes the situation before the commit, so
> maybe s/they can now do so/they will be able to do so/.

Sure.

> 
> > -static void append_or_move_hook(struct list_head *head, const char *command)
> > +static struct hook* find_hook_by_command(struct list_head *head, const char *command)
> 
> "* " -> " *"

Thanks.

> 
> [snip tests]
> 
> For the tests, I thought of the case in which we skip a hookcmd that was
> never specified as a hook, but that's probably not very useful.

Ah, it might be useful to make sure we don't choke trying to remove
something that isn't there - I'll add one.


By the way, I got feedback from Googlers using config hooks that "skip"
isn't actually documented anywhere public-facing. For v8 I've added a
section on it to Documentation/git-hook.txt as well as to
Documentation/config/hook.txt.

 - Emily
