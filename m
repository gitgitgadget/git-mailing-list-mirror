Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140AAC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E055461375
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 21:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhFQWAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 18:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFQWAP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 18:00:15 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55231C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:58:06 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so7682072otu.6
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 14:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Gibme+P5KUXr2OPGVeGW9mF03fv2tLlGMZWtbaCah+g=;
        b=f5MA8i6ksS6wOp5g24aJ+AcXbxrgv5fRzLbvw/D0rDjy6cayaD5a2uUDLfmoe1h3ex
         DrvovXMpGFv/qIB0dUcib1wYvU6V6gK+mJjgN1rJuqVJvJ04yN1yjvUSTsHRs4criKk2
         37yrFftQUmtYSvXaYHdJ1Or3iDAkUOJDP0vVD9vsRRqAuyt2+it0DN0j8zMwMTj4vjaY
         5KSnplZyho5oQaMsNpPg8tYSzZZsNI4MpKgyk1T4Dxg1cdPPq/UcVcm4JCC+61UCnQXW
         FnS+Siqw85TRxVlFED/OB7TmXk8JkXOgcONLEFlVYVXA4mU1eKG73R1IVr4PN+GTQuCx
         buFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Gibme+P5KUXr2OPGVeGW9mF03fv2tLlGMZWtbaCah+g=;
        b=sU0wVVRwCK44ZjD78v0x7yNqb5OUIU3h+6SqXZIxId32RfvdXTTcSD0ICC1JB5G9ox
         cow3sb6d/raHR26i8mHXCg3/M/xTdg71t9/qWnOiSvcFnhmkTTlNuYThdXYrYByqjAe9
         V6SiZGwrsBcGxG96TVVWZlXAMV3nxXzO2z+rCeLQZe/1qo6KNZc8e69F370/h8cNLFwo
         mkDfBRq4gVB+tLWGK1blV22mYQAevwsi3K4bLJuZTLYqcWF+yUJ4XsDCCs5P5UrLyqvW
         y67ExrB9muMwH9oExLta8GFhD7zqVJFebhBoMMjMqYuY/lXoIbtjwQwZvpqEpA3g0q86
         9ZuQ==
X-Gm-Message-State: AOAM531arsdryIRtDG8gqTMgWwv7jKRYMjpcMUearqyEOU1V9jATwfcz
        kbfMVyxZ080IlQzTvUR/2zM=
X-Google-Smtp-Source: ABdhPJy5c9+qIpBPzHzRGE8imGu/40jjyKJHW12hzjcdZEls3/rJfBXSQVaar20DGnbmcsQnTRtOxQ==
X-Received: by 2002:a9d:729d:: with SMTP id t29mr6528148otj.256.1623967085665;
        Thu, 17 Jun 2021 14:58:05 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id u10sm1641865otj.75.2021.06.17.14.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:58:05 -0700 (PDT)
Date:   Thu, 17 Jun 2021 16:58:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <60cbc56c92b4_1299208f6@natae.notmuch>
In-Reply-To: <87zgvo435v.fsf@evledraar.gmail.com>
References: <cover-0.3-0000000000-20210617T095827Z-avarab@gmail.com>
 <patch-2.3-6e164edb0b-20210617T095827Z-avarab@gmail.com>
 <60cbad11b13f5_9bf20896@natae.notmuch>
 <87zgvo435v.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 2/3] Makefile: stop hardcoding {command,config}-list.h
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Thu, Jun 17 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> Change various places that hardcode the names of these two files to
> >> refer to either $(GENERATED_H), or to a new generated-hdrs
> >> target.
> >
> > Avoiding hard-coded things is generally a good idea, and I can smell
> > there's an advantage nearby, but it's not stated.
> >
> > Can you spell out what you are trying to achieve?
> =

> It's hinted at in the CL,

Yes, but the commit message should stand on its own.

> but this is series 1/3 of a re-roll of the
> base topic for config-based hooks, real use of this is made in step 2/3=
,
> 3/3 has a better overview:
> http://lore.kernel.org/git/cover-00.27-0000000000-20210617T101216Z-avar=
ab@gmail.com

Yeah, I read the cover letter afterwards, but I'm just putting my
reviewer cap; the rationale belongs in the commit message: we will want
more generated files in GENERATED_H.

Also, I presume you meant this one:

https://lore.kernel.org/git/cover-0.3-0000000000-20210617T100239Z-avarab@=
gmail.com/

Cheers.

-- =

Felipe Contreras=
