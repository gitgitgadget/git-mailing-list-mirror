Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6E4C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7137F61028
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349109AbhERMaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 08:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbhERMaA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 08:30:00 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02745C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 05:28:43 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so8447634oth.5
        for <git@vger.kernel.org>; Tue, 18 May 2021 05:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=bsgewUzR5jkrnzPlOrrMtvc9JoeL5FpRpNkfRi4dg3g=;
        b=jhFGDslXpnsdoaaNh0wx+P8cYSqtKeFP4NoFR9EDHShLq1IUm/LJ6jXfnHcmMnzndv
         0vPHp67opPzoduc+2nohbeFfJGhpDKIGsiH2u1OhZPJLf8yel5L/vu8EV4Ds/bmLdp0V
         ZdE758+vsrbUTob7jusQCHuLaQ8ybfzDp3eZxKAeH1KmvOq8K9+iZ+1E21YGzuUabO78
         DPMuRY2eRVqO3tZmrVaPXo/K835LAIYfGBHTEBeoR7BHFettCR2ekHpSwlKlq6VUZsFw
         Vz5Hm8ApJKKnzQOBXWtEulGuFsP6+58qx3IkaX048wA6bk11QvM6ZtbfaciEavkIZfbH
         RMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=bsgewUzR5jkrnzPlOrrMtvc9JoeL5FpRpNkfRi4dg3g=;
        b=S4hYs1snb7RLAzTqDDCBxKuGepu+B9uUbwbyYamxUPvctvxXPfTbIkCyRc32caNZ+f
         aPw5y7d3f8pFgHUldbw8J0IqIlql3Zf5UVRP/GujqH1ZurqRtuZT6hacwlpUypCW0Z4G
         GFKdIhVCstS+ysW8AnhHJRDe5o7nL91BAxlDaRNsdSCh/M1TDJuZ/D5BPkYNnNWSYG5G
         PcEVAv/6NRaVBD0da45N3vwqKGUImMBpd7X+Qc3wXUR9TZAoZLA+WeYTdfyn/WIQkSkW
         u2a4Nof2/95axq/hPqOSNIIFTLsxhuQJAWWxrdOcel16f5IT0JoMmcTR90QJ9u5U4lda
         DVJQ==
X-Gm-Message-State: AOAM531PaSOJ6/ROl+Rgk89EefkNDO3cRK29AQPnIXi8XCisLFwh5fi6
        WvmHzvMc7RwYGrYdvM1cAYU=
X-Google-Smtp-Source: ABdhPJw6o/XGESz9WdA8YALLqhxZ7zQ+JeQZz0nfyE5FFWMV+RKOBQiUsls5FCXWtZ+5VeuiUe0Dcw==
X-Received: by 2002:a05:6830:16d4:: with SMTP id l20mr4024945otr.356.1621340922370;
        Tue, 18 May 2021 05:28:42 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id d1sm3432392otu.9.2021.05.18.05.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:28:41 -0700 (PDT)
Date:   Tue, 18 May 2021 07:28:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Richard Hansen <rhansen@rhansen.org>
Message-ID: <60a3b2f8eb3b_1519872087c@natae.notmuch>
In-Reply-To: <YKNl6IAFGezjCZUf@coredump.intra.peff.net>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
 <60a2a670648b1_12801e20895@natae.notmuch>
 <YKNl6IAFGezjCZUf@coredump.intra.peff.net>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, May 17, 2021 at 12:22:56PM -0500, Felipe Contreras wrote:
> 
> > > > If we must not use @, then I would rather use `master..mybranch`, or
> > > > something like that. HEAD seems like a technical accident. But of course
> > > > I would prefer HEAD to nothing, because at least it qualifies as an
> > > > ending point.
> > > 
> > > I agree that if the purpose is to be illustrative, using shortcuts like
> > > "an empty endpoint means HEAD" is not helpful. And likewise for "@"; if
> > > you need to have "revision range" defined, there is a good chance that
> > > you don't know about shortcuts like "@" either.
> > 
> > But they don't need to know what @ means; it's clearly a shortcut for
> > _something_, and that's all they need to know. In fact, I'd say most
> > people can quickly realize what a shorcut for it is, which is why it was
> > picked by the git project, and many Mercurial projects as well.
> 
> That's my point. It _isn't_ clearly a shortcut for something for all
> people. If you are reading the glossary entry for "revision range", you
> might not know about the ".." syntax at all. So what does:
> 
>   foo..@
> 
> mean?

An ellipsis is a common feature of both human and computer languages...

  The ... fox jumps ...

Is easily understood by most English speakers, so is a, b, c ... z.

It is used in math as well 1, 2, 3,..., 100.

It's used in computer languages, like Pascal, Modula, Oberon, Ada,
Haskell, Perl, Ruby, Swift, Kotlin, F#, and MATLAB.

  (1..10).each { |i| puts i }

I think most readers would infer that a) the starting point is at the
left of the ending point b) there's nothing after the ending point.

So what could the thing at the right of the starting point, follwing an
ellipsis, and not followed by anything else be? I think most people
would get it.

> I expect most people would figure it out. But if your point is to serve
> as documentation, especially for people who do not yet know all of the
> concepts, then why not try to reduce the chance of error as much as
> possible?

We want to minimize the chances of error... up to a point. We also want
to be useful.

Moreover, most readers don't learn at the speed they read, it takes
time, and often practice. Copy-pasting `master..@` to their terminal
will most likely work, and with any luck they'll understand it right
away.

They don't need to understand revision ranges completely when they read
the glossary, they just need a brief explanation.

[1] https://en.wikipedia.org/wiki/Ellipsis

-- 
Felipe Contreras
