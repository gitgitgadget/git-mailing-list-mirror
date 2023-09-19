Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D3CE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 17:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjISR5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 13:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjISR46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 13:56:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056EB95
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 10:56:52 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59bfb0825efso53280457b3.3
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695146211; x=1695751011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDe5q8ZmtRGuNkyFcXVkEtbw7iWZA+8g5iLfodMx7f8=;
        b=LGF601hw6GwcKmFB/vGUn1NxOzTIkqYYzTbR0h5Jg+n+63hQrBQ4O6LTYn8H6AzuXt
         +/lUQX+Tnn05GlwcKwvXCkw1whHjnEUjzvlTHAMV8yFmHMaal/dAqo3q2RuaiwdFjz57
         iqKsxp5skDzqjxtdhbePy3pVY/pv4aWkj6tydZwiDAillsZC72zIXh2C8dir1rXBG2cB
         VfwCnObIoy0mBYbhL5iZOCZfAZPQOJ4UejCPWpulqWN6Hy6s1lwk2GZlQoyoL9Rcip+H
         awzFWsHVf30DE+3FpuuoiVRVMI2YTlxhMm2z68bJlefb6ej8M8DvzGeDempkL6HX8juL
         yfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146211; x=1695751011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDe5q8ZmtRGuNkyFcXVkEtbw7iWZA+8g5iLfodMx7f8=;
        b=gTbrv/+fl6UCuOJHZHgk99l5D3rNRtytTVz781zcYqUAUhrvasSXQTejfxbezZHD1y
         EHmEDBYzlx4fr6pZYLG14LrPiKuoUxtnUMRXxRQlpPgmFNtD/VCv1U9YL9tSPzkz3nz3
         DDm06CrWYb3/+k2FdPIiBM7YcK+bnIPqB/7l2Vodch2pLtt982pW4GPBywCrqjWzIXoI
         PFtQsokzWKHJ4FHJjdE1udgHt7fOvQSui28gzPwdNaX5OxDrCLxAMBcuPbMptJ7eMSfz
         gA44+DxOp9ROECcB9KsAGZt34GI6RiF0yauM72at5hFSo/kVTY5ZoSriFFGtoPxblhi3
         2DmA==
X-Gm-Message-State: AOJu0Yxuwf2+fywxlqI9FZNehpSPXcLObjneOh6Zjvq6zmbZQkF4I7SB
        L/dH7u4URAlW/5XM4lkfnz+GdsototkbPLPsAYDPpg==
X-Google-Smtp-Source: AGHT+IG17uPtYfyYF89EYrroZxLYDU0gHFtOC60tbI7u5HaALIzYSNqrHZIbsofj8cnCRBGCtyH5AQ==
X-Received: by 2002:a81:7287:0:b0:59b:b24c:4161 with SMTP id n129-20020a817287000000b0059bb24c4161mr175138ywc.52.1695146210226;
        Tue, 19 Sep 2023 10:56:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z15-20020a81c20f000000b0057736c436f1sm3251428ywc.141.2023.09.19.10.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:56:49 -0700 (PDT)
Date:   Tue, 19 Sep 2023 13:56:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] http: update curl http/2 info matching for curl 8.3.0
Message-ID: <ZQng4UNugsw6eKhq@nand.local>
References: <20230915113237.GA3531328@coredump.intra.peff.net>
 <20230915113443.GB3531587@coredump.intra.peff.net>
 <ZQSkjiyrOac4DK8q@nand.local>
 <20230916053201.GB13092@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230916053201.GB13092@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 16, 2023 at 01:32:01AM -0400, Jeff King wrote:
> > But I think we would happily eat a line like:
> >
> >     [HTTP/2] [] [Secret: xyz]
> >
> > even lacking a stream identifier. I think that's reasonably OK in
> > practice, because we're being over-eager in redacting instead of the
> > other way around. And we're unlikely to see such a line from curl
> > anyway, so I don't think that it matters.
>
> Yes, you're correct that we'd allow an empty stream identifier. I'm
> content to leave it in the name of simplicity.

Yeah, I am definitely OK with that as well. I don't think it's worth
being overly specific in what we accept for redaction, since we're
erring on the side of being less restrictive.

> > But this may all be moot anyway, I don't feel strongly one way or the
> > other.
>
> My inclination is to leave it. I was actually tempted to just allow
> _anything_ in the brackets if only because it makes the code even
> simpler, but the "skip past digits" seemed like a reasonable middle
> ground.

Yep, same. Thanks for the sanity check :-).

Thanks,
Taylor
