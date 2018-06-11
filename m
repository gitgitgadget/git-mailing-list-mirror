Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DA61F403
	for <e@80x24.org>; Mon, 11 Jun 2018 20:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933111AbeFKUU7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 16:20:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39606 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932861AbeFKUU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 16:20:59 -0400
Received: by mail-it0-f67.google.com with SMTP id p185-v6so12600925itp.4
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2dq6HTCuSOuedEa0lIW59GNZVl9aMY0gWVZ+42ZIxU=;
        b=f3nxSA6a29pk9BxJAPN8ZaQKlrictd/pslj/1maUMtznjW+6Xn+0y4sEDtoPMJ6Szx
         Vyg/05S7FJMk/irAMxh+O2pmLKzPL2caKvREJow6kLf7L2gMkpeM0vIlKnLNSqJA35XH
         dXO8gbu0sW7lQCrLqAPWK/RFKr8in/WoPz3no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2dq6HTCuSOuedEa0lIW59GNZVl9aMY0gWVZ+42ZIxU=;
        b=nSKm2BoubwaCwKHM4sJAsUzIO2SD0f27rb5IbG0Pa6YBhUJCFnDVGE+6O4mLd0FiTP
         7q36D5IOubWaQXkr7O/Z1e10yuKm5/3Liqz9wzhlj33kk3SakZsuJQ567hbpref4PabT
         kj8V6IpMFCwJO+EgT9O+le/bOFvjlTrc+TDhhUzjBebhiVwucIhpj8WKQv14OuF6Eyu0
         EKTYzDvG5O0GThNoAVZ3emFgbFzak+lH6ffPmZ1MyWZFVkdoGcFi/uHEabSHPT/Gmf6c
         95wwu4CkWyUd2vor7Ti0H3rMRV5aI+feb2GK0/N8GJnxbzkHThfiJtwQsOFO9rgl1u/x
         jNiA==
X-Gm-Message-State: APt69E1OE5InyU5OMGxmFssPkRRRRlQJZMwv0exwfn3MUVRvnrVYm4rv
        OvtEq8DjCUSgymTLPEK5j5MY5FN7AxOLsBnhLTQ=
X-Google-Smtp-Source: ADUXVKIrzi38nbUndXRFTqK8we1HfHXAmMq1AGlwwvXj/08IZovTDhpg3oCP+QbblRlLmEFeVhbinBbnDLFXAOsZQFQ=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr449113ita.113.1528748458091;
 Mon, 11 Jun 2018 13:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com>
In-Reply-To: <20180611192942.GC20665@aiede.svl.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jun 2018 13:20:46 -0700
Message-ID: <CA+55aFw+E9GT7TKC_EgPTVcvHR8HDSipNPa7VQ1ASeL1M68xMQ@mail.gmail.com>
Subject: Re: Hash algorithm analysis
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, agl@google.com, keccak@noekeon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 12:29 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Yves Orton and Linus Torvalds prefer[5] SHA3 over SHA2 because of how
> it is constructed.

Yeah, I really think that it's a mistake to switch to something that
has the same problem SHA1 had.

That doesn't necessarily mean SHA3, but it does mean "bigger
intermediate hash state" (so no length extension attack), which could
be SHA3, but also SHA-512/256 or K12.

Honestly, git has effectively already moved from SHA1 to SHA1DC.

So the actual known attack and weakness of SHA1 should simply not be
part of the discussion for the next hash. You can basically say "we're
_already_ on the second hash, we just picked one that was so
compatible with SHA1 that nobody even really noticed.

The reason to switch is

 (a) 160 bits may not be enough

 (b) maybe there are other weaknesses in SHA1 that SHA1DC doesn't catch.

 (c) others?

Obviously all of the choices address (a).

But at least for me, (b) makes me go "well, SHA2 has the exact same
weak inter-block state attack, so if there are unknown weaknesses in
SHA1, then what about unknown weaknesses in SHA2"?

And no, I'm not a cryptographer. But honestly, length extension
attacks were how both md5 and sha1 were broken in practice, so I'm
just going "why would we go with a crypto choice that has that known
weakness? That's just crazy".

From a performance standpoint, I have to say (once more) that crypto
performance actually mattered a lot less than I originally thought it
would. Yes, there are phases that do care, but they are rare.

For example, I think SHA1 performance has probably mattered most for
the index and pack-file, where it's really only used as a fancy CRC.
For most individual object cases, it is almost never an issue.

From a performance angle, I think the whole "256-bit hashes are
bigger" is going to be the more noticeable performance issue, just
because things like delta compression and zlib - both of which are
very *real* and present performance issues - will have more data that
they need to work on. The performance difference between different
hashing functions is likely not all that noticeable in most common
cases as long as we're not talking orders of magnitude.

And yes, I guess we're in the "approaching an order of magnitude"
performance difference, but we should actually compare not to OpenSSL
SHA1, but to SHA1DC. See above.

Personally, the fact that the Keccak people would suggest K12 makes me
think that should be a front-runner, but whatever. I don't think the
128-bit preimage case is an issue, since 128 bits is the brute-force
cost for any 256-bit hash.

But hey, I picked sha1 to begin with, so take any input from me with
that historical pinch of salt in mind ;)

                Linus
