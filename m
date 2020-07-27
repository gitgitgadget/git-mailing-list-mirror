Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3BDC433E5
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 295B22074F
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIkyBWGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgG0T7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgG0T7R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 15:59:17 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D061C061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 12:59:17 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c2so7198171edx.8
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Uq/ulHhjtsALGxCIV9oWTe5daiVwEQUkZVBYYQS2BTA=;
        b=XIkyBWGAOuUuUs4ZFAYPLkxILRv5dLrui91ctWjliRUEXGeHlupLu8YEbaSUdRx9zl
         jB3spon+hlnL4lYnjnNZZyK7LE4S7e5enz1ZvhH+zT8NzdoYVIeKJyRT+W//BPm8FP4+
         UYENLjJQna7KGTk+p8A8OKeVF/dDtiaFQYNVTFaioiqmk1AoCyWo5/Gjx+wwz86RXpyN
         pejahMb4hRKGbGzdFQ8sZbmc8+V8oY9y4zFJTYpfb5t/husNdxsP2tWDj9jSb1vQyBF3
         xtkMcvs0P6Vj+cmRtF0UPJ+saPoscxgxpjhyikWP1rV/h3X1JYEjO43w+H4f6TbtMiBr
         ouCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Uq/ulHhjtsALGxCIV9oWTe5daiVwEQUkZVBYYQS2BTA=;
        b=hSllt+4vAtvAEL2Nafxmw95QrMGC1aqTusm0RxLJRcfw1LQqo7ep/hsLmaQ+63l4ZF
         X/6KicFFECXDDdH6CNz42fW7QGB7wqZRCfxSTTrsCtc1FhIaHniAaKzZT4E2IXEiWujW
         3uS3VoFkvR3sfOQpi28gdlDxiTDzpsTIrzZHNXigddFOZsVipBPJ7iD5UVlKcTb/BvUM
         lcWfk7cpNr6TNMXBbzTPEZw7EPyWl6HkZU5iMYSk4dncMKbFMz8NtJ7R5JUADUEo+FD5
         Uik60rvh2LhCf729KwRB0UjdBuM9jIjCFjFieLcqSyH2drkyeT+IIBsMmPY5MWYhV3JQ
         +BdQ==
X-Gm-Message-State: AOAM532M5emj7hDOehzGB6+fF5agdfTOcguarp0/VjFUgLvIwdWXEkrg
        nh3U0TJRC1evUAOuajEkj68=
X-Google-Smtp-Source: ABdhPJwz/SnmCG1XSmC9k1/xllxN0Y0xRoEi6bsFyoi6tDZamupzly1g/BLGr2a/6wITW6XQXZr2Gw==
X-Received: by 2002:aa7:d6cc:: with SMTP id x12mr23591700edr.354.1595879955777;
        Mon, 27 Jul 2020 12:59:15 -0700 (PDT)
Received: from szeder.dev (62-165-238-20.pool.digikabel.hu. [62.165.238.20])
        by smtp.gmail.com with ESMTPSA id o17sm7593352ejb.105.2020.07.27.12.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 12:59:15 -0700 (PDT)
Date:   Mon, 27 Jul 2020 21:59:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org,
        gitster@pobox.com
Subject: Re: [PATCH v2 0/4] upload-pack: custom allowed object filters
Message-ID: <20200727195912.GP11341@szeder.dev>
References: <cover.1595468657.git.me@ttaylorr.com>
 <20200723204325.GM11341@szeder.dev>
 <20200724165133.GA15287@syl.lan>
 <20200727193432.GO11341@szeder.dev>
 <20200727193657.GC62919@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200727193657.GC62919@syl.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 27, 2020 at 03:36:57PM -0400, Taylor Blau wrote:
> On Mon, Jul 27, 2020 at 09:34:32PM +0200, SZEDER Gábor wrote:
> > On Fri, Jul 24, 2020 at 12:51:33PM -0400, Taylor Blau wrote:
> > > On Thu, Jul 23, 2020 at 10:43:25PM +0200, SZEDER Gábor wrote:
> > > > On Wed, Jul 22, 2020 at 09:48:54PM -0400, Taylor Blau wrote:
> > > > > Here's a much-delayed v2 of my series to teach upload-pack to limit the
> > > > > kinds of object filters that it is willing to server in a request.
> > > > >
> > > > > Much is the same since last time, with two notable exceptions:
> > > > >
> > > > >   - We use the 'uploadpackfilter' top-level configuration key instead of
> > > > >     pretending that 'uploadpack.filter' is top-level, which greatly
> > > > >     simplifies the call to 'parse_config_key()'.
> > > > >
> > > > >   - Instead of writing an err packet, 'git upload-pack' simply 'die()'s,
> > > >
> > > > To clarify, I only recommended to pass the same message to die() as in
> > > > the ERR packet, not dropping the ERR packet, because ...
> > > >
> > > > >     which propagates the error through 'git clone' always,
> > > >
> > > > it does in the new tests when creating a local clone, but does it
> > > > really work with all protocols and remote helpers and what not?
> > > >
> > > > >     and resolves
> > > > >     a flaky set of tests that used to result in a SIGPIPE.
> > > >
> > > > This doesn't resolve the SIGPIPE flakiness, because 'git upload-pack'
> > > > can still abort while 'git clone' is still sending packets.  IOW we
> > > > still need that 'test_must_fail ok=sigpipe' in all new tests.
> > >
> > > Let me double check my understanding... I think that you are suggesting
> > > the following three things:
> > >
> > >   - Write the same message as an err packet over the wire as we do when
> > >     'die()'ing from inside of upload-pack.c
> >
> > Yes, though I'm not quite sure that I understand this sentence
> > correctly, and unless you can convincingly argue in the commit message
> > that the die() messages make it to the client no matter the
> > protocol.
> >
> > >   - Don't mark said message(s) for translation, matching what we do in
> > >     the rest of upload-pack.c.
> >
> > Yes.
> >
> > >   - Re-introduce the 'test_must_fail ok=sigpipe'
> >
> > Yes.
> >
> > >      and stop grepping stderr for the right message.
> >
> > No, please check them, I love those error messages :)
> 
> Isn't the problem that these messages only sometimes make it to the
> client depending on what protocol is in use? If so, the right thing to
> do would be to not grep for them, since it will make that test flakey.

To my understanding the die() messages always make it to the client's
stderr when cloning from a local repository.  And that's exactly what
all new tests do, i.e they do run 'git clone ... file://', that's why
I recommended to pass those fancy error messages to die(), because
that's easy enough to do, and doesn't require us to make 'git clone'
SIGPIPE-proof first (which, I agree, is beyond the scope of this
series).

> Maybe I'm misunderstanding you/the problem...
> 
> > > Do I have that right?
> > >
> > > Thanks,
> > > Taylor
> 
> Thanks,
> Taylor
