Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E02C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 19:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJSTHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJSTHp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 15:07:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3701ACABF
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 12:07:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b2so42258262eja.6
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a7GS3sYfqdA8D7BcbQm6JfcCs8UCdRz0A7JK8XPmhPo=;
        b=psUWo9Vru+HVwYMkLFbUEQqdmPKwviBgMZAWTy9IgNMC96aIT1YjmJL9cAsrvJUaPc
         /roEmvwuQin2JLSL9k0M8bkYhPYI60kHYE/kSloYczFN3wX9+Qa5ux8UB4D7Aw0IVCR2
         SICi7OXQ+bIRKHjjkLhAC9Jg0fpdSVvedaG4/EnCTjKtEJQwYl2UcQB1p1mXi3a/nTZl
         KGsdr+TKTJVmubzQKgAiZ0ZbAQkA2PeZVua/XyB4T6gIDcb2pdapInw+mNubI/DxJ5/4
         ukwDF+9D0uvbHrHCrxWEEbQRr+jnJx/llL62uJzvtMyguWvMybzCHTMvvDv0XD6KTfY0
         OBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7GS3sYfqdA8D7BcbQm6JfcCs8UCdRz0A7JK8XPmhPo=;
        b=dyZ0Rb+9q2puLlf7azu6wxi/xgkGP0WB7IfNtrFZ9PHe9KPIovUY4ECZHE1TrTOhfa
         br50f9Z8qiJMF0XH4rs/x4g6pe3B1DVkrsCPtkIBEgcjrGg/eEaK8JTFBLMBoBYApJWc
         oAy59d28aS8AZkMwNuGNflyYWnZGqcFcMEDehG1sqmkXhPaPi1QdpHOUkVJa8U5RfFV/
         rELZHnHxIcmL+jcPPrMjE5Jp28Y0TZpALzLBSaMdSyOZB9uZn0UZTV7BPbrkZPeKLdvq
         crtFGQk+/4RYE+2JibtXrI1IgxznhJoxqvs8LqDC8vgFWdBvFaWw0yowdtWWQ4k5gMH7
         PvrA==
X-Gm-Message-State: ACrzQf1wWkq1v6MEEhBkoHkpkjqUdiiwuvHptx+8sWpXxhgjHBlgKPxg
        sfB93Vt6zynxF6eSQM5GdoQmiSEFxxwOSQ==
X-Google-Smtp-Source: AMsMyM6+0VqV/XhGsu99mxr8QFZj/jF801tQqKMPGar2tdTGb4LQ8sx0AfPsHFfhGdeeHykNjN9lMA==
X-Received: by 2002:a17:906:5dae:b0:78e:3109:36d1 with SMTP id n14-20020a1709065dae00b0078e310936d1mr8080475ejv.470.1666206462581;
        Wed, 19 Oct 2022 12:07:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090679c300b0077909095acasm9376981ejo.143.2022.10.19.12.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:07:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1olEPk-0068Ji-0Q;
        Wed, 19 Oct 2022 21:07:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 3/4] Makefile: really use and document
 sha1collisiondetection by default
Date:   Wed, 19 Oct 2022 20:54:29 +0200
References: <cover-0.5-00000000000-20220422T094624Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20221019T010222Z-avarab@gmail.com>
 <patch-v2-3.4-78ef8636c57-20221019T010222Z-avarab@gmail.com>
 <CAPig+cS8jvUn9bR=1ywWgCC3gPosgycdcdbm+aASo59mXz6rfw@mail.gmail.com>
 <xmqqo7u7srp4.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqo7u7srp4.fsf@gitster.g>
Message-ID: <221019.867d0vhbsz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 19 2022, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> diff --git a/Makefile b/Makefile
>>> +ifdef DC_SHA1
>>> +$(error the DC_SHA1 flag is no longer used, and has become the default. Adjust your build scripts accordingly)
>>> +endif
>>
>> bikeshedding: Do we really need to penalize (abuse) people merely for
>> asking us to do what we're already doing anyhow?
>
> A valid question.
>
> I can understand and very much appreciate [1/4] as a very focused
> fix to the problem.  Very small part of this step, namely, make the
> DC_SHA1 the default everywhere, is also very much welcome.
>
> Everything else I see in these patches are extra "while we are at
> it" that should not exist.  These "while at it" changes tend to
> somehow implement more subjective choices that will cause more
> discussion and take more review resources.  Not all "white at it"
> may be more subjective, but at least in this series, they appear
> to be.
>
> They distract us from the core changes and slows us down.  It is OK
> to do them as totally unrelated clean-up changes long after the dust
> settles, but not entangled with the other more important changes
> like these patches.

There's things I can eject from this series, but I don't really find it
to be "while at it" changes, I suspect what you're thinking of is
one/some of:

 - Re-arranging the Makefile commentary into sections: I did that
   because now the structure is very much one-paragraph-per-flag. 

   So before 2/4 there's no good place to put that "Alternate
   implementations" in a way that clearly refers to the surrounding
   SHA{1,256} discussion. But yeah, I could try harder to keep that diff
   size down, or just not update the docs.

 - We're still claiming that we use OpenSSL by default, so I fixed the
   docs in general (not just the Makefile). Would you like this to be
   just a "we forgot OSX?" series?

 - Ditto asking to provide NO_DC_SHA1=Y now in addition to
   e.g. BLK_SHA1=Y if you *really* want to use that
   non-collision-detecting SHA-1 implementation.

   E.g. BLK_SHA1=Y was added in 2009. It's a small one-time bother to
   add NO_DC_SHA1=Y to your scripts if you *really* mean "I want the
   less safe SHA-1".

   But I think it's more likely that someone running into that error
   will be happy that the default has changed in a strong way.

   We've been *strongly* recommending sha1collisiondetection for a while
   now, but the structure of the build system has been the exact
   opposite, if you asked for anything else we'd avoid using it, and
   only default to it if nothing else was picked.

 - In particular the current flag on OSX is "APPLE_COMMON_CRYPTO", which
   is now split up into that & "APPLE_SHA1".

   Maybe changing our default flags is sufficient, and we don't need to
   worry about 3rd party build scripts having the previous "Yeah, I have
   that OS library" effectively meaning "...and use it for everything
   possible, including SHA-1".

Or maybe you're OK with topic(s) at large, i.e. "switch the default,
update the docs, make sure noone's left behind", but would just like it
done in more incremental steps?
