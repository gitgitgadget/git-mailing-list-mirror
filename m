Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BB3C76195
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 23:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCXXXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 19:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCXXXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 19:23:20 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A065CC08
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 16:23:08 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p204so4127990ybc.12
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 16:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1679700187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9My0fCVYLEC+diDJVHB9PEsX5BIbXPB/VPIcsLmTYgk=;
        b=YKLxDedeQ8/AO+pXHAdHsmhNx5FEMOp4T784CGk6oFpPEN2G98DROjlyM7yNLgG4fF
         XQGUGma07Udu2wikZc04vAxvLik2vDOratMDq0pkgSUgqDrSt4XwzFHRZiyVJnhyzGFF
         1PjGfqE346kYgIPNytLWwrSsTz36K1TsHeN4q47aQ1UwRdBh+m/B07wmJZzCfINf5xfF
         DlfQyc6nAmptzE4hSJqFhUqblAedpLApRLa2x/c8T5NkmqR3j77lhWkik+H8iJMrMoWY
         uH+JbkJRZAbSnmOlchja9x22v4hmD8Lif4Z1IHAUR3ecj74Hd9Rl3uAtjgzVVbyC/s75
         yw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679700187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9My0fCVYLEC+diDJVHB9PEsX5BIbXPB/VPIcsLmTYgk=;
        b=yzlnfWGQEreEisozRQSVusCjpztoW321z3zsjtHSSzhNf6Uc1NtDUqeNn+Fb4qSMJy
         bSm4rLrnumcG4xVVomWm9DvUTJthSUpdGdw59ojM+kO5GjlFO/K4FmqWqsmYSMX2vrMg
         0qC1SpLSLMHmQbSsH5+zH8q0UluvLFrLG3Ad33Nqk0olimzdjQ+PptPe+Ot5Z71hvBmf
         0ZbsBflov33JwN8M6iPmZElxHRIvMH+o+t0OVZAu6fAPzu3DZmQcIVUgePBcuPOzOOKz
         YPPLe/NYcgMgxzRQVg1rWDZbbCuia4L3m/I2dzC4UVqKLvWVCwSQp0ul9XrkTai9tPjl
         11zg==
X-Gm-Message-State: AAQBX9dhDK+S1lWz/nXN4EXsyLFrrpAtVuEf5OuFJKKeUy07BdA4HrA8
        JL9/KR8Sj5BmpI+cQjcCbP0KDX/ewZ759skehm0VgA==
X-Google-Smtp-Source: AKy350Yy+8D1Tj7trSkM6vCPajfMxk+VlP8jdnNzn+Er72ndD7gTGjZKAp6JFc4cSxXpTeWwjb0M1A==
X-Received: by 2002:a25:3404:0:b0:a30:3ccd:e16e with SMTP id b4-20020a253404000000b00a303ccde16emr4157372yba.2.1679700187471;
        Fri, 24 Mar 2023 16:23:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bv15-20020a056902098f00b00b7767ca747asm746714ybb.23.2023.03.24.16.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:23:07 -0700 (PDT)
Date:   Fri, 24 Mar 2023 19:23:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 4/6] pack-bitmap.c: factor out manual `map_pos`
 manipulation
Message-ID: <ZB4w2gCo/qPCmWkz@nand.local>
References: <cover.1679342296.git.me@ttaylorr.com>
 <0decf13869df6216914044a560d94968126836f4.1679342296.git.me@ttaylorr.com>
 <20230321175612.GF3119834@coredump.intra.peff.net>
 <61ae4ad5-4d4d-933c-a2cb-e7e2cd734401@github.com>
 <20230324182929.GA536252@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324182929.GA536252@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 02:29:29PM -0400, Jeff King wrote:
> We know the advance will succeed because we checked ahead of time that
> we had enough bytes. So it really is a BUG() if we don't, as it would
> indicate somebody missed the earlier check. On the other hand, it is a
> weird spot for an extra check, because by definition we'll have just
> read off the array just before the seek.

Here you claim that we want bitmap_index_seek_to() to call BUG() if we
end up with map_pos >= map_size. But...

> The case where we _do_ seek directly to a file-provided offset, rather
> than incrementing, is an important check that this series adds, but that
> one should be a die() and not a BUG().

...here you say that it should be a die().

I think it does depend on the context. When seeking directly to a
position before reading something, die()-ing is appropriate. The case
where you seek to a relative position to reflect that you just read
something, a BUG() is appropriate.

So really, I think you want something like this:

    static void bitmap_index_seek_set(struct bitmap_index *bitmap_git, size_t pos)
    {
      if (pos >= bitmap_git->map_size)
        die(_("bitmap position exceeds size (%"PRIuMAX" >= %"PRIuMAX")"),
            (uintmax_t)bitmap_git->map_pos,
            (uintmax_t)bitmap_git->map_size);

      bitmap_git->map_pos = pos;
    }

    static void bitmap_index_seek_ahead(struct bitmap_index *bitmap_git,
                                        size_t offset)
    {
      if (bitmap_git->map_pos + offset >= bitmap_git->map_size)
        BUG("cannot seek %"PRIuMAX" byte(s) ahead of %"PRIuMAX" "
            "(%"PRIuMAX" >= %"PRIuMAX")",
            (uintmax_t)offset,
            (uintmax_t)bitmap_git->map_pos,
            (uintmax_t)(bitmap_git->map_pos + offset),
            (uintmax_t)bitmap_git->map_size);

      bitmap_git->map_pos += offset;
    }

Does that match what you were thinking?

Thanks,
Taylor
