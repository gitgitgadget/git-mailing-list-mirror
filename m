Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91370C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 14:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F95521D7D
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 14:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrnKtpTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLSOo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:44:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46868 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSOo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 09:44:26 -0500
Received: by mail-ed1-f65.google.com with SMTP id m8so5083041edi.13
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 06:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TaVOB8G44oZ8ET+t8fTZeGgIpFKtdOpqRinUWJFaVmk=;
        b=OrnKtpTTTFT8I8zth875KoZ1Y0SKtUm79m6PeYOSU91GPq4xVr92QOeCkzz3SJObDo
         FEQuUCAWEcfvYd5DWiAr9P9HlMJ/d/a3F0lgwRmVFzfXPEcHxOhsxGMDoQ+uBvJ8S3lq
         k7Ci0mWt2HtFHWNYDVF+Xk7SljJwYnPXcsBcQbm5Ly5726RhI2Yv+tDow/Tb4YwbQ2uw
         SFa0nwllxwtdzhtZJNm3nRqkFt0hiTbU6Y9PbtkKnzFas6MxsIRIUFQbP5Va9wNzY9P+
         qvuDQJZA8/Izf4W7aXRXNnnOeKZ5LsaO5yOAVQGFTfBqLwCeRgAkjSn8DKD6y12us0kg
         UiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TaVOB8G44oZ8ET+t8fTZeGgIpFKtdOpqRinUWJFaVmk=;
        b=hKJ9IT9ZShXG5qaRi753chBsWV9NnRSDkoo9jtF/yBBAi0BtLqmZ6VUNuGNU7UQrkf
         3GIc4c0h9QmgsmsYUIMbRwm7G+KTVkjPHOVkBdj71HeEXVAGlQ1bJdtEFEEFOELpcBVd
         gi/puR2tC6vWoLFHggGKyZo3mE//IAGsD+uyfXbu938NP3+ulPUcFYXvE4fVPa3o4gSh
         WHLfOMEpTmmiQMcnYlDN7SORmDuVDDzVNyQPk5OTtFI+fVCqi0h/v2OF79gA+W5rNdh9
         Z1iinoYJniRkyhH0v5BZYPowraFl/QHGtNJMb+kwh2XXmL3w8OluUYA6/i1CWLUxjgHL
         vT8g==
X-Gm-Message-State: APjAAAWZmvKYMvN7sIf6AlBmZiyxFLAb/kDYkEaDSaQa0lpn/yimbBoc
        YqcPoGMJYqhsabPsFPw9wxc=
X-Google-Smtp-Source: APXvYqwEWWJQ7XVORFByXqyCtWMT9MJdn8kk5g2pQJTb5boCnaHjeqle1ioGVrlSs/aMF+CQP+saaw==
X-Received: by 2002:a50:b7b4:: with SMTP id h49mr9589112ede.22.1576766662824;
        Thu, 19 Dec 2019 06:44:22 -0800 (PST)
Received: from szeder.dev (x4db583fb.dyn.telefonica.de. [77.181.131.251])
        by smtp.gmail.com with ESMTPSA id j17sm398972ejf.83.2019.12.19.06.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 06:44:21 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:44:19 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/6] completion: return the index of found word from
 __git_find_on_cmdline()
Message-ID: <20191219144419.GE8609@szeder.dev>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
 <20191017173501.3198-4-szeder.dev@gmail.com>
 <CAPig+cTLCTPtUWHKVBQEaP9GkrmrnHPwfef8KnktOSqYQY-jPA@mail.gmail.com>
 <20191018143728.GC29845@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018143728.GC29845@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 04:37:28PM +0200, SZEDER Gábor wrote:
> On Thu, Oct 17, 2019 at 01:52:27PM -0400, Eric Sunshine wrote:
> > >  __git_find_on_cmdline ()
> > >  {
> > > -       local word c=1
> > > +       local word c=1 show_idx
> > > +
> > > +       while test $# -gt 1; do
> > > +               case "$1" in
> > > +               --show-idx)     show_idx=y ;;
> > > +               *)              return 1 ;;
> > 
> > Should this emit an error message to aid a person debugging a test
> > which fails on a call to __git_find_on_cmdline()? For instance:
> > 
> >     echo "unrecognized option/argument: $1" >&2
> >     return 1
> >     ;;
> > 
> > or something...
> 
> When debugging the completion script I frequently resort to 'echo >&2
> "<msg>"', for lack of better options.

Well, there is a better option for debugging: adding 'echo >>~/LOG
"<msg>"' to the completion script and running 'tail -f ~/LOG' in a
separate terminal window is so much more convenient than screwing up
the command line with those messages to stderr every time.

I just wonder why it took me about a dozen years to figure this one
out... ;)

