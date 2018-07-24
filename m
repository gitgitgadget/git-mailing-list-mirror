Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD9A1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 20:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbeGXVjW (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 17:39:22 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36859 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbeGXVjW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 17:39:22 -0400
Received: by mail-io0-f172.google.com with SMTP id r15-v6so4530001ioa.3
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 13:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRGLrcT3TYAqM7lFCuM1omSZCPS7Vgt4olMbj2kstVY=;
        b=fo1xc712WZZVCjZu/9yGTZuVSBioay5dr6SFncwdsMjNVC3GLOWON6ow5pVUWno9Ec
         oFnod1w+te3+TPgh9TpPlXZTXk7eZ/sVA/2CPQlwdEQDPol1ZqTfnz0H0+691eHHS/0B
         ws5Ehgn/lU3qx1T1u80PAMWysySgY0PJ8hUEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRGLrcT3TYAqM7lFCuM1omSZCPS7Vgt4olMbj2kstVY=;
        b=SLCf+TDKmcORfcEGM89wDS5hv9CbZ60GUSZruzfSBt2r+LwyG+27H9imMm4iG6DrLp
         tvAEpJCnOQdv6v0Ienhc5Ca2HnjDgj1hlxrizU6h0tz+H4bHY4rIRKA1jH829AuexKVV
         nL5Awg53p3NCXmo1eXJu+KnBOCn+gN6JNp8Z56nEgwVazD8D/wlldEuRWUdNG62I/l6m
         DsuGHaaNpVlzPnp6SxISDOqn/tumuwaGzMxFkfPSFRKsjEBn16cW/kRjwc2j5kNzuxsP
         KLqAcCYJz0KctoPk2d09DY7ThmrqI62G86W022hhOzJcc6GB/At7MOcIxyyFXbjEPMCR
         FwBg==
X-Gm-Message-State: AOUpUlEiSL8ACcqHG6NqHoS2vGtvlD8bzbb/LyA2/JM/8Jwb32GFxhYe
        lnCryC0Fvoy4jn5PmCZc4vcUofNr1mpcydN0rRY=
X-Google-Smtp-Source: AAOMgpe88W44DAYGetqPC7OrPAdGQvNKANuhIiHF6Zfh5NZlNZETooLYIwclgN9rTNc8ycsPkJviorSCFKGJvrBHjwU=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr15285950iom.238.1532464271666;
 Tue, 24 Jul 2018 13:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net> <20180724190136.GA5@0f3cdde9c159>
In-Reply-To: <20180724190136.GA5@0f3cdde9c159>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jul 2018 13:31:00 -0700
Message-ID: <CA+55aFwSe9BF8e0hLk9pp3FVD5LaVY5GRdsV3fbNtgzekJadyA@mail.gmail.com>
Subject: Re: Hash algorithm analysis
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 12:01 PM Edward Thomson
<ethomson@edwardthomson.com> wrote:
>
> Switching gears, if I look at this from the perspective of the libgit2
> project, I would also prefer SHA-256 or SHA3 over blake2b.  To support
> blake2b, we'd have to include - and support - that code ourselves.  But
> to support SHA-256, we would simply use the system's crypto libraries
> that we already take a dependecy on (OpenSSL, mbedTLS, CryptoNG, or
> SecureTransport).

I think this is probably the single strongest argument for sha256.
"It's just there".

The hardware acceleration hasn't become nearly as ubiquitous as I
would have hoped, and honestly, sha256 _needs_ hw acceleration more
than some of the alternatives in the first place.

But sha256 does have the big advantage of just having been around and
existing in pretty much every single crypto library.

So I'm not a huge fan of sha256, partly because of my disappointment
in lack of hw acceleration in releant markets (sure, it's fairly
common in ARM, but nobody sane uses ARM for development because of
_other_ reasons). And partly because I don't like how the internal
data size is the same as the final hash. But that second issue is an
annoyance with it, not a real issue - in the absence of weaknesses
it's a non-issue, and any future weaknesses might affect any other
choice too.

So hey, if people are actually at the point where the lack of choice
holds up development, we should just pick one. And despite what I've
said in this discussion, sha256 would have been my first choice, just
because it's the "obvious" choice. The exact same way that SHA1 was
the obvious choice (for pretty much the same infrastructure reasons)
back in 2005.

And maybe the hw acceleration landscape will actually improve. I think
AMD actually does do the SHA extensions in Zen/TR.

So I think Junio should just pick one. And I'll stand up and say

 "Let's just pick one.

  And sha256 is certainly the safe choice in that it won't strike
  anybody as being the _wrong_ choice per se, even if not everybody will
  necessarily agree it's the _bext_ choice".

but in the end I think Junio should be the final arbiter. I think all
of the discussed choices are perfectly fine in practice.

Btw, the one thing I *would* suggest is that the git community just
also says that the current hash is not SHA1, but SHA1DC.

Support for "plain" SHA1 should be removed entirely. If we add a lot
of new infrastructure to support a new more secure hash, we should not
have the old fallback for the known-weak one. Just make SHA1DC the
only one git can be built with.

               Linus
