Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0029C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 02:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiGKCl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 22:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGKClZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 22:41:25 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C18165A4
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 19:41:24 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-31cac89d8d6so36126257b3.2
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 19:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDOV0sCHHqpFefzMX77tOzWhJnzmHeHMeGL5i7qDQGY=;
        b=sCbxjOYSUg8dLGCZVDYWxPczSEB6jcW4xs4d0cj76C3nDxBv6ZszJve0jLCv/oXvkk
         a2OuHQsiMPUcXYlF7fpeil6PJBybuf5WQi9zHZ0CtURTd8oJzYtXibJIcS2lce2iLchr
         He7eQfQuo+ZiR0F/V4l9kFUvOTQQWSuzZ2RcGq58lVezfTI9sGQb2RdqSLrfuK63xT4o
         lTq8W8v5ZsudUneGHHu/o03E4p5/59Z5PmZg+4mE1qSK205mDwK3uR6Ucsz9LNoNpWKW
         k85bpI0FHTvMVZ0PR15Z2tV7iTfbyAmNtj6M1TAg9alR8E8AxPwqRfPSTjjtZwb2/82K
         dJGg==
X-Gm-Message-State: AJIora9nVYpzHO4vSKSr/IARo7r/LsK8wklgGvApfoEQ573tYf4D7Ov0
        T1YvyxhbTWkMT5weJ0RBmUCTHUi3Bv4QJm7eqtuPN8fikmA=
X-Google-Smtp-Source: AGRyM1vGyBBJirZcLwKIUUAfDBk1HlKBufmCQxLSc3+A1DyNNvvBKiAmQn1wgKg5re3za+f79SOSDfJIcDQzZawpaYE=
X-Received: by 2002:a81:b50:0:b0:31c:cd9a:c875 with SMTP id
 77-20020a810b50000000b0031ccd9ac875mr17759350ywl.411.1657507283637; Sun, 10
 Jul 2022 19:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220710081135.74964-1-sunshine@sunshineco.com> <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
In-Reply-To: <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Jul 2022 22:41:12 -0400
Message-ID: <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10, 2022 at 10:00 PM Han Xin <chiyutianyi@gmail.com> wrote:
> On Sun, Jul 10, 2022 at 4:12 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On macOS High Sierra (10.13), Apple's `clang`[1] complains about missing
> > braces around initialization of a subobject, which is problematic when
> > building with `DEVELOPER=YesPlease` which enables `-Werror`:
> >
> >     builtin/unpack-objects.c:388:26: error: suggest braces around
> >         initialization of subobject [-Werror,-Wmissing-braces]
> >             git_zstream zstream = { 0 };
> >
> > [1]: `cc --version` => "Apple LLVM version 10.0.0 (clang-1000.10.44.4)"
> > -       git_zstream zstream = { 0 };
> > +       git_zstream zstream = {{ 0 }};
>
> Not a comment, just wondering, when should I use "{ { 0 } }" and when
> should I use "{ 0 }"?
>
> I didn't get the error with "Apple clang version 13.0.0
> (clang-1300.0.29.30)",  because it's
> a higher version ?

I don't have a good answer. More modern `clang` versions don't seem to
complain about plain old `{0}` here, but the older `clang` with which
I'm stuck does complain. Aside from actually building the project with
an older `clang` (or older Apple-specific `clang`), it may be
sufficient to inspect the structure that's being initialized to see if
the first element is itself a subobject. However, I'm not sure it's
worth the effort to do so considering how rare this problem seems to
be.
