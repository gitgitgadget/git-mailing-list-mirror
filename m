Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E54C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 22:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD4461279
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 22:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhFRWP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 18:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbhFRWP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 18:15:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699D1C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 15:13:48 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y15so2974366pfl.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cGdLgZ43eBSh5ws+6rop56HbJMoyl72pykHTSd1jSkI=;
        b=LJrZP6JU0/UvGGCHkOF8J9oCT5t7ohEa3hBTJOmj2Rhx/y2WHW3C09JPIWoQsBo7Nj
         8zCKxGRIlZd1gnPwXChhXSOO4gzqeQ8nFYI0gCP/PM4Ij+3h55ke+wRf2DmskOQsPhCP
         9XFW1H46rAD1vHc+wAMYAtxQvewNH3zExH+9sTJeTza6SnRxrf2zAsFMQ7zA96rsPUJg
         pkEIC24lMC933Y3399a9ZYIwl2o5BIJ5md73RFFXJfKLZt0/1rMuPqZo/S5iNL9RHL6N
         0N0MwhIgG5NTq7bxvKsj+r91Q5Z5V+EK1LYzLio1LuyIUIwbHSY4+oCYfvBamSwQvkuA
         UGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cGdLgZ43eBSh5ws+6rop56HbJMoyl72pykHTSd1jSkI=;
        b=pCfMWyjYCSg6TH781+9UMEwQFGsZ11Eg87FGP+pu2J4VBjrL/n3ElxI1FHMi/VoWc6
         iFyEICsZsCyySAGjOEqjvRdwO29UFSx5CgDCyXL1e2MPiSZ+OE6+MsN1kc/pKwMHuVmn
         5ZcycHSwk5bmMmYTxbrkN6KoN0GlF62e1Mi9SAShybf61n3NljXtOnG3bIs4OAcnHA2t
         UNl7k0G7GoD5vKiU/NEjiuuEGK6TuTKFKQ9cl8+vOj0CN4O3ETH6Yr7hdt0XZ6aHdh/N
         wfhbUiSqHbUzFxIXNngYNlGPSeuFaDnHtjtNk4d8OEEhR1m7S/23bpYRJef7w6EBaezH
         /Lsw==
X-Gm-Message-State: AOAM531ac6t63UIVMdzqF3s27oQE/GSGlPskaFoMI/HPpFZUZQz+jXOn
        CoLK0e6MfaVcq4Uia/OFQy97Kw==
X-Google-Smtp-Source: ABdhPJyyLDAf8gwLTYaCU8mfTBkA+NGChxBrI2ZtaGTOhRyOFKvWD7zkBv7W0z2NImO682d6dHFKbQ==
X-Received: by 2002:a63:561d:: with SMTP id k29mr12022685pgb.335.1624054427673;
        Fri, 18 Jun 2021 15:13:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:551d:e7ea:4a2f:6667])
        by smtp.gmail.com with ESMTPSA id v14sm9869472pgo.89.2021.06.18.15.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 15:13:46 -0700 (PDT)
Date:   Fri, 18 Jun 2021 15:13:40 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 01/30] hook: add 'run' subcommand
Message-ID: <YM0alLP5U81D+ZI0@google.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <patch-01.30-447d349c738-20210614T101920Z-avarab@gmail.com>
 <YMfLO9CT+iIDR3OA@google.com>
 <87lf7bzbrk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lf7bzbrk.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 11:36:26AM +0200, Ævar Arnfjörð Bjarmason wrote:
> > Overall, I think I like the direction your reroll is going - I've needed
> > some time to process it. Hopefully I'll be able to get through all or
> > most of the series this week, but there's a lot going on here, too. I'll
> > do what I can. Thanks for the help.
> 
> Yeah, will reply to any qusetions etc; and as noted above my initial
> goal here was "hey, what about this approach", so if you wanted to pick
> this up & run with it...
> 
> This particular version of the series is at github.com/avar/git.git's
> es-avar/config-based-hooks-3 b.t.w.

Have finished scanning through the rest of the series, and I think I
understand your goal a little better - you are not saying "let me take
over and drive this part of the feature set", which is what I thought
initially. Instead, you seem to be saying "let's chop it up this way
instead".

I don't dislike the reorganization, but I do still wonder whether it's
a setback to the progress the original series had made. I guess it is
hard to know - I had thought the original series was pretty much ready
to go in, therefore making "what if we ordered it this way" moot. But it
seems that you disagree.

Anyway, I do hear also that you don't have interest in driving this
subset to completion, and that's fine. Correct me if I'm wrong.

I'll keep thinking on this over the weekend. Thanks for the suggestion.

 - Emily
