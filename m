Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC13C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 18:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A08924640
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 18:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="oq2TlufQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368269AbgJVSi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 14:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508732AbgJVSi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 14:38:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34070C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 11:38:26 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b69so2697474qkg.8
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EZhRdI6C4vGXtgj5Ldpog7mHdBnVYe8OjQQBaerYDDU=;
        b=oq2TlufQo/CqHHBdwYlBhOeKHrXwfztjl+q1HDPKE/Hl2x2En0FD4sTz6/urNSQDXp
         Zx0VHpkYQCUB0Po2ZJyksStx53m9atE9tPzQegF+jT5vp6+fxfbj0hvqnUzZCqC8PKpn
         tcweEKeA2qptw8x0/Nne0JTlC+/VhNC4+2s58s2xbCRaM4cmcepmqmnXjpMyHOQZcZTh
         Xaf7Fw1tIBprPDW422vd+KFs0Cr+0Xu8KP8YH+xEZJvTZuuRSbBDLM+fTikODhB4PR3M
         9u2k0Z4jE9bxAAHmLDIsct1A6eUsh2uqeDrNI9nGkMsC1P2N9+NhSLZZHF8ZBKa9trnw
         +MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EZhRdI6C4vGXtgj5Ldpog7mHdBnVYe8OjQQBaerYDDU=;
        b=QKKaTb485ABeb30XS702/M8MeBAKLQz5TZ5TUC5HWYd2x5khgeAIO4iSit2nd8mY6P
         iwXxIMuQT4laCag8Ym3VO6F5aurq4uUXznPnbodUD+IEsTiAEYZb+joXIJjZhu/XO9+7
         SxK6C2T14goGkz1i3kFJLxzyn/Y+qudkIc6jLCSFCyNNY4BEJ4U2vUAVRltNeZX1Hfrk
         UujVNa8Gu+9wBmOwEQCeqXpf0r5CrLu3SJPM/02tlC4FrEyZjXE28UenwNb1UXBaCIBi
         hDeikjfFZx/6wSJFnYJ0E05aJtL4YbhZby7Bp7qG7RNfbKlKK44DvGVzKr092QlqWyZp
         gIgw==
X-Gm-Message-State: AOAM532Sgf2GPn/psVDp5+4jzUxi6tbI+uUi3gJfpbbxqbXF0SHCCghY
        EmB1csNCumPRnc+hVwtOoRwDBA==
X-Google-Smtp-Source: ABdhPJz/7V0qkVuLPY/cL/bkMf8Kl9G5gNwLiKiMRCVEWlN4FvF849rWrqCWYF/PDW6DN0q/C1+Ndg==
X-Received: by 2002:a37:9c06:: with SMTP id f6mr2442696qke.161.1603391905276;
        Thu, 22 Oct 2020 11:38:25 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:fdf3:f65:ad7d:8324])
        by smtp.gmail.com with ESMTPSA id f22sm1532794qtf.4.2020.10.22.11.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 11:38:24 -0700 (PDT)
Date:   Thu, 22 Oct 2020 14:38:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>
Subject: Re: [PATCH v2 0/2] fsmonitor inline / testing cleanup
Message-ID: <20201022183822.GA781760@nand.local>
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
 <pull.767.v2.git.1603326066.gitgitgadget@gmail.com>
 <20201022174043.GA775513@nand.local>
 <xmqqblgum7qk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblgum7qk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 22, 2020 at 11:32:51AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > I'm still iffy on whether or not this series makes sense to apply
> > without the rest of the code that depends on it, but I'll leave that up
> > to Junio whether he wants to take the series as it is now, or wait for
> > other patches to come in on top.
>
> Sorry but I am not sure what you mean by "the code that depends on
> it".  Are these two functions unused anywhere in the code?  If so,
> the right way to clean them up may not be to turn them from inline
> to a proper definition, but to remove them ;-).
>
> If they have existing callers and it can be demonstrated that their
> callers do not benefit from them being inline, that by itself is a
> worthy clean-up, without adding any more callers, no?
>
> Confused...

Sorry for the confusion. I mean the following:

  - These functions have existing callers that Nipunn claims do not need
    to be explicitly inlined.

  - These functions are being moved to be part of the fsmonitor public
    interface (presumably so that new callers can be added).

...And I was wondering whether you wanted to wait for new callers
before applying these to your tree.

Thanks,
Taylor
