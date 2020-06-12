Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8318C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25B020838
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWMfQ8cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFLPOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFLPOs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 11:14:48 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D386C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:14:48 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id o2so5512736vsr.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mdLW43iVIKQGRu6+G5EpfvVDd/rzjik4I5kfUXTZrFo=;
        b=LWMfQ8cvX9ZyIR333hPNUAGbOZ0AUMrcnx4c6eCB7umf8tQ3cQzFcD62FB7pYd/HEi
         UBdvhkjOe7baq4sU+Yon9agX7WQpr7pwgAaGzVH/IRTJ9aT9HEpuRgJF0aXgnSCprBOZ
         82wL87Kx6dkK171MW+ETTHmDrb/0cH243nKO9Xl4Bhqinj2PGbS8wUC8yjoFNeRUOrGp
         +MJKNOusNUMWfEwAhJo8KFfNP29gB7AdlRdIW39nFdz5pn0jCs90z9D0vkLdev/5kP/w
         DWNsu0izje+GwnywePjsVBdyk9ZoKBZBTTdJBiSB95qezek1W4ugzG9OtNw93rzfKYC8
         UWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mdLW43iVIKQGRu6+G5EpfvVDd/rzjik4I5kfUXTZrFo=;
        b=RN88iTVvCvpRvqWz2q6MYbap58pkOX3xeOn05H7/PmCFa3Ft3H4p2Di2DDPQk+/Syd
         4N82gCVriI/Ra3Du21HAbEe1CIx+A4vm892tYSAjFUxOxGZMGmmpk43VsNWv0+4oGlue
         GG5m57E7qMitMT6NxUFRDEmu2XPZnz3qoZIBGXhp0T28dYFEAgMozmV+cEnqnYkguorh
         yR8mUH3joboC5CNifQP58cj2xMppXN9ultTpkuDLww97k3eDmaa4Bj7phLJZpwJ2ZAeD
         O33U5tR//870HoapP8lamAwOA+THjy7kchPZ3jei6MBpxZlP8dux/710cNtPBBaFAuO9
         a6+A==
X-Gm-Message-State: AOAM5315LtH1yR/+/w9LWNWaztNbs1iOgH94rgeSuwWpojWBcAxPS++8
        x89Te6LgGazXmhuzC7MxT/s=
X-Google-Smtp-Source: ABdhPJxnMVSPDy3QEPY6eGdyM0NzhdL1R48FknH0LVEPGn8wzo5BCVA1tn9t9KU6lTIjkIwzu0n1Mg==
X-Received: by 2002:a05:6102:5ed:: with SMTP id w13mr10606959vsf.189.1591974887224;
        Fri, 12 Jun 2020 08:14:47 -0700 (PDT)
Received: from localhost (25.173.196.35.bc.googleusercontent.com. [35.196.173.25])
        by smtp.gmail.com with ESMTPSA id b10sm1003239vke.33.2020.06.12.08.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 08:14:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        <xmqq3672cgw8.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
        <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
Date:   Fri, 12 Jun 2020 08:14:46 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 12 Jun 2020 14:53:34 +0200 (CEST)")
Message-ID: <xmqqy2os2u55.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I just realized that the comment above reads:
>
>         /*
>          * We also leave "master" as a special case, since it does not reveal
>          * anything interesting.
>          */
>
>
> Obviously, we need to change that comment here because we do not leave the
> name unchanged. How about this?
>
>         /*
>          * We special-case the main branch, anonymizing it to `ref0`.
>          */

If you are going to update it, why not make it useful?

I complained number of times during the discussion that the original
comment explains why leaving 'master' as-is does not reveal anything
useful to adversaries but does not justify what the code attempts to
achieve by special casing 'master' in the first place.  

It is not an improvement to literally adjust that inadequate comment
to the new world order to just parrot what the code already says
without explaining why it does so.

	/*
	 * Anonymize the name used for the primary branch in this
	 * repository, but reserve `ref0` for it, so that it can
	 * be identified among other refs in the output.
	 */

is the minimum I would expect before calling it an improvement.  We
could add

	It is often `main` for new repositories (and `master` for
	aged ones) and such well-known names may not need
	anonymizing, but it could be configured to use a secret word
	that the user may not want to reveal.

at the end to explain the motivation behind anonymizing even more,
if we wanted to.

Now, "so that ..." part is totally a fabrication based on my best
guess.  I do not know what the original author was thinking when the
decision to leave the master as-is was made.

Thanks.
