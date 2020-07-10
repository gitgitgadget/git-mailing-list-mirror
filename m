Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33106C433E4
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0564C2078B
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGJo6P+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGJT1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJT1j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 15:27:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC715C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 12:27:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z3so2935675pfn.12
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YiP4vlY2fMOh3KFylmQOuMB5EwylbDaVGzzplXYJJEQ=;
        b=QGJo6P+7uO3BctCrHQsWlA4MfG2GkBooPi5N8C4g9NYpe3Q4Tlm9k6tjyk9JJYFhs8
         9S0FC3anpzG3IcjgcymigU/SbI2VAvbGW2tN4qx6vCVmX1HnF7TFzKnzHsrOjB+E8xTL
         liJC6jgBpUQRYyyZlgSv8d9WfbPRrPjWk/o3ajlIDoIddrQZ27iSFE24UB0Or0Q8H1zH
         sbAz0q51K1oXE9EPcjsBLRm663AC8THrpX6Ih8Vibr4kI1rSHn24VPMl+Iknn8C76uPg
         dOHZWgtAgI82gxM8syJ89uV01BCNcRSvmvsADyzWxfAFqG1TDAib9tUknZATw+c8ZX2G
         YCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YiP4vlY2fMOh3KFylmQOuMB5EwylbDaVGzzplXYJJEQ=;
        b=GqPvqKkYu9jSMZjY4TxOzuezXaA5EisCWXdxd6dKGGJWOxq2yWBdkrmSQdCjkbscF1
         qN9blihBU8Em9HzUmGYVwMhdJd0C6OB9RFMboGhWQ53/iOSFDIZQAf28oHH+rZqxvu/q
         zAgiyNFCILi1ahFfBCbf53xheFEse4Nh95cgy+nkwZbP12lX3vWg5AZ9Na5l17Ge+5iZ
         Tn/TStwT5geBc5Z+nU2u0o+WgAqCr7IHoXPvOM1KjmK0CDt8AIuViJDZYtUoCZOP9gpZ
         5k7/Xw8djAiX+9pf1DHCVj14km91RM5m3J4Vnkz3TR6KFUvcOrtHvmOBZDHON26p0fFY
         lL0g==
X-Gm-Message-State: AOAM530fA6yZeTRDKoe5vhfyn0GB4Uxjd7BBI944A2iacBJDiUFFth4Y
        PiH83rkJHPy5XcRrr1Mg+7jOVw==
X-Google-Smtp-Source: ABdhPJxUhkNXkYIe7ZXochL4BchR7+GSX0SC1OuwljFQTpMe63cZdj4YJpiXDVxwxHwqhGepDeQ4ZA==
X-Received: by 2002:a63:9e02:: with SMTP id s2mr58382762pgd.170.1594409257133;
        Fri, 10 Jul 2020 12:27:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id c14sm7004628pfj.82.2020.07.10.12.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:27:36 -0700 (PDT)
Date:   Fri, 10 Jul 2020 12:27:31 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] progress: remove redundant null-checking
Message-ID: <20200710192731.GE3189386@google.com>
References: <20200710014242.1088216-1-emilyshaffer@google.com>
 <20200710014242.1088216-3-emilyshaffer@google.com>
 <aebbc1ca-9936-ce1b-bacc-855d353f83f9@gmail.com>
 <20200710022040.GB39052@syl.lan>
 <xmqq1rljurvj.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rljurvj.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 10, 2020 at 11:50:08AM -0700, Junio C Hamano wrote:
> 
> Taylor Blau <me@ttaylorr.com> writes:
> 
> > To me too, although note that this will generate merge conflicts with
> > Szeder's patch from earlier today[1].
> >
> > Unfortunately, the conflicts are a little deeper than "we both removed
> > an unnecessary 'if' statement", since Szeder's patch moves the
> > 'stop_progress()' call earlier to avoid a bug that I introduced.
> >
> > This is just something for Junio to look out for while queuing,
> 
> Actually that is something contributors learn to play better with
> each other ;-)

Yeah, I was worried about the nature of this series in general. Sorry to
have missed Szeder's change.

> 
> Thanks for a heads-up.

Will it make your life easier if I base this series on the other topic?
Or would you rather I leave it to you?

 - Emily
