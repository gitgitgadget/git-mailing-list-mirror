Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4A9C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 08:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DA660FE3
	for <git@archiver.kernel.org>; Mon, 31 May 2021 08:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhEaIQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhEaIQL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 04:16:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB17EC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 01:14:30 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so10374246otp.11
        for <git@vger.kernel.org>; Mon, 31 May 2021 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hHuwnPCVBzoXVpUjpf6lFgVpohhbtfT7mGNMeCLOCJ8=;
        b=qB7PuRIrNaOVsCrusxdFT9vXQ6M7eHW6QSR8NBSMr60/yUyVU+TRJEP9Skb2UoWHN6
         vHoUviqVhQerl6oCc0D9a8FEtQC8qw+fXKRCqa/afJEw/AdjtzuJvZGvcHUWT4Mym+Ks
         6/w3Vpp/Y1hNMAYBHMGoqORUAxMjbJBuYdl1UNIOT+g4dxsPNuuf/GwAV02ERG4/SAYG
         dMRdbTAWxiBvhvQqIGX4rpojuJxwl9KAP7aII0R+Olf5sHC08WF+9wOQQbNY51ATsJmJ
         zEScXizIx+lm9GqsdbrCQ9hyz8sozF3DBE3zH4UsYPvKOkGZEImVL0sfm1GQZK9cNR0e
         da5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hHuwnPCVBzoXVpUjpf6lFgVpohhbtfT7mGNMeCLOCJ8=;
        b=htnWFiV/GJk4wK+vcgRHRV7hoxcuAbs8237VbixbUgOjLjZjJbOW5coai6fBYpFr7V
         9dDtORjXE/GOn71IZo0aIFiFak4EEot25zTpvD4eeQ0nWhf1aNOTTFo7EuS/gKutvrE3
         YrQRtNC9KhO87Fy1+g7X5AQq03PBzUyt8RDm5jihhX+U/2TA9thaF+5GogSvmkLwVLRn
         m7sZhmlJlAeRrh3LJnOBPij5OhIOqA3xBYEB78aPHRn6dyuOO/RxqvowVlZtcbKOUKMC
         aWPLj59uCnD05O6lkhMrQKHKzyGnRZehAVCRbBvQ3jqK5hcXuh94PxJmCO2Wr6FGVN3r
         oM3g==
X-Gm-Message-State: AOAM5319WndQiV5kPOMIpBI0lYNza/qaHFJ2x8vRYgFzuAcBQ+2pHtf2
        NqlJyNt8pum7jNZNFH2jKxg=
X-Google-Smtp-Source: ABdhPJyL74fSyuG7byuqC9MUYOmS9o2fZ9wgBJZTkR5gsJ2e+ZhUjIG7q0FjmHc6uLqqN7bEsSBSnw==
X-Received: by 2002:a9d:62d2:: with SMTP id z18mr16405271otk.78.1622448870043;
        Mon, 31 May 2021 01:14:30 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id r83sm2648000oih.48.2021.05.31.01.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 01:14:29 -0700 (PDT)
Date:   Mon, 31 May 2021 03:14:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Message-ID: <60b49ae37803f_24d282085c@natae.notmuch>
In-Reply-To: <xmqqeednwgvo.fsf@gitster.g>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
 <20210529074458.1916817-4-felipe.contreras@gmail.com>
 <xmqqeednwgvo.fsf@gitster.g>
Subject: Re: [PATCH 03/15] push: reorder switch cases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > We want all the cases that don't do anything with a branch first, and
> > then the rest.
> >
> > Will help further patches.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  builtin/push.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/builtin/push.c b/builtin/push.c
> > index f4e919450d..c19321bb9d 100644
> > --- a/builtin/push.c
> > +++ b/builtin/push.c
> > @@ -254,11 +254,19 @@ static void setup_default_push_refspecs(struct remote *remote)
> >  	int triangular = is_workflow_triangular(remote);
> >  
> >  	switch (push_default) {
> > -	default:
> >  	case PUSH_DEFAULT_MATCHING:
> >  		refspec_append(&rs, ":");
> >  		return;
> >  
> > +	case PUSH_DEFAULT_NOTHING:
> > +		die(_("You didn't specify any refspecs to push, and "
> > +		    "push.default is \"nothing\"."));
> > +		return;
> > +	default:
> > +	}
> > +
> > +	switch (push_default) {
> > +	default:
> 
> This is not quite "reorder" but split into two.

OK.

> It is not yet clear
> how it helps, but hopefully we'll find out why splitting the switch
> into two switches is a good idea soon in a later step, so the title
> needs updating to sell that aspect of the change

How about: By splitting the two kinds of modes we can return sooner in
the case the mode doesn't need to do anything else, and for the rest
that reuse quite a bit of code it can be set up after the first switch.

-- 
Felipe Contreras
