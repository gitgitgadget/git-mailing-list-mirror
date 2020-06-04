Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7943EC433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 23:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C81C206A2
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 23:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF9XEwMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgFDX0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 19:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgFDX0X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 19:26:23 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C7DC08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 16:26:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so4218642pgn.5
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mhztg9wyBhmizTShdNbolR/lvW/WCX1i75cWzZBC1y0=;
        b=eF9XEwMIz6/p5oL4RPrNoswRfIg/jXarwFh0l0M9s31PFwRXjy4P3yJBhxm+fWc4Qo
         E+36m8yr+PagrkSdAAtyASv29r0eGliVQZOi6hwaE6qPbbYscvbst/Hf+wv2cEHTHxqV
         8aGrxyrNeDNZCXin0+OpjdsldLSCY9my06y1NbkUKXfZZQIM6EbdUloehfmUZVF32xKw
         SY6cp6nfYEGpkgc8hNgY1w6vYA3Lny4pO9A/ACF2QGrk6sZ5cdkef/4StO/gjzVFwLQt
         L+yCz/gxcFJS5FkBoAM6PKg8W8bLfuVquAZ9+fpJD0A7xo6KUGoZAqPC5zub3lTWy7YO
         M6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mhztg9wyBhmizTShdNbolR/lvW/WCX1i75cWzZBC1y0=;
        b=qlzueuWsMEu9D1jtx6iy+XY9hvZmWQoJheY9jAFBIGrsyzV822sEe1Rpixj0oiUiyU
         q8J2/avwWNlTgxUNKmkyMd3437sUS0X0ku98H1A0sGrt0zU/VqEuKjBXjcjv/0Gu7TXE
         rr+mkIApqQAIzm8oQYlLqeKn9/b/r41oXxh4j6111IS6okI8xavWCVX+TgBPer5xqMfR
         1SdLaxPUNjOBv0CGwU81D2hSGoQtqCNv5DWiLBBMlKoX/YXoYAc5UK76Rx5F8bHAg0ny
         EDeQoOvuoXVRF9nw4fzyPWPSXHQLGwV/0OmXkA8bHLe/OyJUUvgBHWmG7t1S8Vckwt3q
         WaOQ==
X-Gm-Message-State: AOAM533As/ldvoxu3Lj21fTlQaksdMFbrQ8llOdyO0TQk9GfxvckEfbp
        Mj3zmBKkbkfLc2rqukhDWJA=
X-Google-Smtp-Source: ABdhPJwQTynJYlCJ2j7S7D1ZETjcmyCnXIQD7Py+u/mYz5qLHHCXpOnQCJEZ2H1grSwK2+hIDPph2w==
X-Received: by 2002:a62:6d01:: with SMTP id i1mr6819204pfc.286.1591313182111;
        Thu, 04 Jun 2020 16:26:22 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id y136sm5637042pfg.55.2020.06.04.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 16:26:21 -0700 (PDT)
Date:   Fri, 5 Jun 2020 06:26:19 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Laurent Arnoud <laurent@spkdev.net>, git@vger.kernel.org
Subject: Re: [PATCH] format-patch: generate valid patch with diff.noprefix
 config
Message-ID: <20200604232619.GA6329@danh.dev>
References: <20200602204924.GA1853335@spk-laptop>
 <xmqqpnahrx2y.fsf@gitster.c.googlers.com>
 <xmqqeeqxrufz.fsf@gitster.c.googlers.com>
 <20200604193238.GA1911544@spk-laptop>
 <xmqq367aposu.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq367aposu.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-04 13:18:57-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Laurent Arnoud <laurent@spkdev.net> writes:
> 
> > I don't know if its a bug but I founded strange that I needed to use an alias
> > "git -c diff.noprefix=false format-patch" to generate a patch that I can apply
> > directly with "git am".
> 
> The same thing can be said about the diff.relative option.
> 
> As I do not use either of these variables myself, I am somewhat
> indifferent, if those who set these variables find the consequences
> of doing so unpleasant.  As people often say, if it hurts, then...
> ;-)

FWIW, people need to dig into git-config(1) to know diff.noprefix
We don't mention it in git-diff(1). Me neither until today.

> Because the recipient of format-patch output who consumes it is
> typically different from the one who generates it, it probably does
> not make much sense to attempt linking diff.noprefix=true with the
> -p0 option (there isn't even a configuration for 'git am -p<num>',
> if I am not mistaken).

Could we extend the patch in someway that can hint git-am(1) to
use "-p0" if patch was generated by --no-prefix?
I couldn't come up with any idea right now, since all parts of the
patch is very busy with a lot of information.
An RFC 822 header, perhap?

Of course old git-am(1) couldn't understand the extension.
And the new git-am may come up with false positive?

> Depending on the project a user works with, allowing
> log/show/format-patch to honor certain diff.* configuration
> variables, without a way to countermand them with more specific
> configuration for log/show/format-patch, may smell like a bug.  
> 
> I am not sure where to draw the line, though.  Would we treat only
> format-patch and no other commands in the log family specially?
> Would we treat each commands in the log family specially and
> separately, so that you could say "diff and show uses noprefix, but
> 'log -p' and 'whatchanged' uses the standard a/ and b/ prefix and
> format-patch uses old/ and new/ prefix" independently?
> 
> > I didn't know the -p option but to send a patch to a
> > mailinglist it should have the prefix I guess ?
> 
> The participants in this project would certainly find it unusual
> when they see a prefix-less patch.
> 
> There probably are projects older than Git whose convention is to
> use .noprefix; we didn't want to force them to switch and instead
> accomodated their preference with .noprefix but in hindsight, it may
> have been a better idea to force one true way to everybody, which
> would have kept the world simpler.  I dunno.

I do use format-patch --no-prefix.
It's unlikely that I will use diff.noprefix, though.
I think other people also have different preferences.

-- 
Danh
