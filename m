Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379DFC83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E4B20B1F
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 20:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="v3ppgPKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgD2UfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2UfN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 16:35:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7873EC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 13:35:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d24so1264433pll.8
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nYFDa27Xo9qtCRYfidSWka7aOcilRntZ4qxah/i5cMA=;
        b=v3ppgPKrn0Q1IBVFBxsRTNWNwx6xWyn4bfcaDDFlCS9cGoct5zZjyfa7ttvEZdGeZc
         g3L1IlGP6q3FvO3qWt/Qgl1Ev+kVwoCml+NW1BtuxElVa7P6odekHrYBqHo+hQy9ss6y
         ufZeP46JArxfdnlnT37a8NjnSh45YxgP8rrYo9BF7GbIFSVWkNQjYRbpU5x5oXYLQEky
         L+ZRTVYcnYnrnwDnL2Aj1qCV2txfGpgEiXklg3sr+xcMcLSA99n/+AA6GwuNibQ43VXR
         r7skOOkHSDK1nw0s6trRZ7K/poH2xqx0J1wgZc1dG4dJE1Fx9PVpJ3U0eCKbYVCgU45x
         pB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nYFDa27Xo9qtCRYfidSWka7aOcilRntZ4qxah/i5cMA=;
        b=PPBipEIRqdmHqNe2qd3PEP+H+ku7IgG/PcuH+4PYacMZOvf85Mp/scG8rH98oo1INa
         d8Dh35DfSnM9bVPPj3KwFB5NBP4JW0CXdUAJGGLCbEDaW8NPiEtsLQTOpsEMX0VaD3Eq
         319LVvkkD5RI8LXajCRcM7B9LWqTbRQAXJj/BEN59JMfko0hLzhYdyeP3Ag5ATc49sZH
         a2IK/UUuSxaG+4DFEemR0Q02+LTgJFr1BfITXCEbqS9qvCs2o6146sma3FDmfcdutAsW
         oqvrmBv7SYyXmA6V0pPNknOSMHiQrI5bPUMqLtORU8QVSmroStRoi1jJtdB06YegR5sG
         FVog==
X-Gm-Message-State: AGi0PuZs/3EoUntc1rjZIR5RT3VxT54LXYJSIkV6d6YXuBrVVNAaAhMg
        CvUlwFw5DhCcq0fDor4zAua0aw==
X-Google-Smtp-Source: APiQypIvEMNkKMog2Cw28ey8J7ZjOVa6Z1NRH65nlQAuz4WMU3XLgb8PSoG+WMj2zFLp27wj5X4c+w==
X-Received: by 2002:a17:902:d689:: with SMTP id v9mr172117ply.328.1588192510833;
        Wed, 29 Apr 2020 13:35:10 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 14sm1769217pfy.38.2020.04.29.13.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:35:10 -0700 (PDT)
Date:   Wed, 29 Apr 2020 14:35:08 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Sergey Organov <sorganov@gmail.com>,
        Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
Message-ID: <20200429203508.GA7899@syl.local>
References: <20200429130133.520981-1-pickfire@riseup.net>
 <877dxyo1k8.fsf@osv.gnss.ru>
 <20200429190013.GG83442@syl.local>
 <87v9likr5a.fsf@osv.gnss.ru>
 <20200429195745.GC3920@syl.local>
 <xmqqa72uvy7n.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa72uvy7n.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 01:22:36PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Again, not sure that this is always the case. This *is* how 'git
> > checkout' works.
>
> To be honest, I am somewhat sympathetic to those who find "-" ==
> "@{-1}" unless it is used as an argument to "git checkout/switch".
> The use of "-" in "checkout" is the exception, not the norm, and it
> was sort of justifiable due to similarity to "cd -".  Both are
> commands to the computer you give to "go to the previous place".
>
> "git merge -", "git branch -d -" etc. are not about *going* to the
> previous place, and declaring the "-" is "previous place" is taking
> it a bit too far, at least to my taste.

OK, I could sympathize with that as well. I still think that my
suggestion from earlier about documenting the fact that 'git branch -D'
already understands '@{-N}' as a separate first patch is valid.

If I were the author, I'd cut that as a first patch, and discard the
remainder if it sounds like we don't want to go with 'git branch -D -',
which is fine by me. (I don't really care either way, and I can
understand the arguments in both directions).

> Oh, I do not like those who advocate "@" as a synonym for "HEAD",
> either.  If there is one simple thing I want to get rid of from the
> system, that's it ;-).
>
> Anyway...

Thanks,
Taylor
