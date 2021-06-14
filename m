Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7390C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 08:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71926128B
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 08:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhFNImR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhFNImQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 04:42:16 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A728C061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 01:40:00 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso10051644otl.13
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 01:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=VMjDSXjR5s1PsnpUHnkdVjl+CFZfcd2LNtAtjTwdKVI=;
        b=FEdVw/nr+3v7bbv/FreWDPyNLockwmHlwKNRSJ+bIE9TdenIU6fP3U4wEa26lHDiZ/
         PEMzYduf2CNGtY8yXqZYQX75Zyu+lKngZA4EerY9GUNYay7qssI6ZswoR8OGcli1OVEX
         jyn1c/R6+MempqKIY7nFm/gMxYHPqQwnEHvvTGAULxzJF+c6MHQ5HSADgbDej3pbU9B8
         2ICSmLdtjYeus6tbeEhJTWtFbf15h7o7pdjUFsTnYC2sYNTFnHF68plO5NWysRlRXTle
         ernamFwpYAFH2cBlVeNGbGzwj2g4fAx5iIyKknYmrF/ZV8eK+NmLz8YTmlIiKYewnH4r
         w7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=VMjDSXjR5s1PsnpUHnkdVjl+CFZfcd2LNtAtjTwdKVI=;
        b=Ck8CciFD2tYEzn+BLOaWuaZsG9lDP7KyRKnGvxgsqIbcqlKDmxKIXzd6tZQtN6I0Hc
         ayptpXgEkNzbxl0u0E09YpK0uX6by3McVoRtSpTyi82CFnQtZ9KiBS7fhaAzHz1abrVb
         bxRLCsWqUPT7/2kC+pftl+XgMY/WcrJhUqpIhECqXvq1+mDy6wX28vYBh2rTmrWz1l3B
         v9Z5EIujUWZmgzKBkfO5fMJXC6NqyMfbVhQIhGSvg9MOL5wcV1tQuxI9X0HEtczSgi8I
         mkVIfU8Hr6XluuU9aDRjMGQv/rkVFhHpUZjcEfN1TkhlQIlvTEbDO/mZ+UFN5vLovPF/
         L60Q==
X-Gm-Message-State: AOAM530jdz1fXpNZrJ+nacP0EieLU8XPW0UB+WO1RIF8lNDF14SdnIYW
        LIMsCRUqOCNjuwS7i90mNkU=
X-Google-Smtp-Source: ABdhPJwcA4jeD/G/KBMb1AD0tYqJEzIZ/WVA4U5O7imOPGu0EVqhoT6LzrAIpk0NSQVR5n+m7+20LA==
X-Received: by 2002:a9d:475:: with SMTP id 108mr12488132otc.69.1623659999367;
        Mon, 14 Jun 2021 01:39:59 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id v42sm944059ott.70.2021.06.14.01.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 01:39:58 -0700 (PDT)
Date:   Mon, 14 Jun 2021 03:39:57 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Q2FybG8gTWFyY2VsbyBBcmVuYXMgQmVsw7Nu?= 
        <carenas@gmail.com>, John Keeping <john@keeping.me.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <60c715dd9939e_436208f3@natae.notmuch>
In-Reply-To: <YMcIv7q1ctyJ0EZn@coredump.intra.peff.net>
References: <20210609170520.67014-1-felipe.contreras@gmail.com>
 <YMWMuDbctae7tF6J@coredump.intra.peff.net>
 <60c627cac29b3_41f45208a7@natae.notmuch>
 <YMcIv7q1ctyJ0EZn@coredump.intra.peff.net>
Subject: Re: [PATCH] test: fix for TEST_OUTPUT_DIRECTORY
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Sun, Jun 13, 2021 at 10:44:10AM -0500, Felipe Contreras wrote:
> 
> > > Unfortunately, this isn't a complete solution.
> > 
> > Software will never be perfect.
> > 
> > We don't need to wait for a perfect solution, all we need is something
> > better than the current siuation.
> 
> Sure, but if you don't fully understand the situation (e.g., that --root
> and TEST_OUTPUT_DIRECTORY are not equivalent), then you may end up
> revisiting the incomplete fix later,

The fact that you may end up revisiting a solution is a fact for *all*
changes (including 2d14e13c56 (test output: respect
$TEST_OUTPUT_DIRECTORY, 2013-04-29)).

> or even making things worse (as this patch did).

I think breaking the test suite is objectively worse than having a few
extra files in the output directory, but to each his own.

> > > I think solving the whole issue would require a mechanism for passing
> > > TEST_OUTPUT_DIRECTORY in a way that can't be overridden (whether in an
> > > environment variable or the command-line).
> > 
> > Why do we even have TEST_OUTPUT_DIRECTORY in GIT-BUILD-OPTIONS? Looking
> > for a reason there's 2d14e13c56 (test output: respect
> > $TEST_OUTPUT_DIRECTORY, 2013-04-29), there it says it's for
> > valgrind/analyze.sh.
> > 
> > I don't know who uses that script, or how. There's no documentaion,
> > nothing on the mailing list, and nothing found on Google.
> 
> Perhaps 268fac6919 (Add a script to coalesce the valgrind outputs,
> 2009-02-04) is enlightening.

That makes it clearer.

> I don't know if anybody still uses it these days, though. I suspect it's
> outlived its usefulness, in that we would typically not have any
> valgrind errors at all (so coalescing them is not that interesting).
> 
> Possibly folks investigating leak-checking via valgrind could find it
> useful, but even there I think LSan is a much better path forward.

Yeah, but even if they do run this tool, they can set
TEST_OUTPUT_DIRECTORY manually.

The needs of the few should not otweight needs of the many.

> > So maybe:
> > 
> > diff --git a/Makefile b/Makefile
> > index c3565fc0f8..2e25489569 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2790,9 +2790,6 @@ GIT-BUILD-OPTIONS: FORCE
> >         @echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
> >         @echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
> >         @echo X=\'$(X)\' >>$@+
> > -ifdef TEST_OUTPUT_DIRECTORY
> > -       @echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
> > -endif
> 
> I don't personally have any problem with that. It does mean that "make
> t1234-foo.sh" will behave differently than "./t1234-foo.sh", but that is
> already true if you set GIT_TEST_OPTS.

Only if you haven't changed TEST_OUTPUT_DIRECTORY since the last time
you ran 'make' on the top level directory.

And of course if somebody really wants their environment to be honored,
that's what "make -e t1234-foo.sh" is for.

Cheers.

-- 
Felipe Contreras
