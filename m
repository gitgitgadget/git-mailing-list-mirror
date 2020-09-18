Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C37C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 05:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BCF2176B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 05:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRFEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 01:04:46 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:40979 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgIRFEq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 01:04:46 -0400
Received: by mail-ej1-f67.google.com with SMTP id lo4so6317114ejb.8
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 22:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRK74XYWbQ/6TNul449V92oXCq5eg0i8MR9DZ+gsuwc=;
        b=emX4zoAEcxX6+rNIBIbCdHmgA2PED6bePOt8ri2x8g6oT0sqSn3sKM4h0t1gcq4g7Q
         NIIpqmCqcwgtfnzsOVGkfPyr2CGDz1yZOPRpRLa7UG/lSBsPhRtIRVdeSn8P2lDt5gaS
         JRg5SlIY9Qh24j/s9ud/1yhAJ/8pLRwX6PtqjpguL16Xv4lA/m6dz9f/LXNdT5KLOeMM
         xAIKtLPUtI49flsAvSW6Kzdmad0uwlX6OTrwxC8esAGl1KB2WQl+PouyacZB4+QHNwUb
         /VA1TmfQ+vzHW4yPJ5N1tFSfqjd5TYBd8ilQ2QYI4PfXKdmg0kwsTnCtIASokFr7e9br
         vU7g==
X-Gm-Message-State: AOAM530NmqH8PjSW+G4/aeisFxw3oYfSrlmooBWBCGVSvkgi0PlbkR9n
        MSO9Xpr/WRSxHnYC80wWg8xsn9x04HXK47u79c4=
X-Google-Smtp-Source: ABdhPJwL/Trynwp18y8Q4RLXqzHwP4/ar8q4sSP+5vx5maSt24Qp2SF5EHCQH1/QkOdCPz25IWgFjBaCaGWPjH8gIu0=
X-Received: by 2002:a17:906:850e:: with SMTP id i14mr33662014ejx.168.1600405484844;
 Thu, 17 Sep 2020 22:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200916020840.84892-1-alipman88@gmail.com> <20200918004909.32474-1-alipman88@gmail.com>
 <20200918004909.32474-2-alipman88@gmail.com> <CAPig+cRXJ5hCEM0dFsSSnGWaYu76gPhpM3fV4FaV+Db4r6dX4g@mail.gmail.com>
In-Reply-To: <CAPig+cRXJ5hCEM0dFsSSnGWaYu76gPhpM3fV4FaV+Db4r6dX4g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 18 Sep 2020 01:04:33 -0400
Message-ID: <CAPig+cRso0DJm3KwYnBZZz7w2pJaWSd+gzfLsRfbrRqLNHAE-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: refactor do_merge_filter()
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 1:03 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > +       if (!check_reachable)
> >                 return;
>
> I would probably drop this conditional return altogether since it
> incorrectly conveys to the reader that it is legal to call this
> function with NULL for 'check_reachable', whereas, in reality, it
> would be pointless to do so. [...]

Nevermind. I'm an idiot. I forgot that filter->reachable_from and
filter->unreachable_from may indeed validly be NULL.
