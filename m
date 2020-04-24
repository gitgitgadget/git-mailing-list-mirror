Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FD1C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E00F20774
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 16:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="upYCG/aA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgDXQuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgDXQup (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 12:50:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE094C09B046
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 09:50:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g2so3943814plo.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LISBEpughaAOrS+D0pygB53qFeSw7EsRe52iD7WONV4=;
        b=upYCG/aAR0Gjzu9RILbKU1ORQI44mb/VIzsGRTOD6sWmf3OH/yggn1k+PrdhHG8pU3
         pyO3YKiGAvfllDjD37zeFGOxi2Ln/GQe8O5NnPRZbAXDDAWdBFJMHOPjWyK+3aPzqu8m
         xh/1AM+mvAHSYA0Mr3VvDxmP5FsfW3qfvNSDjNVSxo3+VC/j9+HmzFyE6EjqbpvHgS27
         /LSWd9NdJF4e4SN6DBdm9xwJ2LBuqbzJLGS7aCtjqSqZlFnByzbvbkXeyiYlq+X4fnPm
         FGusgUTrH57qLbtMUUoL1H0KMCAMhZwY8LyY2cn5pui2ftOQD7PfwapDKEufbmNKfNI1
         iS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LISBEpughaAOrS+D0pygB53qFeSw7EsRe52iD7WONV4=;
        b=hLZjOXego5o3YYtnrkSS5yFD8tjCZh/l7jsEiADyY1jupsENG5jqslUMqKSgXI7KyV
         +KoPsYMzhV4f0+H7ZRB9PLtUCGaCGWrIiUwgs43sNflEk1ZeCrhaGm07RPtpdGAaRLnC
         1yLRyJFbnTDOZQXr27lFhmvdgKu24K6daNonizEz8qppaOYKPS5nSAviCUOO8ITsbPPb
         nZvQXISPn7JalarXiS1TRqRibxfoZR0SBBjfHA1lkqNp5iLo9pZihShvA1wI7dFKAznk
         uRxastxKDTQp5r5iEW2CJg30HRTfvIr490EOEpSGZna6Wykzjp7DlAOudqQ0lkXYlOAc
         o9fQ==
X-Gm-Message-State: AGi0PuZHyguEKVWH+oczlGfhaKe1CvvdgqDukDD18LCoGjjuJ7Q9yMiO
        IoJGiHdC8zH5OoEflEQ4gG3u0g==
X-Google-Smtp-Source: APiQypKs7gP92iSW5m3EjjNyCgyTfHhEYi3CoP+jIcrkbiAPhK/ZBKKlkFrkQa474t5oww1ekvOslA==
X-Received: by 2002:a17:902:8641:: with SMTP id y1mr10594656plt.14.1587747045178;
        Fri, 24 Apr 2020 09:50:45 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z190sm6159687pfz.84.2020.04.24.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 09:50:43 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:50:42 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] push: anonymize URLs in error messages and warnings
Message-ID: <20200424165042.GA58621@syl.local>
References: <pull.618.git.1587738008248.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.618.git.1587738008248.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 24, 2020 at 02:20:08PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Just like 47abd85ba0 (fetch: Strip usernames from url's before storing
> them, 2009-04-17) and later 882d49ca5c (push: anonymize URL in status
> output, 2016-07-13), and even later c1284b21f243 (curl: anonymize URLs
> in error messages and warnings, 2019-03-04) this change anonymizes URLs
> (read: strips them of user names and especially passwords) in
> user-facing error messages and warnings.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     push: anonymize URLs in error messages and warnings
>
>     A token used by GitGitGadget was leaked by this bug. Thankfully, it
>     seems nobody noticed, and I installed a patched Git on the self-hosted
>     build agent so that this won't happen anymore.

All looks good to me, thanks.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
