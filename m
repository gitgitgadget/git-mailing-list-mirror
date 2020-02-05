Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A5EC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 02:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FD921741
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 02:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOQV2b3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgBECud (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:50:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46943 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgBECuc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 21:50:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so223246pll.13
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 18:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gelE++Q8PEG6mxb/NNZc+Xy5SqrqMIQl+U8bxFUtvI4=;
        b=FOQV2b3/QfHVLjxxnYVBjfCvlHwzB+0w3QT4QImcP0S7t7pb/CCX7AKeTI7NJZuRaO
         fKlslyT58BRaxxRQ9h9y0wQpP41xT6g3VrvwDL9JDdmwmBRFPQEe8iWV3SNWy++g3lVf
         FaYw1TYE2Da31j4z1aQlr3DTNRtkwY2M8319ZPCLpQPTDlHjdilwnut1wlcHsHs3Bhe2
         QljzHLpL+vFOhTg4UpeLa6o3iCqK8IZEc0I6qejo4y+/7fYEFG7s7NQCtfyr/NkIC12J
         WzUGbt5KC0VnLarAONc3q7/VO+CS+wleJdNiL7jJEmFvcdPkB5fgMJUa4B468KmdQjmT
         ml9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gelE++Q8PEG6mxb/NNZc+Xy5SqrqMIQl+U8bxFUtvI4=;
        b=j8YuSxelWyb9oSDFB8O9T7VjuQcedSFC/Q1K6FIF8X6/WNGg518yxORLoGlhzmNls3
         BjFzwjnui7Pv/6tWC3i7PtTfuoe+7kYfniyxR+SLvEUcZnPWwJUd73vj8gx9IWyjEFob
         ocqLyViqHv46JxaFoLkn1FywdpkXDCji4DDUEoqTa2Q1aoHpYSBnUKyfa96zxNK3NVHr
         RtOo3+5I7bBNmfy7PBDjsnMj0eF9qXL/7jv0KwbcgwEoXaFk9cMnbORO7Ix8NnD41IGN
         q6qwyBry/qfDuwetuM4DLeq/SBCMfBE66fjn4d7y8EUhaB4uoMZ5vCCRu0txgHOoQJGW
         7daA==
X-Gm-Message-State: APjAAAXxeDODz/8mguwIwF3GyGgqCUziA4E83tla22i7eySqeQKluzIm
        LIWQ3svQIyya9GEYVK8YGN8OvNoAXFM=
X-Google-Smtp-Source: APXvYqxS1JYLEJ4xKeVLLITLFxfIYbMJVKBW5Kt/RWataT1+3+A1LDHeOBlOGmGR/51A1vDp9WYG3A==
X-Received: by 2002:a17:90a:f0c1:: with SMTP id fa1mr2942788pjb.129.1580871031947;
        Tue, 04 Feb 2020 18:50:31 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id g9sm26189343pfm.150.2020.02.04.18.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:50:31 -0800 (PST)
Date:   Tue, 4 Feb 2020 18:50:26 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 12/15] bugreport: count loose objects
Message-ID: <20200205025026.GN87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-13-emilyshaffer@google.com>
 <xmqqd0au89z5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0au89z5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 10:48:30AM -0800, Junio C Hamano wrote:
> emilyshaffer@google.com writes:
> 
> > From: Emily Shaffer <emilyshaffer@google.com>
> >
> > The number of unpacked objects in a user's repository may help us
> > understand the root of the problem they're seeing, especially if a
> > command is running unusually slowly.
> >
> > Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > The refactor removed much of the code Dscho suggested; and yet it
> > remains true that he helped me while developing this commit (although
> > his suggestions didn't survive). Shall I leave the Helped-by line or
> > remove it?
> 
> You two collectively thought about viable alternatives and decided
> to reject what was not wanted in the final result, and not having
> that rejected code was good for the project, right?  If so, I would
> say it still is the help that deserves recognition.  After all,
> making the result better by removing things is harder than by adding
> things ;-)

Sounds great to me. I'd rather over-assign credit than under-assign (but
I don't think this is a case of over-assigning here).

> >  bugreport.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > ...
> 
> The patch text looked sensible.

Thanks.

 - Emily
