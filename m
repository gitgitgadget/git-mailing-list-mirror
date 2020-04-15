Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B262C2BB1D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44B220784
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 00:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WTSoI3Qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392396AbgDOAeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731654AbgDOAeH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 20:34:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42734C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:34:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n24so586277plp.13
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hnXKxVZzJWakBPkfDA+qARTuSVuKTGLuc9RCZdkTWBc=;
        b=WTSoI3Qf35Spvyq6IMrLr7UTCSgksCDM29V0r4QnSXPqurQDYjOCkWKAQxTE6KUSt4
         4MvhOFqF+SgvB/MNS/SWHXPU0sQnbgSSr6O4s2AoDGsc9jqUFtqySkJsYCYZSaJZSEok
         m/teBmWm0XEoQjPWRje/KiqPX9C2DYVBIqkMOyTvSQH4hRaXOkb2TIoynVLWKHkPwkDV
         h1rxF1UCxqPEtiw99ye69g5UGvM2F97C7ci1i3DgzdFsTLkdMroisVZRVaNXWVY7JWtq
         dtLHrWCWcGdr1WeDN6E6cYI+uw8GdBp2Qs+6n6b8jSGJcO+IlsgjXtY3keA8OvPjzRmc
         rVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hnXKxVZzJWakBPkfDA+qARTuSVuKTGLuc9RCZdkTWBc=;
        b=aBC0tlULn6R0WJpQOFrekek8RzSzrAd5AQWEmi/U1tHggJBKfttaTJeVlB7Y7AXvTi
         VxD1khu7ryUxAYvoVmWuAu/3h1w7Vu5+AO22AytaC/fnyQKz9buq6x6gfyOlkf3znydY
         LnQ6hhELyqMhih08pVVr2OJEorsi/djVMt0s9ZMvXHJboVRTa7OG763Fg2+zeZKivGig
         Z1jxVhoekuVS+ZX2JKRJN+1jdT4kVRPdKj03oA4wCnUudYlrImOMgUnggWSfiWjpA/db
         NNPkrCVn3B2qNy4oe8Z7g/mUscfLqhktTqkfgCQuXtNYCzj4WWKTlXhr7YmHuuvT1kMc
         F8FA==
X-Gm-Message-State: AGi0PuaI3+y5Ww3/hn1c3po8BXhzTr+dyAMABHOpmriEDNpHmF255eBn
        ettAf2o1vLo+/PYu0a0HNSY6SA==
X-Google-Smtp-Source: APiQypKxtP7OJ9CYurDGgzxaYeDabUIgzSmEnYfKStdwdRsSYFXbnNQTiESgFPN3jt88OdRqJk3IFg==
X-Received: by 2002:a17:902:7488:: with SMTP id h8mr2367443pll.289.1586910846754;
        Tue, 14 Apr 2020 17:34:06 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id o99sm4271560pjo.8.2020.04.14.17.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:34:05 -0700 (PDT)
Date:   Tue, 14 Apr 2020 18:34:04 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] oid_array: rename source file from sha1-array
Message-ID: <20200415003404.GD7457@syl.local>
References: <20200330140247.GA476088@coredump.intra.peff.net>
 <20200330140346.GC2456038@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330140346.GC2456038@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 30, 2020 at 10:03:46AM -0400, Jeff King wrote:
> We renamed the actual data structure in 910650d2f8 (Rename sha1_array to
> oid_array, 2017-03-31), but the file is still called sha1-array. Besides
> being slightly confusing, it makes it more annoying to grep for leftover
> occurrences of "sha1" in various files, because the header is included
> in so many places.
>
> Let's complete the transition by renaming the source and header files
> (and fixing up a few comment references).
>
> I kept the "-" in the name, as that seems to be our style; cf.
> fc1395f4a4 (sha1_file.c: rename to use dash in file name, 2018-04-10).
> We also have oidmap.h and oidset.h without any punctuation, but those
> are "struct oidmap" and "struct oidset" in the code. We _could_ make
> this "oidarray" to match, but somehow it looks uglier to me because of
> the length of "array" (plus it would be a very invasive patch for little
> gain).

I was wondering what you were planning to do about that. But I think
that what you did is the right move. Sure, perhaps it'd be more
consistent to call this "oidarray", or rename everything else to
"oid_map" and "oid_set".

I prefer what you did here to that, I think because I also find the
"oidarray" spelling to be weird.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Thanks,
Taylor
