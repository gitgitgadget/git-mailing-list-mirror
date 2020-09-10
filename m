Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F5C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A79821D40
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNr4Uw4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIJB7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 21:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgIJBjU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 21:39:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1DCC061374
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 18:39:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so2218369pjd.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 18:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lfweq4m0gFjow9Q4fyvlSBeeeUqHJBdp2a/kx5o41IA=;
        b=nNr4Uw4dpyc3dTazU9cecRwPRtZTUqrGv0pZ8Pflgl1etiM7YQZo1ipRYPglIr67Gu
         QrUWSyDwCuqS+VXHTt/XTtraziojre6mYMEb87kjEywgBDE5XSlnORs3c3qd7Af+IXcv
         0wOIqg+dKFKzDMw+UEU2Wbh779Va9e3HUqmsio3ojW/3mO5m78qN/YcRLoff9V348yYW
         eozs/kjZ+YazrObxXhzmvGz2+JAwPRRUXWUfmoWIUSkXDYZ2bFTONiu9WFV+ft/RCZ1z
         oIMUNRmnIm77TMuHR6/6x2eLxqTBSu27JKrsRdj5gyQe1B4ibV+lgq1NIpMAw5a1poQa
         9lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lfweq4m0gFjow9Q4fyvlSBeeeUqHJBdp2a/kx5o41IA=;
        b=Aru+8CFmZNZqWh7eUu3HoZGB6k9WexGI5w62wPRn4c2HMfwZ4pGgctoEW0I4BjnSEL
         LQ3x+uxPnVfNi1G0m2je9XDJghtAfPDTZz8dj9OoZw/z88hTvKIlMIAnH1MlJJb2j20N
         cyqHTs50o6b9qyDVvg1n9L8yZ4luP0jFBCYkYVoybjg7UP7R+gCM9/HPhLC5M0Z70Z7U
         GxpntOKYYgcu007rictXHpJT6bynr4PEgx0RnmO3LDlhK6EeYXq91PEOGrEvNXd5Z8m+
         kELvG/gleiRjb04Hcc5KjL6PGBEG3nbtaheNuwytl3qK8j2WGq043EdX/w9uNiT6rju/
         L90Q==
X-Gm-Message-State: AOAM533a53jA27OyBHvfxgjahr9plvIeCJRhCNrSZsR1LfZcarqLT+Tg
        pXdqz7wnvrCpUmn2uxB8Dgc=
X-Google-Smtp-Source: ABdhPJx9Sq9U3Q1O3qeBZwZk0qaEtlPjhLXIKkEkd5u4I/mrW/108vkZGMdTHEx6p7oGqzS4y6E20w==
X-Received: by 2002:a17:902:8d86:b029:d1:9237:6dfd with SMTP id v6-20020a1709028d86b02900d192376dfdmr196065plo.22.1599701957747;
        Wed, 09 Sep 2020 18:39:17 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id mp3sm350380pjb.33.2020.09.09.18.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 18:39:17 -0700 (PDT)
Date:   Wed, 9 Sep 2020 18:39:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git in Outreachy?
Message-ID: <20200910013915.GD667601@google.com>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com>
 <20200903060041.GH4035286@google.com>
 <20200909182617.GA14981@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909182617.GA14981@nand.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> On Wed, Sep 02, 2020 at 11:00:41PM -0700, Jonathan Nieder wrote:

>> I think setting up something like snowpatch[*] to run CI on patches
>> that have hit the mailing list but not yet hit "seen" might be a good
>> project for an interested applicant (and I'd be interested in
>> co-mentoring if we find a taker).
>
> To be honest, I'm not crazy about this one. We already have a system
> in place that works well (GitHub Actions) that allows people to run CI
> on their patches automatically at no cost.

I agree, that's good for people using GitGitGadget.  So if we're
focusing on individual contributors to Git, that may be enough (or
having the ability to run tests on their own machine may be even
better ;-)).

But a reviewer or maintainer cannot count on all contributors using
GitGitGadget.  Hence a bridge from patches sent on the mailing list to
git commits that a system like GitHub Actions can consume becomes
important.  Snowpatch is such a bridge.

In other words: this isn't about changing how tests are executed ---
it's about going from patches on list to git commits that can be
tested.

[...]
>> - formats: on-disk reverse idx
>
> As a heads up, I think that I am going to start working on (an
> alternative to) this myself,

Neat!  I look forward to seeing what you build.  (Is this related to
the bitmaps-using-midx-ordering work?)

Thanks,
Jonathan

>> [*] https://github.com/ruscur/snowpatch
