Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43812C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 23:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B5D2070B
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 23:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UANq5AMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgBRX7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:59:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39585 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgBRX7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 18:59:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id 84so11503012pfy.6
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 15:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TNgKzcK8ZL3Ctb4BDyS3ZdBBelz5YEV3tkwbY5j/To4=;
        b=UANq5AMg9aWuDv5yLbisWw+i1/bf40YHKiCTb40ac0reEZ2BDuykPU9866j1wKj+6V
         ww8mOftPeSoGeX4Tm+fCPlICJDCygTyt28LtCwTQXt/+2Tbxm0mZfXNeDemmPAnEV/cV
         UF/iwRQ5C184CMg/fIEaGVAriIH3nsqFZXkDDaJdF+fy3nUgRrPHaOvSPa527hoizRcB
         xe0hYrr0+vrZnYX/+LLDBhnwLSc1YkRyfEdeA+88fT3BoMWm5FBC4Lsk19ttnd4aX/aq
         5nbeXIUZgjaBJJlpjV8nREBrGy0ll8oCUjkIVY24AkCnKzS824/oH4vCveUZ7m8EkuZD
         mTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TNgKzcK8ZL3Ctb4BDyS3ZdBBelz5YEV3tkwbY5j/To4=;
        b=V0UXCVxtaBqMf4Zq+rxfh9ur76IsWUjz8rdJgeb9lE0E7VMM3CHUkXsU7QDnFj9vTR
         MtI45HaCGqT8AURzSfPp85RMfAMCDl+Zhhd1GGRa5MSvpLHP5kpou7eQgpZW6p1bDyuB
         6TpNgkLqQxhoSsX5jj+S2JSpirdZ2Nbcv/vCTWdPDFkCwirII3IlBgAwt3doANARDakc
         Kvql4ZxoF3Cds8G7WOYgFoOYQ/435cOL7qd5TqJho0DB9c52tMkIoGRDY8ZqAq4mgIjW
         1Yy6G8VI7qvrSRIURpS2LPz+gAFSg4ZJxaNNuxaIss3tf4/ifOQ2seGqeGnR0geuufc8
         UXJQ==
X-Gm-Message-State: APjAAAVVXfkP229aA4fzN2AbsxLFh9ieMYlB4eaf7yAqTbijM7zFa4f3
        vHORNx2O8vvJXT/RSL44fXcJ2ZJOwoI=
X-Google-Smtp-Source: APXvYqyRL+Sgeq/pc+sgmlCphCWu8r8kfE4o4ygATs7znj+J5y66fak4U4I6VRCvaVDgbYVdi26IjQ==
X-Received: by 2002:a63:6407:: with SMTP id y7mr25275855pgb.45.1582070388220;
        Tue, 18 Feb 2020 15:59:48 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id n2sm134553pfq.50.2020.02.18.15.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 15:59:47 -0800 (PST)
Date:   Tue, 18 Feb 2020 15:59:43 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 14/15] bugreport: list contents of $OBJDIR/info
Message-ID: <20200218235943.GC1461@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <20200214015343.201946-15-emilyshaffer@google.com>
 <xmqq4kvtp0ca.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4kvtp0ca.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 09:04:05AM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Miscellaneous information used about the object store can end up in
> > .git/objects/info; this can help us understand what may be going on with
> > the object store when the user is reporting a bug. Otherwise, it could
> > be difficult to track down what is going wrong with an object which
> > isn't kept locally to .git/objects/ or .git/objects/pack. Having some
> > understanding of where the user's objects may be kept can save us some
> > hops during the bug reporting process.
> 
> This step seems to have a new whitespace breakage that did not exist
> in the previous round.

Hmph. I saw it warned at some point during the rebase-and-format-patch
workflow for v7 but thought I had quashed it. Very sorry.

 - Emily
