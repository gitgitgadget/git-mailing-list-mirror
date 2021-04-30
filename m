Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1445C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 20:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13456145A
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 20:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbhD3UqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 16:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhD3UqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 16:46:16 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E814EC06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 13:45:26 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id l17so39934962oil.11
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=v7EU7lG2goXYaaE9nDJxtTJyINqGTzZWE8pxVQsyKNg=;
        b=E8JG29gmZMzATrnN7r1ZuDsKdQ3FiZA8oXVH3G2YSTeyJKS+47QvihXpcY+7s2MB/H
         XPH9kSe5EGeYS5flnxguWB+sANpS+jtJMW1mYMAYHIPU8p57hiUJ67WrJ/qD7aPlvgYj
         Z0XhdzVTBoeDQjovNirMFRQEMtCAvjSX3FXpsJ2u9ATiw+dcpwFSXmOPCm4Fm1RQ1s4z
         rtgBAfHN5uzFdTNKPzr6si9jRMPFHfwG1wpKBX4anJKhXjSF4OIzOJyXzGCQbyTm1mSi
         9EGNs/PA2YHZXRaQDIV+oBnPQIBNHYK8/WVLj6kw+0LIWgg3Hct19pBYFrg244mO59/4
         ZyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=v7EU7lG2goXYaaE9nDJxtTJyINqGTzZWE8pxVQsyKNg=;
        b=qYc5o6W9cwuuSyWagmlkjIKLydch2EJbXJsOtgAhCd+IceHc5B0Q69VH5xdiSygiD+
         9Lz8SLfimbFeRLPEOT/f/0rZzOpk7JwHStR0elOcCAOgK1eThyCEXUgpli7cDY+zFX64
         sbQcgXLAHTf6P+MPcclnWVMqinuu7LYg1uhY7a9wmN6fsCMb/8oU4uah1HA5awj/ROZ2
         Epcgu3Y4g6AXiEOV1t2saFb8P+gyAjBoD7theTFXA3/H+a6oUGVQ+McdicclSmnqcGdZ
         tMj/PEWcdKO+AIF3iYuJeIXxNz6WzOwQfawIIY8JQ/Gsc+LtL3AKVx0fotqg1/VyOlqQ
         378w==
X-Gm-Message-State: AOAM530paQoHSMktLSCzj6g+x6hp17nBkxxkv33+XVnOgjLctanhwKmL
        S/ogWqCp3JfFhznBN7roozs1gLLVLXDHxQ==
X-Google-Smtp-Source: ABdhPJwZHJy/PfBrxOhzbj1bdgmx/ABHRNnt0sg0bv72lFbw/p+toQ9RqqXVXl+ptf6BAjUjYTXhzw==
X-Received: by 2002:a05:6808:103:: with SMTP id b3mr5344814oie.132.1619815526395;
        Fri, 30 Apr 2021 13:45:26 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id 34sm951405otf.38.2021.04.30.13.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:45:25 -0700 (PDT)
Date:   Fri, 30 Apr 2021 15:45:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        patchwork@lists.ozlabs.org
Message-ID: <608c6c64746b2_2cb208ee@natae.notmuch>
In-Reply-To: <CAHGBnuNrXrHUz9f8nWEdB0PoO0FeLsNpNOGgdiYmsmAD5LjTmg@mail.gmail.com>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
 <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
 <87czuq4r4l.fsf@evledraar.gmail.com>
 <CAHGBnuMedez4SE-4-JwCcR8k=_FRtjgBdBSEJqshQnVceCvGug@mail.gmail.com>
 <YH4FaQRB/vWOI9aI@mit.edu>
 <CAHGBnuNrXrHUz9f8nWEdB0PoO0FeLsNpNOGgdiYmsmAD5LjTmg@mail.gmail.com>
Subject: Re: Pain points in Git's patch flow
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Schuberth wrote:
> On Tue, Apr 20, 2021 at 12:34 AM Theodore Ts'o <tytso@mit.edu> wrote:
> 
> > The primary reason why the kernel uses mailing lists is because code
> > reviews are fundamentally *discussions*, and people are used to using
> > inboxes.  Sure, you can have a gerrit server send e-mail notifications
> 
> [...]
> 
> > maintainers simply find e-mail reviews to simply be more *convenient*
> > than using gerrit.  And over time, we've used other tools to track
> 
> That still sounds to me as if people are stuck to what they know.
> Maintainers are "used to using inboxes'', and that's *why* they find
> e-mail reviews to be convenient.

I'm not stuck with what I know.

The reason why I use the email workflow is not because "I'm stuck" with
it, it's because I've tried every approach out there, and they are *all*
inferior.

You tell me of an approach and I will tell you all the ways in which
it's inferior to email.

If some people want to use Gerrit, and/or Patchwork on top of email,
that's fine. You can use inferior approaches if you want, just don't
force the rest of us to stop using the superior approach.

Cheers.

-- 
Felipe Contreras
