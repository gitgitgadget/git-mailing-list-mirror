Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A18C33CAA
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBD121569
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 16:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4mOmRRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgAUQxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:53:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35762 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgAUQxB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 11:53:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so4066826wro.2
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 08:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xv8TRZLk1M4dBaaM4xqddnV2SfCrA/o0qCx5DT/ENK4=;
        b=Z4mOmRRNmTqRcS+lX3ggbUI5TwxbfhtTKloHnC4p2kB3ERObbSbrIKFNesXeeHH1uu
         BdH5LYdyAosPjPLEwpdozIqMlIUZWgfqAZiMbevWQW0Qj2Zy9ztyu1BYn/wSauZP3U0I
         9Sik518YkN02kc4jpAkbFUbLf5ygwbRDNAl/fUoCstPBNjztyo3BtKvPR4fAA69RqajI
         5LPYuQ883OuQmyq9hqLWQlQwFO/muY/TRwhutvBSEwbNtF0LvcqoL+X5WZV94Ug/BP1D
         +N9LeTClFSOhQX9g9Fsktl0hCt7moGRM14vWJIOnIJvFas9JVOVYzaQmHpTCqtxqmPpD
         IAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xv8TRZLk1M4dBaaM4xqddnV2SfCrA/o0qCx5DT/ENK4=;
        b=jjEyK/Oea7i/tncKzmf5ND3SRkbUcLcO18RkNcjCA4jG05Mi+F86RRTpDn5mc+S2Si
         10ZFFM9NozgMyevzCzTZN8xCgRYgkLFeGEbXZvR5we2nQRk23Kj3FU+pNYO/vvcWaVoy
         3QuQACXVMtAPcfXmoCipwVGrJ6sOpxMVmNN9HIL5JcURN95CkML1d8Celmov/omgVMtx
         uYtIfJ0gzEq/SZHbJzGBUdyHikVabe/CxZZsbewS4dxhSPFEOPI5VG8PyKwi0V8hZuol
         ZQQFrHhKTZr/N/y3TxQAyKXGUpG76EzrPv2eFOEwfNqo4DmZ07BWpXmtMbOYJov0nUVj
         CHgw==
X-Gm-Message-State: APjAAAWjdftxsl3Gs2Kzwvi+pE+zyNoyNM6ZHNzIRs09vjI/XsugPDv8
        K6VO1uUAq9weguv1LiRMHbPs13MUYQi2Nf5cCUs=
X-Google-Smtp-Source: APXvYqwI8hghplY83YaYQHVwoU1nwXlVi/8Sxeo5CjM4klTABL2+c1OJM0r8fJw6Vj0ukqDNhy80auZeVHeGi87Fbso=
X-Received: by 2002:a5d:6344:: with SMTP id b4mr6071149wrw.414.1579625580298;
 Tue, 21 Jan 2020 08:53:00 -0800 (PST)
MIME-Version: 1.0
References: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
 <20200118145318.5177-1-shawarmakarma@gmail.com> <20200118145318.5177-2-shawarmakarma@gmail.com>
 <xmqqv9p8bo0o.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9p8bo0o.fsf@gitster-ct.c.googlers.com>
From:   Eyal Soha <shawarmakarma@gmail.com>
Date:   Tue, 21 Jan 2020 08:52:49 -0800
Message-ID: <CANsz78+-Z89d8E=n3cjfnXaGVFXpchdG7EjtdQuFjzo-=2aPeA@mail.gmail.com>
Subject: Re: [PATCH 2/3] color.c: Support bright aixterm colors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 18, 2020 at 10:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> OK, so this round the design is to reuse the ANSI mode instead of
> introducing a new AIX mode that sits next to ANSI, 256 and RGB?

Right.  Previously I had it with a new AIX enum parallel to ANSI, 256,
etc, but it just made the code longer for no good reason.

> For this to work, not just the 90-97 range for bright-ansi orders
> the colors the same way as 30-37 range (only brighter), but also
> the differences between corresponding fore- and background colors
> must also be 10 just like the regular ANSI colors.

Yes.  It's a happy coincidence that the background version is always
10 greater than the foreground version, for ANSI, for AIX, and even
for the 256-bit colors.   The code takes advantage of that.  If that
later proves to be not true, color_output needs to be modified.
However!, the modification would be just in color_output because the
input is now a boolean "background" instead of the previous char
"type".  I think that's a good improvement so that the caller of
color_output doesn't need to know that, ie, '3' is foreground and '4'
is background.

>
> So perhaps an additional sentence or two deserve to be there, e.g.
>
>         ... of the 3-bit colors.  Instead of 30-37 range for the
>         foreground and 40-47 range for the background, they live in
>         90-97 and 100-107 range, respectively.

Will do.

>
> or something like that, perhaps?
>
> >  The basic colors accepted are `normal`, `black`, `red`, `green`, `yellow`,
> >  `blue`, `magenta`, `cyan` and `white`.  The first color given is the
> > -foreground; the second is the background.
> > +foreground; the second is the background.  All the basic colors except
> > +`normal` have a bright variant that can be speficied by prefixing the
> > +color with `bright`, like `brightred`.
>
> Nicely and readably written.

Thanks.  I tried to keep the voice in line with the rest of the text.

>
> I have to wonder if spelling "bright<color>", i.e. two words smashed
> together without anything in between words, is in widespread use (in
> other words, are we following an established practice, or are we
> inventing our own), or if we need to prepare for synonyms?  HTML/CSS
> folks seem to use words-smashed-without-anything-in-betwen so they
> should be fine with this design; I no longer recall what X did ;-)

/usr/local/lib/X11/rgb.txt often uses smashed together:
https://github.com/vim/vim/blob/master/runtime/rgb.txt  Wikipedia
calls them "bright" consistently:
https://en.wikipedia.org/wiki/ANSI_escape_code#Colors .  So we've got
a vote for smashing them together and a vote for "bright".  Seems okay
by me!

Eyal
