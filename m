Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B701BEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 11:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjFULRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjFULRh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 07:17:37 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563B3184
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:17:36 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-440ad406bc8so975641137.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687346255; x=1689938255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ntn3EwekWomlk4+53PKh2mT8X3YFjGZjgJrj6dw4wo=;
        b=NgwUMbkmkHoTCjoFUXR8GmtHFBIgEw/yxvSubuLMB987sdk0+gvq84m4HfamdBzveM
         nx0R/38Tb1BMzrY+qt0HJ5YaFlkIStstqhT1djrlvxWNEj0jBOwJVfnZnPckKD+wKhq8
         L5KvwY/WhG3KdHYVaHYONigIOXmzuQGTQMXIYYC2xIGjDDm9Uq3sMyDkiZHjSoUYsewH
         PX+tuxfoT2cbx68Lo8Tm4bqsASpQlUbw3FY9ZOrZssVQKG6bl604afYxU0Yy+X1pQC5R
         DbE/H/DuPp2EHkcePWQjI/olbY2OPX3o7v+dUypgyN1VRe8pDwVGvN9svRiETfn3T99l
         cdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687346255; x=1689938255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ntn3EwekWomlk4+53PKh2mT8X3YFjGZjgJrj6dw4wo=;
        b=i1yMHWC+GieYjc6L8q5uD83B3Kimy/DyVY2T/33w8Tc2thINgOr3g4djrFG/TA6bGj
         uWLTRW7t5zn0xeAYEgG3YouvPVAHThvds8d2lvUIlBpYhjBEo2irvzqQNxh9z07zfUG1
         anzEnTdViR2ypFuTSiA/RAlE/C1I5BIJ/r8+pabYoK/gEzuIgNZPZZvLk8K53ycNDa+N
         gqicaxDg1Qy8SS2XTq7Zp5K2+pqyYkn+uJCBqdA4ODmsagjkxxbk6RrgwKSdL3/4z066
         3VOoPLxB7EMjbMesk0FdDflPWaCQkn5rIWnAttmW5PPximF4A99lvt5HTrOuR/wuYBq2
         /VEQ==
X-Gm-Message-State: AC+VfDyxA0ky1XzN5D0c/iMkxWj9z9LSAzKdS7+7ta0kQQnXenank9oq
        zGt0AZTWQdHoOesZfy0vMu+dEQ==
X-Google-Smtp-Source: ACHHUZ4VKMtCRsQ0Mn2B2n+m3PHwg3KzYFAakFuxb2yFAcoFDSw6dCeeDibmAYfqvHQibKb1D7SY2w==
X-Received: by 2002:a67:e314:0:b0:439:3158:77f6 with SMTP id j20-20020a67e314000000b00439315877f6mr3850907vsf.8.1687346255461;
        Wed, 21 Jun 2023 04:17:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e71-20020a25d34a000000b00b8f6ec5a955sm879856ybf.49.2023.06.21.04.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:17:34 -0700 (PDT)
Date:   Wed, 21 Jun 2023 07:17:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 6/9] repack: add `--filter=<filter-spec>` option
Message-ID: <ZJLcS78DDOjn6MzP@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-7-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614192541.1599256-7-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2023 at 09:25:38PM +0200, Christian Couder wrote:
> ---
>  Documentation/git-repack.txt |  5 +++
>  builtin/repack.c             | 75 ++++++++++++++++++++++++++++++++++--
>  t/t7700-repack.sh            | 16 ++++++++
>  3 files changed, 93 insertions(+), 3 deletions(-)

Having read through the implementation in the repack builtin, I am
almost certain that my suggestion earlier in the thread to implement
this in terms of 'git pack-objects --filter' and 'git pack-objects
--stdin-packs' would work.

> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index 4017157949..aa29c7e648 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -143,6 +143,11 @@ depth is 4095.
>  	a larger and slower repository; see the discussion in
>  	`pack.packSizeLimit`.
>
> +--filter=<filter-spec>::
> +	Remove objects matching the filter specification from the
> +	resulting packfile and put them into a separate packfile. See
> +	linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
> +

This documentation leaves me with a handful of questions about how it
interacts with other options. Here are some:

  - What happens when you pass it with "-d"? Does it delete objects that
    didn't match the filter? Leave them alone? If the latter, should
    this combination be declared invalid instead of silently ignoring
    the user's request to delete redundant packs?

  - What happens with --max-pack-size? Does the filtered pack get split
    into multiple packs (as I think we would expect from such a
    combination)?

  - What about with `--cruft`? Does it split the cruft pack into two
    based on whether or not the unreachable object(s) matched or didn't
    match the filter?

  - What happens when passed with "--geometric"? I don't think there is
    a sensible interpretation (at least, I can't think of what it would
    mean to do "--filter=<spec> --geometric=<factor>" off the top of my
    head).

  - What about with "--write-bitmap-index"? Do we write one bitmap
    index? Two? If the latter, do we combine the packs into a MIDX
    before writing the bitmap? Should we?

I think it may be worth spelling out answers to some of these questions
in the documentation, and codifying those answers in the form of tests.

This makes me wonder whether or not this option should belong in repack
at all, or whether there should be some new special-purpose builtin that
is designed to split existing pack(s) based on whether or not they meet
some filter criteria.

Thanks,
Taylor
