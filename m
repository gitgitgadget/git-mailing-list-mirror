Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1442AC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66CB64DF1
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhA2BSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhA2BSY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:18:24 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA57C061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:17:44 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id x81so7385388qkb.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=em+m0DZ3pQkt7TDyO4+nNp0ra5QKWAgjDhOR8231b3s=;
        b=SKDPl43uDJtm00WkibR0MlUQFZgFutmMXzlNb9Ii+ReZOIEFPAnpNcBBDxZiIr8VJ8
         7PGK12PKLvgVnEI0hkk/b6sDlDPd99Q3uz7esXdeif59BAzl6LZw36df3oXYafbDCTX0
         HjPUSqZVBe4MikgR+lPBJwOiJLRDxxMtLmHngBJUgyGiPihLk0eQZW1p438XBQ8vk9Gy
         zeVmPR/+LAd2Ttz2L2M2SJb2IOADYWs7N8FqQcGVgGxNrx8ZXiG62xiZKJI5gZ/GhAGh
         F2/fM/sFe+iysV6VLgkBWnDoQMNy16Rw+2J7Ic+xut5wi9+X/BdhW8Hp6tru1cL3MC4Q
         xr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=em+m0DZ3pQkt7TDyO4+nNp0ra5QKWAgjDhOR8231b3s=;
        b=QOVfQ6U9n/gGL7RhZfIPHLpIUhjCduzICOuxmWRQxVhuQmEleZPR2tsdiMO82zcEmH
         LPmuUuCXb8QOmUPjiTmSRV8rROsZyVuR10byc3l2zdjK+aq0Bp6ZT7o+kwBPpW9LsS4w
         Y+tHtOvO4MEY0xRL/tlkf+T/IzScFUwBQuWmGXfa9RghoEF+04LmIdr2JaNH1Da08sd2
         UPqkp9T6wcu+muxuo11tGl7E9zeW2OT5esg4eqSP5aesdPm/i6oSQAbX64UtYR2cyhB+
         BDy9lykiqIIsTHh7nk5LCMlnyajIB/gKBWg6gObxK+msYLLw+0MRv1r303ZE+6KvEPnr
         Yr2g==
X-Gm-Message-State: AOAM533hc5TagAxAiqDn1+HygBMZioNyUdKzpwS8etTDAOUBj+moTY3z
        YLSTmEeDwWwSRAqeeti2c3cJVg==
X-Google-Smtp-Source: ABdhPJybKOl1fQitnpWYk4T9yknemY/uARomASYYSgFPTuJ2olWfKEbzJPPFUzkman+AuEGmKQizWQ==
X-Received: by 2002:ae9:ebd7:: with SMTP id b206mr2198882qkg.280.1611883063400;
        Thu, 28 Jan 2021 17:17:43 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5d6b:9c45:5e60:e7b4])
        by smtp.gmail.com with ESMTPSA id d71sm4768470qkc.75.2021.01.28.17.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:17:42 -0800 (PST)
Date:   Thu, 28 Jan 2021 20:17:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 06/10] Documentation/config/pack.txt: advertise
 'pack.writeReverseIndex'
Message-ID: <YBNiNAVhlRpNKzr+@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <7e29f2d3a08c42b1e8368c4a2f52a11cc47ee959.1611617820.git.me@ttaylorr.com>
 <YBNXQDlmdZVeMsA8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBNXQDlmdZVeMsA8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 07:30:56PM -0500, Jeff King wrote:
> On Mon, Jan 25, 2021 at 06:37:34PM -0500, Taylor Blau wrote:
>
> > +pack.writeReverseIndex::
> > +	When true, git will write a corresponding .rev file (see:
> > +	link:../technical/pack-format.html[Documentation/technical/pack-format.txt])
> > +	for each new packfile that it writes in all places except for
> > +	linkgit:git-fast-import[1] and in the bulk checkin mechanism.
> > +	Defaults to false.
>
> We may want to teach fast-import about this, too, but I think it's OK to
> draw the line here for now (it's already reasonably well known that the
> generated packs aren't amazing and benefit from repacking).

Maybe this was worth explaining in the documentation, but this choice
was intentional. I'm not aware of any use-case that keeps the packs
generated by fast-import around for very long (i.e., I'd expect any 'git
fast-import' to be pretty quickly followed by a 'git repack -ad'), so I
don't think we'd want to spend time generating a reverse index for a
pack structure that we're about to immediately discard.

> -Peff

Thanks,
Taylor
