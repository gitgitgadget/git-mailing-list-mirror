Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF49C43460
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87F761028
	for <git@archiver.kernel.org>; Mon, 17 May 2021 16:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhEQQxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 12:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242128AbhEQQwo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 12:52:44 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E58AC06137F
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:50:41 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v22so7084989oic.2
        for <git@vger.kernel.org>; Mon, 17 May 2021 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yFydeqKAnfb59TZfsP972xanyg4PSxvU9ZzldPyS2As=;
        b=ok7YQpeioxdKvYzLOXm1/qILzGsnLSkMP7K/HGjULNvkS3CJ3runAd0rxZH6PWc7Gn
         s+90TNP6HIvo3a3smZgqc7sqC1GdbD5JcL7p6uUdQ1NPdQpLxl0Wcsfw9z23yeZlykoK
         ZKMhxnO8rHrx42GKQFwcSvqs1qt171tV4mR5EcfmXDS5YQVg1DNCsGlApEVoyDT31eUt
         lLwFaFb0n9nvkilfY+FQr+mBsiD04TTbNO8U24s8zCVV6iP5ayIORXnSKK3Yg1gMngu6
         4zTrUmga4KcUWLsR93OlURU8lNmc2mGAshRKJx0zbimzFcJnO86xMQg+cGw+QyRyDZE5
         tIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yFydeqKAnfb59TZfsP972xanyg4PSxvU9ZzldPyS2As=;
        b=o5x/i/xKb0aBCxgMgP2ufu3clRebpuTWjSgT0ZbODlTw7CYBlBKZ1S2kNx/0EYSiDy
         0+39btPDQfEOQBAEUZsbM6S0Eh8cmGDHSOi6Xdqq57yUkbcymvsMyfg5MeFrvERxZ6Ps
         xNw8Z2zWLEn3T+eR50vA2lkIXMonxwHoAiUJRY/4wFXMJ9ryPzHUN+xAA4JjWSYlOiKm
         i/7jaFWbtFEtg5MnARA6Zpc4048TCviXBaD+5yBbEmhcBjtKanOlB4VsPb+vucqMC9ZS
         cdomWhHqPR3AOeYmU/AkI73Uw3pGlegH3PvtvG2dd0PJQfRw7fc68f9P/nssOPNH/BcI
         ZR8g==
X-Gm-Message-State: AOAM531L7NRqBzbUNmROrEs9cD77zD0pit9OrNGxOtS1AbmES6NTgp5W
        i67R+Lm2ptm8cQuyEdIFdLA=
X-Google-Smtp-Source: ABdhPJz2VGGKDhN0XX5rrgnvCCo30qBviMpNS136HpXflhxq5w5+bg9Ltl//yz5AS8meCF6oxKf6GA==
X-Received: by 2002:a05:6808:1304:: with SMTP id y4mr68898oiv.20.1621270240528;
        Mon, 17 May 2021 09:50:40 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w66sm3155688ooa.37.2021.05.17.09.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 09:50:40 -0700 (PDT)
Date:   Mon, 17 May 2021 11:50:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60a29edea3d13_12801e20873@natae.notmuch>
In-Reply-To: <YKJV8HBYCA7hEQiX@coredump.intra.peff.net>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
 <20210514121435.504423-2-felipe.contreras@gmail.com>
 <YJ+VGKUa0Kk3BRWQ@coredump.intra.peff.net>
 <YJ+WzATLCM8SW2GH@coredump.intra.peff.net>
 <609fbafc73fcd_e173a208f4@natae.notmuch>
 <YKIwDTQI3sBXu+7W@coredump.intra.peff.net>
 <60a24b25499c0_126a0520823@natae.notmuch>
 <YKJV8HBYCA7hEQiX@coredump.intra.peff.net>
Subject: Re: [PATCH 01/11] doc: allow the user to provide ASCIIDOC_EXTRA
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, May 17, 2021 at 05:53:25AM -0500, Felipe Contreras wrote:
> 
> > > It's meant for the caller of "make". Your proposed use is within
> > > doc-diff, but any user running "make ASCIIDOC_EXTRA=foo" would see the
> > > different behavior.
> > 
> > Yeah, they would, but I don't think it would be wrong behavior.
> 
> It depends what they're trying to do. If they write:
> 
>   make ASCIIDOC_EXTRA=--one-extra-option
> 
> then they probably intend to to add to the options we set. If they
> write:
> 
>   make ASCIIDOC_EXTRA='-acompat-mode -atabsize=4 ...etc...'
> 
> with the intent of replicating the flags but changing or removing some
> elements, then it would no longer do what they want.
> 
> I don't mean to imply one is more right than the other (I'd suspect even
> that the override behavior is more likely to be what somebody wants).

Yeah, but I am implying that one is more right than the other.

> I'm mostly pointing out that this is unlike the rest of our Makefiles,
> which do not ever use override (and that the effect is visible to the
> caller, depending on what they want to do).

It's used in the main Makefile, although in a different way.

I see how it is not consistent with the rest of the Makefiles, but I
wonder why it's not being used. It's rather useful.

> > > I'd probably call it ASCIIDOC_FLAGS (like we have CFLAGS and LDFLAGS
> > > that are meant for users to inform us of extra flags they'd like
> > > passed).
> > 
> > Right, but Makefiles do override those, like:
> > 
> >   override CFLAGS += -fPIC
> > 
> > Otherwise builds may fail.
> 
> Some Makefiles do, but in this project we have not historically used
> override. Instead, we provide defaults for things like CFLAGS, expect
> the use to replace them if they like, and then aggregate them (along
> with other internal variables) into things like ALL_CFLAGS.

I know, but status quo is not an argument.

If we always did things the way we've always done things there would
never be progress.

I'm aruging there's no value in giving the user the opportunity to break
the build by doing `make BASIC_CFLAGS=`. Yes, it's more historically
consistent, that doesn't mean it's good.

> > > Of course that may not solve your problem in a sense; if you want
> > > doc-diff to override it, then that might conflict with a theoretical
> > > ASCIIDOC_FLAGS somebody set in their config.mak (but we really are in
> > > the realm of hypothetical here).
> > 
> > Setting ASCIIDOC_FLAGS in config.mk would not override the
> > user-supplied flags any more than setting them in the Makefile (they are
> > virtually the same thing as one includes the other).
> > 
> > It's only if the user has `override ASCIIDOC_FLAGS` in config.mk that
> > such a problem would arise. And that's really hypothetical.
> 
> I mean that if your doc-diff runs:
> 
>   make USE_ASCIIDOCTOR=Yes ASCIIDOC_FLAGS=-adocdate=01/01/1970
> 
> then that will override anything the user put into config.mak. If they
> had some option like:
> 
>   ASCIIDOC_FLAGS = --load-path=/some/special/directory
> 
> they need for asciidoctor to run correctly on their system, then things
> would break for them. But we don't even have a user-facing
> ASCIIDOC_FLAGS now, and nobody is asking for it, so it's pretty
> hypothetical (I'd guess somebody in this situation would just set
> ASCIIDOC="asciidoctor --load-path=...", and that already doesn't work
> with doc-diff).

Exactly, so it's unclear how much value we get by talking about these.

Either way, I don't feel very strongly about `override ASCIIDOC_EXTRA`.
I think it's superior but ASCIIDOC_FLAGS requires less changes, so I'm
fine with that.

Cheers.

-- 
Felipe Contreras
