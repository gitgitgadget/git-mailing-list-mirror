Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B0BC433E8
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF2F2072E
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="s8ItQecP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgG0UD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgG0UD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 16:03:58 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E4C061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:03:58 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id o2so8073073qvk.6
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9ZNDtRyunKBEQrFPPd+GURo8dn87+nsYg8sxqgG8ijk=;
        b=s8ItQecPkTW/e5nEdOqmqYjEb5HCqZlKtBoiIqzM9FF+/8WFXZvx6RB0HjUb0QCZKO
         E6bIX6ew1C51qNzrinBVYpsJCu5EDRXz9+Nx/fhbCTyPmP4Hdr9C5xJdc4hhtDp7QVRw
         KpSCRnmXdfltFf4dBfZ9Yf1QqnQdnWn2Lq9/XbScNnKYF7CYTWUv3JNncS99I8bl7EtR
         qiK4pSOExmmSRFxMxhxXMJ2HOhTjFxnH6crYkGGCwcPBJmMChQGpNHcDtVl0VwpdZ/yL
         +P4+RmtqZzgUj1vMXSXlsmlAXKcdwzGc/uJ+pdo0k0E41t/EJzeTOOcFftn15NNC9ZbE
         L5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9ZNDtRyunKBEQrFPPd+GURo8dn87+nsYg8sxqgG8ijk=;
        b=cqIxdXpQbHXoa0wbLbgi7yZGmXr3IEXkqMokNHt+kJTX0VEwZwQF0kvIS3TegJIngx
         gW26V91cYJeI67vgSsYpHt34CY3N+ooeHhGb9FoBKfjrfMcw+ARm1FHTNXk7T/D+zHsl
         n09XjlpvTWuVwvE/1NrKGvChZlpmk681bHaqUG8rjJb5uoONtyhuYCNuYZk92kdCkMVG
         TUANZhndpAcT4OEMeULZV4uqL2SBRiP7xtv5YE3AMTBSLLjMu8ohyAuBki82wVI8weJs
         iramYRnzI8oRQC7uxifPJaz985O2ioBz5JxMbcmcsTIswqvi+e0WyxzobpzTSALNeE9N
         Cxpw==
X-Gm-Message-State: AOAM531XsAWmhmWyH97ZvGMdaAmRH80l4VyYGZ1V/0Vvapr0ml0cIcaq
        EELyPOYCOyEBNvRR473Ln3tD9bN04hDkTw==
X-Google-Smtp-Source: ABdhPJzO5+TacWplGcnRVWj1SqIXik4Pm05yes7Xz2kqs9yOpgnVlCkzgxCrUSj8U1NCSTFRx9UCMg==
X-Received: by 2002:a0c:ec92:: with SMTP id u18mr24385961qvo.28.1595880237656;
        Mon, 27 Jul 2020 13:03:57 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id 78sm19108147qke.81.2020.07.27.13.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:03:56 -0700 (PDT)
Date:   Mon, 27 Jul 2020 16:03:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        chriscool@tuxfamily.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] upload-pack: custom allowed object filters
Message-ID: <20200727200355.GD62919@syl.lan>
References: <cover.1595468657.git.me@ttaylorr.com>
 <20200723204325.GM11341@szeder.dev>
 <20200724165133.GA15287@syl.lan>
 <20200727193432.GO11341@szeder.dev>
 <20200727193657.GC62919@syl.lan>
 <20200727195912.GP11341@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200727195912.GP11341@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 27, 2020 at 09:59:12PM +0200, SZEDER Gábor wrote:
> On Mon, Jul 27, 2020 at 03:36:57PM -0400, Taylor Blau wrote:
> > On Mon, Jul 27, 2020 at 09:34:32PM +0200, SZEDER Gábor wrote:
> > > On Fri, Jul 24, 2020 at 12:51:33PM -0400, Taylor Blau wrote:
> > > > On Thu, Jul 23, 2020 at 10:43:25PM +0200, SZEDER Gábor wrote:
> > > > > On Wed, Jul 22, 2020 at 09:48:54PM -0400, Taylor Blau wrote:
> > > > > > Here's a much-delayed v2 of my series to teach upload-pack to limit the
> > > > > > kinds of object filters that it is willing to server in a request.
> > > > > >
> > > > > > Much is the same since last time, with two notable exceptions:
> > > > > >
> > > > > >   - We use the 'uploadpackfilter' top-level configuration key instead of
> > > > > >     pretending that 'uploadpack.filter' is top-level, which greatly
> > > > > >     simplifies the call to 'parse_config_key()'.
> > > > > >
> > > > > >   - Instead of writing an err packet, 'git upload-pack' simply 'die()'s,
> > > > >
> > > > > To clarify, I only recommended to pass the same message to die() as in
> > > > > the ERR packet, not dropping the ERR packet, because ...
> > > > >
> > > > > >     which propagates the error through 'git clone' always,
> > > > >
> > > > > it does in the new tests when creating a local clone, but does it
> > > > > really work with all protocols and remote helpers and what not?
> > > > >
> > > > > >     and resolves
> > > > > >     a flaky set of tests that used to result in a SIGPIPE.
> > > > >
> > > > > This doesn't resolve the SIGPIPE flakiness, because 'git upload-pack'
> > > > > can still abort while 'git clone' is still sending packets.  IOW we
> > > > > still need that 'test_must_fail ok=sigpipe' in all new tests.
> > > >
> > > > Let me double check my understanding... I think that you are suggesting
> > > > the following three things:
> > > >
> > > >   - Write the same message as an err packet over the wire as we do when
> > > >     'die()'ing from inside of upload-pack.c
> > >
> > > Yes, though I'm not quite sure that I understand this sentence
> > > correctly, and unless you can convincingly argue in the commit message
> > > that the die() messages make it to the client no matter the
> > > protocol.
> > >
> > > >   - Don't mark said message(s) for translation, matching what we do in
> > > >     the rest of upload-pack.c.
> > >
> > > Yes.
> > >
> > > >   - Re-introduce the 'test_must_fail ok=sigpipe'
> > >
> > > Yes.
> > >
> > > >      and stop grepping stderr for the right message.
> > >
> > > No, please check them, I love those error messages :)
> >
> > Isn't the problem that these messages only sometimes make it to the
> > client depending on what protocol is in use? If so, the right thing to
> > do would be to not grep for them, since it will make that test flakey.
>
> To my understanding the die() messages always make it to the client's
> stderr when cloning from a local repository.  And that's exactly what
> all new tests do, i.e they do run 'git clone ... file://', that's why
> I recommended to pass those fancy error messages to die(), because
> that's easy enough to do, and doesn't require us to make 'git clone'
> SIGPIPE-proof first (which, I agree, is beyond the scope of this
> series).

Ah, thanks for your patient explanation of what's going on here. These
tests _would_ be flakey if run over non-local protocols, but they
aren't, so we can (and should) safely grep for the right error message.

So the things to do are the original list, nixing "stop grepping stderr
for ...". Easy ;-).

> > Maybe I'm misunderstanding you/the problem...
> >
> > > > Do I have that right?
> > > >
> > > > Thanks,
> > > > Taylor
> >
> > Thanks,
> > Taylor

Thanks,
Taylor
