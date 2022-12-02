Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4787AC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 01:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiLBBLA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 1 Dec 2022 20:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLBBK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 20:10:59 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB20ECAF9A
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 17:10:58 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id q15so2456012pja.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 17:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgyHZtAhpmnm3DYEqiNhtQPyFZHD95VdWBgVvvcCF2Q=;
        b=V5KdGEM1D/apX6ryxTEcopBBzJwPt+ObaDiBo0hr7O7jN8fHHRRBGoLzjFuhXDovzF
         h1bEFKcmoKsyEaAbQegj6oYssZbwKjk//dNMLopXDEvVQVZYVzmvoxbD6BlmivOjT/5k
         92hij8Lr7ig1solulZz1MKC4l/IotCmIW8ah0XUOvF2JPFHPn7oG3q2bZg6SI563pv3L
         +2jKhx+QMNybufSbSRxUi7Ii10tBjD3IYXiLwxkp9HokWWvGEJp0YEklXGOqXXVJBnsi
         Evs1e3kcMF0iHAWqrm535Mrhd2OwZ47laesYR80JZnHISePWPTzvXFbMrX9h1LGll7Q3
         0+RA==
X-Gm-Message-State: ANoB5pkPsdNGwi8ie1GNKDNjO21Y4mN2fx9Mo5ezqygNITnW9Jjf2/Bg
        4EAKX5eAJWLuq0AdIfhJ+7ZCPb8HBSJLFj+TI9Y=
X-Google-Smtp-Source: AA0mqf4yXI9hHDZomRgE0RjSurOfu+idl6YB8OZE+VmzMGCLGBqD60vHJ641/Isw4RO67lChoHfkiz7Ew81VZ2ydG/o=
X-Received: by 2002:a17:90a:bd96:b0:219:3553:4ff5 with SMTP id
 z22-20020a17090abd9600b0021935534ff5mr23957835pjr.22.1669943458088; Thu, 01
 Dec 2022 17:10:58 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-2.8-345a667d5bb-20221202T000227Z-avarab@gmail.com> <02ead668-5b5d-877c-1e40-3656fd85945f@web.de>
In-Reply-To: <02ead668-5b5d-877c-1e40-3656fd85945f@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Dec 2022 20:10:47 -0500
Message-ID: <CAPig+cRwwyiQdbAhDYGH==8r+Q2HVuqbW2a8c6W_myyqKAs4eA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] auto-crlf tests: check "git checkout" exit code
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2022 at 8:02 PM René Scharfe <l.s.r@web.de> wrote:
> Am 02.12.2022 um 01:06 schrieb Ævar Arnfjörð Bjarmason:
> > Don't hide the exit code from the "git checkout" we run to checkout
> > our attributes file.
> > @@ -294,11 +294,17 @@ checkout_files () {
> >       pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
> >       for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
> >       do
> > -             rm crlf_false_attr__$f.txt &&
> > -             if test -z "$ceol"; then
> > -                     git checkout -- crlf_false_attr__$f.txt
> > +             if test -z "$ceol"
> > +             then
> > +                     test_expect_success "setup $f checkout" '
> > +                             rm crlf_false_attr__$f.txt &&
> > +                             git checkout -- crlf_false_attr__$f.txt
> > +                     '
> >               else
> > -                     git -c core.eol=$ceol checkout -- crlf_false_attr__$f.txt
> > +                     test_expect_success "setup $f checkout with core.eol=$ceol" '
> > +                             rm crlf_false_attr__$f.txt &&
> > +                             git -c core.eol=$ceol checkout -- crlf_false_attr__$f.txt
> > +                     '
>
> That adds five test_expect_success calls.  Wouldn't one suffice, for the
> whole for loop, and a "|| return 1"?

Seems like a reasonable idea.

> One line above the context there's a "git config" call that should also
> be covered, right?

Also, the call to create_gitattributes() just above that line is in
the function's &&-chain, which implies that it too should be covered.
