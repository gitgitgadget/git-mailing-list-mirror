Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3096C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 16:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D0661C39
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 16:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFBQz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 12:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFBQzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 12:55:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677E7C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 09:53:42 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o27so3022297qkj.9
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QCcUepHLnyjjAz28cwaU6zqskh6+xkPurWaSa6jnPAo=;
        b=MfOQcqEkp/3kTGixT1fZOWeALhf+DnQmzqPM6fXyG7Y30jQLMo18JUaBRV/9ONhX78
         IPre7OFsmKp/UMocxIER+GJeqCuM3BTXGoxehGztmacrwhvy8VPIrJ9XaWpcumTC0Tnr
         SRv268CEUp6OSAorcZtPE6JrVo/VO9nRlLk5caNrESucGRrIz3SNUSl5HdVKkNwPKrEh
         OKdX61JEakkpZlTw3xA2ImCEYYFKktczehQBPx6CXh9YyKmy1MO38r1qf4fitJKrdegf
         zFr78sTkGRKM6jbb9VeCi/FwiEnSs+MxvZhKvzqOmBqDHsWkvXPscrt9C7DpySaM9Owl
         ECGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QCcUepHLnyjjAz28cwaU6zqskh6+xkPurWaSa6jnPAo=;
        b=erjglNQopfTifigCkoTi/50RfErsSjGE4Y3J6lwAXWDh15gjZXq+NaovPXGR5WeXWy
         XNMwF26mfPwyEAdWSMhBzzB8u27RoAIT5EIMRRjWQb97mfAjPwJQ8vaYROXMb6PY4TGh
         I885FqMNa90bNmCAQacW0HVVwJKgfJ9LdGHMXHde8C9aIw3JJaI0ZI89xfruXwAyW4L3
         DFyItUN/NRJqy1qjVZvgapuAVeGB4nzBf+zrkO0woE5rMD7EpgPKYpfH0jOCWBlfYWEW
         0BQyRthqcVgK14sNUvlLq1GNjUSCkTomqyVjUhWeBqHenpC7mAUu51tL1g1zpmd3m9h2
         Sa6A==
X-Gm-Message-State: AOAM5306FkJMtQc8uv7RJaBZZWXpdaJxxqa8NTtMwJ+U2tpWffHr3VhL
        3YplN1p5ZYtoFyl5TdibFuLjFLwZc7qGLyuT
X-Google-Smtp-Source: ABdhPJw1TRvOWW7YwNRCw2DS/NH8uzLCRACpoq/M9GcVb1xTJ0uR+Qx6cUi+SYtGKc8HSAMKo/tMfg==
X-Received: by 2002:a37:46d0:: with SMTP id t199mr28042784qka.192.1622652821588;
        Wed, 02 Jun 2021 09:53:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:28ad:8020:cfd7:7a23])
        by smtp.gmail.com with ESMTPSA id 196sm163207qkd.114.2021.06.02.09.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 09:53:41 -0700 (PDT)
Date:   Wed, 2 Jun 2021 12:53:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: why does git-send-email unwrap headers?
Message-ID: <YLe3k1CYMhv9LEeh@nand.local>
References: <20210602153441.cjmey63x2vudlnk6@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210602153441.cjmey63x2vudlnk6@nitro.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 11:34:41AM -0400, Konstantin Ryabitsev wrote:
> While it's not *wrong* (the 78-character limit is from a very old RFC), I'm
> curious if this is intentional or just an oversight.

My guess is that this dates back to 5012699d98 (send-email: handle
multiple Cc addresses when reading mbox message, 2009-02-14), which
unfolds all multi-line headers, probably so that parsing the header can
be done line-wise without having to keep track of whether you are
parsing a continuation line or not.

Perl's Mail::Header [1] looks to have support for folding a header
across multiple lines, but I'd just as soon defer to the Perl experts
around here for help using it :).

Thanks,
Taylor

[1]: https://metacpan.org/pod/Mail::Header
