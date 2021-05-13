Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528EFC433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 19:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2033461406
	for <git@archiver.kernel.org>; Thu, 13 May 2021 19:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhEMTeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhEMTe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 15:34:29 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1BC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 12:33:16 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id c3so26290306oic.8
        for <git@vger.kernel.org>; Thu, 13 May 2021 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=65pjJ2po/DMn3P6OIsD7FWSb4eA6uVWQhXJDW1jWwqQ=;
        b=RLjDOdo+FRNP/k/l/MLdVapKEPHStquldEZ9qM3NMiFS9tps6TAfaeV1wZR/veLBnz
         w30A7j5HuQcpWXOKV/yt2U563RnihsE5N/Fi5MVXN+QS//wLdDBlNfq6Kx9qWO78EhZM
         YD0uKp5menMwC1cTHm2zEo+GQktOAUWBnFhrZ1TiSTztcgWbrsEliCoruY7HR2BbsYYk
         vymLANTpKFgXjcg3AN49C45lBU2O4sLhMKmwkm3pSlby6B+SCXuVFQuRoWDWOE3ombRa
         sEj88N/KYy7gWuCgdEawm+oHBN4Y1YHe0qc4XCeqv0sDt8bsV0tm36c0gJ+bUUbJKqcs
         d6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=65pjJ2po/DMn3P6OIsD7FWSb4eA6uVWQhXJDW1jWwqQ=;
        b=JIEGSXB8D07azGe+dC3yPxFOm9brxX8TY0URINzTtgNqtMsHLi6v/OgzB7Qmj4KtuB
         mQ7JUi8/er9AXz72Sw0KCvgA/LY/3fmb3Vv6/ijqePzM+878YU6W2HH2zqGEZXU/6+dq
         /1iIc88SSRLTK+401N1GZvKpaFfHf0WdIR9lezTgCR8BMlYlV+Jp1WvQXbCQTVTYTKEn
         AHwcuzdoWlI1+aAcxDEcwv6ugRcjWRqqLOPWlnVg3qGhXpLTWTcXtKZxEXZxiVLhjaO3
         CECScnQDveN7UZdWMpzx87H56C6eStYqKw8lesOrF1UkbMaigg3jeJvLGe0HbstBx25q
         4nJw==
X-Gm-Message-State: AOAM5317bZANSyeaxFGBOdpz3hQ9mnLqKiW5g964M03eFvl3VxWGsK9a
        ZOkv2zgnTMVm0nKSF0d253E=
X-Google-Smtp-Source: ABdhPJyk/Ucl0eHnOSNDshvYLia7pLFqsGYWviO1jVbarQYuuuOqL322LWjBBgJ5l2R/BbDXeLguuw==
X-Received: by 2002:a05:6808:345:: with SMTP id j5mr4305413oie.106.1620934396357;
        Thu, 13 May 2021 12:33:16 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z4sm842083otq.65.2021.05.13.12.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 12:33:15 -0700 (PDT)
Date:   Thu, 13 May 2021 14:33:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <609d7efa79732_42a0208d@natae.notmuch>
In-Reply-To: <87bl9esls8.fsf@evledraar.gmail.com>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
 <20210512222803.508446-3-felipe.contreras@gmail.com>
 <87bl9esls8.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 2/8] doc: add an asciidoc helper
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Wed, May 12 2021, Felipe Contreras wrote:
> =

> > The hacks to deal with interrupted builds is scattered throughout the=

> > Makefile, but not everywhere (it's not done for techical/ and article=
s).
> >
> > It originally comes from f9dae0d3e6 (Documentation/Makefile: fix
> > interrupted builds of user-manual.xml, 2010-04-21), however, that
> > description is not correct.
> >
> > asciidoc does actually remove the output file in case of an exception=
,
> > but there was a bug that handled keyboard interruptions through a
> > different path, and thus in that particular case the file is not
> > removed[1].
> >
> > We shouldn't overly complicate the Makefile due to bugs in asciidoc.
> >
> > In order to keep the Makefile clean this commit creates an asciidoc
> > wrapper that does the job of tracking the intermediary output.
> >
> > Once asciidoc is fixed this helper can be safely removed and there wo=
uld
> > be minimal changes elsewhere.
> >
> > It's written for bash, but could easily be modified for something mor=
e
> > portable.
> =

> Both this and your first patch could just be made to use the
> .DELETE_ON_ERROR flag instead, although that's a bigger change.
> =

> I had this and a related series for that recently:
> =

> https://lore.kernel.org/git/patch-4.6-2ff6359c273-20210329T161723Z-avar=
ab@gmail.com/

It may be a bigger change on the general Makefile, but I don't think
that's the case for the documentation Makefile.

> I don't think anyone had an objection to using that, I didn't pursue it=

> because I was trying to make (among other things) AIX development less
> annoying, but Junio didn't like the -o $@+ && mv $@+ $@ pattern for
> object files, so I gave up on pursuing it.

I really don't see what's the point of scattering all those rm mv all
over the place. If the command is interrupted (ctrl+C), then make will
remove the file anyway (regardless of .DELETE_ON_ERROR).

It's only a problem if the command fails for some other reason, in which
case the command itself should remove the file, or it's trapping the
SIGINT signal incorrectly (as is the case with asciidoc).

> But if you're trying to address this "maybe it errors" issue then
> .DELETE_ON_ERROR is a better solution.

Indeed, it seems so. Thanks.

> I think if we use that we should also undo your changes to use "-o file=
"
> and instead pipe to the file ourselves, otherwise we'll probably have
> cases where the program that fails and GNU make will race to delete the=

> file (but I haven't tested that case).

Yes, although I would prefer to investigate what happens in that case,
and I bet no race happens (doing `rm -f` twice is not an issue).

Cheers.

-- =

Felipe Contreras=
