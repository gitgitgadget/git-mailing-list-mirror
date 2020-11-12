Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061A2C388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD302085B
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovx8Sqw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgKLWyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgKLWyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:54:23 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945DC0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:54:23 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 19so6616144wmf.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+J1l+FezcA5CPce2/EqcrTqLDNtt4ded/9yWpPOD7z0=;
        b=Ovx8Sqw5Z4GC1iZ9cgDbRVPo3n2PZ7F7J3XFRVGyNsKwV9we0GrozVQ4vI+9zuBq09
         DrseuGWdtV0ng616991l6ikBnsdqXADwmZuFh3LuVpLv8Y5DQPyAeCmPZhwpigtQfcdR
         XCLPMv3IMzg+kMDdW3QxthB38tXnuOVFgs6eQkFk3NBzfmdPE1wr00klsLHwuotUGp6c
         AMeuw5YkPnkJOTyQl7y10CKFs8XiBuninhEZPQZrEy0qWlG/oywAWrNJ9WAe8YeL4W8n
         fCAVFxGyYlz87UhEC2wx+MrkSTKe/VMceOXqJ9heP7knFC0kL9wVJVtWC/nOsWT3lknA
         8ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+J1l+FezcA5CPce2/EqcrTqLDNtt4ded/9yWpPOD7z0=;
        b=gqCVVO2M9lnF4VE4ucQvkLhG6gmNV7Y2x8VGS1WHkoYW4aJwP2NPEdGKfN6Z8E+4DV
         Fvq4Qa6tvjsGVSGAV4uC2pS3GhrkQ/ZNdrqn5/zRfgWbzSYEBPCXrourUCrTXb6WI0aO
         5LfVNaaHZxSI0qZ9MWRbJng+IVAQP0CNcJkdZkrb3TYvKXf9h/KWK/ovJJZ5KFFJN4PX
         3iBB1riJi3IuXsBTRQ3U+F7tZ0q+1Yf+DT7DN2ckFASF/ade+7QdM2Lv7Y6nx0WxHVf+
         ZJmXKcBibL4etAG8UWlplht/bOkLhi3xANK4iAvx/y4MCQy0W2UK7+7BlqOXNw2OOmzB
         jX4Q==
X-Gm-Message-State: AOAM532UTkY682siQdu/ZWE1YyfXEkhiODedxp8WwivAI9usYvD7j7Bk
        VpFPmTkExXg2XMm/peqFbI+67rGhgwaapr/FyQ4=
X-Google-Smtp-Source: ABdhPJxIB+zfhsvFimVi1dP8DE7E7Ia3ZT3cvd92sFkTZU7yAyaJdhXEcDKFXDAK0M3SVxP1Yb3ZPEnj/sWDxlet5Jw=
X-Received: by 2002:a1c:98cd:: with SMTP id a196mr117540wme.42.1605221661973;
 Thu, 12 Nov 2020 14:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
 <20201110212136.870769-7-felipe.contreras@gmail.com> <xmqq1rh05p6f.fsf@gitster.c.googlers.com>
 <CAMP44s0XA6QjOZTJaC5CK9Rp9ySfoH9_rJu-AoEGgprstzprfw@mail.gmail.com> <xmqqsg9f4zme.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg9f4zme.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 12 Nov 2020 16:54:10 -0600
Message-ID: <CAMP44s02ytq9gpa1S-Kp7dhMknrZkGtwcqu7mssCCzJY2v=S6Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/26] test: completion: add run_func() helper
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 10:39 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > But even with no other reason for it, the patch stands on its own.
> >
> >> > +run_func ()
> >> > +{
> >> > +     local -a COMPREPLY &&
> >
> > This is the line that was smuggled in. It should be part of a separate
> > patch, since this is behavior change.
> > ...
> > Do you want me to add: "In two places we generate an output that
> > didn't exist before, but nothing ever reads it." ?
>
> That would be very friendly to readers who may later wonder why the
> change was made, yes.
>
> In any case, I am not a shell-completion person, so even if I said
> "yes that would make the patch perfect", that would not count as
> much ;-)

But it doesn't hurt either.

I'll resend the series only with the obvious fixes, since there
doesn't seem to be much interest in the rest.

-- 
Felipe Contreras
