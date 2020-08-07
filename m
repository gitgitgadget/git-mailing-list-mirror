Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5BCC433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B92B20866
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P7gKW+cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHGUxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGUxO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 16:53:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECD5C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 13:53:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g127so4239498ybf.11
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7ddZbqfudpEkenf5CuHM74M5rqnA00NPxvT2EtTsFZM=;
        b=P7gKW+cj+0vAF3UjWAO5LcpOLfvsMrP6D61b1l/9ccN9ibQKvEKg/8zNrXPJtgqwsM
         birAncsxV1usUzGJtJq91d84zDM21CUADdWLNNHs8PJh/Jusxc8zE0W30PQQWd87PxHm
         OQROqerQwKC3FLFE+dCvdnms2OsiTyfmn0+XQb/2Jl62ICO0XWXEyAcGZyQ+7JTwzuQ/
         sKOidZEOEvPe1C/w8Ic6003e0wJyGe41V2L9inL0R+sRC0K218EzlWS/3HZFYxYsndC2
         4Dq25uo2kY6TZqxm6GYHEaC0GMkH+xBZe3aD57+jpwTxi7dcwLECR8NMh/98ND2FnmHM
         Q/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7ddZbqfudpEkenf5CuHM74M5rqnA00NPxvT2EtTsFZM=;
        b=Y0iKf7nuzUGq64SioLbKaWVkY4QqjCirAirEQhcz5gixIlaLgqcRGfuxq08zgaXGll
         kklZ6GDZiyqYk1TZ7GY7KJKaBeZwkoVd+mSstZ9+jVm7ZDE0GO6cwGc0Kh/7mVb1R2xJ
         LSIH0GaGlPn2zK6fNgeTfUsTnp5hp8sSMKY9fcfhTgPRpFjH4mhPIIKsmiq6n8/xZIaH
         lls4iEwyjX3iAMpXdsRC18EBwiLK8vaMifV1NLtjdfQFvo5pOAKKYgQVmaTnjAOIRMHB
         wmblMwoKvtNTYJMoslBMw4lHi9jcvwlFEIHIAZZxCpQfVeUtzavbZQUH+lzBvH1nmtmN
         qTfw==
X-Gm-Message-State: AOAM533s8thb71OGrhUnYQ0bw4sqJaxNhylMr5pYRXCZASsu9owNm89c
        4MzEWXvYnHab6HufHYYPYRII2tovJE8FzzuG1u6q
X-Google-Smtp-Source: ABdhPJwWKj7RCAsWZxvkMK/JvDER7DMRGPRij9jaWB5vVfqKXg9Hyb6NMmcZXNbZHxn28dL7gBsfPisf3a7sv/n/1ifu
X-Received: by 2002:a5b:403:: with SMTP id m3mr22160167ybp.514.1596833593221;
 Fri, 07 Aug 2020 13:53:13 -0700 (PDT)
Date:   Fri,  7 Aug 2020 13:53:08 -0700
In-Reply-To: <xmqqo8noooni.fsf@gitster.c.googlers.com>
Message-Id: <20200807205308.2732007-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqo8noooni.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: Re: [RFC PATCH 1/7] fetch-pack: allow NULL negotiator->add_tip
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > In a subsequent patch, a null fetch negotiator will be introduced. This
> > negotiator, among other things, will not need any tip information and
> > will have a NULL add_tip.
> 
> After reading the original code that the patch touches, I know what
> "a NULL add_tip" is, but it would have been nicer to readers if you
> said "callback" or "method" or "function".

OK.

> With or without the "if add_tip method is set to NULL, return
> without doing anything" optimization, it does make sense to refactor
> two existing places that do identical things.  
> 
> If all the current negotiators never have NULL in the .add_tip
> field, however, I'd suspect that it would make it easier to
> understand if this step is explained as refactoring duplicated code
> into a single helper _without_ the early-return for optimization,
> and then the step that introduces the negotiator that does want to
> lack add_tip method to add the early return.

This makes sense.

> After all, if the null
> negotiator added a pointer to a no-op function to its .add_tip field,
> things would still work correctly without the early-return in the
> new helper function, no?

Right now no, because in a partial clone, I also want to
avoid any iterations over refs since whenever refs are iterated, their
targets are checked for existence (see the call to
ref_resolves_to_object() in packed_ref_iterator_advance() in
packed-refs.c). However after looking at the code again, I see that
for_each_rawref() exists, which might do what I want (coupled with our
own way of deref-fing tags in fetch-pack). I'll take another look and if
this works, I'll just avoid the whole null method thing.
