Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B6C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 19:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3B320759
	for <git@archiver.kernel.org>; Fri, 22 May 2020 19:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbasq6gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgEVTjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 15:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbgEVTjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 15:39:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C03C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 12:39:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x10so4778360plr.4
        for <git@vger.kernel.org>; Fri, 22 May 2020 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FsoIuySebu+aRZ+3Vveu4AJoUYgUevM36uh0UHq/Wsk=;
        b=kbasq6gZexY9qfkfc8cgJtsvWxSwUOFyvPFbGdrU/WHhlVEQRXxebsZGjD2q82dCjb
         m49JtFKGcxYMTVs978JotcVWdEnJPvc0har0ryhJp1e2yWp3ZAJ+n1OhChKmbZl6IRxj
         SxTKPfWmpc/VM2uDkmEFEew04YmPrxZYJgmEbu4SorHm9b7nSBFEG5W+MqGPpxkbMa0e
         qUBxSSBa4FZtl/LLzTHqJ42NypOb11omL8Fh/JOm+S8swzrooHenCAMVjdVb4xqYIHxM
         z90gzhjxwvw2LGSJoxMKJoz3Z3SMx2WCAiFWbS3BaNRkokp7OGEq9XFwq7EJcWTyXEL/
         pxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FsoIuySebu+aRZ+3Vveu4AJoUYgUevM36uh0UHq/Wsk=;
        b=lYGE4E/gvihNWvRT28v4+sOYatx9lPcE6rggomncOy47g54yzobJtJz9x/wks2DcRU
         d6FboGXlNUxDwaGMtmIwamDETr5XcSFFSXkC+SkdiXcUgs7/5PrUL8sgh+pMni+K+eOg
         TEtjqcDaUTt1F+NdVU2usoKm1MAjtYNJlHksvgLwgTVHrnJq/1DQ9XWLcAPKdmtuhQsM
         IngYpxQYP7PaZ7vhqaNfFObp9rho1TlpS6j7QI96vFyVlGnbYDLjcARGiZ8mN5IrOnik
         eGdJDNiENt+nS1xquGPWwbqlw8gULB4UqjbQaN4nX6jnRKIjvBZ/QUQmCl82SPpzNRtE
         YcAA==
X-Gm-Message-State: AOAM533oGo+3IU/eJGNQLjqRdcrUpgWVMjm8Fxd/GkPLTI+pngfuAoT3
        3xvTjh8UQq/+auSEx4AulXg=
X-Google-Smtp-Source: ABdhPJxKrceyoSI7wdjF2L6qC1676AOAtcoNuYWhuAS7dgkVF5vnwwFic6sl+eh0U+/jaPLvMDRIYA==
X-Received: by 2002:a17:90a:338b:: with SMTP id n11mr6568951pjb.225.1590176354514;
        Fri, 22 May 2020 12:39:14 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id f3sm7329851pfd.30.2020.05.22.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 12:39:13 -0700 (PDT)
Date:   Sat, 23 May 2020 01:09:07 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, congdanhqx@gmail.com,
        sunshine@sunshineco.com, liu.denton@gmail.com
Subject: Re: [PATCH v3] submodule: port subcommand 'set-branch' from shell to
 C
Message-ID: <20200522193907.GA4780@konoha>
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
 <xmqqk115ruux.fsf@gitster.c.googlers.com>
 <20200521190329.GB615266@generichostname>
 <xmqqftbtrrt6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftbtrrt6.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/05 12:50, Junio C Hamano wrote:
> OK, so "we accept -q for uniformity across subcommands, but there is
> nothing to make less verbose in this subcommand" is the answer to my
> question.
> 
> That cannot be read from "... is currently not used"; especially
> with "currently", I expect that most readers would expect we would
> start using it in the (near) future, and some other readers would
> guess that something used to be talkative and we squelched it using
> the option but there no longer is such need because that something
> is now quiet by default and there is no option to make it talkative.

What do you think should be the most apt comment here? Also, the rest of
the code is fine right?
