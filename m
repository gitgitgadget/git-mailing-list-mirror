Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AABC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6462086A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WC8gRd2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgKXUOZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKXUOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 15:14:25 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610F4C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 12:14:25 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id p6so8879803plr.7
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 12:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NlRdD9SOz9vR9KADUOvaibwkUf8E2Sy9srg8aSmptg0=;
        b=WC8gRd2AxNZyyf+ORp8vvVRK01+6w4hPtXdd4XOJAh8nNkIBAsQtSWZzCcyn1mfNkm
         uJMglLebOo1B/Fk221Ok8nrKHr+gzsilvEa3G78sdg9HazRTFRQuv15GxBb87OfmH91S
         0YqkkTTT4XSi61vtpVhmvcXnS29AUahAOUsrouVJpGSWYXXc0ekGIF12Oar1CB5V61jU
         BTtxYp8Y6vOxUEWX+5UHWD/ZdA4acuMDGlW2Raml7DAa4N+4h7SC0EtlAC2M4p2S1/bH
         X796NdurQYcEw2W/PgY/Yl3ItSgOCFpxLormh2SqoyhvlswGPjexBcG7kTUU47CNT7MO
         x9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NlRdD9SOz9vR9KADUOvaibwkUf8E2Sy9srg8aSmptg0=;
        b=q/Q6JDvBuviKij1ywaT8SLDmOYdNW6fPleKe+8X/zBr/fvQ3qpBYoSbSMknSoX8Nvx
         Ce2BKD2DDjgdTmlOtVAvDCxCDFPU4ECWNxblZi0R1T1+QpT9fNf8TrwMcmbWj4ekItlz
         mzrdVmU+4vtrXIPlKuWWpeTqUmYvIK2AhGCRuPT8OdoSF70ZiDbmUJMrTM/w33u1yaPy
         /hWvbc3t+IAKhkEjBdLHrPALefnoz12GDeRkJCh0/MYEYukZ4rUjwPsgkIE/7iFrd7ew
         VViJw/k2skJZzLzMI12rwNv2GlOv8S4pQWs/UL5nkqEuz559b6I4DAN8AGuV0PWxZVMz
         mOcQ==
X-Gm-Message-State: AOAM5313ozZ7OtFCm4BD4D0tYo0zyj76uCaqWrdE775N5IL6X46EtaTW
        aRoYyj+rG//dp9uUTQ9WIc1xeCvFnPDcKA==
X-Google-Smtp-Source: ABdhPJzDYvPF8rBPTeuD5iWJlSexRR1m00oVjQDCjEXI2l3aeCm8YSvecpm98XewmVFtuM2LQZQCWw==
X-Received: by 2002:a17:902:724c:b029:d9:e964:c4a4 with SMTP id c12-20020a170902724cb02900d9e964c4a4mr23903pll.82.1606248864703;
        Tue, 24 Nov 2020 12:14:24 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id h3sm15228807pfo.170.2020.11.24.12.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 12:14:24 -0800 (PST)
Date:   Tue, 24 Nov 2020 12:14:19 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] myFirstContribition: answering questions is not the end
 of the story
Message-ID: <20201124201419.GA3783238@google.com>
References: <xmqq3613vrtx.fsf@gitster.c.googlers.com>
 <33e4b940-2560-83b7-1015-100c16c71345@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33e4b940-2560-83b7-1015-100c16c71345@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 09:42:16PM +0000, Philip Oakley wrote:
> >  It's good manners to reply to each comment, notifying the reviewer that you have
> > -made the change requested, feel the original is better, or that the comment
> > +made the change suggested, feel the original is better, or that the comment
> >  inspired you to do something a new way which is superior to both the original
> >  and the suggested change. This way reviewers don't need to inspect your v2 to
> >  figure out whether you implemented their comment or not.
> >  
> > +Reviewers may ask you about what you wrote in the patchset, either in
> > +the proposed commit log message or in the changes themselves.  You
> > +should answer these questions in your response messages, but often the
> > +reason why reviewers asked these questions to understand what you meant
> > +to write is because your patchset needed clarification to be understood.
> 
> Perhaps a paragraph break here?
Agreed.

> > +Do not be satisfied by just answering their questions in your response
> > +and hear them say that they now understand what you wanted to say.
> > +Update your patches to clarify the points reviewers had trouble with,
> > +and prepare your v2; the words you used to explain your v1 to answer
> > +reviewers' questions may be useful thing to use.  Your goal is to make
> > +your v2 clear enough so that it becomes unnecessary for you to give the
> > +same explanation to the next person who reads it.

Overall a point I really appreciate having written out here. I think
it's a good addition to this doc.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
