Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F189C4332B
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 22:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C8620772
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 22:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCRWjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:39:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39486 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCRWjE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 18:39:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id f7so9482wml.4
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 15:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+BuZ3bf0qS0IlwCiRIHfhmuQxsITahrGdYQ+MqsW6U=;
        b=J257L3lPeuICBrdhHTM/Zgd0ea0xCDAzf6g4+1G1pZK6Uz9o14RNMiqaZNDMiOsjdy
         fM4b4A42hRzSWuikioSFA3GSmCTqEPfmH/9/fPacf/31N+od+7AMbHy53LS1JoluDzve
         DvEFV5osINU5CbGKHcIJd7TGZOl+mEVLd66QQOrryObZsK/AeSMdI2yRZep8x+HFLsFA
         GDUgU+CNRPQ6b+neB9q0F3nnNKKWG81ueewA6uJh5wZJEDgut47XU7DPofl6YRMJcLyI
         AvCVB6mDeOYzSjq6FXeZ8YXRoK6Rw5risQvD2sByCyzmriECljM25bvG06yY7GxrB5op
         NYjA==
X-Gm-Message-State: ANhLgQ3Itia7TcxI2nqKhE3XbyF6WEGJrIwfDupApj5FNtHSFKr4+h2f
        u0Jwvh3siw9DGN+NYf/Rg6hiPTbl/iiSmRqhd4o=
X-Google-Smtp-Source: ADFU+vu9l4UwLs2PLJ6FOCGI7GLOSCcpkX34UwkM92m6t3JhjJovVEZz4EJ25sXhdUeTwNiU1Y3kuYVqAiaSSjnzSvw=
X-Received: by 2002:a7b:c08a:: with SMTP id r10mr7372748wmh.130.1584571140932;
 Wed, 18 Mar 2020 15:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com> <c75806d011b04f2ad7efbbec01613a2d0b1f570b.1584477196.git.me@ttaylorr.com>
 <CAPig+cTVtv+uzzpoZ-BT=F=srdt1ewvgeBAAr9R+OUCYSov65A@mail.gmail.com> <20200318100327.GA1227946@coredump.intra.peff.net>
In-Reply-To: <20200318100327.GA1227946@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 18 Mar 2020 18:38:49 -0400
Message-ID: <CAPig+cTWb55K70v1MahHbTi12F5Zi6stKc1vjY2=9jSvEm7jww@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] list_objects_filter_options: introduce 'list_object_filter_config_name'
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        james@jramsay.com.au
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 18, 2020 at 6:03 AM Jeff King <peff@peff.net> wrote:
> On Tue, Mar 17, 2020 at 04:53:44PM -0400, Eric Sunshine wrote:
> > > +       case LOFC__COUNT:
> > > +               /*
> > > +                * Include these to catch all enumerated values, but
> > > +                * break to treat them as a bug. Any new values of this
> > > +                * enum will cause a compiler error, as desired.
> > > +                */
> >
> > In general, people will see a warning, not an error, unless they
> > specifically use -Werror (or such) to turn the warning into an error,
> > so this statement is misleading. Also, while some compilers may
> > complain, others may not. So, although the comment claims that we will
> > notice an unhandled enum constant at compile-time, that isn't
> > necessarily the case.
>
> Yes, but that's the best we can do, isn't it?

To be clear, I wasn't questioning the code structure at all. I was
specifically referring to the comment talking about "error" when it
should say "warning" or "possible warning".

Moreover, normally, we use comments to highlight something in the code
which is not obvious or straightforward, so I was questioning whether
this comment is even helpful since the code seems reasonably clear.
And...

> But we can't just remove the default case. Even though enums don't
> generally take on other values, it's legal for them to do so. So we do
> want to make sure we BUG() in that instance.
>
> This is awkward to solve in the general case[1]. But because we're
> returning in each case arm here, it's easy to just put the BUG() after
> the switch. Anything that didn't return is unhandled, and we get the
> best of both: -Wswitch warnings when we need to add a new filter type,
> and a BUG() in the off chance that we see an unexpected value.
>
> So...I dunno. Worth it as a general technique?

...if this is or will become an idiom we want in this codebase, then
it would be silly to write an explanatory comment every place we
employ it. Instead, a document such as CodingGuidelines would likely
be a better fit for such knowledge.
