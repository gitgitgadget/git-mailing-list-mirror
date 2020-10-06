Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB98C41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 19:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584C4206B5
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 19:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIkZEh/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgJFTIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFTIs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 15:08:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5FEC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 12:08:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e10so9025858pfj.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 12:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FgYecRfVzScDItnnz488ifiwAivC171GOyraNCoSzy0=;
        b=jIkZEh/Yft5p2Dgi193tAzdSlUX2jHotWZar4Nd99mt7bA8HE5YTrWRBdyCOpBbE+A
         lpdT9CSLkYADv8J4Hljyy+7AZdvZDhsDWb09K9QF/EovJj8tm0T4TeBre8NRVVL3HkDR
         /VT7Zu+iZQddnBPFKhGB3JF3Im+pmUP+m15tja6tNmwTcoaEOLK5bnroF88W/jedFpYg
         ZKrQVanHjWgC9GAjSGg49EJvvzLmNOMkkHaB5MzzZxuJIb9vk2b+4kgYJ232X3ZINMCo
         21OTyc2lulReA9fBag8bT1fuGS1/6E6VCHT7wxHIhWjoHEVS/Dwr/BvnS/ERpU07kK0I
         PA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FgYecRfVzScDItnnz488ifiwAivC171GOyraNCoSzy0=;
        b=Q/3yHM2a3PHmXm1aMk8hfJvrCbtz0Uay+ANfPYUqsqOTNhrV7hXjBPQE6wiUDrbr9F
         qT8EWjLumLcPv0ZTV1ShWzWKrlh1eJDE/vAu0dXX8fmStuPM+Q2QzFwK1nWJVksgLqWL
         PLnCS8nQ1Nx58OuOkAZz+pRp44uSiwU4i+oY9hdGHssYK320I2iaVBY2t+lKjofAZqW6
         fzYlUNi07ig2adkKDlqlUqklUj0qBuS3/5NLq+RIleOa8sRx64YHFIpiegMDywc5eIpm
         hnEsJmwFJAVYM7mftu5TXFKDjAaYbdga2nWagbBE1RLchVW+twdAwpA2O0B+rBoN1OZE
         /T0Q==
X-Gm-Message-State: AOAM5320TQeKgaR1it08rG1zFhZoU/47EsoktB6aIldMbbIPo2zMY2jv
        WMdKDjJdJsob4tSS4A+B32wm8Q==
X-Google-Smtp-Source: ABdhPJw/GvpeO8z/SGLuuZGSKuAocN3JEeSF85hmx/9p8ScVHNmXsg/YEnH4zTziNQ9OPsd6kEYNIA==
X-Received: by 2002:a65:5249:: with SMTP id q9mr5331310pgp.79.1602011327940;
        Tue, 06 Oct 2020 12:08:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id 15sm3906840pgt.24.2020.10.06.12.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 12:08:47 -0700 (PDT)
Date:   Tue, 6 Oct 2020 12:08:42 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 8/9] commit: use config-based hooks
Message-ID: <20201006190842.GJ331156@google.com>
References: <20200909004939.1942347-9-emilyshaffer@google.com>
 <20200923234734.1294057-1-jonathantanmy@google.com>
 <20201005212751.GH331156@google.com>
 <20201005234839.GF1393696@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005234839.GF1393696@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 04:48:39PM -0700, Jonathan Nieder wrote:
> 
> Emily Shaffer wrote:
> > On Wed, Sep 23, 2020 at 04:47:34PM -0700, Jonathan Tan wrote:
> 
> >>  - As for whether (1) it is OK for none of the hooks to be converted (and
> >>    instead rely on the user to edit their hook scripts to call "git hook
> >>    run ???"), or if (2) we should require some hooks to be
> >>    converted, or if (3) we should require all hooks to be converted: I'd
> >>    rather have (2) or (3) so that we don't have dead code. I prefer (3),
> >>    especially since a reviewer wouldn't have to worry about leftover
> >>    usages of old functions like find_hook() (as I mentioned at the start
> >>    of this email), but I'm not fully opposed to (2) either.
> >
> > I personally prefer (3) - I think the user experience with (2) in a
> > release (or even in 'next', which all Googlers use) is pretty bad. The
> > downside, of course, is that a large topic gets merged all at once and
> > makes some pretty nasty reviewer overhead.
> 
> One approach is to build up a series with "git hook run" and "git hook
> list" demonstrating and testing the functionality and [PATCH n+1/n]
> extra patches at the end converting existing hooks.  The user
> experience from "git hook run" and even "git hook list" supporting a
> preview of the future without built-in commands living in that future
> yet would not be so bad, methinks.  And then a final series could
> update the built-in commands' usage of hooks and would still be fairly
> small.
> 
> In other words, I think I like (1), except *without* the
> recommendation for users to edit their hook scripts to call "git hook
> run" --- instead, the recommendation would be "try running this
> command if you want to see what hooks will do in the future".

Ok. I'll fix up the wording in the design doc and follow through with my
plan to split the series into two parts.

 - Emily
