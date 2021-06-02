Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD1C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 04:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E206F613B1
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 04:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhFBEDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 00:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhFBEB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 00:01:56 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E76AC06138E
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 20:59:07 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id d21so1439064oic.11
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 20:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=UM7iGvyln+zYD7RMpGKysypMwHzSbfoDqFI/u/75dUY=;
        b=JHagr+WED2HT9xMDYzuTQLds5vysnSoc+Ml0xtDee3Lyy41+Eir55NCikg75xmedW7
         FSGXKkE7wrxFmVVz0cxdSBM3WBi6O0P+EKy9EC8dRsPkovtYwtHcG/WPb4ySXEhXhVmF
         ujCjqIfCbp9RGSOlqaP/Ee7Y2/ZqnbyaetgVcHDdgoxf6BHPDAiGnN6b+UaKcwl7sY88
         iOB3YOcVbNTWK9t3q/M7ywQ2ChS5n6HeDfyJ8DkgxdYM7Wq1xafxO0iuwYHLodIjQUCG
         Q5TM7XVXpe3BUIgH+Ffi5seijYFDlhCO6WBRuf1CkR6Ub6L8gNnDyszB6dA9V6xPd7wc
         HLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=UM7iGvyln+zYD7RMpGKysypMwHzSbfoDqFI/u/75dUY=;
        b=ZYFSIMSBqt1BzngMCPgxlrNKlj1J3TVdaO33rE7MHbThgn3TCiGkWdn63RxUl5g571
         AqshsQUYLsF6flbxyLTrVYNBkqgExzeVHYnhNrmnZTFQfJUAv1NwRI6Wj84MWymmKdxf
         QKXWppT1dZmrCkukdBr5yG9ubxzyqVM2vv/n/pyfAVZKMmznQmEV9rUIX8o/bMtF0GK8
         P2wQ8v5yePWu1DKNEevMz3VIHqBXV7jY1+4MmlieZA7qvxfnTMAccjlEsMqj0C+UFWZS
         soRmcfgZC/7hLBoEywOTfjU3WCyzvErJzNWzLFy2TqdJZwKQ+jo0bZHGAAlndKcSYSoT
         0Nmw==
X-Gm-Message-State: AOAM531xlREwVp6kMNubpD8XTS3T7MS508+MC1Ask+w9p7dzPkpMGfF1
        dmgJTEcoO6AWMM2aETBUyvTuUZnRtvaqqw==
X-Google-Smtp-Source: ABdhPJwBoKmchx/QAONvbklLCOLofhKlBwpTLzkcYKdZyZ0VdR9Q2GGCY1MZUYGfNTnxPhCQ8SSnUA==
X-Received: by 2002:aca:4a8b:: with SMTP id x133mr20954076oia.124.1622606346836;
        Tue, 01 Jun 2021 20:59:06 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v8sm3834688oiv.5.2021.06.01.20.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 20:59:06 -0700 (PDT)
Date:   Tue, 01 Jun 2021 22:59:05 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <60b70209342d1_511920812@natae.notmuch>
In-Reply-To: <8f8d023a-936a-948f-7b36-655774319ba9@gmail.com>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <8f8d023a-936a-948f-7b36-655774319ba9@gmail.com>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 01/06/21 13.24, Felipe Contreras wrote:
> > Once you've lost, reply to this message with the configuration you could
> > not live without.
> > 
> 
> I'm not opting in into the challenge, but here are my mandatory global 
> configurations:
> 
> > [core]
> >         editor = rvim
> 
> I set core.editor to rvim because of my habit to edit using restricted 
> vim (as I only use vim to edit files, nothing else).

Why not VISUAL=rvim? (or EDITOR)

> > [merge]
> >         conflictstyle = diff3
> 
> With diff3 conflict style, I can clearly see the context of conflict 
> (base) instead of having to choose between either side without context.
> 
> For several repos, I do GPG-sign commits, so the required config is:

Yeap, just like apparently everyone else.

> On very large repos I have (for example GCC and Linux kernel), I have:
> 
> > [pack]
> >         packSizeLimit = 650m
> >         windowMemory = 400m
> 
> Both pack.packSizeLimit and pack.windowMemory helps when doing 
> git-repack there. With the former, the resulting pack file is limited to 
> 650M size each, and the latter set memory window during delta compression.

All right. But I presume you don't need to do `git repack` that often.
You can wait a month, or type --max-pack-size --window-memory if you
really must run it.

Either way it's probably not some defaults that newcomers would benefit
from.

Cheers.

-- 
Felipe Contreras
