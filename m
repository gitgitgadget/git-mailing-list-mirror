Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC3DC4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18FE46120E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 14:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhE2O0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhE2O0p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 10:26:45 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCA5C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 07:25:09 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so6357385oth.8
        for <git@vger.kernel.org>; Sat, 29 May 2021 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=q/kls+YNX/JOofvkstoIZ4p2q+coBQUdAlzfPWifHhw=;
        b=ULrLQf2JKhARKElQfoiN7I9NLEud2QdOout9X2fVH2Nb5XbQV2/tGEy38o+Q2kcZHr
         2LNJl5bQvl8G2LjyFxZbTVZAspzY5sqOSlCUbNPIOva3jnLsGc70bIkfJq6PdlegRPql
         +K8dH8fMPg00Z627Bq1b+I4iX6YnLnM5GR1TsljNhF6E0c8V2y37XVnv2llmwXBGDRGJ
         NG2dZke2OW9e1x8tpZatCVsbBqI374F0P1E9o/DSoy+YXP2FB6kkNVR1582AC23bgGgQ
         8M0YkKdAo2hVjkSxqgzbGhk48X70l/Xslr2vC9al0iOl5CAbdASAKdj2t3+6pZmc4leV
         Vlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=q/kls+YNX/JOofvkstoIZ4p2q+coBQUdAlzfPWifHhw=;
        b=pC6C8DXVewczEfl1LJxJjcSAj7goVE2WurS8YALWYYycAE20vLad52X5urnh3VqAi7
         SVqJQEFMR3vLTzffzNvVXkWcXQUf5RYHNHSVfU0FoTqP3LM7iqlJM2Bq40lGFYHRVmmy
         Ev5/p74vYbEjc1DoIj/ZPvgdyciQzkYi0jta2kex511BPnPy4KBXVlGdYF9oao+pW3BX
         +lKRSS0kYCBh/U4rHhDp7torvoRaY36h41gagYCsjHrIesuANvGaViFb2n5aI163+6qg
         5Hzo+ngeq6nx9j/KcTKZ1YFD0JDGJYrhtCzzLAOfqR7FnTJnjv7euU/9IyiNgL/QB70S
         A2AQ==
X-Gm-Message-State: AOAM531HIacHGUw1ADPE0SkSKs3UoHJ90aYPwmu1lDMP/QROOJox7XSf
        sxDDGBdMMvM6UuZ9h1fFVoY=
X-Google-Smtp-Source: ABdhPJzoXXyIhM/cs4dw600bcp6OsiCO+Kl4YWTaYsKGE7KIsf7z1T1/UJeREQJi5/Hg9iR5AZiRBw==
X-Received: by 2002:a9d:6ace:: with SMTP id m14mr10776138otq.207.1622298308820;
        Sat, 29 May 2021 07:25:08 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x65sm1824573otb.59.2021.05.29.07.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 07:25:08 -0700 (PDT)
Date:   Sat, 29 May 2021 09:25:07 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Message-ID: <60b24ec34b065_2650882086e@natae.notmuch>
In-Reply-To: <87fsy62bs1.fsf@evledraar.gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
 <patch-08.13-f1a879a8ae9-20210528T092228Z-avarab@gmail.com>
 <60b116015b98a_4b03220857@natae.notmuch>
 <87fsy62bs1.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v5 08/13] send-email: use function syntax instead of
 barewords
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Fri, May 28 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> Change calls like "__ 'foo'" to "__('foo')" so the Perl compiler
> >> doesn't have to guess that "__" is a function. This makes the code
> >> more readable.
> >
> > Agreed. Ruby has something similar:
> >
> >   foo arg1, arg2
> >   foo(arg1, arg2)
> >
> > As a C programmer I find the former a quirk of the language, and much=

> > harder to read.
> >
> > If it's a function call, present it as such.
> =

> I'm not too familiar with Ruby, but the important part here in Perl is
> that it's not a "foo()" v.s. "foo" shortcut for a function invocation,
> it's unambiguous whether that is a function and what its arguments are
> until at that point in the program. Perl has dynamic grammar, you can't=

> parse it with a regular grammar without executing it.

Yes, that is the important part, but not the only part.

I'm saying in addition it's easier to read for most git.git developers.

-- =

Felipe Contreras=
