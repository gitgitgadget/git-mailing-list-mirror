Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5C7C2BB1D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C195120784
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="iQBlT1IS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbgDOAfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731654AbgDOAfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 20:35:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A745C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:35:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so5946952pjb.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aD6aB6HYGc6MEduKzjE0XdzZfsQBFejLY0GC13aAzas=;
        b=iQBlT1ISImJrtQ6a7bSopOSAjL9di5ZHKFZi8Jy+uJo/tcOdd0HniAnUKKTTP2rMs2
         qX+LcwefyDrD4o1RcX0yVE9PQuFS6flizyQyq5MLXZ3KXivdxWFgA9RiHuvaFv9TAPnN
         SmACnvO2151IRBtlAUeTmcE8YYVGy87eiIPTIEtZli++zBUHIq6BUPVG0kzi6lQAbPRB
         QvpwEhOSpjhNrshChDqdUW2FGsqZzde/wZOoVDobcdJMoS5kFrZfF9gySfELolrrQsui
         jh9WF8X7xuLLuQ2pbXQt1oPWsfZROZ3bAXf15iRvfQzKGbn3LtARlLrqMNrEK/r7hglB
         IIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aD6aB6HYGc6MEduKzjE0XdzZfsQBFejLY0GC13aAzas=;
        b=frWYkiMAzieO+26UjMcZeLxRJT6QeRdHbeFUJlTIjmr2YKADkyMedrC44Og7c1Kc9E
         4666oJBYe5OxndRH80r6obgy/Fut9gCclibT/I0K5G6B0kLj+4jZ6F4AygJd3hur5LYI
         PN/YNJMzO9WZfXIQQ9zODeOl5+sGm+q9N03kCyYITSRUheN69hEqOQ9KZXXf4sPMucgY
         lIa0Oz1BNq2AnGAYL0wNNhspWmzSnb3M5b309fynWEvcq9GSf4GFoo0iTCC84uiJLLk1
         EJG6G5I9vjl8ZQV4WQi5OIkZM8P9C8V56mFAIULbgwdiwZdUsZLoiA0ekMNSuLuvvAbk
         x2dQ==
X-Gm-Message-State: AGi0PubyYjBqnoDSfBHgopc4L6ej6QTezxQt10mYCqnHz3d3iIdHG4GR
        0SA/tgPwTnvjHICwxiDsWjk2Ew==
X-Google-Smtp-Source: APiQypKF+j3SgIesjEDwOvr2QTzG6xRO0DV4I4sJQbocnSPosViYNtjaFpPpIKK3soE+PNh/qULbQQ==
X-Received: by 2002:a17:90b:23ce:: with SMTP id md14mr3093444pjb.164.1586910948715;
        Tue, 14 Apr 2020 17:35:48 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id h16sm12134926pfk.38.2020.04.14.17.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:35:48 -0700 (PDT)
Date:   Tue, 14 Apr 2020 18:35:46 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] oid_array cleanups
Message-ID: <20200415003546.GE7457@syl.local>
References: <20200330140247.GA476088@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330140247.GA476088@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, Mar 30, 2020 at 10:02:47AM -0400, Jeff King wrote:
> I recently encountered a repo in the wild that had over 2^31 objects,
> and found that cat-file barfed:
>
>   $ git cat-file --batch-all-objects --batch-check
>   fatal: size_t overflow: 32 * 18446744071562067968
>
> The issue is that we use an "int" to store the count and the allocation.
> Fortunately our st_mult() protection kicks in before we end up with an
> undersized buffer, so this shouldn't be dangerous. And while I'd argue
> that having that many objects is probably silly and likely to cause
> other problems, I'd just as soon we kept our allocating code as robust
> as possible.
>
> The first patch is the actual fix, followed by some related type
> cleanup. The rest of it is just leftovers from the
> s/sha1_array/oid_array/ transition a few years back.
>
>   [1/7]: oid_array: use size_t for count and allocation
>   [2/7]: oid_array: use size_t for iteration
>   [3/7]: oid_array: rename source file from sha1-array
>   [4/7]: test-tool: rename sha1-array to oid-array
>   [5/7]: bisect: stop referring to sha1_array
>   [6/7]: ref-filter: stop referring to "sha1 array"
>   [7/7]: oidset: stop referring to sha1-array

Thanks for this. I reviewed the patch, which was a breeze thanks to how
you broke it out. I don't think that I said anything useful in my actual
review, which is to say that this looks good from my perspective.

Sorry that I let it sit in my inbox for a few days. Trying to get better
about that :).

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
