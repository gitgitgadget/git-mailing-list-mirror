Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F303EC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 11:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE893216FD
	for <git@archiver.kernel.org>; Sat,  2 May 2020 11:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnD59MxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgEBLDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 07:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726764AbgEBLDy (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 07:03:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D872C061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 04:03:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x77so2884884pfc.0
        for <git@vger.kernel.org>; Sat, 02 May 2020 04:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jx+E34RcjMCGiXZBZkELg8K7Nl99+qPvWY5csFannyk=;
        b=VnD59MxThZzSYybEdMTb2SFUOR4IJlvqxwKQXUnMhOYU9IEFgEMdkiATD/CrcXX7r9
         gIW7fDQYvSa3LnQAK22ndiAGkZyiUcTlrG4xVEnysE0s7LbtvUvoP/qxZm9DtozLRuRj
         Ex6Xt0fZef3z8mO7MTzxsy+a/nteloFjzCr2wfdF02D9Bp7Bh1Fl4/Qkubyn989dy/r2
         dkl6UgTO2EkyAbe+5CJFEGzFnyspZEm/76nEAhbkQ0y7vB7V62f5+tNKxcgWssmL25g3
         NHqZbSB79E6OrXuEFsU98WRhpCOCxD3OnKTS/bq9LOFyrtwDcr+dJ8wRZkpDZ3B+odBG
         B9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jx+E34RcjMCGiXZBZkELg8K7Nl99+qPvWY5csFannyk=;
        b=Jb24jcfaylbOQbKyNzeAGcpCiUu+sP5CTa3pAEmAQhufr+n9hUhU8V7Pl9tiAmHfaA
         9POnhaFZloNiq33b/2DwTn0I7ygX7zJULPf0qtzUlh/7sKwWuOFU7LHsWjd6RGtPlnj2
         UmNQ50fPaPhOvt+QheJsoPM5i+Vni/+bXfeMX2RrOMKFRwCATZc03uHlACXORMly1IdV
         ANYj3EE7DUtOYalrXRcnj6SxLUPpLbhRj7TctzIHEeUUBoYI7sMZNE5juzboENCrzAcD
         YsXjiBAdDDrMkGRwdms4g6i50YIdZ2IUtYYASb0U5I/u3ZfKEUwSrsR3e4lrIqL2vIPd
         vh2A==
X-Gm-Message-State: AGi0PuYpI6GaP8XgFEnFZK5NonHEQ7HS+ZSUHs2AJDnn22Y932OAv0Zq
        sKcgZAgSAjdB99dG6aHADSoGIS+LZx8=
X-Google-Smtp-Source: APiQypKx2MJZncVPHHjyn92ML3LbFTHFdzJXVsThw2OOUAPgIPib8+4+iDCZR7swmIKJwwXItspCyw==
X-Received: by 2002:a63:4c08:: with SMTP id z8mr8069142pga.175.1588417433576;
        Sat, 02 May 2020 04:03:53 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id g43sm1843215pje.22.2020.05.02.04.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 04:03:53 -0700 (PDT)
Date:   Sat, 2 May 2020 18:03:50 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Dmitry Kulikov <dima@koulikoff.ru>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git log --since=<date>
Message-ID: <20200502110350.GA3143@danh.dev>
References: <3860060.ab4mYtCOl4@hp470>
 <xmqqd07nl3dt.fsf@gitster.c.googlers.com>
 <42953119.Wv2erQna2g@hp470>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42953119.Wv2erQna2g@hp470>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-02 07:54:03+0200, Dmitry Kulikov <dima@koulikoff.ru> wrote:
> On Friday 01 May 2020 15:03:10 Junio C Hamano wrote:
> > You of course can say "git log --since=yesterday.midnight" if you
> > want to be exact ;-).
> 
>   What should I enter instead --since=2020-05-01 to have a midnight time?


You can use the same syntax:

	git log --since='2020-05-01 midnight'
	# or ISO-8601
	git log --since='2020-05-01 00:00:00'


-- 
Danh
