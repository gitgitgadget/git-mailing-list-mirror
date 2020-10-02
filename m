Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C521C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BED20719
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ykyp/r6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgJBV46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 17:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJBV46 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 17:56:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCBFC0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 14:56:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d143so3088776ybh.11
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 14:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wSKeTuqd6Q+3iB0sIQ7+Ry88yXHXkc5AfJE1hT54QjI=;
        b=Ykyp/r6wWTNDqWJI2FLFQOdDzMviwdQXgngvm2f5NwaSDSO/6QRKtTWeSPlv7a2JBj
         BZSRUMhJpRz/Y1BipKltVfqfxB0Fmd5PpsqLjtXOd+nZVgwB6j+EvCEYyd3ouc4bzjyH
         9m8uLsZyh6e1p25Bxz2I58XjdS4hsnVmdIvcJtHKKJ4w9tGlIR8i5Pnn7XIQN7kzElD5
         4F0xCaX2TYwJRfkfQeM0kN1JsVkPy9WFA3YEwObi42F6M8z0lfeXe6qBt52rhZWqO8w3
         oSpYKC4BUSNFFQ/x4G8/7SkutfJLUuraZG66okElaUyta+xxqqmHhTmrxbjWxdmNHVpG
         m6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wSKeTuqd6Q+3iB0sIQ7+Ry88yXHXkc5AfJE1hT54QjI=;
        b=O6eD0eUbMnvU1CFQUpKiiYTkUzCwg1+ue2lexHIKFi7ulTXsmL6+SYav02NEW7krDG
         iai0Gy4qNOY8bV8SWUn1esWDl4uYW9nqLrJlHBbF9w6xSSd3ihA+ehn/1j5JDYWmrHap
         2GPFtaELkbExGzfBT12EOEEfy79C4TwVf+9uYrCzO+vQvKxa/gG+LUXTltRW/XlVpnrt
         jIBi+I/cmp5QTBLqeapYTG/girDJdoziC3dunws4QwRkkQJ2P6MTknXQWDvAr1qb6Mj5
         eS1rNujlZmit9z6I913VrG4qK4PL8YT6nbyCICtlyF7eiId8+msse8FTDxlH5LU6laRI
         vYmA==
X-Gm-Message-State: AOAM5321ftwAntYPgDM+SFXBiUk+DMWqLshMWUcXGFWdMTEHI1yHdrBf
        6CM7Z5K37OedGGnvDn4iWV7ostBfbb8o
X-Google-Smtp-Source: ABdhPJw1HLDC3XheRkNcK9BT2LMYM7zEjFBRZlOuyL0/AzEinkZD4E6W+3A6DlmH5ROklnHnBJVTqQNYFjhj
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a25:2e0c:: with SMTP id
 u12mr5653852ybu.410.1601675817294; Fri, 02 Oct 2020 14:56:57 -0700 (PDT)
Date:   Fri,  2 Oct 2020 21:56:56 +0000
In-Reply-To: <20201001034350.GB2930867@google.com>
Message-Id: <20201002215656.80643-1-shengfa@google.com>
Mime-Version: 1.0
References: <20201001034350.GB2930867@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
From:   Shengfa Lin <shengfa@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, nathaniel@google.com,
        rsbecker@nexbridge.com, santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>                                                Our setenv() may not
>> be early enough---before the code that decides to call a setenv()
>> is run, there are many things that are outside your control (like
>> the tracing subsystem, repository discovery, etc.) will run, and if
>> any of them does something that triggers tzset() to be called, it
>> will be done with the value of TZ the process started with, and our
>> setenv() that happens much later won't have any effect to it.
>
> I thought about this before, but in fact it's okay: when calling a
> function like localtime() (though not localetime_r() --- see my other
> reply), tzset() is called each time so it is able to reflect any
> updates to the TZ envvar from the interim.
> 

My understanding is that it's concerning that setenv may not be early
enough that not all things have the same TZ; thus, it's still possible
to expose the user timezone.

> [....]
> 
> In addition to not having to futz with TZ, I think I like the
> semantics better.  The motivation that started this thread was not so
> much "I want to set a custom timezone to blend in" but rather "why are
> we recording the timezone at all here?"  In that context, it makes
> sense to me to have a setting such as
> 
> 	core.recordTimeZone
> 
> that I can turn *off* to say that I don't think datestamp() callers
> should consider the timezone to be information worth recording (and
> instead they should write +0000).  To me that seems a little simpler
> to understand than user.hideTimezone since this focuses on turning
> some functionality off (recording of the time zone) instead of turning
> on a new stealth mode.
> 
> Thanks,
> Jonathan

+1, simpler to understand.
Using user.hideTimezone because user is
trying to hide timezone sounds a little off; directly instructing the
system is more straight forward.
If we have a setting of "core.recordTimeZone", do we need to make it
as a command option as Junio suggested earlier?
