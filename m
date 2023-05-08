Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A5EC77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjEHW0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjEHW0c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:26:32 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EAA5B92
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:26:31 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-55aa1da9d4aso91806337b3.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683584790; x=1686176790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5gMwLqfRf3c3zUdKI4dQ6JT7rCBr04uhT2TSvZSUMxU=;
        b=cQ0vOjXn/jts9zNDwQnEhn1Pkh1b6UT7QK8hcE2GSUGjnKiB1jMixr0+c3oumeBBCj
         pOT/vFVB+J4DA1Duhn8IVreSy4STu+hhhGyc79I9XkZjv5MmGe11xrgayz6kyKxMt8RQ
         gBIqXAsDuUp8E8XIhwjzJRLXEjaPmS2E2VAIyyoMm1STDGGzV2ytB678y1nSkas3klUo
         g6fWOg24byG3nQ8ioYfRpkS0mWMGdXokwNLNkpmg0UKURO/0wuMdgIn2PTknZuj7utXY
         dgfsG82Lx9muV/LKl0Q0e5Qw3nZnsisFPn/B3e6RYGgVasYBKnNirUtdnN6CCzCcIy83
         yG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683584790; x=1686176790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gMwLqfRf3c3zUdKI4dQ6JT7rCBr04uhT2TSvZSUMxU=;
        b=LtWgk/Qb0MIUmK7y5370jMIdNT8xNPbCM00RucTMOQPUSt90ub1I7TLkuuebiNQXkG
         ZkGsBE4ReDh8jjPNxDYj1yvVDX5OiZi2PLYsJ8/BX17qXUbfT4+XwGGEnsgswpy6Srzo
         muEbWdDNXRd8kN2aIzYp0YQsOvbF0wI38sg515JNXDxG9tg0rxjUUxaMv4EzmUQcEs5K
         V71sWEe1yg5ydDTO9LuaTPOnY3WZ15BzfyIALWpw2XhBMY1qgliPyq3cJ9+lYwCam3mT
         afXknDQY7xjMwUSEcGUAN5JLjbKqIGjV72k0IZtDawmjJXkQTqADHELav66resUt/Ewp
         Bfnw==
X-Gm-Message-State: AC+VfDyhjV3UFeSbDHFxV7gihkpB4gqUL6LsB5h0StO8ULHFdbyzGJko
        JNmwbLF47oxML95bN2LV1Q1Nc50KyfwqcG4s6eQFLw==
X-Google-Smtp-Source: ACHHUZ6T0Av6SC+VB2Dp0bnqR94rdFcl/ifaG84Q1pXsHUx4xbkjIEojhnvfhKmpTOcDxfLcmRoFEw==
X-Received: by 2002:a0d:d483:0:b0:55b:4940:1bb5 with SMTP id w125-20020a0dd483000000b0055b49401bb5mr10965719ywd.22.1683584790641;
        Mon, 08 May 2023 15:26:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s126-20020a815e84000000b0054c0c9e4043sm2827231ywb.95.2023.05.08.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:26:30 -0700 (PDT)
Date:   Mon, 8 May 2023 18:26:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] dropping "verbose" test helper function
Message-ID: <ZFl3FSt2a59G/X7m@nand.local>
References: <20230508185953.GA2108869@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508185953.GA2108869@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2023 at 02:59:53PM -0400, Jeff King wrote:
> I happened across an instance of the "verbose" helper function in a
> test recently. I think it's clear we prefer the "-x" tracing to it these
> days, and we've been slowly removing instances. This series gets rid of
> the last few.
>
> The actual change (and rationale) is in patch 3. Patch 1 just fixes pipe
> problems on lines we'll be touching patch 3, and patch 2 is a cute
> optimization enabled by patch 1. I don't think any of it should be very
> controversial, but it can all be split up if need be.
>
>   [1/3]: t7001: avoid git on upstream of pipe
>   [2/3]: t7001: use "ls-files --format" instead of "cut"
>   [3/3]: t: drop "verbose" helper function

All look good to me, I'd be happy to see this get picked up.

Thanks,
Taylor
