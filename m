Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763D4C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345912368A
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 20:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgLPURL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 15:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgLPURL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 15:17:11 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22660C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:16:31 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id be12so529836plb.4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 12:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C/pi/daXye3k4juEV+2upK2Ccbo7PDqNYJVuOiv69gQ=;
        b=I3T0VuaB6E8GNdCyz+MnAj9N1+I5PAl4mo3E83YzZrFHGW6qqKK8SfQviyYu2XiWrb
         Ybe3/fmLyXf0C65eAMREYSFK97ahqXPmBCtntoGRxhuR7WJ0ifvIQKoPJKRBJ7pE7BkV
         zvRfLpRBLu38rQiE5cY7FrlRuutBjFTftWs5bKeKCCWuvft+7J/h/VFrrKQRPXIXMYPv
         vCYzUjQ0Sb6fLkc8EqP/n9te9VuRf5lgvmdvCT9X2qq3/Q7McZ69zIyMivSDrTJjTe47
         2EH1X0iblc65XAKjid3P6xbWLn4HrUlr+iS/G2M5eoerpJu2x5xKP7kY/fLrVN45qzuL
         YuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C/pi/daXye3k4juEV+2upK2Ccbo7PDqNYJVuOiv69gQ=;
        b=CWE/Co0n48G/n/bFoOXZrQI7fEwhXqknDHqALdqhwzLfLyswkAH07SvgLAOft4dRoq
         Cqia+XbDbtXdh6J6cCiF/bgS1Ogd0b8O/nGUBSP5f5h0J7Wtwq9ThZZWrW+21uBf08zE
         ELZNi/LtGXbV/PIo0orY+AZm01yYUyGfIwMi9d4d7oBj2NaSEfvkTBNGxPiacEBOsJ/Z
         HgPEu7/ytGXlyu3JHgJz0KUNhkes5Bz8l6FEN/IyRVTpy5HdAo/zhJXQh04TPFwMQx+T
         2WUZ5/FdGTnVmT59otLHtoCT8/HyX3Uj8IgmYnT1kGMdIyB8AzUpUJgWbvqCO2cSDUKV
         iiiA==
X-Gm-Message-State: AOAM531a0/N4MkMG+PcZSJdVrf+Q58LnM03ftKjkrRBxmTrknzfqDpL1
        /D6GwpraxpJ6z9POJculrfU2Vg==
X-Google-Smtp-Source: ABdhPJwGAkHWnxxdAjcYbuQCO1sa6S/YJCHtcw9ITnQHPersHrVvAWvdGcwW1PE0vOzXwANjFuv3hw==
X-Received: by 2002:a17:90a:db0b:: with SMTP id g11mr4488782pjv.168.1608149790467;
        Wed, 16 Dec 2020 12:16:30 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id v26sm3433313pfm.203.2020.12.16.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 12:16:29 -0800 (PST)
Date:   Wed, 16 Dec 2020 12:16:25 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 00/17] propose config-based hooks (part I)
Message-ID: <20201216201625.GF3783238@google.com>
References: <20201014232447.3050579-1-emilyshaffer@google.com>
 <20201205014607.1464119-1-emilyshaffer@google.com>
 <20201216003408.GR36751@google.com>
 <xmqqlfdy6025.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfdy6025.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 04:56:18PM -0800, Junio C Hamano wrote:
> 
> Josh Steadmon <steadmon@google.com> writes:
> 
> > On 2020.12.04 17:45, Emily Shaffer wrote:
> >> Hi folks, and thanks for the patience - I ran into many, many last-mile
> >> challenges.
> >> 
> >> I haven't addressed many comments on the design doc yet - I was keen to get the
> >> "functionally complete" implementation and conversion to the list.
> >> 
> >> Next on my plate:
> >>  - Update the design doc to make sense with what's in the implementation.
> >>  - A blog post! How to set up new hooks, why they're neat, etc.
> >>  - We seem to have some Googlers interested in trying it out internally, so
> >>    I'm hoping we'll gather and collate feedback from that soon too.
> >>  - And of course addressing comments on this series.
> >> 
> >> Thanks!
> >>  - Emily
> >
> > This approach looks good to me. I'll look forward to seeing the updated
> > design and the feedback from the internal tests.
> 
> Thanks.
> 
> By the way, es/config-hooks does not seem to pass 5411 (at least)
> even as a standalone topic, and has been kicked out of 'seen' for
> some time.  Has anybody took a look into the issue?

Yeah, I looked at it today. Looks like an issue with not paying
attention to master->main default config, since I added a new test to
the 5411 suite (which means it wouldn't have made a conflict for someone
to say "ah yes, s/master/main/g"). I am tracking down couple of other CI
errors today and will send a reroll today or tomorrow.
