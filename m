Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D0C47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 14:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD0B6120A
	for <git@archiver.kernel.org>; Sat, 29 May 2021 14:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhE2OZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 10:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhE2OZn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 10:25:43 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E58C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 07:24:07 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso6380883ote.1
        for <git@vger.kernel.org>; Sat, 29 May 2021 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=TgIV6Dztreh69wdJgNGBT8WSvZ5OgxM5ujaHN74g68c=;
        b=QETtD/DcCJfFsde1UcuudSdu30t5vWFD2p1eWL7aPzgE3CKaN2rkdGyHRjqcE7Rb0f
         xvVkySB2LMXMzlcl1oZ6dRwTIvzZq3sC7kIy2BcMBVUCBNDbJSSK6TzLSB4OE6yqR8a0
         n/7mOic+cUMonkNhheOdXMa62PS1JEj59kkJAneK5/xITHN8x+8m653dc+j3sflDVLG9
         Dwh6UeHDks/klUIHj9JpcnXdQyoDDCBLmqxQJe+rAPpEo6GfqWfbpq5Y5Ap2gNUSF6UD
         dcCWWlQXQ65SEIjSVaNaaqUJywmyQzNlAGfxwlRVciYw5sxeZvEGbVLooXA/XfnyDQCf
         mhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=TgIV6Dztreh69wdJgNGBT8WSvZ5OgxM5ujaHN74g68c=;
        b=CNt3SN+raZY7XJoKvlJZEVEZtyJ6WQM2DwJD7K1JP/8nLbSbmErCP8fwqV41CGD29S
         Pm90W7f4StVEtyFww2eZ5oPpsxeNTJRQogWYtDi6YP1rXDOJY/a4jItB/29Dtair8DvT
         s+209dB3qP7hFVpxHrnW1iryjYSBOqQKLp6J1L4rST2ANgjlo6C/8K4ghFuQxI1y+XsU
         nOXWnwTiuHV//RlYEXfc/HvjQFTF21rccyl/NtT5phDVwvwW4EMzM2VtID6NQ8XwmKeB
         oJeR5UhjJAsSe4LqYR0wXKCRnLVhjgqur1gBVhm8a5EjTCAffFoQA8mFvpBByMzKbi4Z
         xoCg==
X-Gm-Message-State: AOAM5303RwEgX8yGl/qEd7UQlI1odzJ6uj90aAdng+YrHVHOtc/7DJfi
        fD8pJynYE6sDiM4qVWiosDU=
X-Google-Smtp-Source: ABdhPJy4zkIDfblzUFWPZFsFKTXLBwGZPWRUQts5QBOVEFGv2P3HZNp58VJGkVXEpx31f43TKF3CLg==
X-Received: by 2002:a05:6830:1df7:: with SMTP id b23mr11183032otj.163.1622298246270;
        Sat, 29 May 2021 07:24:06 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w6sm1806614otj.5.2021.05.29.07.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 07:24:05 -0700 (PDT)
Date:   Sat, 29 May 2021 09:24:04 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Message-ID: <60b24e84658ff_2650882081a@natae.notmuch>
In-Reply-To: <87im322c04.fsf@evledraar.gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
 <patch-10.13-9f21bc6e6f2-20210528T092228Z-avarab@gmail.com>
 <60b112638fc47_4b03220885@natae.notmuch>
 <87im322c04.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v5 10/13] send-email: lazily load modules for a big
 speedup
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Fri, May 28 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> Optimize the time git-send-email takes to do even the simplest of
> >> things (such as serving up "-h") from around ~150ms to ~80ms-~90ms b=
y
> >> lazily loading the modules it requires.
> >> =

> >> Before this change Devel::TraceUse would report 99/97 used modules
> >> under NO_GETTEXT=3D[|Y], respectively. Now it's 52/37. It now takes =
~15s
> >> to run t9001-send-email.sh, down from ~20s.
> >> =

> >> Changing File::Spec::Functions::{catdir,catfile} to invoking class
> >> methods on File::Spec itself is idiomatic. See [1] for a more
> >> elaborate explanation, the resulting code behaves the same way, just=

> >> without the now-pointless function wrapper.
> >
> > I would reference `man File::Spec` rather than an email.
> >
> > And while this change makes sense, I think it should be split in two.=

> >
> > Instead of doing:
> >
> >   -use Term::ANSIColor;
> >   -print color("reset"), "\n";
> >   +require Term::ANSIColor;
> >   +print Term::ANSIColor::color("reset"), "\n";
> >
> > We could do this in one patch:
> >
> >   -print color("reset"), "\n";
> >   +print Term::ANSIColor::color("reset"), "\n";
> >
> > That is just no-op noise that we can mostly ignore in the review.
> >
> > Then the actual change to require Term::ANSIColor selectively would b=
e
> > much simpler to see.
> =

> You mean do the change from imported functions in one commit, and then
> sprinkle the "require" in another one?

Yes.
 =

> I think it's clearer this way, you can't really assert that it worked a=
s
> intended (i.e. you have no more imports) without the s/use/require/g, s=
o
> it makes sense to do both as one atomic change.

It is clear, but there's some noise.

And I don't see how you can assert there are no more imports from this
patch, especially when the next patch gets rid of more imports.

Moreover, it's already the case that the code uses namespaces in some
cases: Net::Domain::domainname is one you did not have to convert. You
would be doing the same for all other instances.

Cheers.


-- =

Felipe Contreras=
