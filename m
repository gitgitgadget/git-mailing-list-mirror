Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811DCC83F2F
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 20:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbjHaU4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 16:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjHaU4H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 16:56:07 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DB31B0
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 13:56:02 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso988150276.1
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 13:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1693515362; x=1694120162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BE/2s3jBAUH7zrwiQQiP1VRrPxqifg1WR0De+y8igYs=;
        b=FWbShBYYAkb+PBQ6fTyOl1wvtMxdLMecyVUgQqpSeXxTyl2YSBlOHPfGq0XpkznvLJ
         spcHGnYpUP0hfFFQDdKYsf2+zv8Ug6nfEo2m87CbeqpknL4E/dFEmFLjMcI02exWBtEX
         8bH7Q70zmkz5xc+mF3gkz0CTGMtNAnW+RSbCqHWeOI8o+fq8aHOvQG21wx8xxuOKjsI1
         QUDVL2Bf5zqLVCKJaVlZzlCjsEfaAQZbpdGmaSd25/xTc0HT7kG9koTsXyNgS8MU+nJb
         nN/nEo+y0rIK4SHoA2PDyAMyLQ1+uwmZf99DjMqmxgpdo/ujqTXDhAU7Zd8vHFiZCz1l
         Q7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693515362; x=1694120162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE/2s3jBAUH7zrwiQQiP1VRrPxqifg1WR0De+y8igYs=;
        b=Txg5D8dlBqE6VAk+Lof30ua/U6diuocVRVfvVMmdupV/0MWN3brZZO9DQkggsUEdkj
         JONMXgHImdZuitq77IqDJ/tmiMhcHAF9da1Z4kXxTag93/gh1g/vz1KdzTuOMGa9aRE+
         0moVKAkvXOPuZtBPgTby4ZPIuo2J+jCux4x2TvwxhOVZDnfi7BScc9neXU3P9TdPXazt
         GDfDeVFiDSk6YEdNZojIGLe3pxA0tx7mWyRT4lnISG8/1crXbbxK1o21hwdHuVIrA8QX
         dEgQO+Gi9MLWZVbD/HgpszghC9OV0GAwGA1qWwvcs9VRJstvQ1qdGUp4PXrF1UbSa7+L
         1hWQ==
X-Gm-Message-State: AOJu0Yzpi7hM8VS/l19HgM1iyKumBZTCnsLvWZyxyCdS9zK5BoakqL79
        ZDwcpYBMJ4KHr6RAu43D0s5NFQ==
X-Google-Smtp-Source: AGHT+IG7RXoPB7Oq+6Y3ScM5qNfk5qSdxvaHjDiwAHjsxZijo37axGffnnsiqWUlfn8alga3Q7SkWA==
X-Received: by 2002:a5b:6c3:0:b0:d47:3d16:4b0d with SMTP id r3-20020a5b06c3000000b00d473d164b0dmr869502ybq.25.1693515361806;
        Thu, 31 Aug 2023 13:56:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g18-20020a256b12000000b00d7473b81a2csm519264ybc.26.2023.08.31.13.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 13:56:01 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:55:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/8] merge: make xopts a strvec
Message-ID: <ZPD+X0JihpYzPI6+@nand.local>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
 <20230831071230.GA3197647@coredump.intra.peff.net>
 <xmqqcyz3z032.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyz3z032.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 08:46:25AM -0700, Junio C Hamano wrote:
> > I guess you could argue this is a backwards-incompatible change, but the
> > existing behavior of --no-strategy-option is so dumb that I can't
> > believe somebody would prefer it (plus revert/cherry-pick already use
> > OPT_STRVEC for their matching "-X").
> >
> > I didn't bother adding a test since we're just re-using OPT_STRVEC code
> > that is used elsewhere.
>
> I do not think of any useful way to have "--no-strategy-option" on
> the command line (either as an early part of an alias or in a
> script) that does nothing (it's not like the command requires at
> least one -X option on the command line), either.  Just like
> fb60b9f3 (sequencer: use struct strvec to store merge strategy
> options, 2023-04-10), which met no complaints about a possible
> fallout by the behaviour change, I do not think that this change
> even deserves an entry in the backward compatibility notes.

I concur with both of you. In a project like this one, we should be
rather generous with the set of things we expect users to do. But even
in a quite generous interpretation, I cannot imagine anybody relying on
this behavior, so I think skipping a mention of it in the backwards
compatibility section makes sense.

Thanks,
Taylor
