Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0A2C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169AE20747
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 01:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="KqS7IGqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFKBKp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKBKo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 21:10:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918C6C08C5C1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 18:10:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d8so1651451plo.12
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 18:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dhi2VROP4k3eMAD7Bne3TKWlTiFzPtlAUl44R13iK/4=;
        b=KqS7IGqGZT+eqNhnEjqvB13gf9l2PSciM0yLwXsm2nxIjg6LvO6PZjA7Z3o0PM6hyr
         cD316x5j6KQGYTVI1FzkhbnDRh8M2GCvKtJjg6TL67luvYByB7RfBvuGaJTxMH0HY7ao
         rL1Rd8GUxcLM+R44SAESHo3yFfosDEx3PheAFMJCfs7ZWu/TbMUa3A82WNpxeC3qBg8C
         AJ0kVciQfz8OpxequyeNRo4saX0mm+evL3kN2tgqRajRmDsPlWzKsvUCVRJBRRBN5oHU
         Bg/3AmB9+HhSyxhyRN9cnTnaW9c6KCgIv9hnqg691SVfOzxyOgQzuLkd1DA1RyPvtUxd
         kxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dhi2VROP4k3eMAD7Bne3TKWlTiFzPtlAUl44R13iK/4=;
        b=WWBMxOWNNkcgE9/L8mZfBsgL6552eu/J0CeBG1cbUkhy1/kzxEy0JX9UCTPyXsuZ5p
         2EsCY7NAN3mLwCoiVU1BvBF1jh+a36jqXUhURmZ0KxC2AMkhQfJ4aCx9DGAaydxD2/qt
         2hD+VOkl2Ay1PcKCPuOoymEcVp+TIrmWF/kkThWAWV9gfcPRI7N2JskMcKV9JgOSfFEN
         LqVrcwACwNPWY9EWaukEWsyjPfjmVp2aDyyxETd3HVKU4F4Tw6T9/Vab61Iq1q3aglgI
         f+zN2RXoexAt1xtOwXST7pX3lMPXW1n2+s6tsk47FKyu01cwB/8BFVWbYBp50XOHCp03
         8tEA==
X-Gm-Message-State: AOAM532LhvbPP0JkxEqAIbPH2ih0slSdTY1jQVL6nIOMyafPgUnis/o9
        cmYfKHdAqm7mOQsNg8gFU/4xn+hZx7iJeg==
X-Google-Smtp-Source: ABdhPJwZJ2CWAW1BgMCK/opFmy8BVoUyCZuon/zjcsqIGQ5mGJs6W7gVnIeUDWqH7VawBnT0NyVSFQ==
X-Received: by 2002:a17:902:834b:: with SMTP id z11mr5212741pln.87.1591837842975;
        Wed, 10 Jun 2020 18:10:42 -0700 (PDT)
Received: from localhost ([63.239.199.7])
        by smtp.gmail.com with ESMTPSA id z85sm1133235pfc.66.2020.06.10.18.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:10:41 -0700 (PDT)
Date:   Wed, 10 Jun 2020 19:10:40 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        git@vger.kernel.org
Subject: Re: Virtual Inclusion Summit
Message-ID: <20200611011040.GB21728@syl.local>
References: <20200610222719.GE148632@google.com>
 <xmqqwo4eedwc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo4eedwc.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 03:48:03PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > One note I'd like to make is that the Git community already suffers from
> > a lack of diversity; it will be hard for us to make meaningful changes
> > if just those of us who already contribute attend, because many of us -
> > myself included! - come from privilege and don't have much or any
> > firsthand experience with microaggressions (or overt discrimination). I
> > think it's a good idea to expand the attendance of this summit beyond
> > the current contributor base and try to include more diverse voices and
> > experts in building inclusive products.
> >
> > To that end, I'm going to see what kind of interested parties we can
> > find to invite within Google - and I hope others will do the same within
> > their own network. I think the risk of us coming up with meaningless
> > changes far outweighs the risk of us having too many people in the Zoom
> > call. :)

To Emily; I would be honored to attend. Please let me know if there is
anything that I can do to help organize such a thing.

> It is OK to have an optional meeting in the hope that a video
> meeting may have a better chance to keep those who easily become too
> aggressive and confrontational in text-only conversation in check
> and instead have civilized conversation.
>
> But I am not sure if it is a good idea to call such a meeting a
> "Summit", given that there are those who prefer not to be seen,
> heard or recorded how they appear and how they sound in a video
> conference.  They would not be able to join the conversation held in
> such a "Summit" held only by those who are privileged enough to be
> able to attend.

I think that this is a very reasonable concern, stated in a very
reasonable fashion. Let's call it something else, sure, and avoid
recording/publishing the event (as we have done in the past at other
in-person events--such as the last Git Merge--which seems like a
lifetime ago ;-).)

> Thanks.

Thanks,
Taylor
