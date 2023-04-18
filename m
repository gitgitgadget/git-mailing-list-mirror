Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8B7C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjDRTos (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjDRToq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:44:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F58955B5
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:44:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id t16so17382199ybi.13
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681847084; x=1684439084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vi8vJ49DXK/RAh8+Xk+/AMwTjjsULJWVTSfJdy4vEKI=;
        b=ClIolKXMtmUxZIbfH/S0FH29Na+zNRY6kk4jrqfzP3gHt1VSmV5tEoHESYeiT9vLYr
         TkpgT80fvd99tti8bGUx1BGtXVOlwzKRCVjNZw+mot3eXJwafA2+wYYkBnVAdPbXVA/9
         2SVfbxw9aOyZ9aOgTMe/l4Wdz2kNfvGChMX5iE4b5ceKDbD9FPP2vmBh0n3uupSa2xiC
         QksxwsMywAlDs3dIf0tPHbKAnW4jrkwPqEZB0FB34c5NGQtBEatToK4FnZI+ow2IIAZz
         uIY0n5Jv81agIKU4+tW3pdJhbrjG+VMc7LzuXCB6lnyDbIacfyiHvRK2qaOLT6vV+PY+
         +l3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681847084; x=1684439084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi8vJ49DXK/RAh8+Xk+/AMwTjjsULJWVTSfJdy4vEKI=;
        b=WjPwVC/vuAhjeA+gIRftDcw0qv0chN8SvO5SldaMDif+VQxgsvFPc5VHPXH+vtUuib
         yXQOsM5Js6FIiPbX3pTaE2CqEq4OPSko08bggWndUI8hvaKAeFmZMcFKyKLodXIHNDfK
         SHh6a4ETNtb1qzQyAqOlWvenzPlzJyf8tHr/kr0FdtD7ygfNONmzjmTgXhmPIiDbzZ60
         jw+EoUnAj2OT87CsXkUbqb0KYSYihYHbw/DwREBau7ywszXCnhqVIKxZ6SO3kHoJLF71
         8jKTqvrphkTQllu4lM4AIq6hxpZgmFhjxemt4N8AUfliahz0EScHcrxlpVfmgasgH1Hb
         X0lA==
X-Gm-Message-State: AAQBX9dubJQhrM5uMRUia6TaAtR7l/wdWPFJVDwQ37H+pLZKwai0ZHCY
        mpo5HJ0nbA+mGYiSMD+bdHEXHA==
X-Google-Smtp-Source: AKy350azvpY8qAU1wkg/yBRtMWrpmcpu/oDzrqY9ZolGi9FquwdIrY/23IKBuYn9i2vR+A8OcyDupA==
X-Received: by 2002:a25:4ca:0:b0:b8f:9b8:ceb7 with SMTP id 193-20020a2504ca000000b00b8f09b8ceb7mr18769698ybe.44.1681847084355;
        Tue, 18 Apr 2023 12:44:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p198-20020a2542cf000000b00b9582234118sm519830yba.32.2023.04.18.12.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:44:43 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:44:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/10] t/t9300-fast-import.sh: prepare for `gc --cruft`
 by default
Message-ID: <ZD7zKl3iDQc/TbWJ@nand.local>
References: <cover.1681764848.git.me@ttaylorr.com>
 <1b07eb83fe6ab9fcb65d5a4746dec50c0f2cbd9e.1681764848.git.me@ttaylorr.com>
 <20230418104331.GE508219@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418104331.GE508219@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 06:43:31AM -0400, Jeff King wrote:
> On Mon, Apr 17, 2023 at 04:54:27PM -0400, Taylor Blau wrote:
>
> > In a similar fashion as the previous commit, adjust the fast-import
> > tests to prepare for "git gc" generating a cruft pack by default.
> >
> > This adjustment is slightly different, however. Instead of relying on us
> > writing out the objects loose, and then calling `git prune` to remove
> > them, t9300 needs to be prepared to drop objects that would be moved
> > into cruft packs.
> >
> > To do this, we can combine the `git gc` invocation with `git prune` into
> > one `git gc --prune`, which handles pruning both loose objects, and
> > objects that would otherwise be written to a cruft pack.
>
> Good. This is more efficient anyway. It probably does not matter for our
> tiny test repository, but it is always good for our tests to model the
> best option when possible. :)

I spent more time than I'd willingly admit second-guessing myself
wondering if there was something I'm missing why we'd want to call `git
gc` and `git prune` separately.

As best as I can tell, this pattern started all the way back in
03db4525d3 (Support gitlinks in fast-import., 2008-07-19), which
happened after deprecating `git gc --prune` in 9e7d501990 (builtin-gc.c:
deprecate --prune, it now really has no effect, 2008-05-09).

After `--prune` was un-deprecated in 58e9d9d472 (gc: make --prune useful
again by accepting an optional parameter, 2009-02-14), we got a handful
of new uses in this script via 4cedb78cb5 (fast-import: add input format
tests, 2011-08-11), which could have been `git gc --prune`, but weren't
(likely taking after 03db4525d3).

I don't know if any of that detail is interesting enough to rise to the
level of needing to be in the patch itself, those were just my notes I
took while wandering through this part of the suite.

> >  t/t9300-fast-import.sh | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
>
> The patch itself looks good to me.

Thanks!

-Taylor
