Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E01C433E0
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7962074F
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="DfCDBwTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgG0ThB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgG0ThA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 15:37:00 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F97C061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 12:37:00 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o22so12917238qtt.13
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mHGimGpaIPiprRfk+oIXM06NPJNXk4Fkga37zhVw460=;
        b=DfCDBwTaC5nTqqUYcZPFb5ewQQRw8VQtXBDF356JJucf/EqYkkxj4ds+uiqGmEsTd4
         phWVIAOdete+VbrWOyp8gomu5ZuG5QePg8rUyGCzvYVEHM2X/eFncLEf5vXD3eszZxaQ
         OWOk5Sp9RVhfDyH2cgFooZ9so400tDDTNGT5/Vgs1nHniVb9EQsw0DZMFxiqPW6hDrQ2
         IYXur3MwCl0slDxq6q4hbgu8t66oGM4HIBHEdQTJXj1cjFiET6tDQMfE/Vis4qDp7W09
         dRZNWZ+EHMyBHuDvbcRay14XkFuVtUaGniL1D6PStp1kR4riHa7rl33paqbSoIlphBwh
         qulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mHGimGpaIPiprRfk+oIXM06NPJNXk4Fkga37zhVw460=;
        b=oJ3ufG9jb6VVtPdMzwX9dJ7Wqy/SnTKCpdcN2xftdKeAW+z3AeGTVz+zk4qvYEG/W7
         d0PhsLi2c2RnlK7EzTdvSD9TLH69L51kH0dgV2nQNC2WH4udjoJ4RJ4UrxAO2C2+X4Zj
         7EhcW5WHLAwYhti52xrKnRoHa0DRlkeNXfjj0Z88kwlb6kPmoP6dsj0Vfi52k3ec5OK7
         QonYs/HezQHYMQkP11pwdpipnJLDsMRtyn9JqfsQ8V10Bhk+8WcaQ07/XoZrM50wULI5
         IM5wEDqAFIgd1tjozca5Jeki+MfdIf8xu5RMZzzqQKvHo41yQfnZ3O6U1bc9Pzq0ShcE
         SWzw==
X-Gm-Message-State: AOAM531C3+FT5CWVsW1zUHspniCxFNgKAMSh6nw08Msy39WHnYkPXV7f
        1zIMyviDh2OnbQqpAjKvrVZkZw==
X-Google-Smtp-Source: ABdhPJxu7ER6QdjhNw0jUSR0B4cJB1kLLvJt+C2Trz3GrYQCFZG2pX0M5vhlh2jMSf2pD4UDLZPcmA==
X-Received: by 2002:ac8:429d:: with SMTP id o29mr24470241qtl.230.1595878619611;
        Mon, 27 Jul 2020 12:36:59 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id g136sm20253115qke.82.2020.07.27.12.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 12:36:58 -0700 (PDT)
Date:   Mon, 27 Jul 2020 15:36:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        chriscool@tuxfamily.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] upload-pack: custom allowed object filters
Message-ID: <20200727193657.GC62919@syl.lan>
References: <cover.1595468657.git.me@ttaylorr.com>
 <20200723204325.GM11341@szeder.dev>
 <20200724165133.GA15287@syl.lan>
 <20200727193432.GO11341@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200727193432.GO11341@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 27, 2020 at 09:34:32PM +0200, SZEDER Gábor wrote:
> On Fri, Jul 24, 2020 at 12:51:33PM -0400, Taylor Blau wrote:
> > On Thu, Jul 23, 2020 at 10:43:25PM +0200, SZEDER Gábor wrote:
> > > On Wed, Jul 22, 2020 at 09:48:54PM -0400, Taylor Blau wrote:
> > > > Here's a much-delayed v2 of my series to teach upload-pack to limit the
> > > > kinds of object filters that it is willing to server in a request.
> > > >
> > > > Much is the same since last time, with two notable exceptions:
> > > >
> > > >   - We use the 'uploadpackfilter' top-level configuration key instead of
> > > >     pretending that 'uploadpack.filter' is top-level, which greatly
> > > >     simplifies the call to 'parse_config_key()'.
> > > >
> > > >   - Instead of writing an err packet, 'git upload-pack' simply 'die()'s,
> > >
> > > To clarify, I only recommended to pass the same message to die() as in
> > > the ERR packet, not dropping the ERR packet, because ...
> > >
> > > >     which propagates the error through 'git clone' always,
> > >
> > > it does in the new tests when creating a local clone, but does it
> > > really work with all protocols and remote helpers and what not?
> > >
> > > >     and resolves
> > > >     a flaky set of tests that used to result in a SIGPIPE.
> > >
> > > This doesn't resolve the SIGPIPE flakiness, because 'git upload-pack'
> > > can still abort while 'git clone' is still sending packets.  IOW we
> > > still need that 'test_must_fail ok=sigpipe' in all new tests.
> >
> > Let me double check my understanding... I think that you are suggesting
> > the following three things:
> >
> >   - Write the same message as an err packet over the wire as we do when
> >     'die()'ing from inside of upload-pack.c
>
> Yes, though I'm not quite sure that I understand this sentence
> correctly, and unless you can convincingly argue in the commit message
> that the die() messages make it to the client no matter the
> protocol.
>
> >   - Don't mark said message(s) for translation, matching what we do in
> >     the rest of upload-pack.c.
>
> Yes.
>
> >   - Re-introduce the 'test_must_fail ok=sigpipe'
>
> Yes.
>
> >      and stop grepping stderr for the right message.
>
> No, please check them, I love those error messages :)

Isn't the problem that these messages only sometimes make it to the
client depending on what protocol is in use? If so, the right thing to
do would be to not grep for them, since it will make that test flakey.

Maybe I'm misunderstanding you/the problem...

> > Do I have that right?
> >
> > Thanks,
> > Taylor

Thanks,
Taylor
