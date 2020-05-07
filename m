Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F33C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9210E21473
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="iBZAJGl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEGRWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 13:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgEGRWF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 13:22:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E283BC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 10:22:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 145so3292082pfw.13
        for <git@vger.kernel.org>; Thu, 07 May 2020 10:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ieINpx65tKjc15Zs4VXwrN4qjLgsPcfZ1SWxlCjRH74=;
        b=iBZAJGl0wfI9TBs+bitKFvC2UKj3gwijDy0ADlaUPZSDskQGwFoLew7KnM0I/Y7ZS8
         EVcbI6koDPoK2V7DNvlNnnOvzkz5pvCxD4ExM36dJBC816M4QLdXJ5ZibbifTad4dJ9q
         L0yYE4KSOp36uQ2tslb/ONGWSujpy7RDBSWqcun4fDgg/rwTPQ+HxQJgb3fvCuCeYWrg
         jNomG92+4674CCWluV6VXmJeP+iXbDtCbn7va6B9MkGksf9Z47D/vCn0YP9UMwMCPfGK
         tLTQgNOsLP0KG73/dJ9UVPH4zGrt1CFbXc7IC7EReaFJzCqtZs13dMOOkVeLdMf5m0Dl
         WrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ieINpx65tKjc15Zs4VXwrN4qjLgsPcfZ1SWxlCjRH74=;
        b=qS/PFPWGDSlxjDiQmlTpbtB7+Xn9yyoae3usFNQqslOAg9XHqz2oVYW6wmjJZLGfyx
         oOBifgCbvKEgrC9udxntJMRME91uVPahZiBTPQaW0wkvqUraexkKnuBG4KnCY77Ab4pe
         4XGdnfWh8TrYoIwTStXQojGrwgmDAv+vPqXNfO1cUxVMXj0ilTfHsNQA2bCJ1XxS9ZFk
         Lvr6rEFeh834kgrnVpLJRORjMZSv8LHmzAL/BfrhAp0OuaPBSymB7YvguPjHmMHIV9YD
         +e/9HkCVel6A16TEaPoix8ZtPmW1cfbmCQkuTDSqT4nxyoMDuQcjH1m9okRq+UWXy6+p
         6aJg==
X-Gm-Message-State: AGi0Pubu2cEWLb5MmyFa3sVt5A2rO547fAaWH3O5k4tP02JeUToRThmO
        Vr6yZ267r0fsQoZ6Z1LOsrRYwQ==
X-Google-Smtp-Source: APiQypKdgNRC4j6EiTLxFapX3E2dpZ16IbhZUF1rlouvjzDFc52WkgNtS6IlAmSNnPzugglOL9/YyQ==
X-Received: by 2002:a65:56c1:: with SMTP id w1mr12235956pgs.332.1588872124115;
        Thu, 07 May 2020 10:22:04 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id u8sm328987pjy.16.2020.05.07.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:22:03 -0700 (PDT)
Date:   Thu, 7 May 2020 11:22:01 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] auto-gc: pass --quiet down from am, commit, merge
 and rebase
Message-ID: <20200507172201.GD26677@syl.local>
References: <20200506094327.GC31637@rillettes>
 <20200506201830.92818-1-gitster@pobox.com>
 <20200506201830.92818-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200506201830.92818-3-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, May 06, 2020 at 01:18:30PM -0700, Junio C Hamano wrote:
> These commands take the --quiet option for their own operation, but
> they forget to pass the option down when they invoke "git gc --auto"
> internally.
>
> Teach them to do so using the run_auto_gc() helper we added in the
> previous step.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/am.c     | 3 +--
>  builtin/commit.c | 3 +--
>  builtin/merge.c  | 3 +--
>  builtin/rebase.c | 3 +--
>  4 files changed, 4 insertions(+), 8 deletions(-)

Very nicely done. Sorry that these took me a little while to look at.
This and the patch before it both have my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
