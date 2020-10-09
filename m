Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D1CC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E6A222BA
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYheTlzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbgJITAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 15:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732834AbgJITAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 15:00:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6945C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 12:00:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y20so4880126pll.12
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YnFt6LUWKtOBKSIpMUL5NRMjfqv4I1JuYAZozO8cG08=;
        b=ZYheTlzstikty293Bi9hh2envOsK6mx0x5UdL6pDFes2URI4T5F8b0CwGrUy5v0Jhi
         9bM2ZYj6OCRTOzqdrLXU60DVYeeiiDXQKyFkfGgwahzSURawGOoBNFaoiEdfYtyGr3zz
         tckJKfA9TDQpab1O/jD7pjH/IepVVzEVXtdxo1H7jYGHWCiFxrfunFYT16zAgXGNAMhG
         Fs0NQH5CbpTMSi01T61MS6ekNJP6gUjtLtsuAUNxrGtreN2hoh8gm9T/ytD4d8JYIIQe
         kRSCAurwF0/fJjsSR4dOhn/Ln19iYR/Xdv1+mNy9t+Zq6N7Xq1Yrorpt+ld1DH1eM2F8
         wjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YnFt6LUWKtOBKSIpMUL5NRMjfqv4I1JuYAZozO8cG08=;
        b=kDWzocdOiToWzHJ+KCRzwXwyA0deQ/OLCKIZWGGN3y77a/hgssIOVi2IN7o4dKj+Ux
         dwd44pWa/0olgeIe/wOsA1cD4UTJFQdhiAswqjlR4Ct39YqBgYVisn1544KN1R4MQlN0
         TgLORxh+y8Fhabf2eiE7B+4ZbdXgqkLs4FRwRlEmLs1EZSikLPnLcr6pykzZnB/4hHz2
         2m+G48sjp/xSoyMG24NNG9tDPPJqaDtaLLbsrAKEj4DC0AFXf2DF+8N4VFAMbQI4WamV
         3bMTDGlWDsdo1es8UVSDPvKh2HSuXuzx747OYrE17vHYzE/SZlC8E5UyMZ31+qqWzgZ4
         5qHw==
X-Gm-Message-State: AOAM5338rZPYfFQEKl+/qUYwERdTrhYsH0JN456h05w6oyMNHd5RbnUb
        h16t6gGFU9YqRS/Pij8K2hrcgA==
X-Google-Smtp-Source: ABdhPJxDyLeQ1dQR3fYV1GE/u+rniURhDe6aEEry17OAET3ELlqUcPoR6yThq1/KqE60fOcbedc2jQ==
X-Received: by 2002:a17:902:aa87:b029:d3:cbcf:2df6 with SMTP id d7-20020a170902aa87b02900d3cbcf2df6mr13240309plr.73.1602270014271;
        Fri, 09 Oct 2020 12:00:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id m9sm11767428pgr.23.2020.10.09.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 12:00:13 -0700 (PDT)
Date:   Fri, 9 Oct 2020 12:00:09 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Richard Sharpe <realrichardsharpe@gmail.com>
Cc:     Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>,
        Amanda Shafack <shafack.likhene@gmail.com>, git@vger.kernel.org
Subject: Re: [Wireshark-dev] Introduction - An Outreachy 2020 Applicant
Message-ID: <20201009190009.GO331156@google.com>
References: <CAGxm6oXSaKoTR3btKRV4bMYUsc3-oKeWSfzrWKkCXgrRorAEAQ@mail.gmail.com>
 <20201009002541.GB2415320@google.com>
 <20201009014319.GA2429084@google.com>
 <CACyXjPxwmEzJ412CSeQdx=CwXExoZg64nKTkW8AP3rg=OBKEQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACyXjPxwmEzJ412CSeQdx=CwXExoZg64nKTkW8AP3rg=OBKEQw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 09, 2020 at 10:46:30AM -0700, Richard Sharpe wrote:
> 
> On Fri, Oct 9, 2020 at 8:18 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> >
> > Jonathan Nieder wrote:
> >
> > > +wireshark-dev@wireshark.org
> > > Hi Amanda,
> > >
> > > Amanda Shafack wrote:
> > >
> > >> I am Amanda Shafack, an Outreachy 2020 applicant who wishes to
> > >> contribute to the "Add Git protocol support to Wireshark" project.
> 
> Perhaps Amanda could resend her introduction on the wireshark-dev
> mailing list because this is the list for development type questions
> and will get better responses for developer-type questions.

I'm a little confused - did you mean a different list than
wireshark-dev? I think Jonathan did cc the wireshark-dev list.

 - Emily
