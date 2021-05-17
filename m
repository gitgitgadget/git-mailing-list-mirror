Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EC1C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 10:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09444611C2
	for <git@archiver.kernel.org>; Mon, 17 May 2021 10:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbhEQKyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 06:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbhEQKyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 06:54:43 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A255EC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 03:53:27 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u11so6099725oiv.1
        for <git@vger.kernel.org>; Mon, 17 May 2021 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Y0LSMPrziytKLB2nOw5Mw4iV3ULhMb82a/Y3ktzVOZ8=;
        b=PS74ddMAElsZSymwiyvOzONAz6hglf5t2Ly3QuV9naigmECgD9D2wizZQQ8EznXSHe
         FH5Ay7kALOjkGJxIP480L1WZknjXyPSvC8dloUs7gGEJbwIb5J/ymnNsWvlOVcaMbvCa
         6BZaFAZZrDre0Sg7ZWefVRT/osL5f6+fQZeCWBEZLhIlcwMC4u/hxDNZUiCqzGP6kjCp
         lpNWMlRqMIGcvCHfhrzKkE1v+uWTgbmLUvZMTNF4/tk+EmE5Hn8FG/Gr+4rHnMtyiVJk
         Osvfzc2PsGvbAFpVvxVi9KYFYzJdgwGGp5HL4XNmgH6J0On2TZEi+3hkFVmwKbwjP/vg
         Z8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Y0LSMPrziytKLB2nOw5Mw4iV3ULhMb82a/Y3ktzVOZ8=;
        b=gLBq6L86/BKlRP0jKFBxtU5Krq04UONtGf2MDwt9X57x743kyg25J4CmEoEuxW+pne
         xPZjOimG5cX4cf1xTENGZEBNOa1lV9N39CZ0L3KLPE2e6X1uLsUtRAKVJXgP0cdaZ+St
         NrR9+tz6hw/jQH6TBfr241BPnm9iPp1ogr9GTYzTaW8xLus4kfp8Mq9SRKzRWCqHpEkx
         p1YfAgqg2mplQr/xMxRX3N/b8udAR2cOZD1kq0UjTZwA2X1OMmaQ8NxXw6Yl9VjKij4u
         cb9VNvnlyZ5usSH3IYZ9f8p94cNq/B5sRyKZTGyLSE2NzBimcKc9QpQFaO4JoSS61YKR
         A3qQ==
X-Gm-Message-State: AOAM5324N+ZZbsqh6YNzFx+Q8BGocV/+8UtVJ9942OYLfU84ttzIo0sh
        yz/vOeaXCq7KNItYBkTs6Oh0JsxGG7+udg==
X-Google-Smtp-Source: ABdhPJwVzEsVfoczJECnNv6bXZY881/u7EIyanr/t/rP6MFDpQxesqYi3H5kiw9vNu6LC5+vDZhf3A==
X-Received: by 2002:aca:d544:: with SMTP id m65mr42756221oig.73.1621248807032;
        Mon, 17 May 2021 03:53:27 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id h20sm2705739oie.33.2021.05.17.03.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:53:26 -0700 (PDT)
Date:   Mon, 17 May 2021 05:53:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60a24b25499c0_126a0520823@natae.notmuch>
In-Reply-To: <YKIwDTQI3sBXu+7W@coredump.intra.peff.net>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
 <20210514121435.504423-2-felipe.contreras@gmail.com>
 <YJ+VGKUa0Kk3BRWQ@coredump.intra.peff.net>
 <YJ+WzATLCM8SW2GH@coredump.intra.peff.net>
 <609fbafc73fcd_e173a208f4@natae.notmuch>
 <YKIwDTQI3sBXu+7W@coredump.intra.peff.net>
Subject: Re: [PATCH 01/11] doc: allow the user to provide ASCIIDOC_EXTRA
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Sat, May 15, 2021 at 07:13:48AM -0500, Felipe Contreras wrote:
> > Jeff King wrote:

> > > To go into further detail: usually we distinguish variables we use
> > > internally from user-facing ones, and include the latter in the former.
> > > I see a later patch wants to start passing ASCIIDOC_EXTRA on the
> > > command-line, and we'd use two variables for that.
> > 
> > Well, it's not exactly user-facing; it's only needed for doc-diff.
> 
> It's meant for the caller of "make". Your proposed use is within
> doc-diff, but any user running "make ASCIIDOC_EXTRA=foo" would see the
> different behavior.

Yeah, they would, but I don't think it would be wrong behavior.

> > Would TEST_ASCIIDOC_EXTRA make sense?
> 
> I'd probably call it ASCIIDOC_FLAGS (like we have CFLAGS and LDFLAGS
> that are meant for users to inform us of extra flags they'd like
> passed).

Right, but Makefiles do override those, like:

  override CFLAGS += -fPIC

Otherwise builds may fail.

> Of course that may not solve your problem in a sense; if you want
> doc-diff to override it, then that might conflict with a theoretical
> ASCIIDOC_FLAGS somebody set in their config.mak (but we really are in
> the realm of hypothetical here).

Setting ASCIIDOC_FLAGS in config.mk would not override the
user-supplied flags any more than setting them in the Makefile (they are
virtually the same thing as one includes the other).

It's only if the user has `override ASCIIDOC_FLAGS` in config.mk that
such a problem would arise. And that's really hypothetical.

Cheers.

-- 
Felipe Contreras
