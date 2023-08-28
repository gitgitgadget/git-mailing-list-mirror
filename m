Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D4AC83F14
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 23:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjH1Xgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbjH1XgI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 19:36:08 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26641B4
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:35:39 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5925e580f12so44744357b3.3
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693265732; x=1693870532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MiCIL7HBwY6pAaYNB10rW8gu9L/J+DH3X4PF0ZQ9uGA=;
        b=3NvqybH08ZjwvRdJuKXfxt+o9gsdCuTJcCcY6C8jtZOadE2kPd5vbQLj4lnuWDRp8U
         D8Gha/+o4OTosxPtt/1SwsmgEbc0LRz+qCVtU+rAYqpUr+DVjqTJZMwYsK5DSwZ/BgJB
         gb15Opk8u3ARsidGKQuiKaqMZG9x51ZbQGDA3ioC07ogZbICwqPvrtRejc7yiAKexOnE
         mCz5JjoZPNFdgqcK63OaQ0+kxoII5bHWVWVgpkWuwhxR5LNKDukIvJ0+g508U/vDBfUt
         WB+SfYZ1mzoSg29Erd1O4Jh9+YGc5plJv70EJuLJrmIOOUv4kyD+mCm9WPEkcqyrl8Q/
         hulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693265732; x=1693870532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiCIL7HBwY6pAaYNB10rW8gu9L/J+DH3X4PF0ZQ9uGA=;
        b=QAOU2YTzJmkbWzcgncPIWtbueXBnPaIKOoaiXAW2yfaVOsK6nLjz9x6ibTPVUY/SRr
         MzA00ps207WXWN//BZHlJJhrOnyevT5DMVPMtOJloE6UUy21awiOvurFDnVqGlE4/HxL
         3LeXgm1fIgUADpYclt2U0qJGqGgvHcBA6rOsTKLgn7XUGuZqoiHW9+jiVJNnwMzjW7bg
         9+HTZbLEPZv4MPzsjiWXBvW+db6w1BCKjLRkXZ3kStgxvGOy7vJBrEGW0OoYG65cX+zI
         h3R7derDxZIxRt9/+T45yg6bGblHmXZ6hFhC+JJEe41nTIgIh3A5hHQq+dSKOfxzomLO
         sL/A==
X-Gm-Message-State: AOJu0Yya+07uq6hKSXAMpxoWtSQIO8VQaWWFmWp4cOsFwDZxEiJ43gWQ
        H9VQKSt9tro4igZOOEy4MLMVNDhVVY/ohETQGw6cYA==
X-Google-Smtp-Source: AGHT+IEC41ZrUyVg1jhKWzPCXgHyOXIK+uMHc+ZxVt4q/EyA03y0QtKyQkPX9INr0lr3O82r9wxXcA==
X-Received: by 2002:a0d:c781:0:b0:58a:d281:a275 with SMTP id j123-20020a0dc781000000b0058ad281a275mr28653753ywd.21.1693265731764;
        Mon, 28 Aug 2023 16:35:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z185-20020a8165c2000000b0058fc7604f45sm2455162ywb.130.2023.08.28.16.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 16:35:31 -0700 (PDT)
Date:   Mon, 28 Aug 2023 19:35:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/22] YAUPS: Yet Another Unused Parameter Series
Message-ID: <ZO0vQk6LWxNhLrd3@nand.local>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 05:46:04PM -0400, Jeff King wrote:
> I'm back with another exciting installment of -Wunused-parameter warning
> fixes. Most of these are pretty boring and obvious; the first two are
> the most interesting in terms of rationale.
>
> I promise we're closing in on the finish line here. I only have about 20
> patches left after this, at which point we should be able to turn on the
> warning by default for developer builds.

Heh ;-). It's good to see us getting dangerously close to being able to
turn on -Wunused-parameter in the DEVELOPER builds.

I reviewed this series, and all looked sensible. I left a couple notes
throughout for potential further cleanups that we could do on top, which
might be nice to squash in.

But I wouldn't be heartbroken if you want to ignore them, either. So
with or without my suggestions, this series LGTM.

Thanks,
Taylor
