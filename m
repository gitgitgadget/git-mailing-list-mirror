Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FA4C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 23:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BACE2065C
	for <git@archiver.kernel.org>; Thu, 14 May 2020 23:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnPKLWPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgENXnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 19:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgENXnF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 19:43:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B6BC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 16:43:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s69so150783pjb.4
        for <git@vger.kernel.org>; Thu, 14 May 2020 16:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YA47T3bxOXU+xFJT235dPfQIljk2aBoA9hL7YlOgR2k=;
        b=jnPKLWPyiCQcTRab1uZsSx0jdGGnKOhsRrc7SJreOAlRpVct4Gpnq2MgNlsuTyEpnD
         F3M1Rcyf0DiTsIdKXTdYKbqYOS9aNfPLtk0VTd5ICMsHv+Q6K3DFxhYvziI4madqGbGg
         GgLe7De/e7EG9mz2CSxbv4Mj8Z/TvrA8Ich4oTlF5enEKxl9Z7BvAhadr0qREkOXGYVW
         AtovPpa+WGTPfKH+um4LufjOabpdllQ7Tg5qBIn3xV9z+ujJ8hHM4k0H1b5aD3YVkVeq
         mnHJBeHc04qK07X82xoazLNaC58VbB560bRmksaFrGLlITqB2CQHYok2wg6V7M8uhYZq
         AAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YA47T3bxOXU+xFJT235dPfQIljk2aBoA9hL7YlOgR2k=;
        b=ca3VmqfuWSJG+pNIZ8NQzdSMrlfyX8KePWYGwGFV+1FZTq/gF9z9Rkly3B45NSAe5N
         ihcbo9z0ItKgFXIC88ACkg2EjRUgYzfdSA8WU7MNOiiaUKeThC67be3tTkVPWUcZiyIQ
         VWNHNUKLduw6imLl0RKK8IQqilHLWTSJcDX7DDQfInO/K2KDYnwE4atmuaJ0WUoC1uas
         wR+MDpLZ9eUc3SndZr6gLzC6oi9tO0WxHeRYH3tzyIHs2Kyy3kieU0ifslWcCW0FPzU+
         ZyFtUOz5EyzpGc301XcFwmVR0F3dKrp46G9rmmhnnr57HJgyikYN/8gFIQa9NXC1OdUM
         d8JA==
X-Gm-Message-State: AOAM531zJVM6VVNs+f5Zg/MeTLOzNGecB/0gy4yYnxG4qAPvWpqtpMpq
        nIU+qKcjIKcoN056Xf4hWRYwb3Di
X-Google-Smtp-Source: ABdhPJxtlKqzNLOl0lQXjYuiHzPGs1MM6YX8CqNTUf2xghBYC+lyJKYYxUyQRmnkGwaXHnGnvl8bJA==
X-Received: by 2002:a17:90b:4383:: with SMTP id in3mr429584pjb.177.1589499783609;
        Thu, 14 May 2020 16:43:03 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id x193sm289415pfd.54.2020.05.14.16.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 16:43:03 -0700 (PDT)
Date:   Thu, 14 May 2020 16:43:01 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] t0300: workaround bug in FreeBSD < 10 sh
Message-ID: <20200514234301.GC38566@Carlos-MBP>
References: <20200514210518.56101-1-carenas@gmail.com>
 <20200514225514.GA6362@camp.crustytoothpaste.net>
 <xmqq5zcyp188.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5zcyp188.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 04:04:39PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > On 2020-05-14 at 21:05:18, Carlo Marcelo Arenas Belón wrote:
> >> 4c5971e18a (credential: treat "?" and "#" in URLs as end of host,
> >> 2020-04-14) introduces check_host_and_path to t0300 and some tests that
> >> use it, but fail in at least FreeBSD 9.3.
> >
> > From FreeBSD's website, it looks like the production releases are 11.3
> > and 12.1.  9.3 is EOL and has been since 2019.  Since FreeBSD is not
> > supporting this release with security updates, nobody should be using
> > it.  In light of that, do we need this patch?

Not urgently, and my rationale was that it might get reverted and dropped
in the near future, like we did for those workarounds for defunct versions
of dash.

Which is why it was clearly marked as a bug and the version it affected.

FWIW there are some people still building git in macOS 10.5 (the last with
powerpc support) that was EOL in 2011.

> Perfect comment given on the day I am cutting -rc0---the fewer
> patches I need to worry about, the better ;-).

I was considering it will be worth pu (in case someone might need to pull
it), but definitely not needed in master for this release.

Carlo
