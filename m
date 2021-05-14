Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACE8C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF056127A
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhENUfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 16:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhENUfB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 16:35:01 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD39C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 13:33:49 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso312495otb.13
        for <git@vger.kernel.org>; Fri, 14 May 2021 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vuFnK2c+/cn4R0uNBCWShAkzHGxTmxJmJEY1wLUo6pg=;
        b=cd2Rmg1ZhnvfREeILNzLSB/lGUr9zp/yp9btgyg3hpvkg0Uh9bsCfOKewJemfpGEsi
         3DwPy26Fo38xK0z0BGdnXZ6c1ElSq2J7CmcT5Ml0bOgZtd2sEhXbaP9g5q4Tj7r4JULD
         wBeKhA+jaP6n7MzLF34lF8091stx3A/C2/aLUt3LV9DRa4L5vrA7xhC9sEyO2UgEACXq
         Vo3q8IgwUhEv2Au2NzmCJ6rwj/GsGieb0nIkr5HcGh9um+Nl6cHLofH3NvNSUtqXhBnP
         LTwjpTlvQzuiS0OxaegWwTtvEVelG7o8hgXNHKT6FAJQ3mI6/2GvO+WU8vzWhjCWguUZ
         mLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vuFnK2c+/cn4R0uNBCWShAkzHGxTmxJmJEY1wLUo6pg=;
        b=h0s8lW0O/EBo2fOVW/l8TEPGovwvlrLOEblsZ51BDQyqtO20dvOWuC6/FAbD13yp0E
         FoB5yl6bE3daWnMVHjByb8b/gxti2ndTXHUk7Uv60brWjR7MYgzsaRjAHRPJzdgaR7AZ
         GQdbwkXYJowIZi99acaZH1+SS+nFneld/Ba/yNNZPB4mId/xOEqz5lbnZPPSJy2cThAn
         l9jsp4xsfy+YZpuMUIxYyebEd7MQPoTDpwgl1CjjBcyr5AJtGwEW1FXtqPuBmAW7XJxl
         Wz8V7fEWUx29pTsRPRGdamr01/URyrcLAVsbTuiqQl6GByUovSloCCDNrCykpWxZiXYi
         8CXQ==
X-Gm-Message-State: AOAM532dZVcFpw/zjkWYBLuvDtDR0rHndNfgooAkM5AO77mC2flxfHOI
        ReFN5lsqqG32p3IFW+tgIFE=
X-Google-Smtp-Source: ABdhPJxn+dFIj98HArhfIsmJgB2H0Otkhj4UmPnQ3hk/GapzY67eFBfve7xDUmh3HeH5R+QpLwe7TQ==
X-Received: by 2002:a05:6830:2143:: with SMTP id r3mr19046179otd.165.1621024428826;
        Fri, 14 May 2021 13:33:48 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x65sm1502440otb.59.2021.05.14.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 13:33:48 -0700 (PDT)
Date:   Fri, 14 May 2021 15:33:47 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <609edeab20e55_43127208c4@natae.notmuch>
In-Reply-To: <20210514154316.810-1-martin.agren@gmail.com>
References: <20210514121435.504423-4-felipe.contreras@gmail.com>
 <20210514154316.810-1-martin.agren@gmail.com>
Subject: Re: [PATCH 03/11] doc: doc-diff: set docdate manually
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren wrote:
> On Fri, 14 May 2021 at 14:14, Felipe Contreras <felipe.contreras@gmail.=
com> wrote:
> >
> > Asciidoc automatically generates a date with format '%Y-%m-%d', while=

> > asciidoctor '%F'.
> =

> Is that really the format Asciidoc uses? Not that it matters much for
> the purposes of this patch.

Yes:

https://github.com/asciidoc-py/asciidoc-py/blob/main/asciidoc/asciidoc.py=
#L1189

> > I personally prefer the latter, so only modify it for diff purposes.
> =

> I agree completely.
> =

> > Fixes tons of these:
> >
> > -Git omitted                       01/01/1970                        =
GIT-ADD(1)
> > +Git omitted                       1970-01-01                        =
GIT-ADD(1)
> =

> >         then
> > -               echo USE_ASCIIDOCTOR=3DYesPlease
> > +               echo USE_ASCIIDOCTOR=3DYesPlease ASCIIDOC_EXTRA=3D'-a=
docdate=3D"01/01/1970"'
> >         fi
> =

> Nice.
> =

> If you introduce a separate Makefile flag and incorporate Peff's patch
> to doc-diff "asciidoctor" and "asciidoctor-direct", you'd need to
> duplicate this a bit, or maybe just emit the ASCIIDOC_EXTRA outside of
> the whole if chain.

Indeed.

> You could follow up with the patch below. If you'd rather keep it out o=
f
> your series to avoid it ballooning, fine. I can repost it later, once
> the dust has settled. Don't let it hold up your work.

I'll include it. Seems to fit the context.

Cheers.

-- =

Felipe Contreras=
