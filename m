Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE4C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 01:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC94B238E4
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 01:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgLIBlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgLIBlo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 20:41:44 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5857CC0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 17:41:04 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id d189so31057oig.11
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 17:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xDShpG5hcv65KzNrC10RnGhN7SIzghZXFbe+7pJGyUY=;
        b=naaInTWLKU8V906epocg711zQYSX3Gqov854xS8+40skURS7v21wx2OE7KRRAn/VGn
         rZsK5MkJZrWuY3qA6d+XdM9LyLcH0p/GRlc3KGAjAmw1LHiOxH6x/0Jnr1GFvUmAqUHk
         ZqAwqOBCLdJ8EhtrKtt6ceyz8FQxRbMMmAepwFqNEyJ5VdLdnUbTHnZRjnP7uYLMSfg+
         TYYzJDJAbyqQLnnGcraTvycJzS2jsP9kr/0jaxG+AF+zkVoC3ew0LEO6pESn1IybSCir
         96krLJMeEYYIufMhnQVzP4me+Gf8tr+uu6eiNfpgSJG+L0zQ3AYb/PdJi3cgYPEJehTP
         fkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xDShpG5hcv65KzNrC10RnGhN7SIzghZXFbe+7pJGyUY=;
        b=SWjVvtGb2wCYRqBTOwWtb+plFVGQwlHQeqHANN2baZ11J7tSdZMAknRI9iODpRkcfy
         M9SlKVecs4/SDs2JXJ/2QnIWoP22NL5Gg+DwOTh/+OufakVUNyaa9IaheLOEwlM69umg
         /JXo/tiOfgcNtxsGy//VFnHnldKoquxgw+MYSMzIcbnZBshWtfdkmBH9tVpbumYe374o
         3o8AGgz27mqfpF7rgeLyhiI/fTZXPyzmJYDKFcgCf802dnn7ujoMN56Fmeiax9Y+f75l
         7wa1G19LXf1oz7ZzQ1qfOkYKd57OENWE5rAaGtr96iJ1y5tmH0cIS+iblQ2TtXIQZSZp
         cA2Q==
X-Gm-Message-State: AOAM530885hP7mHwbA4sFA6uwUBUppG/qwthzOULtZVNh5JJTWhrKKmK
        f3vi1+7Ee5Xpat9bF2KCBt/VAg==
X-Google-Smtp-Source: ABdhPJzKXxHmyBZhK66yHNAapnvWd6nSpUizGm0ERHkUxzOjb2Y9oprLKcpaLJAR+NM+x9NgfkFfiA==
X-Received: by 2002:aca:fc96:: with SMTP id a144mr209264oii.146.1607478063744;
        Tue, 08 Dec 2020 17:41:03 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id y204sm22367oiy.38.2020.12.08.17.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 17:41:03 -0800 (PST)
Date:   Tue, 8 Dec 2020 20:41:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Dec 2020, #01; Tue, 8)
Message-ID: <X9ArLOecIhoivhym@nand.local>
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 08, 2020 at 05:31:54PM -0800, Junio C Hamano wrote:
> * tb/partial-clone-filters-fix (2020-12-03) 2 commits
>  - upload-pack.c: don't free allowed_filters util pointers
>  - builtin/clone.c: don't ignore transport_fetch_refs() errors
>
>  Fix potential server side resource deallocation issues when
>  responding to a partial clone request.
>
>  Will merge to 'next'.

This is one that I'd like to see in -rc0, if possible. It's fixing a
regression that has existed for two releases (both 2.28 and 2.29). On
the other hand, I don't think that anybody has reported these issues...

> * tb/pack-bitmap (2020-12-08) 24 commits
>
>  Various improvement to the codepath that writes out pack bitmaps.
>
>  Will merge to 'next'?

I'm obviously biased, but I'd be quite happy to see this get onto next.
I would like Jonathan Tan to take another look over the series (since he
reviewed many parts of v2), in addition to anybody else with interest
and time.

Thanks,
Taylor
