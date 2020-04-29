Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA879C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AEA208E0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="XLCFxJ+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgD2T5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2T5s (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 15:57:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C4FC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 12:57:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so1517394pgl.9
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=spcSn3VGYj2zmfoJCrO1XcwN+HE0TUW8ilIBqImjBqk=;
        b=XLCFxJ+e9wI1fJYTBR6pcUYgIJ3IOUorKKq9OOcqtZ3Rp/7KHGax+d9bGbCgHdbMjd
         yLlRxMl0pPbemInMr8uuTUvLIIQE+1qTdKDsTsy7kg/hihu8wN/FkIcXbkstg97GEJc1
         AZo72OcxBDEMxgFvWrEbZ3bSCJeDZZ4/JBN0qxN91yZ76W7xag0SvlefsFe7yMHsEcGT
         KKrNnhuCPFOTYMi5QjrtsTu7oyNrgn3+FyUYOOCo+0vkHOA+Sv7JPgUSn77AwNA/UDhv
         O2QQe65I8vEAeOfApsnbSC99vLXxa6i4EFulfyTWfS6r7hgQBTEQHoDCJlsUJPW09GDt
         D7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=spcSn3VGYj2zmfoJCrO1XcwN+HE0TUW8ilIBqImjBqk=;
        b=GZZCPyra/mgouh0RVKn3M1qL1WUuUmEwS7eal4mUiTqVDD2XC4chFlklQA7ci//KBF
         CNrOX1dDQ1T8NasLpGUmQa1e3ryHbwAfZeTYdQ4ObEjNdav9fShtBYmiXI5/IelABmY4
         SfQl61L9Y7xn0smR+e3mFzaihMy23Tgxnsnz29vxJWKpOGw6GqkCaVcfUs4B8V2zvEX1
         0T/jMZEBSb5flcCAEOvTvxl16DSBy3daQuEgMu1GnDKu3aZ9woiQda9uWhok1y0JHjUQ
         TUifuT0VBuHYLWukWXtPYS7+K92w3WSlW9G+2rOjvJ3z8lVYqvyNehn26HA5phQx/Auu
         XHlA==
X-Gm-Message-State: AGi0PuYU57RcAs9EXyDQKcoImcPQgShgP3c1bEZVOsGHgixrS+4jKJMP
        W/riOHawxlyuF9VjReKuZSzaTg==
X-Google-Smtp-Source: APiQypK1tkYWgz2pMI59sJjcVhq1Uu6aKxpUDLzkXvrnADrSKzw6w4ixxIt5tBtsoZoSlqkWY7SDsg==
X-Received: by 2002:a62:76c1:: with SMTP id r184mr37509417pfc.155.1588190267755;
        Wed, 29 Apr 2020 12:57:47 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id e7sm1686461pfh.161.2020.04.29.12.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:57:46 -0700 (PDT)
Date:   Wed, 29 Apr 2020 13:57:45 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Ivan Tham <pickfire@riseup.net>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
Message-ID: <20200429195745.GC3920@syl.local>
References: <20200429130133.520981-1-pickfire@riseup.net>
 <877dxyo1k8.fsf@osv.gnss.ru>
 <20200429190013.GG83442@syl.local>
 <87v9likr5a.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v9likr5a.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 10:50:41PM +0300, Sergey Organov wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> [...]
>
> > In my opinion, it is fairly clear that 'git branch -D -' means "delete
> > the last branch", and not "delete a list of branches from stdin.
>
> Honestly, I'd never guess it'd "delete the last branch". No way.

I'm having trouble understanding why. This is how 'git checkout -'
behaves, so I have no idea why 'git branch' wouldn't work the same way.

> "-" standing by itself in a command means stdin, stdout, or otherwise a
> typo. Using it for any other meaning is a blasphemy. Sure, nobody will
> die because of this, but it's /extremely/ confusing!

Again, not sure that this is always the case. This *is* how 'git
checkout' works.

> BTW, what about mistyping:
>
> $ git branch -d - f my_branch
>
> for
>
> $ git branch -d -f my_branch
>
> or some such?
>
> No, it still doesn't look like a good idea to use isolated '-' as
> suggested by the patch.

Frankly, I do not find this compelling. Does that mean that '/' as a
directory separator is dangerous, too, because you can accidentally
write 'rm -rf / foo/bar/baz'?

> OTOH, for otherwise unusual @{-1}, @{-}, or @- I'd immediately realize I
> must consult the manual, so these would be fine with me.
>
> Thanks,
> -- Sergey

Thanks,
Taylor
