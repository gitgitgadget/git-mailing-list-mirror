Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F76C2D0C3
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B65E206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oA8X5l+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfLPWeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:34:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46236 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfLPWeW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 17:34:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id y14so6386647pfm.13
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 14:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ZBuEC6mL86zCB+VmpFHbbnPBik9S4SMG4qQvWq12rI=;
        b=oA8X5l+qG44wDeLVcPh5ZdnwhgPYZETe9fMFJFrSIsLwhykotmgAE/5XsscqBXhPyp
         ZBDHp9dc0TF8o+RKeU4jQuMgJEGFg2b5GLDzIwseiIBh0wNtumK7t2Ky6NZuznfiOeEN
         D8vbmjKDVjLiU0tGeg7UOullOe6byx9+rPZNMQFZFJhLR8F2W3kjA7GVXJrH8lyY9kNF
         dQEOVazn4iX8bV49TBhoTDmqDxypGFun7dMjMT3zg2lNodzrSk7AsrW74+NklGtxrQcj
         UB82/a8yutxHsUT/zsfsmKhgqC4TNRi7DPotOm6MvpoNRHS0u7/jgIAIxEUtHB4pEyAU
         Belg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ZBuEC6mL86zCB+VmpFHbbnPBik9S4SMG4qQvWq12rI=;
        b=WqMUaK9Za14GDHTFdkgH5oQg33qev45DfHG58+mHlZ+jKb3KdiTC7s3cXWfclFjsPi
         YEJam4l6MNzt5M58qKYxV2mfVrZG40oarfHL/+gnCVEpHfSs9n2f9W84We4Iy3axYXRr
         vIwD6MayhuEd2hf/Ur9xPS7gyPo+BKGFsgMUPtH5nwObxujfhl/iilAYRi7yuoCQLqfq
         ftJpZC/HkZ4dG5Vq+rIxD7xFWFLmj8UdybRbkSXb8FpdiQsVvDENOnHRdcrxf1jv7mOj
         KkJgP84pleExfsp5J5aIUvrX7zXOKdJHLX8MFYdreaV4C42rmM9XDelqUWRfSUawvMwq
         L3zA==
X-Gm-Message-State: APjAAAUrJ6hxXNUVfaIzGBNTHPMCLHl1pv+esvecAhW6maO2fg8NqF4K
        8dYDYZzBLSMgHWaIyAlVWAVYltW2JuU=
X-Google-Smtp-Source: APXvYqzmcDaLOH46nBytV/6kWB5oLdnDVeRrCjnAlO8h1Oj5TB9aiR2Vix3G5rut/nUSbhaMbKbkgw==
X-Received: by 2002:a63:5c59:: with SMTP id n25mr20998425pgm.415.1576535661369;
        Mon, 16 Dec 2019 14:34:21 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id v13sm10382235pgc.54.2019.12.16.14.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 14:34:20 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:34:16 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 02/15] help: move list_config_help to builtin/help
Message-ID: <20191216223416.GF135450@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-3-emilyshaffer@google.com>
 <xmqqv9qkhrtd.fsf@gitster-ct.c.googlers.com>
 <20191216213625.GE135450@google.com>
 <xmqqv9qfj4l7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9qfj4l7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 02:19:48PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> >> OK.  Looks like a clean-up that is very worthy even without the
> >> remainder of the topic.
> >> 
> >> Thanks.
> >
> > Ok. Are you going to take it on its own?
> 
> Not really.  Unless you abandon the rest of the topic, in which case
> it may be worth resurrecting this one on its own, that is.  But that
> is not what you plan to do anyway, so I expect to see it as part of
> an updated series ;-)

Ok! That's fine and makes my life easier. Just making sure. :)

 - Emily
