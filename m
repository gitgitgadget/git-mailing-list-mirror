Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D71C433E0
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AEF20729
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9738WbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgG0Tei (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0Teh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 15:34:37 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B70C061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 12:34:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id g7so9959212ejw.12
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vw8utnN9/z2KEf7QjZl2Uc23X1pLBYQE6l4mISF7KPc=;
        b=n9738WbKbgysFky7OESCR9YrH6ROgSOlNO9WymTPilzRCLCwfVSpfC/nj+qupHDN66
         4nnVddwjXBTjTSbv9733JGTm+vrcWVePyURvf2jnS4VFPdwX+mnowAjP5+3Yc8D0266F
         5gHfnVNIjsVjiugBHJ0tZ3cQ8jdIky2QR4/39O+gXA3XTl9YhI1TE4YwQf5v6ZGU4B/l
         eRBlqFNmiCr5q/yCYYJUeHv8dHba8PiSWGqjkTBwWkMM7rZMEHVUUXN143PBH4mwLWj0
         ZXRLAV8LqITCKQCdTlKPCS/2JnEjJs+HrwBGzsZhh5Cgektf8NMQ3bSEDO+gZe5ZBbt7
         takw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vw8utnN9/z2KEf7QjZl2Uc23X1pLBYQE6l4mISF7KPc=;
        b=GYl572bJX5yqKww2UDGwTkJ7GunuCppNJQir8M5RYA8o4q8Mqd3wUzBJIctfvXC/7m
         AAVpXN2U2R21db1aDxYD3gvlnLmsII7UhCSNt6rxX32wcSMnECORpnlQVWVUmdC+mga9
         +1Dxrxa865GIRexKUl5WNVcUvcQePFr44mCcBDCAG9vQRRf7x8Btr3oGcISiFBojB4DT
         eYm60IoARG4zwRLo8zfIM6oJOGO19uOlmFSCi47YEzh8D0Iqyxk2tzJbyzflOMioaeJS
         Q8TQne0PDA2En+0Z8WLEEUn4jiUXUMWGsIZTe7fDMpKS1rO/wY18uyNH1/5Uz+nX98Uo
         n2nQ==
X-Gm-Message-State: AOAM530WxSATf09D8icggoAu2/7rEP2FCk7VSfisSGG6ZvOiMRaiteV6
        8wMnras8jL9Tf9aRnuD0ZKc=
X-Google-Smtp-Source: ABdhPJztHUUiT9LWKim8fNvlhUyErOgKeFGwBjkKCGAafzwM3VbOKvwj/iB6kudO2G4JZYZ6NitoCA==
X-Received: by 2002:a17:906:b08:: with SMTP id u8mr21167575ejg.401.1595878476165;
        Mon, 27 Jul 2020 12:34:36 -0700 (PDT)
Received: from szeder.dev (62-165-238-20.pool.digikabel.hu. [62.165.238.20])
        by smtp.gmail.com with ESMTPSA id bw7sm7507825ejb.5.2020.07.27.12.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 12:34:35 -0700 (PDT)
Date:   Mon, 27 Jul 2020 21:34:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org,
        gitster@pobox.com
Subject: Re: [PATCH v2 0/4] upload-pack: custom allowed object filters
Message-ID: <20200727193432.GO11341@szeder.dev>
References: <cover.1595468657.git.me@ttaylorr.com>
 <20200723204325.GM11341@szeder.dev>
 <20200724165133.GA15287@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200724165133.GA15287@syl.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 24, 2020 at 12:51:33PM -0400, Taylor Blau wrote:
> On Thu, Jul 23, 2020 at 10:43:25PM +0200, SZEDER Gábor wrote:
> > On Wed, Jul 22, 2020 at 09:48:54PM -0400, Taylor Blau wrote:
> > > Here's a much-delayed v2 of my series to teach upload-pack to limit the
> > > kinds of object filters that it is willing to server in a request.
> > >
> > > Much is the same since last time, with two notable exceptions:
> > >
> > >   - We use the 'uploadpackfilter' top-level configuration key instead of
> > >     pretending that 'uploadpack.filter' is top-level, which greatly
> > >     simplifies the call to 'parse_config_key()'.
> > >
> > >   - Instead of writing an err packet, 'git upload-pack' simply 'die()'s,
> >
> > To clarify, I only recommended to pass the same message to die() as in
> > the ERR packet, not dropping the ERR packet, because ...
> >
> > >     which propagates the error through 'git clone' always,
> >
> > it does in the new tests when creating a local clone, but does it
> > really work with all protocols and remote helpers and what not?
> >
> > >     and resolves
> > >     a flaky set of tests that used to result in a SIGPIPE.
> >
> > This doesn't resolve the SIGPIPE flakiness, because 'git upload-pack'
> > can still abort while 'git clone' is still sending packets.  IOW we
> > still need that 'test_must_fail ok=sigpipe' in all new tests.
> 
> Let me double check my understanding... I think that you are suggesting
> the following three things:
> 
>   - Write the same message as an err packet over the wire as we do when
>     'die()'ing from inside of upload-pack.c

Yes, though I'm not quite sure that I understand this sentence
correctly, and unless you can convincingly argue in the commit message
that the die() messages make it to the client no matter the
protocol.

>   - Don't mark said message(s) for translation, matching what we do in
>     the rest of upload-pack.c.

Yes.

>   - Re-introduce the 'test_must_fail ok=sigpipe'

Yes.

>      and stop grepping stderr for the right message.

No, please check them, I love those error messages :)

> Do I have that right?
> 
> Thanks,
> Taylor
